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
   26     | LTYPEXC spec8
   27     | LTYPEX spec9
   28     | LTYPERT spec10
   29     | LTYPEG spec11
   30     | LTYPEPC spec12
   31     | LTYPEF spec13

   32 nonnon: /* empty */
   33       | ','

   34 rimrem: rim ',' rem

   35 remrim: rem ',' rim

   36 rimnon: rim ','
   37       | rim

   38 nonrem: ',' rem
   39       | rem

   40 nonrel: ',' rel
   41       | rel
   42       | imm ',' rel

   43 spec1: nam '/' con ',' imm

   44 spec2: mem ',' imm2
   45      | mem ',' con ',' imm2

   46 spec3: ',' rom
   47      | rom

   48 spec4: nonnon
   49      | nonrem

   50 spec5: rim ',' rem
   51      | rim ',' rem ':' LLREG

   52 spec6: rim ',' rem
   53      | rim ',' rem ':' LSREG

   54 spec7: rim ','
   55      | rim
   56      | rim ',' rem

   57 spec8: reg ',' rem ',' con

   58 spec9: imm ',' rem ',' reg

   59 spec10: /* empty */
   60       | imm

   61 spec11: mem ',' imm
   62       | mem ',' con ',' imm

   63 spec12: rim ',' rim

   64 spec13: rim ',' rim

   65 rem: reg
   66    | mem

   67 rom: rel
   68    | nmem
   69    | '*' reg
   70    | '*' omem
   71    | reg
   72    | omem

   73 rim: rem
   74    | imm

   75 rel: con '(' LPC ')'
   76    | LNAME offset
   77    | LLAB offset

   78 reg: LBREG
   79    | LFREG
   80    | LLREG
   81    | LMREG
   82    | LSP
   83    | LSREG
   84    | LXREG

   85 imm2: '$' con2

   86 imm: '$' con
   87    | '$' nam
   88    | '$' LSCONST
   89    | '$' LFCONST
   90    | '$' '(' LFCONST ')'
   91    | '$' '(' '-' LFCONST ')'
   92    | '$' '-' LFCONST

   93 mem: omem
   94    | nmem

   95 omem: con
   96     | con '(' LLREG ')'
   97     | con '(' LSP ')'
   98     | con '(' LSREG ')'
   99     | con '(' LLREG '*' con ')'
  100     | con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | '(' LLREG ')'
  103     | '(' LSP ')'
  104     | '(' LLREG '*' con ')'
  105     | '(' LLREG ')' '(' LLREG '*' con ')'

  106 nmem: nam
  107     | nam '(' LLREG '*' con ')'

  108 nam: LNAME offset '(' pointer ')'
  109    | LNAME '<' '>' offset '(' LSB ')'

  110 offset: /* empty */
  111       | '+' con
  112       | '-' con

  113 pointer: LSB
  114        | LSP
  115        | LFP

  116 con: LCONST
  117    | LVAR
  118    | '-' con
  119    | '+' con
  120    | '~' con
  121    | '(' expr ')'

  122 con2: LCONST
  123     | '-' LCONST
  124     | LCONST '-' LCONST
  125     | '-' LCONST '-' LCONST

  126 expr: con
  127     | expr '+' expr
  128     | expr '-' expr
  129     | expr '*' expr
  130     | expr '/' expr
  131     | expr '%' expr
  132     | expr '<' '<' expr
  133     | expr '>' '>' expr
  134     | expr '&' expr
  135     | expr '^' expr
  136     | expr '|' expr


Terminals, with rules where they appear

$end (0) 0
'$' (36) 85 86 87 88 89 90 91 92
'%' (37) 131
'&' (38) 134
'(' (40) 75 90 91 96 97 98 99 100 101 102 103 104 105 107 108 109 121
')' (41) 75 90 91 96 97 98 99 100 101 102 103 104 105 107 108 109 121
'*' (42) 69 70 99 100 101 104 105 107 129
'+' (43) 111 119 127
',' (44) 33 34 35 36 38 40 42 43 44 45 46 50 51 52 53 54 56 57 58 61
    62 63 64
'-' (45) 91 92 112 118 123 124 125 128
'/' (47) 43 130
':' (58) 5 7 51 53
';' (59) 8 9 10
'<' (60) 109 132
'=' (61) 11 12
'>' (62) 109 133
'^' (94) 135
'|' (124) 136
'~' (126) 120
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
LTYPEG (268) 29
LTYPEPC (269) 30
LTYPES (270) 23
LTYPEM (271) 24
LTYPEI (272) 25
LTYPEXC (273) 26
LTYPEX (274) 27
LTYPERT (275) 28
LTYPEF (276) 31
LCONST (277) 116 122 123 124 125
LFP (278) 115
LPC (279) 75
LSB (280) 109 113
LBREG (281) 78
LLREG (282) 51 80 96 99 100 101 102 104 105 107
LSREG (283) 53 83 98 101
LFREG (284) 79
LMREG (285) 81
LXREG (286) 84
LFCONST (287) 89 90 91 92
LSCONST (288) 88
LSP (289) 82 97 103 114
LNAME (290) 7 11 76 108 109
LLAB (291) 5 77
LVAR (292) 12 117


Nonterminals, with rules where they appear

$accept (56)
    on left: 0
prog (57)
    on left: 1 3, on right: 0 3
$@1 (58)
    on left: 2, on right: 3
line (59)
    on left: 5 7 8 9 10, on right: 3 5 7
$@2 (60)
    on left: 4, on right: 5
$@3 (61)
    on left: 6, on right: 7
inst (62)
    on left: 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28
    29 30 31, on right: 9
nonnon (63)
    on left: 32 33, on right: 13 48
rimrem (64)
    on left: 34, on right: 16
remrim (65)
    on left: 35, on right: 17
rimnon (66)
    on left: 36 37, on right: 15
nonrem (67)
    on left: 38 39, on right: 14 49
nonrel (68)
    on left: 40 41 42, on right: 18
spec1 (69)
    on left: 43, on right: 19
spec2 (70)
    on left: 44 45, on right: 20
spec3 (71)
    on left: 46 47, on right: 21
spec4 (72)
    on left: 48 49, on right: 22
spec5 (73)
    on left: 50 51, on right: 23
spec6 (74)
    on left: 52 53, on right: 24
spec7 (75)
    on left: 54 55 56, on right: 25
spec8 (76)
    on left: 57, on right: 26
spec9 (77)
    on left: 58, on right: 27
spec10 (78)
    on left: 59 60, on right: 28
spec11 (79)
    on left: 61 62, on right: 29
spec12 (80)
    on left: 63, on right: 30
spec13 (81)
    on left: 64, on right: 31
rem (82)
    on left: 65 66, on right: 34 35 38 39 50 51 52 53 56 57 58 73
rom (83)
    on left: 67 68 69 70 71 72, on right: 46 47
rim (84)
    on left: 73 74, on right: 34 35 36 37 50 51 52 53 54 55 56 63 64
rel (85)
    on left: 75 76 77, on right: 40 41 42 67
reg (86)
    on left: 78 79 80 81 82 83 84, on right: 57 58 65 69 71
imm2 (87)
    on left: 85, on right: 44 45
imm (88)
    on left: 86 87 88 89 90 91 92, on right: 42 43 58 60 61 62 74
mem (89)
    on left: 93 94, on right: 44 45 61 62 66
omem (90)
    on left: 95 96 97 98 99 100 101 102 103 104 105, on right: 70 72
    93
nmem (91)
    on left: 106 107, on right: 68 94
nam (92)
    on left: 108 109, on right: 43 87 106 107
offset (93)
    on left: 110 111 112, on right: 76 77 108 109
pointer (94)
    on left: 113 114 115, on right: 108
con (95)
    on left: 116 117 118 119 120 121, on right: 43 45 57 62 75 86 95
    96 97 98 99 100 101 104 105 107 111 112 118 119 120 126
con2 (96)
    on left: 122 123 124 125, on right: 85
expr (97)
    on left: 126 127 128 129 130 131 132 133 134 135 136, on right:
    11 12 121 127 128 129 130 131 132 133 134 135 136


state 0

    0 $accept: . prog $end
    1 prog: .
    3     | . prog $@1 line

    $default  reduce using rule 1 (prog)

    prog  go to state 1


state 1

    0 $accept: prog . $end
    2 $@1: .  [error, LTYPE0, LTYPE1, LTYPE2, LTYPE3, LTYPE4, LTYPEC, LTYPED, LTYPEN, LTYPER, LTYPET, LTYPEG, LTYPEPC, LTYPES, LTYPEM, LTYPEI, LTYPEXC, LTYPEX, LTYPERT, LTYPEF, LNAME, LLAB, LVAR, ';']
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
   26     | . LTYPEXC spec8
   27     | . LTYPEX spec9
   28     | . LTYPERT spec10
   29     | . LTYPEG spec11
   30     | . LTYPEPC spec12
   31     | . LTYPEF spec13

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
    LTYPEG   shift, and go to state 15
    LTYPEPC  shift, and go to state 16
    LTYPES   shift, and go to state 17
    LTYPEM   shift, and go to state 18
    LTYPEI   shift, and go to state 19
    LTYPEXC  shift, and go to state 20
    LTYPEX   shift, and go to state 21
    LTYPERT  shift, and go to state 22
    LTYPEF   shift, and go to state 23
    LNAME    shift, and go to state 24
    LLAB     shift, and go to state 25
    LVAR     shift, and go to state 26
    ';'      shift, and go to state 27

    line  go to state 28
    inst  go to state 29


state 4

   10 line: error . ';'

    ';'  shift, and go to state 30


state 5

   13 inst: LTYPE0 . nonnon
   32 nonnon: .  [';']
   33       | . ','

    ','  shift, and go to state 31

    $default  reduce using rule 32 (nonnon)

    nonnon  go to state 32


state 6

   14 inst: LTYPE1 . nonrem
   38 nonrem: . ',' rem
   39       | . rem
   65 rem: . reg
   66    | . mem
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    ','     shift, and go to state 45
    '('     shift, and go to state 46
    '~'     shift, and go to state 47

    nonrem  go to state 48
    rem     go to state 49
    reg     go to state 50
    mem     go to state 51
    omem    go to state 52
    nmem    go to state 53
    nam     go to state 54
    con     go to state 55


