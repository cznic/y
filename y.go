// Copyright 2014 The y Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package y

import (
	"bytes"
	"container/heap"
	"fmt"
	"go/ast"
	"go/parser"
	"go/scanner"
	"go/token"
	"io"
	"sort"
	"strconv"
	"strings"

	"github.com/cznic/mathutil"
	yparser "github.com/cznic/parser/yacc"
	yscanner "github.com/cznic/scanner/yacc"
	"github.com/cznic/strutil"
)

const (
	assocNotSpecified = iota
	assocLeft
	assocRight
	assocNone
)

const (
	intBits  = mathutil.IntBits
	bitShift = intBits>>6 + 5
	bitMask  = intBits - 1
)

var (
	assocStr = map[int]string{
		assocLeft:  "%left",
		assocRight: "%right",
		assocNone:  "%nonassoc",
	}
	empty     = "ε"
	isTesting bool
)

type action struct {
	kind int // 'a': accept, 'g': goto, 'r': reduce, 's': shift
	arg  int // a: N/A, r: rule#, g, s: state#
}

func newReduction(arg int) action {
	if arg == 0 {
		return action{'a', 0}
	}

	return action{'r', arg}
}

func (a action) String() string {
	switch a.kind {
	case 'a':
		return "accept"
	case 'g':
		return fmt.Sprintf("goto state %d", a.arg)
	case 'r':
		return fmt.Sprintf("reduce using rule %d", a.arg)
	case 's':
		return fmt.Sprintf("shift, and goto state %d", a.arg)
	default:
		panic("internal error 008")
	}
}

type item uint64 // LR 0 item

func newItem(rule, dot int) item { return item(uint64(rule)<<32 | uint64(dot)) }

func (i item) dot() int { return int(i & (1<<32 - 1)) }

func (i item) dump(y *y) string {
	var buf bytes.Buffer
	rule := y.Rules[i.rule()]
	buf.WriteString(fmt.Sprintf("%3d %s:", i.rule(), rule.Sym.Name))
	dot := i.dot()
	for _, v := range rule.Components[:dot] {
		buf.WriteString(" " + v)
	}
	buf.WriteString(" .")
	for _, v := range rule.Components[dot:] {
		buf.WriteString(" " + v)
	}
	return buf.String()
}

func (i item) next(y *y) *Symbol { return i.sym(y, i.dot()) }
func (i item) rule() int         { return int(i >> 32) }

func (i item) sym(y *y, dot int) *Symbol {
	rule := y.Rules[i.rule()]
	if dot < 0 {
		return rule.Sym
	}

	if dot == len(rule.Components) {
		return nil
	}

	return rule.syms[dot]
}

func (i item) syms(y *y) (r []*Symbol) {
	return y.Rules[i.rule()].syms
}

type item1 struct { // LR 1 item
	item item
	sym  *Symbol
}

func (i item1) dump(y *y) string {
	return fmt.Sprintf("%s, %s", i.item.dump(y), i.sym.Name)
}

type itemSet []item

func (s itemSet) add(i item) (itemSet, bool) { // true: s already has i
	l, ok := s.find(i)
	if ok {
		return s, true
	}

	s = append(s, 0)
	copy(s[l+1:], s[l:])
	s[l] = i
	return s, false
}

func (s itemSet) clone() itemSet { return append(itemSet(nil), s...) }

func (s itemSet) closure(y *y) (r itemSet) { // dragon 4.7, Fig. 4.33
	q, r := s.clone(), s.clone()
	for len(q) != 0 {
		item := q[len(q)-1]
		q = q[:len(q)-1]
		nx := item.next(y)
		if nx == nil || nx.IsTerminal {
			continue
		}

		for _, rule := range nx.rules {
			s := newItem(rule.ruleNum, 0)
			var ok bool
			r, ok = r.add(s)
			if !ok {
				q = append(q, s)
			}
		}
	}
	return r
}

func (s itemSet) find(i item) (m int, _ bool) {
	l, h := 0, len(s)-1
	for l <= h {
		m = (l + h) >> 1
		switch j := s[m]; {
		case i > j:
			l = m + 1
		case i == j:
			return m, true
		default:
			h = m - 1
		}
	}
	return l, false
}

func (s itemSet) goTo(y *y, x *Symbol) (r itemSet) { // dragon 4.7, Example 4.35.
	if n := len(y.isPool); n != 0 {
		r = y.isPool[n-1][:0]
		y.isPool = y.isPool[:n-1]
	}
	for _, item := range s { //TODO cache item->nextSym
		if item.next(y) != x {
			continue
		}

		r = append(r, item+1)
	}
	return r
}

func (s itemSet) mustFind(i item) int {
	if m, ok := s.find(i); ok {
		return m
	}

	panic("internal error 011")
}

func (s itemSet) state(y *y) (int, bool) {
	id := y.id(s)
	n, ok := y.itemSets[id]
	if !ok {
		n = len(y.itemSets)
		y.itemSets[id] = n
		ns := newState(y, s)
		ns.id = n
		y.states = append(y.states, ns)
	}
	return n, ok
}

type itemSet1 map[item1]bool

func (s itemSet1) add(i item1) bool { // true: s already has i
	if i.sym.id == 0 {
		return true
	}

	if _, ok := s[i]; ok {
		return true
	}

	s[i] = true
	return false
}

type state struct {
	actions   map[*Symbol][]action //
	distance  int                  // On path to state 0.
	gotos     map[*Symbol]action   //
	id        int                  // Numeric id of the state.
	kernel    itemSet              //
	lookahead []symSet             // kernel LA.
	parent    *state               // On path to state 0.
	psym      *Symbol              // Label for the edge parent -> state.
	resolved  []string             //TODO non string data.
	sym       *Symbol              // Sym transfering from parent to state.
	trans     map[trans]stateItem  // sym.i -> stateItem
	xitems    itemSet              // {x ∈ closure(kernel) | x.rule -> ε }.
	xla       []symSet             // xitems LA.
}

func newState(y *y, s itemSet) *state {
	return &state{
		actions:   map[*Symbol][]action{},
		gotos:     map[*Symbol]action{},
		kernel:    s,
		lookahead: make([]symSet, len(s)),
		trans:     map[trans]stateItem{},
	}
}

