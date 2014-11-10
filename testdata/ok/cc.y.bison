State 1 conflicts: 1 shift/reduce
State 31 conflicts: 1 shift/reduce
State 399 conflicts: 1 shift/reduce


Grammar

    0 $accept: prog $end

    1 prog: /* empty */
    2     | prog xdecl

    3 xdecl: zctlist ';'
    4      | zctlist xdlist ';'

    5 $@1: /* empty */

    6 $@2: /* empty */

    7 xdecl: zctlist xdecor $@1 pdecl $@2 block

    8 xdlist: xdecor

    9 $@3: /* empty */

   10 xdlist: xdecor $@3 '=' init
   11       | xdlist ',' xdlist

   12 xdecor: xdecor2
   13       | '*' zgnlist xdecor

   14 xdecor2: tag
   15        | '(' xdecor ')'
   16        | xdecor2 '(' zarglist ')'
   17        | xdecor2 '[' zexpr ']'

   18 adecl: ctlist ';'
   19      | ctlist adlist ';'

   20 adlist: xdecor

   21 $@4: /* empty */

   22 adlist: xdecor $@4 '=' init
   23       | adlist ',' adlist

   24 pdecl: /* empty */
   25      | pdecl ctlist pdlist ';'

   26 pdlist: xdecor
   27       | pdlist ',' pdlist

   28 $@5: /* empty */

   29 edecl: tlist $@5 zedlist ';'

   30 $@6: /* empty */

   31 edecl: edecl tlist $@6 zedlist ';'

   32 zedlist: /* empty */
   33        | edlist

   34 edlist: edecor
   35       | edlist ',' edlist

   36 edecor: xdecor
   37       | tag ':' lexpr
   38       | ':' lexpr

   39 abdecor: /* empty */
   40        | abdecor1

   41 abdecor1: '*' zgnlist
   42         | '*' zgnlist abdecor1
   43         | abdecor2

   44 abdecor2: abdecor3
   45         | abdecor2 '(' zarglist ')'
   46         | abdecor2 '[' zexpr ']'

   47 abdecor3: '(' ')'
   48         | '[' zexpr ']'
   49         | '(' abdecor1 ')'

   50 init: expr
   51     | '{' ilist '}'

   52 qual: '[' lexpr ']'
   53     | '.' ltag
   54     | qual '='

   55 qlist: init ','
   56      | qlist init ','
   57      | qual
   58      | qlist qual

   59 ilist: qlist
   60      | init
   61      | qlist init

   62 zarglist: /* empty */
   63         | arglist

   64 arglist: name
   65        | tlist abdecor
   66        | tlist xdecor
   67        | '.' '.' '.'
   68        | arglist ',' arglist

   69 block: '{' slist '}'

   70 slist: /* empty */
   71      | slist adecl
   72      | slist stmnt

   73 labels: label
   74       | labels label

   75 label: LCASE expr ':'
   76      | LDEFAULT ':'
   77      | LNAME ':'

   78 stmnt: error ';'
   79      | ulstmnt
   80      | labels ulstmnt

   81 forexpr: zcexpr
   82        | ctlist adlist

   83 ulstmnt: zcexpr ';'

   84 $@7: /* empty */

   85 ulstmnt: $@7 block
   86        | LIF '(' cexpr ')' stmnt
   87        | LIF '(' cexpr ')' stmnt LELSE stmnt

   88 $@8: /* empty */

   89 ulstmnt: $@8 LFOR '(' forexpr ';' zcexpr ';' zcexpr ')' stmnt
   90        | LWHILE '(' cexpr ')' stmnt
   91        | LDO stmnt LWHILE '(' cexpr ')' ';'
   92        | LRETURN zcexpr ';'
   93        | LSWITCH '(' cexpr ')' stmnt
   94        | LBREAK ';'
   95        | LCONTINUE ';'
   96        | LGOTO ltag ';'
   97        | LUSED '(' zelist ')' ';'
   98        | LPREFETCH '(' zelist ')' ';'
   99        | LSET '(' zelist ')' ';'

  100 zcexpr: /* empty */
  101       | cexpr

  102 zexpr: /* empty */
  103      | lexpr

  104 lexpr: expr

  105 cexpr: expr
  106      | cexpr ',' cexpr

  107 expr: xuexpr
  108     | expr '*' expr
  109     | expr '/' expr
  110     | expr '%' expr
  111     | expr '+' expr
  112     | expr '-' expr
  113     | expr LRSH expr
  114     | expr LLSH expr
  115     | expr '<' expr
  116     | expr '>' expr
  117     | expr LLE expr
  118     | expr LGE expr
  119     | expr LEQ expr
  120     | expr LNE expr
  121     | expr '&' expr
  122     | expr '^' expr
  123     | expr '|' expr
  124     | expr LANDAND expr
  125     | expr LOROR expr
  126     | expr '?' cexpr ':' expr
  127     | expr '=' expr
  128     | expr LPE expr
  129     | expr LME expr
  130     | expr LMLE expr
  131     | expr LDVE expr
  132     | expr LMDE expr
  133     | expr LLSHE expr
  134     | expr LRSHE expr
  135     | expr LANDE expr
  136     | expr LXORE expr
  137     | expr LORE expr

  138 xuexpr: uexpr
  139       | '(' tlist abdecor ')' xuexpr
  140       | '(' tlist abdecor ')' '{' ilist '}'

  141 uexpr: pexpr
  142      | '*' xuexpr
  143      | '&' xuexpr
  144      | '+' xuexpr
  145      | '-' xuexpr
  146      | '!' xuexpr
  147      | '~' xuexpr
  148      | LPP xuexpr
  149      | LMM xuexpr
  150      | LSIZEOF uexpr
  151      | LSIGNOF uexpr

  152 pexpr: '(' cexpr ')'
  153      | LSIZEOF '(' tlist abdecor ')'
  154      | LSIGNOF '(' tlist abdecor ')'
  155      | pexpr '(' zelist ')'
  156      | pexpr '[' cexpr ']'
  157      | pexpr LMG ltag
  158      | pexpr '.' ltag
  159      | pexpr LPP
  160      | pexpr LMM
  161      | name
  162      | LCONST
  163      | LLCONST
  164      | LUCONST
  165      | LULCONST
  166      | LDCONST
  167      | LFCONST
  168      | LVLCONST
  169      | LUVLCONST
  170      | string
  171      | lstring

  172 string: LSTRING
  173       | string LSTRING

  174 lstring: LLSTRING
  175        | lstring LLSTRING

  176 zelist: /* empty */
  177       | elist

  178 elist: expr
  179      | elist ',' elist

  180 @9: /* empty */

  181 sbody: '{' @9 edecl '}'

  182 zctlist: /* empty */
  183        | ctlist

  184 types: complex
  185      | tname
  186      | gcnlist
  187      | complex gctnlist
  188      | tname gctnlist
  189      | gcnlist complex zgnlist
  190      | gcnlist tname
  191      | gcnlist tname gctnlist

  192 tlist: types

  193 ctlist: types

  194 complex: LSTRUCT ltag

  195 $@10: /* empty */

  196 complex: LSTRUCT ltag $@10 sbody
  197        | LSTRUCT sbody
  198        | LUNION ltag

  199 $@11: /* empty */

  200 complex: LUNION ltag $@11 sbody
  201        | LUNION sbody
  202        | LENUM ltag

  203 $@12: /* empty */

  204 $@13: /* empty */

  205 complex: LENUM ltag $@12 '{' $@13 enum '}'

  206 $@14: /* empty */

  207 complex: LENUM '{' $@14 enum '}'
  208        | LTYPE

  209 gctnlist: gctname
  210         | gctnlist gctname

  211 zgnlist: /* empty */
  212        | zgnlist gname

  213 gctname: tname
  214        | gname
  215        | cname

  216 gcnlist: gcname
  217        | gcnlist gcname

  218 gcname: gname
  219       | cname

  220 enum: LNAME
  221     | LNAME '=' expr
  222     | enum ','
  223     | enum ',' enum

  224 tname: LCHAR
  225      | LSHORT
  226      | LINT
  227      | LLONG
  228      | LSIGNED
  229      | LUNSIGNED
  230      | LFLOAT
  231      | LDOUBLE
  232      | LVOID

  233 cname: LAUTO
  234      | LSTATIC
  235      | LEXTERN
  236      | LTYPEDEF
  237      | LTYPESTR
  238      | LREGISTER
  239      | LINLINE

  240 gname: LCONSTNT
  241      | LVOLATILE
  242      | LRESTRICT

  243 name: LNAME

  244 tag: ltag

  245 ltag: LNAME
  246     | LTYPE


Terminals, with rules where they appear

$end (0) 0
'!' (33) 146
'%' (37) 110
'&' (38) 121 143
'(' (40) 15 16 45 47 49 86 87 89 90 91 93 97 98 99 139 140 152 153
    154 155
')' (41) 15 16 45 47 49 86 87 89 90 91 93 97 98 99 139 140 152 153
    154 155
'*' (42) 13 41 42 108 142
'+' (43) 111 144
',' (44) 11 23 27 35 55 56 68 106 179 222 223
'-' (45) 112 145
'.' (46) 53 67 158
'/' (47) 109
':' (58) 37 38 75 76 77 126
';' (59) 3 4 18 19 25 29 31 78 83 89 91 92 94 95 96 97 98 99
'<' (60) 115
'=' (61) 10 22 54 127 221
'>' (62) 116
'?' (63) 126
'[' (91) 17 46 48 52 156
']' (93) 17 46 48 52 156
'^' (94) 122
'{' (123) 51 69 140 181 205 207
'|' (124) 123
'}' (125) 51 69 140 181 205 207
'~' (126) 147
error (256) 78
LORE (258) 137
LXORE (259) 136
LANDE (260) 135
LLSHE (261) 133
LRSHE (262) 134
LMDE (263) 132
LDVE (264) 131
LMLE (265) 130
LME (266) 129
LPE (267) 128
LOROR (268) 125
LANDAND (269) 124
LNE (270) 120
LEQ (271) 119
LGE (272) 118
LLE (273) 117
LRSH (274) 113
LLSH (275) 114
LMG (276) 157
LPP (277) 148 159
LMM (278) 149 160
LNAME (279) 77 220 221 243 245
LTYPE (280) 208 246
LFCONST (281) 167
LDCONST (282) 166
LCONST (283) 162
LLCONST (284) 163
LUCONST (285) 164
LULCONST (286) 165
LVLCONST (287) 168
LUVLCONST (288) 169
LSTRING (289) 172 173
LLSTRING (290) 174 175
LAUTO (291) 233
LBREAK (292) 94
LCASE (293) 75
LCHAR (294) 224
LCONTINUE (295) 95
LDEFAULT (296) 76
LDO (297) 91
LDOUBLE (298) 231
LELSE (299) 87
LEXTERN (300) 235
LFLOAT (301) 230
LFOR (302) 89
LGOTO (303) 96
LIF (304) 86 87
LINT (305) 226
LLONG (306) 227
LPREFETCH (307) 98
LREGISTER (308) 238
LRETURN (309) 92
LSHORT (310) 225
LSIZEOF (311) 150 153
LUSED (312) 97
LSTATIC (313) 234
LSTRUCT (314) 194 196 197
LSWITCH (315) 93
LTYPEDEF (316) 236
LTYPESTR (317) 237
LUNION (318) 198 200 201
LUNSIGNED (319) 229
LWHILE (320) 90 91
LVOID (321) 232
LENUM (322) 202 205 207
LSIGNED (323) 228
LCONSTNT (324) 240
LVOLATILE (325) 241
LSET (326) 99
LSIGNOF (327) 151 154
LRESTRICT (328) 242
LINLINE (329) 239


Nonterminals, with rules where they appear

$accept (99)
    on left: 0
prog (100)
    on left: 1 2, on right: 0 2
xdecl (101)
    on left: 3 4 7, on right: 2
$@1 (102)
    on left: 5, on right: 7
$@2 (103)
    on left: 6, on right: 7
xdlist (104)
    on left: 8 10 11, on right: 4 11
$@3 (105)
    on left: 9, on right: 10
xdecor (106)
    on left: 12 13, on right: 7 8 10 13 15 20 22 26 36 66
xdecor2 (107)
    on left: 14 15 16 17, on right: 12 16 17
adecl (108)
    on left: 18 19, on right: 71
adlist (109)
    on left: 20 22 23, on right: 19 23 82
$@4 (110)
    on left: 21, on right: 22
pdecl (111)
    on left: 24 25, on right: 7 25
pdlist (112)
    on left: 26 27, on right: 25 27
edecl (113)
    on left: 29 31, on right: 31 181
$@5 (114)
    on left: 28, on right: 29
$@6 (115)
    on left: 30, on right: 31
zedlist (116)
    on left: 32 33, on right: 29 31
edlist (117)
    on left: 34 35, on right: 33 35
edecor (118)
    on left: 36 37 38, on right: 34
abdecor (119)
    on left: 39 40, on right: 65 139 140 153 154
abdecor1 (120)
    on left: 41 42 43, on right: 40 42 49
abdecor2 (121)
    on left: 44 45 46, on right: 43 45 46
abdecor3 (122)
    on left: 47 48 49, on right: 44
init (123)
    on left: 50 51, on right: 10 22 55 56 60 61
qual (124)
    on left: 52 53 54, on right: 54 57 58
qlist (125)
    on left: 55 56 57 58, on right: 56 58 59 61
ilist (126)
    on left: 59 60 61, on right: 51 140
zarglist (127)
    on left: 62 63, on right: 16 45
arglist (128)
    on left: 64 65 66 67 68, on right: 63 68
block (129)
    on left: 69, on right: 7 85
slist (130)
    on left: 70 71 72, on right: 69 71 72
labels (131)
    on left: 73 74, on right: 74 80
label (132)
    on left: 75 76 77, on right: 73 74
stmnt (133)
    on left: 78 79 80, on right: 72 86 87 89 90 91 93
forexpr (134)
    on left: 81 82, on right: 89
ulstmnt (135)
    on left: 83 85 86 87 89 90 91 92 93 94 95 96 97 98 99, on right:
    79 80
$@7 (136)
    on left: 84, on right: 85
$@8 (137)
    on left: 88, on right: 89
zcexpr (138)
    on left: 100 101, on right: 81 83 89 92
zexpr (139)
    on left: 102 103, on right: 17 46 48
lexpr (140)
    on left: 104, on right: 37 38 52 103
cexpr (141)
    on left: 105 106, on right: 86 87 90 91 93 101 106 126 152 156
expr (142)
    on left: 107 108 109 110 111 112 113 114 115 116 117 118 119 120
    121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136
    137, on right: 50 75 104 105 108 109 110 111 112 113 114 115 116
    117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132
    133 134 135 136 137 178 221
xuexpr (143)
    on left: 138 139 140, on right: 107 139 142 143 144 145 146 147
    148 149
uexpr (144)
    on left: 141 142 143 144 145 146 147 148 149 150 151, on right:
    138 150 151
pexpr (145)
    on left: 152 153 154 155 156 157 158 159 160 161 162 163 164 165
    166 167 168 169 170 171, on right: 141 155 156 157 158 159 160
string (146)
    on left: 172 173, on right: 170 173
lstring (147)
    on left: 174 175, on right: 171 175
zelist (148)
    on left: 176 177, on right: 97 98 99 155
elist (149)
    on left: 178 179, on right: 177 179
sbody (150)
    on left: 181, on right: 196 197 200 201
@9 (151)
    on left: 180, on right: 181
zctlist (152)
    on left: 182 183, on right: 3 4 7
types (153)
    on left: 184 185 186 187 188 189 190 191, on right: 192 193
tlist (154)
    on left: 192, on right: 29 31 65 66 139 140 153 154
ctlist (155)
    on left: 193, on right: 18 19 25 82 183
complex (156)
    on left: 194 196 197 198 200 201 202 205 207 208, on right: 184
    187 189
$@10 (157)
    on left: 195, on right: 196
$@11 (158)
    on left: 199, on right: 200
$@12 (159)
    on left: 203, on right: 205
$@13 (160)
    on left: 204, on right: 205
$@14 (161)
    on left: 206, on right: 207
gctnlist (162)
    on left: 209 210, on right: 187 188 191 210
zgnlist (163)
    on left: 211 212, on right: 13 41 42 189 212
gctname (164)
    on left: 213 214 215, on right: 209 210
gcnlist (165)
    on left: 216 217, on right: 186 189 190 191 217
gcname (166)
    on left: 218 219, on right: 216 217
enum (167)
    on left: 220 221 222 223, on right: 205 207 222 223
tname (168)
    on left: 224 225 226 227 228 229 230 231 232, on right: 185 188
    190 191 213
cname (169)
    on left: 233 234 235 236 237 238 239, on right: 215 219
gname (170)
    on left: 240 241 242, on right: 212 214 218
name (171)
    on left: 243, on right: 64 161
tag (172)
    on left: 244, on right: 14 37
ltag (173)
    on left: 245 246, on right: 53 96 157 158 194 196 198 200 202 205
    244


state 0

    0 $accept: . prog $end
    1 prog: .
    2     | . prog xdecl

    $default  reduce using rule 1 (prog)

    prog  go to state 1


state 1

    0 $accept: prog . $end
    2 prog: prog . xdecl
    3 xdecl: . zctlist ';'
    4      | . zctlist xdlist ';'
    7      | . zctlist xdecor $@1 pdecl $@2 block
  182 zctlist: .  [';', '*', '(', LNAME, LTYPE]
  183        | . ctlist
  184 types: . complex
  185      | . tname
  186      | . gcnlist
  187      | . complex gctnlist
  188      | . tname gctnlist
  189      | . gcnlist complex zgnlist
  190      | . gcnlist tname
  191      | . gcnlist tname gctnlist
  193 ctlist: . types
  194 complex: . LSTRUCT ltag
  196        | . LSTRUCT ltag $@10 sbody
  197        | . LSTRUCT sbody
  198        | . LUNION ltag
  200        | . LUNION ltag $@11 sbody
  201        | . LUNION sbody
  202        | . LENUM ltag
  205        | . LENUM ltag $@12 '{' $@13 enum '}'
  207        | . LENUM '{' $@14 enum '}'
  208        | . LTYPE
  216 gcnlist: . gcname
  217        | . gcnlist gcname
  218 gcname: . gname
  219       | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT

    $end       shift, and go to state 2
    LTYPE      shift, and go to state 3
    LAUTO      shift, and go to state 4
    LCHAR      shift, and go to state 5
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LREGISTER  shift, and go to state 11
    LSHORT     shift, and go to state 12
    LSTATIC    shift, and go to state 13
    LSTRUCT    shift, and go to state 14
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNION     shift, and go to state 17
    LUNSIGNED  shift, and go to state 18
    LVOID      shift, and go to state 19
    LENUM      shift, and go to state 20
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25

    LTYPE     [reduce using rule 182 (zctlist)]
    $default  reduce using rule 182 (zctlist)

    xdecl    go to state 26
    zctlist  go to state 27
    types    go to state 28
    ctlist   go to state 29
    complex  go to state 30
    gcnlist  go to state 31
    gcname   go to state 32
    tname    go to state 33
    cname    go to state 34
    gname    go to state 35


state 2

    0 $accept: prog $end .

    $default  accept


state 3

  208 complex: LTYPE .

    $default  reduce using rule 208 (complex)


state 4

  233 cname: LAUTO .

    $default  reduce using rule 233 (cname)


state 5

  224 tname: LCHAR .

    $default  reduce using rule 224 (tname)


state 6

  231 tname: LDOUBLE .

    $default  reduce using rule 231 (tname)


state 7

  235 cname: LEXTERN .

    $default  reduce using rule 235 (cname)


state 8

  230 tname: LFLOAT .

    $default  reduce using rule 230 (tname)


state 9

  226 tname: LINT .

    $default  reduce using rule 226 (tname)


state 10

  227 tname: LLONG .

    $default  reduce using rule 227 (tname)


state 11

  238 cname: LREGISTER .

    $default  reduce using rule 238 (cname)


state 12

  225 tname: LSHORT .

    $default  reduce using rule 225 (tname)


state 13

  234 cname: LSTATIC .

    $default  reduce using rule 234 (cname)


state 14

  181 sbody: . '{' @9 edecl '}'
  194 complex: LSTRUCT . ltag
  196        | LSTRUCT . ltag $@10 sbody
  197        | LSTRUCT . sbody
  245 ltag: . LNAME
  246     | . LTYPE

    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37
    '{'    shift, and go to state 38

    sbody  go to state 39
    ltag   go to state 40


state 15

  236 cname: LTYPEDEF .

    $default  reduce using rule 236 (cname)


state 16

  237 cname: LTYPESTR .

    $default  reduce using rule 237 (cname)


state 17

  181 sbody: . '{' @9 edecl '}'
  198 complex: LUNION . ltag
  200        | LUNION . ltag $@11 sbody
  201        | LUNION . sbody
  245 ltag: . LNAME
  246     | . LTYPE

    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37
    '{'    shift, and go to state 38

    sbody  go to state 41
    ltag   go to state 42


state 18

  229 tname: LUNSIGNED .

    $default  reduce using rule 229 (tname)


state 19

  232 tname: LVOID .

    $default  reduce using rule 232 (tname)


state 20

  202 complex: LENUM . ltag
  205        | LENUM . ltag $@12 '{' $@13 enum '}'
  207        | LENUM . '{' $@14 enum '}'
  245 ltag: . LNAME
  246     | . LTYPE

    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37
    '{'    shift, and go to state 43

    ltag  go to state 44


state 21

  228 tname: LSIGNED .

    $default  reduce using rule 228 (tname)


state 22

  240 gname: LCONSTNT .

    $default  reduce using rule 240 (gname)


state 23

  241 gname: LVOLATILE .

    $default  reduce using rule 241 (gname)


state 24

  242 gname: LRESTRICT .

    $default  reduce using rule 242 (gname)


state 25

  239 cname: LINLINE .

    $default  reduce using rule 239 (cname)


state 26

    2 prog: prog xdecl .

    $default  reduce using rule 2 (prog)


state 27

    3 xdecl: zctlist . ';'
    4      | zctlist . xdlist ';'
    7      | zctlist . xdecor $@1 pdecl $@2 block
    8 xdlist: . xdecor
   10       | . xdecor $@3 '=' init
   11       | . xdlist ',' xdlist
   12 xdecor: . xdecor2
   13       | . '*' zgnlist xdecor
   14 xdecor2: . tag
   15        | . '(' xdecor ')'
   16        | . xdecor2 '(' zarglist ')'
   17        | . xdecor2 '[' zexpr ']'
  244 tag: . ltag
  245 ltag: . LNAME
  246     | . LTYPE

    ';'    shift, and go to state 45
    '*'    shift, and go to state 46
    '('    shift, and go to state 47
    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37

    xdlist   go to state 48
    xdecor   go to state 49
    xdecor2  go to state 50
    tag      go to state 51
    ltag     go to state 52


state 28

  193 ctlist: types .

    $default  reduce using rule 193 (ctlist)


state 29

  183 zctlist: ctlist .

    $default  reduce using rule 183 (zctlist)


state 30

  184 types: complex .  [';', ',', ':', '*', '[', '(', LNAME, LTYPE, ')']
  187      | complex . gctnlist
  209 gctnlist: . gctname
  210         | . gctnlist gctname
  213 gctname: . tname
  214        | . gname
  215        | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT

    LAUTO      shift, and go to state 4
    LCHAR      shift, and go to state 5
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LREGISTER  shift, and go to state 11
    LSHORT     shift, and go to state 12
    LSTATIC    shift, and go to state 13
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNSIGNED  shift, and go to state 18
    LVOID      shift, and go to state 19
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25

    $default  reduce using rule 184 (types)

    gctnlist  go to state 53
    gctname   go to state 54
    tname     go to state 55
    cname     go to state 56
    gname     go to state 57


state 31

  186 types: gcnlist .  [';', ',', ':', '*', '[', '(', LNAME, LTYPE, ')']
  189      | gcnlist . complex zgnlist
  190      | gcnlist . tname
  191      | gcnlist . tname gctnlist
  194 complex: . LSTRUCT ltag
  196        | . LSTRUCT ltag $@10 sbody
  197        | . LSTRUCT sbody
  198        | . LUNION ltag
  200        | . LUNION ltag $@11 sbody
  201        | . LUNION sbody
  202        | . LENUM ltag
  205        | . LENUM ltag $@12 '{' $@13 enum '}'
  207        | . LENUM '{' $@14 enum '}'
  208        | . LTYPE
  217 gcnlist: gcnlist . gcname
  218 gcname: . gname
  219       | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT

    LTYPE      shift, and go to state 3
    LAUTO      shift, and go to state 4
    LCHAR      shift, and go to state 5
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LREGISTER  shift, and go to state 11
    LSHORT     shift, and go to state 12
    LSTATIC    shift, and go to state 13
    LSTRUCT    shift, and go to state 14
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNION     shift, and go to state 17
    LUNSIGNED  shift, and go to state 18
    LVOID      shift, and go to state 19
    LENUM      shift, and go to state 20
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25

    LTYPE     [reduce using rule 186 (types)]
    $default  reduce using rule 186 (types)

    complex  go to state 58
    gcname   go to state 59
    tname    go to state 60
    cname    go to state 34
    gname    go to state 35


state 32

  216 gcnlist: gcname .

    $default  reduce using rule 216 (gcnlist)


state 33

  185 types: tname .  [';', ',', ':', '*', '[', '(', LNAME, LTYPE, ')']
  188      | tname . gctnlist
  209 gctnlist: . gctname
  210         | . gctnlist gctname
  213 gctname: . tname
  214        | . gname
  215        | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT

    LAUTO      shift, and go to state 4
    LCHAR      shift, and go to state 5
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LREGISTER  shift, and go to state 11
    LSHORT     shift, and go to state 12
    LSTATIC    shift, and go to state 13
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNSIGNED  shift, and go to state 18
    LVOID      shift, and go to state 19
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25

    $default  reduce using rule 185 (types)

    gctnlist  go to state 61
    gctname   go to state 54
    tname     go to state 55
    cname     go to state 56
    gname     go to state 57


state 34

  219 gcname: cname .

    $default  reduce using rule 219 (gcname)


state 35

  218 gcname: gname .

    $default  reduce using rule 218 (gcname)


state 36

  245 ltag: LNAME .

    $default  reduce using rule 245 (ltag)


state 37

  246 ltag: LTYPE .

    $default  reduce using rule 246 (ltag)


state 38

  180 @9: .
  181 sbody: '{' . @9 edecl '}'

    $default  reduce using rule 180 (@9)

    @9  go to state 62


state 39

  197 complex: LSTRUCT sbody .

    $default  reduce using rule 197 (complex)


state 40

  194 complex: LSTRUCT ltag .  [';', ',', ':', '*', '[', '(', LNAME, LTYPE, LAUTO, LCHAR, LDOUBLE, LEXTERN, LFLOAT, LINT, LLONG, LREGISTER, LSHORT, LSTATIC, LTYPEDEF, LTYPESTR, LUNSIGNED, LVOID, LSIGNED, LCONSTNT, LVOLATILE, LRESTRICT, LINLINE, ')']
  195 $@10: .  ['{']
  196 complex: LSTRUCT ltag . $@10 sbody

    '{'       reduce using rule 195 ($@10)
    $default  reduce using rule 194 (complex)

    $@10  go to state 63


state 41

  201 complex: LUNION sbody .

    $default  reduce using rule 201 (complex)


state 42

  198 complex: LUNION ltag .  [';', ',', ':', '*', '[', '(', LNAME, LTYPE, LAUTO, LCHAR, LDOUBLE, LEXTERN, LFLOAT, LINT, LLONG, LREGISTER, LSHORT, LSTATIC, LTYPEDEF, LTYPESTR, LUNSIGNED, LVOID, LSIGNED, LCONSTNT, LVOLATILE, LRESTRICT, LINLINE, ')']
  199 $@11: .  ['{']
  200 complex: LUNION ltag . $@11 sbody

    '{'       reduce using rule 199 ($@11)
    $default  reduce using rule 198 (complex)

    $@11  go to state 64


state 43

  206 $@14: .
  207 complex: LENUM '{' . $@14 enum '}'

    $default  reduce using rule 206 ($@14)

    $@14  go to state 65