state 7

   15 inst: LTYPE2 . rimnon
   36 rimnon: . rim ','
   37       | . rim
   65 rem: . reg
   66    | . mem
   73 rim: . rem
   74    | . imm
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   86 imm: . '$' con
   87    | . '$' nam
   88    | . '$' LSCONST
   89    | . '$' LFCONST
   90    | . '$' '(' LFCONST ')'
   91    | . '$' '(' '-' LFCONST ')'
   92    | . '$' '-' LFCONST
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '$'     shift, and go to state 56
    '~'     shift, and go to state 47

    rimnon  go to state 57
    rem     go to state 58
    rim     go to state 59
    reg     go to state 50
    imm     go to state 60
    mem     go to state 51
    omem    go to state 52
    nmem    go to state 53
    nam     go to state 54
    con     go to state 55


state 8

   16 inst: LTYPE3 . rimrem
   34 rimrem: . rim ',' rem
   65 rem: . reg
   66    | . mem
   73 rim: . rem
   74    | . imm
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   86 imm: . '$' con
   87    | . '$' nam
   88    | . '$' LSCONST
   89    | . '$' LFCONST
   90    | . '$' '(' LFCONST ')'
   91    | . '$' '(' '-' LFCONST ')'
   92    | . '$' '-' LFCONST
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '$'     shift, and go to state 56
    '~'     shift, and go to state 47

    rimrem  go to state 61
    rem     go to state 58
    rim     go to state 62
    reg     go to state 50
    imm     go to state 60
    mem     go to state 51
    omem    go to state 52
    nmem    go to state 53
    nam     go to state 54
    con     go to state 55


state 9

   17 inst: LTYPE4 . remrim
   35 remrim: . rem ',' rim
   65 rem: . reg
   66    | . mem
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '~'     shift, and go to state 47

    remrim  go to state 63
    rem     go to state 64
    reg     go to state 50
    mem     go to state 51
    omem    go to state 52
    nmem    go to state 53
    nam     go to state 54
    con     go to state 55


state 10

   21 inst: LTYPEC . spec3
   46 spec3: . ',' rom
   47      | . rom
   67 rom: . rel
   68    | . nmem
   69    | . '*' reg
   70    | . '*' omem
   71    | . reg
   72    | . omem
   75 rel: . con '(' LPC ')'
   76    | . LNAME offset
   77    | . LLAB offset
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    '*'     shift, and go to state 65
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 66
    LLAB    shift, and go to state 67
    LVAR    shift, and go to state 44
    ','     shift, and go to state 68
    '('     shift, and go to state 46
    '~'     shift, and go to state 47

    spec3  go to state 69
    rom    go to state 70
    rel    go to state 71
    reg    go to state 72
    omem   go to state 73
    nmem   go to state 74
    nam    go to state 54
    con    go to state 75


state 11

   19 inst: LTYPED . spec1
   43 spec1: . nam '/' con ',' imm
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'

    LNAME  shift, and go to state 43

    spec1  go to state 76
    nam    go to state 77


state 12

   22 inst: LTYPEN . spec4
   32 nonnon: .  [';']
   33       | . ','
   38 nonrem: . ',' rem
   39       | . rem
   48 spec4: . nonnon
   49      | . nonrem
   65 rem: . reg
   66    | . mem
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    ','     shift, and go to state 78
    '('     shift, and go to state 46
    '~'     shift, and go to state 47

    $default  reduce using rule 32 (nonnon)

    nonnon  go to state 79
    nonrem  go to state 80
    spec4   go to state 81
    rem     go to state 49
    reg     go to state 50
    mem     go to state 51
    omem    go to state 52
    nmem    go to state 53
    nam     go to state 54
    con     go to state 55


state 13

   18 inst: LTYPER . nonrel
   40 nonrel: . ',' rel
   41       | . rel
   42       | . imm ',' rel
   75 rel: . con '(' LPC ')'
   76    | . LNAME offset
   77    | . LLAB offset
   86 imm: . '$' con
   87    | . '$' nam
   88    | . '$' LSCONST
   89    | . '$' LFCONST
   90    | . '$' '(' LFCONST ')'
   91    | . '$' '(' '-' LFCONST ')'
   92    | . '$' '-' LFCONST
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LNAME   shift, and go to state 82
    LLAB    shift, and go to state 67
    LVAR    shift, and go to state 44
    ','     shift, and go to state 83
    '('     shift, and go to state 84
    '$'     shift, and go to state 56
    '~'     shift, and go to state 47

    nonrel  go to state 85
    rel     go to state 86
    imm     go to state 87
    con     go to state 88


state 14

   20 inst: LTYPET . spec2
   44 spec2: . mem ',' imm2
   45      | . mem ',' con ',' imm2
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '~'     shift, and go to state 47

    spec2  go to state 89
    mem    go to state 90
    omem   go to state 52
    nmem   go to state 53
    nam    go to state 54
    con    go to state 55


state 15

   29 inst: LTYPEG . spec11
   61 spec11: . mem ',' imm
   62       | . mem ',' con ',' imm
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '~'     shift, and go to state 47

    spec11  go to state 91
    mem     go to state 92
    omem    go to state 52
    nmem    go to state 53
    nam     go to state 54
    con     go to state 55


state 16

   30 inst: LTYPEPC . spec12
   63 spec12: . rim ',' rim
   65 rem: . reg
   66    | . mem
   73 rim: . rem
   74    | . imm
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   86 imm: . '$' con
   87    | . '$' nam
   88    | . '$' LSCONST
   89    | . '$' LFCONST
   90    | . '$' '(' LFCONST ')'
   91    | . '$' '(' '-' LFCONST ')'
   92    | . '$' '-' LFCONST
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '$'     shift, and go to state 56
    '~'     shift, and go to state 47

    spec12  go to state 93
    rem     go to state 58
    rim     go to state 94
    reg     go to state 50
    imm     go to state 60
    mem     go to state 51
    omem    go to state 52
    nmem    go to state 53
    nam     go to state 54
    con     go to state 55


state 17

   23 inst: LTYPES . spec5
   50 spec5: . rim ',' rem
   51      | . rim ',' rem ':' LLREG
   65 rem: . reg
   66    | . mem
   73 rim: . rem
   74    | . imm
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   86 imm: . '$' con
   87    | . '$' nam
   88    | . '$' LSCONST
   89    | . '$' LFCONST
   90    | . '$' '(' LFCONST ')'
   91    | . '$' '(' '-' LFCONST ')'
   92    | . '$' '-' LFCONST
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '$'     shift, and go to state 56
    '~'     shift, and go to state 47

    spec5  go to state 95
    rem    go to state 58
    rim    go to state 96
    reg    go to state 50
    imm    go to state 60
    mem    go to state 51
    omem   go to state 52
    nmem   go to state 53
    nam    go to state 54
    con    go to state 55


state 18

   24 inst: LTYPEM . spec6
   52 spec6: . rim ',' rem
   53      | . rim ',' rem ':' LSREG
   65 rem: . reg
   66    | . mem
   73 rim: . rem
   74    | . imm
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   86 imm: . '$' con
   87    | . '$' nam
   88    | . '$' LSCONST
   89    | . '$' LFCONST
   90    | . '$' '(' LFCONST ')'
   91    | . '$' '(' '-' LFCONST ')'
   92    | . '$' '-' LFCONST
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '$'     shift, and go to state 56
    '~'     shift, and go to state 47

    spec6  go to state 97
    rem    go to state 58
    rim    go to state 98
    reg    go to state 50
    imm    go to state 60
    mem    go to state 51
    omem   go to state 52
    nmem   go to state 53
    nam    go to state 54
    con    go to state 55


state 19

   25 inst: LTYPEI . spec7
   54 spec7: . rim ','
   55      | . rim
   56      | . rim ',' rem
   65 rem: . reg
   66    | . mem
   73 rim: . rem
   74    | . imm
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   86 imm: . '$' con
   87    | . '$' nam
   88    | . '$' LSCONST
   89    | . '$' LFCONST
   90    | . '$' '(' LFCONST ')'
   91    | . '$' '(' '-' LFCONST ')'
   92    | . '$' '-' LFCONST
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '$'     shift, and go to state 56
    '~'     shift, and go to state 47

    spec7  go to state 99
    rem    go to state 58
    rim    go to state 100
    reg    go to state 50
    imm    go to state 60
    mem    go to state 51
    omem   go to state 52
    nmem   go to state 53
    nam    go to state 54
    con    go to state 55


state 20

   26 inst: LTYPEXC . spec8
   57 spec8: . reg ',' rem ',' con
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG

    LBREG  shift, and go to state 36
    LLREG  shift, and go to state 37
    LSREG  shift, and go to state 38
    LFREG  shift, and go to state 39
    LMREG  shift, and go to state 40
    LXREG  shift, and go to state 41
    LSP    shift, and go to state 42

    spec8  go to state 101
    reg    go to state 102


state 21

   27 inst: LTYPEX . spec9
   58 spec9: . imm ',' rem ',' reg
   86 imm: . '$' con
   87    | . '$' nam
   88    | . '$' LSCONST
   89    | . '$' LFCONST
   90    | . '$' '(' LFCONST ')'
   91    | . '$' '(' '-' LFCONST ')'
   92    | . '$' '-' LFCONST

    '$'  shift, and go to state 56

    spec9  go to state 103
    imm    go to state 104


state 22

   28 inst: LTYPERT . spec10
   59 spec10: .  [';']
   60       | . imm
   86 imm: . '$' con
   87    | . '$' nam
   88    | . '$' LSCONST
   89    | . '$' LFCONST
   90    | . '$' '(' LFCONST ')'
   91    | . '$' '(' '-' LFCONST ')'
   92    | . '$' '-' LFCONST

    '$'  shift, and go to state 56

    $default  reduce using rule 59 (spec10)

    spec10  go to state 105
    imm     go to state 106


state 23

   31 inst: LTYPEF . spec13
   64 spec13: . rim ',' rim
   65 rem: . reg
   66    | . mem
   73 rim: . rem
   74    | . imm
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   86 imm: . '$' con
   87    | . '$' nam
   88    | . '$' LSCONST
   89    | . '$' LFCONST
   90    | . '$' '(' LFCONST ')'
   91    | . '$' '(' '-' LFCONST ')'
   92    | . '$' '-' LFCONST
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '$'     shift, and go to state 56
    '~'     shift, and go to state 47

    spec13  go to state 107
    rem     go to state 58
    rim     go to state 108
    reg     go to state 50
    imm     go to state 60
    mem     go to state 51
    omem    go to state 52
    nmem    go to state 53
    nam     go to state 54
    con     go to state 55