// Symbols required to get from state 0 to s.
func (s *state) syms0(y *y) (r []*Symbol) {
	y.zeroPaths()
	if s.parent == nil {
		return nil
	}

	sym := s.psym
	if sym.IsTerminal {
		return append(s.parent.syms0(y), sym)
	}

	return append(s.parent.syms0(y), sym.minString(nil)...)
}

type stateItem struct {
	state int
	i     int
}

type symSet []int

func (s symSet) add(t symSet, withEmpty bool) (r bool) { // true: s already has all items in t
	r = true
	for x, w := range t {
		if x == 0 && !withEmpty {
			w &^= 1
		}
		if w == 0 {
			continue
		}

		o := s[x]
		if w = o | w; w != o {
			s[x] = w
			r = false
		}
	}
	return r
}

func (s symSet) add1(t int) bool { // true: s already has t
	x, m := t>>bitShift, 1<<uint(t&bitMask)
	w := s[x]
	if w&m != 0 {
		return true
	}
	s[x] = w | m
	return false
}

func (s symSet) addEmpty() { s[0] |= 1 }

func (s symSet) clear() symSet {
	for i := range s {
		s[i] = 0
	}
	return s
}

func (s symSet) clone(y *y) symSet {
	r := y.newSymSet(-1)
	copy(r, s)
	return r
}

func (s symSet) len() (r int) {
	for _, w := range s {
		for bit := 0; bit < intBits && w != 0; bit, w = bit+1, w>>1 {
			if w&1 != 0 {
				r++
			}
		}
	}
	return r
}

func (s symSet) dump(y *y) string {
	var a []string
	for x, w := range s {
		for bit := 0; bit < intBits && w != 0; bit, w = bit+1, w>>1 {
			if w&1 != 0 {
				a = append(a, y.syms[x<<bitShift+bit].Name)
			}
		}
	}
	sort.Strings(a)
	return strings.Join(a, ", ")
}

func (s symSet) has(sym int) bool { return s[sym>>bitShift]&(1<<uint(sym&bitMask)) != 0 }

func (s symSet) hasEmpty() bool { return s[0]&1 != 0 }

func (s symSet) remove(t int) {
	s[t>>bitShift] &^= 1 << uint(t&bitMask)
}

type trans struct {
	item
	*Symbol
}

type typeDecl struct {
	token.Pos
	typeName string
}

type y struct {
	*Parser
	acceptSym      *Symbol
	allocVal       int
	ast            *yparser.AST
	clsCache       map[item]map[item]symSet
	clsQueue       []item1   // Non reentrant item1.closure todo list.
	clsSyms        []*Symbol // Non reentrant item1.closure buffer.
	dummySym       *Symbol
	emptySym       *Symbol
	endSym         *Symbol
	entries        int // Number of used cells in the parse table.
	errSym         *Symbol
	errors         scanner.ErrorList
	firstRule      int
	fset           *token.FileSet
	idBuf          []byte // Non reentrant id() buffer.
	isPool         []itemSet
	itemSets       map[string]int
	noSym          *Symbol
	nonTerminals   map[string]token.Pos
	opts           *Options
	precedence     int
	ssPool         []symSet
	start          string
	states         []*state
	symSetCap      int
	symTypes       map[string]typeDecl
	syms           []*Symbol
	symsUsed       map[string]token.Pos
	synthRule      int
	types          map[string]token.Pos // %union fields
	typesUsed      map[string]token.Pos
	unionPos       token.Pos
	zeroPathsValid bool // States paths to state 0 determined.
}

func newY(fset *token.FileSet, ast *yparser.AST, opts *Options) *y {
	r := &y{
		Parser:       newParser(),
		acceptSym:    &Symbol{Name: "$accept"},
		ast:          ast,
		clsCache:     map[item]map[item]symSet{},
		dummySym:     &Symbol{Name: "#", IsTerminal: true},
		emptySym:     &Symbol{Name: empty, IsTerminal: true},
		endSym:       &Symbol{Name: "$end", IsTerminal: true, precedence: -1, Value: -1},
		errSym:       &Symbol{Name: "error", IsTerminal: true},
		fset:         fset,
		itemSets:     map[string]int{},
		noSym:        &Symbol{Name: "$default", Value: -1},
		nonTerminals: map[string]token.Pos{},
		opts:         opts,
		types:        map[string]token.Pos{},
		typesUsed:    map[string]token.Pos{},
		idBuf:        make([]byte, 1024),
	}
	r.symsUsed = map[string]token.Pos{r.errSym.Name: 0, r.noSym.Name: 0}
	r.errSym.Value = r.allocValue()
	r.Syms = map[string]*Symbol{
		r.acceptSym.Name: r.acceptSym,
		r.dummySym.Name:  r.dummySym,
		r.emptySym.Name:  r.emptySym,
		r.endSym.Name:    r.endSym,
		r.errSym.Name:    r.errSym,
		r.noSym.Name:     r.noSym,
	}
	return r
}

func processAST(fset *token.FileSet, ast *yparser.AST, opts *Options) (*y, error) {
	var err error
	if opts, err = opts.boot(fset); err != nil {
		return nil, err
	}

	y := newY(fset, ast, opts)
	if err := y.defs(); err != nil {
		return nil, err
	}

	y.Tail = ast.Tail
	if err := y.rules0(); err != nil {
		return nil, err
	}

	m := map[int]*Symbol{}
	for nm, sym := range y.Syms {
		if nm == "" || nm == "#" || nm[0] == '$' && nm[1] != '@' && sym != y.noSym { // internal symbols
			continue
		}

		if sym.Value < 0 {
			sym.Value = y.allocValue()
		}

		ex, ok := m[sym.Value]
		if ok {
			y.err(sym.pos, "symbol %s has the same value (%d) as symbol %s at %s.", sym, sym.Value, ex, y.pos(ex.pos))
		}

		m[sym.Value] = sym
	}
	if err := y.error(); err != nil {
		return nil, y.error()
	}

	y.follows()
	y.states0()
	y.lookaheads()
	y.reductions()
	y.conflicts()
	if w := opts.Report; w != nil {
		y.report(w)
	}
	y.Table = make([][]Action, len(y.states))
	for i, state := range y.states {
		a := make([]Action, 0, len(state.actions)+len(state.gotos))
		for sym, acts := range state.actions {
			act := acts[0]
			switch act.kind {
			case 'a':
				a = append(a, Action{y.endSym, 0})
			case 's':
				a = append(a, Action{sym, act.arg})
			case 'r':
				a = append(a, Action{sym, -act.arg})
			default:
				panic("internal error 014")
			}
		}
		for sym, act := range state.gotos {
			a = append(a, Action{sym, act.arg})
		}
		y.Table[i] = a
	}
	return y, y.xerrors()
}

