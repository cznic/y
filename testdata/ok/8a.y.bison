Grammar

    0 $accept: prog $end

    1 prog: /* empty */

    2 $@1: /* empty */

    3 prog: prog $@1 line

    4 $@2: /* empty */

    5 line: LLAB ':' $@2 line

    6 $@3: /* empty */

    7 line: LNAME ':' $@3 line
    8     | ';'
    9     | inst ';'
   10     | error ';'

   11 inst: LNAME '=' expr
   12     | LVAR '=' expr
   13     | LTYPE0 nonnon
   14     | LTYPE1 nonrem
   15     | LTYPE2 rimnon
   16     | LTYPE3 rimrem
   17     | LTYPE4 remrim
   18     | LTYPER nonrel
   19     | LTYPED spec1
   20     | LTYPET spec2
   21     | LTYPEC spec3
   22     | LTYPEN spec4
   23     | LTYPES spec5
   24     | LTYPEM spec6
   25     | LTYPEI spec7
   26     | LTYPEG spec8
   27     | LTYPEXC spec9
   28     | LTYPEX spec10
   29     | LTYPEPC spec11
   30     | LTYPEF spec12

   31 nonnon: /* empty */
   32       | ','

   33 rimrem: rim ',' rem

   34 remrim: rem ',' rim

   35 rimnon: rim ','
   36       | rim

   37 nonrem: ',' rem
   38       | rem

   39 nonrel: ',' rel
   40       | rel
   41       | imm ',' rel

   42 spec1: nam '/' con ',' imm

   43 spec2: mem ',' imm2
   44      | mem ',' con ',' imm2

   45 spec3: ',' rom
   46      | rom
   47      | '*' nam

   48 spec4: nonnon
   49      | nonrem

   50 spec5: rim ',' rem
   51      | rim ',' rem ':' LLREG

   52 spec6: rim ',' rem
   53      | rim ',' rem ':' LSREG

   54 spec7: rim ','
   55      | rim
   56      | rim ',' rem

   57 spec8: mem ',' imm
   58      | mem ',' con ',' imm

   59 spec9: reg ',' rem ',' con

   60 spec10: imm ',' rem ',' reg

   61 spec11: rim ',' rim

   62 spec12: rim ',' rim

   63 rem: reg
   64    | mem

   65 rom: rel
   66    | nmem
   67    | '*' reg
   68    | '*' omem
   69    | reg
   70    | omem
   71    | imm

   72 rim: rem
   73    | imm

   74 rel: con '(' LPC ')'
   75    | LNAME offset
   76    | LLAB offset

   77 reg: LBREG
   78    | LFREG
   79    | LLREG
   80    | LXREG
   81    | LSP
   82    | LSREG

   83 imm: '$' con
   84    | '$' nam
   85    | '$' LSCONST
   86    | '$' LFCONST
   87    | '$' '(' LFCONST ')'
   88    | '$' '(' '-' LFCONST ')'
   89    | '$' '-' LFCONST

   90 imm2: '$' con2

   91 con2: LCONST
   92     | '-' LCONST
   93     | LCONST '-' LCONST
   94     | '-' LCONST '-' LCONST

   95 mem: omem
   96    | nmem

   97 omem: con
   98     | con '(' LLREG ')'
   99     | con '(' LSP ')'
  100     | con '(' LLREG '*' con ')'
  101     | con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | '(' LLREG ')'
  104     | '(' LSP ')'
  105     | con '(' LSREG ')'
  106     | '(' LLREG '*' con ')'
  107     | '(' LLREG ')' '(' LLREG '*' con ')'

  108 nmem: nam
  109     | nam '(' LLREG '*' con ')'

  110 nam: LNAME offset '(' pointer ')'
  111    | LNAME '<' '>' offset '(' LSB ')'

  112 offset: /* empty */
  113       | '+' con
  114       | '-' con

  115 pointer: LSB
  116        | LSP
  117        | LFP

  118 con: LCONST
  119    | LVAR
  120    | '-' con
  121    | '+' con
  122    | '~' con
  123    | '(' expr ')'

  124 expr: con
  125     | expr '+' expr
  126     | expr '-' expr
  127     | expr '*' expr
  128     | expr '/' expr
  129     | expr '%' expr
  130     | expr '<' '<' expr
  131     | expr '>' '>' expr
  132     | expr '&' expr
  133     | expr '^' expr
  134     | expr '|' expr


Terminals, with rules where they appear

$end (0) 0
'$' (36) 83 84 85 86 87 88 89 90
'%' (37) 129
'&' (38) 132
'(' (40) 74 87 88 98 99 100 101 102 103 104 105 106 107 109 110 111
    123
')' (41) 74 87 88 98 99 100 101 102 103 104 105 106 107 109 110 111
    123
'*' (42) 47 67 68 100 101 102 106 107 109 127
'+' (43) 113 121 125
',' (44) 32 33 34 35 37 39 41 42 43 44 45 50 51 52 53 54 56 57 58 59
    60 61 62
'-' (45) 88 89 92 93 94 114 120 126
'/' (47) 42 128
':' (58) 5 7 51 53
';' (59) 8 9 10
'<' (60) 111 130
'=' (61) 11 12
'>' (62) 111 131
'^' (94) 133
'|' (124) 134
'~' (126) 122
error (256) 10
LTYPE0 (258) 13
LTYPE1 (259) 14
LTYPE2 (260) 15
LTYPE3 (261) 16
LTYPE4 (262) 17
LTYPEC (263) 21
LTYPED (264) 19
LTYPEN (265) 22
LTYPER (266) 18
LTYPET (267) 20
LTYPES (268) 23
LTYPEM (269) 24
LTYPEI (270) 25
LTYPEG (271) 26
LTYPEXC (272) 27
LTYPEX (273) 28
LTYPEPC (274) 29
LTYPEF (275) 30
LCONST (276) 91 92 93 94 118
LFP (277) 117
LPC (278) 74
LSB (279) 111 115
LBREG (280) 77
LLREG (281) 51 79 98 100 101 102 103 106 107 109
LSREG (282) 53 82 102 105
LFREG (283) 78
LXREG (284) 80
LFCONST (285) 86 87 88 89
LSCONST (286) 85
LSP (287) 81 99 104 116
LNAME (288) 7 11 75 110 111
LLAB (289) 5 76
LVAR (290) 12 119


Nonterminals, with rules where they appear

$accept (54)
    on left: 0
prog (55)
    on left: 1 3, on right: 0 3
$@1 (56)
    on left: 2, on right: 3
line (57)
    on left: 5 7 8 9 10, on right: 3 5 7
$@2 (58)
    on left: 4, on right: 5
$@3 (59)
    on left: 6, on right: 7
inst (60)
    on left: 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28
    29 30, on right: 9
nonnon (61)
    on left: 31 32, on right: 13 48
rimrem (62)
    on left: 33, on right: 16
remrim (63)
    on left: 34, on right: 17
rimnon (64)
    on left: 35 36, on right: 15
nonrem (65)
    on left: 37 38, on right: 14 49
nonrel (66)
    on left: 39 40 41, on right: 18
spec1 (67)
    on left: 42, on right: 19
spec2 (68)
    on left: 43 44, on right: 20
spec3 (69)
    on left: 45 46 47, on right: 21
spec4 (70)
    on left: 48 49, on right: 22
spec5 (71)
    on left: 50 51, on right: 23
spec6 (72)
    on left: 52 53, on right: 24
spec7 (73)
    on left: 54 55 56, on right: 25
spec8 (74)
    on left: 57 58, on right: 26
spec9 (75)
    on left: 59, on right: 27
spec10 (76)
    on left: 60, on right: 28
spec11 (77)
    on left: 61, on right: 29
spec12 (78)
    on left: 62, on right: 30
rem (79)
    on left: 63 64, on right: 33 34 37 38 50 51 52 53 56 59 60 72
rom (80)
    on left: 65 66 67 68 69 70 71, on right: 45 46
rim (81)
    on left: 72 73, on right: 33 34 35 36 50 51 52 53 54 55 56 61 62
rel (82)
    on left: 74 75 76, on right: 39 40 41 65
reg (83)
    on left: 77 78 79 80 81 82, on right: 59 60 63 67 69
imm (84)
    on left: 83 84 85 86 87 88 89, on right: 41 42 57 58 60 71 73
imm2 (85)
    on left: 90, on right: 43 44
con2 (86)
    on left: 91 92 93 94, on right: 90
mem (87)
    on left: 95 96, on right: 43 44 57 58 64
omem (88)
    on left: 97 98 99 100 101 102 103 104 105 106 107, on right: 68
    70 95
nmem (89)
    on left: 108 109, on right: 66 96
nam (90)
    on left: 110 111, on right: 42 47 84 108 109
offset (91)
    on left: 112 113 114, on right: 75 76 110 111
pointer (92)
    on left: 115 116 117, on right: 110
con (93)
    on left: 118 119 120 121 122 123, on right: 42 44 58 59 74 83 97
    98 99 100 101 102 105 106 107 109 113 114 120 121 122 124
expr (94)
    on left: 124 125 126 127 128 129 130 131 132 133 134, on right:
    11 12 123 125 126 127 128 129 130 131 132 133 134


state 0

    0 $accept: . prog $end
    1 prog: .
    3     | . prog $@1 line

    $default  reduce using rule 1 (prog)

    prog  go to state 1


state 1

    0 $accept: prog . $end
    2 $@1: .  [error, LTYPE0, LTYPE1, LTYPE2, LTYPE3, LTYPE4, LTYPEC, LTYPED, LTYPEN, LTYPER, LTYPET, LTYPES, LTYPEM, LTYPEI, LTYPEG, LTYPEXC, LTYPEX, LTYPEPC, LTYPEF, LNAME, LLAB, LVAR, ';']
    3 prog: prog . $@1 line

    $end  shift, and go to state 2

    $default  reduce using rule 2 ($@1)

    $@1  go to state 3


state 2

    0 $accept: prog $end .

    $default  accept