state 44

  202 complex: LENUM ltag .  [';', ',', ':', '*', '[', '(', LNAME, LTYPE, LAUTO, LCHAR, LDOUBLE, LEXTERN, LFLOAT, LINT, LLONG, LREGISTER, LSHORT, LSTATIC, LTYPEDEF, LTYPESTR, LUNSIGNED, LVOID, LSIGNED, LCONSTNT, LVOLATILE, LRESTRICT, LINLINE, ')']
  203 $@12: .  ['{']
  205 complex: LENUM ltag . $@12 '{' $@13 enum '}'

    '{'       reduce using rule 203 ($@12)
    $default  reduce using rule 202 (complex)

    $@12  go to state 66


state 45

    3 xdecl: zctlist ';' .

    $default  reduce using rule 3 (xdecl)


state 46

   13 xdecor: '*' . zgnlist xdecor
  211 zgnlist: .
  212        | . zgnlist gname

    $default  reduce using rule 211 (zgnlist)

    zgnlist  go to state 67


state 47

   12 xdecor: . xdecor2
   13       | . '*' zgnlist xdecor
   14 xdecor2: . tag
   15        | . '(' xdecor ')'
   15        | '(' . xdecor ')'
   16        | . xdecor2 '(' zarglist ')'
   17        | . xdecor2 '[' zexpr ']'
  244 tag: . ltag
  245 ltag: . LNAME
  246     | . LTYPE

    '*'    shift, and go to state 46
    '('    shift, and go to state 47
    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37

    xdecor   go to state 68
    xdecor2  go to state 50
    tag      go to state 51
    ltag     go to state 52


state 48

    4 xdecl: zctlist xdlist . ';'
   11 xdlist: xdlist . ',' xdlist

    ';'  shift, and go to state 69
    ','  shift, and go to state 70


state 49

    5 $@1: .  [LTYPE, LAUTO, LCHAR, LDOUBLE, LEXTERN, LFLOAT, LINT, LLONG, LREGISTER, LSHORT, LSTATIC, LSTRUCT, LTYPEDEF, LTYPESTR, LUNION, LUNSIGNED, LVOID, LENUM, LSIGNED, LCONSTNT, LVOLATILE, LRESTRICT, LINLINE, '{']
    7 xdecl: zctlist xdecor . $@1 pdecl $@2 block
    8 xdlist: xdecor .  [';', ',']
    9 $@3: .  ['=']
   10 xdlist: xdecor . $@3 '=' init

    ';'       reduce using rule 8 (xdlist)
    ','       reduce using rule 8 (xdlist)
    '='       reduce using rule 9 ($@3)
    $default  reduce using rule 5 ($@1)

    $@1  go to state 71
    $@3  go to state 72


state 50

   12 xdecor: xdecor2 .  [';', ',', '=', LTYPE, LAUTO, LCHAR, LDOUBLE, LEXTERN, LFLOAT, LINT, LLONG, LREGISTER, LSHORT, LSTATIC, LSTRUCT, LTYPEDEF, LTYPESTR, LUNION, LUNSIGNED, LVOID, LENUM, LSIGNED, LCONSTNT, LVOLATILE, LRESTRICT, LINLINE, ')', '{']
   16 xdecor2: xdecor2 . '(' zarglist ')'
   17        | xdecor2 . '[' zexpr ']'

    '['  shift, and go to state 73
    '('  shift, and go to state 74

    $default  reduce using rule 12 (xdecor)


state 51

   14 xdecor2: tag .

    $default  reduce using rule 14 (xdecor2)


state 52

  244 tag: ltag .

    $default  reduce using rule 244 (tag)


state 53

  187 types: complex gctnlist .  [';', ',', ':', '*', '[', '(', LNAME, LTYPE, ')']
  210 gctnlist: gctnlist . gctname
  213 gctname: . tname
  214        | . gname
  215        | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT

    LAUTO      shift, and go to state 4
    LCHAR      shift, and go to state 5
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LREGISTER  shift, and go to state 11
    LSHORT     shift, and go to state 12
    LSTATIC    shift, and go to state 13
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNSIGNED  shift, and go to state 18
    LVOID      shift, and go to state 19
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25

    $default  reduce using rule 187 (types)

    gctname  go to state 75
    tname    go to state 55
    cname    go to state 56
    gname    go to state 57


state 54

  209 gctnlist: gctname .

    $default  reduce using rule 209 (gctnlist)


state 55

  213 gctname: tname .

    $default  reduce using rule 213 (gctname)


state 56

  215 gctname: cname .

    $default  reduce using rule 215 (gctname)


state 57

  214 gctname: gname .

    $default  reduce using rule 214 (gctname)


state 58

  189 types: gcnlist complex . zgnlist
  211 zgnlist: .
  212        | . zgnlist gname

    $default  reduce using rule 211 (zgnlist)

    zgnlist  go to state 76


state 59

  217 gcnlist: gcnlist gcname .

    $default  reduce using rule 217 (gcnlist)


state 60

  190 types: gcnlist tname .  [';', ',', ':', '*', '[', '(', LNAME, LTYPE, ')']
  191      | gcnlist tname . gctnlist
  209 gctnlist: . gctname
  210         | . gctnlist gctname
  213 gctname: . tname
  214        | . gname
  215        | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT

    LAUTO      shift, and go to state 4
    LCHAR      shift, and go to state 5
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LREGISTER  shift, and go to state 11
    LSHORT     shift, and go to state 12
    LSTATIC    shift, and go to state 13
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNSIGNED  shift, and go to state 18
    LVOID      shift, and go to state 19
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25

    $default  reduce using rule 190 (types)

    gctnlist  go to state 77
    gctname   go to state 54
    tname     go to state 55
    cname     go to state 56
    gname     go to state 57


state 61

  188 types: tname gctnlist .  [';', ',', ':', '*', '[', '(', LNAME, LTYPE, ')']
  210 gctnlist: gctnlist . gctname
  213 gctname: . tname
  214        | . gname
  215        | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT

    LAUTO      shift, and go to state 4
    LCHAR      shift, and go to state 5
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LREGISTER  shift, and go to state 11
    LSHORT     shift, and go to state 12
    LSTATIC    shift, and go to state 13
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNSIGNED  shift, and go to state 18
    LVOID      shift, and go to state 19
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25

    $default  reduce using rule 188 (types)

    gctname  go to state 75
    tname    go to state 55
    cname    go to state 56
    gname    go to state 57


state 62

   29 edecl: . tlist $@5 zedlist ';'
   31      | . edecl tlist $@6 zedlist ';'
  181 sbody: '{' @9 . edecl '}'
  184 types: . complex
  185      | . tname
  186      | . gcnlist
  187      | . complex gctnlist
  188      | . tname gctnlist
  189      | . gcnlist complex zgnlist
  190      | . gcnlist tname
  191      | . gcnlist tname gctnlist
  192 tlist: . types
  194 complex: . LSTRUCT ltag
  196        | . LSTRUCT ltag $@10 sbody
  197        | . LSTRUCT sbody
  198        | . LUNION ltag
  200        | . LUNION ltag $@11 sbody
  201        | . LUNION sbody
  202        | . LENUM ltag
  205        | . LENUM ltag $@12 '{' $@13 enum '}'
  207        | . LENUM '{' $@14 enum '}'
  208        | . LTYPE
  216 gcnlist: . gcname
  217        | . gcnlist gcname
  218 gcname: . gname
  219       | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT

    LTYPE      shift, and go to state 3
    LAUTO      shift, and go to state 4
    LCHAR      shift, and go to state 5
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LREGISTER  shift, and go to state 11
    LSHORT     shift, and go to state 12
    LSTATIC    shift, and go to state 13
    LSTRUCT    shift, and go to state 14
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNION     shift, and go to state 17
    LUNSIGNED  shift, and go to state 18
    LVOID      shift, and go to state 19
    LENUM      shift, and go to state 20
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25

    edecl    go to state 78
    types    go to state 79
    tlist    go to state 80
    complex  go to state 30
    gcnlist  go to state 31
    gcname   go to state 32
    tname    go to state 33
    cname    go to state 34
    gname    go to state 35


state 63

  181 sbody: . '{' @9 edecl '}'
  196 complex: LSTRUCT ltag $@10 . sbody

    '{'  shift, and go to state 38

    sbody  go to state 81


state 64

  181 sbody: . '{' @9 edecl '}'
  200 complex: LUNION ltag $@11 . sbody

    '{'  shift, and go to state 38

    sbody  go to state 82


state 65

  207 complex: LENUM '{' $@14 . enum '}'
  220 enum: . LNAME
  221     | . LNAME '=' expr
  222     | . enum ','
  223     | . enum ',' enum

    LNAME  shift, and go to state 83

    enum  go to state 84


state 66

  205 complex: LENUM ltag $@12 . '{' $@13 enum '}'

    '{'  shift, and go to state 85


state 67

   12 xdecor: . xdecor2
   13       | . '*' zgnlist xdecor
   13       | '*' zgnlist . xdecor
   14 xdecor2: . tag
   15        | . '(' xdecor ')'
   16        | . xdecor2 '(' zarglist ')'
   17        | . xdecor2 '[' zexpr ']'
  212 zgnlist: zgnlist . gname
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT
  244 tag: . ltag
  245 ltag: . LNAME
  246     | . LTYPE

    '*'        shift, and go to state 46
    '('        shift, and go to state 47
    LNAME      shift, and go to state 36
    LTYPE      shift, and go to state 37
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LRESTRICT  shift, and go to state 24

    xdecor   go to state 86
    xdecor2  go to state 50
    gname    go to state 87
    tag      go to state 51
    ltag     go to state 52


state 68

   15 xdecor2: '(' xdecor . ')'

    ')'  shift, and go to state 88


state 69

    4 xdecl: zctlist xdlist ';' .

    $default  reduce using rule 4 (xdecl)


state 70

    8 xdlist: . xdecor
   10       | . xdecor $@3 '=' init
   11       | . xdlist ',' xdlist
   11       | xdlist ',' . xdlist
   12 xdecor: . xdecor2
   13       | . '*' zgnlist xdecor
   14 xdecor2: . tag
   15        | . '(' xdecor ')'
   16        | . xdecor2 '(' zarglist ')'
   17        | . xdecor2 '[' zexpr ']'
  244 tag: . ltag
  245 ltag: . LNAME
  246     | . LTYPE

    '*'    shift, and go to state 46
    '('    shift, and go to state 47
    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37

    xdlist   go to state 89
    xdecor   go to state 90
    xdecor2  go to state 50
    tag      go to state 51
    ltag     go to state 52


state 71

    7 xdecl: zctlist xdecor $@1 . pdecl $@2 block
   24 pdecl: .
   25      | . pdecl ctlist pdlist ';'

    $default  reduce using rule 24 (pdecl)

    pdecl  go to state 91


state 72

   10 xdlist: xdecor $@3 . '=' init

    '='  shift, and go to state 92


state 73

   17 xdecor2: xdecor2 '[' . zexpr ']'
  102 zexpr: .  [']']
  103      | . lexpr
  104 lexpr: . expr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    $default  reduce using rule 102 (zexpr)

    zexpr    go to state 115
    lexpr    go to state 116
    expr     go to state 117
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 74

   16 xdecor2: xdecor2 '(' . zarglist ')'
   62 zarglist: .  [')']
   63         | . arglist
   64 arglist: . name
   65        | . tlist abdecor
   66        | . tlist xdecor
   67        | . '.' '.' '.'
   68        | . arglist ',' arglist
  184 types: . complex
  185      | . tname
  186      | . gcnlist
  187      | . complex gctnlist
  188      | . tname gctnlist
  189      | . gcnlist complex zgnlist
  190      | . gcnlist tname
  191      | . gcnlist tname gctnlist
  192 tlist: . types
  194 complex: . LSTRUCT ltag
  196        | . LSTRUCT ltag $@10 sbody
  197        | . LSTRUCT sbody
  198        | . LUNION ltag
  200        | . LUNION ltag $@11 sbody
  201        | . LUNION sbody
  202        | . LENUM ltag
  205        | . LENUM ltag $@12 '{' $@13 enum '}'
  207        | . LENUM '{' $@14 enum '}'
  208        | . LTYPE
  216 gcnlist: . gcname
  217        | . gcnlist gcname
  218 gcname: . gname
  219       | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT
  243 name: . LNAME

    '.'        shift, and go to state 124
    LNAME      shift, and go to state 100
    LTYPE      shift, and go to state 3
    LAUTO      shift, and go to state 4
    LCHAR      shift, and go to state 5
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LREGISTER  shift, and go to state 11
    LSHORT     shift, and go to state 12
    LSTATIC    shift, and go to state 13
    LSTRUCT    shift, and go to state 14
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNION     shift, and go to state 17
    LUNSIGNED  shift, and go to state 18
    LVOID      shift, and go to state 19
    LENUM      shift, and go to state 20
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25

    $default  reduce using rule 62 (zarglist)

    zarglist  go to state 125
    arglist   go to state 126
    types     go to state 79
    tlist     go to state 127
    complex   go to state 30
    gcnlist   go to state 31
    gcname    go to state 32
    tname     go to state 33
    cname     go to state 34
    gname     go to state 35
    name      go to state 128


state 75

  210 gctnlist: gctnlist gctname .

    $default  reduce using rule 210 (gctnlist)


state 76

  189 types: gcnlist complex zgnlist .  [';', ',', ':', '*', '[', '(', LNAME, LTYPE, ')']
  212 zgnlist: zgnlist . gname
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT

    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LRESTRICT  shift, and go to state 24

    $default  reduce using rule 189 (types)

    gname  go to state 87


state 77

  191 types: gcnlist tname gctnlist .  [';', ',', ':', '*', '[', '(', LNAME, LTYPE, ')']
  210 gctnlist: gctnlist . gctname
  213 gctname: . tname
  214        | . gname
  215        | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT

    LAUTO      shift, and go to state 4
    LCHAR      shift, and go to state 5
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LREGISTER  shift, and go to state 11
    LSHORT     shift, and go to state 12
    LSTATIC    shift, and go to state 13
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNSIGNED  shift, and go to state 18
    LVOID      shift, and go to state 19
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25

    $default  reduce using rule 191 (types)

    gctname  go to state 75
    tname    go to state 55
    cname    go to state 56
    gname    go to state 57


state 78

   31 edecl: edecl . tlist $@6 zedlist ';'
  181 sbody: '{' @9 edecl . '}'
  184 types: . complex
  185      | . tname
  186      | . gcnlist
  187      | . complex gctnlist
  188      | . tname gctnlist
  189      | . gcnlist complex zgnlist
  190      | . gcnlist tname
  191      | . gcnlist tname gctnlist
  192 tlist: . types
  194 complex: . LSTRUCT ltag
  196        | . LSTRUCT ltag $@10 sbody
  197        | . LSTRUCT sbody
  198        | . LUNION ltag
  200        | . LUNION ltag $@11 sbody
  201        | . LUNION sbody
  202        | . LENUM ltag
  205        | . LENUM ltag $@12 '{' $@13 enum '}'
  207        | . LENUM '{' $@14 enum '}'
  208        | . LTYPE
  216 gcnlist: . gcname
  217        | . gcnlist gcname
  218 gcname: . gname
  219       | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT

    LTYPE      shift, and go to state 3
    LAUTO      shift, and go to state 4
    LCHAR      shift, and go to state 5
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LREGISTER  shift, and go to state 11
    LSHORT     shift, and go to state 12
    LSTATIC    shift, and go to state 13
    LSTRUCT    shift, and go to state 14
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNION     shift, and go to state 17
    LUNSIGNED  shift, and go to state 18
    LVOID      shift, and go to state 19
    LENUM      shift, and go to state 20
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25
    '}'        shift, and go to state 129

    types    go to state 79
    tlist    go to state 130
    complex  go to state 30
    gcnlist  go to state 31
    gcname   go to state 32
    tname    go to state 33
    cname    go to state 34
    gname    go to state 35


state 79

  192 tlist: types .

    $default  reduce using rule 192 (tlist)


state 80

   28 $@5: .
   29 edecl: tlist . $@5 zedlist ';'

    $default  reduce using rule 28 ($@5)

    $@5  go to state 131


state 81

  196 complex: LSTRUCT ltag $@10 sbody .

    $default  reduce using rule 196 (complex)


state 82

  200 complex: LUNION ltag $@11 sbody .

    $default  reduce using rule 200 (complex)


state 83

  220 enum: LNAME .  [',', '}']
  221     | LNAME . '=' expr

    '='  shift, and go to state 132

    $default  reduce using rule 220 (enum)


state 84

  207 complex: LENUM '{' $@14 enum . '}'
  222 enum: enum . ','
  223     | enum . ',' enum

    ','  shift, and go to state 133
    '}'  shift, and go to state 134


state 85

  204 $@13: .
  205 complex: LENUM ltag $@12 '{' . $@13 enum '}'

    $default  reduce using rule 204 ($@13)

    $@13  go to state 135


state 86

   13 xdecor: '*' zgnlist xdecor .

    $default  reduce using rule 13 (xdecor)


state 87

  212 zgnlist: zgnlist gname .

    $default  reduce using rule 212 (zgnlist)


state 88

   15 xdecor2: '(' xdecor ')' .

    $default  reduce using rule 15 (xdecor2)


state 89

   11 xdlist: xdlist . ',' xdlist
   11       | xdlist ',' xdlist .  [';', ',']

    $default  reduce using rule 11 (xdlist)

    Conflict between rule 11 and token ',' resolved as reduce (%left ',').


state 90

    8 xdlist: xdecor .  [';', ',']
    9 $@3: .  ['=']
   10 xdlist: xdecor . $@3 '=' init

    '='       reduce using rule 9 ($@3)
    $default  reduce using rule 8 (xdlist)

    $@3  go to state 72


state 91

    6 $@2: .  ['{']
    7 xdecl: zctlist xdecor $@1 pdecl . $@2 block
   25 pdecl: pdecl . ctlist pdlist ';'
  184 types: . complex
  185      | . tname
  186      | . gcnlist
  187      | . complex gctnlist
  188      | . tname gctnlist
  189      | . gcnlist complex zgnlist
  190      | . gcnlist tname
  191      | . gcnlist tname gctnlist
  193 ctlist: . types
  194 complex: . LSTRUCT ltag
  196        | . LSTRUCT ltag $@10 sbody
  197        | . LSTRUCT sbody
  198        | . LUNION ltag
  200        | . LUNION ltag $@11 sbody
  201        | . LUNION sbody
  202        | . LENUM ltag
  205        | . LENUM ltag $@12 '{' $@13 enum '}'
  207        | . LENUM '{' $@14 enum '}'
  208        | . LTYPE
  216 gcnlist: . gcname
  217        | . gcnlist gcname
  218 gcname: . gname
  219       | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT

    LTYPE      shift, and go to state 3
    LAUTO      shift, and go to state 4
    LCHAR      shift, and go to state 5
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LREGISTER  shift, and go to state 11
    LSHORT     shift, and go to state 12
    LSTATIC    shift, and go to state 13
    LSTRUCT    shift, and go to state 14
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNION     shift, and go to state 17
    LUNSIGNED  shift, and go to state 18
    LVOID      shift, and go to state 19
    LENUM      shift, and go to state 20
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25

    $default  reduce using rule 6 ($@2)

    $@2      go to state 136
    types    go to state 28
    ctlist   go to state 137
    complex  go to state 30
    gcnlist  go to state 31
    gcname   go to state 32
    tname    go to state 33
    cname    go to state 34
    gname    go to state 35


state 92

   10 xdlist: xdecor $@3 '=' . init
   50 init: . expr
   51     | . '{' ilist '}'
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '{'        shift, and go to state 138
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    init     go to state 139
    expr     go to state 140
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 93

  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  143      | '&' . xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    xuexpr   go to state 141
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 94

  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  144      | '+' . xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    xuexpr   go to state 142
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 95

  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  145      | '-' . xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    xuexpr   go to state 143
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 96

  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  142      | '*' . xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    xuexpr   go to state 144
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 97

  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  139       | '(' . tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  140       | '(' . tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  152      | '(' . cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  184 types: . complex
  185      | . tname
  186      | . gcnlist
  187      | . complex gctnlist
  188      | . tname gctnlist
  189      | . gcnlist complex zgnlist
  190      | . gcnlist tname
  191      | . gcnlist tname gctnlist
  192 tlist: . types
  194 complex: . LSTRUCT ltag
  196        | . LSTRUCT ltag $@10 sbody
  197        | . LSTRUCT sbody
  198        | . LUNION ltag
  200        | . LUNION ltag $@11 sbody
  201        | . LUNION sbody
  202        | . LENUM ltag
  205        | . LENUM ltag $@12 '{' $@13 enum '}'
  207        | . LENUM '{' $@14 enum '}'
  208        | . LTYPE
  216 gcnlist: . gcname
  217        | . gcnlist gcname
  218 gcname: . gname
  219       | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LTYPE      shift, and go to state 3
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LAUTO      shift, and go to state 4
    LCHAR      shift, and go to state 5
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LREGISTER  shift, and go to state 11
    LSHORT     shift, and go to state 12
    LSIZEOF    shift, and go to state 111
    LSTATIC    shift, and go to state 13
    LSTRUCT    shift, and go to state 14
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNION     shift, and go to state 17
    LUNSIGNED  shift, and go to state 18
    LVOID      shift, and go to state 19
    LENUM      shift, and go to state 20
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LSIGNOF    shift, and go to state 112
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    cexpr    go to state 145
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    types    go to state 79
    tlist    go to state 147
    complex  go to state 30
    gcnlist  go to state 31
    gcname   go to state 32
    tname    go to state 33
    cname    go to state 34
    gname    go to state 35
    name     go to state 123


state 98

  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  148      | LPP . xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    xuexpr   go to state 148
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 99

  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  149      | LMM . xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    xuexpr   go to state 149
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 100

  243 name: LNAME .

    $default  reduce using rule 243 (name)


state 101

  167 pexpr: LFCONST .

    $default  reduce using rule 167 (pexpr)


state 102

  166 pexpr: LDCONST .

    $default  reduce using rule 166 (pexpr)


state 103

  162 pexpr: LCONST .

    $default  reduce using rule 162 (pexpr)


state 104

  163 pexpr: LLCONST .

    $default  reduce using rule 163 (pexpr)


state 105

  164 pexpr: LUCONST .

    $default  reduce using rule 164 (pexpr)


state 106

  165 pexpr: LULCONST .

    $default  reduce using rule 165 (pexpr)


state 107

  168 pexpr: LVLCONST .

    $default  reduce using rule 168 (pexpr)


state 108

  169 pexpr: LUVLCONST .

    $default  reduce using rule 169 (pexpr)


state 109

  172 string: LSTRING .

    $default  reduce using rule 172 (string)


state 110

  174 lstring: LLSTRING .

    $default  reduce using rule 174 (lstring)


state 111

  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  150      | LSIZEOF . uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  153      | LSIZEOF . '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 150
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    uexpr    go to state 151
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 112

  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  151      | LSIGNOF . uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  154      | LSIGNOF . '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 152
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    uexpr    go to state 153
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 113

  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  146      | '!' . xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    xuexpr   go to state 154
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 114

  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  147      | '~' . xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    xuexpr   go to state 155
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 115

   17 xdecor2: xdecor2 '[' zexpr . ']'

    ']'  shift, and go to state 156


state 116

  103 zexpr: lexpr .

    $default  reduce using rule 103 (zexpr)


state 117

  104 lexpr: expr .  [';', ',', ']']
  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '='      shift, and go to state 157
    LORE     shift, and go to state 158
    LXORE    shift, and go to state 159
    LANDE    shift, and go to state 160
    LLSHE    shift, and go to state 161
    LRSHE    shift, and go to state 162
    LMDE     shift, and go to state 163
    LDVE     shift, and go to state 164
    LMLE     shift, and go to state 165
    LME      shift, and go to state 166
    LPE      shift, and go to state 167
    '?'      shift, and go to state 168
    LOROR    shift, and go to state 169
    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186

    $default  reduce using rule 104 (lexpr)


state 118

  107 expr: xuexpr .

    $default  reduce using rule 107 (expr)


state 119

  138 xuexpr: uexpr .

    $default  reduce using rule 138 (xuexpr)


state 120

  141 uexpr: pexpr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', '^', '&', LNE, LEQ, '<', '>', LGE, LLE, LRSH, LLSH, '+', '-', '*', '/', '%', ')', ']', '}']
  155 pexpr: pexpr . '(' zelist ')'
  156      | pexpr . '[' cexpr ']'
  157      | pexpr . LMG ltag
  158      | pexpr . '.' ltag
  159      | pexpr . LPP
  160      | pexpr . LMM

    '.'  shift, and go to state 187
    '['  shift, and go to state 188
    '('  shift, and go to state 189
    LMG  shift, and go to state 190
    LPP  shift, and go to state 191
    LMM  shift, and go to state 192

    $default  reduce using rule 141 (uexpr)


state 121

  170 pexpr: string .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', '^', '&', LNE, LEQ, '<', '>', LGE, LLE, LRSH, LLSH, '+', '-', '*', '/', '%', '.', '[', '(', LMG, LPP, LMM, ')', ']', '}']
  173 string: string . LSTRING

    LSTRING  shift, and go to state 193

    $default  reduce using rule 170 (pexpr)


state 122

  171 pexpr: lstring .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', '^', '&', LNE, LEQ, '<', '>', LGE, LLE, LRSH, LLSH, '+', '-', '*', '/', '%', '.', '[', '(', LMG, LPP, LMM, ')', ']', '}']
  175 lstring: lstring . LLSTRING

    LLSTRING  shift, and go to state 194

    $default  reduce using rule 171 (pexpr)


state 123

  161 pexpr: name .

    $default  reduce using rule 161 (pexpr)


state 124

   67 arglist: '.' . '.' '.'

    '.'  shift, and go to state 195


state 125

   16 xdecor2: xdecor2 '(' zarglist . ')'

    ')'  shift, and go to state 196


state 126

   63 zarglist: arglist .  [')']
   68 arglist: arglist . ',' arglist

    ','  shift, and go to state 197

    $default  reduce using rule 63 (zarglist)


state 127

   12 xdecor: . xdecor2
   13       | . '*' zgnlist xdecor
   14 xdecor2: . tag
   15        | . '(' xdecor ')'
   16        | . xdecor2 '(' zarglist ')'
   17        | . xdecor2 '[' zexpr ']'
   39 abdecor: .  [',', ')']
   40        | . abdecor1
   41 abdecor1: . '*' zgnlist
   42         | . '*' zgnlist abdecor1
   43         | . abdecor2
   44 abdecor2: . abdecor3
   45         | . abdecor2 '(' zarglist ')'
   46         | . abdecor2 '[' zexpr ']'
   47 abdecor3: . '(' ')'
   48         | . '[' zexpr ']'
   49         | . '(' abdecor1 ')'
   65 arglist: tlist . abdecor
   66        | tlist . xdecor
  244 tag: . ltag
  245 ltag: . LNAME
  246     | . LTYPE

    '*'    shift, and go to state 198
    '['    shift, and go to state 199
    '('    shift, and go to state 200
    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37

    $default  reduce using rule 39 (abdecor)

    xdecor    go to state 201
    xdecor2   go to state 50
    abdecor   go to state 202
    abdecor1  go to state 203
    abdecor2  go to state 204
    abdecor3  go to state 205
    tag       go to state 51
    ltag      go to state 52


state 128

   64 arglist: name .

    $default  reduce using rule 64 (arglist)


state 129

  181 sbody: '{' @9 edecl '}' .

    $default  reduce using rule 181 (sbody)


state 130

   30 $@6: .
   31 edecl: edecl tlist . $@6 zedlist ';'

    $default  reduce using rule 30 ($@6)

    $@6  go to state 206


state 131

   12 xdecor: . xdecor2
   13       | . '*' zgnlist xdecor
   14 xdecor2: . tag
   15        | . '(' xdecor ')'
   16        | . xdecor2 '(' zarglist ')'
   17        | . xdecor2 '[' zexpr ']'
   29 edecl: tlist $@5 . zedlist ';'
   32 zedlist: .  [';']
   33        | . edlist
   34 edlist: . edecor
   35       | . edlist ',' edlist
   36 edecor: . xdecor
   37       | . tag ':' lexpr
   38       | . ':' lexpr
  244 tag: . ltag
  245 ltag: . LNAME
  246     | . LTYPE

    ':'    shift, and go to state 207
    '*'    shift, and go to state 46
    '('    shift, and go to state 47
    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37

    $default  reduce using rule 32 (zedlist)

    xdecor   go to state 208
    xdecor2  go to state 50
    zedlist  go to state 209
    edlist   go to state 210
    edecor   go to state 211
    tag      go to state 212
    ltag     go to state 52