func (y *y) addRule(r *Rule) *Rule {
	r.Sym.rules = append(r.Sym.rules, r)
	r.ruleNum = len(y.Rules)
	y.Rules = append(y.Rules, r)
	return r
}

func (y *y) allocValue() (n int) {
	switch n = y.allocVal; {
	case n == 0:
		n = 0xe000 // Private Use Area.
	case n == 0xf8ff:
		n = 0xf0000 // Supplemental Private Use Area-A.
	case n == 0xffffd:
		n = 0x100000 // Supplemental Private Use Area-B.
	case n == 0x10fffd:
		panic("internal error 012")
	default:
		n++
	}
	y.allocVal = n
	return n
}

func (y *y) closure(i item) (r map[item]symSet) { // Result symSets must not be mutated.
	if r, ok := y.clsCache[i]; ok {
		return r
	}

	r = y.closure0(map[item]symSet{i: y.newSymSet(y.dummySym.id)}, append(y.clsQueue[:0], item1{i, y.dummySym}))
	y.clsCache[i] = r
	return r
}

func (y *y) closure0(j map[item]symSet, q []item1) map[item]symSet { // dragon 4.7, Fig. 4.38; not reentrant.
	ySyms := y.clsSyms
	for len(q) != 0 {
		i := q[len(q)-1]
		q = q[:len(q)-1]
		bb := i.item.syms(y)[i.item.dot():]
		if len(bb) == 0 {
			continue
		}

		rules := bb[0].rules
		ySyms = append(ySyms[:0], bb[1:]...)
		ySyms = append(ySyms, i.sym)
		symSet := y.first(ySyms)
		for x, w := range symSet {
			for bit := 0; bit < intBits && w != 0; bit, w = bit+1, w>>1 {
				if w&1 == 0 {
					continue
				}

				for _, p := range rules {
					nii := newItem(p.ruleNum, 0)
					ni := item1{nii, y.syms[x<<bitShift+bit]}
					switch v, ok := j[nii]; {
					case !ok:
						j[nii] = y.newSymSet(ni.sym.id)
						q = append(q, ni)
					default:
						if v.add1(ni.sym.id) {
							break
						}

						j[nii] = v
						q = append(q, ni)
					}
				}
			}
		}
		y.ssPool = append(y.ssPool, symSet.clear())
	}
	y.clsSyms = ySyms
	y.clsQueue = q
	return j
}

func (y *y) conflicts() error {
	for si, state := range y.states {
		for sym, acts := range state.actions {
			if len(acts) < 2 {
				continue
			}

			delete(state.actions, sym)
			var s, r []action
			for _, act := range acts {
				switch act.kind {
				case 's':
					s = append(s, act)
				case 'r':
					r = append(r, act)
				default:
					panic("internal error 006")
				}
			}
			if len(s) > 1 {
				panic("internal error 007")
			}

			var in, out [][2]action
			if len(s) != 0 {
				s := s[0]
				for _, r := range r {
					in = append(in, [2]action{s, r})
				}
			}
			for i, r1 := range r {
				for _, r2 := range r[i+1:] {
					in = append(in, [2]action{r1, r2})
				}
			}
			for _, conflict := range in {
				switch resolved, asShift := y.resolve(state, si, sym, conflict); {
				case !resolved:
					out = append(out, conflict)
				case asShift:
					if conflict[0].kind != 's' {
						break
					}

					r := conflict[1].arg
					dot := len(y.Rules[r].Components)
					item := newItem(r, dot)
					switch dot {
					case 0:
						state.xla[state.xitems.mustFind(item)].remove(sym.id)
					default:
						state.lookahead[state.kernel.mustFind(item)].remove(sym.id)
					}
				}
			}
			ret := map[action]bool{}
			for _, conflict := range out {
				ret[conflict[0]], ret[conflict[1]] = true, true
				if conflict[0].kind == 's' {
					y.ConflictsSR++
					continue
				}

				y.ConflictsRR++
			}
			var sa, ra []action
			for action := range ret {
				if action.kind == 's' {
					sa = append(sa, action)
					continue
				}

				ra = append(ra, action)
			}
			state.actions[sym] = append(state.actions[sym], sa...)
			state.actions[sym] = append(state.actions[sym], ra...)
		}
		sort.Strings(state.resolved)
	}
	if !y.opts.AllowConflicts {
		if y.ConflictsSR != 0 {
			y.err(0, "conflicts: %d shift/reduce", y.ConflictsSR)
		}
		if y.ConflictsRR != 0 {
			y.err(0, "conflicts: %d reduce/reduce", y.ConflictsRR)
		}
	}
	if y.opts.noDefault {
		return y.error()
	}

	for si, state := range y.states {
		var valid bool
		var la symSet
		max := 0
		for i, item := range state.kernel {
			if item.next(y) != nil || si == 1 && item == 1 {
				continue
			}

			if n := state.lookahead[i].len(); !valid || n < max {
				max = n
				la = state.lookahead[i]
				valid = true
			}
		}
		for i := range state.xitems {
			if n := state.xla[i].len(); !valid || n < max {
				max = n
				la = state.xla[i]
				valid = true
			}
		}

		if !valid {
			continue
		}

		// Collapse la reductions.
		redn := -1
		for sym, actions := range state.actions {
			action := actions[0]
			if action.kind != 'r' {
				continue
			}

			if redn < 0 && la.has(sym.id) {
				redn = action.arg
			}

			switch actions = actions[1:]; len(actions) {
			case 0:
				delete(state.actions, sym)
			default:
				state.actions[sym] = actions
			}

		}
		state.actions[y.noSym] = []action{action{'r', redn}}
	}
	return y.error()
}

