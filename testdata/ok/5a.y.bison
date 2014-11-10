Terminals unused in grammar

   LTYPEG
   LTYPEX


Grammar

    0 $accept: prog $end

    1 prog: /* empty */

    2 $@1: /* empty */

    3 prog: prog $@1 line

    4 $@2: /* empty */

    5 line: LLAB ':' $@2 line

    6 $@3: /* empty */

    7 line: LNAME ':' $@3 line
    8     | LNAME '=' expr ';'
    9     | LVAR '=' expr ';'
   10     | ';'
   11     | inst ';'
   12     | error ';'

   13 inst: LTYPE1 cond imsr ',' spreg ',' reg
   14     | LTYPE1 cond imsr ',' spreg ','
   15     | LTYPE1 cond imsr ',' reg
   16     | LTYPE2 cond imsr ',' reg
   17     | LTYPE3 cond gen ',' gen
   18     | LTYPE4 cond comma rel
   19     | LTYPE4 cond comma nireg
   20     | LTYPEBX comma ireg
   21     | LTYPE5 comma rel
   22     | LTYPE6 cond comma gen
   23     | LTYPE7 cond imsr ',' spreg comma
   24     | LTYPE8 cond ioreg ',' '[' reglist ']'
   25     | LTYPE8 cond '[' reglist ']' ',' ioreg
   26     | LTYPE9 cond reg ',' ireg ',' reg
   27     | LTYPE9 cond reg ',' ireg comma
   28     | LTYPE9 cond comma ireg ',' reg
   29     | LTYPEA cond comma
   30     | LTYPEB name ',' imm
   31     | LTYPEB name ',' con ',' imm
   32     | LTYPEB name ',' con ',' imm '-' con
   33     | LTYPEC name '/' con ',' ximm
   34     | LTYPED cond reg comma
   35     | LTYPEH comma ximm
   36     | LTYPEI cond freg ',' freg
   37     | LTYPEK cond frcon ',' freg
   38     | LTYPEK cond frcon ',' LFREG ',' freg
   39     | LTYPEL cond freg ',' freg comma
   40     | LTYPEJ cond con ',' expr ',' spreg ',' creg ',' creg oexpr
   41     | LTYPEM cond reg ',' reg ',' regreg
   42     | LTYPEN cond reg ',' reg ',' reg ',' spreg
   43     | LTYPEPLD oreg
   44     | LTYPEPC gen ',' gen
   45     | LTYPEF gen ',' gen
   46     | LTYPEE comma

   47 cond: /* empty */
   48     | cond LCOND
   49     | cond LS

   50 comma: /* empty */
   51      | ',' comma

   52 rel: con '(' LPC ')'
   53    | LNAME offset
   54    | LLAB offset

   55 ximm: '$' con
   56     | '$' oreg
   57     | '$' '*' '$' oreg
   58     | '$' LSCONST
   59     | fcon

   60 fcon: '$' LFCONST
   61     | '$' '-' LFCONST

   62 reglist: spreg
   63        | spreg '-' spreg
   64        | spreg comma reglist

   65 gen: reg
   66    | ximm
   67    | shift
   68    | shift '(' spreg ')'
   69    | LPSR
   70    | LFCR
   71    | con
   72    | oreg
   73    | freg

   74 nireg: ireg
   75      | name

   76 ireg: '(' spreg ')'

   77 ioreg: ireg
   78      | con '(' sreg ')'

   79 oreg: name
   80     | name '(' sreg ')'
   81     | ioreg

   82 imsr: reg
   83     | imm
   84     | shift

   85 imm: '$' con

   86 reg: spreg

   87 regreg: '(' spreg ',' spreg ')'

   88 shift: spreg '<' '<' rcon
   89      | spreg '>' '>' rcon
   90      | spreg '-' '>' rcon
   91      | spreg LAT '>' rcon

   92 rcon: spreg
   93     | con

   94 sreg: LREG
   95     | LPC
   96     | LR '(' expr ')'

   97 spreg: sreg
   98      | LSP

   99 creg: LCREG
  100     | LC '(' expr ')'

  101 frcon: freg
  102      | fcon

  103 freg: LFREG
  104     | LF '(' con ')'

  105 name: con '(' pointer ')'
  106     | LNAME offset '(' pointer ')'
  107     | LNAME '<' '>' offset '(' LSB ')'

  108 offset: /* empty */
  109       | '+' con
  110       | '-' con

  111 pointer: LSB
  112        | LSP
  113        | LFP

  114 con: LCONST
  115    | LVAR
  116    | '-' con
  117    | '+' con
  118    | '~' con
  119    | '(' expr ')'

  120 oexpr: /* empty */
  121      | ',' expr

  122 expr: con
  123     | expr '+' expr
  124     | expr '-' expr
  125     | expr '*' expr
  126     | expr '/' expr
  127     | expr '%' expr
  128     | expr '<' '<' expr
  129     | expr '>' '>' expr
  130     | expr '&' expr
  131     | expr '^' expr
  132     | expr '|' expr


Terminals, with rules where they appear

$end (0) 0
'$' (36) 55 56 57 58 60 61 85
'%' (37) 127
'&' (38) 130
'(' (40) 52 68 76 78 80 87 96 100 104 105 106 107 119
')' (41) 52 68 76 78 80 87 96 100 104 105 106 107 119
'*' (42) 57 125
'+' (43) 109 117 123
',' (44) 13 14 15 16 17 23 24 25 26 27 28 30 31 32 33 36 37 38 39 40
    41 42 44 45 51 87 121
'-' (45) 32 61 63 90 110 116 124
'/' (47) 33 126
':' (58) 5 7
';' (59) 8 9 10 11 12
'<' (60) 88 107 128
'=' (61) 8 9
'>' (62) 89 90 91 107 129
'[' (91) 24 25
']' (93) 24 25
'^' (94) 131
'|' (124) 132
'~' (126) 118
error (256) 12
LTYPE1 (258) 13 14 15
LTYPE2 (259) 16
LTYPE3 (260) 17
LTYPE4 (261) 18 19
LTYPE5 (262) 21
LTYPE6 (263) 22
LTYPE7 (264) 23
LTYPE8 (265) 24 25
LTYPE9 (266) 26 27 28
LTYPEA (267) 29
LTYPEB (268) 30 31 32
LTYPEC (269) 33
LTYPED (270) 34
LTYPEE (271) 46
LTYPEG (272)
LTYPEH (273) 35
LTYPEI (274) 36
LTYPEJ (275) 40
LTYPEK (276) 37 38
LTYPEL (277) 39
LTYPEM (278) 41
LTYPEN (279) 42
LTYPEBX (280) 20
LTYPEPLD (281) 43
LCONST (282) 114
LSP (283) 98 112
LSB (284) 107 111
LFP (285) 113
LPC (286) 52 95
LTYPEX (287)
LTYPEPC (288) 44
LTYPEF (289) 45
LR (290) 96
LREG (291) 94
LF (292) 104
LFREG (293) 38 103
LC (294) 100
LCREG (295) 99
LPSR (296) 69
LFCR (297) 70
LCOND (298) 48
LS (299) 49
LAT (300) 91
LFCONST (301) 60 61
LSCONST (302) 58
LNAME (303) 7 8 53 106 107
LLAB (304) 5 54
LVAR (305) 9 115


Nonterminals, with rules where they appear

$accept (71)
    on left: 0
prog (72)
    on left: 1 3, on right: 0 3
$@1 (73)
    on left: 2, on right: 3
line (74)
    on left: 5 7 8 9 10 11 12, on right: 3 5 7
$@2 (75)
    on left: 4, on right: 5
$@3 (76)
    on left: 6, on right: 7
inst (77)
    on left: 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
    31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46, on right: 11
cond (78)
    on left: 47 48 49, on right: 13 14 15 16 17 18 19 22 23 24 25 26
    27 28 29 34 36 37 38 39 40 41 42 48 49
comma (79)
    on left: 50 51, on right: 18 19 20 21 22 23 27 28 29 34 35 39 46
    51 64
rel (80)
    on left: 52 53 54, on right: 18 21
ximm (81)
    on left: 55 56 57 58 59, on right: 33 35 66
fcon (82)
    on left: 60 61, on right: 59 102
reglist (83)
    on left: 62 63 64, on right: 24 25 64
gen (84)
    on left: 65 66 67 68 69 70 71 72 73, on right: 17 22 44 45
nireg (85)
    on left: 74 75, on right: 19
ireg (86)
    on left: 76, on right: 20 26 27 28 74 77
ioreg (87)
    on left: 77 78, on right: 24 25 81
oreg (88)
    on left: 79 80 81, on right: 43 56 57 72
imsr (89)
    on left: 82 83 84, on right: 13 14 15 16 23
imm (90)
    on left: 85, on right: 30 31 32 83
reg (91)
    on left: 86, on right: 13 15 16 26 27 28 34 41 42 65 82
regreg (92)
    on left: 87, on right: 41
shift (93)
    on left: 88 89 90 91, on right: 67 68 84
rcon (94)
    on left: 92 93, on right: 88 89 90 91
sreg (95)
    on left: 94 95 96, on right: 78 80 97
spreg (96)
    on left: 97 98, on right: 13 14 23 40 42 62 63 64 68 76 86 87 88
    89 90 91 92
creg (97)
    on left: 99 100, on right: 40
frcon (98)
    on left: 101 102, on right: 37 38
freg (99)
    on left: 103 104, on right: 36 37 38 39 73 101
name (100)
    on left: 105 106 107, on right: 30 31 32 33 75 79 80
offset (101)
    on left: 108 109 110, on right: 53 54 106 107
pointer (102)
    on left: 111 112 113, on right: 105 106
con (103)
    on left: 114 115 116 117 118 119, on right: 31 32 33 40 52 55 71
    78 85 93 104 105 109 110 116 117 118 122
oexpr (104)
    on left: 120 121, on right: 40
expr (105)
    on left: 122 123 124 125 126 127 128 129 130 131 132, on right:
    8 9 40 96 100 119 121 123 124 125 126 127 128 129 130 131 132


state 0

    0 $accept: . prog $end
    1 prog: .
    3     | . prog $@1 line

    $default  reduce using rule 1 (prog)

    prog  go to state 1


state 1

    0 $accept: prog . $end
    2 $@1: .  [error, LTYPE1, LTYPE2, LTYPE3, LTYPE4, LTYPE5, LTYPE6, LTYPE7, LTYPE8, LTYPE9, LTYPEA, LTYPEB, LTYPEC, LTYPED, LTYPEE, LTYPEH, LTYPEI, LTYPEJ, LTYPEK, LTYPEL, LTYPEM, LTYPEN, LTYPEBX, LTYPEPLD, LTYPEPC, LTYPEF, LNAME, LLAB, LVAR, ';']
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
    8     | . LNAME '=' expr ';'
    9     | . LVAR '=' expr ';'
   10     | . ';'
   11     | . inst ';'
   12     | . error ';'
   13 inst: . LTYPE1 cond imsr ',' spreg ',' reg
   14     | . LTYPE1 cond imsr ',' spreg ','
   15     | . LTYPE1 cond imsr ',' reg
   16     | . LTYPE2 cond imsr ',' reg
   17     | . LTYPE3 cond gen ',' gen
   18     | . LTYPE4 cond comma rel
   19     | . LTYPE4 cond comma nireg
   20     | . LTYPEBX comma ireg
   21     | . LTYPE5 comma rel
   22     | . LTYPE6 cond comma gen
   23     | . LTYPE7 cond imsr ',' spreg comma
   24     | . LTYPE8 cond ioreg ',' '[' reglist ']'
   25     | . LTYPE8 cond '[' reglist ']' ',' ioreg
   26     | . LTYPE9 cond reg ',' ireg ',' reg
   27     | . LTYPE9 cond reg ',' ireg comma
   28     | . LTYPE9 cond comma ireg ',' reg
   29     | . LTYPEA cond comma
   30     | . LTYPEB name ',' imm
   31     | . LTYPEB name ',' con ',' imm
   32     | . LTYPEB name ',' con ',' imm '-' con
   33     | . LTYPEC name '/' con ',' ximm
   34     | . LTYPED cond reg comma
   35     | . LTYPEH comma ximm
   36     | . LTYPEI cond freg ',' freg
   37     | . LTYPEK cond frcon ',' freg
   38     | . LTYPEK cond frcon ',' LFREG ',' freg
   39     | . LTYPEL cond freg ',' freg comma
   40     | . LTYPEJ cond con ',' expr ',' spreg ',' creg ',' creg oexpr
   41     | . LTYPEM cond reg ',' reg ',' regreg
   42     | . LTYPEN cond reg ',' reg ',' reg ',' spreg
   43     | . LTYPEPLD oreg
   44     | . LTYPEPC gen ',' gen
   45     | . LTYPEF gen ',' gen
   46     | . LTYPEE comma

    error     shift, and go to state 4
    LTYPE1    shift, and go to state 5
    LTYPE2    shift, and go to state 6
    LTYPE3    shift, and go to state 7
    LTYPE4    shift, and go to state 8
    LTYPE5    shift, and go to state 9
    LTYPE6    shift, and go to state 10
    LTYPE7    shift, and go to state 11
    LTYPE8    shift, and go to state 12
    LTYPE9    shift, and go to state 13
    LTYPEA    shift, and go to state 14
    LTYPEB    shift, and go to state 15
    LTYPEC    shift, and go to state 16
    LTYPED    shift, and go to state 17
    LTYPEE    shift, and go to state 18
    LTYPEH    shift, and go to state 19
    LTYPEI    shift, and go to state 20
    LTYPEJ    shift, and go to state 21
    LTYPEK    shift, and go to state 22
    LTYPEL    shift, and go to state 23
    LTYPEM    shift, and go to state 24
    LTYPEN    shift, and go to state 25
    LTYPEBX   shift, and go to state 26
    LTYPEPLD  shift, and go to state 27
    LTYPEPC   shift, and go to state 28
    LTYPEF    shift, and go to state 29
    LNAME     shift, and go to state 30
    LLAB      shift, and go to state 31
    LVAR      shift, and go to state 32
    ';'       shift, and go to state 33

    line  go to state 34
    inst  go to state 35


state 4

   12 line: error . ';'

    ';'  shift, and go to state 36


state 5

   13 inst: LTYPE1 . cond imsr ',' spreg ',' reg
   14     | LTYPE1 . cond imsr ',' spreg ','
   15     | LTYPE1 . cond imsr ',' reg
   47 cond: .
   48     | . cond LCOND
   49     | . cond LS

    $default  reduce using rule 47 (cond)

    cond  go to state 37


state 6

   16 inst: LTYPE2 . cond imsr ',' reg
   47 cond: .
   48     | . cond LCOND
   49     | . cond LS

    $default  reduce using rule 47 (cond)

    cond  go to state 38