state 132

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  221 enum: LNAME '=' . expr
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 213
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 133

  220 enum: . LNAME
  221     | . LNAME '=' expr
  222     | . enum ','
  222     | enum ',' .  [',', '}']
  223     | . enum ',' enum
  223     | enum ',' . enum

    LNAME  shift, and go to state 83

    $default  reduce using rule 222 (enum)

    enum  go to state 214


state 134

  207 complex: LENUM '{' $@14 enum '}' .

    $default  reduce using rule 207 (complex)


state 135

  205 complex: LENUM ltag $@12 '{' $@13 . enum '}'
  220 enum: . LNAME
  221     | . LNAME '=' expr
  222     | . enum ','
  223     | . enum ',' enum

    LNAME  shift, and go to state 83

    enum  go to state 215


state 136

    7 xdecl: zctlist xdecor $@1 pdecl $@2 . block
   69 block: . '{' slist '}'

    '{'  shift, and go to state 216

    block  go to state 217


state 137

   12 xdecor: . xdecor2
   13       | . '*' zgnlist xdecor
   14 xdecor2: . tag
   15        | . '(' xdecor ')'
   16        | . xdecor2 '(' zarglist ')'
   17        | . xdecor2 '[' zexpr ']'
   25 pdecl: pdecl ctlist . pdlist ';'
   26 pdlist: . xdecor
   27       | . pdlist ',' pdlist
  244 tag: . ltag
  245 ltag: . LNAME
  246     | . LTYPE

    '*'    shift, and go to state 46
    '('    shift, and go to state 47
    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37

    xdecor   go to state 218
    xdecor2  go to state 50
    pdlist   go to state 219
    tag      go to state 51
    ltag     go to state 52


state 138

   50 init: . expr
   51     | . '{' ilist '}'
   51     | '{' . ilist '}'
   52 qual: . '[' lexpr ']'
   53     | . '.' ltag
   54     | . qual '='
   55 qlist: . init ','
   56      | . qlist init ','
   57      | . qual
   58      | . qlist qual
   59 ilist: . qlist
   60      | . init
   61      | . qlist init
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '.'        shift, and go to state 220
    '['        shift, and go to state 221
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '{'        shift, and go to state 138
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    init     go to state 222
    qual     go to state 223
    qlist    go to state 224
    ilist    go to state 225
    expr     go to state 140
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 139

   10 xdlist: xdecor $@3 '=' init .

    $default  reduce using rule 10 (xdlist)


state 140

   50 init: expr .  [';', ',', '}']
  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '='      shift, and go to state 157
    LORE     shift, and go to state 158
    LXORE    shift, and go to state 159
    LANDE    shift, and go to state 160
    LLSHE    shift, and go to state 161
    LRSHE    shift, and go to state 162
    LMDE     shift, and go to state 163
    LDVE     shift, and go to state 164
    LMLE     shift, and go to state 165
    LME      shift, and go to state 166
    LPE      shift, and go to state 167
    '?'      shift, and go to state 168
    LOROR    shift, and go to state 169
    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186

    $default  reduce using rule 50 (init)


state 141

  143 uexpr: '&' xuexpr .

    $default  reduce using rule 143 (uexpr)


state 142

  144 uexpr: '+' xuexpr .

    $default  reduce using rule 144 (uexpr)


state 143

  145 uexpr: '-' xuexpr .

    $default  reduce using rule 145 (uexpr)


state 144

  142 uexpr: '*' xuexpr .

    $default  reduce using rule 142 (uexpr)


state 145

  106 cexpr: cexpr . ',' cexpr
  152 pexpr: '(' cexpr . ')'

    ','  shift, and go to state 226
    ')'  shift, and go to state 227


state 146

  105 cexpr: expr .  [';', ',', ':', ')', ']']
  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '='      shift, and go to state 157
    LORE     shift, and go to state 158
    LXORE    shift, and go to state 159
    LANDE    shift, and go to state 160
    LLSHE    shift, and go to state 161
    LRSHE    shift, and go to state 162
    LMDE     shift, and go to state 163
    LDVE     shift, and go to state 164
    LMLE     shift, and go to state 165
    LME      shift, and go to state 166
    LPE      shift, and go to state 167
    '?'      shift, and go to state 168
    LOROR    shift, and go to state 169
    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186

    $default  reduce using rule 105 (cexpr)


state 147

   39 abdecor: .  [')']
   40        | . abdecor1
   41 abdecor1: . '*' zgnlist
   42         | . '*' zgnlist abdecor1
   43         | . abdecor2
   44 abdecor2: . abdecor3
   45         | . abdecor2 '(' zarglist ')'
   46         | . abdecor2 '[' zexpr ']'
   47 abdecor3: . '(' ')'
   48         | . '[' zexpr ']'
   49         | . '(' abdecor1 ')'
  139 xuexpr: '(' tlist . abdecor ')' xuexpr
  140       | '(' tlist . abdecor ')' '{' ilist '}'

    '*'  shift, and go to state 228
    '['  shift, and go to state 199
    '('  shift, and go to state 229

    $default  reduce using rule 39 (abdecor)

    abdecor   go to state 230
    abdecor1  go to state 203
    abdecor2  go to state 204
    abdecor3  go to state 205


state 148

  148 uexpr: LPP xuexpr .

    $default  reduce using rule 148 (uexpr)


state 149

  149 uexpr: LMM xuexpr .

    $default  reduce using rule 149 (uexpr)


state 150

  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  152      | '(' . cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  153      | LSIZEOF '(' . tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  184 types: . complex
  185      | . tname
  186      | . gcnlist
  187      | . complex gctnlist
  188      | . tname gctnlist
  189      | . gcnlist complex zgnlist
  190      | . gcnlist tname
  191      | . gcnlist tname gctnlist
  192 tlist: . types
  194 complex: . LSTRUCT ltag
  196        | . LSTRUCT ltag $@10 sbody
  197        | . LSTRUCT sbody
  198        | . LUNION ltag
  200        | . LUNION ltag $@11 sbody
  201        | . LUNION sbody
  202        | . LENUM ltag
  205        | . LENUM ltag $@12 '{' $@13 enum '}'
  207        | . LENUM '{' $@14 enum '}'
  208        | . LTYPE
  216 gcnlist: . gcname
  217        | . gcnlist gcname
  218 gcname: . gname
  219       | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LTYPE      shift, and go to state 3
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LAUTO      shift, and go to state 4
    LCHAR      shift, and go to state 5
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LREGISTER  shift, and go to state 11
    LSHORT     shift, and go to state 12
    LSIZEOF    shift, and go to state 111
    LSTATIC    shift, and go to state 13
    LSTRUCT    shift, and go to state 14
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNION     shift, and go to state 17
    LUNSIGNED  shift, and go to state 18
    LVOID      shift, and go to state 19
    LENUM      shift, and go to state 20
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LSIGNOF    shift, and go to state 112
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    cexpr    go to state 145
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    types    go to state 79
    tlist    go to state 231
    complex  go to state 30
    gcnlist  go to state 31
    gcname   go to state 32
    tname    go to state 33
    cname    go to state 34
    gname    go to state 35
    name     go to state 123


state 151

  150 uexpr: LSIZEOF uexpr .

    $default  reduce using rule 150 (uexpr)


state 152

  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  152      | '(' . cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  154      | LSIGNOF '(' . tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  184 types: . complex
  185      | . tname
  186      | . gcnlist
  187      | . complex gctnlist
  188      | . tname gctnlist
  189      | . gcnlist complex zgnlist
  190      | . gcnlist tname
  191      | . gcnlist tname gctnlist
  192 tlist: . types
  194 complex: . LSTRUCT ltag
  196        | . LSTRUCT ltag $@10 sbody
  197        | . LSTRUCT sbody
  198        | . LUNION ltag
  200        | . LUNION ltag $@11 sbody
  201        | . LUNION sbody
  202        | . LENUM ltag
  205        | . LENUM ltag $@12 '{' $@13 enum '}'
  207        | . LENUM '{' $@14 enum '}'
  208        | . LTYPE
  216 gcnlist: . gcname
  217        | . gcnlist gcname
  218 gcname: . gname
  219       | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LTYPE      shift, and go to state 3
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LAUTO      shift, and go to state 4
    LCHAR      shift, and go to state 5
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LREGISTER  shift, and go to state 11
    LSHORT     shift, and go to state 12
    LSIZEOF    shift, and go to state 111
    LSTATIC    shift, and go to state 13
    LSTRUCT    shift, and go to state 14
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNION     shift, and go to state 17
    LUNSIGNED  shift, and go to state 18
    LVOID      shift, and go to state 19
    LENUM      shift, and go to state 20
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LSIGNOF    shift, and go to state 112
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    cexpr    go to state 145
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    types    go to state 79
    tlist    go to state 232
    complex  go to state 30
    gcnlist  go to state 31
    gcname   go to state 32
    tname    go to state 33
    cname    go to state 34
    gname    go to state 35
    name     go to state 123


state 153

  151 uexpr: LSIGNOF uexpr .

    $default  reduce using rule 151 (uexpr)


state 154

  146 uexpr: '!' xuexpr .

    $default  reduce using rule 146 (uexpr)


state 155

  147 uexpr: '~' xuexpr .

    $default  reduce using rule 147 (uexpr)


state 156

   17 xdecor2: xdecor2 '[' zexpr ']' .

    $default  reduce using rule 17 (xdecor2)


state 157

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  127     | expr '=' . expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 233
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 158

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  137     | expr LORE . expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 234
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 159

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  136     | expr LXORE . expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 235
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 160

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  135     | expr LANDE . expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 236
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 161

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  133     | expr LLSHE . expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 237
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 162

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  134     | expr LRSHE . expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 238
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 163

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  132     | expr LMDE . expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 239
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 164

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  131     | expr LDVE . expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 240
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 165

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  130     | expr LMLE . expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 241
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 166

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  129     | expr LME . expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 242
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 167

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  128     | expr LPE . expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 243
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 168

  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  126     | expr '?' . cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    cexpr    go to state 244
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 169

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  125     | expr LOROR . expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 245
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 170

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  124     | expr LANDAND . expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 246
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 171

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  123     | expr '|' . expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 247
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 172

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  122     | expr '^' . expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 248
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 173

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  121     | expr '&' . expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 249
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 174

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  120     | expr LNE . expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 250
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 175

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  119     | expr LEQ . expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 251
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 176

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  115     | expr '<' . expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 252
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 177

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  116     | expr '>' . expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 253
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 178

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  118     | expr LGE . expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 254
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 179

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  117     | expr LLE . expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 255
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 180

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  113     | expr LRSH . expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 256
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 181

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  114     | expr LLSH . expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 257
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 182

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  111     | expr '+' . expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 258
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 183

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  112     | expr '-' . expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 259
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 184

  107 expr: . xuexpr
  108     | . expr '*' expr
  108     | expr '*' . expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 260
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 185

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  109     | expr '/' . expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 261
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 186

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  110     | expr '%' . expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 262
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 187

  158 pexpr: pexpr '.' . ltag
  245 ltag: . LNAME
  246     | . LTYPE

    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37

    ltag  go to state 263


state 188

  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  156      | pexpr '[' . cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    cexpr    go to state 264
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 189

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  155      | pexpr '(' . zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  176 zelist: .  [')']
  177       | . elist
  178 elist: . expr
  179      | . elist ',' elist
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    $default  reduce using rule 176 (zelist)

    expr     go to state 265
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    zelist   go to state 266
    elist    go to state 267
    name     go to state 123


state 190

  157 pexpr: pexpr LMG . ltag
  245 ltag: . LNAME
  246     | . LTYPE

    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37

    ltag  go to state 268


state 191

  159 pexpr: pexpr LPP .

    $default  reduce using rule 159 (pexpr)


state 192

  160 pexpr: pexpr LMM .

    $default  reduce using rule 160 (pexpr)


state 193

  173 string: string LSTRING .

    $default  reduce using rule 173 (string)


state 194

  175 lstring: lstring LLSTRING .

    $default  reduce using rule 175 (lstring)


state 195

   67 arglist: '.' '.' . '.'

    '.'  shift, and go to state 269


state 196

   16 xdecor2: xdecor2 '(' zarglist ')' .

    $default  reduce using rule 16 (xdecor2)


state 197

   64 arglist: . name
   65        | . tlist abdecor
   66        | . tlist xdecor
   67        | . '.' '.' '.'
   68        | . arglist ',' arglist
   68        | arglist ',' . arglist
  184 types: . complex
  185      | . tname
  186      | . gcnlist
  187      | . complex gctnlist
  188      | . tname gctnlist
  189      | . gcnlist complex zgnlist
  190      | . gcnlist tname
  191      | . gcnlist tname gctnlist
  192 tlist: . types
  194 complex: . LSTRUCT ltag
  196        | . LSTRUCT ltag $@10 sbody
  197        | . LSTRUCT sbody
  198        | . LUNION ltag
  200        | . LUNION ltag $@11 sbody
  201        | . LUNION sbody
  202        | . LENUM ltag
  205        | . LENUM ltag $@12 '{' $@13 enum '}'
  207        | . LENUM '{' $@14 enum '}'
  208        | . LTYPE
  216 gcnlist: . gcname
  217        | . gcnlist gcname
  218 gcname: . gname
  219       | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT
  243 name: . LNAME

    '.'        shift, and go to state 124
    LNAME      shift, and go to state 100
    LTYPE      shift, and go to state 3
    LAUTO      shift, and go to state 4
    LCHAR      shift, and go to state 5
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LREGISTER  shift, and go to state 11
    LSHORT     shift, and go to state 12
    LSTATIC    shift, and go to state 13
    LSTRUCT    shift, and go to state 14
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNION     shift, and go to state 17
    LUNSIGNED  shift, and go to state 18
    LVOID      shift, and go to state 19
    LENUM      shift, and go to state 20
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25

    arglist  go to state 270
    types    go to state 79
    tlist    go to state 127
    complex  go to state 30
    gcnlist  go to state 31
    gcname   go to state 32
    tname    go to state 33
    cname    go to state 34
    gname    go to state 35
    name     go to state 128


state 198

   13 xdecor: '*' . zgnlist xdecor
   41 abdecor1: '*' . zgnlist
   42         | '*' . zgnlist abdecor1
  211 zgnlist: .
  212        | . zgnlist gname

    $default  reduce using rule 211 (zgnlist)

    zgnlist  go to state 271


state 199

   48 abdecor3: '[' . zexpr ']'
  102 zexpr: .  [']']
  103      | . lexpr
  104 lexpr: . expr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    $default  reduce using rule 102 (zexpr)

    zexpr    go to state 272
    lexpr    go to state 116
    expr     go to state 117
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 200

   12 xdecor: . xdecor2
   13       | . '*' zgnlist xdecor
   14 xdecor2: . tag
   15        | . '(' xdecor ')'
   15        | '(' . xdecor ')'
   16        | . xdecor2 '(' zarglist ')'
   17        | . xdecor2 '[' zexpr ']'
   41 abdecor1: . '*' zgnlist
   42         | . '*' zgnlist abdecor1
   43         | . abdecor2
   44 abdecor2: . abdecor3
   45         | . abdecor2 '(' zarglist ')'
   46         | . abdecor2 '[' zexpr ']'
   47 abdecor3: . '(' ')'
   47         | '(' . ')'
   48         | . '[' zexpr ']'
   49         | . '(' abdecor1 ')'
   49         | '(' . abdecor1 ')'
  244 tag: . ltag
  245 ltag: . LNAME
  246     | . LTYPE

    '*'    shift, and go to state 198
    '['    shift, and go to state 199
    '('    shift, and go to state 200
    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37
    ')'    shift, and go to state 273

    xdecor    go to state 68
    xdecor2   go to state 50
    abdecor1  go to state 274
    abdecor2  go to state 204
    abdecor3  go to state 205
    tag       go to state 51
    ltag      go to state 52


state 201

   66 arglist: tlist xdecor .

    $default  reduce using rule 66 (arglist)


state 202

   65 arglist: tlist abdecor .

    $default  reduce using rule 65 (arglist)


state 203

   40 abdecor: abdecor1 .

    $default  reduce using rule 40 (abdecor)


state 204

   43 abdecor1: abdecor2 .  [',', ')']
   45 abdecor2: abdecor2 . '(' zarglist ')'
   46         | abdecor2 . '[' zexpr ']'

    '['  shift, and go to state 275
    '('  shift, and go to state 276

    $default  reduce using rule 43 (abdecor1)


state 205

   44 abdecor2: abdecor3 .

    $default  reduce using rule 44 (abdecor2)


state 206

   12 xdecor: . xdecor2
   13       | . '*' zgnlist xdecor
   14 xdecor2: . tag
   15        | . '(' xdecor ')'
   16        | . xdecor2 '(' zarglist ')'
   17        | . xdecor2 '[' zexpr ']'
   31 edecl: edecl tlist $@6 . zedlist ';'
   32 zedlist: .  [';']
   33        | . edlist
   34 edlist: . edecor
   35       | . edlist ',' edlist
   36 edecor: . xdecor
   37       | . tag ':' lexpr
   38       | . ':' lexpr
  244 tag: . ltag
  245 ltag: . LNAME
  246     | . LTYPE

    ':'    shift, and go to state 207
    '*'    shift, and go to state 46
    '('    shift, and go to state 47
    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37

    $default  reduce using rule 32 (zedlist)

    xdecor   go to state 208
    xdecor2  go to state 50
    zedlist  go to state 277
    edlist   go to state 210
    edecor   go to state 211
    tag      go to state 212
    ltag     go to state 52


state 207

   38 edecor: ':' . lexpr
  104 lexpr: . expr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    lexpr    go to state 278
    expr     go to state 117
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 208

   36 edecor: xdecor .

    $default  reduce using rule 36 (edecor)


state 209

   29 edecl: tlist $@5 zedlist . ';'

    ';'  shift, and go to state 279


state 210

   33 zedlist: edlist .  [';']
   35 edlist: edlist . ',' edlist

    ','  shift, and go to state 280

    $default  reduce using rule 33 (zedlist)


state 211

   34 edlist: edecor .

    $default  reduce using rule 34 (edlist)


state 212

   14 xdecor2: tag .  [';', ',', '[', '(']
   37 edecor: tag . ':' lexpr

    ':'  shift, and go to state 281

    $default  reduce using rule 14 (xdecor2)


state 213

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr
  221 enum: LNAME '=' expr .  [',', '}']

    '='      shift, and go to state 157
    LORE     shift, and go to state 158
    LXORE    shift, and go to state 159
    LANDE    shift, and go to state 160
    LLSHE    shift, and go to state 161
    LRSHE    shift, and go to state 162
    LMDE     shift, and go to state 163
    LDVE     shift, and go to state 164
    LMLE     shift, and go to state 165
    LME      shift, and go to state 166
    LPE      shift, and go to state 167
    '?'      shift, and go to state 168
    LOROR    shift, and go to state 169
    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186

    $default  reduce using rule 221 (enum)


state 214

  222 enum: enum . ','
  223     | enum . ',' enum
  223     | enum ',' enum .  [',', '}']

    $default  reduce using rule 223 (enum)

    Conflict between rule 223 and token ',' resolved as reduce (%left ',').


state 215

  205 complex: LENUM ltag $@12 '{' $@13 enum . '}'
  222 enum: enum . ','
  223     | enum . ',' enum

    ','  shift, and go to state 133
    '}'  shift, and go to state 282


state 216

   69 block: '{' . slist '}'
   70 slist: .
   71      | . slist adecl
   72      | . slist stmnt

    $default  reduce using rule 70 (slist)

    slist  go to state 283


state 217

    7 xdecl: zctlist xdecor $@1 pdecl $@2 block .

    $default  reduce using rule 7 (xdecl)


state 218

   26 pdlist: xdecor .

    $default  reduce using rule 26 (pdlist)


state 219

   25 pdecl: pdecl ctlist pdlist . ';'
   27 pdlist: pdlist . ',' pdlist

    ';'  shift, and go to state 284
    ','  shift, and go to state 285


state 220

   53 qual: '.' . ltag
  245 ltag: . LNAME
  246     | . LTYPE

    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37

    ltag  go to state 286


state 221

   52 qual: '[' . lexpr ']'
  104 lexpr: . expr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    lexpr    go to state 287
    expr     go to state 117
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 222

   55 qlist: init . ','
   60 ilist: init .  ['}']

    ','  shift, and go to state 288

    $default  reduce using rule 60 (ilist)


state 223

   54 qual: qual . '='
   57 qlist: qual .  ['&', '+', '-', '*', '.', '[', '(', LPP, LMM, LNAME, LFCONST, LDCONST, LCONST, LLCONST, LUCONST, LULCONST, LVLCONST, LUVLCONST, LSTRING, LLSTRING, LSIZEOF, LSIGNOF, '{', '}', '!', '~']

    '='  shift, and go to state 289

    $default  reduce using rule 57 (qlist)


state 224

   50 init: . expr
   51     | . '{' ilist '}'
   52 qual: . '[' lexpr ']'
   53     | . '.' ltag
   54     | . qual '='
   56 qlist: qlist . init ','
   58      | qlist . qual
   59 ilist: qlist .  ['}']
   61      | qlist . init
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '.'        shift, and go to state 220
    '['        shift, and go to state 221
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '{'        shift, and go to state 138
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    $default  reduce using rule 59 (ilist)

    init     go to state 290
    qual     go to state 291
    expr     go to state 140
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 225

   51 init: '{' ilist . '}'

    '}'  shift, and go to state 292


state 226

  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  106      | cexpr ',' . cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    cexpr    go to state 293
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 227

  152 pexpr: '(' cexpr ')' .

    $default  reduce using rule 152 (pexpr)


state 228

   41 abdecor1: '*' . zgnlist
   42         | '*' . zgnlist abdecor1
  211 zgnlist: .
  212        | . zgnlist gname

    $default  reduce using rule 211 (zgnlist)

    zgnlist  go to state 294


state 229

   41 abdecor1: . '*' zgnlist
   42         | . '*' zgnlist abdecor1
   43         | . abdecor2
   44 abdecor2: . abdecor3
   45         | . abdecor2 '(' zarglist ')'
   46         | . abdecor2 '[' zexpr ']'
   47 abdecor3: . '(' ')'
   47         | '(' . ')'
   48         | . '[' zexpr ']'
   49         | . '(' abdecor1 ')'
   49         | '(' . abdecor1 ')'

    '*'  shift, and go to state 228
    '['  shift, and go to state 199
    '('  shift, and go to state 229
    ')'  shift, and go to state 273

    abdecor1  go to state 274
    abdecor2  go to state 204
    abdecor3  go to state 205


state 230

  139 xuexpr: '(' tlist abdecor . ')' xuexpr
  140       | '(' tlist abdecor . ')' '{' ilist '}'

    ')'  shift, and go to state 295


state 231

   39 abdecor: .  [')']
   40        | . abdecor1
   41 abdecor1: . '*' zgnlist
   42         | . '*' zgnlist abdecor1
   43         | . abdecor2
   44 abdecor2: . abdecor3
   45         | . abdecor2 '(' zarglist ')'
   46         | . abdecor2 '[' zexpr ']'
   47 abdecor3: . '(' ')'
   48         | . '[' zexpr ']'
   49         | . '(' abdecor1 ')'
  153 pexpr: LSIZEOF '(' tlist . abdecor ')'

    '*'  shift, and go to state 228
    '['  shift, and go to state 199
    '('  shift, and go to state 229

    $default  reduce using rule 39 (abdecor)

    abdecor   go to state 296
    abdecor1  go to state 203
    abdecor2  go to state 204
    abdecor3  go to state 205


state 232

   39 abdecor: .  [')']
   40        | . abdecor1
   41 abdecor1: . '*' zgnlist
   42         | . '*' zgnlist abdecor1
   43         | . abdecor2
   44 abdecor2: . abdecor3
   45         | . abdecor2 '(' zarglist ')'
   46         | . abdecor2 '[' zexpr ']'
   47 abdecor3: . '(' ')'
   48         | . '[' zexpr ']'
   49         | . '(' abdecor1 ')'
  154 pexpr: LSIGNOF '(' tlist . abdecor ')'

    '*'  shift, and go to state 228
    '['  shift, and go to state 199
    '('  shift, and go to state 229

    $default  reduce using rule 39 (abdecor)

    abdecor   go to state 297
    abdecor1  go to state 203
    abdecor2  go to state 204
    abdecor3  go to state 205


state 233

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  127     | expr '=' expr .  [';', ',', ':', ')', ']', '}']
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '='      shift, and go to state 157
    LORE     shift, and go to state 158
    LXORE    shift, and go to state 159
    LANDE    shift, and go to state 160
    LLSHE    shift, and go to state 161
    LRSHE    shift, and go to state 162
    LMDE     shift, and go to state 163
    LDVE     shift, and go to state 164
    LMLE     shift, and go to state 165
    LME      shift, and go to state 166
    LPE      shift, and go to state 167
    '?'      shift, and go to state 168
    LOROR    shift, and go to state 169
    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186

    $default  reduce using rule 127 (expr)

    Conflict between rule 127 and token '=' resolved as shift (%right '=').
    Conflict between rule 127 and token LORE resolved as shift (%right LORE).
    Conflict between rule 127 and token LXORE resolved as shift (%right LXORE).
    Conflict between rule 127 and token LANDE resolved as shift (%right LANDE).
    Conflict between rule 127 and token LLSHE resolved as shift (%right LLSHE).
    Conflict between rule 127 and token LRSHE resolved as shift (%right LRSHE).
    Conflict between rule 127 and token LMDE resolved as shift (%right LMDE).
    Conflict between rule 127 and token LDVE resolved as shift (%right LDVE).
    Conflict between rule 127 and token LMLE resolved as shift (%right LMLE).
    Conflict between rule 127 and token LME resolved as shift (%right LME).
    Conflict between rule 127 and token LPE resolved as shift (%right LPE).
    Conflict between rule 127 and token '?' resolved as shift ('=' < '?').
    Conflict between rule 127 and token LOROR resolved as shift ('=' < LOROR).
    Conflict between rule 127 and token LANDAND resolved as shift ('=' < LANDAND).
    Conflict between rule 127 and token '|' resolved as shift ('=' < '|').
    Conflict between rule 127 and token '^' resolved as shift ('=' < '^').
    Conflict between rule 127 and token '&' resolved as shift ('=' < '&').
    Conflict between rule 127 and token LNE resolved as shift ('=' < LNE).
    Conflict between rule 127 and token LEQ resolved as shift ('=' < LEQ).
    Conflict between rule 127 and token '<' resolved as shift ('=' < '<').
    Conflict between rule 127 and token '>' resolved as shift ('=' < '>').
    Conflict between rule 127 and token LGE resolved as shift ('=' < LGE).
    Conflict between rule 127 and token LLE resolved as shift ('=' < LLE).
    Conflict between rule 127 and token LRSH resolved as shift ('=' < LRSH).
    Conflict between rule 127 and token LLSH resolved as shift ('=' < LLSH).
    Conflict between rule 127 and token '+' resolved as shift ('=' < '+').
    Conflict between rule 127 and token '-' resolved as shift ('=' < '-').
    Conflict between rule 127 and token '*' resolved as shift ('=' < '*').
    Conflict between rule 127 and token '/' resolved as shift ('=' < '/').
    Conflict between rule 127 and token '%' resolved as shift ('=' < '%').