func (y *y) defs() error {
	types := map[string]typeDecl{}
	var buf bytes.Buffer
	defer func() {
		y.Prologue = buf.String()
		y.symTypes = types
	}()

	for _, def := range y.ast.Defs {
		switch def.Rword {
		case yparser.Copy:
			buf.WriteString(def.Tag)
		case yparser.ErrVerbose:
			y.ErrorVerbose = true
		case yparser.Start:
			nm := def.Tag
			y.start = nm
			y.nonTerminals[nm] = def.Pos
			y.useSym(nm, def.Pos)
		case yparser.Left, yparser.Right, yparser.Nonassoc:
			y.precedence++
			fallthrough
		case yparser.Token:
			typ := def.Tag
			y.useType(def.Pos, typ)
			assoc := assocNotSpecified
			switch def.Rword {
			case yparser.Left:
				assoc = assocLeft
			case yparser.Right:
				assoc = assocRight
			case yparser.Nonassoc:
				assoc = assocNone
			}
			for _, nmno := range def.Nlist {
				var name string
				num := nmno.Number

				switch x := nmno.Identifier.(type) {
				case int:
					name = fmt.Sprintf("%q", x)
					if num < 0 {
						num = x
					}
				case string:
					name = x
				default:
					panic("internal error 002")
				}

				t := &Symbol{
					associativity: assoc,
					IsTerminal:    true,
					Name:          name,
					pos:           nmno.Pos,
					precedence:    -1,
					Type:          typ,
					Value:         num,
				}

				switch def.Rword {
				case yparser.Left, yparser.Right, yparser.Nonassoc:
					t.precedence = y.precedence
				}

				ex, ok := y.Syms[name]
				if !ok {
					if t.Value < 0 {
						t.Value = y.allocValue()
					}
					y.Syms[name] = t
					continue
				}

				// Merge the declarations, if possible.
				if n := t.associativity; n != assocNotSpecified {
					switch o := ex.associativity; {
					case o == assocNotSpecified:
						ex.associativity = n
					case n != o:
						y.err(
							t.pos,
							"%s: conflict with previous associativity declaration at %v",
							name, y.pos(ex.pos),
						)
					}
				}

				if n := t.precedence; n >= 0 {
					switch o := ex.precedence; {
					case o < 0:
						ex.precedence = n
					case n != o:
						y.err(
							t.pos,
							"%s: conflict with previous precedence declaration at %v",
							name, y.pos(ex.pos),
						)
					}
				}

				if n := t.Type; n != "" {
					switch o := ex.Type; {
					case o == "":
						ex.Type = n
					case n != o:
						y.err(
							t.pos,
							"%s: conflict with previous type declaration at %v",
							name, y.pos(ex.pos),
						)
					}
				}

				if n := t.Value; n >= 0 {
					switch o := ex.Value; {
					case o < 0:
						ex.Value = n
					case n != o:
						y.err(
							t.pos,
							"%s: conflict with previous value declaration at %v",
							name, y.pos(ex.pos),
						)
					}
				}
			}
		case yparser.Type:
			typ := def.Tag
			y.useType(def.Pos, typ)
			for _, nmno := range def.Nlist {
				nm := nmno.Identifier.(string)
				if ex, ok := types[nm]; ok {
					y.err(nmno.Pos, "%%type: previous declaration at %v", y.pos(ex.Pos))
					break
				}

				types[nm] = typeDecl{nmno.Pos, typ}
				y.useSym(nm, def.Pos)
			}
		case yparser.Union:
			if ex := y.unionPos; ex != 0 {
				y.err(def.Pos, "duplicate %%union: previous at %v", y.pos(ex))
				break
			}

			y.unionPos = def.Pos
			src := def.Tag
			for len(src) != 0 && src[0] != '{' {
				src = src[1:]
			}
			if len(src) != 0 {
				src = src[1:]
			}
			for len(src) != 0 && (src[0] == '\n' || src[0] == '\r') {
				src = src[1:]
			}
			src = fmt.Sprintf("struct {\n\tyys    int\n%s{}", src)
			expr, err := parser.ParseExpr(src)
			if err != nil {
				y.err(def.Pos, "invalid %%union:\n%s\n%v", src, err)
				break
			}

			y.Union, y.UnionSrc = expr.(*ast.CompositeLit).Type.(*ast.StructType), src[:len(src)-2]
			for _, fields := range y.Union.Fields.List[1:] {
				for _, nm := range fields.Names {
					switch ex, ok := y.types[nm.Name]; {
					case !ok:
						y.types[nm.Name] = def.Pos
					default:
						y.err(def.Pos, "union field %s lalready declared: %s", nm, y.pos(ex))
					}
				}
			}
		default:
			panic("internal error 001")
		}
	}
	return y.error()
}

func (y *y) err(pos token.Pos, format string, arg ...interface{}) error {
	return y.errp(y.pos(pos), format, arg...)
}

func (y *y) errp(pos token.Position, format string, arg ...interface{}) error {
	y.errors.Add(pos, fmt.Sprintf(format, arg...))
	return y.errors[len(y.errors)-1]
}

func (y *y) error() error {
	if len(y.errors) == 0 {
		return nil
	}

	y.errors.Sort()
	return y.errors.Err()
}

func (y *y) first(x []*Symbol) (r symSet) { // dragon, 4.4
	r = y.newSymSet(-1)
	for _, sym := range x {
		f1 := sym.first(y)
		r.add(f1, false)
		if !f1.hasEmpty() {
			return r
		}
	}

	r.addEmpty()
	return r
}

func (y *y) follows() { // dragon, 4.4
	y.acceptSym.follow = y.newSymSet(y.endSym.id) // 1.
	for {
		changed := false

		for _, sym := range y.Syms {
			if sym.IsTerminal {
				continue
			}

			for _, rule := range sym.rules {
				a := rule.Sym
				if len(a.follow) == 0 {
					a.follow = y.newSymSet(-1)
				}
				syms := rule.syms
				n := len(syms)
				for dot, b := range syms {
					if len(b.follow) == 0 {
						b.follow = y.newSymSet(-1)
					}
					f3 := false
					if dot < n-1 { // 2.
						beta := syms[dot+1]
						f := beta.first(y)
						if !b.follow.add(f, false) {
							changed = true
						}
						f3 = f.hasEmpty()
					}
					if dot == n-1 || f3 { // 3.
						if !b.follow.add(a.follow, true) {
							changed = true
						}
					}
				}
			}
		}

		if !changed {
			break
		}
	}
}