state 3

    3 prog: prog $@1 . line
    5 line: . LLAB ':' $@2 line
    7     | . LNAME ':' $@3 line
    8     | . ';'
    9     | . inst ';'
   10     | . error ';'
   11 inst: . LNAME '=' expr
   12     | . LVAR '=' expr
   13     | . LTYPE0 nonnon
   14     | . LTYPE1 nonrem
   15     | . LTYPE2 rimnon
   16     | . LTYPE3 rimrem
   17     | . LTYPE4 remrim
   18     | . LTYPER nonrel
   19     | . LTYPED spec1
   20     | . LTYPET spec2
   21     | . LTYPEC spec3
   22     | . LTYPEN spec4
   23     | . LTYPES spec5
   24     | . LTYPEM spec6
   25     | . LTYPEI spec7
   26     | . LTYPEG spec8
   27     | . LTYPEXC spec9
   28     | . LTYPEX spec10
   29     | . LTYPEPC spec11
   30     | . LTYPEF spec12

    error    shift, and go to state 4
    LTYPE0   shift, and go to state 5
    LTYPE1   shift, and go to state 6
    LTYPE2   shift, and go to state 7
    LTYPE3   shift, and go to state 8
    LTYPE4   shift, and go to state 9
    LTYPEC   shift, and go to state 10
    LTYPED   shift, and go to state 11
    LTYPEN   shift, and go to state 12
    LTYPER   shift, and go to state 13
    LTYPET   shift, and go to state 14
    LTYPES   shift, and go to state 15
    LTYPEM   shift, and go to state 16
    LTYPEI   shift, and go to state 17
    LTYPEG   shift, and go to state 18
    LTYPEXC  shift, and go to state 19
    LTYPEX   shift, and go to state 20
    LTYPEPC  shift, and go to state 21
    LTYPEF   shift, and go to state 22
    LNAME    shift, and go to state 23
    LLAB     shift, and go to state 24
    LVAR     shift, and go to state 25
    ';'      shift, and go to state 26

    line  go to state 27
    inst  go to state 28


state 4

   10 line: error . ';'

    ';'  shift, and go to state 29


state 5

   13 inst: LTYPE0 . nonnon
   31 nonnon: .  [';']
   32       | . ','

    ','  shift, and go to state 30

    $default  reduce using rule 31 (nonnon)

    nonnon  go to state 31


state 6

   14 inst: LTYPE1 . nonrem
   37 nonrem: . ',' rem
   38       | . rem
   63 rem: . reg
   64    | . mem
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    ','     shift, and go to state 43
    '('     shift, and go to state 44
    '~'     shift, and go to state 45

    nonrem  go to state 46
    rem     go to state 47
    reg     go to state 48
    mem     go to state 49
    omem    go to state 50
    nmem    go to state 51
    nam     go to state 52
    con     go to state 53


state 7

   15 inst: LTYPE2 . rimnon
   35 rimnon: . rim ','
   36       | . rim
   63 rem: . reg
   64    | . mem
   72 rim: . rem
   73    | . imm
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   83 imm: . '$' con
   84    | . '$' nam
   85    | . '$' LSCONST
   86    | . '$' LFCONST
   87    | . '$' '(' LFCONST ')'
   88    | . '$' '(' '-' LFCONST ')'
   89    | . '$' '-' LFCONST
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '$'     shift, and go to state 54
    '~'     shift, and go to state 45

    rimnon  go to state 55
    rem     go to state 56
    rim     go to state 57
    reg     go to state 48
    imm     go to state 58
    mem     go to state 49
    omem    go to state 50
    nmem    go to state 51
    nam     go to state 52
    con     go to state 53


state 8

   16 inst: LTYPE3 . rimrem
   33 rimrem: . rim ',' rem
   63 rem: . reg
   64    | . mem
   72 rim: . rem
   73    | . imm
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   83 imm: . '$' con
   84    | . '$' nam
   85    | . '$' LSCONST
   86    | . '$' LFCONST
   87    | . '$' '(' LFCONST ')'
   88    | . '$' '(' '-' LFCONST ')'
   89    | . '$' '-' LFCONST
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '$'     shift, and go to state 54
    '~'     shift, and go to state 45

    rimrem  go to state 59
    rem     go to state 56
    rim     go to state 60
    reg     go to state 48
    imm     go to state 58
    mem     go to state 49
    omem    go to state 50
    nmem    go to state 51
    nam     go to state 52
    con     go to state 53


state 9

   17 inst: LTYPE4 . remrim
   34 remrim: . rem ',' rim
   63 rem: . reg
   64    | . mem
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '~'     shift, and go to state 45

    remrim  go to state 61
    rem     go to state 62
    reg     go to state 48
    mem     go to state 49
    omem    go to state 50
    nmem    go to state 51
    nam     go to state 52
    con     go to state 53


state 10

   21 inst: LTYPEC . spec3
   45 spec3: . ',' rom
   46      | . rom
   47      | . '*' nam
   65 rom: . rel
   66    | . nmem
   67    | . '*' reg
   68    | . '*' omem
   69    | . reg
   70    | . omem
   71    | . imm
   74 rel: . con '(' LPC ')'
   75    | . LNAME offset
   76    | . LLAB offset
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   83 imm: . '$' con
   84    | . '$' nam
   85    | . '$' LSCONST
   86    | . '$' LFCONST
   87    | . '$' '(' LFCONST ')'
   88    | . '$' '(' '-' LFCONST ')'
   89    | . '$' '-' LFCONST
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    '*'     shift, and go to state 63
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 64
    LLAB    shift, and go to state 65
    LVAR    shift, and go to state 42
    ','     shift, and go to state 66
    '('     shift, and go to state 44
    '$'     shift, and go to state 54
    '~'     shift, and go to state 45

    spec3  go to state 67
    rom    go to state 68
    rel    go to state 69
    reg    go to state 70
    imm    go to state 71
    omem   go to state 72
    nmem   go to state 73
    nam    go to state 52
    con    go to state 74


state 11

   19 inst: LTYPED . spec1
   42 spec1: . nam '/' con ',' imm
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'

    LNAME  shift, and go to state 41

    spec1  go to state 75
    nam    go to state 76


state 12

   22 inst: LTYPEN . spec4
   31 nonnon: .  [';']
   32       | . ','
   37 nonrem: . ',' rem
   38       | . rem
   48 spec4: . nonnon
   49      | . nonrem
   63 rem: . reg
   64    | . mem
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    ','     shift, and go to state 77
    '('     shift, and go to state 44
    '~'     shift, and go to state 45

    $default  reduce using rule 31 (nonnon)

    nonnon  go to state 78
    nonrem  go to state 79
    spec4   go to state 80
    rem     go to state 47
    reg     go to state 48
    mem     go to state 49
    omem    go to state 50
    nmem    go to state 51
    nam     go to state 52
    con     go to state 53


state 13

   18 inst: LTYPER . nonrel
   39 nonrel: . ',' rel
   40       | . rel
   41       | . imm ',' rel
   74 rel: . con '(' LPC ')'
   75    | . LNAME offset
   76    | . LLAB offset
   83 imm: . '$' con
   84    | . '$' nam
   85    | . '$' LSCONST
   86    | . '$' LFCONST
   87    | . '$' '(' LFCONST ')'
   88    | . '$' '(' '-' LFCONST ')'
   89    | . '$' '-' LFCONST
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LNAME   shift, and go to state 81
    LLAB    shift, and go to state 65
    LVAR    shift, and go to state 42
    ','     shift, and go to state 82
    '('     shift, and go to state 83
    '$'     shift, and go to state 54
    '~'     shift, and go to state 45

    nonrel  go to state 84
    rel     go to state 85
    imm     go to state 86
    con     go to state 87


state 14

   20 inst: LTYPET . spec2
   43 spec2: . mem ',' imm2
   44      | . mem ',' con ',' imm2
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '~'     shift, and go to state 45

    spec2  go to state 88
    mem    go to state 89
    omem   go to state 50
    nmem   go to state 51
    nam    go to state 52
    con    go to state 53


state 15

   23 inst: LTYPES . spec5
   50 spec5: . rim ',' rem
   51      | . rim ',' rem ':' LLREG
   63 rem: . reg
   64    | . mem
   72 rim: . rem
   73    | . imm
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   83 imm: . '$' con
   84    | . '$' nam
   85    | . '$' LSCONST
   86    | . '$' LFCONST
   87    | . '$' '(' LFCONST ')'
   88    | . '$' '(' '-' LFCONST ')'
   89    | . '$' '-' LFCONST
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '$'     shift, and go to state 54
    '~'     shift, and go to state 45

    spec5  go to state 90
    rem    go to state 56
    rim    go to state 91
    reg    go to state 48
    imm    go to state 58
    mem    go to state 49
    omem   go to state 50
    nmem   go to state 51
    nam    go to state 52
    con    go to state 53


state 16

   24 inst: LTYPEM . spec6
   52 spec6: . rim ',' rem
   53      | . rim ',' rem ':' LSREG
   63 rem: . reg
   64    | . mem
   72 rim: . rem
   73    | . imm
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   83 imm: . '$' con
   84    | . '$' nam
   85    | . '$' LSCONST
   86    | . '$' LFCONST
   87    | . '$' '(' LFCONST ')'
   88    | . '$' '(' '-' LFCONST ')'
   89    | . '$' '-' LFCONST
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '$'     shift, and go to state 54
    '~'     shift, and go to state 45

    spec6  go to state 92
    rem    go to state 56
    rim    go to state 93
    reg    go to state 48
    imm    go to state 58
    mem    go to state 49
    omem   go to state 50
    nmem   go to state 51
    nam    go to state 52
    con    go to state 53


state 17

   25 inst: LTYPEI . spec7
   54 spec7: . rim ','
   55      | . rim
   56      | . rim ',' rem
   63 rem: . reg
   64    | . mem
   72 rim: . rem
   73    | . imm
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   83 imm: . '$' con
   84    | . '$' nam
   85    | . '$' LSCONST
   86    | . '$' LFCONST
   87    | . '$' '(' LFCONST ')'
   88    | . '$' '(' '-' LFCONST ')'
   89    | . '$' '-' LFCONST
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '$'     shift, and go to state 54
    '~'     shift, and go to state 45

    spec7  go to state 94
    rem    go to state 56
    rim    go to state 95
    reg    go to state 48
    imm    go to state 58
    mem    go to state 49
    omem   go to state 50
    nmem   go to state 51
    nam    go to state 52
    con    go to state 53


state 18

   26 inst: LTYPEG . spec8
   57 spec8: . mem ',' imm
   58      | . mem ',' con ',' imm
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '~'     shift, and go to state 45

    spec8  go to state 96
    mem    go to state 97
    omem   go to state 50
    nmem   go to state 51
    nam    go to state 52
    con    go to state 53


state 19

   27 inst: LTYPEXC . spec9
   59 spec9: . reg ',' rem ',' con
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG

    LBREG  shift, and go to state 35
    LLREG  shift, and go to state 36
    LSREG  shift, and go to state 37
    LFREG  shift, and go to state 38
    LXREG  shift, and go to state 39
    LSP    shift, and go to state 40

    spec9  go to state 98
    reg    go to state 99


state 20

   28 inst: LTYPEX . spec10
   60 spec10: . imm ',' rem ',' reg
   83 imm: . '$' con
   84    | . '$' nam
   85    | . '$' LSCONST
   86    | . '$' LFCONST
   87    | . '$' '(' LFCONST ')'
   88    | . '$' '(' '-' LFCONST ')'
   89    | . '$' '-' LFCONST

    '$'  shift, and go to state 54

    spec10  go to state 100
    imm     go to state 101