state 234

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr
  137     | expr LORE expr .  [';', ',', ':', ')', ']', '}']

    '='      shift, and go to state 157
    LORE     shift, and go to state 158
    LXORE    shift, and go to state 159
    LANDE    shift, and go to state 160
    LLSHE    shift, and go to state 161
    LRSHE    shift, and go to state 162
    LMDE     shift, and go to state 163
    LDVE     shift, and go to state 164
    LMLE     shift, and go to state 165
    LME      shift, and go to state 166
    LPE      shift, and go to state 167
    '?'      shift, and go to state 168
    LOROR    shift, and go to state 169
    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186

    $default  reduce using rule 137 (expr)

    Conflict between rule 137 and token '=' resolved as shift (%right '=').
    Conflict between rule 137 and token LORE resolved as shift (%right LORE).
    Conflict between rule 137 and token LXORE resolved as shift (%right LXORE).
    Conflict between rule 137 and token LANDE resolved as shift (%right LANDE).
    Conflict between rule 137 and token LLSHE resolved as shift (%right LLSHE).
    Conflict between rule 137 and token LRSHE resolved as shift (%right LRSHE).
    Conflict between rule 137 and token LMDE resolved as shift (%right LMDE).
    Conflict between rule 137 and token LDVE resolved as shift (%right LDVE).
    Conflict between rule 137 and token LMLE resolved as shift (%right LMLE).
    Conflict between rule 137 and token LME resolved as shift (%right LME).
    Conflict between rule 137 and token LPE resolved as shift (%right LPE).
    Conflict between rule 137 and token '?' resolved as shift (LORE < '?').
    Conflict between rule 137 and token LOROR resolved as shift (LORE < LOROR).
    Conflict between rule 137 and token LANDAND resolved as shift (LORE < LANDAND).
    Conflict between rule 137 and token '|' resolved as shift (LORE < '|').
    Conflict between rule 137 and token '^' resolved as shift (LORE < '^').
    Conflict between rule 137 and token '&' resolved as shift (LORE < '&').
    Conflict between rule 137 and token LNE resolved as shift (LORE < LNE).
    Conflict between rule 137 and token LEQ resolved as shift (LORE < LEQ).
    Conflict between rule 137 and token '<' resolved as shift (LORE < '<').
    Conflict between rule 137 and token '>' resolved as shift (LORE < '>').
    Conflict between rule 137 and token LGE resolved as shift (LORE < LGE).
    Conflict between rule 137 and token LLE resolved as shift (LORE < LLE).
    Conflict between rule 137 and token LRSH resolved as shift (LORE < LRSH).
    Conflict between rule 137 and token LLSH resolved as shift (LORE < LLSH).
    Conflict between rule 137 and token '+' resolved as shift (LORE < '+').
    Conflict between rule 137 and token '-' resolved as shift (LORE < '-').
    Conflict between rule 137 and token '*' resolved as shift (LORE < '*').
    Conflict between rule 137 and token '/' resolved as shift (LORE < '/').
    Conflict between rule 137 and token '%' resolved as shift (LORE < '%').


state 235

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  136     | expr LXORE expr .  [';', ',', ':', ')', ']', '}']
  137     | expr . LORE expr

    '='      shift, and go to state 157
    LORE     shift, and go to state 158
    LXORE    shift, and go to state 159
    LANDE    shift, and go to state 160
    LLSHE    shift, and go to state 161
    LRSHE    shift, and go to state 162
    LMDE     shift, and go to state 163
    LDVE     shift, and go to state 164
    LMLE     shift, and go to state 165
    LME      shift, and go to state 166
    LPE      shift, and go to state 167
    '?'      shift, and go to state 168
    LOROR    shift, and go to state 169
    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186

    $default  reduce using rule 136 (expr)

    Conflict between rule 136 and token '=' resolved as shift (%right '=').
    Conflict between rule 136 and token LORE resolved as shift (%right LORE).
    Conflict between rule 136 and token LXORE resolved as shift (%right LXORE).
    Conflict between rule 136 and token LANDE resolved as shift (%right LANDE).
    Conflict between rule 136 and token LLSHE resolved as shift (%right LLSHE).
    Conflict between rule 136 and token LRSHE resolved as shift (%right LRSHE).
    Conflict between rule 136 and token LMDE resolved as shift (%right LMDE).
    Conflict between rule 136 and token LDVE resolved as shift (%right LDVE).
    Conflict between rule 136 and token LMLE resolved as shift (%right LMLE).
    Conflict between rule 136 and token LME resolved as shift (%right LME).
    Conflict between rule 136 and token LPE resolved as shift (%right LPE).
    Conflict between rule 136 and token '?' resolved as shift (LXORE < '?').
    Conflict between rule 136 and token LOROR resolved as shift (LXORE < LOROR).
    Conflict between rule 136 and token LANDAND resolved as shift (LXORE < LANDAND).
    Conflict between rule 136 and token '|' resolved as shift (LXORE < '|').
    Conflict between rule 136 and token '^' resolved as shift (LXORE < '^').
    Conflict between rule 136 and token '&' resolved as shift (LXORE < '&').
    Conflict between rule 136 and token LNE resolved as shift (LXORE < LNE).
    Conflict between rule 136 and token LEQ resolved as shift (LXORE < LEQ).
    Conflict between rule 136 and token '<' resolved as shift (LXORE < '<').
    Conflict between rule 136 and token '>' resolved as shift (LXORE < '>').
    Conflict between rule 136 and token LGE resolved as shift (LXORE < LGE).
    Conflict between rule 136 and token LLE resolved as shift (LXORE < LLE).
    Conflict between rule 136 and token LRSH resolved as shift (LXORE < LRSH).
    Conflict between rule 136 and token LLSH resolved as shift (LXORE < LLSH).
    Conflict between rule 136 and token '+' resolved as shift (LXORE < '+').
    Conflict between rule 136 and token '-' resolved as shift (LXORE < '-').
    Conflict between rule 136 and token '*' resolved as shift (LXORE < '*').
    Conflict between rule 136 and token '/' resolved as shift (LXORE < '/').
    Conflict between rule 136 and token '%' resolved as shift (LXORE < '%').


state 236

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  135     | expr LANDE expr .  [';', ',', ':', ')', ']', '}']
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '='      shift, and go to state 157
    LORE     shift, and go to state 158
    LXORE    shift, and go to state 159
    LANDE    shift, and go to state 160
    LLSHE    shift, and go to state 161
    LRSHE    shift, and go to state 162
    LMDE     shift, and go to state 163
    LDVE     shift, and go to state 164
    LMLE     shift, and go to state 165
    LME      shift, and go to state 166
    LPE      shift, and go to state 167
    '?'      shift, and go to state 168
    LOROR    shift, and go to state 169
    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186

    $default  reduce using rule 135 (expr)

    Conflict between rule 135 and token '=' resolved as shift (%right '=').
    Conflict between rule 135 and token LORE resolved as shift (%right LORE).
    Conflict between rule 135 and token LXORE resolved as shift (%right LXORE).
    Conflict between rule 135 and token LANDE resolved as shift (%right LANDE).
    Conflict between rule 135 and token LLSHE resolved as shift (%right LLSHE).
    Conflict between rule 135 and token LRSHE resolved as shift (%right LRSHE).
    Conflict between rule 135 and token LMDE resolved as shift (%right LMDE).
    Conflict between rule 135 and token LDVE resolved as shift (%right LDVE).
    Conflict between rule 135 and token LMLE resolved as shift (%right LMLE).
    Conflict between rule 135 and token LME resolved as shift (%right LME).
    Conflict between rule 135 and token LPE resolved as shift (%right LPE).
    Conflict between rule 135 and token '?' resolved as shift (LANDE < '?').
    Conflict between rule 135 and token LOROR resolved as shift (LANDE < LOROR).
    Conflict between rule 135 and token LANDAND resolved as shift (LANDE < LANDAND).
    Conflict between rule 135 and token '|' resolved as shift (LANDE < '|').
    Conflict between rule 135 and token '^' resolved as shift (LANDE < '^').
    Conflict between rule 135 and token '&' resolved as shift (LANDE < '&').
    Conflict between rule 135 and token LNE resolved as shift (LANDE < LNE).
    Conflict between rule 135 and token LEQ resolved as shift (LANDE < LEQ).
    Conflict between rule 135 and token '<' resolved as shift (LANDE < '<').
    Conflict between rule 135 and token '>' resolved as shift (LANDE < '>').
    Conflict between rule 135 and token LGE resolved as shift (LANDE < LGE).
    Conflict between rule 135 and token LLE resolved as shift (LANDE < LLE).
    Conflict between rule 135 and token LRSH resolved as shift (LANDE < LRSH).
    Conflict between rule 135 and token LLSH resolved as shift (LANDE < LLSH).
    Conflict between rule 135 and token '+' resolved as shift (LANDE < '+').
    Conflict between rule 135 and token '-' resolved as shift (LANDE < '-').
    Conflict between rule 135 and token '*' resolved as shift (LANDE < '*').
    Conflict between rule 135 and token '/' resolved as shift (LANDE < '/').
    Conflict between rule 135 and token '%' resolved as shift (LANDE < '%').


state 237

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  133     | expr LLSHE expr .  [';', ',', ':', ')', ']', '}']
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '='      shift, and go to state 157
    LORE     shift, and go to state 158
    LXORE    shift, and go to state 159
    LANDE    shift, and go to state 160
    LLSHE    shift, and go to state 161
    LRSHE    shift, and go to state 162
    LMDE     shift, and go to state 163
    LDVE     shift, and go to state 164
    LMLE     shift, and go to state 165
    LME      shift, and go to state 166
    LPE      shift, and go to state 167
    '?'      shift, and go to state 168
    LOROR    shift, and go to state 169
    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186

    $default  reduce using rule 133 (expr)

    Conflict between rule 133 and token '=' resolved as shift (%right '=').
    Conflict between rule 133 and token LORE resolved as shift (%right LORE).
    Conflict between rule 133 and token LXORE resolved as shift (%right LXORE).
    Conflict between rule 133 and token LANDE resolved as shift (%right LANDE).
    Conflict between rule 133 and token LLSHE resolved as shift (%right LLSHE).
    Conflict between rule 133 and token LRSHE resolved as shift (%right LRSHE).
    Conflict between rule 133 and token LMDE resolved as shift (%right LMDE).
    Conflict between rule 133 and token LDVE resolved as shift (%right LDVE).
    Conflict between rule 133 and token LMLE resolved as shift (%right LMLE).
    Conflict between rule 133 and token LME resolved as shift (%right LME).
    Conflict between rule 133 and token LPE resolved as shift (%right LPE).
    Conflict between rule 133 and token '?' resolved as shift (LLSHE < '?').
    Conflict between rule 133 and token LOROR resolved as shift (LLSHE < LOROR).
    Conflict between rule 133 and token LANDAND resolved as shift (LLSHE < LANDAND).
    Conflict between rule 133 and token '|' resolved as shift (LLSHE < '|').
    Conflict between rule 133 and token '^' resolved as shift (LLSHE < '^').
    Conflict between rule 133 and token '&' resolved as shift (LLSHE < '&').
    Conflict between rule 133 and token LNE resolved as shift (LLSHE < LNE).
    Conflict between rule 133 and token LEQ resolved as shift (LLSHE < LEQ).
    Conflict between rule 133 and token '<' resolved as shift (LLSHE < '<').
    Conflict between rule 133 and token '>' resolved as shift (LLSHE < '>').
    Conflict between rule 133 and token LGE resolved as shift (LLSHE < LGE).
    Conflict between rule 133 and token LLE resolved as shift (LLSHE < LLE).
    Conflict between rule 133 and token LRSH resolved as shift (LLSHE < LRSH).
    Conflict between rule 133 and token LLSH resolved as shift (LLSHE < LLSH).
    Conflict between rule 133 and token '+' resolved as shift (LLSHE < '+').
    Conflict between rule 133 and token '-' resolved as shift (LLSHE < '-').
    Conflict between rule 133 and token '*' resolved as shift (LLSHE < '*').
    Conflict between rule 133 and token '/' resolved as shift (LLSHE < '/').
    Conflict between rule 133 and token '%' resolved as shift (LLSHE < '%').


state 238

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  134     | expr LRSHE expr .  [';', ',', ':', ')', ']', '}']
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '='      shift, and go to state 157
    LORE     shift, and go to state 158
    LXORE    shift, and go to state 159
    LANDE    shift, and go to state 160
    LLSHE    shift, and go to state 161
    LRSHE    shift, and go to state 162
    LMDE     shift, and go to state 163
    LDVE     shift, and go to state 164
    LMLE     shift, and go to state 165
    LME      shift, and go to state 166
    LPE      shift, and go to state 167
    '?'      shift, and go to state 168
    LOROR    shift, and go to state 169
    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186

    $default  reduce using rule 134 (expr)

    Conflict between rule 134 and token '=' resolved as shift (%right '=').
    Conflict between rule 134 and token LORE resolved as shift (%right LORE).
    Conflict between rule 134 and token LXORE resolved as shift (%right LXORE).
    Conflict between rule 134 and token LANDE resolved as shift (%right LANDE).
    Conflict between rule 134 and token LLSHE resolved as shift (%right LLSHE).
    Conflict between rule 134 and token LRSHE resolved as shift (%right LRSHE).
    Conflict between rule 134 and token LMDE resolved as shift (%right LMDE).
    Conflict between rule 134 and token LDVE resolved as shift (%right LDVE).
    Conflict between rule 134 and token LMLE resolved as shift (%right LMLE).
    Conflict between rule 134 and token LME resolved as shift (%right LME).
    Conflict between rule 134 and token LPE resolved as shift (%right LPE).
    Conflict between rule 134 and token '?' resolved as shift (LRSHE < '?').
    Conflict between rule 134 and token LOROR resolved as shift (LRSHE < LOROR).
    Conflict between rule 134 and token LANDAND resolved as shift (LRSHE < LANDAND).
    Conflict between rule 134 and token '|' resolved as shift (LRSHE < '|').
    Conflict between rule 134 and token '^' resolved as shift (LRSHE < '^').
    Conflict between rule 134 and token '&' resolved as shift (LRSHE < '&').
    Conflict between rule 134 and token LNE resolved as shift (LRSHE < LNE).
    Conflict between rule 134 and token LEQ resolved as shift (LRSHE < LEQ).
    Conflict between rule 134 and token '<' resolved as shift (LRSHE < '<').
    Conflict between rule 134 and token '>' resolved as shift (LRSHE < '>').
    Conflict between rule 134 and token LGE resolved as shift (LRSHE < LGE).
    Conflict between rule 134 and token LLE resolved as shift (LRSHE < LLE).
    Conflict between rule 134 and token LRSH resolved as shift (LRSHE < LRSH).
    Conflict between rule 134 and token LLSH resolved as shift (LRSHE < LLSH).
    Conflict between rule 134 and token '+' resolved as shift (LRSHE < '+').
    Conflict between rule 134 and token '-' resolved as shift (LRSHE < '-').
    Conflict between rule 134 and token '*' resolved as shift (LRSHE < '*').
    Conflict between rule 134 and token '/' resolved as shift (LRSHE < '/').
    Conflict between rule 134 and token '%' resolved as shift (LRSHE < '%').


state 239

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  132     | expr LMDE expr .  [';', ',', ':', ')', ']', '}']
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '='      shift, and go to state 157
    LORE     shift, and go to state 158
    LXORE    shift, and go to state 159
    LANDE    shift, and go to state 160
    LLSHE    shift, and go to state 161
    LRSHE    shift, and go to state 162
    LMDE     shift, and go to state 163
    LDVE     shift, and go to state 164
    LMLE     shift, and go to state 165
    LME      shift, and go to state 166
    LPE      shift, and go to state 167
    '?'      shift, and go to state 168
    LOROR    shift, and go to state 169
    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186

    $default  reduce using rule 132 (expr)

    Conflict between rule 132 and token '=' resolved as shift (%right '=').
    Conflict between rule 132 and token LORE resolved as shift (%right LORE).
    Conflict between rule 132 and token LXORE resolved as shift (%right LXORE).
    Conflict between rule 132 and token LANDE resolved as shift (%right LANDE).
    Conflict between rule 132 and token LLSHE resolved as shift (%right LLSHE).
    Conflict between rule 132 and token LRSHE resolved as shift (%right LRSHE).
    Conflict between rule 132 and token LMDE resolved as shift (%right LMDE).
    Conflict between rule 132 and token LDVE resolved as shift (%right LDVE).
    Conflict between rule 132 and token LMLE resolved as shift (%right LMLE).
    Conflict between rule 132 and token LME resolved as shift (%right LME).
    Conflict between rule 132 and token LPE resolved as shift (%right LPE).
    Conflict between rule 132 and token '?' resolved as shift (LMDE < '?').
    Conflict between rule 132 and token LOROR resolved as shift (LMDE < LOROR).
    Conflict between rule 132 and token LANDAND resolved as shift (LMDE < LANDAND).
    Conflict between rule 132 and token '|' resolved as shift (LMDE < '|').
    Conflict between rule 132 and token '^' resolved as shift (LMDE < '^').
    Conflict between rule 132 and token '&' resolved as shift (LMDE < '&').
    Conflict between rule 132 and token LNE resolved as shift (LMDE < LNE).
    Conflict between rule 132 and token LEQ resolved as shift (LMDE < LEQ).
    Conflict between rule 132 and token '<' resolved as shift (LMDE < '<').
    Conflict between rule 132 and token '>' resolved as shift (LMDE < '>').
    Conflict between rule 132 and token LGE resolved as shift (LMDE < LGE).
    Conflict between rule 132 and token LLE resolved as shift (LMDE < LLE).
    Conflict between rule 132 and token LRSH resolved as shift (LMDE < LRSH).
    Conflict between rule 132 and token LLSH resolved as shift (LMDE < LLSH).
    Conflict between rule 132 and token '+' resolved as shift (LMDE < '+').
    Conflict between rule 132 and token '-' resolved as shift (LMDE < '-').
    Conflict between rule 132 and token '*' resolved as shift (LMDE < '*').
    Conflict between rule 132 and token '/' resolved as shift (LMDE < '/').
    Conflict between rule 132 and token '%' resolved as shift (LMDE < '%').


state 240

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  131     | expr LDVE expr .  [';', ',', ':', ')', ']', '}']
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '='      shift, and go to state 157
    LORE     shift, and go to state 158
    LXORE    shift, and go to state 159
    LANDE    shift, and go to state 160
    LLSHE    shift, and go to state 161
    LRSHE    shift, and go to state 162
    LMDE     shift, and go to state 163
    LDVE     shift, and go to state 164
    LMLE     shift, and go to state 165
    LME      shift, and go to state 166
    LPE      shift, and go to state 167
    '?'      shift, and go to state 168
    LOROR    shift, and go to state 169
    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186

    $default  reduce using rule 131 (expr)

    Conflict between rule 131 and token '=' resolved as shift (%right '=').
    Conflict between rule 131 and token LORE resolved as shift (%right LORE).
    Conflict between rule 131 and token LXORE resolved as shift (%right LXORE).
    Conflict between rule 131 and token LANDE resolved as shift (%right LANDE).
    Conflict between rule 131 and token LLSHE resolved as shift (%right LLSHE).
    Conflict between rule 131 and token LRSHE resolved as shift (%right LRSHE).
    Conflict between rule 131 and token LMDE resolved as shift (%right LMDE).
    Conflict between rule 131 and token LDVE resolved as shift (%right LDVE).
    Conflict between rule 131 and token LMLE resolved as shift (%right LMLE).
    Conflict between rule 131 and token LME resolved as shift (%right LME).
    Conflict between rule 131 and token LPE resolved as shift (%right LPE).
    Conflict between rule 131 and token '?' resolved as shift (LDVE < '?').
    Conflict between rule 131 and token LOROR resolved as shift (LDVE < LOROR).
    Conflict between rule 131 and token LANDAND resolved as shift (LDVE < LANDAND).
    Conflict between rule 131 and token '|' resolved as shift (LDVE < '|').
    Conflict between rule 131 and token '^' resolved as shift (LDVE < '^').
    Conflict between rule 131 and token '&' resolved as shift (LDVE < '&').
    Conflict between rule 131 and token LNE resolved as shift (LDVE < LNE).
    Conflict between rule 131 and token LEQ resolved as shift (LDVE < LEQ).
    Conflict between rule 131 and token '<' resolved as shift (LDVE < '<').
    Conflict between rule 131 and token '>' resolved as shift (LDVE < '>').
    Conflict between rule 131 and token LGE resolved as shift (LDVE < LGE).
    Conflict between rule 131 and token LLE resolved as shift (LDVE < LLE).
    Conflict between rule 131 and token LRSH resolved as shift (LDVE < LRSH).
    Conflict between rule 131 and token LLSH resolved as shift (LDVE < LLSH).
    Conflict between rule 131 and token '+' resolved as shift (LDVE < '+').
    Conflict between rule 131 and token '-' resolved as shift (LDVE < '-').
    Conflict between rule 131 and token '*' resolved as shift (LDVE < '*').
    Conflict between rule 131 and token '/' resolved as shift (LDVE < '/').
    Conflict between rule 131 and token '%' resolved as shift (LDVE < '%').


state 241

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  130     | expr LMLE expr .  [';', ',', ':', ')', ']', '}']
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '='      shift, and go to state 157
    LORE     shift, and go to state 158
    LXORE    shift, and go to state 159
    LANDE    shift, and go to state 160
    LLSHE    shift, and go to state 161
    LRSHE    shift, and go to state 162
    LMDE     shift, and go to state 163
    LDVE     shift, and go to state 164
    LMLE     shift, and go to state 165
    LME      shift, and go to state 166
    LPE      shift, and go to state 167
    '?'      shift, and go to state 168
    LOROR    shift, and go to state 169
    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186

    $default  reduce using rule 130 (expr)

    Conflict between rule 130 and token '=' resolved as shift (%right '=').
    Conflict between rule 130 and token LORE resolved as shift (%right LORE).
    Conflict between rule 130 and token LXORE resolved as shift (%right LXORE).
    Conflict between rule 130 and token LANDE resolved as shift (%right LANDE).
    Conflict between rule 130 and token LLSHE resolved as shift (%right LLSHE).
    Conflict between rule 130 and token LRSHE resolved as shift (%right LRSHE).
    Conflict between rule 130 and token LMDE resolved as shift (%right LMDE).
    Conflict between rule 130 and token LDVE resolved as shift (%right LDVE).
    Conflict between rule 130 and token LMLE resolved as shift (%right LMLE).
    Conflict between rule 130 and token LME resolved as shift (%right LME).
    Conflict between rule 130 and token LPE resolved as shift (%right LPE).
    Conflict between rule 130 and token '?' resolved as shift (LMLE < '?').
    Conflict between rule 130 and token LOROR resolved as shift (LMLE < LOROR).
    Conflict between rule 130 and token LANDAND resolved as shift (LMLE < LANDAND).
    Conflict between rule 130 and token '|' resolved as shift (LMLE < '|').
    Conflict between rule 130 and token '^' resolved as shift (LMLE < '^').
    Conflict between rule 130 and token '&' resolved as shift (LMLE < '&').
    Conflict between rule 130 and token LNE resolved as shift (LMLE < LNE).
    Conflict between rule 130 and token LEQ resolved as shift (LMLE < LEQ).
    Conflict between rule 130 and token '<' resolved as shift (LMLE < '<').
    Conflict between rule 130 and token '>' resolved as shift (LMLE < '>').
    Conflict between rule 130 and token LGE resolved as shift (LMLE < LGE).
    Conflict between rule 130 and token LLE resolved as shift (LMLE < LLE).
    Conflict between rule 130 and token LRSH resolved as shift (LMLE < LRSH).
    Conflict between rule 130 and token LLSH resolved as shift (LMLE < LLSH).
    Conflict between rule 130 and token '+' resolved as shift (LMLE < '+').
    Conflict between rule 130 and token '-' resolved as shift (LMLE < '-').
    Conflict between rule 130 and token '*' resolved as shift (LMLE < '*').
    Conflict between rule 130 and token '/' resolved as shift (LMLE < '/').
    Conflict between rule 130 and token '%' resolved as shift (LMLE < '%').


state 242

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  129     | expr LME expr .  [';', ',', ':', ')', ']', '}']
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '='      shift, and go to state 157
    LORE     shift, and go to state 158
    LXORE    shift, and go to state 159
    LANDE    shift, and go to state 160
    LLSHE    shift, and go to state 161
    LRSHE    shift, and go to state 162
    LMDE     shift, and go to state 163
    LDVE     shift, and go to state 164
    LMLE     shift, and go to state 165
    LME      shift, and go to state 166
    LPE      shift, and go to state 167
    '?'      shift, and go to state 168
    LOROR    shift, and go to state 169
    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186

    $default  reduce using rule 129 (expr)

    Conflict between rule 129 and token '=' resolved as shift (%right '=').
    Conflict between rule 129 and token LORE resolved as shift (%right LORE).
    Conflict between rule 129 and token LXORE resolved as shift (%right LXORE).
    Conflict between rule 129 and token LANDE resolved as shift (%right LANDE).
    Conflict between rule 129 and token LLSHE resolved as shift (%right LLSHE).
    Conflict between rule 129 and token LRSHE resolved as shift (%right LRSHE).
    Conflict between rule 129 and token LMDE resolved as shift (%right LMDE).
    Conflict between rule 129 and token LDVE resolved as shift (%right LDVE).
    Conflict between rule 129 and token LMLE resolved as shift (%right LMLE).
    Conflict between rule 129 and token LME resolved as shift (%right LME).
    Conflict between rule 129 and token LPE resolved as shift (%right LPE).
    Conflict between rule 129 and token '?' resolved as shift (LME < '?').
    Conflict between rule 129 and token LOROR resolved as shift (LME < LOROR).
    Conflict between rule 129 and token LANDAND resolved as shift (LME < LANDAND).
    Conflict between rule 129 and token '|' resolved as shift (LME < '|').
    Conflict between rule 129 and token '^' resolved as shift (LME < '^').
    Conflict between rule 129 and token '&' resolved as shift (LME < '&').
    Conflict between rule 129 and token LNE resolved as shift (LME < LNE).
    Conflict between rule 129 and token LEQ resolved as shift (LME < LEQ).
    Conflict between rule 129 and token '<' resolved as shift (LME < '<').
    Conflict between rule 129 and token '>' resolved as shift (LME < '>').
    Conflict between rule 129 and token LGE resolved as shift (LME < LGE).
    Conflict between rule 129 and token LLE resolved as shift (LME < LLE).
    Conflict between rule 129 and token LRSH resolved as shift (LME < LRSH).
    Conflict between rule 129 and token LLSH resolved as shift (LME < LLSH).
    Conflict between rule 129 and token '+' resolved as shift (LME < '+').
    Conflict between rule 129 and token '-' resolved as shift (LME < '-').
    Conflict between rule 129 and token '*' resolved as shift (LME < '*').
    Conflict between rule 129 and token '/' resolved as shift (LME < '/').
    Conflict between rule 129 and token '%' resolved as shift (LME < '%').


state 243

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  128     | expr LPE expr .  [';', ',', ':', ')', ']', '}']
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '='      shift, and go to state 157
    LORE     shift, and go to state 158
    LXORE    shift, and go to state 159
    LANDE    shift, and go to state 160
    LLSHE    shift, and go to state 161
    LRSHE    shift, and go to state 162
    LMDE     shift, and go to state 163
    LDVE     shift, and go to state 164
    LMLE     shift, and go to state 165
    LME      shift, and go to state 166
    LPE      shift, and go to state 167
    '?'      shift, and go to state 168
    LOROR    shift, and go to state 169
    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186

    $default  reduce using rule 128 (expr)

    Conflict between rule 128 and token '=' resolved as shift (%right '=').
    Conflict between rule 128 and token LORE resolved as shift (%right LORE).
    Conflict between rule 128 and token LXORE resolved as shift (%right LXORE).
    Conflict between rule 128 and token LANDE resolved as shift (%right LANDE).
    Conflict between rule 128 and token LLSHE resolved as shift (%right LLSHE).
    Conflict between rule 128 and token LRSHE resolved as shift (%right LRSHE).
    Conflict between rule 128 and token LMDE resolved as shift (%right LMDE).
    Conflict between rule 128 and token LDVE resolved as shift (%right LDVE).
    Conflict between rule 128 and token LMLE resolved as shift (%right LMLE).
    Conflict between rule 128 and token LME resolved as shift (%right LME).
    Conflict between rule 128 and token LPE resolved as shift (%right LPE).
    Conflict between rule 128 and token '?' resolved as shift (LPE < '?').
    Conflict between rule 128 and token LOROR resolved as shift (LPE < LOROR).
    Conflict between rule 128 and token LANDAND resolved as shift (LPE < LANDAND).
    Conflict between rule 128 and token '|' resolved as shift (LPE < '|').
    Conflict between rule 128 and token '^' resolved as shift (LPE < '^').
    Conflict between rule 128 and token '&' resolved as shift (LPE < '&').
    Conflict between rule 128 and token LNE resolved as shift (LPE < LNE).
    Conflict between rule 128 and token LEQ resolved as shift (LPE < LEQ).
    Conflict between rule 128 and token '<' resolved as shift (LPE < '<').
    Conflict between rule 128 and token '>' resolved as shift (LPE < '>').
    Conflict between rule 128 and token LGE resolved as shift (LPE < LGE).
    Conflict between rule 128 and token LLE resolved as shift (LPE < LLE).
    Conflict between rule 128 and token LRSH resolved as shift (LPE < LRSH).
    Conflict between rule 128 and token LLSH resolved as shift (LPE < LLSH).
    Conflict between rule 128 and token '+' resolved as shift (LPE < '+').
    Conflict between rule 128 and token '-' resolved as shift (LPE < '-').
    Conflict between rule 128 and token '*' resolved as shift (LPE < '*').
    Conflict between rule 128 and token '/' resolved as shift (LPE < '/').
    Conflict between rule 128 and token '%' resolved as shift (LPE < '%').