state 24

    7 line: LNAME . ':' $@3 line
   11 inst: LNAME . '=' expr

    ':'  shift, and go to state 109
    '='  shift, and go to state 110


state 25

    5 line: LLAB . ':' $@2 line

    ':'  shift, and go to state 111


state 26

   12 inst: LVAR . '=' expr

    '='  shift, and go to state 112


state 27

    8 line: ';' .

    $default  reduce using rule 8 (line)


state 28

    3 prog: prog $@1 line .

    $default  reduce using rule 3 (prog)


state 29

    9 line: inst . ';'

    ';'  shift, and go to state 113


state 30

   10 line: error ';' .

    $default  reduce using rule 10 (line)


state 31

   33 nonnon: ',' .

    $default  reduce using rule 33 (nonnon)


state 32

   13 inst: LTYPE0 nonnon .

    $default  reduce using rule 13 (inst)


state 33

  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  119    | '+' . con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con  go to state 114


state 34

  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  118    | '-' . con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con  go to state 115


state 35

  116 con: LCONST .

    $default  reduce using rule 116 (con)


state 36

   78 reg: LBREG .

    $default  reduce using rule 78 (reg)


state 37

   80 reg: LLREG .

    $default  reduce using rule 80 (reg)


state 38

   83 reg: LSREG .

    $default  reduce using rule 83 (reg)


state 39

   79 reg: LFREG .

    $default  reduce using rule 79 (reg)


state 40

   81 reg: LMREG .

    $default  reduce using rule 81 (reg)


state 41

   84 reg: LXREG .

    $default  reduce using rule 84 (reg)


state 42

   82 reg: LSP .

    $default  reduce using rule 82 (reg)


state 43

  108 nam: LNAME . offset '(' pointer ')'
  109    | LNAME . '<' '>' offset '(' LSB ')'
  110 offset: .  ['(']
  111       | . '+' con
  112       | . '-' con

    '<'  shift, and go to state 116
    '+'  shift, and go to state 117
    '-'  shift, and go to state 118

    $default  reduce using rule 110 (offset)

    offset  go to state 119


state 44

  117 con: LVAR .

    $default  reduce using rule 117 (con)


state 45

   38 nonrem: ',' . rem
   65 rem: . reg
   66    | . mem
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '~'     shift, and go to state 47

    rem   go to state 120
    reg   go to state 50
    mem   go to state 51
    omem  go to state 52
    nmem  go to state 53
    nam   go to state 54
    con   go to state 55


state 46

  102 omem: '(' . LLREG ')'
  103     | '(' . LSP ')'
  104     | '(' . LLREG '*' con ')'
  105     | '(' . LLREG ')' '(' LLREG '*' con ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'
  121    | '(' . expr ')'
  126 expr: . con
  127     | . expr '+' expr
  128     | . expr '-' expr
  129     | . expr '*' expr
  130     | . expr '/' expr
  131     | . expr '%' expr
  132     | . expr '<' '<' expr
  133     | . expr '>' '>' expr
  134     | . expr '&' expr
  135     | . expr '^' expr
  136     | . expr '|' expr

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LLREG   shift, and go to state 121
    LSP     shift, and go to state 122
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con   go to state 123
    expr  go to state 124


state 47

  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  120    | '~' . con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con  go to state 125


state 48

   14 inst: LTYPE1 nonrem .

    $default  reduce using rule 14 (inst)


state 49

   39 nonrem: rem .

    $default  reduce using rule 39 (nonrem)


state 50

   65 rem: reg .

    $default  reduce using rule 65 (rem)


state 51

   66 rem: mem .

    $default  reduce using rule 66 (rem)


state 52

   93 mem: omem .

    $default  reduce using rule 93 (mem)


state 53

   94 mem: nmem .

    $default  reduce using rule 94 (mem)


state 54

  106 nmem: nam .  [':', ';', ',']
  107     | nam . '(' LLREG '*' con ')'

    '('  shift, and go to state 126

    $default  reduce using rule 106 (nmem)


state 55

   95 omem: con .  [':', ';', ',']
   96     | con . '(' LLREG ')'
   97     | con . '(' LSP ')'
   98     | con . '(' LSREG ')'
   99     | con . '(' LLREG '*' con ')'
  100     | con . '(' LLREG ')' '(' LLREG '*' con ')'
  101     | con . '(' LLREG ')' '(' LSREG '*' con ')'

    '('  shift, and go to state 127

    $default  reduce using rule 95 (omem)


state 56

   86 imm: '$' . con
   87    | '$' . nam
   88    | '$' . LSCONST
   89    | '$' . LFCONST
   90    | '$' . '(' LFCONST ')'
   91    | '$' . '(' '-' LFCONST ')'
   92    | '$' . '-' LFCONST
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'      shift, and go to state 33
    '-'      shift, and go to state 128
    LCONST   shift, and go to state 35
    LFCONST  shift, and go to state 129
    LSCONST  shift, and go to state 130
    LNAME    shift, and go to state 43
    LVAR     shift, and go to state 44
    '('      shift, and go to state 131
    '~'      shift, and go to state 47

    nam  go to state 132
    con  go to state 133


state 57

   15 inst: LTYPE2 rimnon .

    $default  reduce using rule 15 (inst)


state 58

   73 rim: rem .

    $default  reduce using rule 73 (rim)


state 59

   36 rimnon: rim . ','
   37       | rim .  [';']

    ','  shift, and go to state 134

    $default  reduce using rule 37 (rimnon)


state 60

   74 rim: imm .

    $default  reduce using rule 74 (rim)


state 61

   16 inst: LTYPE3 rimrem .

    $default  reduce using rule 16 (inst)


state 62

   34 rimrem: rim . ',' rem

    ','  shift, and go to state 135


state 63

   17 inst: LTYPE4 remrim .

    $default  reduce using rule 17 (inst)


state 64

   35 remrim: rem . ',' rim

    ','  shift, and go to state 136


state 65

   69 rom: '*' . reg
   70    | '*' . omem
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '~'     shift, and go to state 47

    reg   go to state 137
    omem  go to state 138
    con   go to state 55


state 66

   76 rel: LNAME . offset
  108 nam: LNAME . offset '(' pointer ')'
  109    | LNAME . '<' '>' offset '(' LSB ')'
  110 offset: .  [';', '(']
  111       | . '+' con
  112       | . '-' con

    '<'  shift, and go to state 116
    '+'  shift, and go to state 117
    '-'  shift, and go to state 118

    $default  reduce using rule 110 (offset)

    offset  go to state 139


state 67

   77 rel: LLAB . offset
  110 offset: .  [';']
  111       | . '+' con
  112       | . '-' con

    '+'  shift, and go to state 117
    '-'  shift, and go to state 118

    $default  reduce using rule 110 (offset)

    offset  go to state 140


state 68

   46 spec3: ',' . rom
   67 rom: . rel
   68    | . nmem
   69    | . '*' reg
   70    | . '*' omem
   71    | . reg
   72    | . omem
   75 rel: . con '(' LPC ')'
   76    | . LNAME offset
   77    | . LLAB offset
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    '*'     shift, and go to state 65
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 66
    LLAB    shift, and go to state 67
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '~'     shift, and go to state 47

    rom   go to state 141
    rel   go to state 71
    reg   go to state 72
    omem  go to state 73
    nmem  go to state 74
    nam   go to state 54
    con   go to state 75


state 69

   21 inst: LTYPEC spec3 .

    $default  reduce using rule 21 (inst)


state 70

   47 spec3: rom .

    $default  reduce using rule 47 (spec3)


state 71

   67 rom: rel .

    $default  reduce using rule 67 (rom)


state 72

   71 rom: reg .

    $default  reduce using rule 71 (rom)


state 73

   72 rom: omem .

    $default  reduce using rule 72 (rom)


state 74

   68 rom: nmem .

    $default  reduce using rule 68 (rom)


state 75

   75 rel: con . '(' LPC ')'
   95 omem: con .  [';']
   96     | con . '(' LLREG ')'
   97     | con . '(' LSP ')'
   98     | con . '(' LSREG ')'
   99     | con . '(' LLREG '*' con ')'
  100     | con . '(' LLREG ')' '(' LLREG '*' con ')'
  101     | con . '(' LLREG ')' '(' LSREG '*' con ')'

    '('  shift, and go to state 142

    $default  reduce using rule 95 (omem)


state 76

   19 inst: LTYPED spec1 .

    $default  reduce using rule 19 (inst)


state 77

   43 spec1: nam . '/' con ',' imm

    '/'  shift, and go to state 143


state 78

   33 nonnon: ',' .  [';']
   38 nonrem: ',' . rem
   65 rem: . reg
   66    | . mem
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '~'     shift, and go to state 47

    $default  reduce using rule 33 (nonnon)

    rem   go to state 120
    reg   go to state 50
    mem   go to state 51
    omem  go to state 52
    nmem  go to state 53
    nam   go to state 54
    con   go to state 55


state 79

   48 spec4: nonnon .

    $default  reduce using rule 48 (spec4)


state 80

   49 spec4: nonrem .

    $default  reduce using rule 49 (spec4)


state 81

   22 inst: LTYPEN spec4 .

    $default  reduce using rule 22 (inst)


state 82

   76 rel: LNAME . offset
  110 offset: .  [';']
  111       | . '+' con
  112       | . '-' con

    '+'  shift, and go to state 117
    '-'  shift, and go to state 118

    $default  reduce using rule 110 (offset)

    offset  go to state 144


state 83

   40 nonrel: ',' . rel
   75 rel: . con '(' LPC ')'
   76    | . LNAME offset
   77    | . LLAB offset
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LNAME   shift, and go to state 82
    LLAB    shift, and go to state 67
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    rel  go to state 145
    con  go to state 88