state 21

   29 inst: LTYPEPC . spec11
   61 spec11: . rim ',' rim
   63 rem: . reg
   64    | . mem
   72 rim: . rem
   73    | . imm
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   83 imm: . '$' con
   84    | . '$' nam
   85    | . '$' LSCONST
   86    | . '$' LFCONST
   87    | . '$' '(' LFCONST ')'
   88    | . '$' '(' '-' LFCONST ')'
   89    | . '$' '-' LFCONST
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '$'     shift, and go to state 54
    '~'     shift, and go to state 45

    spec11  go to state 102
    rem     go to state 56
    rim     go to state 103
    reg     go to state 48
    imm     go to state 58
    mem     go to state 49
    omem    go to state 50
    nmem    go to state 51
    nam     go to state 52
    con     go to state 53


state 22

   30 inst: LTYPEF . spec12
   62 spec12: . rim ',' rim
   63 rem: . reg
   64    | . mem
   72 rim: . rem
   73    | . imm
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   83 imm: . '$' con
   84    | . '$' nam
   85    | . '$' LSCONST
   86    | . '$' LFCONST
   87    | . '$' '(' LFCONST ')'
   88    | . '$' '(' '-' LFCONST ')'
   89    | . '$' '-' LFCONST
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '$'     shift, and go to state 54
    '~'     shift, and go to state 45

    spec12  go to state 104
    rem     go to state 56
    rim     go to state 105
    reg     go to state 48
    imm     go to state 58
    mem     go to state 49
    omem    go to state 50
    nmem    go to state 51
    nam     go to state 52
    con     go to state 53


state 23

    7 line: LNAME . ':' $@3 line
   11 inst: LNAME . '=' expr

    ':'  shift, and go to state 106
    '='  shift, and go to state 107


state 24

    5 line: LLAB . ':' $@2 line

    ':'  shift, and go to state 108


state 25

   12 inst: LVAR . '=' expr

    '='  shift, and go to state 109


state 26

    8 line: ';' .

    $default  reduce using rule 8 (line)


state 27

    3 prog: prog $@1 line .

    $default  reduce using rule 3 (prog)


state 28

    9 line: inst . ';'

    ';'  shift, and go to state 110


state 29

   10 line: error ';' .

    $default  reduce using rule 10 (line)


state 30

   32 nonnon: ',' .

    $default  reduce using rule 32 (nonnon)


state 31

   13 inst: LTYPE0 nonnon .

    $default  reduce using rule 13 (inst)


state 32

  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  121    | '+' . con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con  go to state 111


state 33

  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  120    | '-' . con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con  go to state 112


state 34

  118 con: LCONST .

    $default  reduce using rule 118 (con)


state 35

   77 reg: LBREG .

    $default  reduce using rule 77 (reg)


state 36

   79 reg: LLREG .

    $default  reduce using rule 79 (reg)


state 37

   82 reg: LSREG .

    $default  reduce using rule 82 (reg)


state 38

   78 reg: LFREG .

    $default  reduce using rule 78 (reg)


state 39

   80 reg: LXREG .

    $default  reduce using rule 80 (reg)


state 40

   81 reg: LSP .

    $default  reduce using rule 81 (reg)


state 41

  110 nam: LNAME . offset '(' pointer ')'
  111    | LNAME . '<' '>' offset '(' LSB ')'
  112 offset: .  ['(']
  113       | . '+' con
  114       | . '-' con

    '<'  shift, and go to state 113
    '+'  shift, and go to state 114
    '-'  shift, and go to state 115

    $default  reduce using rule 112 (offset)

    offset  go to state 116


state 42

  119 con: LVAR .

    $default  reduce using rule 119 (con)


state 43

   37 nonrem: ',' . rem
   63 rem: . reg
   64    | . mem
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '~'     shift, and go to state 45

    rem   go to state 117
    reg   go to state 48
    mem   go to state 49
    omem  go to state 50
    nmem  go to state 51
    nam   go to state 52
    con   go to state 53


state 44

  103 omem: '(' . LLREG ')'
  104     | '(' . LSP ')'
  106     | '(' . LLREG '*' con ')'
  107     | '(' . LLREG ')' '(' LLREG '*' con ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'
  123    | '(' . expr ')'
  124 expr: . con
  125     | . expr '+' expr
  126     | . expr '-' expr
  127     | . expr '*' expr
  128     | . expr '/' expr
  129     | . expr '%' expr
  130     | . expr '<' '<' expr
  131     | . expr '>' '>' expr
  132     | . expr '&' expr
  133     | . expr '^' expr
  134     | . expr '|' expr

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LLREG   shift, and go to state 118
    LSP     shift, and go to state 119
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con   go to state 120
    expr  go to state 121


state 45

  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  122    | '~' . con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con  go to state 122


state 46

   14 inst: LTYPE1 nonrem .

    $default  reduce using rule 14 (inst)


state 47

   38 nonrem: rem .

    $default  reduce using rule 38 (nonrem)


state 48

   63 rem: reg .

    $default  reduce using rule 63 (rem)


state 49

   64 rem: mem .

    $default  reduce using rule 64 (rem)


state 50

   95 mem: omem .

    $default  reduce using rule 95 (mem)


state 51

   96 mem: nmem .

    $default  reduce using rule 96 (mem)


state 52

  108 nmem: nam .  [':', ';', ',']
  109     | nam . '(' LLREG '*' con ')'

    '('  shift, and go to state 123

    $default  reduce using rule 108 (nmem)


state 53

   97 omem: con .  [':', ';', ',']
   98     | con . '(' LLREG ')'
   99     | con . '(' LSP ')'
  100     | con . '(' LLREG '*' con ')'
  101     | con . '(' LLREG ')' '(' LLREG '*' con ')'
  102     | con . '(' LLREG ')' '(' LSREG '*' con ')'
  105     | con . '(' LSREG ')'

    '('  shift, and go to state 124

    $default  reduce using rule 97 (omem)


state 54

   83 imm: '$' . con
   84    | '$' . nam
   85    | '$' . LSCONST
   86    | '$' . LFCONST
   87    | '$' . '(' LFCONST ')'
   88    | '$' . '(' '-' LFCONST ')'
   89    | '$' . '-' LFCONST
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'      shift, and go to state 32
    '-'      shift, and go to state 125
    LCONST   shift, and go to state 34
    LFCONST  shift, and go to state 126
    LSCONST  shift, and go to state 127
    LNAME    shift, and go to state 41
    LVAR     shift, and go to state 42
    '('      shift, and go to state 128
    '~'      shift, and go to state 45

    nam  go to state 129
    con  go to state 130


state 55

   15 inst: LTYPE2 rimnon .

    $default  reduce using rule 15 (inst)


state 56

   72 rim: rem .

    $default  reduce using rule 72 (rim)


state 57

   35 rimnon: rim . ','
   36       | rim .  [';']

    ','  shift, and go to state 131

    $default  reduce using rule 36 (rimnon)


state 58

   73 rim: imm .

    $default  reduce using rule 73 (rim)


state 59

   16 inst: LTYPE3 rimrem .

    $default  reduce using rule 16 (inst)


state 60

   33 rimrem: rim . ',' rem

    ','  shift, and go to state 132


state 61

   17 inst: LTYPE4 remrim .

    $default  reduce using rule 17 (inst)


state 62

   34 remrim: rem . ',' rim

    ','  shift, and go to state 133


state 63

   47 spec3: '*' . nam
   67 rom: '*' . reg
   68    | '*' . omem
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '~'     shift, and go to state 45

    reg   go to state 134
    omem  go to state 135
    nam   go to state 136
    con   go to state 53


state 64

   75 rel: LNAME . offset
  110 nam: LNAME . offset '(' pointer ')'
  111    | LNAME . '<' '>' offset '(' LSB ')'
  112 offset: .  [';', '(']
  113       | . '+' con
  114       | . '-' con

    '<'  shift, and go to state 113
    '+'  shift, and go to state 114
    '-'  shift, and go to state 115

    $default  reduce using rule 112 (offset)

    offset  go to state 137


state 65

   76 rel: LLAB . offset
  112 offset: .  [';']
  113       | . '+' con
  114       | . '-' con

    '+'  shift, and go to state 114
    '-'  shift, and go to state 115

    $default  reduce using rule 112 (offset)

    offset  go to state 138


state 66

   45 spec3: ',' . rom
   65 rom: . rel
   66    | . nmem
   67    | . '*' reg
   68    | . '*' omem
   69    | . reg
   70    | . omem
   71    | . imm
   74 rel: . con '(' LPC ')'
   75    | . LNAME offset
   76    | . LLAB offset
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   83 imm: . '$' con
   84    | . '$' nam
   85    | . '$' LSCONST
   86    | . '$' LFCONST
   87    | . '$' '(' LFCONST ')'
   88    | . '$' '(' '-' LFCONST ')'
   89    | . '$' '-' LFCONST
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    '*'     shift, and go to state 139
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 64
    LLAB    shift, and go to state 65
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '$'     shift, and go to state 54
    '~'     shift, and go to state 45

    rom   go to state 140
    rel   go to state 69
    reg   go to state 70
    imm   go to state 71
    omem  go to state 72
    nmem  go to state 73
    nam   go to state 52
    con   go to state 74


state 67

   21 inst: LTYPEC spec3 .

    $default  reduce using rule 21 (inst)


state 68

   46 spec3: rom .

    $default  reduce using rule 46 (spec3)


state 69

   65 rom: rel .

    $default  reduce using rule 65 (rom)


state 70

   69 rom: reg .

    $default  reduce using rule 69 (rom)


state 71

   71 rom: imm .

    $default  reduce using rule 71 (rom)


state 72

   70 rom: omem .

    $default  reduce using rule 70 (rom)


state 73

   66 rom: nmem .

    $default  reduce using rule 66 (rom)


state 74

   74 rel: con . '(' LPC ')'
   97 omem: con .  [';']
   98     | con . '(' LLREG ')'
   99     | con . '(' LSP ')'
  100     | con . '(' LLREG '*' con ')'
  101     | con . '(' LLREG ')' '(' LLREG '*' con ')'
  102     | con . '(' LLREG ')' '(' LSREG '*' con ')'
  105     | con . '(' LSREG ')'

    '('  shift, and go to state 141

    $default  reduce using rule 97 (omem)


state 75

   19 inst: LTYPED spec1 .

    $default  reduce using rule 19 (inst)


state 76

   42 spec1: nam . '/' con ',' imm

    '/'  shift, and go to state 142


state 77

   32 nonnon: ',' .  [';']
   37 nonrem: ',' . rem
   63 rem: . reg
   64    | . mem
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '~'     shift, and go to state 45

    $default  reduce using rule 32 (nonnon)

    rem   go to state 117
    reg   go to state 48
    mem   go to state 49
    omem  go to state 50
    nmem  go to state 51
    nam   go to state 52
    con   go to state 53


state 78

   48 spec4: nonnon .

    $default  reduce using rule 48 (spec4)


state 79

   49 spec4: nonrem .

    $default  reduce using rule 49 (spec4)