state 244

  106 cexpr: cexpr . ',' cexpr
  126 expr: expr '?' cexpr . ':' expr

    ','  shift, and go to state 226
    ':'  shift, and go to state 298


state 245

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  125     | expr LOROR expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, ')', ']', '}']
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186

    $default  reduce using rule 125 (expr)

    Conflict between rule 125 and token '=' resolved as reduce ('=' < LOROR).
    Conflict between rule 125 and token LORE resolved as reduce (LORE < LOROR).
    Conflict between rule 125 and token LXORE resolved as reduce (LXORE < LOROR).
    Conflict between rule 125 and token LANDE resolved as reduce (LANDE < LOROR).
    Conflict between rule 125 and token LLSHE resolved as reduce (LLSHE < LOROR).
    Conflict between rule 125 and token LRSHE resolved as reduce (LRSHE < LOROR).
    Conflict between rule 125 and token LMDE resolved as reduce (LMDE < LOROR).
    Conflict between rule 125 and token LDVE resolved as reduce (LDVE < LOROR).
    Conflict between rule 125 and token LMLE resolved as reduce (LMLE < LOROR).
    Conflict between rule 125 and token LME resolved as reduce (LME < LOROR).
    Conflict between rule 125 and token LPE resolved as reduce (LPE < LOROR).
    Conflict between rule 125 and token '?' resolved as reduce ('?' < LOROR).
    Conflict between rule 125 and token LOROR resolved as reduce (%left LOROR).
    Conflict between rule 125 and token LANDAND resolved as shift (LOROR < LANDAND).
    Conflict between rule 125 and token '|' resolved as shift (LOROR < '|').
    Conflict between rule 125 and token '^' resolved as shift (LOROR < '^').
    Conflict between rule 125 and token '&' resolved as shift (LOROR < '&').
    Conflict between rule 125 and token LNE resolved as shift (LOROR < LNE).
    Conflict between rule 125 and token LEQ resolved as shift (LOROR < LEQ).
    Conflict between rule 125 and token '<' resolved as shift (LOROR < '<').
    Conflict between rule 125 and token '>' resolved as shift (LOROR < '>').
    Conflict between rule 125 and token LGE resolved as shift (LOROR < LGE).
    Conflict between rule 125 and token LLE resolved as shift (LOROR < LLE).
    Conflict between rule 125 and token LRSH resolved as shift (LOROR < LRSH).
    Conflict between rule 125 and token LLSH resolved as shift (LOROR < LLSH).
    Conflict between rule 125 and token '+' resolved as shift (LOROR < '+').
    Conflict between rule 125 and token '-' resolved as shift (LOROR < '-').
    Conflict between rule 125 and token '*' resolved as shift (LOROR < '*').
    Conflict between rule 125 and token '/' resolved as shift (LOROR < '/').
    Conflict between rule 125 and token '%' resolved as shift (LOROR < '%').


state 246

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  124     | expr LANDAND expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, ')', ']', '}']
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '|'   shift, and go to state 171
    '^'   shift, and go to state 172
    '&'   shift, and go to state 173
    LNE   shift, and go to state 174
    LEQ   shift, and go to state 175
    '<'   shift, and go to state 176
    '>'   shift, and go to state 177
    LGE   shift, and go to state 178
    LLE   shift, and go to state 179
    LRSH  shift, and go to state 180
    LLSH  shift, and go to state 181
    '+'   shift, and go to state 182
    '-'   shift, and go to state 183
    '*'   shift, and go to state 184
    '/'   shift, and go to state 185
    '%'   shift, and go to state 186

    $default  reduce using rule 124 (expr)

    Conflict between rule 124 and token '=' resolved as reduce ('=' < LANDAND).
    Conflict between rule 124 and token LORE resolved as reduce (LORE < LANDAND).
    Conflict between rule 124 and token LXORE resolved as reduce (LXORE < LANDAND).
    Conflict between rule 124 and token LANDE resolved as reduce (LANDE < LANDAND).
    Conflict between rule 124 and token LLSHE resolved as reduce (LLSHE < LANDAND).
    Conflict between rule 124 and token LRSHE resolved as reduce (LRSHE < LANDAND).
    Conflict between rule 124 and token LMDE resolved as reduce (LMDE < LANDAND).
    Conflict between rule 124 and token LDVE resolved as reduce (LDVE < LANDAND).
    Conflict between rule 124 and token LMLE resolved as reduce (LMLE < LANDAND).
    Conflict between rule 124 and token LME resolved as reduce (LME < LANDAND).
    Conflict between rule 124 and token LPE resolved as reduce (LPE < LANDAND).
    Conflict between rule 124 and token '?' resolved as reduce ('?' < LANDAND).
    Conflict between rule 124 and token LOROR resolved as reduce (LOROR < LANDAND).
    Conflict between rule 124 and token LANDAND resolved as reduce (%left LANDAND).
    Conflict between rule 124 and token '|' resolved as shift (LANDAND < '|').
    Conflict between rule 124 and token '^' resolved as shift (LANDAND < '^').
    Conflict between rule 124 and token '&' resolved as shift (LANDAND < '&').
    Conflict between rule 124 and token LNE resolved as shift (LANDAND < LNE).
    Conflict between rule 124 and token LEQ resolved as shift (LANDAND < LEQ).
    Conflict between rule 124 and token '<' resolved as shift (LANDAND < '<').
    Conflict between rule 124 and token '>' resolved as shift (LANDAND < '>').
    Conflict between rule 124 and token LGE resolved as shift (LANDAND < LGE).
    Conflict between rule 124 and token LLE resolved as shift (LANDAND < LLE).
    Conflict between rule 124 and token LRSH resolved as shift (LANDAND < LRSH).
    Conflict between rule 124 and token LLSH resolved as shift (LANDAND < LLSH).
    Conflict between rule 124 and token '+' resolved as shift (LANDAND < '+').
    Conflict between rule 124 and token '-' resolved as shift (LANDAND < '-').
    Conflict between rule 124 and token '*' resolved as shift (LANDAND < '*').
    Conflict between rule 124 and token '/' resolved as shift (LANDAND < '/').
    Conflict between rule 124 and token '%' resolved as shift (LANDAND < '%').


state 247

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  123     | expr '|' expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', ')', ']', '}']
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '^'   shift, and go to state 172
    '&'   shift, and go to state 173
    LNE   shift, and go to state 174
    LEQ   shift, and go to state 175
    '<'   shift, and go to state 176
    '>'   shift, and go to state 177
    LGE   shift, and go to state 178
    LLE   shift, and go to state 179
    LRSH  shift, and go to state 180
    LLSH  shift, and go to state 181
    '+'   shift, and go to state 182
    '-'   shift, and go to state 183
    '*'   shift, and go to state 184
    '/'   shift, and go to state 185
    '%'   shift, and go to state 186

    $default  reduce using rule 123 (expr)

    Conflict between rule 123 and token '=' resolved as reduce ('=' < '|').
    Conflict between rule 123 and token LORE resolved as reduce (LORE < '|').
    Conflict between rule 123 and token LXORE resolved as reduce (LXORE < '|').
    Conflict between rule 123 and token LANDE resolved as reduce (LANDE < '|').
    Conflict between rule 123 and token LLSHE resolved as reduce (LLSHE < '|').
    Conflict between rule 123 and token LRSHE resolved as reduce (LRSHE < '|').
    Conflict between rule 123 and token LMDE resolved as reduce (LMDE < '|').
    Conflict between rule 123 and token LDVE resolved as reduce (LDVE < '|').
    Conflict between rule 123 and token LMLE resolved as reduce (LMLE < '|').
    Conflict between rule 123 and token LME resolved as reduce (LME < '|').
    Conflict between rule 123 and token LPE resolved as reduce (LPE < '|').
    Conflict between rule 123 and token '?' resolved as reduce ('?' < '|').
    Conflict between rule 123 and token LOROR resolved as reduce (LOROR < '|').
    Conflict between rule 123 and token LANDAND resolved as reduce (LANDAND < '|').
    Conflict between rule 123 and token '|' resolved as reduce (%left '|').
    Conflict between rule 123 and token '^' resolved as shift ('|' < '^').
    Conflict between rule 123 and token '&' resolved as shift ('|' < '&').
    Conflict between rule 123 and token LNE resolved as shift ('|' < LNE).
    Conflict between rule 123 and token LEQ resolved as shift ('|' < LEQ).
    Conflict between rule 123 and token '<' resolved as shift ('|' < '<').
    Conflict between rule 123 and token '>' resolved as shift ('|' < '>').
    Conflict between rule 123 and token LGE resolved as shift ('|' < LGE).
    Conflict between rule 123 and token LLE resolved as shift ('|' < LLE).
    Conflict between rule 123 and token LRSH resolved as shift ('|' < LRSH).
    Conflict between rule 123 and token LLSH resolved as shift ('|' < LLSH).
    Conflict between rule 123 and token '+' resolved as shift ('|' < '+').
    Conflict between rule 123 and token '-' resolved as shift ('|' < '-').
    Conflict between rule 123 and token '*' resolved as shift ('|' < '*').
    Conflict between rule 123 and token '/' resolved as shift ('|' < '/').
    Conflict between rule 123 and token '%' resolved as shift ('|' < '%').


state 248

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  122     | expr '^' expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', '^', ')', ']', '}']
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '&'   shift, and go to state 173
    LNE   shift, and go to state 174
    LEQ   shift, and go to state 175
    '<'   shift, and go to state 176
    '>'   shift, and go to state 177
    LGE   shift, and go to state 178
    LLE   shift, and go to state 179
    LRSH  shift, and go to state 180
    LLSH  shift, and go to state 181
    '+'   shift, and go to state 182
    '-'   shift, and go to state 183
    '*'   shift, and go to state 184
    '/'   shift, and go to state 185
    '%'   shift, and go to state 186

    $default  reduce using rule 122 (expr)

    Conflict between rule 122 and token '=' resolved as reduce ('=' < '^').
    Conflict between rule 122 and token LORE resolved as reduce (LORE < '^').
    Conflict between rule 122 and token LXORE resolved as reduce (LXORE < '^').
    Conflict between rule 122 and token LANDE resolved as reduce (LANDE < '^').
    Conflict between rule 122 and token LLSHE resolved as reduce (LLSHE < '^').
    Conflict between rule 122 and token LRSHE resolved as reduce (LRSHE < '^').
    Conflict between rule 122 and token LMDE resolved as reduce (LMDE < '^').
    Conflict between rule 122 and token LDVE resolved as reduce (LDVE < '^').
    Conflict between rule 122 and token LMLE resolved as reduce (LMLE < '^').
    Conflict between rule 122 and token LME resolved as reduce (LME < '^').
    Conflict between rule 122 and token LPE resolved as reduce (LPE < '^').
    Conflict between rule 122 and token '?' resolved as reduce ('?' < '^').
    Conflict between rule 122 and token LOROR resolved as reduce (LOROR < '^').
    Conflict between rule 122 and token LANDAND resolved as reduce (LANDAND < '^').
    Conflict between rule 122 and token '|' resolved as reduce ('|' < '^').
    Conflict between rule 122 and token '^' resolved as reduce (%left '^').
    Conflict between rule 122 and token '&' resolved as shift ('^' < '&').
    Conflict between rule 122 and token LNE resolved as shift ('^' < LNE).
    Conflict between rule 122 and token LEQ resolved as shift ('^' < LEQ).
    Conflict between rule 122 and token '<' resolved as shift ('^' < '<').
    Conflict between rule 122 and token '>' resolved as shift ('^' < '>').
    Conflict between rule 122 and token LGE resolved as shift ('^' < LGE).
    Conflict between rule 122 and token LLE resolved as shift ('^' < LLE).
    Conflict between rule 122 and token LRSH resolved as shift ('^' < LRSH).
    Conflict between rule 122 and token LLSH resolved as shift ('^' < LLSH).
    Conflict between rule 122 and token '+' resolved as shift ('^' < '+').
    Conflict between rule 122 and token '-' resolved as shift ('^' < '-').
    Conflict between rule 122 and token '*' resolved as shift ('^' < '*').
    Conflict between rule 122 and token '/' resolved as shift ('^' < '/').
    Conflict between rule 122 and token '%' resolved as shift ('^' < '%').


state 249

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  121     | expr '&' expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', '^', '&', ')', ']', '}']
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    LNE   shift, and go to state 174
    LEQ   shift, and go to state 175
    '<'   shift, and go to state 176
    '>'   shift, and go to state 177
    LGE   shift, and go to state 178
    LLE   shift, and go to state 179
    LRSH  shift, and go to state 180
    LLSH  shift, and go to state 181
    '+'   shift, and go to state 182
    '-'   shift, and go to state 183
    '*'   shift, and go to state 184
    '/'   shift, and go to state 185
    '%'   shift, and go to state 186

    $default  reduce using rule 121 (expr)

    Conflict between rule 121 and token '=' resolved as reduce ('=' < '&').
    Conflict between rule 121 and token LORE resolved as reduce (LORE < '&').
    Conflict between rule 121 and token LXORE resolved as reduce (LXORE < '&').
    Conflict between rule 121 and token LANDE resolved as reduce (LANDE < '&').
    Conflict between rule 121 and token LLSHE resolved as reduce (LLSHE < '&').
    Conflict between rule 121 and token LRSHE resolved as reduce (LRSHE < '&').
    Conflict between rule 121 and token LMDE resolved as reduce (LMDE < '&').
    Conflict between rule 121 and token LDVE resolved as reduce (LDVE < '&').
    Conflict between rule 121 and token LMLE resolved as reduce (LMLE < '&').
    Conflict between rule 121 and token LME resolved as reduce (LME < '&').
    Conflict between rule 121 and token LPE resolved as reduce (LPE < '&').
    Conflict between rule 121 and token '?' resolved as reduce ('?' < '&').
    Conflict between rule 121 and token LOROR resolved as reduce (LOROR < '&').
    Conflict between rule 121 and token LANDAND resolved as reduce (LANDAND < '&').
    Conflict between rule 121 and token '|' resolved as reduce ('|' < '&').
    Conflict between rule 121 and token '^' resolved as reduce ('^' < '&').
    Conflict between rule 121 and token '&' resolved as reduce (%left '&').
    Conflict between rule 121 and token LNE resolved as shift ('&' < LNE).
    Conflict between rule 121 and token LEQ resolved as shift ('&' < LEQ).
    Conflict between rule 121 and token '<' resolved as shift ('&' < '<').
    Conflict between rule 121 and token '>' resolved as shift ('&' < '>').
    Conflict between rule 121 and token LGE resolved as shift ('&' < LGE).
    Conflict between rule 121 and token LLE resolved as shift ('&' < LLE).
    Conflict between rule 121 and token LRSH resolved as shift ('&' < LRSH).
    Conflict between rule 121 and token LLSH resolved as shift ('&' < LLSH).
    Conflict between rule 121 and token '+' resolved as shift ('&' < '+').
    Conflict between rule 121 and token '-' resolved as shift ('&' < '-').
    Conflict between rule 121 and token '*' resolved as shift ('&' < '*').
    Conflict between rule 121 and token '/' resolved as shift ('&' < '/').
    Conflict between rule 121 and token '%' resolved as shift ('&' < '%').


state 250

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  120     | expr LNE expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', '^', '&', LNE, LEQ, ')', ']', '}']
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '<'   shift, and go to state 176
    '>'   shift, and go to state 177
    LGE   shift, and go to state 178
    LLE   shift, and go to state 179
    LRSH  shift, and go to state 180
    LLSH  shift, and go to state 181
    '+'   shift, and go to state 182
    '-'   shift, and go to state 183
    '*'   shift, and go to state 184
    '/'   shift, and go to state 185
    '%'   shift, and go to state 186

    $default  reduce using rule 120 (expr)

    Conflict between rule 120 and token '=' resolved as reduce ('=' < LNE).
    Conflict between rule 120 and token LORE resolved as reduce (LORE < LNE).
    Conflict between rule 120 and token LXORE resolved as reduce (LXORE < LNE).
    Conflict between rule 120 and token LANDE resolved as reduce (LANDE < LNE).
    Conflict between rule 120 and token LLSHE resolved as reduce (LLSHE < LNE).
    Conflict between rule 120 and token LRSHE resolved as reduce (LRSHE < LNE).
    Conflict between rule 120 and token LMDE resolved as reduce (LMDE < LNE).
    Conflict between rule 120 and token LDVE resolved as reduce (LDVE < LNE).
    Conflict between rule 120 and token LMLE resolved as reduce (LMLE < LNE).
    Conflict between rule 120 and token LME resolved as reduce (LME < LNE).
    Conflict between rule 120 and token LPE resolved as reduce (LPE < LNE).
    Conflict between rule 120 and token '?' resolved as reduce ('?' < LNE).
    Conflict between rule 120 and token LOROR resolved as reduce (LOROR < LNE).
    Conflict between rule 120 and token LANDAND resolved as reduce (LANDAND < LNE).
    Conflict between rule 120 and token '|' resolved as reduce ('|' < LNE).
    Conflict between rule 120 and token '^' resolved as reduce ('^' < LNE).
    Conflict between rule 120 and token '&' resolved as reduce ('&' < LNE).
    Conflict between rule 120 and token LNE resolved as reduce (%left LNE).
    Conflict between rule 120 and token LEQ resolved as reduce (%left LEQ).
    Conflict between rule 120 and token '<' resolved as shift (LNE < '<').
    Conflict between rule 120 and token '>' resolved as shift (LNE < '>').
    Conflict between rule 120 and token LGE resolved as shift (LNE < LGE).
    Conflict between rule 120 and token LLE resolved as shift (LNE < LLE).
    Conflict between rule 120 and token LRSH resolved as shift (LNE < LRSH).
    Conflict between rule 120 and token LLSH resolved as shift (LNE < LLSH).
    Conflict between rule 120 and token '+' resolved as shift (LNE < '+').
    Conflict between rule 120 and token '-' resolved as shift (LNE < '-').
    Conflict between rule 120 and token '*' resolved as shift (LNE < '*').
    Conflict between rule 120 and token '/' resolved as shift (LNE < '/').
    Conflict between rule 120 and token '%' resolved as shift (LNE < '%').


state 251

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  119     | expr LEQ expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', '^', '&', LNE, LEQ, ')', ']', '}']
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '<'   shift, and go to state 176
    '>'   shift, and go to state 177
    LGE   shift, and go to state 178
    LLE   shift, and go to state 179
    LRSH  shift, and go to state 180
    LLSH  shift, and go to state 181
    '+'   shift, and go to state 182
    '-'   shift, and go to state 183
    '*'   shift, and go to state 184
    '/'   shift, and go to state 185
    '%'   shift, and go to state 186

    $default  reduce using rule 119 (expr)

    Conflict between rule 119 and token '=' resolved as reduce ('=' < LEQ).
    Conflict between rule 119 and token LORE resolved as reduce (LORE < LEQ).
    Conflict between rule 119 and token LXORE resolved as reduce (LXORE < LEQ).
    Conflict between rule 119 and token LANDE resolved as reduce (LANDE < LEQ).
    Conflict between rule 119 and token LLSHE resolved as reduce (LLSHE < LEQ).
    Conflict between rule 119 and token LRSHE resolved as reduce (LRSHE < LEQ).
    Conflict between rule 119 and token LMDE resolved as reduce (LMDE < LEQ).
    Conflict between rule 119 and token LDVE resolved as reduce (LDVE < LEQ).
    Conflict between rule 119 and token LMLE resolved as reduce (LMLE < LEQ).
    Conflict between rule 119 and token LME resolved as reduce (LME < LEQ).
    Conflict between rule 119 and token LPE resolved as reduce (LPE < LEQ).
    Conflict between rule 119 and token '?' resolved as reduce ('?' < LEQ).
    Conflict between rule 119 and token LOROR resolved as reduce (LOROR < LEQ).
    Conflict between rule 119 and token LANDAND resolved as reduce (LANDAND < LEQ).
    Conflict between rule 119 and token '|' resolved as reduce ('|' < LEQ).
    Conflict between rule 119 and token '^' resolved as reduce ('^' < LEQ).
    Conflict between rule 119 and token '&' resolved as reduce ('&' < LEQ).
    Conflict between rule 119 and token LNE resolved as reduce (%left LNE).
    Conflict between rule 119 and token LEQ resolved as reduce (%left LEQ).
    Conflict between rule 119 and token '<' resolved as shift (LEQ < '<').
    Conflict between rule 119 and token '>' resolved as shift (LEQ < '>').
    Conflict between rule 119 and token LGE resolved as shift (LEQ < LGE).
    Conflict between rule 119 and token LLE resolved as shift (LEQ < LLE).
    Conflict between rule 119 and token LRSH resolved as shift (LEQ < LRSH).
    Conflict between rule 119 and token LLSH resolved as shift (LEQ < LLSH).
    Conflict between rule 119 and token '+' resolved as shift (LEQ < '+').
    Conflict between rule 119 and token '-' resolved as shift (LEQ < '-').
    Conflict between rule 119 and token '*' resolved as shift (LEQ < '*').
    Conflict between rule 119 and token '/' resolved as shift (LEQ < '/').
    Conflict between rule 119 and token '%' resolved as shift (LEQ < '%').


state 252

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  115     | expr '<' expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', '^', '&', LNE, LEQ, '<', '>', LGE, LLE, ')', ']', '}']
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    LRSH  shift, and go to state 180
    LLSH  shift, and go to state 181
    '+'   shift, and go to state 182
    '-'   shift, and go to state 183
    '*'   shift, and go to state 184
    '/'   shift, and go to state 185
    '%'   shift, and go to state 186

    $default  reduce using rule 115 (expr)

    Conflict between rule 115 and token '=' resolved as reduce ('=' < '<').
    Conflict between rule 115 and token LORE resolved as reduce (LORE < '<').
    Conflict between rule 115 and token LXORE resolved as reduce (LXORE < '<').
    Conflict between rule 115 and token LANDE resolved as reduce (LANDE < '<').
    Conflict between rule 115 and token LLSHE resolved as reduce (LLSHE < '<').
    Conflict between rule 115 and token LRSHE resolved as reduce (LRSHE < '<').
    Conflict between rule 115 and token LMDE resolved as reduce (LMDE < '<').
    Conflict between rule 115 and token LDVE resolved as reduce (LDVE < '<').
    Conflict between rule 115 and token LMLE resolved as reduce (LMLE < '<').
    Conflict between rule 115 and token LME resolved as reduce (LME < '<').
    Conflict between rule 115 and token LPE resolved as reduce (LPE < '<').
    Conflict between rule 115 and token '?' resolved as reduce ('?' < '<').
    Conflict between rule 115 and token LOROR resolved as reduce (LOROR < '<').
    Conflict between rule 115 and token LANDAND resolved as reduce (LANDAND < '<').
    Conflict between rule 115 and token '|' resolved as reduce ('|' < '<').
    Conflict between rule 115 and token '^' resolved as reduce ('^' < '<').
    Conflict between rule 115 and token '&' resolved as reduce ('&' < '<').
    Conflict between rule 115 and token LNE resolved as reduce (LNE < '<').
    Conflict between rule 115 and token LEQ resolved as reduce (LEQ < '<').
    Conflict between rule 115 and token '<' resolved as reduce (%left '<').
    Conflict between rule 115 and token '>' resolved as reduce (%left '>').
    Conflict between rule 115 and token LGE resolved as reduce (%left LGE).
    Conflict between rule 115 and token LLE resolved as reduce (%left LLE).
    Conflict between rule 115 and token LRSH resolved as shift ('<' < LRSH).
    Conflict between rule 115 and token LLSH resolved as shift ('<' < LLSH).
    Conflict between rule 115 and token '+' resolved as shift ('<' < '+').
    Conflict between rule 115 and token '-' resolved as shift ('<' < '-').
    Conflict between rule 115 and token '*' resolved as shift ('<' < '*').
    Conflict between rule 115 and token '/' resolved as shift ('<' < '/').
    Conflict between rule 115 and token '%' resolved as shift ('<' < '%').


state 253

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  116     | expr '>' expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', '^', '&', LNE, LEQ, '<', '>', LGE, LLE, ')', ']', '}']
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    LRSH  shift, and go to state 180
    LLSH  shift, and go to state 181
    '+'   shift, and go to state 182
    '-'   shift, and go to state 183
    '*'   shift, and go to state 184
    '/'   shift, and go to state 185
    '%'   shift, and go to state 186

    $default  reduce using rule 116 (expr)

    Conflict between rule 116 and token '=' resolved as reduce ('=' < '>').
    Conflict between rule 116 and token LORE resolved as reduce (LORE < '>').
    Conflict between rule 116 and token LXORE resolved as reduce (LXORE < '>').
    Conflict between rule 116 and token LANDE resolved as reduce (LANDE < '>').
    Conflict between rule 116 and token LLSHE resolved as reduce (LLSHE < '>').
    Conflict between rule 116 and token LRSHE resolved as reduce (LRSHE < '>').
    Conflict between rule 116 and token LMDE resolved as reduce (LMDE < '>').
    Conflict between rule 116 and token LDVE resolved as reduce (LDVE < '>').
    Conflict between rule 116 and token LMLE resolved as reduce (LMLE < '>').
    Conflict between rule 116 and token LME resolved as reduce (LME < '>').
    Conflict between rule 116 and token LPE resolved as reduce (LPE < '>').
    Conflict between rule 116 and token '?' resolved as reduce ('?' < '>').
    Conflict between rule 116 and token LOROR resolved as reduce (LOROR < '>').
    Conflict between rule 116 and token LANDAND resolved as reduce (LANDAND < '>').
    Conflict between rule 116 and token '|' resolved as reduce ('|' < '>').
    Conflict between rule 116 and token '^' resolved as reduce ('^' < '>').
    Conflict between rule 116 and token '&' resolved as reduce ('&' < '>').
    Conflict between rule 116 and token LNE resolved as reduce (LNE < '>').
    Conflict between rule 116 and token LEQ resolved as reduce (LEQ < '>').
    Conflict between rule 116 and token '<' resolved as reduce (%left '<').
    Conflict between rule 116 and token '>' resolved as reduce (%left '>').
    Conflict between rule 116 and token LGE resolved as reduce (%left LGE).
    Conflict between rule 116 and token LLE resolved as reduce (%left LLE).
    Conflict between rule 116 and token LRSH resolved as shift ('>' < LRSH).
    Conflict between rule 116 and token LLSH resolved as shift ('>' < LLSH).
    Conflict between rule 116 and token '+' resolved as shift ('>' < '+').
    Conflict between rule 116 and token '-' resolved as shift ('>' < '-').
    Conflict between rule 116 and token '*' resolved as shift ('>' < '*').
    Conflict between rule 116 and token '/' resolved as shift ('>' < '/').
    Conflict between rule 116 and token '%' resolved as shift ('>' < '%').