func (y *y) id(s itemSet) string { // Not reentrant.
	b := y.idBuf[:0] //TODO try compute size in advance using log2
	for _, item := range s {
		r, d := item.rule(), item.dot()
		if r != 0 && d == 0 {
			continue
		}

		for r != 0 {
			b = append(b, byte(r)&0x7f)
			r >>= 7
		}
		b = append(b, 0x80)
		for d != 0 {
			b = append(b, byte(d)&0x7f)
			d >>= 7
		}
		b = append(b, 0x81)
	}
	y.idBuf = b
	return string(b)
}

func (y *y) lookaheads() {
	di := y.dummySym.id
	dx, dm := di>>bitShift, 1<<uint(di&bitMask) //TODO static const
	y.states[0].lookahead[0] = y.newSymSet(y.endSym.id)
	q := make([]stateItem, 0, len(y.states))
	m := make(map[stateItem]bool, len(y.states))
	for s, state := range y.states {
		for i := range state.kernel {
			si := stateItem{s, i}
			q = append(q, si)
			m[si] = true
		}
	}
	for len(q) != 0 {
		j := q[len(q)-1]
		q = q[:len(q)-1]
		delete(m, j)
		state, i := y.states[j.state], j.i
		item := state.kernel[i]
		if item.dot() == 0 && item.rule() != 0 {
			continue
		}

		for item, syms := range y.closure(item) {
			sym := item.next(y)
			if sym == nil {
				continue
			}

			j := state.trans[trans{item, sym}]
			gs := y.states[j.state]
			v := gs.lookahead[j.i]
			if v == nil {
				v = y.newSymSet(-1)
			}

			if syms[dx]&dm != 0 {
				syms = syms.clone(y) // Must not mutate.
				syms[dx] &^= dm
				syms.add(state.lookahead[i], false)
			}
			if !v.add(syms, false) && !m[j] {
				m[j] = true
				q = append(q, j)
			}
			gs.lookahead[j.i] = v
		}
	}
}

func (y *y) newSymSet(sym int) symSet {
	var r symSet
	switch n := len(y.ssPool); {
	case n != 0:
		r = y.ssPool[n-1]
		y.ssPool = y.ssPool[:n-1]
	default:
		r = make(symSet, y.symSetCap)
	}
	if sym >= 0 {
		r[sym>>bitShift] = 1 << uint(sym&bitMask)
	}
	return r
}

func (y *y) pos(po token.Pos) token.Position { return y.fset.Position(po) }

func (y *y) reductions() {
	defaultLA := y.newSymSet(y.noSym.id)
	for _, state := range y.states {
		for i, item := range state.kernel {
			if item.next(y) != nil {
				continue
			}

			// Item reduces a rule.
			la := state.lookahead[i]
			if len(la) == 0 {
				la = defaultLA
			}
			for x, w := range la {
				for bit := 0; bit < intBits && w != 0; bit, w = bit+1, w>>1 {
					if w&1 == 0 {
						continue
					}

					sym := y.syms[x<<bitShift+bit]
					state.actions[sym] = append(state.actions[sym], newReduction(item.rule()))
					y.entries++
				}
			}
		}

		if len(state.xitems) == 0 {
			continue
		}

		cls := state.kernel.closure(y)
		las := make([]symSet, len(cls))
		m := map[*Symbol][]int{}
		for i, item := range cls {
			rsym := item.sym(y, -1)
			m[rsym] = append(m[rsym], i)
		}
		for i, item := range state.kernel {
			j := cls.mustFind(item)
			las[j] = state.lookahead[i].clone(y)
		}
		for {
			changed := false
			for i, item := range cls {
				sym := item.next(y)
				if sym == nil || sym.IsTerminal {
					continue
				}

				targ, ok := m[sym]
				if !ok {
					continue
				}

				var la symSet
				switch nsym := (item + 1).next(y); {
				case nsym == nil:
					la = las[i]
				default:
					la = y.first(item.syms(y)[item.dot()+1:])
					if la.hasEmpty() {
						la.add(las[i], false)
					}
				}

				for _, i := range targ {
					v := las[i]
					if len(v) == 0 {
						v = y.newSymSet(-1)
					}

					if !v.add(la, false) {
						las[i] = v
						changed = true
					}
				}
			}

			if !changed {
				break
			}
		}
		for i, item := range state.xitems {
			j := cls.mustFind(item)
			state.xla[i] = las[j]
			las[j] = nil
		}
		for _, v := range las {
			if len(v) != 0 {
				y.ssPool = append(y.ssPool, v.clear())
			}
		}
		for i, item := range state.xitems {
			for x, w := range state.xla[i] {
				for bit := 0; bit < intBits && w != 0; bit, w = bit+1, w>>1 {
					if w&1 == 0 {
						continue
					}

					sym := y.syms[x<<bitShift+bit]
					state.actions[sym] = append(state.actions[sym], newReduction(item.rule()))
					y.entries++
				}
			}
		}
	}
}