state 80

   22 inst: LTYPEN spec4 .

    $default  reduce using rule 22 (inst)


state 81

   75 rel: LNAME . offset
  112 offset: .  [';']
  113       | . '+' con
  114       | . '-' con

    '+'  shift, and go to state 114
    '-'  shift, and go to state 115

    $default  reduce using rule 112 (offset)

    offset  go to state 143


state 82

   39 nonrel: ',' . rel
   74 rel: . con '(' LPC ')'
   75    | . LNAME offset
   76    | . LLAB offset
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LNAME   shift, and go to state 81
    LLAB    shift, and go to state 65
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    rel  go to state 144
    con  go to state 87


state 83

  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'
  123    | '(' . expr ')'
  124 expr: . con
  125     | . expr '+' expr
  126     | . expr '-' expr
  127     | . expr '*' expr
  128     | . expr '/' expr
  129     | . expr '%' expr
  130     | . expr '<' '<' expr
  131     | . expr '>' '>' expr
  132     | . expr '&' expr
  133     | . expr '^' expr
  134     | . expr '|' expr

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con   go to state 120
    expr  go to state 121


state 84

   18 inst: LTYPER nonrel .

    $default  reduce using rule 18 (inst)


state 85

   40 nonrel: rel .

    $default  reduce using rule 40 (nonrel)


state 86

   41 nonrel: imm . ',' rel

    ','  shift, and go to state 145


state 87

   74 rel: con . '(' LPC ')'

    '('  shift, and go to state 146


state 88

   20 inst: LTYPET spec2 .

    $default  reduce using rule 20 (inst)


state 89

   43 spec2: mem . ',' imm2
   44      | mem . ',' con ',' imm2

    ','  shift, and go to state 147


state 90

   23 inst: LTYPES spec5 .

    $default  reduce using rule 23 (inst)


state 91

   50 spec5: rim . ',' rem
   51      | rim . ',' rem ':' LLREG

    ','  shift, and go to state 148


state 92

   24 inst: LTYPEM spec6 .

    $default  reduce using rule 24 (inst)


state 93

   52 spec6: rim . ',' rem
   53      | rim . ',' rem ':' LSREG

    ','  shift, and go to state 149


state 94

   25 inst: LTYPEI spec7 .

    $default  reduce using rule 25 (inst)


state 95

   54 spec7: rim . ','
   55      | rim .  [';']
   56      | rim . ',' rem

    ','  shift, and go to state 150

    $default  reduce using rule 55 (spec7)


state 96

   26 inst: LTYPEG spec8 .

    $default  reduce using rule 26 (inst)


state 97

   57 spec8: mem . ',' imm
   58      | mem . ',' con ',' imm

    ','  shift, and go to state 151


state 98

   27 inst: LTYPEXC spec9 .

    $default  reduce using rule 27 (inst)


state 99

   59 spec9: reg . ',' rem ',' con

    ','  shift, and go to state 152


state 100

   28 inst: LTYPEX spec10 .

    $default  reduce using rule 28 (inst)


state 101

   60 spec10: imm . ',' rem ',' reg

    ','  shift, and go to state 153


state 102

   29 inst: LTYPEPC spec11 .

    $default  reduce using rule 29 (inst)


state 103

   61 spec11: rim . ',' rim

    ','  shift, and go to state 154


state 104

   30 inst: LTYPEF spec12 .

    $default  reduce using rule 30 (inst)


state 105

   62 spec12: rim . ',' rim

    ','  shift, and go to state 155


state 106

    6 $@3: .
    7 line: LNAME ':' . $@3 line

    $default  reduce using rule 6 ($@3)

    $@3  go to state 156


state 107

   11 inst: LNAME '=' . expr
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'
  124 expr: . con
  125     | . expr '+' expr
  126     | . expr '-' expr
  127     | . expr '*' expr
  128     | . expr '/' expr
  129     | . expr '%' expr
  130     | . expr '<' '<' expr
  131     | . expr '>' '>' expr
  132     | . expr '&' expr
  133     | . expr '^' expr
  134     | . expr '|' expr

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con   go to state 120
    expr  go to state 157


state 108

    4 $@2: .
    5 line: LLAB ':' . $@2 line

    $default  reduce using rule 4 ($@2)

    $@2  go to state 158


state 109

   12 inst: LVAR '=' . expr
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'
  124 expr: . con
  125     | . expr '+' expr
  126     | . expr '-' expr
  127     | . expr '*' expr
  128     | . expr '/' expr
  129     | . expr '%' expr
  130     | . expr '<' '<' expr
  131     | . expr '>' '>' expr
  132     | . expr '&' expr
  133     | . expr '^' expr
  134     | . expr '|' expr

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con   go to state 120
    expr  go to state 159


state 110

    9 line: inst ';' .

    $default  reduce using rule 9 (line)


state 111

  121 con: '+' con .

    $default  reduce using rule 121 (con)


state 112

  120 con: '-' con .

    $default  reduce using rule 120 (con)


state 113

  111 nam: LNAME '<' . '>' offset '(' LSB ')'

    '>'  shift, and go to state 160


state 114

  113 offset: '+' . con
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con  go to state 161


state 115

  114 offset: '-' . con
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con  go to state 162


state 116

  110 nam: LNAME offset . '(' pointer ')'

    '('  shift, and go to state 163


state 117

   37 nonrem: ',' rem .

    $default  reduce using rule 37 (nonrem)


state 118

  103 omem: '(' LLREG . ')'
  106     | '(' LLREG . '*' con ')'
  107     | '(' LLREG . ')' '(' LLREG '*' con ')'

    '*'  shift, and go to state 164
    ')'  shift, and go to state 165


state 119

  104 omem: '(' LSP . ')'

    ')'  shift, and go to state 166


state 120

  124 expr: con .

    $default  reduce using rule 124 (expr)


state 121

  123 con: '(' expr . ')'
  125 expr: expr . '+' expr
  126     | expr . '-' expr
  127     | expr . '*' expr
  128     | expr . '/' expr
  129     | expr . '%' expr
  130     | expr . '<' '<' expr
  131     | expr . '>' '>' expr
  132     | expr . '&' expr
  133     | expr . '^' expr
  134     | expr . '|' expr

    '|'  shift, and go to state 167
    '^'  shift, and go to state 168
    '&'  shift, and go to state 169
    '<'  shift, and go to state 170
    '>'  shift, and go to state 171
    '+'  shift, and go to state 172
    '-'  shift, and go to state 173
    '*'  shift, and go to state 174
    '/'  shift, and go to state 175
    '%'  shift, and go to state 176
    ')'  shift, and go to state 177


state 122

  122 con: '~' con .

    $default  reduce using rule 122 (con)


state 123

  109 nmem: nam '(' . LLREG '*' con ')'

    LLREG  shift, and go to state 178


state 124

   98 omem: con '(' . LLREG ')'
   99     | con '(' . LSP ')'
  100     | con '(' . LLREG '*' con ')'
  101     | con '(' . LLREG ')' '(' LLREG '*' con ')'
  102     | con '(' . LLREG ')' '(' LSREG '*' con ')'
  105     | con '(' . LSREG ')'

    LLREG  shift, and go to state 179
    LSREG  shift, and go to state 180
    LSP    shift, and go to state 181


state 125

   89 imm: '$' '-' . LFCONST
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  120    | '-' . con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'      shift, and go to state 32
    '-'      shift, and go to state 33
    LCONST   shift, and go to state 34
    LFCONST  shift, and go to state 182
    LVAR     shift, and go to state 42
    '('      shift, and go to state 83
    '~'      shift, and go to state 45

    con  go to state 112


state 126

   86 imm: '$' LFCONST .

    $default  reduce using rule 86 (imm)


state 127

   85 imm: '$' LSCONST .

    $default  reduce using rule 85 (imm)


state 128

   87 imm: '$' '(' . LFCONST ')'
   88    | '$' '(' . '-' LFCONST ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'
  123    | '(' . expr ')'
  124 expr: . con
  125     | . expr '+' expr
  126     | . expr '-' expr
  127     | . expr '*' expr
  128     | . expr '/' expr
  129     | . expr '%' expr
  130     | . expr '<' '<' expr
  131     | . expr '>' '>' expr
  132     | . expr '&' expr
  133     | . expr '^' expr
  134     | . expr '|' expr

    '+'      shift, and go to state 32
    '-'      shift, and go to state 183
    LCONST   shift, and go to state 34
    LFCONST  shift, and go to state 184
    LVAR     shift, and go to state 42
    '('      shift, and go to state 83
    '~'      shift, and go to state 45

    con   go to state 120
    expr  go to state 121


state 129

   84 imm: '$' nam .

    $default  reduce using rule 84 (imm)


state 130

   83 imm: '$' con .

    $default  reduce using rule 83 (imm)


state 131

   35 rimnon: rim ',' .

    $default  reduce using rule 35 (rimnon)


state 132

   33 rimrem: rim ',' . rem
   63 rem: . reg
   64    | . mem
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '~'     shift, and go to state 45

    rem   go to state 185
    reg   go to state 48
    mem   go to state 49
    omem  go to state 50
    nmem  go to state 51
    nam   go to state 52
    con   go to state 53


state 133

   34 remrim: rem ',' . rim
   63 rem: . reg
   64    | . mem
   72 rim: . rem
   73    | . imm
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   83 imm: . '$' con
   84    | . '$' nam
   85    | . '$' LSCONST
   86    | . '$' LFCONST
   87    | . '$' '(' LFCONST ')'
   88    | . '$' '(' '-' LFCONST ')'
   89    | . '$' '-' LFCONST
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '$'     shift, and go to state 54
    '~'     shift, and go to state 45

    rem   go to state 56
    rim   go to state 186
    reg   go to state 48
    imm   go to state 58
    mem   go to state 49
    omem  go to state 50
    nmem  go to state 51
    nam   go to state 52
    con   go to state 53


state 134

   67 rom: '*' reg .

    $default  reduce using rule 67 (rom)


state 135

   68 rom: '*' omem .

    $default  reduce using rule 68 (rom)


state 136

   47 spec3: '*' nam .

    $default  reduce using rule 47 (spec3)


state 137

   75 rel: LNAME offset .  [';']
  110 nam: LNAME offset . '(' pointer ')'

    '('  shift, and go to state 163

    $default  reduce using rule 75 (rel)


state 138

   76 rel: LLAB offset .

    $default  reduce using rule 76 (rel)


state 139

   67 rom: '*' . reg
   68    | '*' . omem
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '~'     shift, and go to state 45

    reg   go to state 134
    omem  go to state 135
    con   go to state 53


state 140

   45 spec3: ',' rom .

    $default  reduce using rule 45 (spec3)