state 7

   17 inst: LTYPE3 . cond gen ',' gen
   47 cond: .
   48     | . cond LCOND
   49     | . cond LS

    $default  reduce using rule 47 (cond)

    cond  go to state 39


state 8

   18 inst: LTYPE4 . cond comma rel
   19     | LTYPE4 . cond comma nireg
   47 cond: .
   48     | . cond LCOND
   49     | . cond LS

    $default  reduce using rule 47 (cond)

    cond  go to state 40


state 9

   21 inst: LTYPE5 . comma rel
   50 comma: .  ['+', '-', LCONST, LNAME, LLAB, LVAR, '(', '~']
   51      | . ',' comma

    ','  shift, and go to state 41

    $default  reduce using rule 50 (comma)

    comma  go to state 42


state 10

   22 inst: LTYPE6 . cond comma gen
   47 cond: .
   48     | . cond LCOND
   49     | . cond LS

    $default  reduce using rule 47 (cond)

    cond  go to state 43


state 11

   23 inst: LTYPE7 . cond imsr ',' spreg comma
   47 cond: .
   48     | . cond LCOND
   49     | . cond LS

    $default  reduce using rule 47 (cond)

    cond  go to state 44


state 12

   24 inst: LTYPE8 . cond ioreg ',' '[' reglist ']'
   25     | LTYPE8 . cond '[' reglist ']' ',' ioreg
   47 cond: .
   48     | . cond LCOND
   49     | . cond LS

    $default  reduce using rule 47 (cond)

    cond  go to state 45


state 13

   26 inst: LTYPE9 . cond reg ',' ireg ',' reg
   27     | LTYPE9 . cond reg ',' ireg comma
   28     | LTYPE9 . cond comma ireg ',' reg
   47 cond: .
   48     | . cond LCOND
   49     | . cond LS

    $default  reduce using rule 47 (cond)

    cond  go to state 46


state 14

   29 inst: LTYPEA . cond comma
   47 cond: .
   48     | . cond LCOND
   49     | . cond LS

    $default  reduce using rule 47 (cond)

    cond  go to state 47


state 15

   30 inst: LTYPEB . name ',' imm
   31     | LTYPEB . name ',' con ',' imm
   32     | LTYPEB . name ',' con ',' imm '-' con
  105 name: . con '(' pointer ')'
  106     | . LNAME offset '(' pointer ')'
  107     | . LNAME '<' '>' offset '(' LSB ')'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LNAME   shift, and go to state 51
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    name  go to state 55
    con   go to state 56


state 16

   33 inst: LTYPEC . name '/' con ',' ximm
  105 name: . con '(' pointer ')'
  106     | . LNAME offset '(' pointer ')'
  107     | . LNAME '<' '>' offset '(' LSB ')'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LNAME   shift, and go to state 51
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    name  go to state 57
    con   go to state 56


state 17

   34 inst: LTYPED . cond reg comma
   47 cond: .
   48     | . cond LCOND
   49     | . cond LS

    $default  reduce using rule 47 (cond)

    cond  go to state 58


state 18

   46 inst: LTYPEE . comma
   50 comma: .  [';']
   51      | . ',' comma

    ','  shift, and go to state 41

    $default  reduce using rule 50 (comma)

    comma  go to state 59


state 19

   35 inst: LTYPEH . comma ximm
   50 comma: .  ['$']
   51      | . ',' comma

    ','  shift, and go to state 41

    $default  reduce using rule 50 (comma)

    comma  go to state 60


state 20

   36 inst: LTYPEI . cond freg ',' freg
   47 cond: .
   48     | . cond LCOND
   49     | . cond LS

    $default  reduce using rule 47 (cond)

    cond  go to state 61


state 21

   40 inst: LTYPEJ . cond con ',' expr ',' spreg ',' creg ',' creg oexpr
   47 cond: .
   48     | . cond LCOND
   49     | . cond LS

    $default  reduce using rule 47 (cond)

    cond  go to state 62


state 22

   37 inst: LTYPEK . cond frcon ',' freg
   38     | LTYPEK . cond frcon ',' LFREG ',' freg
   47 cond: .
   48     | . cond LCOND
   49     | . cond LS

    $default  reduce using rule 47 (cond)

    cond  go to state 63


state 23

   39 inst: LTYPEL . cond freg ',' freg comma
   47 cond: .
   48     | . cond LCOND
   49     | . cond LS

    $default  reduce using rule 47 (cond)

    cond  go to state 64


state 24

   41 inst: LTYPEM . cond reg ',' reg ',' regreg
   47 cond: .
   48     | . cond LCOND
   49     | . cond LS

    $default  reduce using rule 47 (cond)

    cond  go to state 65


state 25

   42 inst: LTYPEN . cond reg ',' reg ',' reg ',' spreg
   47 cond: .
   48     | . cond LCOND
   49     | . cond LS

    $default  reduce using rule 47 (cond)

    cond  go to state 66


state 26

   20 inst: LTYPEBX . comma ireg
   50 comma: .  ['(']
   51      | . ',' comma

    ','  shift, and go to state 41

    $default  reduce using rule 50 (comma)

    comma  go to state 67


state 27

   43 inst: LTYPEPLD . oreg
   76 ireg: . '(' spreg ')'
   77 ioreg: . ireg
   78      | . con '(' sreg ')'
   79 oreg: . name
   80     | . name '(' sreg ')'
   81     | . ioreg
  105 name: . con '(' pointer ')'
  106     | . LNAME offset '(' pointer ')'
  107     | . LNAME '<' '>' offset '(' LSB ')'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LNAME   shift, and go to state 51
    LVAR    shift, and go to state 52
    '('     shift, and go to state 68
    '~'     shift, and go to state 54

    ireg   go to state 69
    ioreg  go to state 70
    oreg   go to state 71
    name   go to state 72
    con    go to state 73


state 28

   44 inst: LTYPEPC . gen ',' gen
   55 ximm: . '$' con
   56     | . '$' oreg
   57     | . '$' '*' '$' oreg
   58     | . '$' LSCONST
   59     | . fcon
   60 fcon: . '$' LFCONST
   61     | . '$' '-' LFCONST
   65 gen: . reg
   66    | . ximm
   67    | . shift
   68    | . shift '(' spreg ')'
   69    | . LPSR
   70    | . LFCR
   71    | . con
   72    | . oreg
   73    | . freg
   76 ireg: . '(' spreg ')'
   77 ioreg: . ireg
   78      | . con '(' sreg ')'
   79 oreg: . name
   80     | . name '(' sreg ')'
   81     | . ioreg
   86 reg: . spreg
   88 shift: . spreg '<' '<' rcon
   89      | . spreg '>' '>' rcon
   90      | . spreg '-' '>' rcon
   91      | . spreg LAT '>' rcon
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP
  103 freg: . LFREG
  104     | . LF '(' con ')'
  105 name: . con '(' pointer ')'
  106     | . LNAME offset '(' pointer ')'
  107     | . LNAME '<' '>' offset '(' LSB ')'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LSP     shift, and go to state 74
    LPC     shift, and go to state 75
    LR      shift, and go to state 76
    LREG    shift, and go to state 77
    LF      shift, and go to state 78
    LFREG   shift, and go to state 79
    LPSR    shift, and go to state 80
    LFCR    shift, and go to state 81
    LNAME   shift, and go to state 51
    LVAR    shift, and go to state 52
    '('     shift, and go to state 68
    '$'     shift, and go to state 82
    '~'     shift, and go to state 54

    ximm   go to state 83
    fcon   go to state 84
    gen    go to state 85
    ireg   go to state 69
    ioreg  go to state 70
    oreg   go to state 86
    reg    go to state 87
    shift  go to state 88
    sreg   go to state 89
    spreg  go to state 90
    freg   go to state 91
    name   go to state 72
    con    go to state 92


state 29

   45 inst: LTYPEF . gen ',' gen
   55 ximm: . '$' con
   56     | . '$' oreg
   57     | . '$' '*' '$' oreg
   58     | . '$' LSCONST
   59     | . fcon
   60 fcon: . '$' LFCONST
   61     | . '$' '-' LFCONST
   65 gen: . reg
   66    | . ximm
   67    | . shift
   68    | . shift '(' spreg ')'
   69    | . LPSR
   70    | . LFCR
   71    | . con
   72    | . oreg
   73    | . freg
   76 ireg: . '(' spreg ')'
   77 ioreg: . ireg
   78      | . con '(' sreg ')'
   79 oreg: . name
   80     | . name '(' sreg ')'
   81     | . ioreg
   86 reg: . spreg
   88 shift: . spreg '<' '<' rcon
   89      | . spreg '>' '>' rcon
   90      | . spreg '-' '>' rcon
   91      | . spreg LAT '>' rcon
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP
  103 freg: . LFREG
  104     | . LF '(' con ')'
  105 name: . con '(' pointer ')'
  106     | . LNAME offset '(' pointer ')'
  107     | . LNAME '<' '>' offset '(' LSB ')'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LSP     shift, and go to state 74
    LPC     shift, and go to state 75
    LR      shift, and go to state 76
    LREG    shift, and go to state 77
    LF      shift, and go to state 78
    LFREG   shift, and go to state 79
    LPSR    shift, and go to state 80
    LFCR    shift, and go to state 81
    LNAME   shift, and go to state 51
    LVAR    shift, and go to state 52
    '('     shift, and go to state 68
    '$'     shift, and go to state 82
    '~'     shift, and go to state 54

    ximm   go to state 83
    fcon   go to state 84
    gen    go to state 93
    ireg   go to state 69
    ioreg  go to state 70
    oreg   go to state 86
    reg    go to state 87
    shift  go to state 88
    sreg   go to state 89
    spreg  go to state 90
    freg   go to state 91
    name   go to state 72
    con    go to state 92


state 30

    7 line: LNAME . ':' $@3 line
    8     | LNAME . '=' expr ';'

    ':'  shift, and go to state 94
    '='  shift, and go to state 95


state 31

    5 line: LLAB . ':' $@2 line

    ':'  shift, and go to state 96


state 32

    9 line: LVAR . '=' expr ';'

    '='  shift, and go to state 97


state 33

   10 line: ';' .

    $default  reduce using rule 10 (line)


state 34

    3 prog: prog $@1 line .

    $default  reduce using rule 3 (prog)


state 35

   11 line: inst . ';'

    ';'  shift, and go to state 98


state 36

   12 line: error ';' .

    $default  reduce using rule 12 (line)


state 37

   13 inst: LTYPE1 cond . imsr ',' spreg ',' reg
   14     | LTYPE1 cond . imsr ',' spreg ','
   15     | LTYPE1 cond . imsr ',' reg
   48 cond: cond . LCOND
   49     | cond . LS
   82 imsr: . reg
   83     | . imm
   84     | . shift
   85 imm: . '$' con
   86 reg: . spreg
   88 shift: . spreg '<' '<' rcon
   89      | . spreg '>' '>' rcon
   90      | . spreg '-' '>' rcon
   91      | . spreg LAT '>' rcon
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP    shift, and go to state 74
    LPC    shift, and go to state 75
    LR     shift, and go to state 76
    LREG   shift, and go to state 77
    LCOND  shift, and go to state 99
    LS     shift, and go to state 100
    '$'    shift, and go to state 101

    imsr   go to state 102
    imm    go to state 103
    reg    go to state 104
    shift  go to state 105
    sreg   go to state 89
    spreg  go to state 90


state 38

   16 inst: LTYPE2 cond . imsr ',' reg
   48 cond: cond . LCOND
   49     | cond . LS
   82 imsr: . reg
   83     | . imm
   84     | . shift
   85 imm: . '$' con
   86 reg: . spreg
   88 shift: . spreg '<' '<' rcon
   89      | . spreg '>' '>' rcon
   90      | . spreg '-' '>' rcon
   91      | . spreg LAT '>' rcon
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP    shift, and go to state 74
    LPC    shift, and go to state 75
    LR     shift, and go to state 76
    LREG   shift, and go to state 77
    LCOND  shift, and go to state 99
    LS     shift, and go to state 100
    '$'    shift, and go to state 101

    imsr   go to state 106
    imm    go to state 103
    reg    go to state 104
    shift  go to state 105
    sreg   go to state 89
    spreg  go to state 90


state 39

   17 inst: LTYPE3 cond . gen ',' gen
   48 cond: cond . LCOND
   49     | cond . LS
   55 ximm: . '$' con
   56     | . '$' oreg
   57     | . '$' '*' '$' oreg
   58     | . '$' LSCONST
   59     | . fcon
   60 fcon: . '$' LFCONST
   61     | . '$' '-' LFCONST
   65 gen: . reg
   66    | . ximm
   67    | . shift
   68    | . shift '(' spreg ')'
   69    | . LPSR
   70    | . LFCR
   71    | . con
   72    | . oreg
   73    | . freg
   76 ireg: . '(' spreg ')'
   77 ioreg: . ireg
   78      | . con '(' sreg ')'
   79 oreg: . name
   80     | . name '(' sreg ')'
   81     | . ioreg
   86 reg: . spreg
   88 shift: . spreg '<' '<' rcon
   89      | . spreg '>' '>' rcon
   90      | . spreg '-' '>' rcon
   91      | . spreg LAT '>' rcon
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP
  103 freg: . LFREG
  104     | . LF '(' con ')'
  105 name: . con '(' pointer ')'
  106     | . LNAME offset '(' pointer ')'
  107     | . LNAME '<' '>' offset '(' LSB ')'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LSP     shift, and go to state 74
    LPC     shift, and go to state 75
    LR      shift, and go to state 76
    LREG    shift, and go to state 77
    LF      shift, and go to state 78
    LFREG   shift, and go to state 79
    LPSR    shift, and go to state 80
    LFCR    shift, and go to state 81
    LCOND   shift, and go to state 99
    LS      shift, and go to state 100
    LNAME   shift, and go to state 51
    LVAR    shift, and go to state 52
    '('     shift, and go to state 68
    '$'     shift, and go to state 82
    '~'     shift, and go to state 54

    ximm   go to state 83
    fcon   go to state 84
    gen    go to state 107
    ireg   go to state 69
    ioreg  go to state 70
    oreg   go to state 86
    reg    go to state 87
    shift  go to state 88
    sreg   go to state 89
    spreg  go to state 90
    freg   go to state 91
    name   go to state 72
    con    go to state 92


state 40

   18 inst: LTYPE4 cond . comma rel
   19     | LTYPE4 cond . comma nireg
   48 cond: cond . LCOND
   49     | cond . LS
   50 comma: .  ['+', '-', LCONST, LNAME, LLAB, LVAR, '(', '~']
   51      | . ',' comma

    LCOND  shift, and go to state 99
    LS     shift, and go to state 100
    ','    shift, and go to state 41

    $default  reduce using rule 50 (comma)

    comma  go to state 108


