// Copyright 2014 The y Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// Package y converts .y (yacc[2]) source files to data suitable for a parser
// generator.
//
// Links
//
// Referenced from elsewhere:
//
//  [0]: http://godoc.org/github.com/cznic/goyacc
//  [1]: http://people.via.ecp.fr/~stilgar/doc/compilo/parser/Generating%20LR%20Syntax%20Error%20Messages.pdf
//  [2]: http://dinosaur.compilertools.net/yacc/
//  [3]: http://dinosaur.compilertools.net/lex/index.html
//  [4]: https://www.gnu.org/software/bison/manual/html_node/Using-Mid_002dRule-Actions.html
package y

import (
	"go/ast"
	"go/token"
	"io"
	"io/ioutil"

	yparser "github.com/cznic/parser/yacc"
)

// Action describes one cell of the parser table, ie. the action to be taken when
// the lookahead is Sym.
type Action struct {
	Sym *Symbol
	arg int
}

// Kind returns typ: 'a' for accept, 's' for shift, 'r' for reduce and 'g' for goto.
//
//	For 'a' arg is not used.
//	For 's' arg is the state number to shift to.
//	For 'r' arg is the rule number which is to be reduced.
//	For 'g' arg is the state number to goto.
func (a Action) Kind() (typ, arg int) {
	if !a.Sym.IsTerminal {
		return 'g', a.arg
	}

	switch arg := a.arg; {
	case arg < 0:
		return 'r', -arg
	case arg > 0:
		return 's', arg
	}

	return 'a', -1
}

// Options amend the behavior of the various Process* functions.
//
// Error Examples
//
// Error examples implement the ideas in "Generating LR Syntax Error Messages
// from Examples"[1]. They extend the capability of a LALR parser to produce
// better error messages.
//
// XErrorSrc is a sequence of Go tokens separated by white space using the same
// rules as valid Go source code except that semicolon injection is not used.
// Comments of both short and long form are equal to white space. An example
// consists of zero or more token specifiers followed by an error message.
// Token specifier is a valid Go identifier or a Go character literal. The
// error message is a Go string literal. The identifiers used in XErrorsSrc
// must be those defined as tokens in the yacc file. An implicit $end token is
// inserted at the end of the example input. For example:
//
//	/*
//		Reject empty file
//	*/
//	"invalid empty source file"
//
//	PACKAGE IDENT ';'
//	IMPORT STRING_LIT ','
//	"multiple imports must be separated by semicolons"
//
//	// Make the semicolon injection error a bit more user friendly.
//	PACKAGE ';'
//	`Missing package name or newline after "package"`
//
//	// A calculator parser might have error examples like
//	NUMBER '+' "operand expected"
//	NUMBER '-' error "invalid operand for subtraction"
//
// Use a specific bad token to provide a specific message:
//
//	// Coders frequently make this mistake.
//	FOO BAR BAZ "baz cannot follow bar, only qux or frob can"
//
// Use the reserved error token to be less specific:
//
//	// Catch any invalid token sequences after foo bar.
//	FOO BAR error "bar must be followed by qux or frob"
//
// Terminate the token sequence to detect premature end of file:
//
//	PACKAGE "missing package name"
//
// Similar to lex[3], examples sharing the same "action" can be joined by
// the | operator:
//
//	CONST  |
//	FUNC   |
//	IMPORT |
//	TYPE   |
//	VAR "package clause must be first"
//
// It's an error if the example token sequence is accepted by the parser, ie.
// if it does not produce an error.
type Options struct {
	AllowConflicts bool      // Do not report unresolved conflicts as errors.
	Closures       bool      // Report non kernel items.
	LA             bool      // Report all lookahead sets.
	Report         io.Writer // If non nil, write a grammar report to Report.
	Resolved       bool      // Explain how conflicts were resolved.
	XErrorsName    string    // Name used to report errors in XErrorsSrc, defaults to <xerrors>.
	XErrorsSrc     []byte    // Used to produce errors by example[1].

	// In conflict with xerrors processing.
	noDefault bool // Disable collapsing largest reduce lookahead set to $default.
}

func (o *Options) boot(fset *token.FileSet) (*Options, error) {
	if o == nil {
		return &Options{}, nil
	}

	p := *o
	p.noDefault = true
	return &p, nil
}

// Parser describes the resulting parser. The intended client is a parser
// generator (like eg. [0]) producing the final Go source code.
type Parser struct {
	ConflictsRR  int                // Number of reduce/reduce conflicts.
	ConflictsSR  int                // Number of shift/reduce conflicts.
	ErrorVerbose bool               // %error-verbose is present.
	Prologue     string             // Collected prologue between the %{ and %} marks.
	Rules        []*Rule            // Rules indexed by rule number.
	Syms         map[string]*Symbol // Symbols indexed by name, eg. "IDENT", "Expression" or "';'".
	Table        [][]Action         // Indexed by state number.
	Tail         string             // Everyting after the second %%, if present.
	Union        *ast.StructType    // %union as Go AST.
	UnionSrc     string             // %union as Go source form.
	XErrors      []XError           // Errors by example[1] descriptions.
	y            *y
}

func newParser() *Parser {
	return &Parser{}
}

// ProcessAST processes yacc source code parsed in ast. It returns a *Parser or
// an error, if any.
func ProcessAST(fset *token.FileSet, ast *yparser.AST, opts *Options) (*Parser, error) {
	y, err := processAST(fset, ast, opts)
	if y == nil {
		return nil, err
	}

	if isTesting {
		y.Parser.y = y
	}
	return y.Parser, err
}