state 141

   74 rel: con '(' . LPC ')'
   98 omem: con '(' . LLREG ')'
   99     | con '(' . LSP ')'
  100     | con '(' . LLREG '*' con ')'
  101     | con '(' . LLREG ')' '(' LLREG '*' con ')'
  102     | con '(' . LLREG ')' '(' LSREG '*' con ')'
  105     | con '(' . LSREG ')'

    LPC    shift, and go to state 187
    LLREG  shift, and go to state 179
    LSREG  shift, and go to state 180
    LSP    shift, and go to state 181


state 142

   42 spec1: nam '/' . con ',' imm
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con  go to state 188


state 143

   75 rel: LNAME offset .

    $default  reduce using rule 75 (rel)


state 144

   39 nonrel: ',' rel .

    $default  reduce using rule 39 (nonrel)


state 145

   41 nonrel: imm ',' . rel
   74 rel: . con '(' LPC ')'
   75    | . LNAME offset
   76    | . LLAB offset
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LNAME   shift, and go to state 81
    LLAB    shift, and go to state 65
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    rel  go to state 189
    con  go to state 87


state 146

   74 rel: con '(' . LPC ')'

    LPC  shift, and go to state 187


state 147

   43 spec2: mem ',' . imm2
   44      | mem ',' . con ',' imm2
   90 imm2: . '$' con2
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '$'     shift, and go to state 190
    '~'     shift, and go to state 45

    imm2  go to state 191
    con   go to state 192


state 148

   50 spec5: rim ',' . rem
   51      | rim ',' . rem ':' LLREG
   63 rem: . reg
   64    | . mem
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '~'     shift, and go to state 45

    rem   go to state 193
    reg   go to state 48
    mem   go to state 49
    omem  go to state 50
    nmem  go to state 51
    nam   go to state 52
    con   go to state 53


state 149

   52 spec6: rim ',' . rem
   53      | rim ',' . rem ':' LSREG
   63 rem: . reg
   64    | . mem
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '~'     shift, and go to state 45

    rem   go to state 194
    reg   go to state 48
    mem   go to state 49
    omem  go to state 50
    nmem  go to state 51
    nam   go to state 52
    con   go to state 53


state 150

   54 spec7: rim ',' .  [';']
   56      | rim ',' . rem
   63 rem: . reg
   64    | . mem
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '~'     shift, and go to state 45

    $default  reduce using rule 54 (spec7)

    rem   go to state 195
    reg   go to state 48
    mem   go to state 49
    omem  go to state 50
    nmem  go to state 51
    nam   go to state 52
    con   go to state 53


state 151

   57 spec8: mem ',' . imm
   58      | mem ',' . con ',' imm
   83 imm: . '$' con
   84    | . '$' nam
   85    | . '$' LSCONST
   86    | . '$' LFCONST
   87    | . '$' '(' LFCONST ')'
   88    | . '$' '(' '-' LFCONST ')'
   89    | . '$' '-' LFCONST
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '$'     shift, and go to state 54
    '~'     shift, and go to state 45

    imm  go to state 196
    con  go to state 197


state 152

   59 spec9: reg ',' . rem ',' con
   63 rem: . reg
   64    | . mem
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '~'     shift, and go to state 45

    rem   go to state 198
    reg   go to state 48
    mem   go to state 49
    omem  go to state 50
    nmem  go to state 51
    nam   go to state 52
    con   go to state 53


state 153

   60 spec10: imm ',' . rem ',' reg
   63 rem: . reg
   64    | . mem
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '~'     shift, and go to state 45

    rem   go to state 199
    reg   go to state 48
    mem   go to state 49
    omem  go to state 50
    nmem  go to state 51
    nam   go to state 52
    con   go to state 53


state 154

   61 spec11: rim ',' . rim
   63 rem: . reg
   64    | . mem
   72 rim: . rem
   73    | . imm
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   83 imm: . '$' con
   84    | . '$' nam
   85    | . '$' LSCONST
   86    | . '$' LFCONST
   87    | . '$' '(' LFCONST ')'
   88    | . '$' '(' '-' LFCONST ')'
   89    | . '$' '-' LFCONST
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '$'     shift, and go to state 54
    '~'     shift, and go to state 45

    rem   go to state 56
    rim   go to state 200
    reg   go to state 48
    imm   go to state 58
    mem   go to state 49
    omem  go to state 50
    nmem  go to state 51
    nam   go to state 52
    con   go to state 53


state 155

   62 spec12: rim ',' . rim
   63 rem: . reg
   64    | . mem
   72 rim: . rem
   73    | . imm
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG
   83 imm: . '$' con
   84    | . '$' nam
   85    | . '$' LSCONST
   86    | . '$' LFCONST
   87    | . '$' '(' LFCONST ')'
   88    | . '$' '(' '-' LFCONST ')'
   89    | . '$' '-' LFCONST
   95 mem: . omem
   96    | . nmem
   97 omem: . con
   98     | . con '(' LLREG ')'
   99     | . con '(' LSP ')'
  100     | . con '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  102     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  103     | . '(' LLREG ')'
  104     | . '(' LSP ')'
  105     | . con '(' LSREG ')'
  106     | . '(' LLREG '*' con ')'
  107     | . '(' LLREG ')' '(' LLREG '*' con ')'
  108 nmem: . nam
  109     | . nam '(' LLREG '*' con ')'
  110 nam: . LNAME offset '(' pointer ')'
  111    | . LNAME '<' '>' offset '(' LSB ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LBREG   shift, and go to state 35
    LLREG   shift, and go to state 36
    LSREG   shift, and go to state 37
    LFREG   shift, and go to state 38
    LXREG   shift, and go to state 39
    LSP     shift, and go to state 40
    LNAME   shift, and go to state 41
    LVAR    shift, and go to state 42
    '('     shift, and go to state 44
    '$'     shift, and go to state 54
    '~'     shift, and go to state 45

    rem   go to state 56
    rim   go to state 201
    reg   go to state 48
    imm   go to state 58
    mem   go to state 49
    omem  go to state 50
    nmem  go to state 51
    nam   go to state 52
    con   go to state 53


state 156

    5 line: . LLAB ':' $@2 line
    7     | . LNAME ':' $@3 line
    7     | LNAME ':' $@3 . line
    8     | . ';'
    9     | . inst ';'
   10     | . error ';'
   11 inst: . LNAME '=' expr
   12     | . LVAR '=' expr
   13     | . LTYPE0 nonnon
   14     | . LTYPE1 nonrem
   15     | . LTYPE2 rimnon
   16     | . LTYPE3 rimrem
   17     | . LTYPE4 remrim
   18     | . LTYPER nonrel
   19     | . LTYPED spec1
   20     | . LTYPET spec2
   21     | . LTYPEC spec3
   22     | . LTYPEN spec4
   23     | . LTYPES spec5
   24     | . LTYPEM spec6
   25     | . LTYPEI spec7
   26     | . LTYPEG spec8
   27     | . LTYPEXC spec9
   28     | . LTYPEX spec10
   29     | . LTYPEPC spec11
   30     | . LTYPEF spec12

    error    shift, and go to state 4
    LTYPE0   shift, and go to state 5
    LTYPE1   shift, and go to state 6
    LTYPE2   shift, and go to state 7
    LTYPE3   shift, and go to state 8
    LTYPE4   shift, and go to state 9
    LTYPEC   shift, and go to state 10
    LTYPED   shift, and go to state 11
    LTYPEN   shift, and go to state 12
    LTYPER   shift, and go to state 13
    LTYPET   shift, and go to state 14
    LTYPES   shift, and go to state 15
    LTYPEM   shift, and go to state 16
    LTYPEI   shift, and go to state 17
    LTYPEG   shift, and go to state 18
    LTYPEXC  shift, and go to state 19
    LTYPEX   shift, and go to state 20
    LTYPEPC  shift, and go to state 21
    LTYPEF   shift, and go to state 22
    LNAME    shift, and go to state 23
    LLAB     shift, and go to state 24
    LVAR     shift, and go to state 25
    ';'      shift, and go to state 26

    line  go to state 202
    inst  go to state 28


state 157

   11 inst: LNAME '=' expr .  [';']
  125 expr: expr . '+' expr
  126     | expr . '-' expr
  127     | expr . '*' expr
  128     | expr . '/' expr
  129     | expr . '%' expr
  130     | expr . '<' '<' expr
  131     | expr . '>' '>' expr
  132     | expr . '&' expr
  133     | expr . '^' expr
  134     | expr . '|' expr

    '|'  shift, and go to state 167
    '^'  shift, and go to state 168
    '&'  shift, and go to state 169
    '<'  shift, and go to state 170
    '>'  shift, and go to state 171
    '+'  shift, and go to state 172
    '-'  shift, and go to state 173
    '*'  shift, and go to state 174
    '/'  shift, and go to state 175
    '%'  shift, and go to state 176

    $default  reduce using rule 11 (inst)


state 158

    5 line: . LLAB ':' $@2 line
    5     | LLAB ':' $@2 . line
    7     | . LNAME ':' $@3 line
    8     | . ';'
    9     | . inst ';'
   10     | . error ';'
   11 inst: . LNAME '=' expr
   12     | . LVAR '=' expr
   13     | . LTYPE0 nonnon
   14     | . LTYPE1 nonrem
   15     | . LTYPE2 rimnon
   16     | . LTYPE3 rimrem
   17     | . LTYPE4 remrim
   18     | . LTYPER nonrel
   19     | . LTYPED spec1
   20     | . LTYPET spec2
   21     | . LTYPEC spec3
   22     | . LTYPEN spec4
   23     | . LTYPES spec5
   24     | . LTYPEM spec6
   25     | . LTYPEI spec7
   26     | . LTYPEG spec8
   27     | . LTYPEXC spec9
   28     | . LTYPEX spec10
   29     | . LTYPEPC spec11
   30     | . LTYPEF spec12

    error    shift, and go to state 4
    LTYPE0   shift, and go to state 5
    LTYPE1   shift, and go to state 6
    LTYPE2   shift, and go to state 7
    LTYPE3   shift, and go to state 8
    LTYPE4   shift, and go to state 9
    LTYPEC   shift, and go to state 10
    LTYPED   shift, and go to state 11
    LTYPEN   shift, and go to state 12
    LTYPER   shift, and go to state 13
    LTYPET   shift, and go to state 14
    LTYPES   shift, and go to state 15
    LTYPEM   shift, and go to state 16
    LTYPEI   shift, and go to state 17
    LTYPEG   shift, and go to state 18
    LTYPEXC  shift, and go to state 19
    LTYPEX   shift, and go to state 20
    LTYPEPC  shift, and go to state 21
    LTYPEF   shift, and go to state 22
    LNAME    shift, and go to state 23
    LLAB     shift, and go to state 24
    LVAR     shift, and go to state 25
    ';'      shift, and go to state 26

    line  go to state 203
    inst  go to state 28