state 254

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  118     | expr LGE expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', '^', '&', LNE, LEQ, '<', '>', LGE, LLE, ')', ']', '}']
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    LRSH  shift, and go to state 180
    LLSH  shift, and go to state 181
    '+'   shift, and go to state 182
    '-'   shift, and go to state 183
    '*'   shift, and go to state 184
    '/'   shift, and go to state 185
    '%'   shift, and go to state 186

    $default  reduce using rule 118 (expr)

    Conflict between rule 118 and token '=' resolved as reduce ('=' < LGE).
    Conflict between rule 118 and token LORE resolved as reduce (LORE < LGE).
    Conflict between rule 118 and token LXORE resolved as reduce (LXORE < LGE).
    Conflict between rule 118 and token LANDE resolved as reduce (LANDE < LGE).
    Conflict between rule 118 and token LLSHE resolved as reduce (LLSHE < LGE).
    Conflict between rule 118 and token LRSHE resolved as reduce (LRSHE < LGE).
    Conflict between rule 118 and token LMDE resolved as reduce (LMDE < LGE).
    Conflict between rule 118 and token LDVE resolved as reduce (LDVE < LGE).
    Conflict between rule 118 and token LMLE resolved as reduce (LMLE < LGE).
    Conflict between rule 118 and token LME resolved as reduce (LME < LGE).
    Conflict between rule 118 and token LPE resolved as reduce (LPE < LGE).
    Conflict between rule 118 and token '?' resolved as reduce ('?' < LGE).
    Conflict between rule 118 and token LOROR resolved as reduce (LOROR < LGE).
    Conflict between rule 118 and token LANDAND resolved as reduce (LANDAND < LGE).
    Conflict between rule 118 and token '|' resolved as reduce ('|' < LGE).
    Conflict between rule 118 and token '^' resolved as reduce ('^' < LGE).
    Conflict between rule 118 and token '&' resolved as reduce ('&' < LGE).
    Conflict between rule 118 and token LNE resolved as reduce (LNE < LGE).
    Conflict between rule 118 and token LEQ resolved as reduce (LEQ < LGE).
    Conflict between rule 118 and token '<' resolved as reduce (%left '<').
    Conflict between rule 118 and token '>' resolved as reduce (%left '>').
    Conflict between rule 118 and token LGE resolved as reduce (%left LGE).
    Conflict between rule 118 and token LLE resolved as reduce (%left LLE).
    Conflict between rule 118 and token LRSH resolved as shift (LGE < LRSH).
    Conflict between rule 118 and token LLSH resolved as shift (LGE < LLSH).
    Conflict between rule 118 and token '+' resolved as shift (LGE < '+').
    Conflict between rule 118 and token '-' resolved as shift (LGE < '-').
    Conflict between rule 118 and token '*' resolved as shift (LGE < '*').
    Conflict between rule 118 and token '/' resolved as shift (LGE < '/').
    Conflict between rule 118 and token '%' resolved as shift (LGE < '%').


state 255

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  117     | expr LLE expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', '^', '&', LNE, LEQ, '<', '>', LGE, LLE, ')', ']', '}']
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    LRSH  shift, and go to state 180
    LLSH  shift, and go to state 181
    '+'   shift, and go to state 182
    '-'   shift, and go to state 183
    '*'   shift, and go to state 184
    '/'   shift, and go to state 185
    '%'   shift, and go to state 186

    $default  reduce using rule 117 (expr)

    Conflict between rule 117 and token '=' resolved as reduce ('=' < LLE).
    Conflict between rule 117 and token LORE resolved as reduce (LORE < LLE).
    Conflict between rule 117 and token LXORE resolved as reduce (LXORE < LLE).
    Conflict between rule 117 and token LANDE resolved as reduce (LANDE < LLE).
    Conflict between rule 117 and token LLSHE resolved as reduce (LLSHE < LLE).
    Conflict between rule 117 and token LRSHE resolved as reduce (LRSHE < LLE).
    Conflict between rule 117 and token LMDE resolved as reduce (LMDE < LLE).
    Conflict between rule 117 and token LDVE resolved as reduce (LDVE < LLE).
    Conflict between rule 117 and token LMLE resolved as reduce (LMLE < LLE).
    Conflict between rule 117 and token LME resolved as reduce (LME < LLE).
    Conflict between rule 117 and token LPE resolved as reduce (LPE < LLE).
    Conflict between rule 117 and token '?' resolved as reduce ('?' < LLE).
    Conflict between rule 117 and token LOROR resolved as reduce (LOROR < LLE).
    Conflict between rule 117 and token LANDAND resolved as reduce (LANDAND < LLE).
    Conflict between rule 117 and token '|' resolved as reduce ('|' < LLE).
    Conflict between rule 117 and token '^' resolved as reduce ('^' < LLE).
    Conflict between rule 117 and token '&' resolved as reduce ('&' < LLE).
    Conflict between rule 117 and token LNE resolved as reduce (LNE < LLE).
    Conflict between rule 117 and token LEQ resolved as reduce (LEQ < LLE).
    Conflict between rule 117 and token '<' resolved as reduce (%left '<').
    Conflict between rule 117 and token '>' resolved as reduce (%left '>').
    Conflict between rule 117 and token LGE resolved as reduce (%left LGE).
    Conflict between rule 117 and token LLE resolved as reduce (%left LLE).
    Conflict between rule 117 and token LRSH resolved as shift (LLE < LRSH).
    Conflict between rule 117 and token LLSH resolved as shift (LLE < LLSH).
    Conflict between rule 117 and token '+' resolved as shift (LLE < '+').
    Conflict between rule 117 and token '-' resolved as shift (LLE < '-').
    Conflict between rule 117 and token '*' resolved as shift (LLE < '*').
    Conflict between rule 117 and token '/' resolved as shift (LLE < '/').
    Conflict between rule 117 and token '%' resolved as shift (LLE < '%').


state 256

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  113     | expr LRSH expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', '^', '&', LNE, LEQ, '<', '>', LGE, LLE, LRSH, LLSH, ')', ']', '}']
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '+'  shift, and go to state 182
    '-'  shift, and go to state 183
    '*'  shift, and go to state 184
    '/'  shift, and go to state 185
    '%'  shift, and go to state 186

    $default  reduce using rule 113 (expr)

    Conflict between rule 113 and token '=' resolved as reduce ('=' < LRSH).
    Conflict between rule 113 and token LORE resolved as reduce (LORE < LRSH).
    Conflict between rule 113 and token LXORE resolved as reduce (LXORE < LRSH).
    Conflict between rule 113 and token LANDE resolved as reduce (LANDE < LRSH).
    Conflict between rule 113 and token LLSHE resolved as reduce (LLSHE < LRSH).
    Conflict between rule 113 and token LRSHE resolved as reduce (LRSHE < LRSH).
    Conflict between rule 113 and token LMDE resolved as reduce (LMDE < LRSH).
    Conflict between rule 113 and token LDVE resolved as reduce (LDVE < LRSH).
    Conflict between rule 113 and token LMLE resolved as reduce (LMLE < LRSH).
    Conflict between rule 113 and token LME resolved as reduce (LME < LRSH).
    Conflict between rule 113 and token LPE resolved as reduce (LPE < LRSH).
    Conflict between rule 113 and token '?' resolved as reduce ('?' < LRSH).
    Conflict between rule 113 and token LOROR resolved as reduce (LOROR < LRSH).
    Conflict between rule 113 and token LANDAND resolved as reduce (LANDAND < LRSH).
    Conflict between rule 113 and token '|' resolved as reduce ('|' < LRSH).
    Conflict between rule 113 and token '^' resolved as reduce ('^' < LRSH).
    Conflict between rule 113 and token '&' resolved as reduce ('&' < LRSH).
    Conflict between rule 113 and token LNE resolved as reduce (LNE < LRSH).
    Conflict between rule 113 and token LEQ resolved as reduce (LEQ < LRSH).
    Conflict between rule 113 and token '<' resolved as reduce ('<' < LRSH).
    Conflict between rule 113 and token '>' resolved as reduce ('>' < LRSH).
    Conflict between rule 113 and token LGE resolved as reduce (LGE < LRSH).
    Conflict between rule 113 and token LLE resolved as reduce (LLE < LRSH).
    Conflict between rule 113 and token LRSH resolved as reduce (%left LRSH).
    Conflict between rule 113 and token LLSH resolved as reduce (%left LLSH).
    Conflict between rule 113 and token '+' resolved as shift (LRSH < '+').
    Conflict between rule 113 and token '-' resolved as shift (LRSH < '-').
    Conflict between rule 113 and token '*' resolved as shift (LRSH < '*').
    Conflict between rule 113 and token '/' resolved as shift (LRSH < '/').
    Conflict between rule 113 and token '%' resolved as shift (LRSH < '%').


state 257

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  114     | expr LLSH expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', '^', '&', LNE, LEQ, '<', '>', LGE, LLE, LRSH, LLSH, ')', ']', '}']
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '+'  shift, and go to state 182
    '-'  shift, and go to state 183
    '*'  shift, and go to state 184
    '/'  shift, and go to state 185
    '%'  shift, and go to state 186

    $default  reduce using rule 114 (expr)

    Conflict between rule 114 and token '=' resolved as reduce ('=' < LLSH).
    Conflict between rule 114 and token LORE resolved as reduce (LORE < LLSH).
    Conflict between rule 114 and token LXORE resolved as reduce (LXORE < LLSH).
    Conflict between rule 114 and token LANDE resolved as reduce (LANDE < LLSH).
    Conflict between rule 114 and token LLSHE resolved as reduce (LLSHE < LLSH).
    Conflict between rule 114 and token LRSHE resolved as reduce (LRSHE < LLSH).
    Conflict between rule 114 and token LMDE resolved as reduce (LMDE < LLSH).
    Conflict between rule 114 and token LDVE resolved as reduce (LDVE < LLSH).
    Conflict between rule 114 and token LMLE resolved as reduce (LMLE < LLSH).
    Conflict between rule 114 and token LME resolved as reduce (LME < LLSH).
    Conflict between rule 114 and token LPE resolved as reduce (LPE < LLSH).
    Conflict between rule 114 and token '?' resolved as reduce ('?' < LLSH).
    Conflict between rule 114 and token LOROR resolved as reduce (LOROR < LLSH).
    Conflict between rule 114 and token LANDAND resolved as reduce (LANDAND < LLSH).
    Conflict between rule 114 and token '|' resolved as reduce ('|' < LLSH).
    Conflict between rule 114 and token '^' resolved as reduce ('^' < LLSH).
    Conflict between rule 114 and token '&' resolved as reduce ('&' < LLSH).
    Conflict between rule 114 and token LNE resolved as reduce (LNE < LLSH).
    Conflict between rule 114 and token LEQ resolved as reduce (LEQ < LLSH).
    Conflict between rule 114 and token '<' resolved as reduce ('<' < LLSH).
    Conflict between rule 114 and token '>' resolved as reduce ('>' < LLSH).
    Conflict between rule 114 and token LGE resolved as reduce (LGE < LLSH).
    Conflict between rule 114 and token LLE resolved as reduce (LLE < LLSH).
    Conflict between rule 114 and token LRSH resolved as reduce (%left LRSH).
    Conflict between rule 114 and token LLSH resolved as reduce (%left LLSH).
    Conflict between rule 114 and token '+' resolved as shift (LLSH < '+').
    Conflict between rule 114 and token '-' resolved as shift (LLSH < '-').
    Conflict between rule 114 and token '*' resolved as shift (LLSH < '*').
    Conflict between rule 114 and token '/' resolved as shift (LLSH < '/').
    Conflict between rule 114 and token '%' resolved as shift (LLSH < '%').


state 258

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  111     | expr '+' expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', '^', '&', LNE, LEQ, '<', '>', LGE, LLE, LRSH, LLSH, '+', '-', ')', ']', '}']
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '*'  shift, and go to state 184
    '/'  shift, and go to state 185
    '%'  shift, and go to state 186

    $default  reduce using rule 111 (expr)

    Conflict between rule 111 and token '=' resolved as reduce ('=' < '+').
    Conflict between rule 111 and token LORE resolved as reduce (LORE < '+').
    Conflict between rule 111 and token LXORE resolved as reduce (LXORE < '+').
    Conflict between rule 111 and token LANDE resolved as reduce (LANDE < '+').
    Conflict between rule 111 and token LLSHE resolved as reduce (LLSHE < '+').
    Conflict between rule 111 and token LRSHE resolved as reduce (LRSHE < '+').
    Conflict between rule 111 and token LMDE resolved as reduce (LMDE < '+').
    Conflict between rule 111 and token LDVE resolved as reduce (LDVE < '+').
    Conflict between rule 111 and token LMLE resolved as reduce (LMLE < '+').
    Conflict between rule 111 and token LME resolved as reduce (LME < '+').
    Conflict between rule 111 and token LPE resolved as reduce (LPE < '+').
    Conflict between rule 111 and token '?' resolved as reduce ('?' < '+').
    Conflict between rule 111 and token LOROR resolved as reduce (LOROR < '+').
    Conflict between rule 111 and token LANDAND resolved as reduce (LANDAND < '+').
    Conflict between rule 111 and token '|' resolved as reduce ('|' < '+').
    Conflict between rule 111 and token '^' resolved as reduce ('^' < '+').
    Conflict between rule 111 and token '&' resolved as reduce ('&' < '+').
    Conflict between rule 111 and token LNE resolved as reduce (LNE < '+').
    Conflict between rule 111 and token LEQ resolved as reduce (LEQ < '+').
    Conflict between rule 111 and token '<' resolved as reduce ('<' < '+').
    Conflict between rule 111 and token '>' resolved as reduce ('>' < '+').
    Conflict between rule 111 and token LGE resolved as reduce (LGE < '+').
    Conflict between rule 111 and token LLE resolved as reduce (LLE < '+').
    Conflict between rule 111 and token LRSH resolved as reduce (LRSH < '+').
    Conflict between rule 111 and token LLSH resolved as reduce (LLSH < '+').
    Conflict between rule 111 and token '+' resolved as reduce (%left '+').
    Conflict between rule 111 and token '-' resolved as reduce (%left '-').
    Conflict between rule 111 and token '*' resolved as shift ('+' < '*').
    Conflict between rule 111 and token '/' resolved as shift ('+' < '/').
    Conflict between rule 111 and token '%' resolved as shift ('+' < '%').


state 259

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  112     | expr '-' expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', '^', '&', LNE, LEQ, '<', '>', LGE, LLE, LRSH, LLSH, '+', '-', ')', ']', '}']
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '*'  shift, and go to state 184
    '/'  shift, and go to state 185
    '%'  shift, and go to state 186

    $default  reduce using rule 112 (expr)

    Conflict between rule 112 and token '=' resolved as reduce ('=' < '-').
    Conflict between rule 112 and token LORE resolved as reduce (LORE < '-').
    Conflict between rule 112 and token LXORE resolved as reduce (LXORE < '-').
    Conflict between rule 112 and token LANDE resolved as reduce (LANDE < '-').
    Conflict between rule 112 and token LLSHE resolved as reduce (LLSHE < '-').
    Conflict between rule 112 and token LRSHE resolved as reduce (LRSHE < '-').
    Conflict between rule 112 and token LMDE resolved as reduce (LMDE < '-').
    Conflict between rule 112 and token LDVE resolved as reduce (LDVE < '-').
    Conflict between rule 112 and token LMLE resolved as reduce (LMLE < '-').
    Conflict between rule 112 and token LME resolved as reduce (LME < '-').
    Conflict between rule 112 and token LPE resolved as reduce (LPE < '-').
    Conflict between rule 112 and token '?' resolved as reduce ('?' < '-').
    Conflict between rule 112 and token LOROR resolved as reduce (LOROR < '-').
    Conflict between rule 112 and token LANDAND resolved as reduce (LANDAND < '-').
    Conflict between rule 112 and token '|' resolved as reduce ('|' < '-').
    Conflict between rule 112 and token '^' resolved as reduce ('^' < '-').
    Conflict between rule 112 and token '&' resolved as reduce ('&' < '-').
    Conflict between rule 112 and token LNE resolved as reduce (LNE < '-').
    Conflict between rule 112 and token LEQ resolved as reduce (LEQ < '-').
    Conflict between rule 112 and token '<' resolved as reduce ('<' < '-').
    Conflict between rule 112 and token '>' resolved as reduce ('>' < '-').
    Conflict between rule 112 and token LGE resolved as reduce (LGE < '-').
    Conflict between rule 112 and token LLE resolved as reduce (LLE < '-').
    Conflict between rule 112 and token LRSH resolved as reduce (LRSH < '-').
    Conflict between rule 112 and token LLSH resolved as reduce (LLSH < '-').
    Conflict between rule 112 and token '+' resolved as reduce (%left '+').
    Conflict between rule 112 and token '-' resolved as reduce (%left '-').
    Conflict between rule 112 and token '*' resolved as shift ('-' < '*').
    Conflict between rule 112 and token '/' resolved as shift ('-' < '/').
    Conflict between rule 112 and token '%' resolved as shift ('-' < '%').


state 260

  108 expr: expr . '*' expr
  108     | expr '*' expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', '^', '&', LNE, LEQ, '<', '>', LGE, LLE, LRSH, LLSH, '+', '-', '*', '/', '%', ')', ']', '}']
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    $default  reduce using rule 108 (expr)

    Conflict between rule 108 and token '=' resolved as reduce ('=' < '*').
    Conflict between rule 108 and token LORE resolved as reduce (LORE < '*').
    Conflict between rule 108 and token LXORE resolved as reduce (LXORE < '*').
    Conflict between rule 108 and token LANDE resolved as reduce (LANDE < '*').
    Conflict between rule 108 and token LLSHE resolved as reduce (LLSHE < '*').
    Conflict between rule 108 and token LRSHE resolved as reduce (LRSHE < '*').
    Conflict between rule 108 and token LMDE resolved as reduce (LMDE < '*').
    Conflict between rule 108 and token LDVE resolved as reduce (LDVE < '*').
    Conflict between rule 108 and token LMLE resolved as reduce (LMLE < '*').
    Conflict between rule 108 and token LME resolved as reduce (LME < '*').
    Conflict between rule 108 and token LPE resolved as reduce (LPE < '*').
    Conflict between rule 108 and token '?' resolved as reduce ('?' < '*').
    Conflict between rule 108 and token LOROR resolved as reduce (LOROR < '*').
    Conflict between rule 108 and token LANDAND resolved as reduce (LANDAND < '*').
    Conflict between rule 108 and token '|' resolved as reduce ('|' < '*').
    Conflict between rule 108 and token '^' resolved as reduce ('^' < '*').
    Conflict between rule 108 and token '&' resolved as reduce ('&' < '*').
    Conflict between rule 108 and token LNE resolved as reduce (LNE < '*').
    Conflict between rule 108 and token LEQ resolved as reduce (LEQ < '*').
    Conflict between rule 108 and token '<' resolved as reduce ('<' < '*').
    Conflict between rule 108 and token '>' resolved as reduce ('>' < '*').
    Conflict between rule 108 and token LGE resolved as reduce (LGE < '*').
    Conflict between rule 108 and token LLE resolved as reduce (LLE < '*').
    Conflict between rule 108 and token LRSH resolved as reduce (LRSH < '*').
    Conflict between rule 108 and token LLSH resolved as reduce (LLSH < '*').
    Conflict between rule 108 and token '+' resolved as reduce ('+' < '*').
    Conflict between rule 108 and token '-' resolved as reduce ('-' < '*').
    Conflict between rule 108 and token '*' resolved as reduce (%left '*').
    Conflict between rule 108 and token '/' resolved as reduce (%left '/').
    Conflict between rule 108 and token '%' resolved as reduce (%left '%').


state 261

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  109     | expr '/' expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', '^', '&', LNE, LEQ, '<', '>', LGE, LLE, LRSH, LLSH, '+', '-', '*', '/', '%', ')', ']', '}']
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    $default  reduce using rule 109 (expr)

    Conflict between rule 109 and token '=' resolved as reduce ('=' < '/').
    Conflict between rule 109 and token LORE resolved as reduce (LORE < '/').
    Conflict between rule 109 and token LXORE resolved as reduce (LXORE < '/').
    Conflict between rule 109 and token LANDE resolved as reduce (LANDE < '/').
    Conflict between rule 109 and token LLSHE resolved as reduce (LLSHE < '/').
    Conflict between rule 109 and token LRSHE resolved as reduce (LRSHE < '/').
    Conflict between rule 109 and token LMDE resolved as reduce (LMDE < '/').
    Conflict between rule 109 and token LDVE resolved as reduce (LDVE < '/').
    Conflict between rule 109 and token LMLE resolved as reduce (LMLE < '/').
    Conflict between rule 109 and token LME resolved as reduce (LME < '/').
    Conflict between rule 109 and token LPE resolved as reduce (LPE < '/').
    Conflict between rule 109 and token '?' resolved as reduce ('?' < '/').
    Conflict between rule 109 and token LOROR resolved as reduce (LOROR < '/').
    Conflict between rule 109 and token LANDAND resolved as reduce (LANDAND < '/').
    Conflict between rule 109 and token '|' resolved as reduce ('|' < '/').
    Conflict between rule 109 and token '^' resolved as reduce ('^' < '/').
    Conflict between rule 109 and token '&' resolved as reduce ('&' < '/').
    Conflict between rule 109 and token LNE resolved as reduce (LNE < '/').
    Conflict between rule 109 and token LEQ resolved as reduce (LEQ < '/').
    Conflict between rule 109 and token '<' resolved as reduce ('<' < '/').
    Conflict between rule 109 and token '>' resolved as reduce ('>' < '/').
    Conflict between rule 109 and token LGE resolved as reduce (LGE < '/').
    Conflict between rule 109 and token LLE resolved as reduce (LLE < '/').
    Conflict between rule 109 and token LRSH resolved as reduce (LRSH < '/').
    Conflict between rule 109 and token LLSH resolved as reduce (LLSH < '/').
    Conflict between rule 109 and token '+' resolved as reduce ('+' < '/').
    Conflict between rule 109 and token '-' resolved as reduce ('-' < '/').
    Conflict between rule 109 and token '*' resolved as reduce (%left '*').
    Conflict between rule 109 and token '/' resolved as reduce (%left '/').
    Conflict between rule 109 and token '%' resolved as reduce (%left '%').


state 262

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  110     | expr '%' expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', ':', LOROR, LANDAND, '|', '^', '&', LNE, LEQ, '<', '>', LGE, LLE, LRSH, LLSH, '+', '-', '*', '/', '%', ')', ']', '}']
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    $default  reduce using rule 110 (expr)

    Conflict between rule 110 and token '=' resolved as reduce ('=' < '%').
    Conflict between rule 110 and token LORE resolved as reduce (LORE < '%').
    Conflict between rule 110 and token LXORE resolved as reduce (LXORE < '%').
    Conflict between rule 110 and token LANDE resolved as reduce (LANDE < '%').
    Conflict between rule 110 and token LLSHE resolved as reduce (LLSHE < '%').
    Conflict between rule 110 and token LRSHE resolved as reduce (LRSHE < '%').
    Conflict between rule 110 and token LMDE resolved as reduce (LMDE < '%').
    Conflict between rule 110 and token LDVE resolved as reduce (LDVE < '%').
    Conflict between rule 110 and token LMLE resolved as reduce (LMLE < '%').
    Conflict between rule 110 and token LME resolved as reduce (LME < '%').
    Conflict between rule 110 and token LPE resolved as reduce (LPE < '%').
    Conflict between rule 110 and token '?' resolved as reduce ('?' < '%').
    Conflict between rule 110 and token LOROR resolved as reduce (LOROR < '%').
    Conflict between rule 110 and token LANDAND resolved as reduce (LANDAND < '%').
    Conflict between rule 110 and token '|' resolved as reduce ('|' < '%').
    Conflict between rule 110 and token '^' resolved as reduce ('^' < '%').
    Conflict between rule 110 and token '&' resolved as reduce ('&' < '%').
    Conflict between rule 110 and token LNE resolved as reduce (LNE < '%').
    Conflict between rule 110 and token LEQ resolved as reduce (LEQ < '%').
    Conflict between rule 110 and token '<' resolved as reduce ('<' < '%').
    Conflict between rule 110 and token '>' resolved as reduce ('>' < '%').
    Conflict between rule 110 and token LGE resolved as reduce (LGE < '%').
    Conflict between rule 110 and token LLE resolved as reduce (LLE < '%').
    Conflict between rule 110 and token LRSH resolved as reduce (LRSH < '%').
    Conflict between rule 110 and token LLSH resolved as reduce (LLSH < '%').
    Conflict between rule 110 and token '+' resolved as reduce ('+' < '%').
    Conflict between rule 110 and token '-' resolved as reduce ('-' < '%').
    Conflict between rule 110 and token '*' resolved as reduce (%left '*').
    Conflict between rule 110 and token '/' resolved as reduce (%left '/').
    Conflict between rule 110 and token '%' resolved as reduce (%left '%').


state 263

  158 pexpr: pexpr '.' ltag .

    $default  reduce using rule 158 (pexpr)


state 264

  106 cexpr: cexpr . ',' cexpr
  156 pexpr: pexpr '[' cexpr . ']'

    ','  shift, and go to state 226
    ']'  shift, and go to state 299


state 265

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr
  178 elist: expr .  [',', ')']

    '='      shift, and go to state 157
    LORE     shift, and go to state 158
    LXORE    shift, and go to state 159
    LANDE    shift, and go to state 160
    LLSHE    shift, and go to state 161
    LRSHE    shift, and go to state 162
    LMDE     shift, and go to state 163
    LDVE     shift, and go to state 164
    LMLE     shift, and go to state 165
    LME      shift, and go to state 166
    LPE      shift, and go to state 167
    '?'      shift, and go to state 168
    LOROR    shift, and go to state 169
    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186

    $default  reduce using rule 178 (elist)


state 266

  155 pexpr: pexpr '(' zelist . ')'

    ')'  shift, and go to state 300


state 267

  177 zelist: elist .  [')']
  179 elist: elist . ',' elist

    ','  shift, and go to state 301

    $default  reduce using rule 177 (zelist)


state 268

  157 pexpr: pexpr LMG ltag .

    $default  reduce using rule 157 (pexpr)


state 269

   67 arglist: '.' '.' '.' .

    $default  reduce using rule 67 (arglist)


state 270

   68 arglist: arglist . ',' arglist
   68        | arglist ',' arglist .  [',', ')']

    $default  reduce using rule 68 (arglist)

    Conflict between rule 68 and token ',' resolved as reduce (%left ',').


state 271

   12 xdecor: . xdecor2
   13       | . '*' zgnlist xdecor
   13       | '*' zgnlist . xdecor
   14 xdecor2: . tag
   15        | . '(' xdecor ')'
   16        | . xdecor2 '(' zarglist ')'
   17        | . xdecor2 '[' zexpr ']'
   41 abdecor1: . '*' zgnlist
   41         | '*' zgnlist .  [',', ')']
   42         | . '*' zgnlist abdecor1
   42         | '*' zgnlist . abdecor1
   43         | . abdecor2
   44 abdecor2: . abdecor3
   45         | . abdecor2 '(' zarglist ')'
   46         | . abdecor2 '[' zexpr ']'
   47 abdecor3: . '(' ')'
   48         | . '[' zexpr ']'
   49         | . '(' abdecor1 ')'
  212 zgnlist: zgnlist . gname
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT
  244 tag: . ltag
  245 ltag: . LNAME
  246     | . LTYPE

    '*'        shift, and go to state 198
    '['        shift, and go to state 199
    '('        shift, and go to state 200
    LNAME      shift, and go to state 36
    LTYPE      shift, and go to state 37
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LRESTRICT  shift, and go to state 24

    $default  reduce using rule 41 (abdecor1)

    xdecor    go to state 86
    xdecor2   go to state 50
    abdecor1  go to state 302
    abdecor2  go to state 204
    abdecor3  go to state 205
    gname     go to state 87
    tag       go to state 51
    ltag      go to state 52


state 272

   48 abdecor3: '[' zexpr . ']'

    ']'  shift, and go to state 303


state 273

   47 abdecor3: '(' ')' .

    $default  reduce using rule 47 (abdecor3)


state 274

   49 abdecor3: '(' abdecor1 . ')'

    ')'  shift, and go to state 304


state 275

   46 abdecor2: abdecor2 '[' . zexpr ']'
  102 zexpr: .  [']']
  103      | . lexpr
  104 lexpr: . expr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    $default  reduce using rule 102 (zexpr)

    zexpr    go to state 305
    lexpr    go to state 116
    expr     go to state 117
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 276

   45 abdecor2: abdecor2 '(' . zarglist ')'
   62 zarglist: .  [')']
   63         | . arglist
   64 arglist: . name
   65        | . tlist abdecor
   66        | . tlist xdecor
   67        | . '.' '.' '.'
   68        | . arglist ',' arglist
  184 types: . complex
  185      | . tname
  186      | . gcnlist
  187      | . complex gctnlist
  188      | . tname gctnlist
  189      | . gcnlist complex zgnlist
  190      | . gcnlist tname
  191      | . gcnlist tname gctnlist
  192 tlist: . types
  194 complex: . LSTRUCT ltag
  196        | . LSTRUCT ltag $@10 sbody
  197        | . LSTRUCT sbody
  198        | . LUNION ltag
  200        | . LUNION ltag $@11 sbody
  201        | . LUNION sbody
  202        | . LENUM ltag
  205        | . LENUM ltag $@12 '{' $@13 enum '}'
  207        | . LENUM '{' $@14 enum '}'
  208        | . LTYPE
  216 gcnlist: . gcname
  217        | . gcnlist gcname
  218 gcname: . gname
  219       | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT
  243 name: . LNAME

    '.'        shift, and go to state 124
    LNAME      shift, and go to state 100
    LTYPE      shift, and go to state 3
    LAUTO      shift, and go to state 4
    LCHAR      shift, and go to state 5
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LREGISTER  shift, and go to state 11
    LSHORT     shift, and go to state 12
    LSTATIC    shift, and go to state 13
    LSTRUCT    shift, and go to state 14
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNION     shift, and go to state 17
    LUNSIGNED  shift, and go to state 18
    LVOID      shift, and go to state 19
    LENUM      shift, and go to state 20
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25

    $default  reduce using rule 62 (zarglist)

    zarglist  go to state 306
    arglist   go to state 126
    types     go to state 79
    tlist     go to state 127
    complex   go to state 30
    gcnlist   go to state 31
    gcname    go to state 32
    tname     go to state 33
    cname     go to state 34
    gname     go to state 35
    name      go to state 128