state 84

  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'
  121    | '(' . expr ')'
  126 expr: . con
  127     | . expr '+' expr
  128     | . expr '-' expr
  129     | . expr '*' expr
  130     | . expr '/' expr
  131     | . expr '%' expr
  132     | . expr '<' '<' expr
  133     | . expr '>' '>' expr
  134     | . expr '&' expr
  135     | . expr '^' expr
  136     | . expr '|' expr

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con   go to state 123
    expr  go to state 124


state 85

   18 inst: LTYPER nonrel .

    $default  reduce using rule 18 (inst)


state 86

   41 nonrel: rel .

    $default  reduce using rule 41 (nonrel)


state 87

   42 nonrel: imm . ',' rel

    ','  shift, and go to state 146


state 88

   75 rel: con . '(' LPC ')'

    '('  shift, and go to state 147


state 89

   20 inst: LTYPET spec2 .

    $default  reduce using rule 20 (inst)


state 90

   44 spec2: mem . ',' imm2
   45      | mem . ',' con ',' imm2

    ','  shift, and go to state 148


state 91

   29 inst: LTYPEG spec11 .

    $default  reduce using rule 29 (inst)


state 92

   61 spec11: mem . ',' imm
   62       | mem . ',' con ',' imm

    ','  shift, and go to state 149


state 93

   30 inst: LTYPEPC spec12 .

    $default  reduce using rule 30 (inst)


state 94

   63 spec12: rim . ',' rim

    ','  shift, and go to state 150


state 95

   23 inst: LTYPES spec5 .

    $default  reduce using rule 23 (inst)


state 96

   50 spec5: rim . ',' rem
   51      | rim . ',' rem ':' LLREG

    ','  shift, and go to state 151


state 97

   24 inst: LTYPEM spec6 .

    $default  reduce using rule 24 (inst)


state 98

   52 spec6: rim . ',' rem
   53      | rim . ',' rem ':' LSREG

    ','  shift, and go to state 152


state 99

   25 inst: LTYPEI spec7 .

    $default  reduce using rule 25 (inst)


state 100

   54 spec7: rim . ','
   55      | rim .  [';']
   56      | rim . ',' rem

    ','  shift, and go to state 153

    $default  reduce using rule 55 (spec7)


state 101

   26 inst: LTYPEXC spec8 .

    $default  reduce using rule 26 (inst)


state 102

   57 spec8: reg . ',' rem ',' con

    ','  shift, and go to state 154


state 103

   27 inst: LTYPEX spec9 .

    $default  reduce using rule 27 (inst)


state 104

   58 spec9: imm . ',' rem ',' reg

    ','  shift, and go to state 155


state 105

   28 inst: LTYPERT spec10 .

    $default  reduce using rule 28 (inst)


state 106

   60 spec10: imm .

    $default  reduce using rule 60 (spec10)


state 107

   31 inst: LTYPEF spec13 .

    $default  reduce using rule 31 (inst)


state 108

   64 spec13: rim . ',' rim

    ','  shift, and go to state 156


state 109

    6 $@3: .
    7 line: LNAME ':' . $@3 line

    $default  reduce using rule 6 ($@3)

    $@3  go to state 157


state 110

   11 inst: LNAME '=' . expr
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'
  126 expr: . con
  127     | . expr '+' expr
  128     | . expr '-' expr
  129     | . expr '*' expr
  130     | . expr '/' expr
  131     | . expr '%' expr
  132     | . expr '<' '<' expr
  133     | . expr '>' '>' expr
  134     | . expr '&' expr
  135     | . expr '^' expr
  136     | . expr '|' expr

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con   go to state 123
    expr  go to state 158


state 111

    4 $@2: .
    5 line: LLAB ':' . $@2 line

    $default  reduce using rule 4 ($@2)

    $@2  go to state 159


state 112

   12 inst: LVAR '=' . expr
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'
  126 expr: . con
  127     | . expr '+' expr
  128     | . expr '-' expr
  129     | . expr '*' expr
  130     | . expr '/' expr
  131     | . expr '%' expr
  132     | . expr '<' '<' expr
  133     | . expr '>' '>' expr
  134     | . expr '&' expr
  135     | . expr '^' expr
  136     | . expr '|' expr

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con   go to state 123
    expr  go to state 160


state 113

    9 line: inst ';' .

    $default  reduce using rule 9 (line)


state 114

  119 con: '+' con .

    $default  reduce using rule 119 (con)


state 115

  118 con: '-' con .

    $default  reduce using rule 118 (con)


state 116

  109 nam: LNAME '<' . '>' offset '(' LSB ')'

    '>'  shift, and go to state 161


state 117

  111 offset: '+' . con
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con  go to state 162


state 118

  112 offset: '-' . con
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con  go to state 163


state 119

  108 nam: LNAME offset . '(' pointer ')'

    '('  shift, and go to state 164


state 120

   38 nonrem: ',' rem .

    $default  reduce using rule 38 (nonrem)


state 121

  102 omem: '(' LLREG . ')'
  104     | '(' LLREG . '*' con ')'
  105     | '(' LLREG . ')' '(' LLREG '*' con ')'

    '*'  shift, and go to state 165
    ')'  shift, and go to state 166


state 122

  103 omem: '(' LSP . ')'

    ')'  shift, and go to state 167


state 123

  126 expr: con .

    $default  reduce using rule 126 (expr)


state 124

  121 con: '(' expr . ')'
  127 expr: expr . '+' expr
  128     | expr . '-' expr
  129     | expr . '*' expr
  130     | expr . '/' expr
  131     | expr . '%' expr
  132     | expr . '<' '<' expr
  133     | expr . '>' '>' expr
  134     | expr . '&' expr
  135     | expr . '^' expr
  136     | expr . '|' expr

    '|'  shift, and go to state 168
    '^'  shift, and go to state 169
    '&'  shift, and go to state 170
    '<'  shift, and go to state 171
    '>'  shift, and go to state 172
    '+'  shift, and go to state 173
    '-'  shift, and go to state 174
    '*'  shift, and go to state 175
    '/'  shift, and go to state 176
    '%'  shift, and go to state 177
    ')'  shift, and go to state 178


state 125

  120 con: '~' con .

    $default  reduce using rule 120 (con)


state 126

  107 nmem: nam '(' . LLREG '*' con ')'

    LLREG  shift, and go to state 179


state 127

   96 omem: con '(' . LLREG ')'
   97     | con '(' . LSP ')'
   98     | con '(' . LSREG ')'
   99     | con '(' . LLREG '*' con ')'
  100     | con '(' . LLREG ')' '(' LLREG '*' con ')'
  101     | con '(' . LLREG ')' '(' LSREG '*' con ')'

    LLREG  shift, and go to state 180
    LSREG  shift, and go to state 181
    LSP    shift, and go to state 182


state 128

   92 imm: '$' '-' . LFCONST
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  118    | '-' . con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'      shift, and go to state 33
    '-'      shift, and go to state 34
    LCONST   shift, and go to state 35
    LFCONST  shift, and go to state 183
    LVAR     shift, and go to state 44
    '('      shift, and go to state 84
    '~'      shift, and go to state 47

    con  go to state 115


state 129

   89 imm: '$' LFCONST .

    $default  reduce using rule 89 (imm)


state 130

   88 imm: '$' LSCONST .

    $default  reduce using rule 88 (imm)


state 131

   90 imm: '$' '(' . LFCONST ')'
   91    | '$' '(' . '-' LFCONST ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'
  121    | '(' . expr ')'
  126 expr: . con
  127     | . expr '+' expr
  128     | . expr '-' expr
  129     | . expr '*' expr
  130     | . expr '/' expr
  131     | . expr '%' expr
  132     | . expr '<' '<' expr
  133     | . expr '>' '>' expr
  134     | . expr '&' expr
  135     | . expr '^' expr
  136     | . expr '|' expr

    '+'      shift, and go to state 33
    '-'      shift, and go to state 184
    LCONST   shift, and go to state 35
    LFCONST  shift, and go to state 185
    LVAR     shift, and go to state 44
    '('      shift, and go to state 84
    '~'      shift, and go to state 47

    con   go to state 123
    expr  go to state 124


state 132

   87 imm: '$' nam .

    $default  reduce using rule 87 (imm)


state 133

   86 imm: '$' con .

    $default  reduce using rule 86 (imm)


state 134

   36 rimnon: rim ',' .

    $default  reduce using rule 36 (rimnon)


state 135

   34 rimrem: rim ',' . rem
   65 rem: . reg
   66    | . mem
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '~'     shift, and go to state 47

    rem   go to state 186
    reg   go to state 50
    mem   go to state 51
    omem  go to state 52
    nmem  go to state 53
    nam   go to state 54
    con   go to state 55


state 136

   35 remrim: rem ',' . rim
   65 rem: . reg
   66    | . mem
   73 rim: . rem
   74    | . imm
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   86 imm: . '$' con
   87    | . '$' nam
   88    | . '$' LSCONST
   89    | . '$' LFCONST
   90    | . '$' '(' LFCONST ')'
   91    | . '$' '(' '-' LFCONST ')'
   92    | . '$' '-' LFCONST
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '$'     shift, and go to state 56
    '~'     shift, and go to state 47

    rem   go to state 58
    rim   go to state 187
    reg   go to state 50
    imm   go to state 60
    mem   go to state 51
    omem  go to state 52
    nmem  go to state 53
    nam   go to state 54
    con   go to state 55


state 137

   69 rom: '*' reg .

    $default  reduce using rule 69 (rom)


state 138

   70 rom: '*' omem .

    $default  reduce using rule 70 (rom)


state 139

   76 rel: LNAME offset .  [';']
  108 nam: LNAME offset . '(' pointer ')'

    '('  shift, and go to state 164

    $default  reduce using rule 76 (rel)


state 140

   77 rel: LLAB offset .

    $default  reduce using rule 77 (rel)


state 141

   46 spec3: ',' rom .

    $default  reduce using rule 46 (spec3)


state 142

   75 rel: con '(' . LPC ')'
   96 omem: con '(' . LLREG ')'
   97     | con '(' . LSP ')'
   98     | con '(' . LSREG ')'
   99     | con '(' . LLREG '*' con ')'
  100     | con '(' . LLREG ')' '(' LLREG '*' con ')'
  101     | con '(' . LLREG ')' '(' LSREG '*' con ')'

    LPC    shift, and go to state 188
    LLREG  shift, and go to state 180
    LSREG  shift, and go to state 181
    LSP    shift, and go to state 182