state 41

   50 comma: .  ['+', '-', LCONST, LSP, LPC, LR, LREG, LF, LFREG, LPSR, LFCR, LNAME, LLAB, LVAR, ';', '(', '$', '~']
   51      | . ',' comma
   51      | ',' . comma

    ','  shift, and go to state 41

    $default  reduce using rule 50 (comma)

    comma  go to state 109


state 42

   21 inst: LTYPE5 comma . rel
   52 rel: . con '(' LPC ')'
   53    | . LNAME offset
   54    | . LLAB offset
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LNAME   shift, and go to state 110
    LLAB    shift, and go to state 111
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    rel  go to state 112
    con  go to state 113


state 43

   22 inst: LTYPE6 cond . comma gen
   48 cond: cond . LCOND
   49     | cond . LS
   50 comma: .  ['+', '-', LCONST, LSP, LPC, LR, LREG, LF, LFREG, LPSR, LFCR, LNAME, LVAR, '(', '$', '~']
   51      | . ',' comma

    LCOND  shift, and go to state 99
    LS     shift, and go to state 100
    ','    shift, and go to state 41

    $default  reduce using rule 50 (comma)

    comma  go to state 114


state 44

   23 inst: LTYPE7 cond . imsr ',' spreg comma
   48 cond: cond . LCOND
   49     | cond . LS
   82 imsr: . reg
   83     | . imm
   84     | . shift
   85 imm: . '$' con
   86 reg: . spreg
   88 shift: . spreg '<' '<' rcon
   89      | . spreg '>' '>' rcon
   90      | . spreg '-' '>' rcon
   91      | . spreg LAT '>' rcon
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP    shift, and go to state 74
    LPC    shift, and go to state 75
    LR     shift, and go to state 76
    LREG   shift, and go to state 77
    LCOND  shift, and go to state 99
    LS     shift, and go to state 100
    '$'    shift, and go to state 101

    imsr   go to state 115
    imm    go to state 103
    reg    go to state 104
    shift  go to state 105
    sreg   go to state 89
    spreg  go to state 90


state 45

   24 inst: LTYPE8 cond . ioreg ',' '[' reglist ']'
   25     | LTYPE8 cond . '[' reglist ']' ',' ioreg
   48 cond: cond . LCOND
   49     | cond . LS
   76 ireg: . '(' spreg ')'
   77 ioreg: . ireg
   78      | . con '(' sreg ')'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LCOND   shift, and go to state 99
    LS      shift, and go to state 100
    LVAR    shift, and go to state 52
    '['     shift, and go to state 116
    '('     shift, and go to state 68
    '~'     shift, and go to state 54

    ireg   go to state 69
    ioreg  go to state 117
    con    go to state 118


state 46

   26 inst: LTYPE9 cond . reg ',' ireg ',' reg
   27     | LTYPE9 cond . reg ',' ireg comma
   28     | LTYPE9 cond . comma ireg ',' reg
   48 cond: cond . LCOND
   49     | cond . LS
   50 comma: .  ['(']
   51      | . ',' comma
   86 reg: . spreg
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP    shift, and go to state 74
    LPC    shift, and go to state 75
    LR     shift, and go to state 76
    LREG   shift, and go to state 77
    LCOND  shift, and go to state 99
    LS     shift, and go to state 100
    ','    shift, and go to state 41

    $default  reduce using rule 50 (comma)

    comma  go to state 119
    reg    go to state 120
    sreg   go to state 89
    spreg  go to state 121


state 47

   29 inst: LTYPEA cond . comma
   48 cond: cond . LCOND
   49     | cond . LS
   50 comma: .  [';']
   51      | . ',' comma

    LCOND  shift, and go to state 99
    LS     shift, and go to state 100
    ','    shift, and go to state 41

    $default  reduce using rule 50 (comma)

    comma  go to state 122


state 48

  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  117    | '+' . con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con  go to state 123


state 49

  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  116    | '-' . con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con  go to state 124


state 50

  114 con: LCONST .

    $default  reduce using rule 114 (con)


state 51

  106 name: LNAME . offset '(' pointer ')'
  107     | LNAME . '<' '>' offset '(' LSB ')'
  108 offset: .  ['(']
  109       | . '+' con
  110       | . '-' con

    '<'  shift, and go to state 125
    '+'  shift, and go to state 126
    '-'  shift, and go to state 127

    $default  reduce using rule 108 (offset)

    offset  go to state 128


state 52

  115 con: LVAR .

    $default  reduce using rule 115 (con)


state 53

  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'
  119    | '(' . expr ')'
  122 expr: . con
  123     | . expr '+' expr
  124     | . expr '-' expr
  125     | . expr '*' expr
  126     | . expr '/' expr
  127     | . expr '%' expr
  128     | . expr '<' '<' expr
  129     | . expr '>' '>' expr
  130     | . expr '&' expr
  131     | . expr '^' expr
  132     | . expr '|' expr

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con   go to state 129
    expr  go to state 130


state 54

  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  118    | '~' . con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con  go to state 131


state 55

   30 inst: LTYPEB name . ',' imm
   31     | LTYPEB name . ',' con ',' imm
   32     | LTYPEB name . ',' con ',' imm '-' con

    ','  shift, and go to state 132


state 56

  105 name: con . '(' pointer ')'

    '('  shift, and go to state 133


state 57

   33 inst: LTYPEC name . '/' con ',' ximm

    '/'  shift, and go to state 134


state 58

   34 inst: LTYPED cond . reg comma
   48 cond: cond . LCOND
   49     | cond . LS
   86 reg: . spreg
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP    shift, and go to state 74
    LPC    shift, and go to state 75
    LR     shift, and go to state 76
    LREG   shift, and go to state 77
    LCOND  shift, and go to state 99
    LS     shift, and go to state 100

    reg    go to state 135
    sreg   go to state 89
    spreg  go to state 121


state 59

   46 inst: LTYPEE comma .

    $default  reduce using rule 46 (inst)


state 60

   35 inst: LTYPEH comma . ximm
   55 ximm: . '$' con
   56     | . '$' oreg
   57     | . '$' '*' '$' oreg
   58     | . '$' LSCONST
   59     | . fcon
   60 fcon: . '$' LFCONST
   61     | . '$' '-' LFCONST

    '$'  shift, and go to state 82

    ximm  go to state 136
    fcon  go to state 84


state 61

   36 inst: LTYPEI cond . freg ',' freg
   48 cond: cond . LCOND
   49     | cond . LS
  103 freg: . LFREG
  104     | . LF '(' con ')'

    LF     shift, and go to state 78
    LFREG  shift, and go to state 79
    LCOND  shift, and go to state 99
    LS     shift, and go to state 100

    freg  go to state 137


state 62

   40 inst: LTYPEJ cond . con ',' expr ',' spreg ',' creg ',' creg oexpr
   48 cond: cond . LCOND
   49     | cond . LS
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LCOND   shift, and go to state 99
    LS      shift, and go to state 100
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con  go to state 138


state 63

   37 inst: LTYPEK cond . frcon ',' freg
   38     | LTYPEK cond . frcon ',' LFREG ',' freg
   48 cond: cond . LCOND
   49     | cond . LS
   60 fcon: . '$' LFCONST
   61     | . '$' '-' LFCONST
  101 frcon: . freg
  102      | . fcon
  103 freg: . LFREG
  104     | . LF '(' con ')'

    LF     shift, and go to state 78
    LFREG  shift, and go to state 79
    LCOND  shift, and go to state 99
    LS     shift, and go to state 100
    '$'    shift, and go to state 139

    fcon   go to state 140
    frcon  go to state 141
    freg   go to state 142


state 64

   39 inst: LTYPEL cond . freg ',' freg comma
   48 cond: cond . LCOND
   49     | cond . LS
  103 freg: . LFREG
  104     | . LF '(' con ')'

    LF     shift, and go to state 78
    LFREG  shift, and go to state 79
    LCOND  shift, and go to state 99
    LS     shift, and go to state 100

    freg  go to state 143


state 65

   41 inst: LTYPEM cond . reg ',' reg ',' regreg
   48 cond: cond . LCOND
   49     | cond . LS
   86 reg: . spreg
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP    shift, and go to state 74
    LPC    shift, and go to state 75
    LR     shift, and go to state 76
    LREG   shift, and go to state 77
    LCOND  shift, and go to state 99
    LS     shift, and go to state 100

    reg    go to state 144
    sreg   go to state 89
    spreg  go to state 121


state 66

   42 inst: LTYPEN cond . reg ',' reg ',' reg ',' spreg
   48 cond: cond . LCOND
   49     | cond . LS
   86 reg: . spreg
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP    shift, and go to state 74
    LPC    shift, and go to state 75
    LR     shift, and go to state 76
    LREG   shift, and go to state 77
    LCOND  shift, and go to state 99
    LS     shift, and go to state 100

    reg    go to state 145
    sreg   go to state 89
    spreg  go to state 121


state 67

   20 inst: LTYPEBX comma . ireg
   76 ireg: . '(' spreg ')'

    '('  shift, and go to state 146

    ireg  go to state 147


state 68

   76 ireg: '(' . spreg ')'
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'
  119    | '(' . expr ')'
  122 expr: . con
  123     | . expr '+' expr
  124     | . expr '-' expr
  125     | . expr '*' expr
  126     | . expr '/' expr
  127     | . expr '%' expr
  128     | . expr '<' '<' expr
  129     | . expr '>' '>' expr
  130     | . expr '&' expr
  131     | . expr '^' expr
  132     | . expr '|' expr

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LSP     shift, and go to state 74
    LPC     shift, and go to state 75
    LR      shift, and go to state 76
    LREG    shift, and go to state 77
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    sreg   go to state 89
    spreg  go to state 148
    con    go to state 129
    expr   go to state 130


state 69

   77 ioreg: ireg .

    $default  reduce using rule 77 (ioreg)


state 70

   81 oreg: ioreg .

    $default  reduce using rule 81 (oreg)


state 71

   43 inst: LTYPEPLD oreg .

    $default  reduce using rule 43 (inst)


state 72

   79 oreg: name .  [';', ',']
   80     | name . '(' sreg ')'

    '('  shift, and go to state 149

    $default  reduce using rule 79 (oreg)


state 73

   78 ioreg: con . '(' sreg ')'
  105 name: con . '(' pointer ')'

    '('  shift, and go to state 150


state 74

   98 spreg: LSP .

    $default  reduce using rule 98 (spreg)


state 75

   95 sreg: LPC .

    $default  reduce using rule 95 (sreg)


state 76

   96 sreg: LR . '(' expr ')'

    '('  shift, and go to state 151


state 77

   94 sreg: LREG .

    $default  reduce using rule 94 (sreg)


state 78

  104 freg: LF . '(' con ')'

    '('  shift, and go to state 152


state 79

  103 freg: LFREG .

    $default  reduce using rule 103 (freg)


state 80

   69 gen: LPSR .

    $default  reduce using rule 69 (gen)


state 81

   70 gen: LFCR .

    $default  reduce using rule 70 (gen)


state 82

   55 ximm: '$' . con
   56     | '$' . oreg
   57     | '$' . '*' '$' oreg
   58     | '$' . LSCONST
   60 fcon: '$' . LFCONST
   61     | '$' . '-' LFCONST
   76 ireg: . '(' spreg ')'
   77 ioreg: . ireg
   78      | . con '(' sreg ')'
   79 oreg: . name
   80     | . name '(' sreg ')'
   81     | . ioreg
  105 name: . con '(' pointer ')'
  106     | . LNAME offset '(' pointer ')'
  107     | . LNAME '<' '>' offset '(' LSB ')'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'      shift, and go to state 48
    '-'      shift, and go to state 153
    '*'      shift, and go to state 154
    LCONST   shift, and go to state 50
    LFCONST  shift, and go to state 155
    LSCONST  shift, and go to state 156
    LNAME    shift, and go to state 51
    LVAR     shift, and go to state 52
    '('      shift, and go to state 68
    '~'      shift, and go to state 54

    ireg   go to state 69
    ioreg  go to state 70
    oreg   go to state 157
    name   go to state 72
    con    go to state 158


state 83

   66 gen: ximm .

    $default  reduce using rule 66 (gen)


state 84

   59 ximm: fcon .

    $default  reduce using rule 59 (ximm)


state 85

   44 inst: LTYPEPC gen . ',' gen

    ','  shift, and go to state 159


state 86

   72 gen: oreg .

    $default  reduce using rule 72 (gen)


state 87

   65 gen: reg .

    $default  reduce using rule 65 (gen)


state 88

   67 gen: shift .  [';', ',']
   68    | shift . '(' spreg ')'

    '('  shift, and go to state 160

    $default  reduce using rule 67 (gen)


state 89

   97 spreg: sreg .

    $default  reduce using rule 97 (spreg)


state 90

   86 reg: spreg .  [';', ',']
   88 shift: spreg . '<' '<' rcon
   89      | spreg . '>' '>' rcon
   90      | spreg . '-' '>' rcon
   91      | spreg . LAT '>' rcon

    '<'  shift, and go to state 161
    '>'  shift, and go to state 162
    '-'  shift, and go to state 163
    LAT  shift, and go to state 164

    $default  reduce using rule 86 (reg)


state 91

   73 gen: freg .

    $default  reduce using rule 73 (gen)


state 92

   71 gen: con .  [';', ',']
   78 ioreg: con . '(' sreg ')'
  105 name: con . '(' pointer ')'

    '('  shift, and go to state 150

    $default  reduce using rule 71 (gen)


state 93

   45 inst: LTYPEF gen . ',' gen

    ','  shift, and go to state 165


state 94

    6 $@3: .
    7 line: LNAME ':' . $@3 line

    $default  reduce using rule 6 ($@3)

    $@3  go to state 166


state 95

    8 line: LNAME '=' . expr ';'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'
  122 expr: . con
  123     | . expr '+' expr
  124     | . expr '-' expr
  125     | . expr '*' expr
  126     | . expr '/' expr
  127     | . expr '%' expr
  128     | . expr '<' '<' expr
  129     | . expr '>' '>' expr
  130     | . expr '&' expr
  131     | . expr '^' expr
  132     | . expr '|' expr

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con   go to state 129
    expr  go to state 167


state 96

    4 $@2: .
    5 line: LLAB ':' . $@2 line

    $default  reduce using rule 4 ($@2)

    $@2  go to state 168


