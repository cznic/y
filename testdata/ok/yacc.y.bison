Terminals unused in grammar

   illegal
   tkRCurl


Grammar

    0 $accept: spec $end

    1 spec: defs tkMark rules tail

    2 tail: /* empty */
    3     | tkMark

    4 defs: /* empty */
    5     | defs def

    6 def: tkStart tkIdent
    7    | tkUnion
    8    | tkLCurl
    9    | tkErrorVerbose
   10    | rword tag nlist

   11 rword: tkToken
   12      | tkLeft
   13      | tkRight
   14      | tkNonAssoc
   15      | tkType

   16 tag: /* empty */
   17    | '<' tkIdent '>'

   18 nlist: nmno
   19      | nlist nmno

   20 nmno: tkIdent
   21     | tkIdent tkNumber

   22 rules: tkCIdent rbody prec
   23      | rules rule

   24 rule: tkCIdent rbody prec
   25     | '|' rbody prec

   26 rbody: /* empty */
   27      | rbody tkIdent
   28      | rbody act

   29 act: '{'

   30 prec: /* empty */
   31     | tkPrec tkIdent
   32     | tkPrec tkIdent act
   33     | prec ';'


Terminals, with rules where they appear

$end (0) 0
';' (59) 33
'<' (60) 17
'>' (62) 17
'{' (123) 29
'|' (124) 25
error (256)
illegal (258)
tkIdent (259) 6 17 20 21 27 31 32
tkCIdent (260) 22 24
tkNumber (261) 21
tkLeft (262) 12
tkRight (263) 13
tkNonAssoc (264) 14
tkToken (265) 11
tkPrec (266) 31 32
tkType (267) 15
tkStart (268) 6
tkUnion (269) 7
tkErrorVerbose (270) 9
tkMark (271) 1 3
tkLCurl (272) 8
tkRCurl (273)


Nonterminals, with rules where they appear

$accept (24)
    on left: 0
spec (25)
    on left: 1, on right: 0
tail (26)
    on left: 2 3, on right: 1
defs (27)
    on left: 4 5, on right: 1 5
def (28)
    on left: 6 7 8 9 10, on right: 5
rword (29)
    on left: 11 12 13 14 15, on right: 10
tag (30)
    on left: 16 17, on right: 10
nlist (31)
    on left: 18 19, on right: 10 19
nmno (32)
    on left: 20 21, on right: 18 19
rules (33)
    on left: 22 23, on right: 1 23
rule (34)
    on left: 24 25, on right: 23
rbody (35)
    on left: 26 27 28, on right: 22 24 25 27 28
act (36)
    on left: 29, on right: 28 32
prec (37)
    on left: 30 31 32 33, on right: 22 24 25 33


state 0

    0 $accept: . spec $end
    1 spec: . defs tkMark rules tail
    4 defs: .
    5     | . defs def

    $default  reduce using rule 4 (defs)

    spec  go to state 1
    defs  go to state 2


state 1

    0 $accept: spec . $end

    $end  shift, and go to state 3


state 2

    1 spec: defs . tkMark rules tail
    5 defs: defs . def
    6 def: . tkStart tkIdent
    7    | . tkUnion
    8    | . tkLCurl
    9    | . tkErrorVerbose
   10    | . rword tag nlist
   11 rword: . tkToken
   12      | . tkLeft
   13      | . tkRight
   14      | . tkNonAssoc
   15      | . tkType

    tkLeft          shift, and go to state 4
    tkRight         shift, and go to state 5
    tkNonAssoc      shift, and go to state 6
    tkToken         shift, and go to state 7
    tkType          shift, and go to state 8
    tkStart         shift, and go to state 9
    tkUnion         shift, and go to state 10
    tkErrorVerbose  shift, and go to state 11
    tkMark          shift, and go to state 12
    tkLCurl         shift, and go to state 13

    def    go to state 14
    rword  go to state 15


state 3

    0 $accept: spec $end .

    $default  accept


state 4

   12 rword: tkLeft .

    $default  reduce using rule 12 (rword)


state 5

   13 rword: tkRight .

    $default  reduce using rule 13 (rword)


state 6

   14 rword: tkNonAssoc .

    $default  reduce using rule 14 (rword)


state 7

   11 rword: tkToken .

    $default  reduce using rule 11 (rword)


state 8

   15 rword: tkType .

    $default  reduce using rule 15 (rword)


state 9

    6 def: tkStart . tkIdent

    tkIdent  shift, and go to state 16


state 10

    7 def: tkUnion .

    $default  reduce using rule 7 (def)


state 11

    9 def: tkErrorVerbose .

    $default  reduce using rule 9 (def)


state 12

    1 spec: defs tkMark . rules tail
   22 rules: . tkCIdent rbody prec
   23      | . rules rule

    tkCIdent  shift, and go to state 17

    rules  go to state 18


state 13

    8 def: tkLCurl .

    $default  reduce using rule 8 (def)


state 14

    5 defs: defs def .

    $default  reduce using rule 5 (defs)


state 15

   10 def: rword . tag nlist
   16 tag: .  [tkIdent]
   17    | . '<' tkIdent '>'

    '<'  shift, and go to state 19

    $default  reduce using rule 16 (tag)

    tag  go to state 20


state 16

    6 def: tkStart tkIdent .

    $default  reduce using rule 6 (def)


state 17

   22 rules: tkCIdent . rbody prec
   26 rbody: .
   27      | . rbody tkIdent
   28      | . rbody act

    $default  reduce using rule 26 (rbody)

    rbody  go to state 21