state 159

   12 inst: LVAR '=' expr .  [';']
  125 expr: expr . '+' expr
  126     | expr . '-' expr
  127     | expr . '*' expr
  128     | expr . '/' expr
  129     | expr . '%' expr
  130     | expr . '<' '<' expr
  131     | expr . '>' '>' expr
  132     | expr . '&' expr
  133     | expr . '^' expr
  134     | expr . '|' expr

    '|'  shift, and go to state 167
    '^'  shift, and go to state 168
    '&'  shift, and go to state 169
    '<'  shift, and go to state 170
    '>'  shift, and go to state 171
    '+'  shift, and go to state 172
    '-'  shift, and go to state 173
    '*'  shift, and go to state 174
    '/'  shift, and go to state 175
    '%'  shift, and go to state 176

    $default  reduce using rule 12 (inst)


state 160

  111 nam: LNAME '<' '>' . offset '(' LSB ')'
  112 offset: .  ['(']
  113       | . '+' con
  114       | . '-' con

    '+'  shift, and go to state 114
    '-'  shift, and go to state 115

    $default  reduce using rule 112 (offset)

    offset  go to state 204


state 161

  113 offset: '+' con .

    $default  reduce using rule 113 (offset)


state 162

  114 offset: '-' con .

    $default  reduce using rule 114 (offset)


state 163

  110 nam: LNAME offset '(' . pointer ')'
  115 pointer: . LSB
  116        | . LSP
  117        | . LFP

    LFP  shift, and go to state 205
    LSB  shift, and go to state 206
    LSP  shift, and go to state 207

    pointer  go to state 208


state 164

  106 omem: '(' LLREG '*' . con ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con  go to state 209


state 165

  103 omem: '(' LLREG ')' .  [':', ';', ',']
  107     | '(' LLREG ')' . '(' LLREG '*' con ')'

    '('  shift, and go to state 210

    $default  reduce using rule 103 (omem)


state 166

  104 omem: '(' LSP ')' .

    $default  reduce using rule 104 (omem)


state 167

  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'
  124 expr: . con
  125     | . expr '+' expr
  126     | . expr '-' expr
  127     | . expr '*' expr
  128     | . expr '/' expr
  129     | . expr '%' expr
  130     | . expr '<' '<' expr
  131     | . expr '>' '>' expr
  132     | . expr '&' expr
  133     | . expr '^' expr
  134     | . expr '|' expr
  134     | expr '|' . expr

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con   go to state 120
    expr  go to state 211


state 168

  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'
  124 expr: . con
  125     | . expr '+' expr
  126     | . expr '-' expr
  127     | . expr '*' expr
  128     | . expr '/' expr
  129     | . expr '%' expr
  130     | . expr '<' '<' expr
  131     | . expr '>' '>' expr
  132     | . expr '&' expr
  133     | . expr '^' expr
  133     | expr '^' . expr
  134     | . expr '|' expr

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con   go to state 120
    expr  go to state 212


state 169

  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'
  124 expr: . con
  125     | . expr '+' expr
  126     | . expr '-' expr
  127     | . expr '*' expr
  128     | . expr '/' expr
  129     | . expr '%' expr
  130     | . expr '<' '<' expr
  131     | . expr '>' '>' expr
  132     | . expr '&' expr
  132     | expr '&' . expr
  133     | . expr '^' expr
  134     | . expr '|' expr

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con   go to state 120
    expr  go to state 213


state 170

  130 expr: expr '<' . '<' expr

    '<'  shift, and go to state 214


state 171

  131 expr: expr '>' . '>' expr

    '>'  shift, and go to state 215


state 172

  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'
  124 expr: . con
  125     | . expr '+' expr
  125     | expr '+' . expr
  126     | . expr '-' expr
  127     | . expr '*' expr
  128     | . expr '/' expr
  129     | . expr '%' expr
  130     | . expr '<' '<' expr
  131     | . expr '>' '>' expr
  132     | . expr '&' expr
  133     | . expr '^' expr
  134     | . expr '|' expr

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con   go to state 120
    expr  go to state 216


state 173

  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'
  124 expr: . con
  125     | . expr '+' expr
  126     | . expr '-' expr
  126     | expr '-' . expr
  127     | . expr '*' expr
  128     | . expr '/' expr
  129     | . expr '%' expr
  130     | . expr '<' '<' expr
  131     | . expr '>' '>' expr
  132     | . expr '&' expr
  133     | . expr '^' expr
  134     | . expr '|' expr

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con   go to state 120
    expr  go to state 217


state 174

  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'
  124 expr: . con
  125     | . expr '+' expr
  126     | . expr '-' expr
  127     | . expr '*' expr
  127     | expr '*' . expr
  128     | . expr '/' expr
  129     | . expr '%' expr
  130     | . expr '<' '<' expr
  131     | . expr '>' '>' expr
  132     | . expr '&' expr
  133     | . expr '^' expr
  134     | . expr '|' expr

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con   go to state 120
    expr  go to state 218


state 175

  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'
  124 expr: . con
  125     | . expr '+' expr
  126     | . expr '-' expr
  127     | . expr '*' expr
  128     | . expr '/' expr
  128     | expr '/' . expr
  129     | . expr '%' expr
  130     | . expr '<' '<' expr
  131     | . expr '>' '>' expr
  132     | . expr '&' expr
  133     | . expr '^' expr
  134     | . expr '|' expr

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con   go to state 120
    expr  go to state 219


state 176

  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'
  124 expr: . con
  125     | . expr '+' expr
  126     | . expr '-' expr
  127     | . expr '*' expr
  128     | . expr '/' expr
  129     | . expr '%' expr
  129     | expr '%' . expr
  130     | . expr '<' '<' expr
  131     | . expr '>' '>' expr
  132     | . expr '&' expr
  133     | . expr '^' expr
  134     | . expr '|' expr

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con   go to state 120
    expr  go to state 220


state 177

  123 con: '(' expr ')' .

    $default  reduce using rule 123 (con)


state 178

  109 nmem: nam '(' LLREG . '*' con ')'

    '*'  shift, and go to state 221


state 179

   98 omem: con '(' LLREG . ')'
  100     | con '(' LLREG . '*' con ')'
  101     | con '(' LLREG . ')' '(' LLREG '*' con ')'
  102     | con '(' LLREG . ')' '(' LSREG '*' con ')'

    '*'  shift, and go to state 222
    ')'  shift, and go to state 223


state 180

  105 omem: con '(' LSREG . ')'

    ')'  shift, and go to state 224


state 181

   99 omem: con '(' LSP . ')'

    ')'  shift, and go to state 225


state 182

   89 imm: '$' '-' LFCONST .

    $default  reduce using rule 89 (imm)


state 183

   88 imm: '$' '(' '-' . LFCONST ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  120    | '-' . con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'      shift, and go to state 32
    '-'      shift, and go to state 33
    LCONST   shift, and go to state 34
    LFCONST  shift, and go to state 226
    LVAR     shift, and go to state 42
    '('      shift, and go to state 83
    '~'      shift, and go to state 45

    con  go to state 112


state 184

   87 imm: '$' '(' LFCONST . ')'

    ')'  shift, and go to state 227


state 185

   33 rimrem: rim ',' rem .

    $default  reduce using rule 33 (rimrem)


state 186

   34 remrim: rem ',' rim .

    $default  reduce using rule 34 (remrim)


state 187

   74 rel: con '(' LPC . ')'

    ')'  shift, and go to state 228


state 188

   42 spec1: nam '/' con . ',' imm

    ','  shift, and go to state 229


state 189

   41 nonrel: imm ',' rel .

    $default  reduce using rule 41 (nonrel)


state 190

   90 imm2: '$' . con2
   91 con2: . LCONST
   92     | . '-' LCONST
   93     | . LCONST '-' LCONST
   94     | . '-' LCONST '-' LCONST

    '-'     shift, and go to state 230
    LCONST  shift, and go to state 231

    con2  go to state 232


state 191

   43 spec2: mem ',' imm2 .

    $default  reduce using rule 43 (spec2)


state 192

   44 spec2: mem ',' con . ',' imm2

    ','  shift, and go to state 233


state 193

   50 spec5: rim ',' rem .  [';']
   51      | rim ',' rem . ':' LLREG

    ':'  shift, and go to state 234

    $default  reduce using rule 50 (spec5)


state 194

   52 spec6: rim ',' rem .  [';']
   53      | rim ',' rem . ':' LSREG

    ':'  shift, and go to state 235

    $default  reduce using rule 52 (spec6)


state 195

   56 spec7: rim ',' rem .

    $default  reduce using rule 56 (spec7)


state 196

   57 spec8: mem ',' imm .

    $default  reduce using rule 57 (spec8)


state 197

   58 spec8: mem ',' con . ',' imm

    ','  shift, and go to state 236


state 198

   59 spec9: reg ',' rem . ',' con

    ','  shift, and go to state 237


state 199

   60 spec10: imm ',' rem . ',' reg

    ','  shift, and go to state 238


state 200

   61 spec11: rim ',' rim .

    $default  reduce using rule 61 (spec11)


state 201

   62 spec12: rim ',' rim .

    $default  reduce using rule 62 (spec12)


state 202

    7 line: LNAME ':' $@3 line .

    $default  reduce using rule 7 (line)


state 203

    5 line: LLAB ':' $@2 line .

    $default  reduce using rule 5 (line)


state 204

  111 nam: LNAME '<' '>' offset . '(' LSB ')'

    '('  shift, and go to state 239


state 205

  117 pointer: LFP .

    $default  reduce using rule 117 (pointer)


state 206

  115 pointer: LSB .

    $default  reduce using rule 115 (pointer)


state 207

  116 pointer: LSP .

    $default  reduce using rule 116 (pointer)


state 208

  110 nam: LNAME offset '(' pointer . ')'

    ')'  shift, and go to state 240


state 209

  106 omem: '(' LLREG '*' con . ')'

    ')'  shift, and go to state 241


state 210

  107 omem: '(' LLREG ')' '(' . LLREG '*' con ')'

    LLREG  shift, and go to state 242


state 211

  125 expr: expr . '+' expr
  126     | expr . '-' expr
  127     | expr . '*' expr
  128     | expr . '/' expr
  129     | expr . '%' expr
  130     | expr . '<' '<' expr
  131     | expr . '>' '>' expr
  132     | expr . '&' expr
  133     | expr . '^' expr
  134     | expr . '|' expr
  134     | expr '|' expr .  ['|', ';', ')']

    '^'  shift, and go to state 168
    '&'  shift, and go to state 169
    '<'  shift, and go to state 170
    '>'  shift, and go to state 171
    '+'  shift, and go to state 172
    '-'  shift, and go to state 173
    '*'  shift, and go to state 174
    '/'  shift, and go to state 175
    '%'  shift, and go to state 176

    $default  reduce using rule 134 (expr)

    Conflict between rule 134 and token '|' resolved as reduce (%left '|').
    Conflict between rule 134 and token '^' resolved as shift ('|' < '^').
    Conflict between rule 134 and token '&' resolved as shift ('|' < '&').
    Conflict between rule 134 and token '<' resolved as shift ('|' < '<').
    Conflict between rule 134 and token '>' resolved as shift ('|' < '>').
    Conflict between rule 134 and token '+' resolved as shift ('|' < '+').
    Conflict between rule 134 and token '-' resolved as shift ('|' < '-').
    Conflict between rule 134 and token '*' resolved as shift ('|' < '*').
    Conflict between rule 134 and token '/' resolved as shift ('|' < '/').
    Conflict between rule 134 and token '%' resolved as shift ('|' < '%').