state 97

    9 line: LVAR '=' . expr ';'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'
  122 expr: . con
  123     | . expr '+' expr
  124     | . expr '-' expr
  125     | . expr '*' expr
  126     | . expr '/' expr
  127     | . expr '%' expr
  128     | . expr '<' '<' expr
  129     | . expr '>' '>' expr
  130     | . expr '&' expr
  131     | . expr '^' expr
  132     | . expr '|' expr

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con   go to state 129
    expr  go to state 169


state 98

   11 line: inst ';' .

    $default  reduce using rule 11 (line)


state 99

   48 cond: cond LCOND .

    $default  reduce using rule 48 (cond)


state 100

   49 cond: cond LS .

    $default  reduce using rule 49 (cond)


state 101

   85 imm: '$' . con
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con  go to state 170


state 102

   13 inst: LTYPE1 cond imsr . ',' spreg ',' reg
   14     | LTYPE1 cond imsr . ',' spreg ','
   15     | LTYPE1 cond imsr . ',' reg

    ','  shift, and go to state 171


state 103

   83 imsr: imm .

    $default  reduce using rule 83 (imsr)


state 104

   82 imsr: reg .

    $default  reduce using rule 82 (imsr)


state 105

   84 imsr: shift .

    $default  reduce using rule 84 (imsr)


state 106

   16 inst: LTYPE2 cond imsr . ',' reg

    ','  shift, and go to state 172


state 107

   17 inst: LTYPE3 cond gen . ',' gen

    ','  shift, and go to state 173


state 108

   18 inst: LTYPE4 cond comma . rel
   19     | LTYPE4 cond comma . nireg
   52 rel: . con '(' LPC ')'
   53    | . LNAME offset
   54    | . LLAB offset
   74 nireg: . ireg
   75      | . name
   76 ireg: . '(' spreg ')'
  105 name: . con '(' pointer ')'
  106     | . LNAME offset '(' pointer ')'
  107     | . LNAME '<' '>' offset '(' LSB ')'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LNAME   shift, and go to state 174
    LLAB    shift, and go to state 111
    LVAR    shift, and go to state 52
    '('     shift, and go to state 68
    '~'     shift, and go to state 54

    rel    go to state 175
    nireg  go to state 176
    ireg   go to state 177
    name   go to state 178
    con    go to state 179


state 109

   51 comma: ',' comma .

    $default  reduce using rule 51 (comma)


state 110

   53 rel: LNAME . offset
  108 offset: .  [';']
  109       | . '+' con
  110       | . '-' con

    '+'  shift, and go to state 126
    '-'  shift, and go to state 127

    $default  reduce using rule 108 (offset)

    offset  go to state 180


state 111

   54 rel: LLAB . offset
  108 offset: .  [';']
  109       | . '+' con
  110       | . '-' con

    '+'  shift, and go to state 126
    '-'  shift, and go to state 127

    $default  reduce using rule 108 (offset)

    offset  go to state 181


state 112

   21 inst: LTYPE5 comma rel .

    $default  reduce using rule 21 (inst)


state 113

   52 rel: con . '(' LPC ')'

    '('  shift, and go to state 182


state 114

   22 inst: LTYPE6 cond comma . gen
   55 ximm: . '$' con
   56     | . '$' oreg
   57     | . '$' '*' '$' oreg
   58     | . '$' LSCONST
   59     | . fcon
   60 fcon: . '$' LFCONST
   61     | . '$' '-' LFCONST
   65 gen: . reg
   66    | . ximm
   67    | . shift
   68    | . shift '(' spreg ')'
   69    | . LPSR
   70    | . LFCR
   71    | . con
   72    | . oreg
   73    | . freg
   76 ireg: . '(' spreg ')'
   77 ioreg: . ireg
   78      | . con '(' sreg ')'
   79 oreg: . name
   80     | . name '(' sreg ')'
   81     | . ioreg
   86 reg: . spreg
   88 shift: . spreg '<' '<' rcon
   89      | . spreg '>' '>' rcon
   90      | . spreg '-' '>' rcon
   91      | . spreg LAT '>' rcon
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP
  103 freg: . LFREG
  104     | . LF '(' con ')'
  105 name: . con '(' pointer ')'
  106     | . LNAME offset '(' pointer ')'
  107     | . LNAME '<' '>' offset '(' LSB ')'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LSP     shift, and go to state 74
    LPC     shift, and go to state 75
    LR      shift, and go to state 76
    LREG    shift, and go to state 77
    LF      shift, and go to state 78
    LFREG   shift, and go to state 79
    LPSR    shift, and go to state 80
    LFCR    shift, and go to state 81
    LNAME   shift, and go to state 51
    LVAR    shift, and go to state 52
    '('     shift, and go to state 68
    '$'     shift, and go to state 82
    '~'     shift, and go to state 54

    ximm   go to state 83
    fcon   go to state 84
    gen    go to state 183
    ireg   go to state 69
    ioreg  go to state 70
    oreg   go to state 86
    reg    go to state 87
    shift  go to state 88
    sreg   go to state 89
    spreg  go to state 90
    freg   go to state 91
    name   go to state 72
    con    go to state 92


state 115

   23 inst: LTYPE7 cond imsr . ',' spreg comma

    ','  shift, and go to state 184


state 116

   25 inst: LTYPE8 cond '[' . reglist ']' ',' ioreg
   62 reglist: . spreg
   63        | . spreg '-' spreg
   64        | . spreg comma reglist
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    reglist  go to state 185
    sreg     go to state 89
    spreg    go to state 186


state 117

   24 inst: LTYPE8 cond ioreg . ',' '[' reglist ']'

    ','  shift, and go to state 187


state 118

   78 ioreg: con . '(' sreg ')'

    '('  shift, and go to state 188


state 119

   28 inst: LTYPE9 cond comma . ireg ',' reg
   76 ireg: . '(' spreg ')'

    '('  shift, and go to state 146

    ireg  go to state 189


state 120

   26 inst: LTYPE9 cond reg . ',' ireg ',' reg
   27     | LTYPE9 cond reg . ',' ireg comma

    ','  shift, and go to state 190


state 121

   86 reg: spreg .

    $default  reduce using rule 86 (reg)


state 122

   29 inst: LTYPEA cond comma .

    $default  reduce using rule 29 (inst)


state 123

  117 con: '+' con .

    $default  reduce using rule 117 (con)


state 124

  116 con: '-' con .

    $default  reduce using rule 116 (con)


state 125

  107 name: LNAME '<' . '>' offset '(' LSB ')'

    '>'  shift, and go to state 191


state 126

  109 offset: '+' . con
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con  go to state 192


state 127

  110 offset: '-' . con
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con  go to state 193


state 128

  106 name: LNAME offset . '(' pointer ')'

    '('  shift, and go to state 194


state 129

  122 expr: con .

    $default  reduce using rule 122 (expr)


state 130

  119 con: '(' expr . ')'
  123 expr: expr . '+' expr
  124     | expr . '-' expr
  125     | expr . '*' expr
  126     | expr . '/' expr
  127     | expr . '%' expr
  128     | expr . '<' '<' expr
  129     | expr . '>' '>' expr
  130     | expr . '&' expr
  131     | expr . '^' expr
  132     | expr . '|' expr

    '|'  shift, and go to state 195
    '^'  shift, and go to state 196
    '&'  shift, and go to state 197
    '<'  shift, and go to state 198
    '>'  shift, and go to state 199
    '+'  shift, and go to state 200
    '-'  shift, and go to state 201
    '*'  shift, and go to state 202
    '/'  shift, and go to state 203
    '%'  shift, and go to state 204
    ')'  shift, and go to state 205


state 131

  118 con: '~' con .

    $default  reduce using rule 118 (con)


state 132

   30 inst: LTYPEB name ',' . imm
   31     | LTYPEB name ',' . con ',' imm
   32     | LTYPEB name ',' . con ',' imm '-' con
   85 imm: . '$' con
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '$'     shift, and go to state 101
    '~'     shift, and go to state 54

    imm  go to state 206
    con  go to state 207


state 133

  105 name: con '(' . pointer ')'
  111 pointer: . LSB
  112        | . LSP
  113        | . LFP

    LSP  shift, and go to state 208
    LSB  shift, and go to state 209
    LFP  shift, and go to state 210

    pointer  go to state 211


state 134

   33 inst: LTYPEC name '/' . con ',' ximm
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con  go to state 212


state 135

   34 inst: LTYPED cond reg . comma
   50 comma: .  [';']
   51      | . ',' comma

    ','  shift, and go to state 41

    $default  reduce using rule 50 (comma)

    comma  go to state 213


state 136

   35 inst: LTYPEH comma ximm .

    $default  reduce using rule 35 (inst)


state 137

   36 inst: LTYPEI cond freg . ',' freg

    ','  shift, and go to state 214


state 138

   40 inst: LTYPEJ cond con . ',' expr ',' spreg ',' creg ',' creg oexpr

    ','  shift, and go to state 215


state 139

   60 fcon: '$' . LFCONST
   61     | '$' . '-' LFCONST

    '-'      shift, and go to state 216
    LFCONST  shift, and go to state 155


state 140

  102 frcon: fcon .

    $default  reduce using rule 102 (frcon)


state 141

   37 inst: LTYPEK cond frcon . ',' freg
   38     | LTYPEK cond frcon . ',' LFREG ',' freg

    ','  shift, and go to state 217


state 142

  101 frcon: freg .

    $default  reduce using rule 101 (frcon)


state 143

   39 inst: LTYPEL cond freg . ',' freg comma

    ','  shift, and go to state 218


state 144

   41 inst: LTYPEM cond reg . ',' reg ',' regreg

    ','  shift, and go to state 219


state 145

   42 inst: LTYPEN cond reg . ',' reg ',' reg ',' spreg

    ','  shift, and go to state 220


state 146

   76 ireg: '(' . spreg ')'
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    sreg   go to state 89
    spreg  go to state 148


state 147

   20 inst: LTYPEBX comma ireg .

    $default  reduce using rule 20 (inst)


state 148

   76 ireg: '(' spreg . ')'

    ')'  shift, and go to state 221


state 149

   80 oreg: name '(' . sreg ')'
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'

    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    sreg  go to state 222


state 150

   78 ioreg: con '(' . sreg ')'
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
  105 name: con '(' . pointer ')'
  111 pointer: . LSB
  112        | . LSP
  113        | . LFP

    LSP   shift, and go to state 208
    LSB   shift, and go to state 209
    LFP   shift, and go to state 210
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    sreg     go to state 223
    pointer  go to state 211


state 151

   96 sreg: LR '(' . expr ')'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'
  122 expr: . con
  123     | . expr '+' expr
  124     | . expr '-' expr
  125     | . expr '*' expr
  126     | . expr '/' expr
  127     | . expr '%' expr
  128     | . expr '<' '<' expr
  129     | . expr '>' '>' expr
  130     | . expr '&' expr
  131     | . expr '^' expr
  132     | . expr '|' expr

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con   go to state 129
    expr  go to state 224


state 152

  104 freg: LF '(' . con ')'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con  go to state 225


state 153

   61 fcon: '$' '-' . LFCONST
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  116    | '-' . con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'      shift, and go to state 48
    '-'      shift, and go to state 49
    LCONST   shift, and go to state 50
    LFCONST  shift, and go to state 226
    LVAR     shift, and go to state 52
    '('      shift, and go to state 53
    '~'      shift, and go to state 54

    con  go to state 124


state 154

   57 ximm: '$' '*' . '$' oreg

    '$'  shift, and go to state 227


state 155

   60 fcon: '$' LFCONST .

    $default  reduce using rule 60 (fcon)


state 156

   58 ximm: '$' LSCONST .

    $default  reduce using rule 58 (ximm)


state 157

   56 ximm: '$' oreg .

    $default  reduce using rule 56 (ximm)


state 158

   55 ximm: '$' con .  [';', ',']
   78 ioreg: con . '(' sreg ')'
  105 name: con . '(' pointer ')'

    '('  shift, and go to state 150

    $default  reduce using rule 55 (ximm)


state 159

   44 inst: LTYPEPC gen ',' . gen
   55 ximm: . '$' con
   56     | . '$' oreg
   57     | . '$' '*' '$' oreg
   58     | . '$' LSCONST
   59     | . fcon
   60 fcon: . '$' LFCONST
   61     | . '$' '-' LFCONST
   65 gen: . reg
   66    | . ximm
   67    | . shift
   68    | . shift '(' spreg ')'
   69    | . LPSR
   70    | . LFCR
   71    | . con
   72    | . oreg
   73    | . freg
   76 ireg: . '(' spreg ')'
   77 ioreg: . ireg
   78      | . con '(' sreg ')'
   79 oreg: . name
   80     | . name '(' sreg ')'
   81     | . ioreg
   86 reg: . spreg
   88 shift: . spreg '<' '<' rcon
   89      | . spreg '>' '>' rcon
   90      | . spreg '-' '>' rcon
   91      | . spreg LAT '>' rcon
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP
  103 freg: . LFREG
  104     | . LF '(' con ')'
  105 name: . con '(' pointer ')'
  106     | . LNAME offset '(' pointer ')'
  107     | . LNAME '<' '>' offset '(' LSB ')'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LSP     shift, and go to state 74
    LPC     shift, and go to state 75
    LR      shift, and go to state 76
    LREG    shift, and go to state 77
    LF      shift, and go to state 78
    LFREG   shift, and go to state 79
    LPSR    shift, and go to state 80
    LFCR    shift, and go to state 81
    LNAME   shift, and go to state 51
    LVAR    shift, and go to state 52
    '('     shift, and go to state 68
    '$'     shift, and go to state 82
    '~'     shift, and go to state 54

    ximm   go to state 83
    fcon   go to state 84
    gen    go to state 228
    ireg   go to state 69
    ioreg  go to state 70
    oreg   go to state 86
    reg    go to state 87
    shift  go to state 88
    sreg   go to state 89
    spreg  go to state 90
    freg   go to state 91
    name   go to state 72
    con    go to state 92


state 160

   68 gen: shift '(' . spreg ')'
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    sreg   go to state 89
    spreg  go to state 229


state 161

   88 shift: spreg '<' . '<' rcon

    '<'  shift, and go to state 230


state 162

   89 shift: spreg '>' . '>' rcon

    '>'  shift, and go to state 231


state 163

   90 shift: spreg '-' . '>' rcon

    '>'  shift, and go to state 232


state 164

   91 shift: spreg LAT . '>' rcon

    '>'  shift, and go to state 233