state 143

   43 spec1: nam '/' . con ',' imm
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con  go to state 189


state 144

   76 rel: LNAME offset .

    $default  reduce using rule 76 (rel)


state 145

   40 nonrel: ',' rel .

    $default  reduce using rule 40 (nonrel)


state 146

   42 nonrel: imm ',' . rel
   75 rel: . con '(' LPC ')'
   76    | . LNAME offset
   77    | . LLAB offset
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LNAME   shift, and go to state 82
    LLAB    shift, and go to state 67
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    rel  go to state 190
    con  go to state 88


state 147

   75 rel: con '(' . LPC ')'

    LPC  shift, and go to state 188


state 148

   44 spec2: mem ',' . imm2
   45      | mem ',' . con ',' imm2
   85 imm2: . '$' con2
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '$'     shift, and go to state 191
    '~'     shift, and go to state 47

    imm2  go to state 192
    con   go to state 193


state 149

   61 spec11: mem ',' . imm
   62       | mem ',' . con ',' imm
   86 imm: . '$' con
   87    | . '$' nam
   88    | . '$' LSCONST
   89    | . '$' LFCONST
   90    | . '$' '(' LFCONST ')'
   91    | . '$' '(' '-' LFCONST ')'
   92    | . '$' '-' LFCONST
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '$'     shift, and go to state 56
    '~'     shift, and go to state 47

    imm  go to state 194
    con  go to state 195


state 150

   63 spec12: rim ',' . rim
   65 rem: . reg
   66    | . mem
   73 rim: . rem
   74    | . imm
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   86 imm: . '$' con
   87    | . '$' nam
   88    | . '$' LSCONST
   89    | . '$' LFCONST
   90    | . '$' '(' LFCONST ')'
   91    | . '$' '(' '-' LFCONST ')'
   92    | . '$' '-' LFCONST
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '$'     shift, and go to state 56
    '~'     shift, and go to state 47

    rem   go to state 58
    rim   go to state 196
    reg   go to state 50
    imm   go to state 60
    mem   go to state 51
    omem  go to state 52
    nmem  go to state 53
    nam   go to state 54
    con   go to state 55


state 151

   50 spec5: rim ',' . rem
   51      | rim ',' . rem ':' LLREG
   65 rem: . reg
   66    | . mem
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '~'     shift, and go to state 47

    rem   go to state 197
    reg   go to state 50
    mem   go to state 51
    omem  go to state 52
    nmem  go to state 53
    nam   go to state 54
    con   go to state 55


state 152

   52 spec6: rim ',' . rem
   53      | rim ',' . rem ':' LSREG
   65 rem: . reg
   66    | . mem
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '~'     shift, and go to state 47

    rem   go to state 198
    reg   go to state 50
    mem   go to state 51
    omem  go to state 52
    nmem  go to state 53
    nam   go to state 54
    con   go to state 55


state 153

   54 spec7: rim ',' .  [';']
   56      | rim ',' . rem
   65 rem: . reg
   66    | . mem
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '~'     shift, and go to state 47

    $default  reduce using rule 54 (spec7)

    rem   go to state 199
    reg   go to state 50
    mem   go to state 51
    omem  go to state 52
    nmem  go to state 53
    nam   go to state 54
    con   go to state 55


state 154

   57 spec8: reg ',' . rem ',' con
   65 rem: . reg
   66    | . mem
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '~'     shift, and go to state 47

    rem   go to state 200
    reg   go to state 50
    mem   go to state 51
    omem  go to state 52
    nmem  go to state 53
    nam   go to state 54
    con   go to state 55


state 155

   58 spec9: imm ',' . rem ',' reg
   65 rem: . reg
   66    | . mem
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '~'     shift, and go to state 47

    rem   go to state 201
    reg   go to state 50
    mem   go to state 51
    omem  go to state 52
    nmem  go to state 53
    nam   go to state 54
    con   go to state 55


state 156

   64 spec13: rim ',' . rim
   65 rem: . reg
   66    | . mem
   73 rim: . rem
   74    | . imm
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG
   86 imm: . '$' con
   87    | . '$' nam
   88    | . '$' LSCONST
   89    | . '$' LFCONST
   90    | . '$' '(' LFCONST ')'
   91    | . '$' '(' '-' LFCONST ')'
   92    | . '$' '-' LFCONST
   93 mem: . omem
   94    | . nmem
   95 omem: . con
   96     | . con '(' LLREG ')'
   97     | . con '(' LSP ')'
   98     | . con '(' LSREG ')'
   99     | . con '(' LLREG '*' con ')'
  100     | . con '(' LLREG ')' '(' LLREG '*' con ')'
  101     | . con '(' LLREG ')' '(' LSREG '*' con ')'
  102     | . '(' LLREG ')'
  103     | . '(' LSP ')'
  104     | . '(' LLREG '*' con ')'
  105     | . '(' LLREG ')' '(' LLREG '*' con ')'
  106 nmem: . nam
  107     | . nam '(' LLREG '*' con ')'
  108 nam: . LNAME offset '(' pointer ')'
  109    | . LNAME '<' '>' offset '(' LSB ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LBREG   shift, and go to state 36
    LLREG   shift, and go to state 37
    LSREG   shift, and go to state 38
    LFREG   shift, and go to state 39
    LMREG   shift, and go to state 40
    LXREG   shift, and go to state 41
    LSP     shift, and go to state 42
    LNAME   shift, and go to state 43
    LVAR    shift, and go to state 44
    '('     shift, and go to state 46
    '$'     shift, and go to state 56
    '~'     shift, and go to state 47

    rem   go to state 58
    rim   go to state 202
    reg   go to state 50
    imm   go to state 60
    mem   go to state 51
    omem  go to state 52
    nmem  go to state 53
    nam   go to state 54
    con   go to state 55


state 157

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
   26     | . LTYPEXC spec8
   27     | . LTYPEX spec9
   28     | . LTYPERT spec10
   29     | . LTYPEG spec11
   30     | . LTYPEPC spec12
   31     | . LTYPEF spec13

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
    LTYPEG   shift, and go to state 15
    LTYPEPC  shift, and go to state 16
    LTYPES   shift, and go to state 17
    LTYPEM   shift, and go to state 18
    LTYPEI   shift, and go to state 19
    LTYPEXC  shift, and go to state 20
    LTYPEX   shift, and go to state 21
    LTYPERT  shift, and go to state 22
    LTYPEF   shift, and go to state 23
    LNAME    shift, and go to state 24
    LLAB     shift, and go to state 25
    LVAR     shift, and go to state 26
    ';'      shift, and go to state 27

    line  go to state 203
    inst  go to state 29


state 158

   11 inst: LNAME '=' expr .  [';']
  127 expr: expr . '+' expr
  128     | expr . '-' expr
  129     | expr . '*' expr
  130     | expr . '/' expr
  131     | expr . '%' expr
  132     | expr . '<' '<' expr
  133     | expr . '>' '>' expr
  134     | expr . '&' expr
  135     | expr . '^' expr
  136     | expr . '|' expr

    '|'  shift, and go to state 168
    '^'  shift, and go to state 169
    '&'  shift, and go to state 170
    '<'  shift, and go to state 171
    '>'  shift, and go to state 172
    '+'  shift, and go to state 173
    '-'  shift, and go to state 174
    '*'  shift, and go to state 175
    '/'  shift, and go to state 176
    '%'  shift, and go to state 177

    $default  reduce using rule 11 (inst)


state 159

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
   26     | . LTYPEXC spec8
   27     | . LTYPEX spec9
   28     | . LTYPERT spec10
   29     | . LTYPEG spec11
   30     | . LTYPEPC spec12
   31     | . LTYPEF spec13

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
    LTYPEG   shift, and go to state 15
    LTYPEPC  shift, and go to state 16
    LTYPES   shift, and go to state 17
    LTYPEM   shift, and go to state 18
    LTYPEI   shift, and go to state 19
    LTYPEXC  shift, and go to state 20
    LTYPEX   shift, and go to state 21
    LTYPERT  shift, and go to state 22
    LTYPEF   shift, and go to state 23
    LNAME    shift, and go to state 24
    LLAB     shift, and go to state 25
    LVAR     shift, and go to state 26
    ';'      shift, and go to state 27

    line  go to state 204
    inst  go to state 29


state 160

   12 inst: LVAR '=' expr .  [';']
  127 expr: expr . '+' expr
  128     | expr . '-' expr
  129     | expr . '*' expr
  130     | expr . '/' expr
  131     | expr . '%' expr
  132     | expr . '<' '<' expr
  133     | expr . '>' '>' expr
  134     | expr . '&' expr
  135     | expr . '^' expr
  136     | expr . '|' expr

    '|'  shift, and go to state 168
    '^'  shift, and go to state 169
    '&'  shift, and go to state 170
    '<'  shift, and go to state 171
    '>'  shift, and go to state 172
    '+'  shift, and go to state 173
    '-'  shift, and go to state 174
    '*'  shift, and go to state 175
    '/'  shift, and go to state 176
    '%'  shift, and go to state 177

    $default  reduce using rule 12 (inst)


state 161

  109 nam: LNAME '<' '>' . offset '(' LSB ')'
  110 offset: .  ['(']
  111       | . '+' con
  112       | . '-' con

    '+'  shift, and go to state 117
    '-'  shift, and go to state 118

    $default  reduce using rule 110 (offset)

    offset  go to state 205


state 162

  111 offset: '+' con .

    $default  reduce using rule 111 (offset)


state 163

  112 offset: '-' con .

    $default  reduce using rule 112 (offset)


state 164

  108 nam: LNAME offset '(' . pointer ')'
  113 pointer: . LSB
  114        | . LSP
  115        | . LFP

    LFP  shift, and go to state 206
    LSB  shift, and go to state 207
    LSP  shift, and go to state 208

    pointer  go to state 209


state 165

  104 omem: '(' LLREG '*' . con ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con  go to state 210


state 166

  102 omem: '(' LLREG ')' .  [':', ';', ',']
  105     | '(' LLREG ')' . '(' LLREG '*' con ')'

    '('  shift, and go to state 211

    $default  reduce using rule 102 (omem)


state 167

  103 omem: '(' LSP ')' .

    $default  reduce using rule 103 (omem)