// ProcessFile processes yacc source code in a named file. It returns a *Parser
// or an error, if any.
func ProcessFile(fset *token.FileSet, fname string, opts *Options) (*Parser, error) {
	b, err := ioutil.ReadFile(fname)
	if err != nil {
		return nil, err
	}

	return ProcessSource(fset, fname, b, opts)
}

// ProcessSource processes yacc source code in src. It returns a *Parser or an
// error, if any.
func ProcessSource(fset *token.FileSet, fname string, src []byte, opts *Options) (*Parser, error) {
	ast, err := yparser.Parse(fset, fname, src)
	if err != nil {
		return nil, err
	}

	return ProcessAST(fset, ast, opts)
}

// Rule describes a single yacc rule, for example (in source form)
//
//	Start:
//		Prologue Body Epilogue
//		{
//			$$ = &ast{$1, $2, $3}
//		}
//
// Inner rule actions
//
// A rule can prescribe semantic actions not only at the end. For example
//
//	Foo:
//		Bar
//		{
//			initBar($1)
//		}
//		Qux
//		{
//			handleQux($3)
//		}
//
// Such constructs are rewritten as
//
//	$@1:
//		{
//			initBar($1)
//		}
//
//	Foo:
//		Bar $@1 Qux
//		{
//			handleQux($3)
//		}
//
// The $@1 and similar is a synthetic rule and such have non nil Parent.
// MaxParentDlr is used to check that the semantic action does not access
// parent values not yet shifted to the parse stack as well as to compute the
// position of the $n thing on the parse stack. See also [4].
type Rule struct {
	Action        []*yparser.Act // Parts of the semantic action associated with the rule, if any.
	Components    []string       // Textual forms of the rule components, for example []string{"IDENT", "';'"}
	MaxParentDlr  int            // See the Rule type docs for details.
	Parent        *Rule          // Non nil if a synthetic rule.
	Sym           *Symbol        // LHS of the rule.
	associativity int
	maxDlr        int
	pos           token.Pos
	precSym       *Symbol
	precedence    int
	ruleNum       int
	syms          []*Symbol
}

// A special default symbol has Name "$default" and represents the default
// action.

// Symbol represents a terminal or non terminal symbol. A special end symbol
// has Name "$end" and represents the EOF token.
type Symbol struct {
	IsTerminal    bool   // Whether this is a terminal symbol.
	Name          string // Textual value of the symbol, for example "IDENT" or "';'".
	Type          string // For example "int", "float64" or "foo", but possibly also "".
	Value         int    // Numeric value of the symbol.
	associativity int
	derivesE      bool // Non terminal sym derives ε.
	first1        symSet
	firstValid    bool
	follow        symSet
	id            int // Index into y.syms
	minx          int // Index into rules for shortest string of terminals reducing sym.
	minxValid     bool
	pos           token.Pos
	precedence    int
	rules         []*Rule
}

func (s *Symbol) first(y *y) symSet { // dragon, 4.4
	if s.firstValid {
		return s.first1
	}

	s.firstValid = true
	if s.IsTerminal {
		s.first1 = y.newSymSet(s.id)
		return s.first1
	}

	s.first1 = y.newSymSet(-1)
loop:
	for _, rule := range s.rules {
		syms := rule.syms
		if len(syms) == 0 {
			s.first1.addEmpty()
			continue
		}

		for _, sym := range syms {
			f1 := sym.first(y)
			s.first1.add(f1, true)
			if !f1.hasEmpty() {
				continue loop
			}
		}
		s.first1.addEmpty()
	}
	return s.first1
}

func (s *Symbol) minString(m map[*Symbol]int) (r []*Symbol) {
	if s.IsTerminal {
		return []*Symbol{s}
	}

	if s.derivesE {
		return nil
	}

	if m == nil {
		m = map[*Symbol]int{}
	}

	m[s]++
	if s.minxValid {
		for _, v := range s.rules[s.minx].syms {
			if m[v] > 0 {
				r = append(r, v)
				continue
			}

			r = append(r, v.minString(m)...)
		}
		m[s]--
		return r
	}

	var rss [][]*Symbol
	var ok []bool
	for _, rule := range s.rules {
		var rs []*Symbol
		ok0 := true
		for _, v := range rule.syms {
			if m[v] > 0 {
				ok0 = false
				rs = append(rs, v)
				continue
			}

			rs = append(rs, v.minString(m)...)
		}
		for _, v := range rs {
			if !v.IsTerminal {
				ok0 = false
				break
			}
		}
		rss = append(rss, rs)
		ok = append(ok, ok0)
	}
	m[s]--
	valid := false
	for i, v := range rss {
		if !ok[i] {
			continue
		}

		if !valid || len(v) < len(r) {
			s.minx, s.minxValid = i, true
			r, valid = v, true
		}
	}
	if valid {
		return r
	}

	for i, v := range rss {
		if !valid || len(v) < len(r) {
			s.minx, s.minxValid = i, true
			r = v
		}
	}
	return r
}

// String implements fmt.Stringer.
func (s *Symbol) String() string {
	if s != nil {
		return s.Name
	}

	return "<nil>"
}

// XError describes the parser state for an error by example. See [1].
type XError struct {
	Stack     []int   // Parser states of the error event. TOS is Stack[len(Stack)-1].
	Lookahead *Symbol // LA of the error event. Nil if LA is the reserved error symbol.
	Msg       string  // Textual representation of the error condition.
}