state 165

   45 inst: LTYPEF gen ',' . gen
   55 ximm: . '$' con
   56     | . '$' oreg
   57     | . '$' '*' '$' oreg
   58     | . '$' LSCONST
   59     | . fcon
   60 fcon: . '$' LFCONST
   61     | . '$' '-' LFCONST
   65 gen: . reg
   66    | . ximm
   67    | . shift
   68    | . shift '(' spreg ')'
   69    | . LPSR
   70    | . LFCR
   71    | . con
   72    | . oreg
   73    | . freg
   76 ireg: . '(' spreg ')'
   77 ioreg: . ireg
   78      | . con '(' sreg ')'
   79 oreg: . name
   80     | . name '(' sreg ')'
   81     | . ioreg
   86 reg: . spreg
   88 shift: . spreg '<' '<' rcon
   89      | . spreg '>' '>' rcon
   90      | . spreg '-' '>' rcon
   91      | . spreg LAT '>' rcon
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP
  103 freg: . LFREG
  104     | . LF '(' con ')'
  105 name: . con '(' pointer ')'
  106     | . LNAME offset '(' pointer ')'
  107     | . LNAME '<' '>' offset '(' LSB ')'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LSP     shift, and go to state 74
    LPC     shift, and go to state 75
    LR      shift, and go to state 76
    LREG    shift, and go to state 77
    LF      shift, and go to state 78
    LFREG   shift, and go to state 79
    LPSR    shift, and go to state 80
    LFCR    shift, and go to state 81
    LNAME   shift, and go to state 51
    LVAR    shift, and go to state 52
    '('     shift, and go to state 68
    '$'     shift, and go to state 82
    '~'     shift, and go to state 54

    ximm   go to state 83
    fcon   go to state 84
    gen    go to state 234
    ireg   go to state 69
    ioreg  go to state 70
    oreg   go to state 86
    reg    go to state 87
    shift  go to state 88
    sreg   go to state 89
    spreg  go to state 90
    freg   go to state 91
    name   go to state 72
    con    go to state 92


state 166

    5 line: . LLAB ':' $@2 line
    7     | . LNAME ':' $@3 line
    7     | LNAME ':' $@3 . line
    8     | . LNAME '=' expr ';'
    9     | . LVAR '=' expr ';'
   10     | . ';'
   11     | . inst ';'
   12     | . error ';'
   13 inst: . LTYPE1 cond imsr ',' spreg ',' reg
   14     | . LTYPE1 cond imsr ',' spreg ','
   15     | . LTYPE1 cond imsr ',' reg
   16     | . LTYPE2 cond imsr ',' reg
   17     | . LTYPE3 cond gen ',' gen
   18     | . LTYPE4 cond comma rel
   19     | . LTYPE4 cond comma nireg
   20     | . LTYPEBX comma ireg
   21     | . LTYPE5 comma rel
   22     | . LTYPE6 cond comma gen
   23     | . LTYPE7 cond imsr ',' spreg comma
   24     | . LTYPE8 cond ioreg ',' '[' reglist ']'
   25     | . LTYPE8 cond '[' reglist ']' ',' ioreg
   26     | . LTYPE9 cond reg ',' ireg ',' reg
   27     | . LTYPE9 cond reg ',' ireg comma
   28     | . LTYPE9 cond comma ireg ',' reg
   29     | . LTYPEA cond comma
   30     | . LTYPEB name ',' imm
   31     | . LTYPEB name ',' con ',' imm
   32     | . LTYPEB name ',' con ',' imm '-' con
   33     | . LTYPEC name '/' con ',' ximm
   34     | . LTYPED cond reg comma
   35     | . LTYPEH comma ximm
   36     | . LTYPEI cond freg ',' freg
   37     | . LTYPEK cond frcon ',' freg
   38     | . LTYPEK cond frcon ',' LFREG ',' freg
   39     | . LTYPEL cond freg ',' freg comma
   40     | . LTYPEJ cond con ',' expr ',' spreg ',' creg ',' creg oexpr
   41     | . LTYPEM cond reg ',' reg ',' regreg
   42     | . LTYPEN cond reg ',' reg ',' reg ',' spreg
   43     | . LTYPEPLD oreg
   44     | . LTYPEPC gen ',' gen
   45     | . LTYPEF gen ',' gen
   46     | . LTYPEE comma

    error     shift, and go to state 4
    LTYPE1    shift, and go to state 5
    LTYPE2    shift, and go to state 6
    LTYPE3    shift, and go to state 7
    LTYPE4    shift, and go to state 8
    LTYPE5    shift, and go to state 9
    LTYPE6    shift, and go to state 10
    LTYPE7    shift, and go to state 11
    LTYPE8    shift, and go to state 12
    LTYPE9    shift, and go to state 13
    LTYPEA    shift, and go to state 14
    LTYPEB    shift, and go to state 15
    LTYPEC    shift, and go to state 16
    LTYPED    shift, and go to state 17
    LTYPEE    shift, and go to state 18
    LTYPEH    shift, and go to state 19
    LTYPEI    shift, and go to state 20
    LTYPEJ    shift, and go to state 21
    LTYPEK    shift, and go to state 22
    LTYPEL    shift, and go to state 23
    LTYPEM    shift, and go to state 24
    LTYPEN    shift, and go to state 25
    LTYPEBX   shift, and go to state 26
    LTYPEPLD  shift, and go to state 27
    LTYPEPC   shift, and go to state 28
    LTYPEF    shift, and go to state 29
    LNAME     shift, and go to state 30
    LLAB      shift, and go to state 31
    LVAR      shift, and go to state 32
    ';'       shift, and go to state 33

    line  go to state 235
    inst  go to state 35


state 167

    8 line: LNAME '=' expr . ';'
  123 expr: expr . '+' expr
  124     | expr . '-' expr
  125     | expr . '*' expr
  126     | expr . '/' expr
  127     | expr . '%' expr
  128     | expr . '<' '<' expr
  129     | expr . '>' '>' expr
  130     | expr . '&' expr
  131     | expr . '^' expr
  132     | expr . '|' expr

    '|'  shift, and go to state 195
    '^'  shift, and go to state 196
    '&'  shift, and go to state 197
    '<'  shift, and go to state 198
    '>'  shift, and go to state 199
    '+'  shift, and go to state 200
    '-'  shift, and go to state 201
    '*'  shift, and go to state 202
    '/'  shift, and go to state 203
    '%'  shift, and go to state 204
    ';'  shift, and go to state 236


state 168

    5 line: . LLAB ':' $@2 line
    5     | LLAB ':' $@2 . line
    7     | . LNAME ':' $@3 line
    8     | . LNAME '=' expr ';'
    9     | . LVAR '=' expr ';'
   10     | . ';'
   11     | . inst ';'
   12     | . error ';'
   13 inst: . LTYPE1 cond imsr ',' spreg ',' reg
   14     | . LTYPE1 cond imsr ',' spreg ','
   15     | . LTYPE1 cond imsr ',' reg
   16     | . LTYPE2 cond imsr ',' reg
   17     | . LTYPE3 cond gen ',' gen
   18     | . LTYPE4 cond comma rel
   19     | . LTYPE4 cond comma nireg
   20     | . LTYPEBX comma ireg
   21     | . LTYPE5 comma rel
   22     | . LTYPE6 cond comma gen
   23     | . LTYPE7 cond imsr ',' spreg comma
   24     | . LTYPE8 cond ioreg ',' '[' reglist ']'
   25     | . LTYPE8 cond '[' reglist ']' ',' ioreg
   26     | . LTYPE9 cond reg ',' ireg ',' reg
   27     | . LTYPE9 cond reg ',' ireg comma
   28     | . LTYPE9 cond comma ireg ',' reg
   29     | . LTYPEA cond comma
   30     | . LTYPEB name ',' imm
   31     | . LTYPEB name ',' con ',' imm
   32     | . LTYPEB name ',' con ',' imm '-' con
   33     | . LTYPEC name '/' con ',' ximm
   34     | . LTYPED cond reg comma
   35     | . LTYPEH comma ximm
   36     | . LTYPEI cond freg ',' freg
   37     | . LTYPEK cond frcon ',' freg
   38     | . LTYPEK cond frcon ',' LFREG ',' freg
   39     | . LTYPEL cond freg ',' freg comma
   40     | . LTYPEJ cond con ',' expr ',' spreg ',' creg ',' creg oexpr
   41     | . LTYPEM cond reg ',' reg ',' regreg
   42     | . LTYPEN cond reg ',' reg ',' reg ',' spreg
   43     | . LTYPEPLD oreg
   44     | . LTYPEPC gen ',' gen
   45     | . LTYPEF gen ',' gen
   46     | . LTYPEE comma

    error     shift, and go to state 4
    LTYPE1    shift, and go to state 5
    LTYPE2    shift, and go to state 6
    LTYPE3    shift, and go to state 7
    LTYPE4    shift, and go to state 8
    LTYPE5    shift, and go to state 9
    LTYPE6    shift, and go to state 10
    LTYPE7    shift, and go to state 11
    LTYPE8    shift, and go to state 12
    LTYPE9    shift, and go to state 13
    LTYPEA    shift, and go to state 14
    LTYPEB    shift, and go to state 15
    LTYPEC    shift, and go to state 16
    LTYPED    shift, and go to state 17
    LTYPEE    shift, and go to state 18
    LTYPEH    shift, and go to state 19
    LTYPEI    shift, and go to state 20
    LTYPEJ    shift, and go to state 21
    LTYPEK    shift, and go to state 22
    LTYPEL    shift, and go to state 23
    LTYPEM    shift, and go to state 24
    LTYPEN    shift, and go to state 25
    LTYPEBX   shift, and go to state 26
    LTYPEPLD  shift, and go to state 27
    LTYPEPC   shift, and go to state 28
    LTYPEF    shift, and go to state 29
    LNAME     shift, and go to state 30
    LLAB      shift, and go to state 31
    LVAR      shift, and go to state 32
    ';'       shift, and go to state 33

    line  go to state 237
    inst  go to state 35


state 169

    9 line: LVAR '=' expr . ';'
  123 expr: expr . '+' expr
  124     | expr . '-' expr
  125     | expr . '*' expr
  126     | expr . '/' expr
  127     | expr . '%' expr
  128     | expr . '<' '<' expr
  129     | expr . '>' '>' expr
  130     | expr . '&' expr
  131     | expr . '^' expr
  132     | expr . '|' expr

    '|'  shift, and go to state 195
    '^'  shift, and go to state 196
    '&'  shift, and go to state 197
    '<'  shift, and go to state 198
    '>'  shift, and go to state 199
    '+'  shift, and go to state 200
    '-'  shift, and go to state 201
    '*'  shift, and go to state 202
    '/'  shift, and go to state 203
    '%'  shift, and go to state 204
    ';'  shift, and go to state 238


state 170

   85 imm: '$' con .

    $default  reduce using rule 85 (imm)


state 171

   13 inst: LTYPE1 cond imsr ',' . spreg ',' reg
   14     | LTYPE1 cond imsr ',' . spreg ','
   15     | LTYPE1 cond imsr ',' . reg
   86 reg: . spreg
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    reg    go to state 239
    sreg   go to state 89
    spreg  go to state 240


state 172

   16 inst: LTYPE2 cond imsr ',' . reg
   86 reg: . spreg
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    reg    go to state 241
    sreg   go to state 89
    spreg  go to state 121


state 173

   17 inst: LTYPE3 cond gen ',' . gen
   55 ximm: . '$' con
   56     | . '$' oreg
   57     | . '$' '*' '$' oreg
   58     | . '$' LSCONST
   59     | . fcon
   60 fcon: . '$' LFCONST
   61     | . '$' '-' LFCONST
   65 gen: . reg
   66    | . ximm
   67    | . shift
   68    | . shift '(' spreg ')'
   69    | . LPSR
   70    | . LFCR
   71    | . con
   72    | . oreg
   73    | . freg
   76 ireg: . '(' spreg ')'
   77 ioreg: . ireg
   78      | . con '(' sreg ')'
   79 oreg: . name
   80     | . name '(' sreg ')'
   81     | . ioreg
   86 reg: . spreg
   88 shift: . spreg '<' '<' rcon
   89      | . spreg '>' '>' rcon
   90      | . spreg '-' '>' rcon
   91      | . spreg LAT '>' rcon
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP
  103 freg: . LFREG
  104     | . LF '(' con ')'
  105 name: . con '(' pointer ')'
  106     | . LNAME offset '(' pointer ')'
  107     | . LNAME '<' '>' offset '(' LSB ')'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LSP     shift, and go to state 74
    LPC     shift, and go to state 75
    LR      shift, and go to state 76
    LREG    shift, and go to state 77
    LF      shift, and go to state 78
    LFREG   shift, and go to state 79
    LPSR    shift, and go to state 80
    LFCR    shift, and go to state 81
    LNAME   shift, and go to state 51
    LVAR    shift, and go to state 52
    '('     shift, and go to state 68
    '$'     shift, and go to state 82
    '~'     shift, and go to state 54

    ximm   go to state 83
    fcon   go to state 84
    gen    go to state 242
    ireg   go to state 69
    ioreg  go to state 70
    oreg   go to state 86
    reg    go to state 87
    shift  go to state 88
    sreg   go to state 89
    spreg  go to state 90
    freg   go to state 91
    name   go to state 72
    con    go to state 92


state 174

   53 rel: LNAME . offset
  106 name: LNAME . offset '(' pointer ')'
  107     | LNAME . '<' '>' offset '(' LSB ')'
  108 offset: .  [';', '(']
  109       | . '+' con
  110       | . '-' con

    '<'  shift, and go to state 125
    '+'  shift, and go to state 126
    '-'  shift, and go to state 127

    $default  reduce using rule 108 (offset)

    offset  go to state 243


state 175

   18 inst: LTYPE4 cond comma rel .

    $default  reduce using rule 18 (inst)


state 176

   19 inst: LTYPE4 cond comma nireg .

    $default  reduce using rule 19 (inst)


state 177

   74 nireg: ireg .

    $default  reduce using rule 74 (nireg)


state 178

   75 nireg: name .

    $default  reduce using rule 75 (nireg)


state 179

   52 rel: con . '(' LPC ')'
  105 name: con . '(' pointer ')'

    '('  shift, and go to state 244


state 180

   53 rel: LNAME offset .

    $default  reduce using rule 53 (rel)


state 181

   54 rel: LLAB offset .

    $default  reduce using rule 54 (rel)


state 182

   52 rel: con '(' . LPC ')'

    LPC  shift, and go to state 245


state 183

   22 inst: LTYPE6 cond comma gen .

    $default  reduce using rule 22 (inst)


state 184

   23 inst: LTYPE7 cond imsr ',' . spreg comma
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    sreg   go to state 89
    spreg  go to state 246


state 185

   25 inst: LTYPE8 cond '[' reglist . ']' ',' ioreg

    ']'  shift, and go to state 247