state 212

  125 expr: expr . '+' expr
  126     | expr . '-' expr
  127     | expr . '*' expr
  128     | expr . '/' expr
  129     | expr . '%' expr
  130     | expr . '<' '<' expr
  131     | expr . '>' '>' expr
  132     | expr . '&' expr
  133     | expr . '^' expr
  133     | expr '^' expr .  ['|', '^', ';', ')']
  134     | expr . '|' expr

    '&'  shift, and go to state 169
    '<'  shift, and go to state 170
    '>'  shift, and go to state 171
    '+'  shift, and go to state 172
    '-'  shift, and go to state 173
    '*'  shift, and go to state 174
    '/'  shift, and go to state 175
    '%'  shift, and go to state 176

    $default  reduce using rule 133 (expr)

    Conflict between rule 133 and token '|' resolved as reduce ('|' < '^').
    Conflict between rule 133 and token '^' resolved as reduce (%left '^').
    Conflict between rule 133 and token '&' resolved as shift ('^' < '&').
    Conflict between rule 133 and token '<' resolved as shift ('^' < '<').
    Conflict between rule 133 and token '>' resolved as shift ('^' < '>').
    Conflict between rule 133 and token '+' resolved as shift ('^' < '+').
    Conflict between rule 133 and token '-' resolved as shift ('^' < '-').
    Conflict between rule 133 and token '*' resolved as shift ('^' < '*').
    Conflict between rule 133 and token '/' resolved as shift ('^' < '/').
    Conflict between rule 133 and token '%' resolved as shift ('^' < '%').


state 213

  125 expr: expr . '+' expr
  126     | expr . '-' expr
  127     | expr . '*' expr
  128     | expr . '/' expr
  129     | expr . '%' expr
  130     | expr . '<' '<' expr
  131     | expr . '>' '>' expr
  132     | expr . '&' expr
  132     | expr '&' expr .  ['|', '^', '&', ';', ')']
  133     | expr . '^' expr
  134     | expr . '|' expr

    '<'  shift, and go to state 170
    '>'  shift, and go to state 171
    '+'  shift, and go to state 172
    '-'  shift, and go to state 173
    '*'  shift, and go to state 174
    '/'  shift, and go to state 175
    '%'  shift, and go to state 176

    $default  reduce using rule 132 (expr)

    Conflict between rule 132 and token '|' resolved as reduce ('|' < '&').
    Conflict between rule 132 and token '^' resolved as reduce ('^' < '&').
    Conflict between rule 132 and token '&' resolved as reduce (%left '&').
    Conflict between rule 132 and token '<' resolved as shift ('&' < '<').
    Conflict between rule 132 and token '>' resolved as shift ('&' < '>').
    Conflict between rule 132 and token '+' resolved as shift ('&' < '+').
    Conflict between rule 132 and token '-' resolved as shift ('&' < '-').
    Conflict between rule 132 and token '*' resolved as shift ('&' < '*').
    Conflict between rule 132 and token '/' resolved as shift ('&' < '/').
    Conflict between rule 132 and token '%' resolved as shift ('&' < '%').


state 214

  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'
  124 expr: . con
  125     | . expr '+' expr
  126     | . expr '-' expr
  127     | . expr '*' expr
  128     | . expr '/' expr
  129     | . expr '%' expr
  130     | . expr '<' '<' expr
  130     | expr '<' '<' . expr
  131     | . expr '>' '>' expr
  132     | . expr '&' expr
  133     | . expr '^' expr
  134     | . expr '|' expr

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con   go to state 120
    expr  go to state 243


state 215

  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'
  124 expr: . con
  125     | . expr '+' expr
  126     | . expr '-' expr
  127     | . expr '*' expr
  128     | . expr '/' expr
  129     | . expr '%' expr
  130     | . expr '<' '<' expr
  131     | . expr '>' '>' expr
  131     | expr '>' '>' . expr
  132     | . expr '&' expr
  133     | . expr '^' expr
  134     | . expr '|' expr

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con   go to state 120
    expr  go to state 244


state 216

  125 expr: expr . '+' expr
  125     | expr '+' expr .  ['|', '^', '&', '<', '>', '+', '-', ';', ')']
  126     | expr . '-' expr
  127     | expr . '*' expr
  128     | expr . '/' expr
  129     | expr . '%' expr
  130     | expr . '<' '<' expr
  131     | expr . '>' '>' expr
  132     | expr . '&' expr
  133     | expr . '^' expr
  134     | expr . '|' expr

    '*'  shift, and go to state 174
    '/'  shift, and go to state 175
    '%'  shift, and go to state 176

    $default  reduce using rule 125 (expr)

    Conflict between rule 125 and token '|' resolved as reduce ('|' < '+').
    Conflict between rule 125 and token '^' resolved as reduce ('^' < '+').
    Conflict between rule 125 and token '&' resolved as reduce ('&' < '+').
    Conflict between rule 125 and token '<' resolved as reduce ('<' < '+').
    Conflict between rule 125 and token '>' resolved as reduce ('>' < '+').
    Conflict between rule 125 and token '+' resolved as reduce (%left '+').
    Conflict between rule 125 and token '-' resolved as reduce (%left '-').
    Conflict between rule 125 and token '*' resolved as shift ('+' < '*').
    Conflict between rule 125 and token '/' resolved as shift ('+' < '/').
    Conflict between rule 125 and token '%' resolved as shift ('+' < '%').


state 217

  125 expr: expr . '+' expr
  126     | expr . '-' expr
  126     | expr '-' expr .  ['|', '^', '&', '<', '>', '+', '-', ';', ')']
  127     | expr . '*' expr
  128     | expr . '/' expr
  129     | expr . '%' expr
  130     | expr . '<' '<' expr
  131     | expr . '>' '>' expr
  132     | expr . '&' expr
  133     | expr . '^' expr
  134     | expr . '|' expr

    '*'  shift, and go to state 174
    '/'  shift, and go to state 175
    '%'  shift, and go to state 176

    $default  reduce using rule 126 (expr)

    Conflict between rule 126 and token '|' resolved as reduce ('|' < '-').
    Conflict between rule 126 and token '^' resolved as reduce ('^' < '-').
    Conflict between rule 126 and token '&' resolved as reduce ('&' < '-').
    Conflict between rule 126 and token '<' resolved as reduce ('<' < '-').
    Conflict between rule 126 and token '>' resolved as reduce ('>' < '-').
    Conflict between rule 126 and token '+' resolved as reduce (%left '+').
    Conflict between rule 126 and token '-' resolved as reduce (%left '-').
    Conflict between rule 126 and token '*' resolved as shift ('-' < '*').
    Conflict between rule 126 and token '/' resolved as shift ('-' < '/').
    Conflict between rule 126 and token '%' resolved as shift ('-' < '%').


state 218

  125 expr: expr . '+' expr
  126     | expr . '-' expr
  127     | expr . '*' expr
  127     | expr '*' expr .  ['|', '^', '&', '<', '>', '+', '-', '*', '/', '%', ';', ')']
  128     | expr . '/' expr
  129     | expr . '%' expr
  130     | expr . '<' '<' expr
  131     | expr . '>' '>' expr
  132     | expr . '&' expr
  133     | expr . '^' expr
  134     | expr . '|' expr

    $default  reduce using rule 127 (expr)

    Conflict between rule 127 and token '|' resolved as reduce ('|' < '*').
    Conflict between rule 127 and token '^' resolved as reduce ('^' < '*').
    Conflict between rule 127 and token '&' resolved as reduce ('&' < '*').
    Conflict between rule 127 and token '<' resolved as reduce ('<' < '*').
    Conflict between rule 127 and token '>' resolved as reduce ('>' < '*').
    Conflict between rule 127 and token '+' resolved as reduce ('+' < '*').
    Conflict between rule 127 and token '-' resolved as reduce ('-' < '*').
    Conflict between rule 127 and token '*' resolved as reduce (%left '*').
    Conflict between rule 127 and token '/' resolved as reduce (%left '/').
    Conflict between rule 127 and token '%' resolved as reduce (%left '%').


state 219

  125 expr: expr . '+' expr
  126     | expr . '-' expr
  127     | expr . '*' expr
  128     | expr . '/' expr
  128     | expr '/' expr .  ['|', '^', '&', '<', '>', '+', '-', '*', '/', '%', ';', ')']
  129     | expr . '%' expr
  130     | expr . '<' '<' expr
  131     | expr . '>' '>' expr
  132     | expr . '&' expr
  133     | expr . '^' expr
  134     | expr . '|' expr

    $default  reduce using rule 128 (expr)

    Conflict between rule 128 and token '|' resolved as reduce ('|' < '/').
    Conflict between rule 128 and token '^' resolved as reduce ('^' < '/').
    Conflict between rule 128 and token '&' resolved as reduce ('&' < '/').
    Conflict between rule 128 and token '<' resolved as reduce ('<' < '/').
    Conflict between rule 128 and token '>' resolved as reduce ('>' < '/').
    Conflict between rule 128 and token '+' resolved as reduce ('+' < '/').
    Conflict between rule 128 and token '-' resolved as reduce ('-' < '/').
    Conflict between rule 128 and token '*' resolved as reduce (%left '*').
    Conflict between rule 128 and token '/' resolved as reduce (%left '/').
    Conflict between rule 128 and token '%' resolved as reduce (%left '%').


state 220

  125 expr: expr . '+' expr
  126     | expr . '-' expr
  127     | expr . '*' expr
  128     | expr . '/' expr
  129     | expr . '%' expr
  129     | expr '%' expr .  ['|', '^', '&', '<', '>', '+', '-', '*', '/', '%', ';', ')']
  130     | expr . '<' '<' expr
  131     | expr . '>' '>' expr
  132     | expr . '&' expr
  133     | expr . '^' expr
  134     | expr . '|' expr

    $default  reduce using rule 129 (expr)

    Conflict between rule 129 and token '|' resolved as reduce ('|' < '%').
    Conflict between rule 129 and token '^' resolved as reduce ('^' < '%').
    Conflict between rule 129 and token '&' resolved as reduce ('&' < '%').
    Conflict between rule 129 and token '<' resolved as reduce ('<' < '%').
    Conflict between rule 129 and token '>' resolved as reduce ('>' < '%').
    Conflict between rule 129 and token '+' resolved as reduce ('+' < '%').
    Conflict between rule 129 and token '-' resolved as reduce ('-' < '%').
    Conflict between rule 129 and token '*' resolved as reduce (%left '*').
    Conflict between rule 129 and token '/' resolved as reduce (%left '/').
    Conflict between rule 129 and token '%' resolved as reduce (%left '%').