state 168

  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'
  126 expr: . con
  127     | . expr '+' expr
  128     | . expr '-' expr
  129     | . expr '*' expr
  130     | . expr '/' expr
  131     | . expr '%' expr
  132     | . expr '<' '<' expr
  133     | . expr '>' '>' expr
  134     | . expr '&' expr
  135     | . expr '^' expr
  136     | . expr '|' expr
  136     | expr '|' . expr

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con   go to state 123
    expr  go to state 212


state 169

  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'
  126 expr: . con
  127     | . expr '+' expr
  128     | . expr '-' expr
  129     | . expr '*' expr
  130     | . expr '/' expr
  131     | . expr '%' expr
  132     | . expr '<' '<' expr
  133     | . expr '>' '>' expr
  134     | . expr '&' expr
  135     | . expr '^' expr
  135     | expr '^' . expr
  136     | . expr '|' expr

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con   go to state 123
    expr  go to state 213


state 170

  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'
  126 expr: . con
  127     | . expr '+' expr
  128     | . expr '-' expr
  129     | . expr '*' expr
  130     | . expr '/' expr
  131     | . expr '%' expr
  132     | . expr '<' '<' expr
  133     | . expr '>' '>' expr
  134     | . expr '&' expr
  134     | expr '&' . expr
  135     | . expr '^' expr
  136     | . expr '|' expr

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con   go to state 123
    expr  go to state 214


state 171

  132 expr: expr '<' . '<' expr

    '<'  shift, and go to state 215


state 172

  133 expr: expr '>' . '>' expr

    '>'  shift, and go to state 216


state 173

  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'
  126 expr: . con
  127     | . expr '+' expr
  127     | expr '+' . expr
  128     | . expr '-' expr
  129     | . expr '*' expr
  130     | . expr '/' expr
  131     | . expr '%' expr
  132     | . expr '<' '<' expr
  133     | . expr '>' '>' expr
  134     | . expr '&' expr
  135     | . expr '^' expr
  136     | . expr '|' expr

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con   go to state 123
    expr  go to state 217


state 174

  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'
  126 expr: . con
  127     | . expr '+' expr
  128     | . expr '-' expr
  128     | expr '-' . expr
  129     | . expr '*' expr
  130     | . expr '/' expr
  131     | . expr '%' expr
  132     | . expr '<' '<' expr
  133     | . expr '>' '>' expr
  134     | . expr '&' expr
  135     | . expr '^' expr
  136     | . expr '|' expr

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con   go to state 123
    expr  go to state 218


state 175

  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'
  126 expr: . con
  127     | . expr '+' expr
  128     | . expr '-' expr
  129     | . expr '*' expr
  129     | expr '*' . expr
  130     | . expr '/' expr
  131     | . expr '%' expr
  132     | . expr '<' '<' expr
  133     | . expr '>' '>' expr
  134     | . expr '&' expr
  135     | . expr '^' expr
  136     | . expr '|' expr

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con   go to state 123
    expr  go to state 219


state 176

  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'
  126 expr: . con
  127     | . expr '+' expr
  128     | . expr '-' expr
  129     | . expr '*' expr
  130     | . expr '/' expr
  130     | expr '/' . expr
  131     | . expr '%' expr
  132     | . expr '<' '<' expr
  133     | . expr '>' '>' expr
  134     | . expr '&' expr
  135     | . expr '^' expr
  136     | . expr '|' expr

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con   go to state 123
    expr  go to state 220


state 177

  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'
  126 expr: . con
  127     | . expr '+' expr
  128     | . expr '-' expr
  129     | . expr '*' expr
  130     | . expr '/' expr
  131     | . expr '%' expr
  131     | expr '%' . expr
  132     | . expr '<' '<' expr
  133     | . expr '>' '>' expr
  134     | . expr '&' expr
  135     | . expr '^' expr
  136     | . expr '|' expr

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con   go to state 123
    expr  go to state 221


state 178

  121 con: '(' expr ')' .

    $default  reduce using rule 121 (con)


state 179

  107 nmem: nam '(' LLREG . '*' con ')'

    '*'  shift, and go to state 222


state 180

   96 omem: con '(' LLREG . ')'
   99     | con '(' LLREG . '*' con ')'
  100     | con '(' LLREG . ')' '(' LLREG '*' con ')'
  101     | con '(' LLREG . ')' '(' LSREG '*' con ')'

    '*'  shift, and go to state 223
    ')'  shift, and go to state 224


state 181

   98 omem: con '(' LSREG . ')'

    ')'  shift, and go to state 225


state 182

   97 omem: con '(' LSP . ')'

    ')'  shift, and go to state 226


state 183

   92 imm: '$' '-' LFCONST .

    $default  reduce using rule 92 (imm)


state 184

   91 imm: '$' '(' '-' . LFCONST ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  118    | '-' . con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'      shift, and go to state 33
    '-'      shift, and go to state 34
    LCONST   shift, and go to state 35
    LFCONST  shift, and go to state 227
    LVAR     shift, and go to state 44
    '('      shift, and go to state 84
    '~'      shift, and go to state 47

    con  go to state 115


state 185

   90 imm: '$' '(' LFCONST . ')'

    ')'  shift, and go to state 228


state 186

   34 rimrem: rim ',' rem .

    $default  reduce using rule 34 (rimrem)


state 187

   35 remrim: rem ',' rim .

    $default  reduce using rule 35 (remrim)


state 188

   75 rel: con '(' LPC . ')'

    ')'  shift, and go to state 229


state 189

   43 spec1: nam '/' con . ',' imm

    ','  shift, and go to state 230


state 190

   42 nonrel: imm ',' rel .

    $default  reduce using rule 42 (nonrel)


state 191

   85 imm2: '$' . con2
  122 con2: . LCONST
  123     | . '-' LCONST
  124     | . LCONST '-' LCONST
  125     | . '-' LCONST '-' LCONST

    '-'     shift, and go to state 231
    LCONST  shift, and go to state 232

    con2  go to state 233


state 192

   44 spec2: mem ',' imm2 .

    $default  reduce using rule 44 (spec2)


state 193

   45 spec2: mem ',' con . ',' imm2

    ','  shift, and go to state 234


state 194

   61 spec11: mem ',' imm .

    $default  reduce using rule 61 (spec11)


state 195

   62 spec11: mem ',' con . ',' imm

    ','  shift, and go to state 235


state 196

   63 spec12: rim ',' rim .

    $default  reduce using rule 63 (spec12)


state 197

   50 spec5: rim ',' rem .  [';']
   51      | rim ',' rem . ':' LLREG

    ':'  shift, and go to state 236

    $default  reduce using rule 50 (spec5)


state 198

   52 spec6: rim ',' rem .  [';']
   53      | rim ',' rem . ':' LSREG

    ':'  shift, and go to state 237

    $default  reduce using rule 52 (spec6)


state 199

   56 spec7: rim ',' rem .

    $default  reduce using rule 56 (spec7)


state 200

   57 spec8: reg ',' rem . ',' con

    ','  shift, and go to state 238


state 201

   58 spec9: imm ',' rem . ',' reg

    ','  shift, and go to state 239


state 202

   64 spec13: rim ',' rim .

    $default  reduce using rule 64 (spec13)


state 203

    7 line: LNAME ':' $@3 line .

    $default  reduce using rule 7 (line)


state 204

    5 line: LLAB ':' $@2 line .

    $default  reduce using rule 5 (line)


state 205

  109 nam: LNAME '<' '>' offset . '(' LSB ')'

    '('  shift, and go to state 240


state 206

  115 pointer: LFP .

    $default  reduce using rule 115 (pointer)


state 207

  113 pointer: LSB .

    $default  reduce using rule 113 (pointer)


state 208

  114 pointer: LSP .

    $default  reduce using rule 114 (pointer)


state 209

  108 nam: LNAME offset '(' pointer . ')'

    ')'  shift, and go to state 241


state 210

  104 omem: '(' LLREG '*' con . ')'

    ')'  shift, and go to state 242


state 211

  105 omem: '(' LLREG ')' '(' . LLREG '*' con ')'

    LLREG  shift, and go to state 243


state 212

  127 expr: expr . '+' expr
  128     | expr . '-' expr
  129     | expr . '*' expr
  130     | expr . '/' expr
  131     | expr . '%' expr
  132     | expr . '<' '<' expr
  133     | expr . '>' '>' expr
  134     | expr . '&' expr
  135     | expr . '^' expr
  136     | expr . '|' expr
  136     | expr '|' expr .  ['|', ';', ')']

    '^'  shift, and go to state 169
    '&'  shift, and go to state 170
    '<'  shift, and go to state 171
    '>'  shift, and go to state 172
    '+'  shift, and go to state 173
    '-'  shift, and go to state 174
    '*'  shift, and go to state 175
    '/'  shift, and go to state 176
    '%'  shift, and go to state 177

    $default  reduce using rule 136 (expr)

    Conflict between rule 136 and token '|' resolved as reduce (%left '|').
    Conflict between rule 136 and token '^' resolved as shift ('|' < '^').
    Conflict between rule 136 and token '&' resolved as shift ('|' < '&').
    Conflict between rule 136 and token '<' resolved as shift ('|' < '<').
    Conflict between rule 136 and token '>' resolved as shift ('|' < '>').
    Conflict between rule 136 and token '+' resolved as shift ('|' < '+').
    Conflict between rule 136 and token '-' resolved as shift ('|' < '-').
    Conflict between rule 136 and token '*' resolved as shift ('|' < '*').
    Conflict between rule 136 and token '/' resolved as shift ('|' < '/').
    Conflict between rule 136 and token '%' resolved as shift ('|' < '%').