state 186

   50 comma: .  [LSP, LPC, LR, LREG]
   51      | . ',' comma
   62 reglist: spreg .  [']']
   63        | spreg . '-' spreg
   64        | spreg . comma reglist

    '-'  shift, and go to state 248
    ','  shift, and go to state 41

    ']'       reduce using rule 62 (reglist)
    $default  reduce using rule 50 (comma)

    comma  go to state 249


state 187

   24 inst: LTYPE8 cond ioreg ',' . '[' reglist ']'

    '['  shift, and go to state 250


state 188

   78 ioreg: con '(' . sreg ')'
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'

    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    sreg  go to state 223


state 189

   28 inst: LTYPE9 cond comma ireg . ',' reg

    ','  shift, and go to state 251


state 190

   26 inst: LTYPE9 cond reg ',' . ireg ',' reg
   27     | LTYPE9 cond reg ',' . ireg comma
   76 ireg: . '(' spreg ')'

    '('  shift, and go to state 146

    ireg  go to state 252


state 191

  107 name: LNAME '<' '>' . offset '(' LSB ')'
  108 offset: .  ['(']
  109       | . '+' con
  110       | . '-' con

    '+'  shift, and go to state 126
    '-'  shift, and go to state 127

    $default  reduce using rule 108 (offset)

    offset  go to state 253


state 192

  109 offset: '+' con .

    $default  reduce using rule 109 (offset)


state 193

  110 offset: '-' con .

    $default  reduce using rule 110 (offset)


state 194

  106 name: LNAME offset '(' . pointer ')'
  111 pointer: . LSB
  112        | . LSP
  113        | . LFP

    LSP  shift, and go to state 208
    LSB  shift, and go to state 209
    LFP  shift, and go to state 210

    pointer  go to state 254


state 195

  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'
  122 expr: . con
  123     | . expr '+' expr
  124     | . expr '-' expr
  125     | . expr '*' expr
  126     | . expr '/' expr
  127     | . expr '%' expr
  128     | . expr '<' '<' expr
  129     | . expr '>' '>' expr
  130     | . expr '&' expr
  131     | . expr '^' expr
  132     | . expr '|' expr
  132     | expr '|' . expr

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con   go to state 129
    expr  go to state 255


state 196

  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'
  122 expr: . con
  123     | . expr '+' expr
  124     | . expr '-' expr
  125     | . expr '*' expr
  126     | . expr '/' expr
  127     | . expr '%' expr
  128     | . expr '<' '<' expr
  129     | . expr '>' '>' expr
  130     | . expr '&' expr
  131     | . expr '^' expr
  131     | expr '^' . expr
  132     | . expr '|' expr

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con   go to state 129
    expr  go to state 256


state 197

  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'
  122 expr: . con
  123     | . expr '+' expr
  124     | . expr '-' expr
  125     | . expr '*' expr
  126     | . expr '/' expr
  127     | . expr '%' expr
  128     | . expr '<' '<' expr
  129     | . expr '>' '>' expr
  130     | . expr '&' expr
  130     | expr '&' . expr
  131     | . expr '^' expr
  132     | . expr '|' expr

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con   go to state 129
    expr  go to state 257


state 198

  128 expr: expr '<' . '<' expr

    '<'  shift, and go to state 258


state 199

  129 expr: expr '>' . '>' expr

    '>'  shift, and go to state 259


state 200

  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'
  122 expr: . con
  123     | . expr '+' expr
  123     | expr '+' . expr
  124     | . expr '-' expr
  125     | . expr '*' expr
  126     | . expr '/' expr
  127     | . expr '%' expr
  128     | . expr '<' '<' expr
  129     | . expr '>' '>' expr
  130     | . expr '&' expr
  131     | . expr '^' expr
  132     | . expr '|' expr

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con   go to state 129
    expr  go to state 260


state 201

  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'
  122 expr: . con
  123     | . expr '+' expr
  124     | . expr '-' expr
  124     | expr '-' . expr
  125     | . expr '*' expr
  126     | . expr '/' expr
  127     | . expr '%' expr
  128     | . expr '<' '<' expr
  129     | . expr '>' '>' expr
  130     | . expr '&' expr
  131     | . expr '^' expr
  132     | . expr '|' expr

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con   go to state 129
    expr  go to state 261


state 202

  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'
  122 expr: . con
  123     | . expr '+' expr
  124     | . expr '-' expr
  125     | . expr '*' expr
  125     | expr '*' . expr
  126     | . expr '/' expr
  127     | . expr '%' expr
  128     | . expr '<' '<' expr
  129     | . expr '>' '>' expr
  130     | . expr '&' expr
  131     | . expr '^' expr
  132     | . expr '|' expr

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con   go to state 129
    expr  go to state 262


state 203

  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'
  122 expr: . con
  123     | . expr '+' expr
  124     | . expr '-' expr
  125     | . expr '*' expr
  126     | . expr '/' expr
  126     | expr '/' . expr
  127     | . expr '%' expr
  128     | . expr '<' '<' expr
  129     | . expr '>' '>' expr
  130     | . expr '&' expr
  131     | . expr '^' expr
  132     | . expr '|' expr

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con   go to state 129
    expr  go to state 263


state 204

  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'
  122 expr: . con
  123     | . expr '+' expr
  124     | . expr '-' expr
  125     | . expr '*' expr
  126     | . expr '/' expr
  127     | . expr '%' expr
  127     | expr '%' . expr
  128     | . expr '<' '<' expr
  129     | . expr '>' '>' expr
  130     | . expr '&' expr
  131     | . expr '^' expr
  132     | . expr '|' expr

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con   go to state 129
    expr  go to state 264


state 205

  119 con: '(' expr ')' .

    $default  reduce using rule 119 (con)


state 206

   30 inst: LTYPEB name ',' imm .

    $default  reduce using rule 30 (inst)


state 207

   31 inst: LTYPEB name ',' con . ',' imm
   32     | LTYPEB name ',' con . ',' imm '-' con

    ','  shift, and go to state 265


state 208

  112 pointer: LSP .

    $default  reduce using rule 112 (pointer)


state 209

  111 pointer: LSB .

    $default  reduce using rule 111 (pointer)


state 210

  113 pointer: LFP .

    $default  reduce using rule 113 (pointer)


state 211

  105 name: con '(' pointer . ')'

    ')'  shift, and go to state 266


state 212

   33 inst: LTYPEC name '/' con . ',' ximm

    ','  shift, and go to state 267


state 213

   34 inst: LTYPED cond reg comma .

    $default  reduce using rule 34 (inst)


state 214

   36 inst: LTYPEI cond freg ',' . freg
  103 freg: . LFREG
  104     | . LF '(' con ')'

    LF     shift, and go to state 78
    LFREG  shift, and go to state 79

    freg  go to state 268


state 215

   40 inst: LTYPEJ cond con ',' . expr ',' spreg ',' creg ',' creg oexpr
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'
  122 expr: . con
  123     | . expr '+' expr
  124     | . expr '-' expr
  125     | . expr '*' expr
  126     | . expr '/' expr
  127     | . expr '%' expr
  128     | . expr '<' '<' expr
  129     | . expr '>' '>' expr
  130     | . expr '&' expr
  131     | . expr '^' expr
  132     | . expr '|' expr

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con   go to state 129
    expr  go to state 269


state 216

   61 fcon: '$' '-' . LFCONST

    LFCONST  shift, and go to state 226


state 217

   37 inst: LTYPEK cond frcon ',' . freg
   38     | LTYPEK cond frcon ',' . LFREG ',' freg
  103 freg: . LFREG
  104     | . LF '(' con ')'

    LF     shift, and go to state 78
    LFREG  shift, and go to state 270

    freg  go to state 271


state 218

   39 inst: LTYPEL cond freg ',' . freg comma
  103 freg: . LFREG
  104     | . LF '(' con ')'

    LF     shift, and go to state 78
    LFREG  shift, and go to state 79

    freg  go to state 272


state 219

   41 inst: LTYPEM cond reg ',' . reg ',' regreg
   86 reg: . spreg
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    reg    go to state 273
    sreg   go to state 89
    spreg  go to state 121


state 220

   42 inst: LTYPEN cond reg ',' . reg ',' reg ',' spreg
   86 reg: . spreg
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    reg    go to state 274
    sreg   go to state 89
    spreg  go to state 121


state 221

   76 ireg: '(' spreg ')' .

    $default  reduce using rule 76 (ireg)


state 222

   80 oreg: name '(' sreg . ')'

    ')'  shift, and go to state 275


state 223

   78 ioreg: con '(' sreg . ')'

    ')'  shift, and go to state 276


state 224

   96 sreg: LR '(' expr . ')'
  123 expr: expr . '+' expr
  124     | expr . '-' expr
  125     | expr . '*' expr
  126     | expr . '/' expr
  127     | expr . '%' expr
  128     | expr . '<' '<' expr
  129     | expr . '>' '>' expr
  130     | expr . '&' expr
  131     | expr . '^' expr
  132     | expr . '|' expr

    '|'  shift, and go to state 195
    '^'  shift, and go to state 196
    '&'  shift, and go to state 197
    '<'  shift, and go to state 198
    '>'  shift, and go to state 199
    '+'  shift, and go to state 200
    '-'  shift, and go to state 201
    '*'  shift, and go to state 202
    '/'  shift, and go to state 203
    '%'  shift, and go to state 204
    ')'  shift, and go to state 277


state 225

  104 freg: LF '(' con . ')'

    ')'  shift, and go to state 278


state 226

   61 fcon: '$' '-' LFCONST .

    $default  reduce using rule 61 (fcon)


state 227

   57 ximm: '$' '*' '$' . oreg
   76 ireg: . '(' spreg ')'
   77 ioreg: . ireg
   78      | . con '(' sreg ')'
   79 oreg: . name
   80     | . name '(' sreg ')'
   81     | . ioreg
  105 name: . con '(' pointer ')'
  106     | . LNAME offset '(' pointer ')'
  107     | . LNAME '<' '>' offset '(' LSB ')'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LNAME   shift, and go to state 51
    LVAR    shift, and go to state 52
    '('     shift, and go to state 68
    '~'     shift, and go to state 54

    ireg   go to state 69
    ioreg  go to state 70
    oreg   go to state 279
    name   go to state 72
    con    go to state 73


state 228

   44 inst: LTYPEPC gen ',' gen .

    $default  reduce using rule 44 (inst)


state 229

   68 gen: shift '(' spreg . ')'

    ')'  shift, and go to state 280


state 230

   88 shift: spreg '<' '<' . rcon
   92 rcon: . spreg
   93     | . con
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LSP     shift, and go to state 74
    LPC     shift, and go to state 75
    LR      shift, and go to state 76
    LREG    shift, and go to state 77
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    rcon   go to state 281
    sreg   go to state 89
    spreg  go to state 282
    con    go to state 283


state 231

   89 shift: spreg '>' '>' . rcon
   92 rcon: . spreg
   93     | . con
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LSP     shift, and go to state 74
    LPC     shift, and go to state 75
    LR      shift, and go to state 76
    LREG    shift, and go to state 77
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    rcon   go to state 284
    sreg   go to state 89
    spreg  go to state 282
    con    go to state 283


state 232

   90 shift: spreg '-' '>' . rcon
   92 rcon: . spreg
   93     | . con
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LSP     shift, and go to state 74
    LPC     shift, and go to state 75
    LR      shift, and go to state 76
    LREG    shift, and go to state 77
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    rcon   go to state 285
    sreg   go to state 89
    spreg  go to state 282
    con    go to state 283


state 233

   91 shift: spreg LAT '>' . rcon
   92 rcon: . spreg
   93     | . con
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LSP     shift, and go to state 74
    LPC     shift, and go to state 75
    LR      shift, and go to state 76
    LREG    shift, and go to state 77
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    rcon   go to state 286
    sreg   go to state 89
    spreg  go to state 282
    con    go to state 283


state 234

   45 inst: LTYPEF gen ',' gen .

    $default  reduce using rule 45 (inst)


state 235

    7 line: LNAME ':' $@3 line .

    $default  reduce using rule 7 (line)


state 236

    8 line: LNAME '=' expr ';' .

    $default  reduce using rule 8 (line)


state 237

    5 line: LLAB ':' $@2 line .

    $default  reduce using rule 5 (line)


state 238

    9 line: LVAR '=' expr ';' .

    $default  reduce using rule 9 (line)


state 239

   15 inst: LTYPE1 cond imsr ',' reg .

    $default  reduce using rule 15 (inst)


state 240

   13 inst: LTYPE1 cond imsr ',' spreg . ',' reg
   14     | LTYPE1 cond imsr ',' spreg . ','
   86 reg: spreg .  [';']

    ','  shift, and go to state 287

    $default  reduce using rule 86 (reg)


state 241

   16 inst: LTYPE2 cond imsr ',' reg .

    $default  reduce using rule 16 (inst)


state 242

   17 inst: LTYPE3 cond gen ',' gen .

    $default  reduce using rule 17 (inst)


state 243

   53 rel: LNAME offset .  [';']
  106 name: LNAME offset . '(' pointer ')'

    '('  shift, and go to state 194

    $default  reduce using rule 53 (rel)


state 244

   52 rel: con '(' . LPC ')'
  105 name: con '(' . pointer ')'
  111 pointer: . LSB
  112        | . LSP
  113        | . LFP

    LSP  shift, and go to state 208
    LSB  shift, and go to state 209
    LFP  shift, and go to state 210
    LPC  shift, and go to state 245

    pointer  go to state 211


state 245

   52 rel: con '(' LPC . ')'

    ')'  shift, and go to state 288


state 246

   23 inst: LTYPE7 cond imsr ',' spreg . comma
   50 comma: .  [';']
   51      | . ',' comma

    ','  shift, and go to state 41

    $default  reduce using rule 50 (comma)

    comma  go to state 289


state 247

   25 inst: LTYPE8 cond '[' reglist ']' . ',' ioreg

    ','  shift, and go to state 290


state 248

   63 reglist: spreg '-' . spreg
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    sreg   go to state 89
    spreg  go to state 291


state 249

   62 reglist: . spreg
   63        | . spreg '-' spreg
   64        | . spreg comma reglist
   64        | spreg comma . reglist
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    reglist  go to state 292
    sreg     go to state 89
    spreg    go to state 186


state 250

   24 inst: LTYPE8 cond ioreg ',' '[' . reglist ']'
   62 reglist: . spreg
   63        | . spreg '-' spreg
   64        | . spreg comma reglist
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    reglist  go to state 293
    sreg     go to state 89
    spreg    go to state 186


state 251

   28 inst: LTYPE9 cond comma ireg ',' . reg
   86 reg: . spreg
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    reg    go to state 294
    sreg   go to state 89
    spreg  go to state 121