func (y *y) report(w io.Writer) {
	f := strutil.IndentFormatter(w, "  ")
	if y.opts.debugSyms {
		var a []string
		max := 0
		for _, v := range y.syms {
			max = mathutil.Max(max, len(v.Name))
		}
		for _, v := range y.syms {
			a = append(a, fmt.Sprintf("%[2]*[1]s val %6[3]d, id %3[5]d, type %[4]q",
				v.Name, -max-1, v.Value, v.Type, v.id),
			)
		}
		sort.Strings(a)
		for _, v := range a {
			f.Format("%s\n", v)
		}
	}
	for si, state := range y.states {
		f.Format("state %d //", si)

		for _, s := range state.syms0(y) {
			switch {
			case s == nil:
				f.Format(" <?>")
			case !s.IsTerminal:
				f.Format(" <%s>", s.Name)
			default:
				f.Format(" %s", s.Name)
			}
		}
		f.Format("%i\n\n")

		switch {
		case y.opts.Closures:
			for _, item := range state.kernel.closure(y) {
				rule := y.Rules[item.rule()]
				f.Format("%v", item.dump(y))
				if y.opts.LA || item.next(y) == nil {
					switch i, ok := state.kernel.find(item); {
					case ok:
						f.Format("  [%s]", state.lookahead[i].dump(y))
					default:
						if i, ok := state.xitems.find(item); ok {
							f.Format("  [%s]", state.xla[i].dump(y))
						}
					}
				}
				if as := assocStr[rule.associativity]; as != "" || rule.precedence >= 0 {
					f.Format("  // assoc %s, prec %d", as, rule.precedence)
				}
				f.Format("\n")
			}
		default:
			for i, item := range state.kernel {
				rule := y.Rules[item.rule()]
				f.Format("%v", item.dump(y))
				if item.dot() == len(rule.Components) {
					f.Format("  [%s]", state.lookahead[i].dump(y))
				}
				if as := assocStr[rule.associativity]; as != "" || rule.precedence >= 0 {
					f.Format("  // assoc %s, prec %d", as, rule.precedence)
				}
				f.Format("\n")
			}
			for i, item := range state.xitems {
				rule := y.Rules[item.rule()]
				f.Format("%v  [%s]", item.dump(y), state.xla[i].dump(y))
				if as := assocStr[rule.associativity]; as != "" || rule.precedence >= 0 {
					f.Format(" // assoc %s, prec %d", as, rule.precedence)
				}
				f.Format("\n")
			}
		}

		f.Format("%i\n")
		a := []string{}
		var w int
		for sym := range state.actions {
			w = mathutil.Max(w, len(sym.Name))
			a = append(a, sym.Name)
		}
		sort.Strings(a)
		type conflict struct {
			sym  *Symbol
			acts []action
		}
		var conflicts []conflict
		for _, nm := range a {
			sym := y.Syms[nm]
			acts := state.actions[sym]
			act := acts[0]
			f.Format("%-*s  %v", w, nm, act)
			if act.kind == 'r' {
				f.Format(" (%s)", y.Rules[act.arg].Sym.Name)
			}
			if len(acts) > 1 {
				conflicts = append(conflicts, conflict{sym, acts})
			}
			f.Format("\n")
		}
		a = a[:0]
		w = 0
		for sym := range state.gotos {
			w = mathutil.Max(w, len(sym.Name))
			a = append(a, sym.Name)
		}
		sort.Strings(a)
		for i, nm := range a {
			if i == 0 {
				f.Format("\n")
			}
			f.Format("%-*s  %v\n", w, nm, state.gotos[y.Syms[nm]])
		}
		for i, conflict := range conflicts {
			if i == 0 {
				if len(state.gotos) != 0 {
					f.Format("\n")
				}
			}
			sym := conflict.sym
			nm := sym.Name
			f.Format("conflict on %v", nm)
			for _, act := range conflict.acts {
				f.Format(", %s", act.String())
			}
			if as := assocStr[sym.associativity]; as != "" || sym.precedence >= 0 {
				f.Format(" // %v: assoc %s, prec %d", nm, assocStr[sym.associativity], sym.precedence)
			}
			f.Format("\n")
		}
		if len(state.resolved) != 0 {
			f.Format("\n")
		}
		for _, v := range state.resolved {
			f.Format("%s\n", v)
		}
		f.Format("%u%u\n")
	}
}

func (y *y) resolve(s *state, si int, sym *Symbol, conflict [2]action) (resolved, asShift bool) {
	switch conflict[0].kind {
	case 's':
		rrule := y.Rules[conflict[1].arg]
		sprec, rprec := sym.precedence, rrule.precedence
		if sprec < 0 || rprec < 0 {
			break
		}

		var explain string
		defer func() {
			if y.opts.Resolved {
				s.resolved = append(s.resolved, explain)
			}
		}()

		switch {
		case sprec > rprec:
			explain = fmt.Sprintf(
				"Conflict between rule %d and token %s resolved as shift (%s < %s).",
				rrule.ruleNum, sym, rrule.precSym, sym,
			)
			s.actions[sym] = append(s.actions[sym], conflict[0])
			return true, true
		case sprec < rprec:
			explain = fmt.Sprintf(
				"Conflict between rule %d and token %s resolved as reduce (%s < %s).",
				rrule.ruleNum, sym, sym, rrule.precSym,
			)
			s.actions[sym] = append(s.actions[sym], conflict[1])
			return true, false
		case sym.associativity == assocLeft:
			explain = fmt.Sprintf(
				"Conflict between rule %d and token %s resolved as reduce (%%left %s).",
				rrule.ruleNum, sym, sym,
			)
			s.actions[sym] = append(s.actions[sym], conflict[1])
			return true, false
		case sym.associativity == assocRight:
			explain = fmt.Sprintf(
				"Conflict between rule %d and token %s resolved as shift (%%right %s).",
				rrule.ruleNum, sym, sym,
			)
			s.actions[sym] = append(s.actions[sym], conflict[0])
			return true, true
		case sym.associativity == assocNone:
			y.err(sym.pos, "%nonassoc symbol %s conflict in state %d", sym, si)
		default:
			panic("internal error 010")
		}
	case 'r':
		// nop
	default:
		panic("internal error 009")
	}
	return false, false
}