state 213

  127 expr: expr . '+' expr
  128     | expr . '-' expr
  129     | expr . '*' expr
  130     | expr . '/' expr
  131     | expr . '%' expr
  132     | expr . '<' '<' expr
  133     | expr . '>' '>' expr
  134     | expr . '&' expr
  135     | expr . '^' expr
  135     | expr '^' expr .  ['|', '^', ';', ')']
  136     | expr . '|' expr

    '&'  shift, and go to state 170
    '<'  shift, and go to state 171
    '>'  shift, and go to state 172
    '+'  shift, and go to state 173
    '-'  shift, and go to state 174
    '*'  shift, and go to state 175
    '/'  shift, and go to state 176
    '%'  shift, and go to state 177

    $default  reduce using rule 135 (expr)

    Conflict between rule 135 and token '|' resolved as reduce ('|' < '^').
    Conflict between rule 135 and token '^' resolved as reduce (%left '^').
    Conflict between rule 135 and token '&' resolved as shift ('^' < '&').
    Conflict between rule 135 and token '<' resolved as shift ('^' < '<').
    Conflict between rule 135 and token '>' resolved as shift ('^' < '>').
    Conflict between rule 135 and token '+' resolved as shift ('^' < '+').
    Conflict between rule 135 and token '-' resolved as shift ('^' < '-').
    Conflict between rule 135 and token '*' resolved as shift ('^' < '*').
    Conflict between rule 135 and token '/' resolved as shift ('^' < '/').
    Conflict between rule 135 and token '%' resolved as shift ('^' < '%').


state 214

  127 expr: expr . '+' expr
  128     | expr . '-' expr
  129     | expr . '*' expr
  130     | expr . '/' expr
  131     | expr . '%' expr
  132     | expr . '<' '<' expr
  133     | expr . '>' '>' expr
  134     | expr . '&' expr
  134     | expr '&' expr .  ['|', '^', '&', ';', ')']
  135     | expr . '^' expr
  136     | expr . '|' expr

    '<'  shift, and go to state 171
    '>'  shift, and go to state 172
    '+'  shift, and go to state 173
    '-'  shift, and go to state 174
    '*'  shift, and go to state 175
    '/'  shift, and go to state 176
    '%'  shift, and go to state 177

    $default  reduce using rule 134 (expr)

    Conflict between rule 134 and token '|' resolved as reduce ('|' < '&').
    Conflict between rule 134 and token '^' resolved as reduce ('^' < '&').
    Conflict between rule 134 and token '&' resolved as reduce (%left '&').
    Conflict between rule 134 and token '<' resolved as shift ('&' < '<').
    Conflict between rule 134 and token '>' resolved as shift ('&' < '>').
    Conflict between rule 134 and token '+' resolved as shift ('&' < '+').
    Conflict between rule 134 and token '-' resolved as shift ('&' < '-').
    Conflict between rule 134 and token '*' resolved as shift ('&' < '*').
    Conflict between rule 134 and token '/' resolved as shift ('&' < '/').
    Conflict between rule 134 and token '%' resolved as shift ('&' < '%').


state 215

  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'
  126 expr: . con
  127     | . expr '+' expr
  128     | . expr '-' expr
  129     | . expr '*' expr
  130     | . expr '/' expr
  131     | . expr '%' expr
  132     | . expr '<' '<' expr
  132     | expr '<' '<' . expr
  133     | . expr '>' '>' expr
  134     | . expr '&' expr
  135     | . expr '^' expr
  136     | . expr '|' expr

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con   go to state 123
    expr  go to state 244


state 216

  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'
  126 expr: . con
  127     | . expr '+' expr
  128     | . expr '-' expr
  129     | . expr '*' expr
  130     | . expr '/' expr
  131     | . expr '%' expr
  132     | . expr '<' '<' expr
  133     | . expr '>' '>' expr
  133     | expr '>' '>' . expr
  134     | . expr '&' expr
  135     | . expr '^' expr
  136     | . expr '|' expr

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con   go to state 123
    expr  go to state 245


state 217

  127 expr: expr . '+' expr
  127     | expr '+' expr .  ['|', '^', '&', '<', '>', '+', '-', ';', ')']
  128     | expr . '-' expr
  129     | expr . '*' expr
  130     | expr . '/' expr
  131     | expr . '%' expr
  132     | expr . '<' '<' expr
  133     | expr . '>' '>' expr
  134     | expr . '&' expr
  135     | expr . '^' expr
  136     | expr . '|' expr

    '*'  shift, and go to state 175
    '/'  shift, and go to state 176
    '%'  shift, and go to state 177

    $default  reduce using rule 127 (expr)

    Conflict between rule 127 and token '|' resolved as reduce ('|' < '+').
    Conflict between rule 127 and token '^' resolved as reduce ('^' < '+').
    Conflict between rule 127 and token '&' resolved as reduce ('&' < '+').
    Conflict between rule 127 and token '<' resolved as reduce ('<' < '+').
    Conflict between rule 127 and token '>' resolved as reduce ('>' < '+').
    Conflict between rule 127 and token '+' resolved as reduce (%left '+').
    Conflict between rule 127 and token '-' resolved as reduce (%left '-').
    Conflict between rule 127 and token '*' resolved as shift ('+' < '*').
    Conflict between rule 127 and token '/' resolved as shift ('+' < '/').
    Conflict between rule 127 and token '%' resolved as shift ('+' < '%').


state 218

  127 expr: expr . '+' expr
  128     | expr . '-' expr
  128     | expr '-' expr .  ['|', '^', '&', '<', '>', '+', '-', ';', ')']
  129     | expr . '*' expr
  130     | expr . '/' expr
  131     | expr . '%' expr
  132     | expr . '<' '<' expr
  133     | expr . '>' '>' expr
  134     | expr . '&' expr
  135     | expr . '^' expr
  136     | expr . '|' expr

    '*'  shift, and go to state 175
    '/'  shift, and go to state 176
    '%'  shift, and go to state 177

    $default  reduce using rule 128 (expr)

    Conflict between rule 128 and token '|' resolved as reduce ('|' < '-').
    Conflict between rule 128 and token '^' resolved as reduce ('^' < '-').
    Conflict between rule 128 and token '&' resolved as reduce ('&' < '-').
    Conflict between rule 128 and token '<' resolved as reduce ('<' < '-').
    Conflict between rule 128 and token '>' resolved as reduce ('>' < '-').
    Conflict between rule 128 and token '+' resolved as reduce (%left '+').
    Conflict between rule 128 and token '-' resolved as reduce (%left '-').
    Conflict between rule 128 and token '*' resolved as shift ('-' < '*').
    Conflict between rule 128 and token '/' resolved as shift ('-' < '/').
    Conflict between rule 128 and token '%' resolved as shift ('-' < '%').


state 219

  127 expr: expr . '+' expr
  128     | expr . '-' expr
  129     | expr . '*' expr
  129     | expr '*' expr .  ['|', '^', '&', '<', '>', '+', '-', '*', '/', '%', ';', ')']
  130     | expr . '/' expr
  131     | expr . '%' expr
  132     | expr . '<' '<' expr
  133     | expr . '>' '>' expr
  134     | expr . '&' expr
  135     | expr . '^' expr
  136     | expr . '|' expr

    $default  reduce using rule 129 (expr)

    Conflict between rule 129 and token '|' resolved as reduce ('|' < '*').
    Conflict between rule 129 and token '^' resolved as reduce ('^' < '*').
    Conflict between rule 129 and token '&' resolved as reduce ('&' < '*').
    Conflict between rule 129 and token '<' resolved as reduce ('<' < '*').
    Conflict between rule 129 and token '>' resolved as reduce ('>' < '*').
    Conflict between rule 129 and token '+' resolved as reduce ('+' < '*').
    Conflict between rule 129 and token '-' resolved as reduce ('-' < '*').
    Conflict between rule 129 and token '*' resolved as reduce (%left '*').
    Conflict between rule 129 and token '/' resolved as reduce (%left '/').
    Conflict between rule 129 and token '%' resolved as reduce (%left '%').


state 220

  127 expr: expr . '+' expr
  128     | expr . '-' expr
  129     | expr . '*' expr
  130     | expr . '/' expr
  130     | expr '/' expr .  ['|', '^', '&', '<', '>', '+', '-', '*', '/', '%', ';', ')']
  131     | expr . '%' expr
  132     | expr . '<' '<' expr
  133     | expr . '>' '>' expr
  134     | expr . '&' expr
  135     | expr . '^' expr
  136     | expr . '|' expr

    $default  reduce using rule 130 (expr)

    Conflict between rule 130 and token '|' resolved as reduce ('|' < '/').
    Conflict between rule 130 and token '^' resolved as reduce ('^' < '/').
    Conflict between rule 130 and token '&' resolved as reduce ('&' < '/').
    Conflict between rule 130 and token '<' resolved as reduce ('<' < '/').
    Conflict between rule 130 and token '>' resolved as reduce ('>' < '/').
    Conflict between rule 130 and token '+' resolved as reduce ('+' < '/').
    Conflict between rule 130 and token '-' resolved as reduce ('-' < '/').
    Conflict between rule 130 and token '*' resolved as reduce (%left '*').
    Conflict between rule 130 and token '/' resolved as reduce (%left '/').
    Conflict between rule 130 and token '%' resolved as reduce (%left '%').


state 221

  127 expr: expr . '+' expr
  128     | expr . '-' expr
  129     | expr . '*' expr
  130     | expr . '/' expr
  131     | expr . '%' expr
  131     | expr '%' expr .  ['|', '^', '&', '<', '>', '+', '-', '*', '/', '%', ';', ')']
  132     | expr . '<' '<' expr
  133     | expr . '>' '>' expr
  134     | expr . '&' expr
  135     | expr . '^' expr
  136     | expr . '|' expr

    $default  reduce using rule 131 (expr)

    Conflict between rule 131 and token '|' resolved as reduce ('|' < '%').
    Conflict between rule 131 and token '^' resolved as reduce ('^' < '%').
    Conflict between rule 131 and token '&' resolved as reduce ('&' < '%').
    Conflict between rule 131 and token '<' resolved as reduce ('<' < '%').
    Conflict between rule 131 and token '>' resolved as reduce ('>' < '%').
    Conflict between rule 131 and token '+' resolved as reduce ('+' < '%').
    Conflict between rule 131 and token '-' resolved as reduce ('-' < '%').
    Conflict between rule 131 and token '*' resolved as reduce (%left '*').
    Conflict between rule 131 and token '/' resolved as reduce (%left '/').
    Conflict between rule 131 and token '%' resolved as reduce (%left '%').


state 222

  107 nmem: nam '(' LLREG '*' . con ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con  go to state 246


state 223

   99 omem: con '(' LLREG '*' . con ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con  go to state 247


state 224

   96 omem: con '(' LLREG ')' .  [':', ';', ',']
  100     | con '(' LLREG ')' . '(' LLREG '*' con ')'
  101     | con '(' LLREG ')' . '(' LSREG '*' con ')'

    '('  shift, and go to state 248

    $default  reduce using rule 96 (omem)