state 252

   26 inst: LTYPE9 cond reg ',' ireg . ',' reg
   27     | LTYPE9 cond reg ',' ireg . comma
   50 comma: .  [';']
   51      | . ',' comma

    ','  shift, and go to state 295

    $default  reduce using rule 50 (comma)

    comma  go to state 296


state 253

  107 name: LNAME '<' '>' offset . '(' LSB ')'

    '('  shift, and go to state 297


state 254

  106 name: LNAME offset '(' pointer . ')'

    ')'  shift, and go to state 298


state 255

  123 expr: expr . '+' expr
  124     | expr . '-' expr
  125     | expr . '*' expr
  126     | expr . '/' expr
  127     | expr . '%' expr
  128     | expr . '<' '<' expr
  129     | expr . '>' '>' expr
  130     | expr . '&' expr
  131     | expr . '^' expr
  132     | expr . '|' expr
  132     | expr '|' expr .  ['|', ';', ',', ')']

    '^'  shift, and go to state 196
    '&'  shift, and go to state 197
    '<'  shift, and go to state 198
    '>'  shift, and go to state 199
    '+'  shift, and go to state 200
    '-'  shift, and go to state 201
    '*'  shift, and go to state 202
    '/'  shift, and go to state 203
    '%'  shift, and go to state 204

    $default  reduce using rule 132 (expr)

    Conflict between rule 132 and token '|' resolved as reduce (%left '|').
    Conflict between rule 132 and token '^' resolved as shift ('|' < '^').
    Conflict between rule 132 and token '&' resolved as shift ('|' < '&').
    Conflict between rule 132 and token '<' resolved as shift ('|' < '<').
    Conflict between rule 132 and token '>' resolved as shift ('|' < '>').
    Conflict between rule 132 and token '+' resolved as shift ('|' < '+').
    Conflict between rule 132 and token '-' resolved as shift ('|' < '-').
    Conflict between rule 132 and token '*' resolved as shift ('|' < '*').
    Conflict between rule 132 and token '/' resolved as shift ('|' < '/').
    Conflict between rule 132 and token '%' resolved as shift ('|' < '%').


state 256

  123 expr: expr . '+' expr
  124     | expr . '-' expr
  125     | expr . '*' expr
  126     | expr . '/' expr
  127     | expr . '%' expr
  128     | expr . '<' '<' expr
  129     | expr . '>' '>' expr
  130     | expr . '&' expr
  131     | expr . '^' expr
  131     | expr '^' expr .  ['|', '^', ';', ',', ')']
  132     | expr . '|' expr

    '&'  shift, and go to state 197
    '<'  shift, and go to state 198
    '>'  shift, and go to state 199
    '+'  shift, and go to state 200
    '-'  shift, and go to state 201
    '*'  shift, and go to state 202
    '/'  shift, and go to state 203
    '%'  shift, and go to state 204

    $default  reduce using rule 131 (expr)

    Conflict between rule 131 and token '|' resolved as reduce ('|' < '^').
    Conflict between rule 131 and token '^' resolved as reduce (%left '^').
    Conflict between rule 131 and token '&' resolved as shift ('^' < '&').
    Conflict between rule 131 and token '<' resolved as shift ('^' < '<').
    Conflict between rule 131 and token '>' resolved as shift ('^' < '>').
    Conflict between rule 131 and token '+' resolved as shift ('^' < '+').
    Conflict between rule 131 and token '-' resolved as shift ('^' < '-').
    Conflict between rule 131 and token '*' resolved as shift ('^' < '*').
    Conflict between rule 131 and token '/' resolved as shift ('^' < '/').
    Conflict between rule 131 and token '%' resolved as shift ('^' < '%').


state 257

  123 expr: expr . '+' expr
  124     | expr . '-' expr
  125     | expr . '*' expr
  126     | expr . '/' expr
  127     | expr . '%' expr
  128     | expr . '<' '<' expr
  129     | expr . '>' '>' expr
  130     | expr . '&' expr
  130     | expr '&' expr .  ['|', '^', '&', ';', ',', ')']
  131     | expr . '^' expr
  132     | expr . '|' expr

    '<'  shift, and go to state 198
    '>'  shift, and go to state 199
    '+'  shift, and go to state 200
    '-'  shift, and go to state 201
    '*'  shift, and go to state 202
    '/'  shift, and go to state 203
    '%'  shift, and go to state 204

    $default  reduce using rule 130 (expr)

    Conflict between rule 130 and token '|' resolved as reduce ('|' < '&').
    Conflict between rule 130 and token '^' resolved as reduce ('^' < '&').
    Conflict between rule 130 and token '&' resolved as reduce (%left '&').
    Conflict between rule 130 and token '<' resolved as shift ('&' < '<').
    Conflict between rule 130 and token '>' resolved as shift ('&' < '>').
    Conflict between rule 130 and token '+' resolved as shift ('&' < '+').
    Conflict between rule 130 and token '-' resolved as shift ('&' < '-').
    Conflict between rule 130 and token '*' resolved as shift ('&' < '*').
    Conflict between rule 130 and token '/' resolved as shift ('&' < '/').
    Conflict between rule 130 and token '%' resolved as shift ('&' < '%').


state 258

  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'
  122 expr: . con
  123     | . expr '+' expr
  124     | . expr '-' expr
  125     | . expr '*' expr
  126     | . expr '/' expr
  127     | . expr '%' expr
  128     | . expr '<' '<' expr
  128     | expr '<' '<' . expr
  129     | . expr '>' '>' expr
  130     | . expr '&' expr
  131     | . expr '^' expr
  132     | . expr '|' expr

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con   go to state 129
    expr  go to state 299


state 259

  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'
  122 expr: . con
  123     | . expr '+' expr
  124     | . expr '-' expr
  125     | . expr '*' expr
  126     | . expr '/' expr
  127     | . expr '%' expr
  128     | . expr '<' '<' expr
  129     | . expr '>' '>' expr
  129     | expr '>' '>' . expr
  130     | . expr '&' expr
  131     | . expr '^' expr
  132     | . expr '|' expr

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con   go to state 129
    expr  go to state 300


state 260

  123 expr: expr . '+' expr
  123     | expr '+' expr .  ['|', '^', '&', '<', '>', '+', '-', ';', ',', ')']
  124     | expr . '-' expr
  125     | expr . '*' expr
  126     | expr . '/' expr
  127     | expr . '%' expr
  128     | expr . '<' '<' expr
  129     | expr . '>' '>' expr
  130     | expr . '&' expr
  131     | expr . '^' expr
  132     | expr . '|' expr

    '*'  shift, and go to state 202
    '/'  shift, and go to state 203
    '%'  shift, and go to state 204

    $default  reduce using rule 123 (expr)

    Conflict between rule 123 and token '|' resolved as reduce ('|' < '+').
    Conflict between rule 123 and token '^' resolved as reduce ('^' < '+').
    Conflict between rule 123 and token '&' resolved as reduce ('&' < '+').
    Conflict between rule 123 and token '<' resolved as reduce ('<' < '+').
    Conflict between rule 123 and token '>' resolved as reduce ('>' < '+').
    Conflict between rule 123 and token '+' resolved as reduce (%left '+').
    Conflict between rule 123 and token '-' resolved as reduce (%left '-').
    Conflict between rule 123 and token '*' resolved as shift ('+' < '*').
    Conflict between rule 123 and token '/' resolved as shift ('+' < '/').
    Conflict between rule 123 and token '%' resolved as shift ('+' < '%').


state 261

  123 expr: expr . '+' expr
  124     | expr . '-' expr
  124     | expr '-' expr .  ['|', '^', '&', '<', '>', '+', '-', ';', ',', ')']
  125     | expr . '*' expr
  126     | expr . '/' expr
  127     | expr . '%' expr
  128     | expr . '<' '<' expr
  129     | expr . '>' '>' expr
  130     | expr . '&' expr
  131     | expr . '^' expr
  132     | expr . '|' expr

    '*'  shift, and go to state 202
    '/'  shift, and go to state 203
    '%'  shift, and go to state 204

    $default  reduce using rule 124 (expr)

    Conflict between rule 124 and token '|' resolved as reduce ('|' < '-').
    Conflict between rule 124 and token '^' resolved as reduce ('^' < '-').
    Conflict between rule 124 and token '&' resolved as reduce ('&' < '-').
    Conflict between rule 124 and token '<' resolved as reduce ('<' < '-').
    Conflict between rule 124 and token '>' resolved as reduce ('>' < '-').
    Conflict between rule 124 and token '+' resolved as reduce (%left '+').
    Conflict between rule 124 and token '-' resolved as reduce (%left '-').
    Conflict between rule 124 and token '*' resolved as shift ('-' < '*').
    Conflict between rule 124 and token '/' resolved as shift ('-' < '/').
    Conflict between rule 124 and token '%' resolved as shift ('-' < '%').


state 262

  123 expr: expr . '+' expr
  124     | expr . '-' expr
  125     | expr . '*' expr
  125     | expr '*' expr .  ['|', '^', '&', '<', '>', '+', '-', '*', '/', '%', ';', ',', ')']
  126     | expr . '/' expr
  127     | expr . '%' expr
  128     | expr . '<' '<' expr
  129     | expr . '>' '>' expr
  130     | expr . '&' expr
  131     | expr . '^' expr
  132     | expr . '|' expr

    $default  reduce using rule 125 (expr)

    Conflict between rule 125 and token '|' resolved as reduce ('|' < '*').
    Conflict between rule 125 and token '^' resolved as reduce ('^' < '*').
    Conflict between rule 125 and token '&' resolved as reduce ('&' < '*').
    Conflict between rule 125 and token '<' resolved as reduce ('<' < '*').
    Conflict between rule 125 and token '>' resolved as reduce ('>' < '*').
    Conflict between rule 125 and token '+' resolved as reduce ('+' < '*').
    Conflict between rule 125 and token '-' resolved as reduce ('-' < '*').
    Conflict between rule 125 and token '*' resolved as reduce (%left '*').
    Conflict between rule 125 and token '/' resolved as reduce (%left '/').
    Conflict between rule 125 and token '%' resolved as reduce (%left '%').


state 263

  123 expr: expr . '+' expr
  124     | expr . '-' expr
  125     | expr . '*' expr
  126     | expr . '/' expr
  126     | expr '/' expr .  ['|', '^', '&', '<', '>', '+', '-', '*', '/', '%', ';', ',', ')']
  127     | expr . '%' expr
  128     | expr . '<' '<' expr
  129     | expr . '>' '>' expr
  130     | expr . '&' expr
  131     | expr . '^' expr
  132     | expr . '|' expr

    $default  reduce using rule 126 (expr)

    Conflict between rule 126 and token '|' resolved as reduce ('|' < '/').
    Conflict between rule 126 and token '^' resolved as reduce ('^' < '/').
    Conflict between rule 126 and token '&' resolved as reduce ('&' < '/').
    Conflict between rule 126 and token '<' resolved as reduce ('<' < '/').
    Conflict between rule 126 and token '>' resolved as reduce ('>' < '/').
    Conflict between rule 126 and token '+' resolved as reduce ('+' < '/').
    Conflict between rule 126 and token '-' resolved as reduce ('-' < '/').
    Conflict between rule 126 and token '*' resolved as reduce (%left '*').
    Conflict between rule 126 and token '/' resolved as reduce (%left '/').
    Conflict between rule 126 and token '%' resolved as reduce (%left '%').


state 264

  123 expr: expr . '+' expr
  124     | expr . '-' expr
  125     | expr . '*' expr
  126     | expr . '/' expr
  127     | expr . '%' expr
  127     | expr '%' expr .  ['|', '^', '&', '<', '>', '+', '-', '*', '/', '%', ';', ',', ')']
  128     | expr . '<' '<' expr
  129     | expr . '>' '>' expr
  130     | expr . '&' expr
  131     | expr . '^' expr
  132     | expr . '|' expr

    $default  reduce using rule 127 (expr)

    Conflict between rule 127 and token '|' resolved as reduce ('|' < '%').
    Conflict between rule 127 and token '^' resolved as reduce ('^' < '%').
    Conflict between rule 127 and token '&' resolved as reduce ('&' < '%').
    Conflict between rule 127 and token '<' resolved as reduce ('<' < '%').
    Conflict between rule 127 and token '>' resolved as reduce ('>' < '%').
    Conflict between rule 127 and token '+' resolved as reduce ('+' < '%').
    Conflict between rule 127 and token '-' resolved as reduce ('-' < '%').
    Conflict between rule 127 and token '*' resolved as reduce (%left '*').
    Conflict between rule 127 and token '/' resolved as reduce (%left '/').
    Conflict between rule 127 and token '%' resolved as reduce (%left '%').


state 265

   31 inst: LTYPEB name ',' con ',' . imm
   32     | LTYPEB name ',' con ',' . imm '-' con
   85 imm: . '$' con

    '$'  shift, and go to state 101

    imm  go to state 301


state 266

  105 name: con '(' pointer ')' .

    $default  reduce using rule 105 (name)


state 267

   33 inst: LTYPEC name '/' con ',' . ximm
   55 ximm: . '$' con
   56     | . '$' oreg
   57     | . '$' '*' '$' oreg
   58     | . '$' LSCONST
   59     | . fcon
   60 fcon: . '$' LFCONST
   61     | . '$' '-' LFCONST

    '$'  shift, and go to state 82

    ximm  go to state 302
    fcon  go to state 84


state 268

   36 inst: LTYPEI cond freg ',' freg .

    $default  reduce using rule 36 (inst)


state 269

   40 inst: LTYPEJ cond con ',' expr . ',' spreg ',' creg ',' creg oexpr
  123 expr: expr . '+' expr
  124     | expr . '-' expr
  125     | expr . '*' expr
  126     | expr . '/' expr
  127     | expr . '%' expr
  128     | expr . '<' '<' expr
  129     | expr . '>' '>' expr
  130     | expr . '&' expr
  131     | expr . '^' expr
  132     | expr . '|' expr

    '|'  shift, and go to state 195
    '^'  shift, and go to state 196
    '&'  shift, and go to state 197
    '<'  shift, and go to state 198
    '>'  shift, and go to state 199
    '+'  shift, and go to state 200
    '-'  shift, and go to state 201
    '*'  shift, and go to state 202
    '/'  shift, and go to state 203
    '%'  shift, and go to state 204
    ','  shift, and go to state 303


state 270

   38 inst: LTYPEK cond frcon ',' LFREG . ',' freg
  103 freg: LFREG .  [';']

    ','  shift, and go to state 304

    $default  reduce using rule 103 (freg)


state 271

   37 inst: LTYPEK cond frcon ',' freg .

    $default  reduce using rule 37 (inst)


state 272

   39 inst: LTYPEL cond freg ',' freg . comma
   50 comma: .  [';']
   51      | . ',' comma

    ','  shift, and go to state 41

    $default  reduce using rule 50 (comma)

    comma  go to state 305