state 221

  109 nmem: nam '(' LLREG '*' . con ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con  go to state 245


state 222

  100 omem: con '(' LLREG '*' . con ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con  go to state 246


state 223

   98 omem: con '(' LLREG ')' .  [':', ';', ',']
  101     | con '(' LLREG ')' . '(' LLREG '*' con ')'
  102     | con '(' LLREG ')' . '(' LSREG '*' con ')'

    '('  shift, and go to state 247

    $default  reduce using rule 98 (omem)


state 224

  105 omem: con '(' LSREG ')' .

    $default  reduce using rule 105 (omem)


state 225

   99 omem: con '(' LSP ')' .

    $default  reduce using rule 99 (omem)


state 226

   88 imm: '$' '(' '-' LFCONST . ')'

    ')'  shift, and go to state 248


state 227

   87 imm: '$' '(' LFCONST ')' .

    $default  reduce using rule 87 (imm)


state 228

   74 rel: con '(' LPC ')' .

    $default  reduce using rule 74 (rel)


state 229

   42 spec1: nam '/' con ',' . imm
   83 imm: . '$' con
   84    | . '$' nam
   85    | . '$' LSCONST
   86    | . '$' LFCONST
   87    | . '$' '(' LFCONST ')'
   88    | . '$' '(' '-' LFCONST ')'
   89    | . '$' '-' LFCONST

    '$'  shift, and go to state 54

    imm  go to state 249


state 230

   92 con2: '-' . LCONST
   94     | '-' . LCONST '-' LCONST

    LCONST  shift, and go to state 250


state 231

   91 con2: LCONST .  [';']
   93     | LCONST . '-' LCONST

    '-'  shift, and go to state 251

    $default  reduce using rule 91 (con2)


state 232

   90 imm2: '$' con2 .

    $default  reduce using rule 90 (imm2)


state 233

   44 spec2: mem ',' con ',' . imm2
   90 imm2: . '$' con2

    '$'  shift, and go to state 190

    imm2  go to state 252


state 234

   51 spec5: rim ',' rem ':' . LLREG

    LLREG  shift, and go to state 253


state 235

   53 spec6: rim ',' rem ':' . LSREG

    LSREG  shift, and go to state 254


state 236

   58 spec8: mem ',' con ',' . imm
   83 imm: . '$' con
   84    | . '$' nam
   85    | . '$' LSCONST
   86    | . '$' LFCONST
   87    | . '$' '(' LFCONST ')'
   88    | . '$' '(' '-' LFCONST ')'
   89    | . '$' '-' LFCONST

    '$'  shift, and go to state 54

    imm  go to state 255


state 237

   59 spec9: reg ',' rem ',' . con
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con  go to state 256


state 238

   60 spec10: imm ',' rem ',' . reg
   77 reg: . LBREG
   78    | . LFREG
   79    | . LLREG
   80    | . LXREG
   81    | . LSP
   82    | . LSREG

    LBREG  shift, and go to state 35
    LLREG  shift, and go to state 36
    LSREG  shift, and go to state 37
    LFREG  shift, and go to state 38
    LXREG  shift, and go to state 39
    LSP    shift, and go to state 40

    reg  go to state 257


state 239

  111 nam: LNAME '<' '>' offset '(' . LSB ')'

    LSB  shift, and go to state 258


state 240

  110 nam: LNAME offset '(' pointer ')' .

    $default  reduce using rule 110 (nam)


state 241

  106 omem: '(' LLREG '*' con ')' .

    $default  reduce using rule 106 (omem)


state 242

  107 omem: '(' LLREG ')' '(' LLREG . '*' con ')'

    '*'  shift, and go to state 259


state 243

  125 expr: expr . '+' expr
  126     | expr . '-' expr
  127     | expr . '*' expr
  128     | expr . '/' expr
  129     | expr . '%' expr
  130     | expr . '<' '<' expr
  130     | expr '<' '<' expr .  ['|', '^', '&', '<', '>', ';', ')']
  131     | expr . '>' '>' expr
  132     | expr . '&' expr
  133     | expr . '^' expr
  134     | expr . '|' expr

    '+'  shift, and go to state 172
    '-'  shift, and go to state 173
    '*'  shift, and go to state 174
    '/'  shift, and go to state 175
    '%'  shift, and go to state 176

    $default  reduce using rule 130 (expr)

    Conflict between rule 130 and token '|' resolved as reduce ('|' < '<').
    Conflict between rule 130 and token '^' resolved as reduce ('^' < '<').
    Conflict between rule 130 and token '&' resolved as reduce ('&' < '<').
    Conflict between rule 130 and token '<' resolved as reduce (%left '<').
    Conflict between rule 130 and token '>' resolved as reduce (%left '>').
    Conflict between rule 130 and token '+' resolved as shift ('<' < '+').
    Conflict between rule 130 and token '-' resolved as shift ('<' < '-').
    Conflict between rule 130 and token '*' resolved as shift ('<' < '*').
    Conflict between rule 130 and token '/' resolved as shift ('<' < '/').
    Conflict between rule 130 and token '%' resolved as shift ('<' < '%').


state 244

  125 expr: expr . '+' expr
  126     | expr . '-' expr
  127     | expr . '*' expr
  128     | expr . '/' expr
  129     | expr . '%' expr
  130     | expr . '<' '<' expr
  131     | expr . '>' '>' expr
  131     | expr '>' '>' expr .  ['|', '^', '&', '<', '>', ';', ')']
  132     | expr . '&' expr
  133     | expr . '^' expr
  134     | expr . '|' expr

    '+'  shift, and go to state 172
    '-'  shift, and go to state 173
    '*'  shift, and go to state 174
    '/'  shift, and go to state 175
    '%'  shift, and go to state 176

    $default  reduce using rule 131 (expr)

    Conflict between rule 131 and token '|' resolved as reduce ('|' < '>').
    Conflict between rule 131 and token '^' resolved as reduce ('^' < '>').
    Conflict between rule 131 and token '&' resolved as reduce ('&' < '>').
    Conflict between rule 131 and token '<' resolved as reduce (%left '<').
    Conflict between rule 131 and token '>' resolved as reduce (%left '>').
    Conflict between rule 131 and token '+' resolved as shift ('>' < '+').
    Conflict between rule 131 and token '-' resolved as shift ('>' < '-').
    Conflict between rule 131 and token '*' resolved as shift ('>' < '*').
    Conflict between rule 131 and token '/' resolved as shift ('>' < '/').
    Conflict between rule 131 and token '%' resolved as shift ('>' < '%').


state 245

  109 nmem: nam '(' LLREG '*' con . ')'

    ')'  shift, and go to state 260


state 246

  100 omem: con '(' LLREG '*' con . ')'

    ')'  shift, and go to state 261


state 247

  101 omem: con '(' LLREG ')' '(' . LLREG '*' con ')'
  102     | con '(' LLREG ')' '(' . LSREG '*' con ')'

    LLREG  shift, and go to state 262
    LSREG  shift, and go to state 263


state 248

   88 imm: '$' '(' '-' LFCONST ')' .

    $default  reduce using rule 88 (imm)


state 249

   42 spec1: nam '/' con ',' imm .

    $default  reduce using rule 42 (spec1)


state 250

   92 con2: '-' LCONST .  [';']
   94     | '-' LCONST . '-' LCONST

    '-'  shift, and go to state 264

    $default  reduce using rule 92 (con2)


state 251

   93 con2: LCONST '-' . LCONST

    LCONST  shift, and go to state 265


state 252

   44 spec2: mem ',' con ',' imm2 .

    $default  reduce using rule 44 (spec2)


state 253

   51 spec5: rim ',' rem ':' LLREG .

    $default  reduce using rule 51 (spec5)


state 254

   53 spec6: rim ',' rem ':' LSREG .

    $default  reduce using rule 53 (spec6)


state 255

   58 spec8: mem ',' con ',' imm .

    $default  reduce using rule 58 (spec8)


state 256

   59 spec9: reg ',' rem ',' con .

    $default  reduce using rule 59 (spec9)


state 257

   60 spec10: imm ',' rem ',' reg .

    $default  reduce using rule 60 (spec10)


state 258

  111 nam: LNAME '<' '>' offset '(' LSB . ')'

    ')'  shift, and go to state 266


state 259

  107 omem: '(' LLREG ')' '(' LLREG '*' . con ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con  go to state 267


state 260

  109 nmem: nam '(' LLREG '*' con ')' .

    $default  reduce using rule 109 (nmem)


state 261

  100 omem: con '(' LLREG '*' con ')' .

    $default  reduce using rule 100 (omem)


state 262

  101 omem: con '(' LLREG ')' '(' LLREG . '*' con ')'

    '*'  shift, and go to state 268


state 263

  102 omem: con '(' LLREG ')' '(' LSREG . '*' con ')'

    '*'  shift, and go to state 269


state 264

   94 con2: '-' LCONST '-' . LCONST

    LCONST  shift, and go to state 270


state 265

   93 con2: LCONST '-' LCONST .

    $default  reduce using rule 93 (con2)


state 266

  111 nam: LNAME '<' '>' offset '(' LSB ')' .

    $default  reduce using rule 111 (nam)


state 267

  107 omem: '(' LLREG ')' '(' LLREG '*' con . ')'

    ')'  shift, and go to state 271


state 268

  101 omem: con '(' LLREG ')' '(' LLREG '*' . con ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con  go to state 272


state 269

  102 omem: con '(' LLREG ')' '(' LSREG '*' . con ')'
  118 con: . LCONST
  119    | . LVAR
  120    | . '-' con
  121    | . '+' con
  122    | . '~' con
  123    | . '(' expr ')'

    '+'     shift, and go to state 32
    '-'     shift, and go to state 33
    LCONST  shift, and go to state 34
    LVAR    shift, and go to state 42
    '('     shift, and go to state 83
    '~'     shift, and go to state 45

    con  go to state 273


state 270

   94 con2: '-' LCONST '-' LCONST .

    $default  reduce using rule 94 (con2)


state 271

  107 omem: '(' LLREG ')' '(' LLREG '*' con ')' .

    $default  reduce using rule 107 (omem)


state 272

  101 omem: con '(' LLREG ')' '(' LLREG '*' con . ')'

    ')'  shift, and go to state 274


state 273

  102 omem: con '(' LLREG ')' '(' LSREG '*' con . ')'

    ')'  shift, and go to state 275


state 274

  101 omem: con '(' LLREG ')' '(' LLREG '*' con ')' .

    $default  reduce using rule 101 (omem)


state 275

  102 omem: con '(' LLREG ')' '(' LSREG '*' con ')' .

    $default  reduce using rule 102 (omem)