func (y *y) rules0() error {
	y.addRule(&Rule{
		Components: []string{""},
		precedence: -1,
		Sym:        y.acceptSym,
	})

	for _, prule := range y.ast.Rules {
		if prule.Name == "error" {
			y.err(prule.Pos, "a rule cannot use the reserved name error")
			continue
		}

		ruleSym := y.Syms[prule.Name]
		if ruleSym == nil {
			ruleSym = &Symbol{Name: prule.Name, pos: prule.Pos, Value: -1}
			y.Syms[prule.Name] = ruleSym
		}
		ruleSym.Type = y.symTypes[ruleSym.Name].typeName
		r := &Rule{
			MaxParentDlr: -1,
			Sym:          ruleSym,
			pos:          prule.Pos,
			precedence:   -1,
		}

		// Make $n have index n.
		pcomponents := append([]interface{}{nil}, prule.Body...)

		if pr := prule.Prec; pr != nil {
			var nm string
			switch x := pr.Identifier.(type) {
			case int:
				nm = fmt.Sprintf("%q", x)
			case string:
				nm = x
			default:
				panic("internal error 003")
			}

			s, ok := y.Syms[nm]
			if !ok {
				y.err(pr.Pos, "%%prec: undefined symbol %s", nm)
				continue
			}

			if !s.IsTerminal {
				y.err(pr.Pos, "must be a terminal: %s", nm)
				continue
			}

			r.associativity, r.precedence = s.associativity, s.precedence
			r.precSym = s
			if len(pr.Act) != 0 {
				pcomponents = append(pcomponents, pr.Act)
			}
		}

		var finalAct []*yparser.Act
		var components []string
		for i, item := range pcomponents {
			switch x := item.(type) {
			case nil:
				// no $0 component
			case string:
				y.useSym(x, prule.Pos)
				components = append(components, x)
				sym := y.Syms[x]
				if sym == nil || sym.Type != "" {
					break
				}

				sym.Type = y.symTypes[x].typeName
			case []*yparser.Act:
				for _, v := range x {
					n := v.Num
					tag := v.Tag
					if v.Tok == yscanner.DLR_DLR && ruleSym.Type == "" {
						y.err(v.Pos, "$$ of %s has no declared type", ruleSym)
					}
					if v.Tok == yscanner.DLR_NUM || v.Tok == yscanner.DLR_TAG_NUM {
						if n < 1 || n >= len(pcomponents) {
							y.err(v.Pos, "undefined: $%d", n)
						}

						if n >= i {
							y.err(v.Pos, "not accessible here: $%d", n)
						}
					}
					if v.Tok == yscanner.DLR_TAG_DLR || v.Tok == yscanner.DLR_TAG_NUM {
						switch _, ok := y.types[tag]; {
						case ok:
							y.useType(v.Pos, tag)
						default:
							y.err(v.Pos, "undefined type %s", tag)
						}
					}
				}

				if i == len(pcomponents)-1 {
					finalAct = x
					break
				}

				y.synthRule++
				s := &Symbol{Name: fmt.Sprintf("$@%d", y.synthRule), Value: -1}
				y.Syms[s.Name] = s
				y.addRule(&Rule{
					Action:       x,
					MaxParentDlr: i - 1,
					Parent:       r,
					Sym:          s,
					maxDlr:       -1,
					precedence:   -1,
				})
				components = append(components, s.Name)
			case int: // literal
				nm := fmt.Sprintf("%q", x)
				components = append(components, nm)
				pcomponents[i] = nm
				s := y.Syms[nm]
				if s != nil {
					break
				}

				s = &Symbol{Name: nm, IsTerminal: true, precedence: -1, Value: x}
				y.Syms[nm] = s
			default:
				panic("internal error 004")
			}
		}
		r.Action = finalAct
		r.maxDlr = len(pcomponents) - 1
		r.Components = components
		y.addRule(r)
		if r.Sym.Type != "" && len(r.Action) == 0 && len(components) == 0 {
			y.err(prule.Pos, "empty rule for typed nonterminal, and no action")
		}

		if y.firstRule == 0 {
			y.firstRule = r.ruleNum
		}
	}

	if y.start == "" {
		y.start = y.Rules[y.firstRule].Sym.Name
	}
	y.useSym(y.start, y.ast.Rules[0].Pos)
	y.Rules[0].Components[0] = y.start

	for _, rule := range y.Rules {
		if rule.precedence >= 0 {
			continue
		}

		components := rule.Components
		if len(components) == 0 {
			rule.Sym.derivesE = true
			continue
		}

		for i := len(components) - 1; i >= 0; i-- {
			if sym := y.Syms[components[i]]; sym.IsTerminal {
				rule.associativity, rule.precedence = sym.associativity, sym.precedence
				rule.precSym = sym
				break
			}
		}
	}

	for nm, pos := range y.typesUsed {
		if _, ok := y.types[nm]; !ok {
			y.err(pos, "undefined type %s", nm)
		}
	}

	//TODO for nm, pos := range y.types {
	//TODO 	if _, ok := y.typesUsed[nm]; !ok {
	//TODO 		y.err(pos, "type declared and not used: %s", nm)
	//TODO 	}
	//TODO }

	for nm, pos := range y.symsUsed {
		if _, ok := y.Syms[nm]; !ok {
			y.err(pos, "undefined symbol %s", nm)
		}
	}

	y.syms = make([]*Symbol, len(y.Syms))
	y.syms[0] = y.emptySym
	x := 1
	a := make([]string, 0, len(y.Syms))
	for nm := range y.Syms {
		a = append(a, nm)
	}
	sort.Strings(a)
	for _, nm := range a {
		s := y.Syms[nm]
		if s != y.emptySym {
			s.id = x
			y.syms[x] = s
			x++
		}
		if nm[0] == '$' || s.IsTerminal {
			continue
		}

		if _, ok := y.symsUsed[nm]; !ok {
			y.err(s.pos, "non terminal declared and not used: %s", nm)
		}
	}
	y.symSetCap = (len(y.syms) + intBits - 1) / intBits
	for nm := range y.nonTerminals {
		nt, ok := y.Syms[nm]
		if !ok {
			panic("internal error 005")
		}

		if nt.IsTerminal {
			y.err(nt.pos, "expected %s to be a non terminal", nt)
		}

	}

	for _, rule := range y.Rules {
		rule.syms = make([]*Symbol, len(rule.Components))
		for i, v := range rule.Components {
			rule.syms[i] = y.Syms[v]
		}
		if e := rule.Sym.Type; e != "" && len(rule.Action) == 0 && len(rule.Components) != 0 {
			if g := y.Syms[rule.Components[0]].Type; g != e {
				y.err(rule.pos, "type clash on default action: <%s> != <%s>", e, g)
			}
		}
	}
	return y.error()
}