state 273

   41 inst: LTYPEM cond reg ',' reg . ',' regreg

    ','  shift, and go to state 306


state 274

   42 inst: LTYPEN cond reg ',' reg . ',' reg ',' spreg

    ','  shift, and go to state 307


state 275

   80 oreg: name '(' sreg ')' .

    $default  reduce using rule 80 (oreg)


state 276

   78 ioreg: con '(' sreg ')' .

    $default  reduce using rule 78 (ioreg)


state 277

   96 sreg: LR '(' expr ')' .

    $default  reduce using rule 96 (sreg)


state 278

  104 freg: LF '(' con ')' .

    $default  reduce using rule 104 (freg)


state 279

   57 ximm: '$' '*' '$' oreg .

    $default  reduce using rule 57 (ximm)


state 280

   68 gen: shift '(' spreg ')' .

    $default  reduce using rule 68 (gen)


state 281

   88 shift: spreg '<' '<' rcon .

    $default  reduce using rule 88 (shift)


state 282

   92 rcon: spreg .

    $default  reduce using rule 92 (rcon)


state 283

   93 rcon: con .

    $default  reduce using rule 93 (rcon)


state 284

   89 shift: spreg '>' '>' rcon .

    $default  reduce using rule 89 (shift)


state 285

   90 shift: spreg '-' '>' rcon .

    $default  reduce using rule 90 (shift)


state 286

   91 shift: spreg LAT '>' rcon .

    $default  reduce using rule 91 (shift)


state 287

   13 inst: LTYPE1 cond imsr ',' spreg ',' . reg
   14     | LTYPE1 cond imsr ',' spreg ',' .  [';']
   86 reg: . spreg
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    $default  reduce using rule 14 (inst)

    reg    go to state 308
    sreg   go to state 89
    spreg  go to state 121


state 288

   52 rel: con '(' LPC ')' .

    $default  reduce using rule 52 (rel)


state 289

   23 inst: LTYPE7 cond imsr ',' spreg comma .

    $default  reduce using rule 23 (inst)


state 290

   25 inst: LTYPE8 cond '[' reglist ']' ',' . ioreg
   76 ireg: . '(' spreg ')'
   77 ioreg: . ireg
   78      | . con '(' sreg ')'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 68
    '~'     shift, and go to state 54

    ireg   go to state 69
    ioreg  go to state 309
    con    go to state 118


state 291

   63 reglist: spreg '-' spreg .

    $default  reduce using rule 63 (reglist)


state 292

   64 reglist: spreg comma reglist .

    $default  reduce using rule 64 (reglist)


state 293

   24 inst: LTYPE8 cond ioreg ',' '[' reglist . ']'

    ']'  shift, and go to state 310


state 294

   28 inst: LTYPE9 cond comma ireg ',' reg .

    $default  reduce using rule 28 (inst)


state 295

   26 inst: LTYPE9 cond reg ',' ireg ',' . reg
   50 comma: .  [';']
   51      | . ',' comma
   51      | ',' . comma
   86 reg: . spreg
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77
    ','   shift, and go to state 41

    $default  reduce using rule 50 (comma)

    comma  go to state 109
    reg    go to state 311
    sreg   go to state 89
    spreg  go to state 121


state 296

   27 inst: LTYPE9 cond reg ',' ireg comma .

    $default  reduce using rule 27 (inst)


state 297

  107 name: LNAME '<' '>' offset '(' . LSB ')'

    LSB  shift, and go to state 312


state 298

  106 name: LNAME offset '(' pointer ')' .

    $default  reduce using rule 106 (name)


state 299

  123 expr: expr . '+' expr
  124     | expr . '-' expr
  125     | expr . '*' expr
  126     | expr . '/' expr
  127     | expr . '%' expr
  128     | expr . '<' '<' expr
  128     | expr '<' '<' expr .  ['|', '^', '&', '<', '>', ';', ',', ')']
  129     | expr . '>' '>' expr
  130     | expr . '&' expr
  131     | expr . '^' expr
  132     | expr . '|' expr

    '+'  shift, and go to state 200
    '-'  shift, and go to state 201
    '*'  shift, and go to state 202
    '/'  shift, and go to state 203
    '%'  shift, and go to state 204

    $default  reduce using rule 128 (expr)

    Conflict between rule 128 and token '|' resolved as reduce ('|' < '<').
    Conflict between rule 128 and token '^' resolved as reduce ('^' < '<').
    Conflict between rule 128 and token '&' resolved as reduce ('&' < '<').
    Conflict between rule 128 and token '<' resolved as reduce (%left '<').
    Conflict between rule 128 and token '>' resolved as reduce (%left '>').
    Conflict between rule 128 and token '+' resolved as shift ('<' < '+').
    Conflict between rule 128 and token '-' resolved as shift ('<' < '-').
    Conflict between rule 128 and token '*' resolved as shift ('<' < '*').
    Conflict between rule 128 and token '/' resolved as shift ('<' < '/').
    Conflict between rule 128 and token '%' resolved as shift ('<' < '%').


state 300

  123 expr: expr . '+' expr
  124     | expr . '-' expr
  125     | expr . '*' expr
  126     | expr . '/' expr
  127     | expr . '%' expr
  128     | expr . '<' '<' expr
  129     | expr . '>' '>' expr
  129     | expr '>' '>' expr .  ['|', '^', '&', '<', '>', ';', ',', ')']
  130     | expr . '&' expr
  131     | expr . '^' expr
  132     | expr . '|' expr

    '+'  shift, and go to state 200
    '-'  shift, and go to state 201
    '*'  shift, and go to state 202
    '/'  shift, and go to state 203
    '%'  shift, and go to state 204

    $default  reduce using rule 129 (expr)

    Conflict between rule 129 and token '|' resolved as reduce ('|' < '>').
    Conflict between rule 129 and token '^' resolved as reduce ('^' < '>').
    Conflict between rule 129 and token '&' resolved as reduce ('&' < '>').
    Conflict between rule 129 and token '<' resolved as reduce (%left '<').
    Conflict between rule 129 and token '>' resolved as reduce (%left '>').
    Conflict between rule 129 and token '+' resolved as shift ('>' < '+').
    Conflict between rule 129 and token '-' resolved as shift ('>' < '-').
    Conflict between rule 129 and token '*' resolved as shift ('>' < '*').
    Conflict between rule 129 and token '/' resolved as shift ('>' < '/').
    Conflict between rule 129 and token '%' resolved as shift ('>' < '%').


state 301

   31 inst: LTYPEB name ',' con ',' imm .  [';']
   32     | LTYPEB name ',' con ',' imm . '-' con

    '-'  shift, and go to state 313

    $default  reduce using rule 31 (inst)


state 302

   33 inst: LTYPEC name '/' con ',' ximm .

    $default  reduce using rule 33 (inst)


state 303

   40 inst: LTYPEJ cond con ',' expr ',' . spreg ',' creg ',' creg oexpr
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    sreg   go to state 89
    spreg  go to state 314


state 304

   38 inst: LTYPEK cond frcon ',' LFREG ',' . freg
  103 freg: . LFREG
  104     | . LF '(' con ')'

    LF     shift, and go to state 78
    LFREG  shift, and go to state 79

    freg  go to state 315


state 305

   39 inst: LTYPEL cond freg ',' freg comma .

    $default  reduce using rule 39 (inst)


state 306

   41 inst: LTYPEM cond reg ',' reg ',' . regreg
   87 regreg: . '(' spreg ',' spreg ')'

    '('  shift, and go to state 316

    regreg  go to state 317


state 307

   42 inst: LTYPEN cond reg ',' reg ',' . reg ',' spreg
   86 reg: . spreg
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    reg    go to state 318
    sreg   go to state 89
    spreg  go to state 121


state 308

   13 inst: LTYPE1 cond imsr ',' spreg ',' reg .

    $default  reduce using rule 13 (inst)


state 309

   25 inst: LTYPE8 cond '[' reglist ']' ',' ioreg .

    $default  reduce using rule 25 (inst)


state 310

   24 inst: LTYPE8 cond ioreg ',' '[' reglist ']' .

    $default  reduce using rule 24 (inst)


state 311

   26 inst: LTYPE9 cond reg ',' ireg ',' reg .

    $default  reduce using rule 26 (inst)


state 312

  107 name: LNAME '<' '>' offset '(' LSB . ')'

    ')'  shift, and go to state 319


state 313

   32 inst: LTYPEB name ',' con ',' imm '-' . con
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con  go to state 320


state 314

   40 inst: LTYPEJ cond con ',' expr ',' spreg . ',' creg ',' creg oexpr

    ','  shift, and go to state 321


state 315

   38 inst: LTYPEK cond frcon ',' LFREG ',' freg .

    $default  reduce using rule 38 (inst)


state 316

   87 regreg: '(' . spreg ',' spreg ')'
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    sreg   go to state 89
    spreg  go to state 322


state 317

   41 inst: LTYPEM cond reg ',' reg ',' regreg .

    $default  reduce using rule 41 (inst)


state 318

   42 inst: LTYPEN cond reg ',' reg ',' reg . ',' spreg

    ','  shift, and go to state 323


state 319

  107 name: LNAME '<' '>' offset '(' LSB ')' .

    $default  reduce using rule 107 (name)


state 320

   32 inst: LTYPEB name ',' con ',' imm '-' con .

    $default  reduce using rule 32 (inst)


state 321

   40 inst: LTYPEJ cond con ',' expr ',' spreg ',' . creg ',' creg oexpr
   99 creg: . LCREG
  100     | . LC '(' expr ')'

    LC     shift, and go to state 324
    LCREG  shift, and go to state 325

    creg  go to state 326


state 322

   87 regreg: '(' spreg . ',' spreg ')'

    ','  shift, and go to state 327


state 323

   42 inst: LTYPEN cond reg ',' reg ',' reg ',' . spreg
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    sreg   go to state 89
    spreg  go to state 328


state 324

  100 creg: LC . '(' expr ')'

    '('  shift, and go to state 329


state 325

   99 creg: LCREG .

    $default  reduce using rule 99 (creg)


state 326

   40 inst: LTYPEJ cond con ',' expr ',' spreg ',' creg . ',' creg oexpr

    ','  shift, and go to state 330


state 327

   87 regreg: '(' spreg ',' . spreg ')'
   94 sreg: . LREG
   95     | . LPC
   96     | . LR '(' expr ')'
   97 spreg: . sreg
   98      | . LSP

    LSP   shift, and go to state 74
    LPC   shift, and go to state 75
    LR    shift, and go to state 76
    LREG  shift, and go to state 77

    sreg   go to state 89
    spreg  go to state 331


state 328

   42 inst: LTYPEN cond reg ',' reg ',' reg ',' spreg .

    $default  reduce using rule 42 (inst)


state 329

  100 creg: LC '(' . expr ')'
  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'
  122 expr: . con
  123     | . expr '+' expr
  124     | . expr '-' expr
  125     | . expr '*' expr
  126     | . expr '/' expr
  127     | . expr '%' expr
  128     | . expr '<' '<' expr
  129     | . expr '>' '>' expr
  130     | . expr '&' expr
  131     | . expr '^' expr
  132     | . expr '|' expr

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con   go to state 129
    expr  go to state 332


state 330

   40 inst: LTYPEJ cond con ',' expr ',' spreg ',' creg ',' . creg oexpr
   99 creg: . LCREG
  100     | . LC '(' expr ')'

    LC     shift, and go to state 324
    LCREG  shift, and go to state 325

    creg  go to state 333


state 331

   87 regreg: '(' spreg ',' spreg . ')'

    ')'  shift, and go to state 334


state 332

  100 creg: LC '(' expr . ')'
  123 expr: expr . '+' expr
  124     | expr . '-' expr
  125     | expr . '*' expr
  126     | expr . '/' expr
  127     | expr . '%' expr
  128     | expr . '<' '<' expr
  129     | expr . '>' '>' expr
  130     | expr . '&' expr
  131     | expr . '^' expr
  132     | expr . '|' expr

    '|'  shift, and go to state 195
    '^'  shift, and go to state 196
    '&'  shift, and go to state 197
    '<'  shift, and go to state 198
    '>'  shift, and go to state 199
    '+'  shift, and go to state 200
    '-'  shift, and go to state 201
    '*'  shift, and go to state 202
    '/'  shift, and go to state 203
    '%'  shift, and go to state 204
    ')'  shift, and go to state 335


state 333

   40 inst: LTYPEJ cond con ',' expr ',' spreg ',' creg ',' creg . oexpr
  120 oexpr: .  [';']
  121      | . ',' expr

    ','  shift, and go to state 336

    $default  reduce using rule 120 (oexpr)

    oexpr  go to state 337


state 334

   87 regreg: '(' spreg ',' spreg ')' .

    $default  reduce using rule 87 (regreg)


state 335

  100 creg: LC '(' expr ')' .

    $default  reduce using rule 100 (creg)


state 336

  114 con: . LCONST
  115    | . LVAR
  116    | . '-' con
  117    | . '+' con
  118    | . '~' con
  119    | . '(' expr ')'
  121 oexpr: ',' . expr
  122 expr: . con
  123     | . expr '+' expr
  124     | . expr '-' expr
  125     | . expr '*' expr
  126     | . expr '/' expr
  127     | . expr '%' expr
  128     | . expr '<' '<' expr
  129     | . expr '>' '>' expr
  130     | . expr '&' expr
  131     | . expr '^' expr
  132     | . expr '|' expr

    '+'     shift, and go to state 48
    '-'     shift, and go to state 49
    LCONST  shift, and go to state 50
    LVAR    shift, and go to state 52
    '('     shift, and go to state 53
    '~'     shift, and go to state 54

    con   go to state 129
    expr  go to state 338


state 337

   40 inst: LTYPEJ cond con ',' expr ',' spreg ',' creg ',' creg oexpr .

    $default  reduce using rule 40 (inst)


state 338

  121 oexpr: ',' expr .  [';']
  123 expr: expr . '+' expr
  124     | expr . '-' expr
  125     | expr . '*' expr
  126     | expr . '/' expr
  127     | expr . '%' expr
  128     | expr . '<' '<' expr
  129     | expr . '>' '>' expr
  130     | expr . '&' expr
  131     | expr . '^' expr
  132     | expr . '|' expr

    '|'  shift, and go to state 195
    '^'  shift, and go to state 196
    '&'  shift, and go to state 197
    '<'  shift, and go to state 198
    '>'  shift, and go to state 199
    '+'  shift, and go to state 200
    '-'  shift, and go to state 201
    '*'  shift, and go to state 202
    '/'  shift, and go to state 203
    '%'  shift, and go to state 204

    $default  reduce using rule 121 (oexpr)