state 225

   98 omem: con '(' LSREG ')' .

    $default  reduce using rule 98 (omem)


state 226

   97 omem: con '(' LSP ')' .

    $default  reduce using rule 97 (omem)


state 227

   91 imm: '$' '(' '-' LFCONST . ')'

    ')'  shift, and go to state 249


state 228

   90 imm: '$' '(' LFCONST ')' .

    $default  reduce using rule 90 (imm)


state 229

   75 rel: con '(' LPC ')' .

    $default  reduce using rule 75 (rel)


state 230

   43 spec1: nam '/' con ',' . imm
   86 imm: . '$' con
   87    | . '$' nam
   88    | . '$' LSCONST
   89    | . '$' LFCONST
   90    | . '$' '(' LFCONST ')'
   91    | . '$' '(' '-' LFCONST ')'
   92    | . '$' '-' LFCONST

    '$'  shift, and go to state 56

    imm  go to state 250


state 231

  123 con2: '-' . LCONST
  125     | '-' . LCONST '-' LCONST

    LCONST  shift, and go to state 251


state 232

  122 con2: LCONST .  [';']
  124     | LCONST . '-' LCONST

    '-'  shift, and go to state 252

    $default  reduce using rule 122 (con2)


state 233

   85 imm2: '$' con2 .

    $default  reduce using rule 85 (imm2)


state 234

   45 spec2: mem ',' con ',' . imm2
   85 imm2: . '$' con2

    '$'  shift, and go to state 191

    imm2  go to state 253


state 235

   62 spec11: mem ',' con ',' . imm
   86 imm: . '$' con
   87    | . '$' nam
   88    | . '$' LSCONST
   89    | . '$' LFCONST
   90    | . '$' '(' LFCONST ')'
   91    | . '$' '(' '-' LFCONST ')'
   92    | . '$' '-' LFCONST

    '$'  shift, and go to state 56

    imm  go to state 254


state 236

   51 spec5: rim ',' rem ':' . LLREG

    LLREG  shift, and go to state 255


state 237

   53 spec6: rim ',' rem ':' . LSREG

    LSREG  shift, and go to state 256


state 238

   57 spec8: reg ',' rem ',' . con
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con  go to state 257


state 239

   58 spec9: imm ',' rem ',' . reg
   78 reg: . LBREG
   79    | . LFREG
   80    | . LLREG
   81    | . LMREG
   82    | . LSP
   83    | . LSREG
   84    | . LXREG

    LBREG  shift, and go to state 36
    LLREG  shift, and go to state 37
    LSREG  shift, and go to state 38
    LFREG  shift, and go to state 39
    LMREG  shift, and go to state 40
    LXREG  shift, and go to state 41
    LSP    shift, and go to state 42

    reg  go to state 258


state 240

  109 nam: LNAME '<' '>' offset '(' . LSB ')'

    LSB  shift, and go to state 259


state 241

  108 nam: LNAME offset '(' pointer ')' .

    $default  reduce using rule 108 (nam)


state 242

  104 omem: '(' LLREG '*' con ')' .

    $default  reduce using rule 104 (omem)


state 243

  105 omem: '(' LLREG ')' '(' LLREG . '*' con ')'

    '*'  shift, and go to state 260


state 244

  127 expr: expr . '+' expr
  128     | expr . '-' expr
  129     | expr . '*' expr
  130     | expr . '/' expr
  131     | expr . '%' expr
  132     | expr . '<' '<' expr
  132     | expr '<' '<' expr .  ['|', '^', '&', '<', '>', ';', ')']
  133     | expr . '>' '>' expr
  134     | expr . '&' expr
  135     | expr . '^' expr
  136     | expr . '|' expr

    '+'  shift, and go to state 173
    '-'  shift, and go to state 174
    '*'  shift, and go to state 175
    '/'  shift, and go to state 176
    '%'  shift, and go to state 177

    $default  reduce using rule 132 (expr)

    Conflict between rule 132 and token '|' resolved as reduce ('|' < '<').
    Conflict between rule 132 and token '^' resolved as reduce ('^' < '<').
    Conflict between rule 132 and token '&' resolved as reduce ('&' < '<').
    Conflict between rule 132 and token '<' resolved as reduce (%left '<').
    Conflict between rule 132 and token '>' resolved as reduce (%left '>').
    Conflict between rule 132 and token '+' resolved as shift ('<' < '+').
    Conflict between rule 132 and token '-' resolved as shift ('<' < '-').
    Conflict between rule 132 and token '*' resolved as shift ('<' < '*').
    Conflict between rule 132 and token '/' resolved as shift ('<' < '/').
    Conflict between rule 132 and token '%' resolved as shift ('<' < '%').


state 245

  127 expr: expr . '+' expr
  128     | expr . '-' expr
  129     | expr . '*' expr
  130     | expr . '/' expr
  131     | expr . '%' expr
  132     | expr . '<' '<' expr
  133     | expr . '>' '>' expr
  133     | expr '>' '>' expr .  ['|', '^', '&', '<', '>', ';', ')']
  134     | expr . '&' expr
  135     | expr . '^' expr
  136     | expr . '|' expr

    '+'  shift, and go to state 173
    '-'  shift, and go to state 174
    '*'  shift, and go to state 175
    '/'  shift, and go to state 176
    '%'  shift, and go to state 177

    $default  reduce using rule 133 (expr)

    Conflict between rule 133 and token '|' resolved as reduce ('|' < '>').
    Conflict between rule 133 and token '^' resolved as reduce ('^' < '>').
    Conflict between rule 133 and token '&' resolved as reduce ('&' < '>').
    Conflict between rule 133 and token '<' resolved as reduce (%left '<').
    Conflict between rule 133 and token '>' resolved as reduce (%left '>').
    Conflict between rule 133 and token '+' resolved as shift ('>' < '+').
    Conflict between rule 133 and token '-' resolved as shift ('>' < '-').
    Conflict between rule 133 and token '*' resolved as shift ('>' < '*').
    Conflict between rule 133 and token '/' resolved as shift ('>' < '/').
    Conflict between rule 133 and token '%' resolved as shift ('>' < '%').


state 246

  107 nmem: nam '(' LLREG '*' con . ')'

    ')'  shift, and go to state 261


state 247

   99 omem: con '(' LLREG '*' con . ')'

    ')'  shift, and go to state 262


state 248

  100 omem: con '(' LLREG ')' '(' . LLREG '*' con ')'
  101     | con '(' LLREG ')' '(' . LSREG '*' con ')'

    LLREG  shift, and go to state 263
    LSREG  shift, and go to state 264


state 249

   91 imm: '$' '(' '-' LFCONST ')' .

    $default  reduce using rule 91 (imm)


state 250

   43 spec1: nam '/' con ',' imm .

    $default  reduce using rule 43 (spec1)


state 251

  123 con2: '-' LCONST .  [';']
  125     | '-' LCONST . '-' LCONST

    '-'  shift, and go to state 265

    $default  reduce using rule 123 (con2)


state 252

  124 con2: LCONST '-' . LCONST

    LCONST  shift, and go to state 266


state 253

   45 spec2: mem ',' con ',' imm2 .

    $default  reduce using rule 45 (spec2)


state 254

   62 spec11: mem ',' con ',' imm .

    $default  reduce using rule 62 (spec11)


state 255

   51 spec5: rim ',' rem ':' LLREG .

    $default  reduce using rule 51 (spec5)


state 256

   53 spec6: rim ',' rem ':' LSREG .

    $default  reduce using rule 53 (spec6)


state 257

   57 spec8: reg ',' rem ',' con .

    $default  reduce using rule 57 (spec8)


state 258

   58 spec9: imm ',' rem ',' reg .

    $default  reduce using rule 58 (spec9)


state 259

  109 nam: LNAME '<' '>' offset '(' LSB . ')'

    ')'  shift, and go to state 267


state 260

  105 omem: '(' LLREG ')' '(' LLREG '*' . con ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con  go to state 268


state 261

  107 nmem: nam '(' LLREG '*' con ')' .

    $default  reduce using rule 107 (nmem)


state 262

   99 omem: con '(' LLREG '*' con ')' .

    $default  reduce using rule 99 (omem)


state 263

  100 omem: con '(' LLREG ')' '(' LLREG . '*' con ')'

    '*'  shift, and go to state 269


state 264

  101 omem: con '(' LLREG ')' '(' LSREG . '*' con ')'

    '*'  shift, and go to state 270


state 265

  125 con2: '-' LCONST '-' . LCONST

    LCONST  shift, and go to state 271


state 266

  124 con2: LCONST '-' LCONST .

    $default  reduce using rule 124 (con2)


state 267

  109 nam: LNAME '<' '>' offset '(' LSB ')' .

    $default  reduce using rule 109 (nam)


state 268

  105 omem: '(' LLREG ')' '(' LLREG '*' con . ')'

    ')'  shift, and go to state 272


state 269

  100 omem: con '(' LLREG ')' '(' LLREG '*' . con ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con  go to state 273


state 270

  101 omem: con '(' LLREG ')' '(' LSREG '*' . con ')'
  116 con: . LCONST
  117    | . LVAR
  118    | . '-' con
  119    | . '+' con
  120    | . '~' con
  121    | . '(' expr ')'

    '+'     shift, and go to state 33
    '-'     shift, and go to state 34
    LCONST  shift, and go to state 35
    LVAR    shift, and go to state 44
    '('     shift, and go to state 84
    '~'     shift, and go to state 47

    con  go to state 274


state 271

  125 con2: '-' LCONST '-' LCONST .

    $default  reduce using rule 125 (con2)


state 272

  105 omem: '(' LLREG ')' '(' LLREG '*' con ')' .

    $default  reduce using rule 105 (omem)


state 273

  100 omem: con '(' LLREG ')' '(' LLREG '*' con . ')'

    ')'  shift, and go to state 275


state 274

  101 omem: con '(' LLREG ')' '(' LSREG '*' con . ')'

    ')'  shift, and go to state 276


state 275

  100 omem: con '(' LLREG ')' '(' LLREG '*' con ')' .

    $default  reduce using rule 100 (omem)


state 276

  101 omem: con '(' LLREG ')' '(' LSREG '*' con ')' .

    $default  reduce using rule 101 (omem)