func (y *y) states0() {
	itemSet{0}.state(y)
	syms := y.newSymSet(-1)
	q := []int{0}
	for len(q) != 0 {
		s := q[len(q)-1]
		state := y.states[s]
		q = q[:len(q)-1]
		cls := state.kernel.closure(y)
		syms.clear()
		for _, item := range cls {
			sym := item.next(y)
			if sym == nil { // reduction
				if len(item.syms(y)) == 0 { // rule -> ε
					state.xitems = append(state.xitems, item)
				}
				continue
			}

			goTo := cls.goTo(y, sym)
			n, ok := goTo.state(y)
			if !ok {
				q = append(q, n)
			} else {
				y.isPool = append(y.isPool, goTo)
			}

			state.trans[trans{item, sym}] = stateItem{n, goTo.mustFind(item + 1)}
			if syms.add1(sym.id) {
				continue
			}

			switch {
			case sym.IsTerminal:
				state.actions[sym] = append(state.actions[sym], action{'s', n})
			default:
				state.gotos[sym] = action{'g', n}
			}
		}
		y.entries += len(state.actions) + len(state.gotos)
		state.xla = make([]symSet, len(state.xitems))
	}
}

func (y *y) useSym(nm string, pos token.Pos) {
	if _, ok := y.symsUsed[nm]; ok {
		return
	}

	y.symsUsed[nm] = pos
}

func (y *y) useType(pos token.Pos, name string) {
	if name == "" {
		return
	}

	if _, ok := y.typesUsed[name]; ok {
		return
	}

	y.typesUsed[name] = pos
}

func (y *y) xerrors() error {
	n := len(y.opts.XErrorsSrc)
	if n == 0 {
		return y.error()
	}

	if y.opts.XErrorsName == "" {
		y.opts.XErrorsName = "<xerrors>"
	}
	var s scanner.Scanner
	s.Init(
		y.fset.AddFile(y.opts.XErrorsName, -1, n),
		y.opts.XErrorsSrc,
		func(pos token.Position, msg string) {
			y.errp(pos, msg)
		},
		0, // Ignore comments
	)

	var example []string
	var examples [][]string
examples:
	for {
		switch pos, tok, lit := s.Scan(); tok {
		case token.IDENT:
			sym, ok := y.Syms[lit]
			if !ok {
				y.err(pos, "undefined symbol %s", lit)
				break
			}

			if !sym.IsTerminal {
				y.err(pos, "not a terminal symbol: %s", lit)
				break
			}

			if lit == "error" {
				lit = ""
			}
			example = append(example, lit)
		case token.CHAR:
			t, err := strconv.Unquote(lit)
			if err != nil {
				y.err(pos, "%v", err)
				break
			}

			nm := fmt.Sprintf("%q", []rune(t)[0])
			if _, ok := y.Syms[nm]; !ok {
				y.Syms[nm] = &Symbol{Name: nm, IsTerminal: true, precedence: -1, Value: int([]rune(lit)[0])}
			}
			example = append(example, nm)
		case token.OR: // '|'
			examples = append(examples, example)
			example = nil
		case token.STRING:
			parse := func(toks []string) (stack []int, la *Symbol, ok bool) {
				lex := func() *Symbol {
					if la != nil {
						return la
					}

					if len(toks) == 0 {
						la = y.endSym
						return la
					}

					la = y.Syms[toks[0]]
					toks = toks[1:]
					return la
				}

				stack = []int{0}
				for {
					state := y.states[stack[len(stack)-1]]
					tok := lex()
					var action action
					actions, ok := state.actions[tok]
					if !ok {
						return stack, la, true
					}

					action = actions[0]
					switch action.kind {
					case 'a':
						return stack, la, false
					case 's':
						la = nil
						stack = append(stack, action.arg)
					case 'r':
						rule := y.Rules[action.arg]
						stack = stack[:len(stack)-len(rule.Components)]
						stack = append(stack, y.states[stack[len(stack)-1]].gotos[rule.Sym].arg)
					default:
						panic("internal error 013")
					}
				}
			}
			lit := lit[1 : len(lit)-1]
			for _, example := range append(examples, example) {
				stack, la, ok := parse(example)
				if !ok {
					y.err(pos, "parser unexpectedly accepts xerror example: %v %s", example, lit)
					continue
				}

				y.XErrors = append(y.XErrors, XError{stack, la, lit})
			}
			example = example[:0]
			examples = examples[:0]
		case token.EOF:
			break examples
		case token.ILLEGAL:
			y.err(pos, "illegal token %s (%q)", tok, lit)
			break examples
		case token.SEMICOLON:
			if lit == "\n" {
				break
			}

			fallthrough
		default:
			y.err(pos, "unexpected token %s (%q)", tok, lit)
			break examples
		}
	}
	return y.error()
}

func (y *y) zeroPaths() {
	if y.zeroPathsValid {
		return
	}

	var h zpHeap
	s0 := y.states[0]
	m := make([]bool, len(y.states))
	h.add(y, s0)
	m[0] = true
	for n := len(y.states) - 1; n != 0; {
		e := heap.Pop(&h).(*zpElem)
		d := e.dest
		if d.psym == nil {
			d.parent = e.src
			d.psym = e.sym
			d.distance = e.distance
			n--
		}
		if di := d.id; !m[di] {
			m[di] = true
			h.add(y, d)
		}
	}
	y.zeroPathsValid = true
}

type zpElem struct {
	src, dest *state
	sym       *Symbol
	distance  int
}

func (z *zpElem) less(b *zpElem) bool {
	if z.distance < b.distance {
		return true
	}

	if z.distance > b.distance {
		return false
	}

	if z.sym.Name < b.sym.Name {
		return true
	}

	if z.sym.Name > b.sym.Name {
		return false
	}

	return z.src.id < z.dest.id
}

type zpHeap []*zpElem

func (z zpHeap) Len() int            { return len(z) }
func (z zpHeap) Less(i, j int) bool  { return z[i].less(z[j]) }
func (z zpHeap) Swap(i, j int)       { z[i], z[j] = z[j], z[i] }
func (z *zpHeap) Push(x interface{}) { *z = append(*z, x.(*zpElem)) }

func (z *zpHeap) Pop() interface{} {
	s := *z
	r := s[len(s)-1]
	*z = s[:len(s)-1]
	return r
}

func (z *zpHeap) add(y *y, s *state) {
	for sym, actions := range s.actions {
		action := actions[0]
		if action.kind == 's' {
			heap.Push(z, &zpElem{s, y.states[action.arg], sym, s.distance + len(sym.minString(nil))})
		}
	}
	for sym, action := range s.gotos {
		heap.Push(z, &zpElem{s, y.states[action.arg], sym, s.distance + len(sym.minString(nil))})
	}
}