state 18

    1 spec: defs tkMark rules . tail
    2 tail: .  [$end]
    3     | . tkMark
   23 rules: rules . rule
   24 rule: . tkCIdent rbody prec
   25     | . '|' rbody prec

    tkCIdent  shift, and go to state 22
    tkMark    shift, and go to state 23
    '|'       shift, and go to state 24

    $default  reduce using rule 2 (tail)

    tail  go to state 25
    rule  go to state 26


state 19

   17 tag: '<' . tkIdent '>'

    tkIdent  shift, and go to state 27


state 20

   10 def: rword tag . nlist
   18 nlist: . nmno
   19      | . nlist nmno
   20 nmno: . tkIdent
   21     | . tkIdent tkNumber

    tkIdent  shift, and go to state 28

    nlist  go to state 29
    nmno   go to state 30


state 21

   22 rules: tkCIdent rbody . prec
   27 rbody: rbody . tkIdent
   28      | rbody . act
   29 act: . '{'
   30 prec: .  [$end, tkCIdent, tkMark, '|', ';']
   31     | . tkPrec tkIdent
   32     | . tkPrec tkIdent act
   33     | . prec ';'

    tkIdent  shift, and go to state 31
    tkPrec   shift, and go to state 32
    '{'      shift, and go to state 33

    $default  reduce using rule 30 (prec)

    act   go to state 34
    prec  go to state 35


state 22

   24 rule: tkCIdent . rbody prec
   26 rbody: .
   27      | . rbody tkIdent
   28      | . rbody act

    $default  reduce using rule 26 (rbody)

    rbody  go to state 36


state 23

    3 tail: tkMark .

    $default  reduce using rule 3 (tail)


state 24

   25 rule: '|' . rbody prec
   26 rbody: .
   27      | . rbody tkIdent
   28      | . rbody act

    $default  reduce using rule 26 (rbody)

    rbody  go to state 37


state 25

    1 spec: defs tkMark rules tail .

    $default  reduce using rule 1 (spec)


state 26

   23 rules: rules rule .

    $default  reduce using rule 23 (rules)


state 27

   17 tag: '<' tkIdent . '>'

    '>'  shift, and go to state 38


state 28

   20 nmno: tkIdent .  [tkIdent, tkLeft, tkRight, tkNonAssoc, tkToken, tkType, tkStart, tkUnion, tkErrorVerbose, tkMark, tkLCurl]
   21     | tkIdent . tkNumber

    tkNumber  shift, and go to state 39

    $default  reduce using rule 20 (nmno)


state 29

   10 def: rword tag nlist .  [tkLeft, tkRight, tkNonAssoc, tkToken, tkType, tkStart, tkUnion, tkErrorVerbose, tkMark, tkLCurl]
   19 nlist: nlist . nmno
   20 nmno: . tkIdent
   21     | . tkIdent tkNumber

    tkIdent  shift, and go to state 28

    $default  reduce using rule 10 (def)

    nmno  go to state 40


state 30

   18 nlist: nmno .

    $default  reduce using rule 18 (nlist)


state 31

   27 rbody: rbody tkIdent .

    $default  reduce using rule 27 (rbody)


state 32

   31 prec: tkPrec . tkIdent
   32     | tkPrec . tkIdent act

    tkIdent  shift, and go to state 41


state 33

   29 act: '{' .

    $default  reduce using rule 29 (act)


state 34

   28 rbody: rbody act .

    $default  reduce using rule 28 (rbody)


state 35

   22 rules: tkCIdent rbody prec .  [$end, tkCIdent, tkMark, '|']
   33 prec: prec . ';'

    ';'  shift, and go to state 42

    $default  reduce using rule 22 (rules)


state 36

   24 rule: tkCIdent rbody . prec
   27 rbody: rbody . tkIdent
   28      | rbody . act
   29 act: . '{'
   30 prec: .  [$end, tkCIdent, tkMark, '|', ';']
   31     | . tkPrec tkIdent
   32     | . tkPrec tkIdent act
   33     | . prec ';'

    tkIdent  shift, and go to state 31
    tkPrec   shift, and go to state 32
    '{'      shift, and go to state 33

    $default  reduce using rule 30 (prec)

    act   go to state 34
    prec  go to state 43


state 37

   25 rule: '|' rbody . prec
   27 rbody: rbody . tkIdent
   28      | rbody . act
   29 act: . '{'
   30 prec: .  [$end, tkCIdent, tkMark, '|', ';']
   31     | . tkPrec tkIdent
   32     | . tkPrec tkIdent act
   33     | . prec ';'

    tkIdent  shift, and go to state 31
    tkPrec   shift, and go to state 32
    '{'      shift, and go to state 33

    $default  reduce using rule 30 (prec)

    act   go to state 34
    prec  go to state 44


state 38

   17 tag: '<' tkIdent '>' .

    $default  reduce using rule 17 (tag)


state 39

   21 nmno: tkIdent tkNumber .

    $default  reduce using rule 21 (nmno)


state 40

   19 nlist: nlist nmno .

    $default  reduce using rule 19 (nlist)


state 41

   29 act: . '{'
   31 prec: tkPrec tkIdent .  [$end, tkCIdent, tkMark, '|', ';']
   32     | tkPrec tkIdent . act

    '{'  shift, and go to state 33

    $default  reduce using rule 31 (prec)

    act  go to state 45


state 42

   33 prec: prec ';' .

    $default  reduce using rule 33 (prec)


state 43

   24 rule: tkCIdent rbody prec .  [$end, tkCIdent, tkMark, '|']
   33 prec: prec . ';'

    ';'  shift, and go to state 42

    $default  reduce using rule 24 (rule)


state 44

   25 rule: '|' rbody prec .  [$end, tkCIdent, tkMark, '|']
   33 prec: prec . ';'

    ';'  shift, and go to state 42

    $default  reduce using rule 25 (rule)


state 45

   32 prec: tkPrec tkIdent act .

    $default  reduce using rule 32 (prec)