state 277

   31 edecl: edecl tlist $@6 zedlist . ';'

    ';'  shift, and go to state 307


state 278

   38 edecor: ':' lexpr .

    $default  reduce using rule 38 (edecor)


state 279

   29 edecl: tlist $@5 zedlist ';' .

    $default  reduce using rule 29 (edecl)


state 280

   12 xdecor: . xdecor2
   13       | . '*' zgnlist xdecor
   14 xdecor2: . tag
   15        | . '(' xdecor ')'
   16        | . xdecor2 '(' zarglist ')'
   17        | . xdecor2 '[' zexpr ']'
   34 edlist: . edecor
   35       | . edlist ',' edlist
   35       | edlist ',' . edlist
   36 edecor: . xdecor
   37       | . tag ':' lexpr
   38       | . ':' lexpr
  244 tag: . ltag
  245 ltag: . LNAME
  246     | . LTYPE

    ':'    shift, and go to state 207
    '*'    shift, and go to state 46
    '('    shift, and go to state 47
    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37

    xdecor   go to state 208
    xdecor2  go to state 50
    edlist   go to state 308
    edecor   go to state 211
    tag      go to state 212
    ltag     go to state 52


state 281

   37 edecor: tag ':' . lexpr
  104 lexpr: . expr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    lexpr    go to state 309
    expr     go to state 117
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 282

  205 complex: LENUM ltag $@12 '{' $@13 enum '}' .

    $default  reduce using rule 205 (complex)


state 283

   18 adecl: . ctlist ';'
   19      | . ctlist adlist ';'
   69 block: '{' slist . '}'
   71 slist: slist . adecl
   72      | slist . stmnt
   73 labels: . label
   74       | . labels label
   75 label: . LCASE expr ':'
   76      | . LDEFAULT ':'
   77      | . LNAME ':'
   78 stmnt: . error ';'
   79      | . ulstmnt
   80      | . labels ulstmnt
   83 ulstmnt: . zcexpr ';'
   84 $@7: .  ['{']
   85 ulstmnt: . $@7 block
   86        | . LIF '(' cexpr ')' stmnt
   87        | . LIF '(' cexpr ')' stmnt LELSE stmnt
   88 $@8: .  [LFOR]
   89 ulstmnt: . $@8 LFOR '(' forexpr ';' zcexpr ';' zcexpr ')' stmnt
   90        | . LWHILE '(' cexpr ')' stmnt
   91        | . LDO stmnt LWHILE '(' cexpr ')' ';'
   92        | . LRETURN zcexpr ';'
   93        | . LSWITCH '(' cexpr ')' stmnt
   94        | . LBREAK ';'
   95        | . LCONTINUE ';'
   96        | . LGOTO ltag ';'
   97        | . LUSED '(' zelist ')' ';'
   98        | . LPREFETCH '(' zelist ')' ';'
   99        | . LSET '(' zelist ')' ';'
  100 zcexpr: .  [';']
  101       | . cexpr
  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  184 types: . complex
  185      | . tname
  186      | . gcnlist
  187      | . complex gctnlist
  188      | . tname gctnlist
  189      | . gcnlist complex zgnlist
  190      | . gcnlist tname
  191      | . gcnlist tname gctnlist
  193 ctlist: . types
  194 complex: . LSTRUCT ltag
  196        | . LSTRUCT ltag $@10 sbody
  197        | . LSTRUCT sbody
  198        | . LUNION ltag
  200        | . LUNION ltag $@11 sbody
  201        | . LUNION sbody
  202        | . LENUM ltag
  205        | . LENUM ltag $@12 '{' $@13 enum '}'
  207        | . LENUM '{' $@14 enum '}'
  208        | . LTYPE
  216 gcnlist: . gcname
  217        | . gcnlist gcname
  218 gcname: . gname
  219       | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT
  243 name: . LNAME

    error      shift, and go to state 310
    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 311
    LTYPE      shift, and go to state 3
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LAUTO      shift, and go to state 4
    LBREAK     shift, and go to state 312
    LCASE      shift, and go to state 313
    LCHAR      shift, and go to state 5
    LCONTINUE  shift, and go to state 314
    LDEFAULT   shift, and go to state 315
    LDO        shift, and go to state 316
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LGOTO      shift, and go to state 317
    LIF        shift, and go to state 318
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LPREFETCH  shift, and go to state 319
    LREGISTER  shift, and go to state 11
    LRETURN    shift, and go to state 320
    LSHORT     shift, and go to state 12
    LSIZEOF    shift, and go to state 111
    LUSED      shift, and go to state 321
    LSTATIC    shift, and go to state 13
    LSTRUCT    shift, and go to state 14
    LSWITCH    shift, and go to state 322
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNION     shift, and go to state 17
    LUNSIGNED  shift, and go to state 18
    LWHILE     shift, and go to state 323
    LVOID      shift, and go to state 19
    LENUM      shift, and go to state 20
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LSET       shift, and go to state 324
    LSIGNOF    shift, and go to state 112
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25
    '}'        shift, and go to state 325
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    ';'   reduce using rule 100 (zcexpr)
    LFOR  reduce using rule 88 ($@8)
    '{'   reduce using rule 84 ($@7)

    adecl    go to state 326
    labels   go to state 327
    label    go to state 328
    stmnt    go to state 329
    ulstmnt  go to state 330
    $@7      go to state 331
    $@8      go to state 332
    zcexpr   go to state 333
    cexpr    go to state 334
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    types    go to state 28
    ctlist   go to state 335
    complex  go to state 30
    gcnlist  go to state 31
    gcname   go to state 32
    tname    go to state 33
    cname    go to state 34
    gname    go to state 35
    name     go to state 123


state 284

   25 pdecl: pdecl ctlist pdlist ';' .

    $default  reduce using rule 25 (pdecl)


state 285

   12 xdecor: . xdecor2
   13       | . '*' zgnlist xdecor
   14 xdecor2: . tag
   15        | . '(' xdecor ')'
   16        | . xdecor2 '(' zarglist ')'
   17        | . xdecor2 '[' zexpr ']'
   26 pdlist: . xdecor
   27       | . pdlist ',' pdlist
   27       | pdlist ',' . pdlist
  244 tag: . ltag
  245 ltag: . LNAME
  246     | . LTYPE

    '*'    shift, and go to state 46
    '('    shift, and go to state 47
    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37

    xdecor   go to state 218
    xdecor2  go to state 50
    pdlist   go to state 336
    tag      go to state 51
    ltag     go to state 52


state 286

   53 qual: '.' ltag .

    $default  reduce using rule 53 (qual)


state 287

   52 qual: '[' lexpr . ']'

    ']'  shift, and go to state 337


state 288

   55 qlist: init ',' .

    $default  reduce using rule 55 (qlist)


state 289

   54 qual: qual '=' .

    $default  reduce using rule 54 (qual)


state 290

   56 qlist: qlist init . ','
   61 ilist: qlist init .  ['}']

    ','  shift, and go to state 338

    $default  reduce using rule 61 (ilist)


state 291

   54 qual: qual . '='
   58 qlist: qlist qual .  ['&', '+', '-', '*', '.', '[', '(', LPP, LMM, LNAME, LFCONST, LDCONST, LCONST, LLCONST, LUCONST, LULCONST, LVLCONST, LUVLCONST, LSTRING, LLSTRING, LSIZEOF, LSIGNOF, '{', '}', '!', '~']

    '='  shift, and go to state 289

    $default  reduce using rule 58 (qlist)


state 292

   51 init: '{' ilist '}' .

    $default  reduce using rule 51 (init)


state 293

  106 cexpr: cexpr . ',' cexpr
  106      | cexpr ',' cexpr .  [';', ',', ':', ')', ']']

    $default  reduce using rule 106 (cexpr)

    Conflict between rule 106 and token ',' resolved as reduce (%left ',').


state 294

   41 abdecor1: . '*' zgnlist
   41         | '*' zgnlist .  [')']
   42         | . '*' zgnlist abdecor1
   42         | '*' zgnlist . abdecor1
   43         | . abdecor2
   44 abdecor2: . abdecor3
   45         | . abdecor2 '(' zarglist ')'
   46         | . abdecor2 '[' zexpr ']'
   47 abdecor3: . '(' ')'
   48         | . '[' zexpr ']'
   49         | . '(' abdecor1 ')'
  212 zgnlist: zgnlist . gname
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT

    '*'        shift, and go to state 228
    '['        shift, and go to state 199
    '('        shift, and go to state 229
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LRESTRICT  shift, and go to state 24

    $default  reduce using rule 41 (abdecor1)

    abdecor1  go to state 302
    abdecor2  go to state 204
    abdecor3  go to state 205
    gname     go to state 87


state 295

  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  139       | '(' tlist abdecor ')' . xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  140       | '(' tlist abdecor ')' . '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '{'        shift, and go to state 339
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    xuexpr   go to state 340
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 296

  153 pexpr: LSIZEOF '(' tlist abdecor . ')'

    ')'  shift, and go to state 341


state 297

  154 pexpr: LSIGNOF '(' tlist abdecor . ')'

    ')'  shift, and go to state 342


state 298

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  126     | expr '?' cexpr ':' . expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 343
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 299

  156 pexpr: pexpr '[' cexpr ']' .

    $default  reduce using rule 156 (pexpr)


state 300

  155 pexpr: pexpr '(' zelist ')' .

    $default  reduce using rule 155 (pexpr)


state 301

  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  178 elist: . expr
  179      | . elist ',' elist
  179      | elist ',' . elist
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 265
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    elist    go to state 344
    name     go to state 123


state 302

   42 abdecor1: '*' zgnlist abdecor1 .

    $default  reduce using rule 42 (abdecor1)


state 303

   48 abdecor3: '[' zexpr ']' .

    $default  reduce using rule 48 (abdecor3)


state 304

   49 abdecor3: '(' abdecor1 ')' .

    $default  reduce using rule 49 (abdecor3)


state 305

   46 abdecor2: abdecor2 '[' zexpr . ']'

    ']'  shift, and go to state 345


state 306

   45 abdecor2: abdecor2 '(' zarglist . ')'

    ')'  shift, and go to state 346


state 307

   31 edecl: edecl tlist $@6 zedlist ';' .

    $default  reduce using rule 31 (edecl)


state 308

   35 edlist: edlist . ',' edlist
   35       | edlist ',' edlist .  [';', ',']

    $default  reduce using rule 35 (edlist)

    Conflict between rule 35 and token ',' resolved as reduce (%left ',').


state 309

   37 edecor: tag ':' lexpr .

    $default  reduce using rule 37 (edecor)


state 310

   78 stmnt: error . ';'

    ';'  shift, and go to state 347


state 311

   77 label: LNAME . ':'
  243 name: LNAME .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, '?', LOROR, LANDAND, '|', '^', '&', LNE, LEQ, '<', '>', LGE, LLE, LRSH, LLSH, '+', '-', '*', '/', '%', '.', '[', '(', LMG, LPP, LMM]

    ':'  shift, and go to state 348

    $default  reduce using rule 243 (name)


state 312

   94 ulstmnt: LBREAK . ';'

    ';'  shift, and go to state 349


state 313

   75 label: LCASE . expr ':'
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    expr     go to state 350
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 314

   95 ulstmnt: LCONTINUE . ';'

    ';'  shift, and go to state 351


state 315

   76 label: LDEFAULT . ':'

    ':'  shift, and go to state 352


state 316

   73 labels: . label
   74       | . labels label
   75 label: . LCASE expr ':'
   76      | . LDEFAULT ':'
   77      | . LNAME ':'
   78 stmnt: . error ';'
   79      | . ulstmnt
   80      | . labels ulstmnt
   83 ulstmnt: . zcexpr ';'
   84 $@7: .  ['{']
   85 ulstmnt: . $@7 block
   86        | . LIF '(' cexpr ')' stmnt
   87        | . LIF '(' cexpr ')' stmnt LELSE stmnt
   88 $@8: .  [LFOR]
   89 ulstmnt: . $@8 LFOR '(' forexpr ';' zcexpr ';' zcexpr ')' stmnt
   90        | . LWHILE '(' cexpr ')' stmnt
   91        | . LDO stmnt LWHILE '(' cexpr ')' ';'
   91        | LDO . stmnt LWHILE '(' cexpr ')' ';'
   92        | . LRETURN zcexpr ';'
   93        | . LSWITCH '(' cexpr ')' stmnt
   94        | . LBREAK ';'
   95        | . LCONTINUE ';'
   96        | . LGOTO ltag ';'
   97        | . LUSED '(' zelist ')' ';'
   98        | . LPREFETCH '(' zelist ')' ';'
   99        | . LSET '(' zelist ')' ';'
  100 zcexpr: .  [';']
  101       | . cexpr
  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    error      shift, and go to state 310
    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 311
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LBREAK     shift, and go to state 312
    LCASE      shift, and go to state 313
    LCONTINUE  shift, and go to state 314
    LDEFAULT   shift, and go to state 315
    LDO        shift, and go to state 316
    LGOTO      shift, and go to state 317
    LIF        shift, and go to state 318
    LPREFETCH  shift, and go to state 319
    LRETURN    shift, and go to state 320
    LSIZEOF    shift, and go to state 111
    LUSED      shift, and go to state 321
    LSWITCH    shift, and go to state 322
    LWHILE     shift, and go to state 323
    LSET       shift, and go to state 324
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    ';'   reduce using rule 100 (zcexpr)
    LFOR  reduce using rule 88 ($@8)
    '{'   reduce using rule 84 ($@7)

    labels   go to state 327
    label    go to state 328
    stmnt    go to state 353
    ulstmnt  go to state 330
    $@7      go to state 331
    $@8      go to state 332
    zcexpr   go to state 333
    cexpr    go to state 334
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 317

   96 ulstmnt: LGOTO . ltag ';'
  245 ltag: . LNAME
  246     | . LTYPE

    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37

    ltag  go to state 354


state 318

   86 ulstmnt: LIF . '(' cexpr ')' stmnt
   87        | LIF . '(' cexpr ')' stmnt LELSE stmnt

    '('  shift, and go to state 355


state 319

   98 ulstmnt: LPREFETCH . '(' zelist ')' ';'

    '('  shift, and go to state 356


state 320

   92 ulstmnt: LRETURN . zcexpr ';'
  100 zcexpr: .  [';']
  101       | . cexpr
  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    $default  reduce using rule 100 (zcexpr)

    zcexpr   go to state 357
    cexpr    go to state 334
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 321

   97 ulstmnt: LUSED . '(' zelist ')' ';'

    '('  shift, and go to state 358


state 322

   93 ulstmnt: LSWITCH . '(' cexpr ')' stmnt

    '('  shift, and go to state 359


state 323

   90 ulstmnt: LWHILE . '(' cexpr ')' stmnt

    '('  shift, and go to state 360


state 324

   99 ulstmnt: LSET . '(' zelist ')' ';'

    '('  shift, and go to state 361


state 325

   69 block: '{' slist '}' .

    $default  reduce using rule 69 (block)


state 326

   71 slist: slist adecl .

    $default  reduce using rule 71 (slist)


state 327

   74 labels: labels . label
   75 label: . LCASE expr ':'
   76      | . LDEFAULT ':'
   77      | . LNAME ':'
   80 stmnt: labels . ulstmnt
   83 ulstmnt: . zcexpr ';'
   84 $@7: .  ['{']
   85 ulstmnt: . $@7 block
   86        | . LIF '(' cexpr ')' stmnt
   87        | . LIF '(' cexpr ')' stmnt LELSE stmnt
   88 $@8: .  [LFOR]
   89 ulstmnt: . $@8 LFOR '(' forexpr ';' zcexpr ';' zcexpr ')' stmnt
   90        | . LWHILE '(' cexpr ')' stmnt
   91        | . LDO stmnt LWHILE '(' cexpr ')' ';'
   92        | . LRETURN zcexpr ';'
   93        | . LSWITCH '(' cexpr ')' stmnt
   94        | . LBREAK ';'
   95        | . LCONTINUE ';'
   96        | . LGOTO ltag ';'
   97        | . LUSED '(' zelist ')' ';'
   98        | . LPREFETCH '(' zelist ')' ';'
   99        | . LSET '(' zelist ')' ';'
  100 zcexpr: .  [';']
  101       | . cexpr
  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 311
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LBREAK     shift, and go to state 312
    LCASE      shift, and go to state 313
    LCONTINUE  shift, and go to state 314
    LDEFAULT   shift, and go to state 315
    LDO        shift, and go to state 316
    LGOTO      shift, and go to state 317
    LIF        shift, and go to state 318
    LPREFETCH  shift, and go to state 319
    LRETURN    shift, and go to state 320
    LSIZEOF    shift, and go to state 111
    LUSED      shift, and go to state 321
    LSWITCH    shift, and go to state 322
    LWHILE     shift, and go to state 323
    LSET       shift, and go to state 324
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    ';'       reduce using rule 100 (zcexpr)
    LFOR      reduce using rule 88 ($@8)
    $default  reduce using rule 84 ($@7)

    label    go to state 362
    ulstmnt  go to state 363
    $@7      go to state 331
    $@8      go to state 332
    zcexpr   go to state 333
    cexpr    go to state 334
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 328

   73 labels: label .

    $default  reduce using rule 73 (labels)


state 329

   72 slist: slist stmnt .

    $default  reduce using rule 72 (slist)


state 330

   79 stmnt: ulstmnt .

    $default  reduce using rule 79 (stmnt)


state 331

   69 block: . '{' slist '}'
   85 ulstmnt: $@7 . block

    '{'  shift, and go to state 216

    block  go to state 364


state 332

   89 ulstmnt: $@8 . LFOR '(' forexpr ';' zcexpr ';' zcexpr ')' stmnt

    LFOR  shift, and go to state 365


state 333

   83 ulstmnt: zcexpr . ';'

    ';'  shift, and go to state 366


state 334

  101 zcexpr: cexpr .  [';', ')']
  106 cexpr: cexpr . ',' cexpr

    ','  shift, and go to state 226

    $default  reduce using rule 101 (zcexpr)


state 335

   12 xdecor: . xdecor2
   13       | . '*' zgnlist xdecor
   14 xdecor2: . tag
   15        | . '(' xdecor ')'
   16        | . xdecor2 '(' zarglist ')'
   17        | . xdecor2 '[' zexpr ']'
   18 adecl: ctlist . ';'
   19      | ctlist . adlist ';'
   20 adlist: . xdecor
   22       | . xdecor $@4 '=' init
   23       | . adlist ',' adlist
  244 tag: . ltag
  245 ltag: . LNAME
  246     | . LTYPE

    ';'    shift, and go to state 367
    '*'    shift, and go to state 46
    '('    shift, and go to state 47
    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37

    xdecor   go to state 368
    xdecor2  go to state 50
    adlist   go to state 369
    tag      go to state 51
    ltag     go to state 52


state 336

   27 pdlist: pdlist . ',' pdlist
   27       | pdlist ',' pdlist .  [';', ',']

    $default  reduce using rule 27 (pdlist)

    Conflict between rule 27 and token ',' resolved as reduce (%left ',').


state 337

   52 qual: '[' lexpr ']' .

    $default  reduce using rule 52 (qual)


state 338

   56 qlist: qlist init ',' .

    $default  reduce using rule 56 (qlist)


state 339

   50 init: . expr
   51     | . '{' ilist '}'
   52 qual: . '[' lexpr ']'
   53     | . '.' ltag
   54     | . qual '='
   55 qlist: . init ','
   56      | . qlist init ','
   57      | . qual
   58      | . qlist qual
   59 ilist: . qlist
   60      | . init
   61      | . qlist init
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  140       | '(' tlist abdecor ')' '{' . ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '.'        shift, and go to state 220
    '['        shift, and go to state 221
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '{'        shift, and go to state 138
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    init     go to state 222
    qual     go to state 223
    qlist    go to state 224
    ilist    go to state 370
    expr     go to state 140
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 340

  139 xuexpr: '(' tlist abdecor ')' xuexpr .

    $default  reduce using rule 139 (xuexpr)


state 341

  153 pexpr: LSIZEOF '(' tlist abdecor ')' .

    $default  reduce using rule 153 (pexpr)


state 342

  154 pexpr: LSIGNOF '(' tlist abdecor ')' .

    $default  reduce using rule 154 (pexpr)


state 343

  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  126     | expr '?' cexpr ':' expr .  [';', ',', '=', LORE, LXORE, LANDE, LLSHE, LRSHE, LMDE, LDVE, LMLE, LME, LPE, ':', ')', ']', '}']
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '?'      shift, and go to state 168
    LOROR    shift, and go to state 169
    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186

    $default  reduce using rule 126 (expr)

    Conflict between rule 126 and token '=' resolved as reduce ('=' < ':').
    Conflict between rule 126 and token LORE resolved as reduce (LORE < ':').
    Conflict between rule 126 and token LXORE resolved as reduce (LXORE < ':').
    Conflict between rule 126 and token LANDE resolved as reduce (LANDE < ':').
    Conflict between rule 126 and token LLSHE resolved as reduce (LLSHE < ':').
    Conflict between rule 126 and token LRSHE resolved as reduce (LRSHE < ':').
    Conflict between rule 126 and token LMDE resolved as reduce (LMDE < ':').
    Conflict between rule 126 and token LDVE resolved as reduce (LDVE < ':').
    Conflict between rule 126 and token LMLE resolved as reduce (LMLE < ':').
    Conflict between rule 126 and token LME resolved as reduce (LME < ':').
    Conflict between rule 126 and token LPE resolved as reduce (LPE < ':').
    Conflict between rule 126 and token '?' resolved as shift (%right '?').
    Conflict between rule 126 and token LOROR resolved as shift (':' < LOROR).
    Conflict between rule 126 and token LANDAND resolved as shift (':' < LANDAND).
    Conflict between rule 126 and token '|' resolved as shift (':' < '|').
    Conflict between rule 126 and token '^' resolved as shift (':' < '^').
    Conflict between rule 126 and token '&' resolved as shift (':' < '&').
    Conflict between rule 126 and token LNE resolved as shift (':' < LNE).
    Conflict between rule 126 and token LEQ resolved as shift (':' < LEQ).
    Conflict between rule 126 and token '<' resolved as shift (':' < '<').
    Conflict between rule 126 and token '>' resolved as shift (':' < '>').
    Conflict between rule 126 and token LGE resolved as shift (':' < LGE).
    Conflict between rule 126 and token LLE resolved as shift (':' < LLE).
    Conflict between rule 126 and token LRSH resolved as shift (':' < LRSH).
    Conflict between rule 126 and token LLSH resolved as shift (':' < LLSH).
    Conflict between rule 126 and token '+' resolved as shift (':' < '+').
    Conflict between rule 126 and token '-' resolved as shift (':' < '-').
    Conflict between rule 126 and token '*' resolved as shift (':' < '*').
    Conflict between rule 126 and token '/' resolved as shift (':' < '/').
    Conflict between rule 126 and token '%' resolved as shift (':' < '%').


state 344

  179 elist: elist . ',' elist
  179      | elist ',' elist .  [',', ')']

    $default  reduce using rule 179 (elist)

    Conflict between rule 179 and token ',' resolved as reduce (%left ',').


state 345

   46 abdecor2: abdecor2 '[' zexpr ']' .

    $default  reduce using rule 46 (abdecor2)


state 346

   45 abdecor2: abdecor2 '(' zarglist ')' .

    $default  reduce using rule 45 (abdecor2)


state 347

   78 stmnt: error ';' .

    $default  reduce using rule 78 (stmnt)


state 348

   77 label: LNAME ':' .

    $default  reduce using rule 77 (label)


state 349

   94 ulstmnt: LBREAK ';' .

    $default  reduce using rule 94 (ulstmnt)


state 350

   75 label: LCASE expr . ':'
  108 expr: expr . '*' expr
  109     | expr . '/' expr
  110     | expr . '%' expr
  111     | expr . '+' expr
  112     | expr . '-' expr
  113     | expr . LRSH expr
  114     | expr . LLSH expr
  115     | expr . '<' expr
  116     | expr . '>' expr
  117     | expr . LLE expr
  118     | expr . LGE expr
  119     | expr . LEQ expr
  120     | expr . LNE expr
  121     | expr . '&' expr
  122     | expr . '^' expr
  123     | expr . '|' expr
  124     | expr . LANDAND expr
  125     | expr . LOROR expr
  126     | expr . '?' cexpr ':' expr
  127     | expr . '=' expr
  128     | expr . LPE expr
  129     | expr . LME expr
  130     | expr . LMLE expr
  131     | expr . LDVE expr
  132     | expr . LMDE expr
  133     | expr . LLSHE expr
  134     | expr . LRSHE expr
  135     | expr . LANDE expr
  136     | expr . LXORE expr
  137     | expr . LORE expr

    '='      shift, and go to state 157
    LORE     shift, and go to state 158
    LXORE    shift, and go to state 159
    LANDE    shift, and go to state 160
    LLSHE    shift, and go to state 161
    LRSHE    shift, and go to state 162
    LMDE     shift, and go to state 163
    LDVE     shift, and go to state 164
    LMLE     shift, and go to state 165
    LME      shift, and go to state 166
    LPE      shift, and go to state 167
    '?'      shift, and go to state 168
    ':'      shift, and go to state 371
    LOROR    shift, and go to state 169
    LANDAND  shift, and go to state 170
    '|'      shift, and go to state 171
    '^'      shift, and go to state 172
    '&'      shift, and go to state 173
    LNE      shift, and go to state 174
    LEQ      shift, and go to state 175
    '<'      shift, and go to state 176
    '>'      shift, and go to state 177
    LGE      shift, and go to state 178
    LLE      shift, and go to state 179
    LRSH     shift, and go to state 180
    LLSH     shift, and go to state 181
    '+'      shift, and go to state 182
    '-'      shift, and go to state 183
    '*'      shift, and go to state 184
    '/'      shift, and go to state 185
    '%'      shift, and go to state 186


state 351

   95 ulstmnt: LCONTINUE ';' .

    $default  reduce using rule 95 (ulstmnt)


state 352

   76 label: LDEFAULT ':' .

    $default  reduce using rule 76 (label)


state 353

   91 ulstmnt: LDO stmnt . LWHILE '(' cexpr ')' ';'

    LWHILE  shift, and go to state 372


state 354

   96 ulstmnt: LGOTO ltag . ';'

    ';'  shift, and go to state 373


state 355

   86 ulstmnt: LIF '(' . cexpr ')' stmnt
   87        | LIF '(' . cexpr ')' stmnt LELSE stmnt
  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    cexpr    go to state 374
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 356

   98 ulstmnt: LPREFETCH '(' . zelist ')' ';'
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  176 zelist: .  [')']
  177       | . elist
  178 elist: . expr
  179      | . elist ',' elist
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    $default  reduce using rule 176 (zelist)

    expr     go to state 265
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    zelist   go to state 375
    elist    go to state 267
    name     go to state 123


state 357

   92 ulstmnt: LRETURN zcexpr . ';'

    ';'  shift, and go to state 376


state 358

   97 ulstmnt: LUSED '(' . zelist ')' ';'
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  176 zelist: .  [')']
  177       | . elist
  178 elist: . expr
  179      | . elist ',' elist
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    $default  reduce using rule 176 (zelist)

    expr     go to state 265
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    zelist   go to state 377
    elist    go to state 267
    name     go to state 123


state 359

   93 ulstmnt: LSWITCH '(' . cexpr ')' stmnt
  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    cexpr    go to state 378
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 360

   90 ulstmnt: LWHILE '(' . cexpr ')' stmnt
  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    cexpr    go to state 379
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 361

   99 ulstmnt: LSET '(' . zelist ')' ';'
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  176 zelist: .  [')']
  177       | . elist
  178 elist: . expr
  179      | . elist ',' elist
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    $default  reduce using rule 176 (zelist)

    expr     go to state 265
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    zelist   go to state 380
    elist    go to state 267
    name     go to state 123


state 362

   74 labels: labels label .

    $default  reduce using rule 74 (labels)


state 363

   80 stmnt: labels ulstmnt .

    $default  reduce using rule 80 (stmnt)


state 364

   85 ulstmnt: $@7 block .

    $default  reduce using rule 85 (ulstmnt)


state 365

   89 ulstmnt: $@8 LFOR . '(' forexpr ';' zcexpr ';' zcexpr ')' stmnt

    '('  shift, and go to state 381


state 366

   83 ulstmnt: zcexpr ';' .

    $default  reduce using rule 83 (ulstmnt)


state 367

   18 adecl: ctlist ';' .

    $default  reduce using rule 18 (adecl)


state 368

   20 adlist: xdecor .  [';', ',']
   21 $@4: .  ['=']
   22 adlist: xdecor . $@4 '=' init

    '='       reduce using rule 21 ($@4)
    $default  reduce using rule 20 (adlist)

    $@4  go to state 382


state 369

   19 adecl: ctlist adlist . ';'
   23 adlist: adlist . ',' adlist

    ';'  shift, and go to state 383
    ','  shift, and go to state 384


state 370

  140 xuexpr: '(' tlist abdecor ')' '{' ilist . '}'

    '}'  shift, and go to state 385


state 371

   75 label: LCASE expr ':' .

    $default  reduce using rule 75 (label)


state 372

   91 ulstmnt: LDO stmnt LWHILE . '(' cexpr ')' ';'

    '('  shift, and go to state 386


state 373

   96 ulstmnt: LGOTO ltag ';' .

    $default  reduce using rule 96 (ulstmnt)


state 374

   86 ulstmnt: LIF '(' cexpr . ')' stmnt
   87        | LIF '(' cexpr . ')' stmnt LELSE stmnt
  106 cexpr: cexpr . ',' cexpr

    ','  shift, and go to state 226
    ')'  shift, and go to state 387


state 375

   98 ulstmnt: LPREFETCH '(' zelist . ')' ';'

    ')'  shift, and go to state 388


state 376

   92 ulstmnt: LRETURN zcexpr ';' .

    $default  reduce using rule 92 (ulstmnt)


state 377

   97 ulstmnt: LUSED '(' zelist . ')' ';'

    ')'  shift, and go to state 389


state 378

   93 ulstmnt: LSWITCH '(' cexpr . ')' stmnt
  106 cexpr: cexpr . ',' cexpr

    ','  shift, and go to state 226
    ')'  shift, and go to state 390


state 379

   90 ulstmnt: LWHILE '(' cexpr . ')' stmnt
  106 cexpr: cexpr . ',' cexpr

    ','  shift, and go to state 226
    ')'  shift, and go to state 391


state 380

   99 ulstmnt: LSET '(' zelist . ')' ';'

    ')'  shift, and go to state 392


state 381

   81 forexpr: . zcexpr
   82        | . ctlist adlist
   89 ulstmnt: $@8 LFOR '(' . forexpr ';' zcexpr ';' zcexpr ')' stmnt
  100 zcexpr: .  [';']
  101       | . cexpr
  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  184 types: . complex
  185      | . tname
  186      | . gcnlist
  187      | . complex gctnlist
  188      | . tname gctnlist
  189      | . gcnlist complex zgnlist
  190      | . gcnlist tname
  191      | . gcnlist tname gctnlist
  193 ctlist: . types
  194 complex: . LSTRUCT ltag
  196        | . LSTRUCT ltag $@10 sbody
  197        | . LSTRUCT sbody
  198        | . LUNION ltag
  200        | . LUNION ltag $@11 sbody
  201        | . LUNION sbody
  202        | . LENUM ltag
  205        | . LENUM ltag $@12 '{' $@13 enum '}'
  207        | . LENUM '{' $@14 enum '}'
  208        | . LTYPE
  216 gcnlist: . gcname
  217        | . gcnlist gcname
  218 gcname: . gname
  219       | . cname
  224 tname: . LCHAR
  225      | . LSHORT
  226      | . LINT
  227      | . LLONG
  228      | . LSIGNED
  229      | . LUNSIGNED
  230      | . LFLOAT
  231      | . LDOUBLE
  232      | . LVOID
  233 cname: . LAUTO
  234      | . LSTATIC
  235      | . LEXTERN
  236      | . LTYPEDEF
  237      | . LTYPESTR
  238      | . LREGISTER
  239      | . LINLINE
  240 gname: . LCONSTNT
  241      | . LVOLATILE
  242      | . LRESTRICT
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LTYPE      shift, and go to state 3
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LAUTO      shift, and go to state 4
    LCHAR      shift, and go to state 5
    LDOUBLE    shift, and go to state 6
    LEXTERN    shift, and go to state 7
    LFLOAT     shift, and go to state 8
    LINT       shift, and go to state 9
    LLONG      shift, and go to state 10
    LREGISTER  shift, and go to state 11
    LSHORT     shift, and go to state 12
    LSIZEOF    shift, and go to state 111
    LSTATIC    shift, and go to state 13
    LSTRUCT    shift, and go to state 14
    LTYPEDEF   shift, and go to state 15
    LTYPESTR   shift, and go to state 16
    LUNION     shift, and go to state 17
    LUNSIGNED  shift, and go to state 18
    LVOID      shift, and go to state 19
    LENUM      shift, and go to state 20
    LSIGNED    shift, and go to state 21
    LCONSTNT   shift, and go to state 22
    LVOLATILE  shift, and go to state 23
    LSIGNOF    shift, and go to state 112
    LRESTRICT  shift, and go to state 24
    LINLINE    shift, and go to state 25
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    $default  reduce using rule 100 (zcexpr)

    forexpr  go to state 393
    zcexpr   go to state 394
    cexpr    go to state 334
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    types    go to state 28
    ctlist   go to state 395
    complex  go to state 30
    gcnlist  go to state 31
    gcname   go to state 32
    tname    go to state 33
    cname    go to state 34
    gname    go to state 35
    name     go to state 123


state 382

   22 adlist: xdecor $@4 . '=' init

    '='  shift, and go to state 396


state 383

   19 adecl: ctlist adlist ';' .

    $default  reduce using rule 19 (adecl)


state 384

   12 xdecor: . xdecor2
   13       | . '*' zgnlist xdecor
   14 xdecor2: . tag
   15        | . '(' xdecor ')'
   16        | . xdecor2 '(' zarglist ')'
   17        | . xdecor2 '[' zexpr ']'
   20 adlist: . xdecor
   22       | . xdecor $@4 '=' init
   23       | . adlist ',' adlist
   23       | adlist ',' . adlist
  244 tag: . ltag
  245 ltag: . LNAME
  246     | . LTYPE

    '*'    shift, and go to state 46
    '('    shift, and go to state 47
    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37

    xdecor   go to state 368
    xdecor2  go to state 50
    adlist   go to state 397
    tag      go to state 51
    ltag     go to state 52


state 385

  140 xuexpr: '(' tlist abdecor ')' '{' ilist '}' .

    $default  reduce using rule 140 (xuexpr)


state 386

   91 ulstmnt: LDO stmnt LWHILE '(' . cexpr ')' ';'
  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    cexpr    go to state 398
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 387

   73 labels: . label
   74       | . labels label
   75 label: . LCASE expr ':'
   76      | . LDEFAULT ':'
   77      | . LNAME ':'
   78 stmnt: . error ';'
   79      | . ulstmnt
   80      | . labels ulstmnt
   83 ulstmnt: . zcexpr ';'
   84 $@7: .  ['{']
   85 ulstmnt: . $@7 block
   86        | . LIF '(' cexpr ')' stmnt
   86        | LIF '(' cexpr ')' . stmnt
   87        | . LIF '(' cexpr ')' stmnt LELSE stmnt
   87        | LIF '(' cexpr ')' . stmnt LELSE stmnt
   88 $@8: .  [LFOR]
   89 ulstmnt: . $@8 LFOR '(' forexpr ';' zcexpr ';' zcexpr ')' stmnt
   90        | . LWHILE '(' cexpr ')' stmnt
   91        | . LDO stmnt LWHILE '(' cexpr ')' ';'
   92        | . LRETURN zcexpr ';'
   93        | . LSWITCH '(' cexpr ')' stmnt
   94        | . LBREAK ';'
   95        | . LCONTINUE ';'
   96        | . LGOTO ltag ';'
   97        | . LUSED '(' zelist ')' ';'
   98        | . LPREFETCH '(' zelist ')' ';'
   99        | . LSET '(' zelist ')' ';'
  100 zcexpr: .  [';']
  101       | . cexpr
  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    error      shift, and go to state 310
    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 311
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LBREAK     shift, and go to state 312
    LCASE      shift, and go to state 313
    LCONTINUE  shift, and go to state 314
    LDEFAULT   shift, and go to state 315
    LDO        shift, and go to state 316
    LGOTO      shift, and go to state 317
    LIF        shift, and go to state 318
    LPREFETCH  shift, and go to state 319
    LRETURN    shift, and go to state 320
    LSIZEOF    shift, and go to state 111
    LUSED      shift, and go to state 321
    LSWITCH    shift, and go to state 322
    LWHILE     shift, and go to state 323
    LSET       shift, and go to state 324
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    ';'   reduce using rule 100 (zcexpr)
    LFOR  reduce using rule 88 ($@8)
    '{'   reduce using rule 84 ($@7)

    labels   go to state 327
    label    go to state 328
    stmnt    go to state 399
    ulstmnt  go to state 330
    $@7      go to state 331
    $@8      go to state 332
    zcexpr   go to state 333
    cexpr    go to state 334
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 388

   98 ulstmnt: LPREFETCH '(' zelist ')' . ';'

    ';'  shift, and go to state 400


state 389

   97 ulstmnt: LUSED '(' zelist ')' . ';'

    ';'  shift, and go to state 401


state 390

   73 labels: . label
   74       | . labels label
   75 label: . LCASE expr ':'
   76      | . LDEFAULT ':'
   77      | . LNAME ':'
   78 stmnt: . error ';'
   79      | . ulstmnt
   80      | . labels ulstmnt
   83 ulstmnt: . zcexpr ';'
   84 $@7: .  ['{']
   85 ulstmnt: . $@7 block
   86        | . LIF '(' cexpr ')' stmnt
   87        | . LIF '(' cexpr ')' stmnt LELSE stmnt
   88 $@8: .  [LFOR]
   89 ulstmnt: . $@8 LFOR '(' forexpr ';' zcexpr ';' zcexpr ')' stmnt
   90        | . LWHILE '(' cexpr ')' stmnt
   91        | . LDO stmnt LWHILE '(' cexpr ')' ';'
   92        | . LRETURN zcexpr ';'
   93        | . LSWITCH '(' cexpr ')' stmnt
   93        | LSWITCH '(' cexpr ')' . stmnt
   94        | . LBREAK ';'
   95        | . LCONTINUE ';'
   96        | . LGOTO ltag ';'
   97        | . LUSED '(' zelist ')' ';'
   98        | . LPREFETCH '(' zelist ')' ';'
   99        | . LSET '(' zelist ')' ';'
  100 zcexpr: .  [';']
  101       | . cexpr
  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    error      shift, and go to state 310
    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 311
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LBREAK     shift, and go to state 312
    LCASE      shift, and go to state 313
    LCONTINUE  shift, and go to state 314
    LDEFAULT   shift, and go to state 315
    LDO        shift, and go to state 316
    LGOTO      shift, and go to state 317
    LIF        shift, and go to state 318
    LPREFETCH  shift, and go to state 319
    LRETURN    shift, and go to state 320
    LSIZEOF    shift, and go to state 111
    LUSED      shift, and go to state 321
    LSWITCH    shift, and go to state 322
    LWHILE     shift, and go to state 323
    LSET       shift, and go to state 324
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    ';'   reduce using rule 100 (zcexpr)
    LFOR  reduce using rule 88 ($@8)
    '{'   reduce using rule 84 ($@7)

    labels   go to state 327
    label    go to state 328
    stmnt    go to state 402
    ulstmnt  go to state 330
    $@7      go to state 331
    $@8      go to state 332
    zcexpr   go to state 333
    cexpr    go to state 334
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 391

   73 labels: . label
   74       | . labels label
   75 label: . LCASE expr ':'
   76      | . LDEFAULT ':'
   77      | . LNAME ':'
   78 stmnt: . error ';'
   79      | . ulstmnt
   80      | . labels ulstmnt
   83 ulstmnt: . zcexpr ';'
   84 $@7: .  ['{']
   85 ulstmnt: . $@7 block
   86        | . LIF '(' cexpr ')' stmnt
   87        | . LIF '(' cexpr ')' stmnt LELSE stmnt
   88 $@8: .  [LFOR]
   89 ulstmnt: . $@8 LFOR '(' forexpr ';' zcexpr ';' zcexpr ')' stmnt
   90        | . LWHILE '(' cexpr ')' stmnt
   90        | LWHILE '(' cexpr ')' . stmnt
   91        | . LDO stmnt LWHILE '(' cexpr ')' ';'
   92        | . LRETURN zcexpr ';'
   93        | . LSWITCH '(' cexpr ')' stmnt
   94        | . LBREAK ';'
   95        | . LCONTINUE ';'
   96        | . LGOTO ltag ';'
   97        | . LUSED '(' zelist ')' ';'
   98        | . LPREFETCH '(' zelist ')' ';'
   99        | . LSET '(' zelist ')' ';'
  100 zcexpr: .  [';']
  101       | . cexpr
  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    error      shift, and go to state 310
    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 311
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LBREAK     shift, and go to state 312
    LCASE      shift, and go to state 313
    LCONTINUE  shift, and go to state 314
    LDEFAULT   shift, and go to state 315
    LDO        shift, and go to state 316
    LGOTO      shift, and go to state 317
    LIF        shift, and go to state 318
    LPREFETCH  shift, and go to state 319
    LRETURN    shift, and go to state 320
    LSIZEOF    shift, and go to state 111
    LUSED      shift, and go to state 321
    LSWITCH    shift, and go to state 322
    LWHILE     shift, and go to state 323
    LSET       shift, and go to state 324
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    ';'   reduce using rule 100 (zcexpr)
    LFOR  reduce using rule 88 ($@8)
    '{'   reduce using rule 84 ($@7)

    labels   go to state 327
    label    go to state 328
    stmnt    go to state 403
    ulstmnt  go to state 330
    $@7      go to state 331
    $@8      go to state 332
    zcexpr   go to state 333
    cexpr    go to state 334
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 392

   99 ulstmnt: LSET '(' zelist ')' . ';'

    ';'  shift, and go to state 404


state 393

   89 ulstmnt: $@8 LFOR '(' forexpr . ';' zcexpr ';' zcexpr ')' stmnt

    ';'  shift, and go to state 405


state 394

   81 forexpr: zcexpr .

    $default  reduce using rule 81 (forexpr)


state 395

   12 xdecor: . xdecor2
   13       | . '*' zgnlist xdecor
   14 xdecor2: . tag
   15        | . '(' xdecor ')'
   16        | . xdecor2 '(' zarglist ')'
   17        | . xdecor2 '[' zexpr ']'
   20 adlist: . xdecor
   22       | . xdecor $@4 '=' init
   23       | . adlist ',' adlist
   82 forexpr: ctlist . adlist
  244 tag: . ltag
  245 ltag: . LNAME
  246     | . LTYPE

    '*'    shift, and go to state 46
    '('    shift, and go to state 47
    LNAME  shift, and go to state 36
    LTYPE  shift, and go to state 37

    xdecor   go to state 368
    xdecor2  go to state 50
    adlist   go to state 406
    tag      go to state 51
    ltag     go to state 52


state 396

   22 adlist: xdecor $@4 '=' . init
   50 init: . expr
   51     | . '{' ilist '}'
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '{'        shift, and go to state 138
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    init     go to state 407
    expr     go to state 140
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 397

   23 adlist: adlist . ',' adlist
   23       | adlist ',' adlist .  [';', ',']

    $default  reduce using rule 23 (adlist)

    Conflict between rule 23 and token ',' resolved as reduce (%left ',').


state 398

   91 ulstmnt: LDO stmnt LWHILE '(' cexpr . ')' ';'
  106 cexpr: cexpr . ',' cexpr

    ','  shift, and go to state 226
    ')'  shift, and go to state 408


state 399

   86 ulstmnt: LIF '(' cexpr ')' stmnt .  [error, ';', '&', '+', '-', '*', '(', LPP, LMM, LNAME, LTYPE, LFCONST, LDCONST, LCONST, LLCONST, LUCONST, LULCONST, LVLCONST, LUVLCONST, LSTRING, LLSTRING, LAUTO, LBREAK, LCASE, LCHAR, LCONTINUE, LDEFAULT, LDO, LDOUBLE, LELSE, LEXTERN, LFLOAT, LFOR, LGOTO, LIF, LINT, LLONG, LPREFETCH, LREGISTER, LRETURN, LSHORT, LSIZEOF, LUSED, LSTATIC, LSTRUCT, LSWITCH, LTYPEDEF, LTYPESTR, LUNION, LUNSIGNED, LWHILE, LVOID, LENUM, LSIGNED, LCONSTNT, LVOLATILE, LSET, LSIGNOF, LRESTRICT, LINLINE, '{', '}', '!', '~']
   87        | LIF '(' cexpr ')' stmnt . LELSE stmnt

    LELSE  shift, and go to state 409

    LELSE     [reduce using rule 86 (ulstmnt)]
    $default  reduce using rule 86 (ulstmnt)


state 400

   98 ulstmnt: LPREFETCH '(' zelist ')' ';' .

    $default  reduce using rule 98 (ulstmnt)


state 401

   97 ulstmnt: LUSED '(' zelist ')' ';' .

    $default  reduce using rule 97 (ulstmnt)


state 402

   93 ulstmnt: LSWITCH '(' cexpr ')' stmnt .

    $default  reduce using rule 93 (ulstmnt)


state 403

   90 ulstmnt: LWHILE '(' cexpr ')' stmnt .

    $default  reduce using rule 90 (ulstmnt)


state 404

   99 ulstmnt: LSET '(' zelist ')' ';' .

    $default  reduce using rule 99 (ulstmnt)


state 405

   89 ulstmnt: $@8 LFOR '(' forexpr ';' . zcexpr ';' zcexpr ')' stmnt
  100 zcexpr: .  [';']
  101       | . cexpr
  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    $default  reduce using rule 100 (zcexpr)

    zcexpr   go to state 410
    cexpr    go to state 334
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 406

   23 adlist: adlist . ',' adlist
   82 forexpr: ctlist adlist .  [';']

    ','  shift, and go to state 384

    $default  reduce using rule 82 (forexpr)


state 407

   22 adlist: xdecor $@4 '=' init .

    $default  reduce using rule 22 (adlist)


state 408

   91 ulstmnt: LDO stmnt LWHILE '(' cexpr ')' . ';'

    ';'  shift, and go to state 411


state 409

   73 labels: . label
   74       | . labels label
   75 label: . LCASE expr ':'
   76      | . LDEFAULT ':'
   77      | . LNAME ':'
   78 stmnt: . error ';'
   79      | . ulstmnt
   80      | . labels ulstmnt
   83 ulstmnt: . zcexpr ';'
   84 $@7: .  ['{']
   85 ulstmnt: . $@7 block
   86        | . LIF '(' cexpr ')' stmnt
   87        | . LIF '(' cexpr ')' stmnt LELSE stmnt
   87        | LIF '(' cexpr ')' stmnt LELSE . stmnt
   88 $@8: .  [LFOR]
   89 ulstmnt: . $@8 LFOR '(' forexpr ';' zcexpr ';' zcexpr ')' stmnt
   90        | . LWHILE '(' cexpr ')' stmnt
   91        | . LDO stmnt LWHILE '(' cexpr ')' ';'
   92        | . LRETURN zcexpr ';'
   93        | . LSWITCH '(' cexpr ')' stmnt
   94        | . LBREAK ';'
   95        | . LCONTINUE ';'
   96        | . LGOTO ltag ';'
   97        | . LUSED '(' zelist ')' ';'
   98        | . LPREFETCH '(' zelist ')' ';'
   99        | . LSET '(' zelist ')' ';'
  100 zcexpr: .  [';']
  101       | . cexpr
  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    error      shift, and go to state 310
    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 311
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LBREAK     shift, and go to state 312
    LCASE      shift, and go to state 313
    LCONTINUE  shift, and go to state 314
    LDEFAULT   shift, and go to state 315
    LDO        shift, and go to state 316
    LGOTO      shift, and go to state 317
    LIF        shift, and go to state 318
    LPREFETCH  shift, and go to state 319
    LRETURN    shift, and go to state 320
    LSIZEOF    shift, and go to state 111
    LUSED      shift, and go to state 321
    LSWITCH    shift, and go to state 322
    LWHILE     shift, and go to state 323
    LSET       shift, and go to state 324
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    ';'   reduce using rule 100 (zcexpr)
    LFOR  reduce using rule 88 ($@8)
    '{'   reduce using rule 84 ($@7)

    labels   go to state 327
    label    go to state 328
    stmnt    go to state 412
    ulstmnt  go to state 330
    $@7      go to state 331
    $@8      go to state 332
    zcexpr   go to state 333
    cexpr    go to state 334
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 410

   89 ulstmnt: $@8 LFOR '(' forexpr ';' zcexpr . ';' zcexpr ')' stmnt

    ';'  shift, and go to state 413


state 411

   91 ulstmnt: LDO stmnt LWHILE '(' cexpr ')' ';' .

    $default  reduce using rule 91 (ulstmnt)


state 412

   87 ulstmnt: LIF '(' cexpr ')' stmnt LELSE stmnt .

    $default  reduce using rule 87 (ulstmnt)


state 413

   89 ulstmnt: $@8 LFOR '(' forexpr ';' zcexpr ';' . zcexpr ')' stmnt
  100 zcexpr: .  [')']
  101       | . cexpr
  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 100
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LSIZEOF    shift, and go to state 111
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    $default  reduce using rule 100 (zcexpr)

    zcexpr   go to state 414
    cexpr    go to state 334
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 414

   89 ulstmnt: $@8 LFOR '(' forexpr ';' zcexpr ';' zcexpr . ')' stmnt

    ')'  shift, and go to state 415


state 415

   73 labels: . label
   74       | . labels label
   75 label: . LCASE expr ':'
   76      | . LDEFAULT ':'
   77      | . LNAME ':'
   78 stmnt: . error ';'
   79      | . ulstmnt
   80      | . labels ulstmnt
   83 ulstmnt: . zcexpr ';'
   84 $@7: .  ['{']
   85 ulstmnt: . $@7 block
   86        | . LIF '(' cexpr ')' stmnt
   87        | . LIF '(' cexpr ')' stmnt LELSE stmnt
   88 $@8: .  [LFOR]
   89 ulstmnt: . $@8 LFOR '(' forexpr ';' zcexpr ';' zcexpr ')' stmnt
   89        | $@8 LFOR '(' forexpr ';' zcexpr ';' zcexpr ')' . stmnt
   90        | . LWHILE '(' cexpr ')' stmnt
   91        | . LDO stmnt LWHILE '(' cexpr ')' ';'
   92        | . LRETURN zcexpr ';'
   93        | . LSWITCH '(' cexpr ')' stmnt
   94        | . LBREAK ';'
   95        | . LCONTINUE ';'
   96        | . LGOTO ltag ';'
   97        | . LUSED '(' zelist ')' ';'
   98        | . LPREFETCH '(' zelist ')' ';'
   99        | . LSET '(' zelist ')' ';'
  100 zcexpr: .  [';']
  101       | . cexpr
  105 cexpr: . expr
  106      | . cexpr ',' cexpr
  107 expr: . xuexpr
  108     | . expr '*' expr
  109     | . expr '/' expr
  110     | . expr '%' expr
  111     | . expr '+' expr
  112     | . expr '-' expr
  113     | . expr LRSH expr
  114     | . expr LLSH expr
  115     | . expr '<' expr
  116     | . expr '>' expr
  117     | . expr LLE expr
  118     | . expr LGE expr
  119     | . expr LEQ expr
  120     | . expr LNE expr
  121     | . expr '&' expr
  122     | . expr '^' expr
  123     | . expr '|' expr
  124     | . expr LANDAND expr
  125     | . expr LOROR expr
  126     | . expr '?' cexpr ':' expr
  127     | . expr '=' expr
  128     | . expr LPE expr
  129     | . expr LME expr
  130     | . expr LMLE expr
  131     | . expr LDVE expr
  132     | . expr LMDE expr
  133     | . expr LLSHE expr
  134     | . expr LRSHE expr
  135     | . expr LANDE expr
  136     | . expr LXORE expr
  137     | . expr LORE expr
  138 xuexpr: . uexpr
  139       | . '(' tlist abdecor ')' xuexpr
  140       | . '(' tlist abdecor ')' '{' ilist '}'
  141 uexpr: . pexpr
  142      | . '*' xuexpr
  143      | . '&' xuexpr
  144      | . '+' xuexpr
  145      | . '-' xuexpr
  146      | . '!' xuexpr
  147      | . '~' xuexpr
  148      | . LPP xuexpr
  149      | . LMM xuexpr
  150      | . LSIZEOF uexpr
  151      | . LSIGNOF uexpr
  152 pexpr: . '(' cexpr ')'
  153      | . LSIZEOF '(' tlist abdecor ')'
  154      | . LSIGNOF '(' tlist abdecor ')'
  155      | . pexpr '(' zelist ')'
  156      | . pexpr '[' cexpr ']'
  157      | . pexpr LMG ltag
  158      | . pexpr '.' ltag
  159      | . pexpr LPP
  160      | . pexpr LMM
  161      | . name
  162      | . LCONST
  163      | . LLCONST
  164      | . LUCONST
  165      | . LULCONST
  166      | . LDCONST
  167      | . LFCONST
  168      | . LVLCONST
  169      | . LUVLCONST
  170      | . string
  171      | . lstring
  172 string: . LSTRING
  173       | . string LSTRING
  174 lstring: . LLSTRING
  175        | . lstring LLSTRING
  243 name: . LNAME

    error      shift, and go to state 310
    '&'        shift, and go to state 93
    '+'        shift, and go to state 94
    '-'        shift, and go to state 95
    '*'        shift, and go to state 96
    '('        shift, and go to state 97
    LPP        shift, and go to state 98
    LMM        shift, and go to state 99
    LNAME      shift, and go to state 311
    LFCONST    shift, and go to state 101
    LDCONST    shift, and go to state 102
    LCONST     shift, and go to state 103
    LLCONST    shift, and go to state 104
    LUCONST    shift, and go to state 105
    LULCONST   shift, and go to state 106
    LVLCONST   shift, and go to state 107
    LUVLCONST  shift, and go to state 108
    LSTRING    shift, and go to state 109
    LLSTRING   shift, and go to state 110
    LBREAK     shift, and go to state 312
    LCASE      shift, and go to state 313
    LCONTINUE  shift, and go to state 314
    LDEFAULT   shift, and go to state 315
    LDO        shift, and go to state 316
    LGOTO      shift, and go to state 317
    LIF        shift, and go to state 318
    LPREFETCH  shift, and go to state 319
    LRETURN    shift, and go to state 320
    LSIZEOF    shift, and go to state 111
    LUSED      shift, and go to state 321
    LSWITCH    shift, and go to state 322
    LWHILE     shift, and go to state 323
    LSET       shift, and go to state 324
    LSIGNOF    shift, and go to state 112
    '!'        shift, and go to state 113
    '~'        shift, and go to state 114

    ';'   reduce using rule 100 (zcexpr)
    LFOR  reduce using rule 88 ($@8)
    '{'   reduce using rule 84 ($@7)

    labels   go to state 327
    label    go to state 328
    stmnt    go to state 416
    ulstmnt  go to state 330
    $@7      go to state 331
    $@8      go to state 332
    zcexpr   go to state 333
    cexpr    go to state 334
    expr     go to state 146
    xuexpr   go to state 118
    uexpr    go to state 119
    pexpr    go to state 120
    string   go to state 121
    lstring  go to state 122
    name     go to state 123


state 416

   89 ulstmnt: $@8 LFOR '(' forexpr ';' zcexpr ';' zcexpr ')' stmnt .

    $default  reduce using rule 89 (ulstmnt)
