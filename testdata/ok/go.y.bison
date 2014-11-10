Terminals unused in grammar

   LIGNORE


Grammar

    0 $accept: file $end

    1 file: loadsys package imports xdcl_list

    2 package: /* empty */
    3        | LPACKAGE sym ';'

    4 $@1: /* empty */

    5 loadsys: $@1 import_package import_there

    6 imports: /* empty */
    7        | imports import ';'

    8 import: LIMPORT import_stmt
    9       | LIMPORT '(' import_stmt_list osemi ')'
   10       | LIMPORT '(' ')'

   11 import_stmt: import_here import_package import_there
   12            | import_here import_there

   13 import_stmt_list: import_stmt
   14                 | import_stmt_list ';' import_stmt

   15 import_here: LLITERAL
   16            | sym LLITERAL
   17            | '.' LLITERAL

   18 import_package: LPACKAGE LNAME import_safety ';'

   19 import_safety: /* empty */
   20              | LNAME

   21 $@2: /* empty */

   22 import_there: $@2 hidden_import_list '$' '$'

   23 xdcl: /* empty */
   24     | common_dcl
   25     | xfndcl
   26     | non_dcl_stmt
   27     | error

   28 common_dcl: LVAR vardcl
   29           | LVAR '(' vardcl_list osemi ')'
   30           | LVAR '(' ')'
   31           | lconst constdcl
   32           | lconst '(' constdcl osemi ')'
   33           | lconst '(' constdcl ';' constdcl_list osemi ')'
   34           | lconst '(' ')'
   35           | LTYPE typedcl
   36           | LTYPE '(' typedcl_list osemi ')'
   37           | LTYPE '(' ')'

   38 lconst: LCONST

   39 vardcl: dcl_name_list ntype
   40       | dcl_name_list ntype '=' expr_list
   41       | dcl_name_list '=' expr_list

   42 constdcl: dcl_name_list ntype '=' expr_list
   43         | dcl_name_list '=' expr_list

   44 constdcl1: constdcl
   45          | dcl_name_list ntype
   46          | dcl_name_list

   47 typedclname: sym

   48 typedcl: typedclname ntype

   49 simple_stmt: expr
   50            | expr LASOP expr
   51            | expr_list '=' expr_list
   52            | expr_list LCOLAS expr_list
   53            | expr LINC
   54            | expr LDEC

   55 case: LCASE expr_or_type_list ':'
   56     | LCASE expr_or_type_list '=' expr ':'
   57     | LCASE expr_or_type_list LCOLAS expr ':'
   58     | LDEFAULT ':'

   59 $@3: /* empty */

   60 compound_stmt: '{' $@3 stmt_list '}'

   61 $@4: /* empty */

   62 caseblock: case $@4 stmt_list

   63 caseblock_list: /* empty */
   64               | caseblock_list caseblock

   65 $@5: /* empty */

   66 loop_body: LBODY $@5 stmt_list '}'

   67 range_stmt: expr_list '=' LRANGE expr
   68           | expr_list LCOLAS LRANGE expr

   69 for_header: osimple_stmt ';' osimple_stmt ';' osimple_stmt
   70           | osimple_stmt
   71           | range_stmt

   72 for_body: for_header loop_body

   73 $@6: /* empty */

   74 for_stmt: LFOR $@6 for_body

   75 if_header: osimple_stmt
   76          | osimple_stmt ';' osimple_stmt

   77 $@7: /* empty */

   78 $@8: /* empty */

   79 $@9: /* empty */

   80 if_stmt: LIF $@7 if_header $@8 loop_body $@9 elseif_list else

   81 $@10: /* empty */

   82 elseif: LELSE LIF $@10 if_header loop_body

   83 elseif_list: /* empty */
   84            | elseif_list elseif

   85 else: /* empty */
   86     | LELSE compound_stmt

   87 $@11: /* empty */

   88 $@12: /* empty */

   89 switch_stmt: LSWITCH $@11 if_header $@12 LBODY caseblock_list '}'

   90 $@13: /* empty */

   91 select_stmt: LSELECT $@13 LBODY caseblock_list '}'

   92 expr: uexpr
   93     | expr LOROR expr
   94     | expr LANDAND expr
   95     | expr LEQ expr
   96     | expr LNE expr
   97     | expr LLT expr
   98     | expr LLE expr
   99     | expr LGE expr
  100     | expr LGT expr
  101     | expr '+' expr
  102     | expr '-' expr
  103     | expr '|' expr
  104     | expr '^' expr
  105     | expr '*' expr
  106     | expr '/' expr
  107     | expr '%' expr
  108     | expr '&' expr
  109     | expr LANDNOT expr
  110     | expr LLSH expr
  111     | expr LRSH expr
  112     | expr LCOMM expr

  113 uexpr: pexpr
  114      | '*' uexpr
  115      | '&' uexpr
  116      | '+' uexpr
  117      | '-' uexpr
  118      | '!' uexpr
  119      | '~' uexpr
  120      | '^' uexpr
  121      | LCOMM uexpr

  122 pseudocall: pexpr '(' ')'
  123           | pexpr '(' expr_or_type_list ocomma ')'
  124           | pexpr '(' expr_or_type_list LDDD ocomma ')'

  125 pexpr_no_paren: LLITERAL
  126               | name
  127               | pexpr '.' sym
  128               | pexpr '.' '(' expr_or_type ')'
  129               | pexpr '.' '(' LTYPE ')'
  130               | pexpr '[' expr ']'
  131               | pexpr '[' oexpr ':' oexpr ']'
  132               | pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | pseudocall
  134               | convtype '(' expr ocomma ')'
  135               | comptype lbrace start_complit braced_keyval_list '}'
  136               | pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | fnliteral

  139 start_complit: /* empty */

  140 keyval: expr ':' complitexpr

  141 bare_complitexpr: expr
  142                 | '{' start_complit braced_keyval_list '}'

  143 complitexpr: expr
  144            | '{' start_complit braced_keyval_list '}'

  145 pexpr: pexpr_no_paren
  146      | '(' expr_or_type ')'

  147 expr_or_type: expr
  148             | non_expr_type

  149 name_or_type: ntype

  150 lbrace: LBODY
  151       | '{'

  152 new_name: sym

  153 dcl_name: sym

  154 onew_name: /* empty */
  155          | new_name

  156 sym: LNAME
  157    | hidden_importsym
  158    | '?'

  159 hidden_importsym: '@' LLITERAL '.' LNAME
  160                 | '@' LLITERAL '.' '?'

  161 name: sym

  162 labelname: new_name

  163 dotdotdot: LDDD
  164          | LDDD ntype

  165 ntype: recvchantype
  166      | fntype
  167      | othertype
  168      | ptrtype
  169      | dotname
  170      | '(' ntype ')'

  171 non_expr_type: recvchantype
  172              | fntype
  173              | othertype
  174              | '*' non_expr_type

  175 non_recvchantype: fntype
  176                 | othertype
  177                 | ptrtype
  178                 | dotname
  179                 | '(' ntype ')'

  180 convtype: fntype
  181         | othertype

  182 comptype: othertype

  183 fnret_type: recvchantype
  184           | fntype
  185           | othertype
  186           | ptrtype
  187           | dotname

  188 dotname: name
  189        | name '.' sym

  190 othertype: '[' oexpr ']' ntype
  191          | '[' LDDD ']' ntype
  192          | LCHAN non_recvchantype
  193          | LCHAN LCOMM ntype
  194          | LMAP '[' ntype ']' ntype
  195          | structtype
  196          | interfacetype

  197 ptrtype: '*' ntype

  198 recvchantype: LCOMM LCHAN ntype

  199 structtype: LSTRUCT lbrace structdcl_list osemi '}'
  200           | LSTRUCT lbrace '}'

  201 interfacetype: LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | LINTERFACE lbrace '}'

  203 xfndcl: LFUNC fndcl fnbody

  204 fndcl: sym '(' oarg_type_list_ocomma ')' fnres
  205      | '(' oarg_type_list_ocomma ')' sym '(' oarg_type_list_ocomma ')' fnres

  206 hidden_fndcl: hidden_pkg_importsym '(' ohidden_funarg_list ')' ohidden_funres
  207             | '(' hidden_funarg_list ')' sym '(' ohidden_funarg_list ')' ohidden_funres

  208 fntype: LFUNC '(' oarg_type_list_ocomma ')' fnres

  209 fnbody: /* empty */
  210       | '{' stmt_list '}'

  211 fnres: /* empty */
  212      | fnret_type
  213      | '(' oarg_type_list_ocomma ')'

  214 fnlitdcl: fntype

  215 fnliteral: fnlitdcl lbrace stmt_list '}'
  216          | fnlitdcl error

  217 xdcl_list: /* empty */
  218          | xdcl_list xdcl ';'

  219 vardcl_list: vardcl
  220            | vardcl_list ';' vardcl

  221 constdcl_list: constdcl1
  222              | constdcl_list ';' constdcl1

  223 typedcl_list: typedcl
  224             | typedcl_list ';' typedcl

  225 structdcl_list: structdcl
  226               | structdcl_list ';' structdcl

  227 interfacedcl_list: interfacedcl
  228                  | interfacedcl_list ';' interfacedcl

  229 structdcl: new_name_list ntype oliteral
  230          | embed oliteral
  231          | '(' embed ')' oliteral
  232          | '*' embed oliteral
  233          | '(' '*' embed ')' oliteral
  234          | '*' '(' embed ')' oliteral

  235 packname: LNAME
  236         | LNAME '.' sym

  237 embed: packname

  238 interfacedcl: new_name indcl
  239             | packname
  240             | '(' packname ')'

  241 indcl: '(' oarg_type_list_ocomma ')' fnres

  242 arg_type: name_or_type
  243         | sym name_or_type
  244         | sym dotdotdot
  245         | dotdotdot

  246 arg_type_list: arg_type
  247              | arg_type_list ',' arg_type

  248 oarg_type_list_ocomma: /* empty */
  249                      | arg_type_list ocomma

  250 stmt: /* empty */
  251     | compound_stmt
  252     | common_dcl
  253     | non_dcl_stmt
  254     | error

  255 non_dcl_stmt: simple_stmt
  256             | for_stmt
  257             | switch_stmt
  258             | select_stmt
  259             | if_stmt

  260 $@14: /* empty */

  261 non_dcl_stmt: labelname ':' $@14 stmt
  262             | LFALL
  263             | LBREAK onew_name
  264             | LCONTINUE onew_name
  265             | LGO pseudocall
  266             | LDEFER pseudocall
  267             | LGOTO new_name
  268             | LRETURN oexpr_list

  269 stmt_list: stmt
  270          | stmt_list ';' stmt

  271 new_name_list: new_name
  272              | new_name_list ',' new_name

  273 dcl_name_list: dcl_name
  274              | dcl_name_list ',' dcl_name

  275 expr_list: expr
  276          | expr_list ',' expr

  277 expr_or_type_list: expr_or_type
  278                  | expr_or_type_list ',' expr_or_type

  279 keyval_list: keyval
  280            | bare_complitexpr
  281            | keyval_list ',' keyval
  282            | keyval_list ',' bare_complitexpr

  283 braced_keyval_list: /* empty */
  284                   | keyval_list ocomma

  285 osemi: /* empty */
  286      | ';'

  287 ocomma: /* empty */
  288       | ','

  289 oexpr: /* empty */
  290      | expr

  291 oexpr_list: /* empty */
  292           | expr_list

  293 osimple_stmt: /* empty */
  294             | simple_stmt

  295 ohidden_funarg_list: /* empty */
  296                    | hidden_funarg_list

  297 ohidden_structdcl_list: /* empty */
  298                       | hidden_structdcl_list

  299 ohidden_interfacedcl_list: /* empty */
  300                          | hidden_interfacedcl_list

  301 oliteral: /* empty */
  302         | LLITERAL

  303 hidden_import: LIMPORT LNAME LLITERAL ';'
  304              | LVAR hidden_pkg_importsym hidden_type ';'
  305              | LCONST hidden_pkg_importsym '=' hidden_constant ';'
  306              | LCONST hidden_pkg_importsym hidden_type '=' hidden_constant ';'
  307              | LTYPE hidden_pkgtype hidden_type ';'
  308              | LFUNC hidden_fndcl fnbody ';'

  309 hidden_pkg_importsym: hidden_importsym

  310 hidden_pkgtype: hidden_pkg_importsym

  311 hidden_type: hidden_type_misc
  312            | hidden_type_recv_chan
  313            | hidden_type_func

  314 hidden_type_non_recv_chan: hidden_type_misc
  315                          | hidden_type_func

  316 hidden_type_misc: hidden_importsym
  317                 | LNAME
  318                 | '[' ']' hidden_type
  319                 | '[' LLITERAL ']' hidden_type
  320                 | LMAP '[' hidden_type ']' hidden_type
  321                 | LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | '*' hidden_type
  324                 | LCHAN hidden_type_non_recv_chan
  325                 | LCHAN '(' hidden_type_recv_chan ')'
  326                 | LCHAN LCOMM hidden_type

  327 hidden_type_recv_chan: LCOMM LCHAN hidden_type

  328 hidden_type_func: LFUNC '(' ohidden_funarg_list ')' ohidden_funres

  329 hidden_funarg: sym hidden_type oliteral
  330              | sym LDDD hidden_type oliteral

  331 hidden_structdcl: sym hidden_type oliteral

  332 hidden_interfacedcl: sym '(' ohidden_funarg_list ')' ohidden_funres
  333                    | hidden_type

  334 ohidden_funres: /* empty */
  335               | hidden_funres

  336 hidden_funres: '(' ohidden_funarg_list ')'
  337              | hidden_type

  338 hidden_literal: LLITERAL
  339               | '-' LLITERAL
  340               | sym

  341 hidden_constant: hidden_literal
  342                | '(' hidden_literal '+' hidden_literal ')'

  343 hidden_import_list: /* empty */
  344                   | hidden_import_list hidden_import

  345 hidden_funarg_list: hidden_funarg
  346                   | hidden_funarg_list ',' hidden_funarg

  347 hidden_structdcl_list: hidden_structdcl
  348                      | hidden_structdcl_list ';' hidden_structdcl

  349 hidden_interfacedcl_list: hidden_interfacedcl
  350                         | hidden_interfacedcl_list ';' hidden_interfacedcl


Terminals, with rules where they appear

$end (0) 0
'!' (33) 118
'$' (36) 22
'%' (37) 107
'&' (38) 108 115
'(' (40) 9 10 29 30 32 33 34 36 37 122 123 124 128 129 134 137 146
    170 179 204 205 206 207 208 213 231 233 234 240 241 325 328 332
    336 342
')' (41) 9 10 29 30 32 33 34 36 37 122 123 124 128 129 134 137 146
    170 179 204 205 206 207 208 213 231 233 234 240 241 325 328 332
    336 342
'*' (42) 105 114 174 197 232 233 234 323
'+' (43) 101 116 342
',' (44) 247 272 274 276 278 281 282 288 346
'-' (45) 102 117 339
'.' (46) 17 127 128 129 159 160 189 236
'/' (47) 106
':' (58) 55 56 57 58 131 132 140 261
';' (59) 3 7 14 18 33 69 76 218 220 222 224 226 228 270 286 303 304
    305 306 307 308 348 350
'=' (61) 40 41 42 43 51 56 67 305 306
'?' (63) 158 160
'@' (64) 159 160
'[' (91) 130 131 132 190 191 194 318 319 320
']' (93) 130 131 132 190 191 194 318 319 320
'^' (94) 104 120
'{' (123) 60 136 137 142 144 151 210 321 322
'|' (124) 103
'}' (125) 60 66 89 91 135 136 137 142 144 199 200 201 202 210 215 321
    322
'~' (126) 119
error (256) 27 216 254
LLITERAL (258) 15 16 17 125 159 160 302 303 319 338 339
LASOP (259) 50
LCOLAS (260) 52 57 68
LBREAK (261) 263
LCASE (262) 55 56 57
LCHAN (263) 192 193 198 324 325 326 327
LCONST (264) 38 305 306
LCONTINUE (265) 264
LDDD (266) 124 163 164 191 330
LDEFAULT (267) 58
LDEFER (268) 266
LELSE (269) 82 86
LFALL (270) 262
LFOR (271) 74
LFUNC (272) 203 208 308 328
LGO (273) 265
LGOTO (274) 267
LIF (275) 80 82
LIMPORT (276) 8 9 10 303
LINTERFACE (277) 201 202 322
LMAP (278) 194 320
LNAME (279) 18 20 156 159 235 236 303 317
LPACKAGE (280) 3 18
LRANGE (281) 67 68
LRETURN (282) 268
LSELECT (283) 91
LSTRUCT (284) 199 200 321
LSWITCH (285) 89
LTYPE (286) 35 36 37 129 307
LVAR (287) 28 29 30 304
LANDAND (288) 94
LANDNOT (289) 109
LBODY (290) 66 89 91 150
LCOMM (291) 112 121 193 198 326 327
LDEC (292) 54
LEQ (293) 95
LGE (294) 99
LGT (295) 100
LIGNORE (296)
LINC (297) 53
LLE (298) 98
LLSH (299) 110
LLT (300) 97
LNE (301) 96
LOROR (302) 93
LRSH (303) 111
NotPackage (304)
NotParen (305)
PreferToRightParen (306)


Nonterminals, with rules where they appear

$accept (76)
    on left: 0
file (77)
    on left: 1, on right: 0
package (78)
    on left: 2 3, on right: 1
loadsys (79)
    on left: 5, on right: 1
$@1 (80)
    on left: 4, on right: 5
imports (81)
    on left: 6 7, on right: 1 7
import (82)
    on left: 8 9 10, on right: 7
import_stmt (83)
    on left: 11 12, on right: 8 13 14
import_stmt_list (84)
    on left: 13 14, on right: 9 14
import_here (85)
    on left: 15 16 17, on right: 11 12
import_package (86)
    on left: 18, on right: 5 11
import_safety (87)
    on left: 19 20, on right: 18
import_there (88)
    on left: 22, on right: 5 11 12
$@2 (89)
    on left: 21, on right: 22
xdcl (90)
    on left: 23 24 25 26 27, on right: 218
common_dcl (91)
    on left: 28 29 30 31 32 33 34 35 36 37, on right: 24 252
lconst (92)
    on left: 38, on right: 31 32 33 34
vardcl (93)
    on left: 39 40 41, on right: 28 219 220
constdcl (94)
    on left: 42 43, on right: 31 32 33 44
constdcl1 (95)
    on left: 44 45 46, on right: 221 222
typedclname (96)
    on left: 47, on right: 48
typedcl (97)
    on left: 48, on right: 35 223 224
simple_stmt (98)
    on left: 49 50 51 52 53 54, on right: 255 294
case (99)
    on left: 55 56 57 58, on right: 62
compound_stmt (100)
    on left: 60, on right: 86 251
$@3 (101)
    on left: 59, on right: 60
caseblock (102)
    on left: 62, on right: 64
$@4 (103)
    on left: 61, on right: 62
caseblock_list (104)
    on left: 63 64, on right: 64 89 91
loop_body (105)
    on left: 66, on right: 72 80 82
$@5 (106)
    on left: 65, on right: 66
range_stmt (107)
    on left: 67 68, on right: 71
for_header (108)
    on left: 69 70 71, on right: 72
for_body (109)
    on left: 72, on right: 74
for_stmt (110)
    on left: 74, on right: 256
$@6 (111)
    on left: 73, on right: 74
if_header (112)
    on left: 75 76, on right: 80 82 89
if_stmt (113)
    on left: 80, on right: 259
$@7 (114)
    on left: 77, on right: 80
$@8 (115)
    on left: 78, on right: 80
$@9 (116)
    on left: 79, on right: 80
elseif (117)
    on left: 82, on right: 84
$@10 (118)
    on left: 81, on right: 82
elseif_list (119)
    on left: 83 84, on right: 80 84
else (120)
    on left: 85 86, on right: 80
switch_stmt (121)
    on left: 89, on right: 257
$@11 (122)
    on left: 87, on right: 89
$@12 (123)
    on left: 88, on right: 89
select_stmt (124)
    on left: 91, on right: 258
$@13 (125)
    on left: 90, on right: 91
expr (126)
    on left: 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107
    108 109 110 111 112, on right: 49 50 53 54 56 57 67 68 93 94 95
    96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112
    130 134 140 141 143 147 275 276 290
uexpr (127)
    on left: 113 114 115 116 117 118 119 120 121, on right: 92 114
    115 116 117 118 119 120 121
pseudocall (128)
    on left: 122 123 124, on right: 133 265 266
pexpr_no_paren (129)
    on left: 125 126 127 128 129 130 131 132 133 134 135 136 137 138,
    on right: 136 145
start_complit (130)
    on left: 139, on right: 135 136 137 142 144
keyval (131)
    on left: 140, on right: 279 281
bare_complitexpr (132)
    on left: 141 142, on right: 280 282
complitexpr (133)
    on left: 143 144, on right: 140
pexpr (134)
    on left: 145 146, on right: 113 122 123 124 127 128 129 130 131
    132
expr_or_type (135)
    on left: 147 148, on right: 128 137 146 277 278
name_or_type (136)
    on left: 149, on right: 242 243
lbrace (137)
    on left: 150 151, on right: 135 199 200 201 202 215
new_name (138)
    on left: 152, on right: 155 162 238 267 271 272
dcl_name (139)
    on left: 153, on right: 273 274
onew_name (140)
    on left: 154 155, on right: 263 264
sym (141)
    on left: 156 157 158, on right: 3 16 47 127 152 153 161 189 204
    205 207 236 243 244 329 330 331 332 340
hidden_importsym (142)
    on left: 159 160, on right: 157 309 316
name (143)
    on left: 161, on right: 126 188 189
labelname (144)
    on left: 162, on right: 261
dotdotdot (145)
    on left: 163 164, on right: 244 245
ntype (146)
    on left: 165 166 167 168 169 170, on right: 39 40 42 45 48 149
    164 170 179 190 191 193 194 197 198 229
non_expr_type (147)
    on left: 171 172 173 174, on right: 148 174
non_recvchantype (148)
    on left: 175 176 177 178 179, on right: 192
convtype (149)
    on left: 180 181, on right: 134
comptype (150)
    on left: 182, on right: 135
fnret_type (151)
    on left: 183 184 185 186 187, on right: 212
dotname (152)
    on left: 188 189, on right: 169 178 187
othertype (153)
    on left: 190 191 192 193 194 195 196, on right: 167 173 176 181
    182 185
ptrtype (154)
    on left: 197, on right: 168 177 186
recvchantype (155)
    on left: 198, on right: 165 171 183
structtype (156)
    on left: 199 200, on right: 195
interfacetype (157)
    on left: 201 202, on right: 196
xfndcl (158)
    on left: 203, on right: 25
fndcl (159)
    on left: 204 205, on right: 203
hidden_fndcl (160)
    on left: 206 207, on right: 308
fntype (161)
    on left: 208, on right: 166 172 175 180 184 214
fnbody (162)
    on left: 209 210, on right: 203 308
fnres (163)
    on left: 211 212 213, on right: 204 205 208 241
fnlitdcl (164)
    on left: 214, on right: 215 216
fnliteral (165)
    on left: 215 216, on right: 138
xdcl_list (166)
    on left: 217 218, on right: 1 218
vardcl_list (167)
    on left: 219 220, on right: 29 220
constdcl_list (168)
    on left: 221 222, on right: 33 222
typedcl_list (169)
    on left: 223 224, on right: 36 224
structdcl_list (170)
    on left: 225 226, on right: 199 226
interfacedcl_list (171)
    on left: 227 228, on right: 201 228
structdcl (172)
    on left: 229 230 231 232 233 234, on right: 225 226
packname (173)
    on left: 235 236, on right: 237 239 240
embed (174)
    on left: 237, on right: 230 231 232 233 234
interfacedcl (175)
    on left: 238 239 240, on right: 227 228
indcl (176)
    on left: 241, on right: 238
arg_type (177)
    on left: 242 243 244 245, on right: 246 247
arg_type_list (178)
    on left: 246 247, on right: 247 249
oarg_type_list_ocomma (179)
    on left: 248 249, on right: 204 205 208 213 241
stmt (180)
    on left: 250 251 252 253 254, on right: 261 269 270
non_dcl_stmt (181)
    on left: 255 256 257 258 259 261 262 263 264 265 266 267 268, on right:
    26 253
$@14 (182)
    on left: 260, on right: 261
stmt_list (183)
    on left: 269 270, on right: 60 62 66 210 215 270
new_name_list (184)
    on left: 271 272, on right: 229 272
dcl_name_list (185)
    on left: 273 274, on right: 39 40 41 42 43 45 46 274
expr_list (186)
    on left: 275 276, on right: 40 41 42 43 51 52 67 68 276 292
expr_or_type_list (187)
    on left: 277 278, on right: 55 56 57 123 124 278
keyval_list (188)
    on left: 279 280 281 282, on right: 281 282 284
braced_keyval_list (189)
    on left: 283 284, on right: 135 136 137 142 144
osemi (190)
    on left: 285 286, on right: 9 29 32 33 36 199 201
ocomma (191)
    on left: 287 288, on right: 123 124 134 249 284
oexpr (192)
    on left: 289 290, on right: 131 132 190
oexpr_list (193)
    on left: 291 292, on right: 268
osimple_stmt (194)
    on left: 293 294, on right: 69 70 75 76
ohidden_funarg_list (195)
    on left: 295 296, on right: 206 207 328 332 336
ohidden_structdcl_list (196)
    on left: 297 298, on right: 321
ohidden_interfacedcl_list (197)
    on left: 299 300, on right: 322
oliteral (198)
    on left: 301 302, on right: 229 230 231 232 233 234 329 330 331
hidden_import (199)
    on left: 303 304 305 306 307 308, on right: 344
hidden_pkg_importsym (200)
    on left: 309, on right: 206 304 305 306 310
hidden_pkgtype (201)
    on left: 310, on right: 307
hidden_type (202)
    on left: 311 312 313, on right: 304 306 307 318 319 320 323 326
    327 329 330 331 333 337
hidden_type_non_recv_chan (203)
    on left: 314 315, on right: 324
hidden_type_misc (204)
    on left: 316 317 318 319 320 321 322 323 324 325 326, on right:
    311 314
hidden_type_recv_chan (205)
    on left: 327, on right: 312 325
hidden_type_func (206)
    on left: 328, on right: 313 315
hidden_funarg (207)
    on left: 329 330, on right: 345 346
hidden_structdcl (208)
    on left: 331, on right: 347 348
hidden_interfacedcl (209)
    on left: 332 333, on right: 349 350
ohidden_funres (210)
    on left: 334 335, on right: 206 207 328 332
hidden_funres (211)
    on left: 336 337, on right: 335
hidden_literal (212)
    on left: 338 339 340, on right: 341 342
hidden_constant (213)
    on left: 341 342, on right: 305 306
hidden_import_list (214)
    on left: 343 344, on right: 22 344
hidden_funarg_list (215)
    on left: 345 346, on right: 207 296 346
hidden_structdcl_list (216)
    on left: 347 348, on right: 298 348
hidden_interfacedcl_list (217)
    on left: 349 350, on right: 300 350


state 0

    0 $accept: . file $end
    1 file: . loadsys package imports xdcl_list
    4 $@1: .
    5 loadsys: . $@1 import_package import_there

    $default  reduce using rule 4 ($@1)

    file     go to state 1
    loadsys  go to state 2
    $@1      go to state 3


state 1

    0 $accept: file . $end

    $end  shift, and go to state 4


state 2

    1 file: loadsys . package imports xdcl_list
    2 package: .  [$end, error, LLITERAL, LBREAK, LCHAN, LCONST, LCONTINUE, LDEFER, LFALL, LFOR, LFUNC, LGO, LGOTO, LIF, LIMPORT, LINTERFACE, LMAP, LNAME, LRETURN, LSELECT, LSTRUCT, LSWITCH, LTYPE, LVAR, LCOMM, '+', '-', '^', '*', '&', '(', ';', '!', '~', '[', '?', '@']
    3        | . LPACKAGE sym ';'

    LPACKAGE  shift, and go to state 5

    $default  reduce using rule 2 (package)

    package  go to state 6


state 3

    5 loadsys: $@1 . import_package import_there
   18 import_package: . LPACKAGE LNAME import_safety ';'

    LPACKAGE  shift, and go to state 7

    import_package  go to state 8


state 4

    0 $accept: file $end .

    $default  accept


state 5

    3 package: LPACKAGE . sym ';'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    sym               go to state 12
    hidden_importsym  go to state 13


state 6

    1 file: loadsys package . imports xdcl_list
    6 imports: .
    7        | . imports import ';'

    $default  reduce using rule 6 (imports)

    imports  go to state 14


state 7

   18 import_package: LPACKAGE . LNAME import_safety ';'

    LNAME  shift, and go to state 15


state 8

    5 loadsys: $@1 import_package . import_there
   21 $@2: .
   22 import_there: . $@2 hidden_import_list '$' '$'

    $default  reduce using rule 21 ($@2)

    import_there  go to state 16
    $@2           go to state 17


state 9

  156 sym: LNAME .

    $default  reduce using rule 156 (sym)


state 10

  158 sym: '?' .

    $default  reduce using rule 158 (sym)


state 11

  159 hidden_importsym: '@' . LLITERAL '.' LNAME
  160                 | '@' . LLITERAL '.' '?'

    LLITERAL  shift, and go to state 18


state 12

    3 package: LPACKAGE sym . ';'

    ';'  shift, and go to state 19


state 13

  157 sym: hidden_importsym .

    $default  reduce using rule 157 (sym)


state 14

    1 file: loadsys package imports . xdcl_list
    7 imports: imports . import ';'
    8 import: . LIMPORT import_stmt
    9       | . LIMPORT '(' import_stmt_list osemi ')'
   10       | . LIMPORT '(' ')'
  217 xdcl_list: .  [$end, error, LLITERAL, LBREAK, LCHAN, LCONST, LCONTINUE, LDEFER, LFALL, LFOR, LFUNC, LGO, LGOTO, LIF, LINTERFACE, LMAP, LNAME, LRETURN, LSELECT, LSTRUCT, LSWITCH, LTYPE, LVAR, LCOMM, '+', '-', '^', '*', '&', '(', ';', '!', '~', '[', '?', '@']
  218          | . xdcl_list xdcl ';'

    LIMPORT  shift, and go to state 20

    $default  reduce using rule 217 (xdcl_list)

    import     go to state 21
    xdcl_list  go to state 22


state 15

   18 import_package: LPACKAGE LNAME . import_safety ';'
   19 import_safety: .  [';']
   20              | . LNAME

    LNAME  shift, and go to state 23

    $default  reduce using rule 19 (import_safety)

    import_safety  go to state 24


state 16

    5 loadsys: $@1 import_package import_there .

    $default  reduce using rule 5 (loadsys)


state 17

   22 import_there: $@2 . hidden_import_list '$' '$'
  343 hidden_import_list: .
  344                   | . hidden_import_list hidden_import

    $default  reduce using rule 343 (hidden_import_list)

    hidden_import_list  go to state 25


state 18

  159 hidden_importsym: '@' LLITERAL . '.' LNAME
  160                 | '@' LLITERAL . '.' '?'

    '.'  shift, and go to state 26


state 19

    3 package: LPACKAGE sym ';' .

    $default  reduce using rule 3 (package)


state 20

    8 import: LIMPORT . import_stmt
    9       | LIMPORT . '(' import_stmt_list osemi ')'
   10       | LIMPORT . '(' ')'
   11 import_stmt: . import_here import_package import_there
   12            | . import_here import_there
   15 import_here: . LLITERAL
   16            | . sym LLITERAL
   17            | . '.' LLITERAL
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'

    LLITERAL  shift, and go to state 27
    LNAME     shift, and go to state 9
    '('       shift, and go to state 28
    '.'       shift, and go to state 29
    '?'       shift, and go to state 10
    '@'       shift, and go to state 11

    import_stmt       go to state 30
    import_here       go to state 31
    sym               go to state 32
    hidden_importsym  go to state 13


state 21

    7 imports: imports import . ';'

    ';'  shift, and go to state 33


state 22

    1 file: loadsys package imports xdcl_list .  [$end]
   23 xdcl: .  [';']
   24     | . common_dcl
   25     | . xfndcl
   26     | . non_dcl_stmt
   27     | . error
   28 common_dcl: . LVAR vardcl
   29           | . LVAR '(' vardcl_list osemi ')'
   30           | . LVAR '(' ')'
   31           | . lconst constdcl
   32           | . lconst '(' constdcl osemi ')'
   33           | . lconst '(' constdcl ';' constdcl_list osemi ')'
   34           | . lconst '(' ')'
   35           | . LTYPE typedcl
   36           | . LTYPE '(' typedcl_list osemi ')'
   37           | . LTYPE '(' ')'
   38 lconst: . LCONST
   49 simple_stmt: . expr
   50            | . expr LASOP expr
   51            | . expr_list '=' expr_list
   52            | . expr_list LCOLAS expr_list
   53            | . expr LINC
   54            | . expr LDEC
   74 for_stmt: . LFOR $@6 for_body
   80 if_stmt: . LIF $@7 if_header $@8 loop_body $@9 elseif_list else
   89 switch_stmt: . LSWITCH $@11 if_header $@12 LBODY caseblock_list '}'
   91 select_stmt: . LSELECT $@13 LBODY caseblock_list '}'
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  152 new_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  162 labelname: . new_name
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  203 xfndcl: . LFUNC fndcl fnbody
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  218 xdcl_list: xdcl_list . xdcl ';'
  255 non_dcl_stmt: . simple_stmt
  256             | . for_stmt
  257             | . switch_stmt
  258             | . select_stmt
  259             | . if_stmt
  261             | . labelname ':' $@14 stmt
  262             | . LFALL
  263             | . LBREAK onew_name
  264             | . LCONTINUE onew_name
  265             | . LGO pseudocall
  266             | . LDEFER pseudocall
  267             | . LGOTO new_name
  268             | . LRETURN oexpr_list
  275 expr_list: . expr
  276          | . expr_list ',' expr

    error       shift, and go to state 34
    LLITERAL    shift, and go to state 35
    LBREAK      shift, and go to state 36
    LCHAN       shift, and go to state 37
    LCONST      shift, and go to state 38
    LCONTINUE   shift, and go to state 39
    LDEFER      shift, and go to state 40
    LFALL       shift, and go to state 41
    LFOR        shift, and go to state 42
    LFUNC       shift, and go to state 43
    LGO         shift, and go to state 44
    LGOTO       shift, and go to state 45
    LIF         shift, and go to state 46
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LRETURN     shift, and go to state 49
    LSELECT     shift, and go to state 50
    LSTRUCT     shift, and go to state 51
    LSWITCH     shift, and go to state 52
    LTYPE       shift, and go to state 53
    LVAR        shift, and go to state 54
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $end  reduce using rule 1 (file)
    ';'   reduce using rule 23 (xdcl)

    xdcl              go to state 65
    common_dcl        go to state 66
    lconst            go to state 67
    simple_stmt       go to state 68
    for_stmt          go to state 69
    if_stmt           go to state 70
    switch_stmt       go to state 71
    select_stmt       go to state 72
    expr              go to state 73
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    new_name          go to state 78
    sym               go to state 79
    hidden_importsym  go to state 13
    name              go to state 80
    labelname         go to state 81
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    xfndcl            go to state 87
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    non_dcl_stmt      go to state 91
    expr_list         go to state 92


state 23

   20 import_safety: LNAME .

    $default  reduce using rule 20 (import_safety)


state 24

   18 import_package: LPACKAGE LNAME import_safety . ';'

    ';'  shift, and go to state 93


state 25

   22 import_there: $@2 hidden_import_list . '$' '$'
  303 hidden_import: . LIMPORT LNAME LLITERAL ';'
  304              | . LVAR hidden_pkg_importsym hidden_type ';'
  305              | . LCONST hidden_pkg_importsym '=' hidden_constant ';'
  306              | . LCONST hidden_pkg_importsym hidden_type '=' hidden_constant ';'
  307              | . LTYPE hidden_pkgtype hidden_type ';'
  308              | . LFUNC hidden_fndcl fnbody ';'
  344 hidden_import_list: hidden_import_list . hidden_import

    LCONST   shift, and go to state 94
    LFUNC    shift, and go to state 95
    LIMPORT  shift, and go to state 96
    LTYPE    shift, and go to state 97
    LVAR     shift, and go to state 98
    '$'      shift, and go to state 99

    hidden_import  go to state 100


state 26

  159 hidden_importsym: '@' LLITERAL '.' . LNAME
  160                 | '@' LLITERAL '.' . '?'

    LNAME  shift, and go to state 101
    '?'    shift, and go to state 102


state 27

   15 import_here: LLITERAL .

    $default  reduce using rule 15 (import_here)


state 28

    9 import: LIMPORT '(' . import_stmt_list osemi ')'
   10       | LIMPORT '(' . ')'
   11 import_stmt: . import_here import_package import_there
   12            | . import_here import_there
   13 import_stmt_list: . import_stmt
   14                 | . import_stmt_list ';' import_stmt
   15 import_here: . LLITERAL
   16            | . sym LLITERAL
   17            | . '.' LLITERAL
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'

    LLITERAL  shift, and go to state 27
    LNAME     shift, and go to state 9
    ')'       shift, and go to state 103
    '.'       shift, and go to state 29
    '?'       shift, and go to state 10
    '@'       shift, and go to state 11

    import_stmt       go to state 104
    import_stmt_list  go to state 105
    import_here       go to state 31
    sym               go to state 32
    hidden_importsym  go to state 13


state 29

   17 import_here: '.' . LLITERAL

    LLITERAL  shift, and go to state 106


state 30

    8 import: LIMPORT import_stmt .

    $default  reduce using rule 8 (import)


state 31

   11 import_stmt: import_here . import_package import_there
   12            | import_here . import_there
   18 import_package: . LPACKAGE LNAME import_safety ';'
   21 $@2: .  [LCONST, LFUNC, LIMPORT, LTYPE, LVAR, '$']
   22 import_there: . $@2 hidden_import_list '$' '$'

    LPACKAGE  shift, and go to state 7

    $default  reduce using rule 21 ($@2)

    import_package  go to state 107
    import_there    go to state 108
    $@2             go to state 17


state 32

   16 import_here: sym . LLITERAL

    LLITERAL  shift, and go to state 109


state 33

    7 imports: imports import ';' .

    $default  reduce using rule 7 (imports)


state 34

   27 xdcl: error .

    $default  reduce using rule 27 (xdcl)


state 35

  125 pexpr_no_paren: LLITERAL .

    $default  reduce using rule 125 (pexpr_no_paren)


state 36

  152 new_name: . sym
  154 onew_name: .  [LCASE, LDEFAULT, ';', '}']
  155          | . new_name
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  263 non_dcl_stmt: LBREAK . onew_name

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    $default  reduce using rule 154 (onew_name)

    new_name          go to state 110
    onew_name         go to state 111
    sym               go to state 112
    hidden_importsym  go to state 13


state 37

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  175 non_recvchantype: . fntype
  176                 | . othertype
  177                 | . ptrtype
  178                 | . dotname
  179                 | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  192          | LCHAN . non_recvchantype
  193          | . LCHAN LCOMM ntype
  193          | LCHAN . LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 114
    '*'         shift, and go to state 115
    '('         shift, and go to state 116
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    non_recvchantype  go to state 119
    dotname           go to state 120
    othertype         go to state 121
    ptrtype           go to state 122
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 123


state 38

   38 lconst: LCONST .

    $default  reduce using rule 38 (lconst)


state 39

  152 new_name: . sym
  154 onew_name: .  [LCASE, LDEFAULT, ';', '}']
  155          | . new_name
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  264 non_dcl_stmt: LCONTINUE . onew_name

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    $default  reduce using rule 154 (onew_name)

    new_name          go to state 110
    onew_name         go to state 124
    sym               go to state 112
    hidden_importsym  go to state 13


state 40

  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  266 non_dcl_stmt: LDEFER . pseudocall

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    '('         shift, and go to state 61
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    pseudocall        go to state 125
    pexpr_no_paren    go to state 76
    pexpr             go to state 126
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 41

  262 non_dcl_stmt: LFALL .

    $default  reduce using rule 262 (non_dcl_stmt)


state 42

   73 $@6: .
   74 for_stmt: LFOR . $@6 for_body

    $default  reduce using rule 73 ($@6)

    $@6  go to state 127


state 43

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  203 xfndcl: LFUNC . fndcl fnbody
  204 fndcl: . sym '(' oarg_type_list_ocomma ')' fnres
  205      | . '(' oarg_type_list_ocomma ')' sym '(' oarg_type_list_ocomma ')' fnres
  208 fntype: LFUNC . '(' oarg_type_list_ocomma ')' fnres

    LNAME  shift, and go to state 9
    '('    shift, and go to state 128
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    sym               go to state 129
    hidden_importsym  go to state 13
    fndcl             go to state 130


state 44

  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  265 non_dcl_stmt: LGO . pseudocall

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    '('         shift, and go to state 61
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    pseudocall        go to state 131
    pexpr_no_paren    go to state 76
    pexpr             go to state 126
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 45

  152 new_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  267 non_dcl_stmt: LGOTO . new_name

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    new_name          go to state 132
    sym               go to state 112
    hidden_importsym  go to state 13


state 46

   77 $@7: .
   80 if_stmt: LIF . $@7 if_header $@8 loop_body $@9 elseif_list else

    $default  reduce using rule 77 ($@7)

    $@7  go to state 133


state 47

  150 lbrace: . LBODY
  151       | . '{'
  201 interfacetype: LINTERFACE . lbrace interfacedcl_list osemi '}'
  202              | LINTERFACE . lbrace '}'

    LBODY  shift, and go to state 134
    '{'    shift, and go to state 135

    lbrace  go to state 136


state 48

  194 othertype: LMAP . '[' ntype ']' ntype

    '['  shift, and go to state 137


state 49

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  268 non_dcl_stmt: LRETURN . oexpr_list
  275 expr_list: . expr
  276          | . expr_list ',' expr
  291 oexpr_list: .  [LCASE, LDEFAULT, ';', '}']
  292           | . expr_list

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 291 (oexpr_list)

    expr              go to state 138
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    expr_list         go to state 139
    oexpr_list        go to state 140


state 50

   90 $@13: .
   91 select_stmt: LSELECT . $@13 LBODY caseblock_list '}'

    $default  reduce using rule 90 ($@13)

    $@13  go to state 141


state 51

  150 lbrace: . LBODY
  151       | . '{'
  199 structtype: LSTRUCT . lbrace structdcl_list osemi '}'
  200           | LSTRUCT . lbrace '}'

    LBODY  shift, and go to state 134
    '{'    shift, and go to state 135

    lbrace  go to state 142


state 52

   87 $@11: .
   89 switch_stmt: LSWITCH . $@11 if_header $@12 LBODY caseblock_list '}'

    $default  reduce using rule 87 ($@11)

    $@11  go to state 143


state 53

   35 common_dcl: LTYPE . typedcl
   36           | LTYPE . '(' typedcl_list osemi ')'
   37           | LTYPE . '(' ')'
   47 typedclname: . sym
   48 typedcl: . typedclname ntype
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'

    LNAME  shift, and go to state 9
    '('    shift, and go to state 144
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    typedclname       go to state 145
    typedcl           go to state 146
    sym               go to state 147
    hidden_importsym  go to state 13


state 54

   28 common_dcl: LVAR . vardcl
   29           | LVAR . '(' vardcl_list osemi ')'
   30           | LVAR . '(' ')'
   39 vardcl: . dcl_name_list ntype
   40       | . dcl_name_list ntype '=' expr_list
   41       | . dcl_name_list '=' expr_list
  153 dcl_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  273 dcl_name_list: . dcl_name
  274              | . dcl_name_list ',' dcl_name

    LNAME  shift, and go to state 9
    '('    shift, and go to state 148
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    vardcl            go to state 149
    dcl_name          go to state 150
    sym               go to state 151
    hidden_importsym  go to state 13
    dcl_name_list     go to state 152


state 55

  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  121      | LCOMM . uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    uexpr             go to state 153
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 56

  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  116      | '+' . uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    uexpr             go to state 154
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 57

  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  117      | '-' . uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    uexpr             go to state 155
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 58

  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  120      | '^' . uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    uexpr             go to state 156
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 59

  113 uexpr: . pexpr
  114      | . '*' uexpr
  114      | '*' . uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    uexpr             go to state 157
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 60

  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  115      | '&' . uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    uexpr             go to state 158
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 61

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  137               | '(' . expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  146      | '(' . expr_or_type ')'
  147 expr_or_type: . expr
  148             | . non_expr_type
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  171 non_expr_type: . recvchantype
  172              | . fntype
  173              | . othertype
  174              | . '*' non_expr_type
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 159
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 160
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 161
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    expr_or_type      go to state 162
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    non_expr_type     go to state 163
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 164
    recvchantype      go to state 165
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 166
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 62

  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  118      | '!' . uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    uexpr             go to state 167
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 63

  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  119      | '~' . uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    uexpr             go to state 168
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 64

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  190          | '[' . oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  191          | '[' . LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  289 oexpr: .  [']']
  290      | . expr

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LDDD        shift, and go to state 169
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 289 (oexpr)

    expr              go to state 170
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    oexpr             go to state 171


state 65

  218 xdcl_list: xdcl_list xdcl . ';'

    ';'  shift, and go to state 172


state 66

   24 xdcl: common_dcl .

    $default  reduce using rule 24 (xdcl)


state 67

   31 common_dcl: lconst . constdcl
   32           | lconst . '(' constdcl osemi ')'
   33           | lconst . '(' constdcl ';' constdcl_list osemi ')'
   34           | lconst . '(' ')'
   42 constdcl: . dcl_name_list ntype '=' expr_list
   43         | . dcl_name_list '=' expr_list
  153 dcl_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  273 dcl_name_list: . dcl_name
  274              | . dcl_name_list ',' dcl_name

    LNAME  shift, and go to state 9
    '('    shift, and go to state 173
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    constdcl          go to state 174
    dcl_name          go to state 150
    sym               go to state 151
    hidden_importsym  go to state 13
    dcl_name_list     go to state 175


state 68

  255 non_dcl_stmt: simple_stmt .

    $default  reduce using rule 255 (non_dcl_stmt)


state 69

  256 non_dcl_stmt: for_stmt .

    $default  reduce using rule 256 (non_dcl_stmt)


state 70

  259 non_dcl_stmt: if_stmt .

    $default  reduce using rule 259 (non_dcl_stmt)


state 71

  257 non_dcl_stmt: switch_stmt .

    $default  reduce using rule 257 (non_dcl_stmt)


state 72

  258 non_dcl_stmt: select_stmt .

    $default  reduce using rule 258 (non_dcl_stmt)


state 73

   49 simple_stmt: expr .  [LCASE, LDEFAULT, LBODY, ';', '}']
   50            | expr . LASOP expr
   53            | expr . LINC
   54            | expr . LDEC
   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr
  275 expr_list: expr .  [LCOLAS, '=', ',']

    LASOP    shift, and go to state 176
    LANDAND  shift, and go to state 177
    LANDNOT  shift, and go to state 178
    LCOMM    shift, and go to state 179
    LDEC     shift, and go to state 180
    LEQ      shift, and go to state 181
    LGE      shift, and go to state 182
    LGT      shift, and go to state 183
    LINC     shift, and go to state 184
    LLE      shift, and go to state 185
    LLSH     shift, and go to state 186
    LLT      shift, and go to state 187
    LNE      shift, and go to state 188
    LOROR    shift, and go to state 189
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    LCOLAS    reduce using rule 275 (expr_list)
    '='       reduce using rule 275 (expr_list)
    ','       reduce using rule 275 (expr_list)
    $default  reduce using rule 49 (simple_stmt)


state 74

   92 expr: uexpr .

    $default  reduce using rule 92 (expr)


state 75

  133 pexpr_no_paren: pseudocall .

    $default  reduce using rule 133 (pexpr_no_paren)


state 76

  136 pexpr_no_paren: pexpr_no_paren . '{' start_complit braced_keyval_list '}'
  145 pexpr: pexpr_no_paren .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LANDNOT, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLSH, LLT, LNE, LOROR, LRSH, '+', '-', '|', '^', '*', '/', '%', '&', '(', ')', ';', '.', '=', ':', '}', '[', ']', ',']

    '{'  shift, and go to state 199

    $default  reduce using rule 145 (pexpr)


state 77

  113 uexpr: pexpr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LANDNOT, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLSH, LLT, LNE, LOROR, LRSH, '+', '-', '|', '^', '*', '/', '%', '&', ')', ';', '=', ':', '}', ']', ',']
  122 pseudocall: pexpr . '(' ')'
  123           | pexpr . '(' expr_or_type_list ocomma ')'
  124           | pexpr . '(' expr_or_type_list LDDD ocomma ')'
  127 pexpr_no_paren: pexpr . '.' sym
  128               | pexpr . '.' '(' expr_or_type ')'
  129               | pexpr . '.' '(' LTYPE ')'
  130               | pexpr . '[' expr ']'
  131               | pexpr . '[' oexpr ':' oexpr ']'
  132               | pexpr . '[' oexpr ':' oexpr ':' oexpr ']'

    '('  shift, and go to state 200
    '.'  shift, and go to state 201
    '['  shift, and go to state 202

    $default  reduce using rule 113 (uexpr)


state 78

  162 labelname: new_name .

    $default  reduce using rule 162 (labelname)


state 79

  152 new_name: sym .  [':']
  161 name: sym .  [LASOP, LCOLAS, LCASE, LDEFAULT, LANDAND, LANDNOT, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLSH, LLT, LNE, LOROR, LRSH, '+', '-', '|', '^', '*', '/', '%', '&', '(', ';', '.', '=', '{', '}', '[', ',']

    ':'       reduce using rule 152 (new_name)
    $default  reduce using rule 161 (name)


state 80

  126 pexpr_no_paren: name .

    $default  reduce using rule 126 (pexpr_no_paren)


state 81

  261 non_dcl_stmt: labelname . ':' $@14 stmt

    ':'  shift, and go to state 203


state 82

  134 pexpr_no_paren: convtype . '(' expr ocomma ')'

    '('  shift, and go to state 204


state 83

  135 pexpr_no_paren: comptype . lbrace start_complit braced_keyval_list '}'
  150 lbrace: . LBODY
  151       | . '{'

    LBODY  shift, and go to state 134
    '{'    shift, and go to state 135

    lbrace  go to state 205


state 84

  181 convtype: othertype .  ['(']
  182 comptype: othertype .  [LBODY, '{']

    '('       reduce using rule 181 (convtype)
    $default  reduce using rule 182 (comptype)


state 85

  195 othertype: structtype .

    $default  reduce using rule 195 (othertype)


state 86

  196 othertype: interfacetype .

    $default  reduce using rule 196 (othertype)


state 87

   25 xdcl: xfndcl .

    $default  reduce using rule 25 (xdcl)


state 88

  180 convtype: fntype .  ['(']
  214 fnlitdcl: fntype .  [error, LBODY, '{']

    '('       reduce using rule 180 (convtype)
    $default  reduce using rule 214 (fnlitdcl)


state 89

  150 lbrace: . LBODY
  151       | . '{'
  215 fnliteral: fnlitdcl . lbrace stmt_list '}'
  216          | fnlitdcl . error

    error  shift, and go to state 206
    LBODY  shift, and go to state 134
    '{'    shift, and go to state 135

    lbrace  go to state 207


state 90

  138 pexpr_no_paren: fnliteral .

    $default  reduce using rule 138 (pexpr_no_paren)


state 91

   26 xdcl: non_dcl_stmt .

    $default  reduce using rule 26 (xdcl)


state 92

   51 simple_stmt: expr_list . '=' expr_list
   52            | expr_list . LCOLAS expr_list
  276 expr_list: expr_list . ',' expr

    LCOLAS  shift, and go to state 208
    '='     shift, and go to state 209
    ','     shift, and go to state 210


state 93

   18 import_package: LPACKAGE LNAME import_safety ';' .

    $default  reduce using rule 18 (import_package)


state 94

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  305 hidden_import: LCONST . hidden_pkg_importsym '=' hidden_constant ';'
  306              | LCONST . hidden_pkg_importsym hidden_type '=' hidden_constant ';'
  309 hidden_pkg_importsym: . hidden_importsym

    '@'  shift, and go to state 11

    hidden_importsym      go to state 211
    hidden_pkg_importsym  go to state 212


state 95

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  206 hidden_fndcl: . hidden_pkg_importsym '(' ohidden_funarg_list ')' ohidden_funres
  207             | . '(' hidden_funarg_list ')' sym '(' ohidden_funarg_list ')' ohidden_funres
  308 hidden_import: LFUNC . hidden_fndcl fnbody ';'
  309 hidden_pkg_importsym: . hidden_importsym

    '('  shift, and go to state 213
    '@'  shift, and go to state 11

    hidden_importsym      go to state 211
    hidden_fndcl          go to state 214
    hidden_pkg_importsym  go to state 215


state 96

  303 hidden_import: LIMPORT . LNAME LLITERAL ';'

    LNAME  shift, and go to state 216


state 97

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  307 hidden_import: LTYPE . hidden_pkgtype hidden_type ';'
  309 hidden_pkg_importsym: . hidden_importsym
  310 hidden_pkgtype: . hidden_pkg_importsym

    '@'  shift, and go to state 11

    hidden_importsym      go to state 211
    hidden_pkg_importsym  go to state 217
    hidden_pkgtype        go to state 218


state 98

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  304 hidden_import: LVAR . hidden_pkg_importsym hidden_type ';'
  309 hidden_pkg_importsym: . hidden_importsym

    '@'  shift, and go to state 11

    hidden_importsym      go to state 211
    hidden_pkg_importsym  go to state 219


state 99

   22 import_there: $@2 hidden_import_list '$' . '$'

    '$'  shift, and go to state 220


state 100

  344 hidden_import_list: hidden_import_list hidden_import .

    $default  reduce using rule 344 (hidden_import_list)


state 101

  159 hidden_importsym: '@' LLITERAL '.' LNAME .

    $default  reduce using rule 159 (hidden_importsym)


state 102

  160 hidden_importsym: '@' LLITERAL '.' '?' .

    $default  reduce using rule 160 (hidden_importsym)


state 103

   10 import: LIMPORT '(' ')' .

    $default  reduce using rule 10 (import)


state 104

   13 import_stmt_list: import_stmt .

    $default  reduce using rule 13 (import_stmt_list)


state 105

    9 import: LIMPORT '(' import_stmt_list . osemi ')'
   14 import_stmt_list: import_stmt_list . ';' import_stmt
  285 osemi: .  [')']
  286      | . ';'

    ';'  shift, and go to state 221

    $default  reduce using rule 285 (osemi)

    osemi  go to state 222


state 106

   17 import_here: '.' LLITERAL .

    $default  reduce using rule 17 (import_here)


state 107

   11 import_stmt: import_here import_package . import_there
   21 $@2: .
   22 import_there: . $@2 hidden_import_list '$' '$'

    $default  reduce using rule 21 ($@2)

    import_there  go to state 223
    $@2           go to state 17


state 108

   12 import_stmt: import_here import_there .

    $default  reduce using rule 12 (import_stmt)


state 109

   16 import_here: sym LLITERAL .

    $default  reduce using rule 16 (import_here)


state 110

  155 onew_name: new_name .

    $default  reduce using rule 155 (onew_name)


state 111

  263 non_dcl_stmt: LBREAK onew_name .

    $default  reduce using rule 263 (non_dcl_stmt)


state 112

  152 new_name: sym .

    $default  reduce using rule 152 (new_name)


state 113

  208 fntype: LFUNC . '(' oarg_type_list_ocomma ')' fnres

    '('  shift, and go to state 224


state 114

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  193          | LCHAN LCOMM . ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    ntype             go to state 227
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232


state 115

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  197        | '*' . ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    ntype             go to state 233
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232


state 116

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  179 non_recvchantype: '(' . ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    ntype             go to state 234
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232


state 117

  161 name: sym .

    $default  reduce using rule 161 (name)


state 118

  188 dotname: name .  [error, LLITERAL, LCOLAS, LCASE, LDDD, LDEFAULT, LBODY, '(', ')', ';', '=', ':', '{', '}', ']', ',']
  189        | name . '.' sym

    '.'  shift, and go to state 235

    $default  reduce using rule 188 (dotname)


state 119

  192 othertype: LCHAN non_recvchantype .

    $default  reduce using rule 192 (othertype)


state 120

  178 non_recvchantype: dotname .

    $default  reduce using rule 178 (non_recvchantype)


state 121

  176 non_recvchantype: othertype .

    $default  reduce using rule 176 (non_recvchantype)


state 122

  177 non_recvchantype: ptrtype .

    $default  reduce using rule 177 (non_recvchantype)


state 123

  175 non_recvchantype: fntype .

    $default  reduce using rule 175 (non_recvchantype)


state 124

  264 non_dcl_stmt: LCONTINUE onew_name .

    $default  reduce using rule 264 (non_dcl_stmt)


state 125

  133 pexpr_no_paren: pseudocall .  ['(', '.', '{', '[']
  266 non_dcl_stmt: LDEFER pseudocall .  [LCASE, LDEFAULT, ';', '}']

    LCASE     reduce using rule 266 (non_dcl_stmt)
    LDEFAULT  reduce using rule 266 (non_dcl_stmt)
    ';'       reduce using rule 266 (non_dcl_stmt)
    '}'       reduce using rule 266 (non_dcl_stmt)
    $default  reduce using rule 133 (pexpr_no_paren)


state 126

  122 pseudocall: pexpr . '(' ')'
  123           | pexpr . '(' expr_or_type_list ocomma ')'
  124           | pexpr . '(' expr_or_type_list LDDD ocomma ')'
  127 pexpr_no_paren: pexpr . '.' sym
  128               | pexpr . '.' '(' expr_or_type ')'
  129               | pexpr . '.' '(' LTYPE ')'
  130               | pexpr . '[' expr ']'
  131               | pexpr . '[' oexpr ':' oexpr ']'
  132               | pexpr . '[' oexpr ':' oexpr ':' oexpr ']'

    '('  shift, and go to state 200
    '.'  shift, and go to state 201
    '['  shift, and go to state 202


state 127

   49 simple_stmt: . expr
   50            | . expr LASOP expr
   51            | . expr_list '=' expr_list
   52            | . expr_list LCOLAS expr_list
   53            | . expr LINC
   54            | . expr LDEC
   67 range_stmt: . expr_list '=' LRANGE expr
   68           | . expr_list LCOLAS LRANGE expr
   69 for_header: . osimple_stmt ';' osimple_stmt ';' osimple_stmt
   70           | . osimple_stmt
   71           | . range_stmt
   72 for_body: . for_header loop_body
   74 for_stmt: LFOR $@6 . for_body
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  275 expr_list: . expr
  276          | . expr_list ',' expr
  293 osimple_stmt: .  [LBODY, ';']
  294             | . simple_stmt

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 293 (osimple_stmt)

    simple_stmt       go to state 236
    range_stmt        go to state 237
    for_header        go to state 238
    for_body          go to state 239
    expr              go to state 73
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    expr_list         go to state 240
    osimple_stmt      go to state 241


state 128

  149 name_or_type: . ntype
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  163 dotdotdot: . LDDD
  164          | . LDDD ntype
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  205 fndcl: '(' . oarg_type_list_ocomma ')' sym '(' oarg_type_list_ocomma ')' fnres
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  208       | LFUNC '(' . oarg_type_list_ocomma ')' fnres
  242 arg_type: . name_or_type
  243         | . sym name_or_type
  244         | . sym dotdotdot
  245         | . dotdotdot
  246 arg_type_list: . arg_type
  247              | . arg_type_list ',' arg_type
  248 oarg_type_list_ocomma: .  [')']
  249                      | . arg_type_list ocomma

    LCHAN       shift, and go to state 37
    LDDD        shift, and go to state 242
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 248 (oarg_type_list_ocomma)

    name_or_type           go to state 243
    sym                    go to state 244
    hidden_importsym       go to state 13
    name                   go to state 118
    dotdotdot              go to state 245
    ntype                  go to state 246
    dotname                go to state 228
    othertype              go to state 229
    ptrtype                go to state 230
    recvchantype           go to state 231
    structtype             go to state 85
    interfacetype          go to state 86
    fntype                 go to state 232
    arg_type               go to state 247
    arg_type_list          go to state 248
    oarg_type_list_ocomma  go to state 249


state 129

  204 fndcl: sym . '(' oarg_type_list_ocomma ')' fnres

    '('  shift, and go to state 250


state 130

  203 xfndcl: LFUNC fndcl . fnbody
  209 fnbody: .  [';']
  210       | . '{' stmt_list '}'

    '{'  shift, and go to state 251

    $default  reduce using rule 209 (fnbody)

    fnbody  go to state 252


state 131

  133 pexpr_no_paren: pseudocall .  ['(', '.', '{', '[']
  265 non_dcl_stmt: LGO pseudocall .  [LCASE, LDEFAULT, ';', '}']

    LCASE     reduce using rule 265 (non_dcl_stmt)
    LDEFAULT  reduce using rule 265 (non_dcl_stmt)
    ';'       reduce using rule 265 (non_dcl_stmt)
    '}'       reduce using rule 265 (non_dcl_stmt)
    $default  reduce using rule 133 (pexpr_no_paren)


state 132

  267 non_dcl_stmt: LGOTO new_name .

    $default  reduce using rule 267 (non_dcl_stmt)


state 133

   49 simple_stmt: . expr
   50            | . expr LASOP expr
   51            | . expr_list '=' expr_list
   52            | . expr_list LCOLAS expr_list
   53            | . expr LINC
   54            | . expr LDEC
   75 if_header: . osimple_stmt
   76          | . osimple_stmt ';' osimple_stmt
   80 if_stmt: LIF $@7 . if_header $@8 loop_body $@9 elseif_list else
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  275 expr_list: . expr
  276          | . expr_list ',' expr
  293 osimple_stmt: .  [LBODY, ';']
  294             | . simple_stmt

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 293 (osimple_stmt)

    simple_stmt       go to state 236
    if_header         go to state 253
    expr              go to state 73
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    expr_list         go to state 92
    osimple_stmt      go to state 254


state 134

  150 lbrace: LBODY .

    $default  reduce using rule 150 (lbrace)


state 135

  151 lbrace: '{' .

    $default  reduce using rule 151 (lbrace)


state 136

  152 new_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  201 interfacetype: LINTERFACE lbrace . interfacedcl_list osemi '}'
  202              | LINTERFACE lbrace . '}'
  227 interfacedcl_list: . interfacedcl
  228                  | . interfacedcl_list ';' interfacedcl
  235 packname: . LNAME
  236         | . LNAME '.' sym
  238 interfacedcl: . new_name indcl
  239             | . packname
  240             | . '(' packname ')'

    LNAME  shift, and go to state 255
    '('    shift, and go to state 256
    '}'    shift, and go to state 257
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    new_name           go to state 258
    sym                go to state 112
    hidden_importsym   go to state 13
    interfacedcl_list  go to state 259
    packname           go to state 260
    interfacedcl       go to state 261


state 137

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  194          | LMAP '[' . ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    ntype             go to state 262
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232


state 138

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr
  275 expr_list: expr .  [LCASE, LDEFAULT, LBODY, ')', ';', '}', ',']

    LANDAND  shift, and go to state 177
    LANDNOT  shift, and go to state 178
    LCOMM    shift, and go to state 179
    LEQ      shift, and go to state 181
    LGE      shift, and go to state 182
    LGT      shift, and go to state 183
    LLE      shift, and go to state 185
    LLSH     shift, and go to state 186
    LLT      shift, and go to state 187
    LNE      shift, and go to state 188
    LOROR    shift, and go to state 189
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 275 (expr_list)


state 139

  276 expr_list: expr_list . ',' expr
  292 oexpr_list: expr_list .  [LCASE, LDEFAULT, ';', '}']

    ','  shift, and go to state 210

    $default  reduce using rule 292 (oexpr_list)


state 140

  268 non_dcl_stmt: LRETURN oexpr_list .

    $default  reduce using rule 268 (non_dcl_stmt)


state 141

   91 select_stmt: LSELECT $@13 . LBODY caseblock_list '}'

    LBODY  shift, and go to state 263


state 142

  152 new_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  199 structtype: LSTRUCT lbrace . structdcl_list osemi '}'
  200           | LSTRUCT lbrace . '}'
  225 structdcl_list: . structdcl
  226               | . structdcl_list ';' structdcl
  229 structdcl: . new_name_list ntype oliteral
  230          | . embed oliteral
  231          | . '(' embed ')' oliteral
  232          | . '*' embed oliteral
  233          | . '(' '*' embed ')' oliteral
  234          | . '*' '(' embed ')' oliteral
  235 packname: . LNAME
  236         | . LNAME '.' sym
  237 embed: . packname
  271 new_name_list: . new_name
  272              | . new_name_list ',' new_name

    LNAME  shift, and go to state 255
    '*'    shift, and go to state 264
    '('    shift, and go to state 265
    '}'    shift, and go to state 266
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    new_name          go to state 267
    sym               go to state 112
    hidden_importsym  go to state 13
    structdcl_list    go to state 268
    structdcl         go to state 269
    packname          go to state 270
    embed             go to state 271
    new_name_list     go to state 272


state 143

   49 simple_stmt: . expr
   50            | . expr LASOP expr
   51            | . expr_list '=' expr_list
   52            | . expr_list LCOLAS expr_list
   53            | . expr LINC
   54            | . expr LDEC
   75 if_header: . osimple_stmt
   76          | . osimple_stmt ';' osimple_stmt
   89 switch_stmt: LSWITCH $@11 . if_header $@12 LBODY caseblock_list '}'
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  275 expr_list: . expr
  276          | . expr_list ',' expr
  293 osimple_stmt: .  [LBODY, ';']
  294             | . simple_stmt

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 293 (osimple_stmt)

    simple_stmt       go to state 236
    if_header         go to state 273
    expr              go to state 73
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    expr_list         go to state 92
    osimple_stmt      go to state 254


state 144

   36 common_dcl: LTYPE '(' . typedcl_list osemi ')'
   37           | LTYPE '(' . ')'
   47 typedclname: . sym
   48 typedcl: . typedclname ntype
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  223 typedcl_list: . typedcl
  224             | . typedcl_list ';' typedcl

    LNAME  shift, and go to state 9
    ')'    shift, and go to state 274
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    typedclname       go to state 145
    typedcl           go to state 275
    sym               go to state 147
    hidden_importsym  go to state 13
    typedcl_list      go to state 276


state 145

   48 typedcl: typedclname . ntype
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    ntype             go to state 277
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232


state 146

   35 common_dcl: LTYPE typedcl .

    $default  reduce using rule 35 (common_dcl)


state 147

   47 typedclname: sym .

    $default  reduce using rule 47 (typedclname)


state 148

   29 common_dcl: LVAR '(' . vardcl_list osemi ')'
   30           | LVAR '(' . ')'
   39 vardcl: . dcl_name_list ntype
   40       | . dcl_name_list ntype '=' expr_list
   41       | . dcl_name_list '=' expr_list
  153 dcl_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  219 vardcl_list: . vardcl
  220            | . vardcl_list ';' vardcl
  273 dcl_name_list: . dcl_name
  274              | . dcl_name_list ',' dcl_name

    LNAME  shift, and go to state 9
    ')'    shift, and go to state 278
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    vardcl            go to state 279
    dcl_name          go to state 150
    sym               go to state 151
    hidden_importsym  go to state 13
    vardcl_list       go to state 280
    dcl_name_list     go to state 152


state 149

   28 common_dcl: LVAR vardcl .

    $default  reduce using rule 28 (common_dcl)


state 150

  273 dcl_name_list: dcl_name .

    $default  reduce using rule 273 (dcl_name_list)


state 151

  153 dcl_name: sym .

    $default  reduce using rule 153 (dcl_name)


state 152

   39 vardcl: dcl_name_list . ntype
   40       | dcl_name_list . ntype '=' expr_list
   41       | dcl_name_list . '=' expr_list
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  274 dcl_name_list: dcl_name_list . ',' dcl_name

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '='         shift, and go to state 281
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11
    ','         shift, and go to state 282

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    ntype             go to state 283
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232


state 153

  121 uexpr: LCOMM uexpr .

    $default  reduce using rule 121 (uexpr)


state 154

  116 uexpr: '+' uexpr .

    $default  reduce using rule 116 (uexpr)


state 155

  117 uexpr: '-' uexpr .

    $default  reduce using rule 117 (uexpr)


state 156

  120 uexpr: '^' uexpr .

    $default  reduce using rule 120 (uexpr)


state 157

  114 uexpr: '*' uexpr .

    $default  reduce using rule 114 (uexpr)


state 158

  115 uexpr: '&' uexpr .

    $default  reduce using rule 115 (uexpr)


state 159

  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  121      | LCOMM . uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  198 recvchantype: LCOMM . LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 284
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    uexpr             go to state 153
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 160

  113 uexpr: . pexpr
  114      | . '*' uexpr
  114      | '*' . uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  171 non_expr_type: . recvchantype
  172              | . fntype
  173              | . othertype
  174              | . '*' non_expr_type
  174              | '*' . non_expr_type
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 159
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 160
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    uexpr             go to state 157
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    non_expr_type     go to state 285
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 164
    recvchantype      go to state 165
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 166
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 161

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr
  147 expr_or_type: expr .  [LCOLAS, LDDD, ')', '=', ':', ',']

    LANDAND  shift, and go to state 177
    LANDNOT  shift, and go to state 178
    LCOMM    shift, and go to state 179
    LEQ      shift, and go to state 181
    LGE      shift, and go to state 182
    LGT      shift, and go to state 183
    LLE      shift, and go to state 185
    LLSH     shift, and go to state 186
    LLT      shift, and go to state 187
    LNE      shift, and go to state 188
    LOROR    shift, and go to state 189
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 147 (expr_or_type)


state 162

  137 pexpr_no_paren: '(' expr_or_type . ')' '{' start_complit braced_keyval_list '}'
  146 pexpr: '(' expr_or_type . ')'

    ')'  shift, and go to state 286


state 163

  148 expr_or_type: non_expr_type .

    $default  reduce using rule 148 (expr_or_type)


state 164

  173 non_expr_type: othertype .  [LCOLAS, LDDD, ')', '=', ':', ',']
  181 convtype: othertype .  ['(']
  182 comptype: othertype .  [LBODY, '{']

    LBODY     reduce using rule 182 (comptype)
    '('       reduce using rule 181 (convtype)
    '{'       reduce using rule 182 (comptype)
    $default  reduce using rule 173 (non_expr_type)


state 165

  171 non_expr_type: recvchantype .

    $default  reduce using rule 171 (non_expr_type)


state 166

  172 non_expr_type: fntype .  [LCOLAS, LDDD, ')', '=', ':', ',']
  180 convtype: fntype .  ['(']
  214 fnlitdcl: fntype .  [error, LBODY, '{']

    error     reduce using rule 214 (fnlitdcl)
    LBODY     reduce using rule 214 (fnlitdcl)
    '('       reduce using rule 180 (convtype)
    '{'       reduce using rule 214 (fnlitdcl)
    $default  reduce using rule 172 (non_expr_type)


state 167

  118 uexpr: '!' uexpr .

    $default  reduce using rule 118 (uexpr)


state 168

  119 uexpr: '~' uexpr .

    $default  reduce using rule 119 (uexpr)


state 169

  191 othertype: '[' LDDD . ']' ntype

    ']'  shift, and go to state 287


state 170

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr
  290 oexpr: expr .  [':', ']']

    LANDAND  shift, and go to state 177
    LANDNOT  shift, and go to state 178
    LCOMM    shift, and go to state 179
    LEQ      shift, and go to state 181
    LGE      shift, and go to state 182
    LGT      shift, and go to state 183
    LLE      shift, and go to state 185
    LLSH     shift, and go to state 186
    LLT      shift, and go to state 187
    LNE      shift, and go to state 188
    LOROR    shift, and go to state 189
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 290 (oexpr)


state 171

  190 othertype: '[' oexpr . ']' ntype

    ']'  shift, and go to state 288


state 172

  218 xdcl_list: xdcl_list xdcl ';' .

    $default  reduce using rule 218 (xdcl_list)


state 173

   32 common_dcl: lconst '(' . constdcl osemi ')'
   33           | lconst '(' . constdcl ';' constdcl_list osemi ')'
   34           | lconst '(' . ')'
   42 constdcl: . dcl_name_list ntype '=' expr_list
   43         | . dcl_name_list '=' expr_list
  153 dcl_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  273 dcl_name_list: . dcl_name
  274              | . dcl_name_list ',' dcl_name

    LNAME  shift, and go to state 9
    ')'    shift, and go to state 289
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    constdcl          go to state 290
    dcl_name          go to state 150
    sym               go to state 151
    hidden_importsym  go to state 13
    dcl_name_list     go to state 175


state 174

   31 common_dcl: lconst constdcl .

    $default  reduce using rule 31 (common_dcl)


state 175

   42 constdcl: dcl_name_list . ntype '=' expr_list
   43         | dcl_name_list . '=' expr_list
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  274 dcl_name_list: dcl_name_list . ',' dcl_name

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '='         shift, and go to state 291
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11
    ','         shift, and go to state 282

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    ntype             go to state 292
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232


state 176

   50 simple_stmt: expr LASOP . expr
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 293
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 177

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   94     | expr LANDAND . expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 294
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 178

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  109     | expr LANDNOT . expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 295
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 179

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  112     | expr LCOMM . expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 296
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 180

   54 simple_stmt: expr LDEC .

    $default  reduce using rule 54 (simple_stmt)


state 181

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   95     | expr LEQ . expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 297
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 182

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
   99     | expr LGE . expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 298
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 183

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  100     | expr LGT . expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 299
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 184

   53 simple_stmt: expr LINC .

    $default  reduce using rule 53 (simple_stmt)


state 185

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   98     | expr LLE . expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 300
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 186

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  110     | expr LLSH . expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 301
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 187

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   97     | expr LLT . expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 302
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 188

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   96     | expr LNE . expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 303
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 189

   92 expr: . uexpr
   93     | . expr LOROR expr
   93     | expr LOROR . expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 304
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 190

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  111     | expr LRSH . expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 305
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 191

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  101     | expr '+' . expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 306
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 192

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  102     | expr '-' . expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 307
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 193

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  103     | expr '|' . expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 308
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 194

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  104     | expr '^' . expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 309
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 195

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  105     | expr '*' . expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 310
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 196

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  106     | expr '/' . expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 311
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 197

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  107     | expr '%' . expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 312
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 198

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  108     | expr '&' . expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 313
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 199

  136 pexpr_no_paren: pexpr_no_paren '{' . start_complit braced_keyval_list '}'
  139 start_complit: .

    $default  reduce using rule 139 (start_complit)

    start_complit  go to state 314


state 200

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  122           | pexpr '(' . ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  123           | pexpr '(' . expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  124           | pexpr '(' . expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  147 expr_or_type: . expr
  148             | . non_expr_type
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  171 non_expr_type: . recvchantype
  172              | . fntype
  173              | . othertype
  174              | . '*' non_expr_type
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  277 expr_or_type_list: . expr_or_type
  278                  | . expr_or_type_list ',' expr_or_type

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 159
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 160
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    ')'         shift, and go to state 315
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr               go to state 161
    uexpr              go to state 74
    pseudocall         go to state 75
    pexpr_no_paren     go to state 76
    pexpr              go to state 77
    expr_or_type       go to state 316
    sym                go to state 117
    hidden_importsym   go to state 13
    name               go to state 80
    non_expr_type      go to state 163
    convtype           go to state 82
    comptype           go to state 83
    othertype          go to state 164
    recvchantype       go to state 165
    structtype         go to state 85
    interfacetype      go to state 86
    fntype             go to state 166
    fnlitdcl           go to state 89
    fnliteral          go to state 90
    expr_or_type_list  go to state 317


state 201

  127 pexpr_no_paren: pexpr '.' . sym
  128               | pexpr '.' . '(' expr_or_type ')'
  129               | pexpr '.' . '(' LTYPE ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'

    LNAME  shift, and go to state 9
    '('    shift, and go to state 318
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    sym               go to state 319
    hidden_importsym  go to state 13


state 202

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  130               | pexpr '[' . expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  131               | pexpr '[' . oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  132               | pexpr '[' . oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  289 oexpr: .  [':']
  290      | . expr

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 289 (oexpr)

    expr              go to state 320
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    oexpr             go to state 321


state 203

  260 $@14: .
  261 non_dcl_stmt: labelname ':' . $@14 stmt

    $default  reduce using rule 260 ($@14)

    $@14  go to state 322


state 204

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  134               | convtype '(' . expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 323
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 205

  135 pexpr_no_paren: comptype lbrace . start_complit braced_keyval_list '}'
  139 start_complit: .

    $default  reduce using rule 139 (start_complit)

    start_complit  go to state 324


state 206

  216 fnliteral: fnlitdcl error .

    $default  reduce using rule 216 (fnliteral)


state 207

   28 common_dcl: . LVAR vardcl
   29           | . LVAR '(' vardcl_list osemi ')'
   30           | . LVAR '(' ')'
   31           | . lconst constdcl
   32           | . lconst '(' constdcl osemi ')'
   33           | . lconst '(' constdcl ';' constdcl_list osemi ')'
   34           | . lconst '(' ')'
   35           | . LTYPE typedcl
   36           | . LTYPE '(' typedcl_list osemi ')'
   37           | . LTYPE '(' ')'
   38 lconst: . LCONST
   49 simple_stmt: . expr
   50            | . expr LASOP expr
   51            | . expr_list '=' expr_list
   52            | . expr_list LCOLAS expr_list
   53            | . expr LINC
   54            | . expr LDEC
   60 compound_stmt: . '{' $@3 stmt_list '}'
   74 for_stmt: . LFOR $@6 for_body
   80 if_stmt: . LIF $@7 if_header $@8 loop_body $@9 elseif_list else
   89 switch_stmt: . LSWITCH $@11 if_header $@12 LBODY caseblock_list '}'
   91 select_stmt: . LSELECT $@13 LBODY caseblock_list '}'
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  152 new_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  162 labelname: . new_name
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  215          | fnlitdcl lbrace . stmt_list '}'
  216          | . fnlitdcl error
  250 stmt: .  [';', '}']
  251     | . compound_stmt
  252     | . common_dcl
  253     | . non_dcl_stmt
  254     | . error
  255 non_dcl_stmt: . simple_stmt
  256             | . for_stmt
  257             | . switch_stmt
  258             | . select_stmt
  259             | . if_stmt
  261             | . labelname ':' $@14 stmt
  262             | . LFALL
  263             | . LBREAK onew_name
  264             | . LCONTINUE onew_name
  265             | . LGO pseudocall
  266             | . LDEFER pseudocall
  267             | . LGOTO new_name
  268             | . LRETURN oexpr_list
  269 stmt_list: . stmt
  270          | . stmt_list ';' stmt
  275 expr_list: . expr
  276          | . expr_list ',' expr

    error       shift, and go to state 325
    LLITERAL    shift, and go to state 35
    LBREAK      shift, and go to state 36
    LCHAN       shift, and go to state 37
    LCONST      shift, and go to state 38
    LCONTINUE   shift, and go to state 39
    LDEFER      shift, and go to state 40
    LFALL       shift, and go to state 41
    LFOR        shift, and go to state 42
    LFUNC       shift, and go to state 113
    LGO         shift, and go to state 44
    LGOTO       shift, and go to state 45
    LIF         shift, and go to state 46
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LRETURN     shift, and go to state 49
    LSELECT     shift, and go to state 50
    LSTRUCT     shift, and go to state 51
    LSWITCH     shift, and go to state 52
    LTYPE       shift, and go to state 53
    LVAR        shift, and go to state 54
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '{'         shift, and go to state 326
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    ';'  reduce using rule 250 (stmt)
    '}'  reduce using rule 250 (stmt)

    common_dcl        go to state 327
    lconst            go to state 67
    simple_stmt       go to state 68
    compound_stmt     go to state 328
    for_stmt          go to state 69
    if_stmt           go to state 70
    switch_stmt       go to state 71
    select_stmt       go to state 72
    expr              go to state 73
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    new_name          go to state 78
    sym               go to state 79
    hidden_importsym  go to state 13
    name              go to state 80
    labelname         go to state 81
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    stmt              go to state 329
    non_dcl_stmt      go to state 330
    stmt_list         go to state 331
    expr_list         go to state 92


state 208

   52 simple_stmt: expr_list LCOLAS . expr_list
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  275 expr_list: . expr
  276          | . expr_list ',' expr

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 138
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    expr_list         go to state 332


state 209

   51 simple_stmt: expr_list '=' . expr_list
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  275 expr_list: . expr
  276          | . expr_list ',' expr

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 138
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    expr_list         go to state 333


state 210

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  276 expr_list: expr_list ',' . expr

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 334
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 211

  309 hidden_pkg_importsym: hidden_importsym .

    $default  reduce using rule 309 (hidden_pkg_importsym)


state 212

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  305 hidden_import: LCONST hidden_pkg_importsym . '=' hidden_constant ';'
  306              | LCONST hidden_pkg_importsym . hidden_type '=' hidden_constant ';'
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 339
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '='         shift, and go to state 343
    '['         shift, and go to state 344
    '@'         shift, and go to state 11

    hidden_importsym       go to state 345
    hidden_type            go to state 346
    hidden_type_misc       go to state 347
    hidden_type_recv_chan  go to state 348
    hidden_type_func       go to state 349


state 213

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  207 hidden_fndcl: '(' . hidden_funarg_list ')' sym '(' ohidden_funarg_list ')' ohidden_funres
  329 hidden_funarg: . sym hidden_type oliteral
  330              | . sym LDDD hidden_type oliteral
  345 hidden_funarg_list: . hidden_funarg
  346                   | . hidden_funarg_list ',' hidden_funarg

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    sym                 go to state 350
    hidden_importsym    go to state 13
    hidden_funarg       go to state 351
    hidden_funarg_list  go to state 352


state 214

  209 fnbody: .  [';']
  210       | . '{' stmt_list '}'
  308 hidden_import: LFUNC hidden_fndcl . fnbody ';'

    '{'  shift, and go to state 251

    $default  reduce using rule 209 (fnbody)

    fnbody  go to state 353


state 215

  206 hidden_fndcl: hidden_pkg_importsym . '(' ohidden_funarg_list ')' ohidden_funres

    '('  shift, and go to state 354


state 216

  303 hidden_import: LIMPORT LNAME . LLITERAL ';'

    LLITERAL  shift, and go to state 355


state 217

  310 hidden_pkgtype: hidden_pkg_importsym .

    $default  reduce using rule 310 (hidden_pkgtype)


state 218

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  307 hidden_import: LTYPE hidden_pkgtype . hidden_type ';'
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 339
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '['         shift, and go to state 344
    '@'         shift, and go to state 11

    hidden_importsym       go to state 345
    hidden_type            go to state 356
    hidden_type_misc       go to state 347
    hidden_type_recv_chan  go to state 348
    hidden_type_func       go to state 349


state 219

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  304 hidden_import: LVAR hidden_pkg_importsym . hidden_type ';'
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 339
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '['         shift, and go to state 344
    '@'         shift, and go to state 11

    hidden_importsym       go to state 345
    hidden_type            go to state 357
    hidden_type_misc       go to state 347
    hidden_type_recv_chan  go to state 348
    hidden_type_func       go to state 349


state 220

   22 import_there: $@2 hidden_import_list '$' '$' .

    $default  reduce using rule 22 (import_there)


state 221

   11 import_stmt: . import_here import_package import_there
   12            | . import_here import_there
   14 import_stmt_list: import_stmt_list ';' . import_stmt
   15 import_here: . LLITERAL
   16            | . sym LLITERAL
   17            | . '.' LLITERAL
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  286 osemi: ';' .  [')']

    LLITERAL  shift, and go to state 27
    LNAME     shift, and go to state 9
    '.'       shift, and go to state 29
    '?'       shift, and go to state 10
    '@'       shift, and go to state 11

    $default  reduce using rule 286 (osemi)

    import_stmt       go to state 358
    import_here       go to state 31
    sym               go to state 32
    hidden_importsym  go to state 13


state 222

    9 import: LIMPORT '(' import_stmt_list osemi . ')'

    ')'  shift, and go to state 359


state 223

   11 import_stmt: import_here import_package import_there .

    $default  reduce using rule 11 (import_stmt)


state 224

  149 name_or_type: . ntype
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  163 dotdotdot: . LDDD
  164          | . LDDD ntype
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  208       | LFUNC '(' . oarg_type_list_ocomma ')' fnres
  242 arg_type: . name_or_type
  243         | . sym name_or_type
  244         | . sym dotdotdot
  245         | . dotdotdot
  246 arg_type_list: . arg_type
  247              | . arg_type_list ',' arg_type
  248 oarg_type_list_ocomma: .  [')']
  249                      | . arg_type_list ocomma

    LCHAN       shift, and go to state 37
    LDDD        shift, and go to state 242
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 248 (oarg_type_list_ocomma)

    name_or_type           go to state 243
    sym                    go to state 244
    hidden_importsym       go to state 13
    name                   go to state 118
    dotdotdot              go to state 245
    ntype                  go to state 246
    dotname                go to state 228
    othertype              go to state 229
    ptrtype                go to state 230
    recvchantype           go to state 231
    structtype             go to state 85
    interfacetype          go to state 86
    fntype                 go to state 232
    arg_type               go to state 247
    arg_type_list          go to state 248
    oarg_type_list_ocomma  go to state 360


state 225

  198 recvchantype: LCOMM . LCHAN ntype

    LCHAN  shift, and go to state 361


state 226

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  170      | '(' . ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    ntype             go to state 362
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232


state 227

  193 othertype: LCHAN LCOMM ntype .

    $default  reduce using rule 193 (othertype)


state 228

  169 ntype: dotname .

    $default  reduce using rule 169 (ntype)


state 229

  167 ntype: othertype .

    $default  reduce using rule 167 (ntype)


state 230

  168 ntype: ptrtype .

    $default  reduce using rule 168 (ntype)


state 231

  165 ntype: recvchantype .

    $default  reduce using rule 165 (ntype)


state 232

  166 ntype: fntype .

    $default  reduce using rule 166 (ntype)


state 233

  197 ptrtype: '*' ntype .

    $default  reduce using rule 197 (ptrtype)


state 234

  179 non_recvchantype: '(' ntype . ')'

    ')'  shift, and go to state 363


state 235

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  189 dotname: name '.' . sym

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    sym               go to state 364
    hidden_importsym  go to state 13


state 236

  294 osimple_stmt: simple_stmt .

    $default  reduce using rule 294 (osimple_stmt)


state 237

   71 for_header: range_stmt .

    $default  reduce using rule 71 (for_header)


state 238

   66 loop_body: . LBODY $@5 stmt_list '}'
   72 for_body: for_header . loop_body

    LBODY  shift, and go to state 365

    loop_body  go to state 366


state 239

   74 for_stmt: LFOR $@6 for_body .

    $default  reduce using rule 74 (for_stmt)


state 240

   51 simple_stmt: expr_list . '=' expr_list
   52            | expr_list . LCOLAS expr_list
   67 range_stmt: expr_list . '=' LRANGE expr
   68           | expr_list . LCOLAS LRANGE expr
  276 expr_list: expr_list . ',' expr

    LCOLAS  shift, and go to state 367
    '='     shift, and go to state 368
    ','     shift, and go to state 210


state 241

   69 for_header: osimple_stmt . ';' osimple_stmt ';' osimple_stmt
   70           | osimple_stmt .  [LBODY]

    ';'  shift, and go to state 369

    $default  reduce using rule 70 (for_header)


state 242

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  163 dotdotdot: LDDD .  [')', ',']
  164          | LDDD . ntype
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 163 (dotdotdot)

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    ntype             go to state 370
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232


state 243

  242 arg_type: name_or_type .

    $default  reduce using rule 242 (arg_type)


state 244

  149 name_or_type: . ntype
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  161     | sym .  [')', '.', ',']
  163 dotdotdot: . LDDD
  164          | . LDDD ntype
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  243 arg_type: sym . name_or_type
  244         | sym . dotdotdot

    LCHAN       shift, and go to state 37
    LDDD        shift, and go to state 242
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 161 (name)

    name_or_type      go to state 371
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    dotdotdot         go to state 372
    ntype             go to state 246
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232


state 245

  245 arg_type: dotdotdot .

    $default  reduce using rule 245 (arg_type)


state 246

  149 name_or_type: ntype .

    $default  reduce using rule 149 (name_or_type)


state 247

  246 arg_type_list: arg_type .

    $default  reduce using rule 246 (arg_type_list)


state 248

  247 arg_type_list: arg_type_list . ',' arg_type
  249 oarg_type_list_ocomma: arg_type_list . ocomma
  287 ocomma: .  [')']
  288       | . ','

    ','  shift, and go to state 373

    $default  reduce using rule 287 (ocomma)

    ocomma  go to state 374


state 249

  205 fndcl: '(' oarg_type_list_ocomma . ')' sym '(' oarg_type_list_ocomma ')' fnres
  208 fntype: LFUNC '(' oarg_type_list_ocomma . ')' fnres

    ')'  shift, and go to state 375


state 250

  149 name_or_type: . ntype
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  163 dotdotdot: . LDDD
  164          | . LDDD ntype
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  204 fndcl: sym '(' . oarg_type_list_ocomma ')' fnres
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  242 arg_type: . name_or_type
  243         | . sym name_or_type
  244         | . sym dotdotdot
  245         | . dotdotdot
  246 arg_type_list: . arg_type
  247              | . arg_type_list ',' arg_type
  248 oarg_type_list_ocomma: .  [')']
  249                      | . arg_type_list ocomma

    LCHAN       shift, and go to state 37
    LDDD        shift, and go to state 242
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 248 (oarg_type_list_ocomma)

    name_or_type           go to state 243
    sym                    go to state 244
    hidden_importsym       go to state 13
    name                   go to state 118
    dotdotdot              go to state 245
    ntype                  go to state 246
    dotname                go to state 228
    othertype              go to state 229
    ptrtype                go to state 230
    recvchantype           go to state 231
    structtype             go to state 85
    interfacetype          go to state 86
    fntype                 go to state 232
    arg_type               go to state 247
    arg_type_list          go to state 248
    oarg_type_list_ocomma  go to state 376


state 251

   28 common_dcl: . LVAR vardcl
   29           | . LVAR '(' vardcl_list osemi ')'
   30           | . LVAR '(' ')'
   31           | . lconst constdcl
   32           | . lconst '(' constdcl osemi ')'
   33           | . lconst '(' constdcl ';' constdcl_list osemi ')'
   34           | . lconst '(' ')'
   35           | . LTYPE typedcl
   36           | . LTYPE '(' typedcl_list osemi ')'
   37           | . LTYPE '(' ')'
   38 lconst: . LCONST
   49 simple_stmt: . expr
   50            | . expr LASOP expr
   51            | . expr_list '=' expr_list
   52            | . expr_list LCOLAS expr_list
   53            | . expr LINC
   54            | . expr LDEC
   60 compound_stmt: . '{' $@3 stmt_list '}'
   74 for_stmt: . LFOR $@6 for_body
   80 if_stmt: . LIF $@7 if_header $@8 loop_body $@9 elseif_list else
   89 switch_stmt: . LSWITCH $@11 if_header $@12 LBODY caseblock_list '}'
   91 select_stmt: . LSELECT $@13 LBODY caseblock_list '}'
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  152 new_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  162 labelname: . new_name
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  210 fnbody: '{' . stmt_list '}'
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  250 stmt: .  [';', '}']
  251     | . compound_stmt
  252     | . common_dcl
  253     | . non_dcl_stmt
  254     | . error
  255 non_dcl_stmt: . simple_stmt
  256             | . for_stmt
  257             | . switch_stmt
  258             | . select_stmt
  259             | . if_stmt
  261             | . labelname ':' $@14 stmt
  262             | . LFALL
  263             | . LBREAK onew_name
  264             | . LCONTINUE onew_name
  265             | . LGO pseudocall
  266             | . LDEFER pseudocall
  267             | . LGOTO new_name
  268             | . LRETURN oexpr_list
  269 stmt_list: . stmt
  270          | . stmt_list ';' stmt
  275 expr_list: . expr
  276          | . expr_list ',' expr

    error       shift, and go to state 325
    LLITERAL    shift, and go to state 35
    LBREAK      shift, and go to state 36
    LCHAN       shift, and go to state 37
    LCONST      shift, and go to state 38
    LCONTINUE   shift, and go to state 39
    LDEFER      shift, and go to state 40
    LFALL       shift, and go to state 41
    LFOR        shift, and go to state 42
    LFUNC       shift, and go to state 113
    LGO         shift, and go to state 44
    LGOTO       shift, and go to state 45
    LIF         shift, and go to state 46
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LRETURN     shift, and go to state 49
    LSELECT     shift, and go to state 50
    LSTRUCT     shift, and go to state 51
    LSWITCH     shift, and go to state 52
    LTYPE       shift, and go to state 53
    LVAR        shift, and go to state 54
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '{'         shift, and go to state 326
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    ';'  reduce using rule 250 (stmt)
    '}'  reduce using rule 250 (stmt)

    common_dcl        go to state 327
    lconst            go to state 67
    simple_stmt       go to state 68
    compound_stmt     go to state 328
    for_stmt          go to state 69
    if_stmt           go to state 70
    switch_stmt       go to state 71
    select_stmt       go to state 72
    expr              go to state 73
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    new_name          go to state 78
    sym               go to state 79
    hidden_importsym  go to state 13
    name              go to state 80
    labelname         go to state 81
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    stmt              go to state 329
    non_dcl_stmt      go to state 330
    stmt_list         go to state 377
    expr_list         go to state 92


state 252

  203 xfndcl: LFUNC fndcl fnbody .

    $default  reduce using rule 203 (xfndcl)


state 253

   78 $@8: .
   80 if_stmt: LIF $@7 if_header . $@8 loop_body $@9 elseif_list else

    $default  reduce using rule 78 ($@8)

    $@8  go to state 378


state 254

   75 if_header: osimple_stmt .  [LBODY]
   76          | osimple_stmt . ';' osimple_stmt

    ';'  shift, and go to state 379

    $default  reduce using rule 75 (if_header)


state 255

  156 sym: LNAME .  [LCHAN, LFUNC, LINTERFACE, LMAP, LNAME, LSTRUCT, LCOMM, '*', '(', '[', '?', '@', ',']
  235 packname: LNAME .  [LLITERAL, ';', '}']
  236         | LNAME . '.' sym

    '.'  shift, and go to state 380

    LLITERAL  reduce using rule 235 (packname)
    ';'       reduce using rule 235 (packname)
    '}'       reduce using rule 235 (packname)
    $default  reduce using rule 156 (sym)


state 256

  235 packname: . LNAME
  236         | . LNAME '.' sym
  240 interfacedcl: '(' . packname ')'

    LNAME  shift, and go to state 381

    packname  go to state 382


state 257

  202 interfacetype: LINTERFACE lbrace '}' .

    $default  reduce using rule 202 (interfacetype)


state 258

  238 interfacedcl: new_name . indcl
  241 indcl: . '(' oarg_type_list_ocomma ')' fnres

    '('  shift, and go to state 383

    indcl  go to state 384


state 259

  201 interfacetype: LINTERFACE lbrace interfacedcl_list . osemi '}'
  228 interfacedcl_list: interfacedcl_list . ';' interfacedcl
  285 osemi: .  ['}']
  286      | . ';'

    ';'  shift, and go to state 385

    $default  reduce using rule 285 (osemi)

    osemi  go to state 386


state 260

  239 interfacedcl: packname .

    $default  reduce using rule 239 (interfacedcl)


state 261

  227 interfacedcl_list: interfacedcl .

    $default  reduce using rule 227 (interfacedcl_list)


state 262

  194 othertype: LMAP '[' ntype . ']' ntype

    ']'  shift, and go to state 387


state 263

   63 caseblock_list: .
   64               | . caseblock_list caseblock
   91 select_stmt: LSELECT $@13 LBODY . caseblock_list '}'

    $default  reduce using rule 63 (caseblock_list)

    caseblock_list  go to state 388


state 264

  232 structdcl: '*' . embed oliteral
  234          | '*' . '(' embed ')' oliteral
  235 packname: . LNAME
  236         | . LNAME '.' sym
  237 embed: . packname

    LNAME  shift, and go to state 381
    '('    shift, and go to state 389

    packname  go to state 270
    embed     go to state 390


state 265

  231 structdcl: '(' . embed ')' oliteral
  233          | '(' . '*' embed ')' oliteral
  235 packname: . LNAME
  236         | . LNAME '.' sym
  237 embed: . packname

    LNAME  shift, and go to state 381
    '*'    shift, and go to state 391

    packname  go to state 270
    embed     go to state 392


state 266

  200 structtype: LSTRUCT lbrace '}' .

    $default  reduce using rule 200 (structtype)


state 267

  271 new_name_list: new_name .

    $default  reduce using rule 271 (new_name_list)


state 268

  199 structtype: LSTRUCT lbrace structdcl_list . osemi '}'
  226 structdcl_list: structdcl_list . ';' structdcl
  285 osemi: .  ['}']
  286      | . ';'

    ';'  shift, and go to state 393

    $default  reduce using rule 285 (osemi)

    osemi  go to state 394


state 269

  225 structdcl_list: structdcl .

    $default  reduce using rule 225 (structdcl_list)


state 270

  237 embed: packname .

    $default  reduce using rule 237 (embed)


state 271

  230 structdcl: embed . oliteral
  301 oliteral: .  [';', '}']
  302         | . LLITERAL

    LLITERAL  shift, and go to state 395

    $default  reduce using rule 301 (oliteral)

    oliteral  go to state 396


state 272

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  229 structdcl: new_name_list . ntype oliteral
  272 new_name_list: new_name_list . ',' new_name

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11
    ','         shift, and go to state 397

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    ntype             go to state 398
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232


state 273

   88 $@12: .
   89 switch_stmt: LSWITCH $@11 if_header . $@12 LBODY caseblock_list '}'

    $default  reduce using rule 88 ($@12)

    $@12  go to state 399


state 274

   37 common_dcl: LTYPE '(' ')' .

    $default  reduce using rule 37 (common_dcl)


state 275

  223 typedcl_list: typedcl .

    $default  reduce using rule 223 (typedcl_list)


state 276

   36 common_dcl: LTYPE '(' typedcl_list . osemi ')'
  224 typedcl_list: typedcl_list . ';' typedcl
  285 osemi: .  [')']
  286      | . ';'

    ';'  shift, and go to state 400

    $default  reduce using rule 285 (osemi)

    osemi  go to state 401


state 277

   48 typedcl: typedclname ntype .

    $default  reduce using rule 48 (typedcl)


state 278

   30 common_dcl: LVAR '(' ')' .

    $default  reduce using rule 30 (common_dcl)


state 279

  219 vardcl_list: vardcl .

    $default  reduce using rule 219 (vardcl_list)


state 280

   29 common_dcl: LVAR '(' vardcl_list . osemi ')'
  220 vardcl_list: vardcl_list . ';' vardcl
  285 osemi: .  [')']
  286      | . ';'

    ';'  shift, and go to state 402

    $default  reduce using rule 285 (osemi)

    osemi  go to state 403


state 281

   41 vardcl: dcl_name_list '=' . expr_list
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  275 expr_list: . expr
  276          | . expr_list ',' expr

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 138
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    expr_list         go to state 404


state 282

  153 dcl_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  274 dcl_name_list: dcl_name_list ',' . dcl_name

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    dcl_name          go to state 405
    sym               go to state 151
    hidden_importsym  go to state 13


state 283

   39 vardcl: dcl_name_list ntype .  [LCASE, LDEFAULT, ')', ';', '}']
   40       | dcl_name_list ntype . '=' expr_list

    '='  shift, and go to state 406

    $default  reduce using rule 39 (vardcl)


state 284

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  175 non_recvchantype: . fntype
  176                 | . othertype
  177                 | . ptrtype
  178                 | . dotname
  179                 | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  192          | LCHAN . non_recvchantype
  193          | . LCHAN LCOMM ntype
  193          | LCHAN . LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  198             | LCOMM LCHAN . ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 407
    '*'         shift, and go to state 115
    '('         shift, and go to state 408
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    ntype             go to state 409
    non_recvchantype  go to state 119
    dotname           go to state 410
    othertype         go to state 411
    ptrtype           go to state 412
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 413


state 285

  174 non_expr_type: '*' non_expr_type .

    $default  reduce using rule 174 (non_expr_type)


state 286

  137 pexpr_no_paren: '(' expr_or_type ')' . '{' start_complit braced_keyval_list '}'
  146 pexpr: '(' expr_or_type ')' .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LANDNOT, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLSH, LLT, LNE, LOROR, LRSH, '+', '-', '|', '^', '*', '/', '%', '&', '(', ')', ';', '.', '=', ':', '}', '[', ']', ',']

    '{'  shift, and go to state 414

    $default  reduce using rule 146 (pexpr)


state 287

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  191          | '[' LDDD ']' . ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    ntype             go to state 415
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232


state 288

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  190          | '[' oexpr ']' . ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    ntype             go to state 416
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232


state 289

   34 common_dcl: lconst '(' ')' .

    $default  reduce using rule 34 (common_dcl)


state 290

   32 common_dcl: lconst '(' constdcl . osemi ')'
   33           | lconst '(' constdcl . ';' constdcl_list osemi ')'
  285 osemi: .  [')']
  286      | . ';'

    ';'  shift, and go to state 417

    $default  reduce using rule 285 (osemi)

    osemi  go to state 418


state 291

   43 constdcl: dcl_name_list '=' . expr_list
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  275 expr_list: . expr
  276          | . expr_list ',' expr

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 138
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    expr_list         go to state 419


state 292

   42 constdcl: dcl_name_list ntype . '=' expr_list

    '='  shift, and go to state 420


state 293

   50 simple_stmt: expr LASOP expr .  [LCASE, LDEFAULT, LBODY, ';', '}']
   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    LANDAND  shift, and go to state 177
    LANDNOT  shift, and go to state 178
    LCOMM    shift, and go to state 179
    LEQ      shift, and go to state 181
    LGE      shift, and go to state 182
    LGT      shift, and go to state 183
    LLE      shift, and go to state 185
    LLSH     shift, and go to state 186
    LLT      shift, and go to state 187
    LNE      shift, and go to state 188
    LOROR    shift, and go to state 189
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 50 (simple_stmt)


state 294

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   94     | expr LANDAND expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LBODY, LCOMM, LDEC, LINC, LOROR, ')', ';', '=', ':', '}', ']', ',']
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    LANDNOT  shift, and go to state 178
    LEQ      shift, and go to state 181
    LGE      shift, and go to state 182
    LGT      shift, and go to state 183
    LLE      shift, and go to state 185
    LLSH     shift, and go to state 186
    LLT      shift, and go to state 187
    LNE      shift, and go to state 188
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 94 (expr)

    Conflict between rule 94 and token LANDAND resolved as reduce (%left LANDAND).
    Conflict between rule 94 and token LANDNOT resolved as shift (LANDAND < LANDNOT).
    Conflict between rule 94 and token LCOMM resolved as reduce (LCOMM < LANDAND).
    Conflict between rule 94 and token LEQ resolved as shift (LANDAND < LEQ).
    Conflict between rule 94 and token LGE resolved as shift (LANDAND < LGE).
    Conflict between rule 94 and token LGT resolved as shift (LANDAND < LGT).
    Conflict between rule 94 and token LLE resolved as shift (LANDAND < LLE).
    Conflict between rule 94 and token LLSH resolved as shift (LANDAND < LLSH).
    Conflict between rule 94 and token LLT resolved as shift (LANDAND < LLT).
    Conflict between rule 94 and token LNE resolved as shift (LANDAND < LNE).
    Conflict between rule 94 and token LOROR resolved as reduce (LOROR < LANDAND).
    Conflict between rule 94 and token LRSH resolved as shift (LANDAND < LRSH).
    Conflict between rule 94 and token '+' resolved as shift (LANDAND < '+').
    Conflict between rule 94 and token '-' resolved as shift (LANDAND < '-').
    Conflict between rule 94 and token '|' resolved as shift (LANDAND < '|').
    Conflict between rule 94 and token '^' resolved as shift (LANDAND < '^').
    Conflict between rule 94 and token '*' resolved as shift (LANDAND < '*').
    Conflict between rule 94 and token '/' resolved as shift (LANDAND < '/').
    Conflict between rule 94 and token '%' resolved as shift (LANDAND < '%').
    Conflict between rule 94 and token '&' resolved as shift (LANDAND < '&').


state 295

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  109     | expr LANDNOT expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LANDNOT, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLSH, LLT, LNE, LOROR, LRSH, '+', '-', '|', '^', '*', '/', '%', '&', ')', ';', '=', ':', '}', ']', ',']
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    $default  reduce using rule 109 (expr)

    Conflict between rule 109 and token LANDAND resolved as reduce (LANDAND < LANDNOT).
    Conflict between rule 109 and token LANDNOT resolved as reduce (%left LANDNOT).
    Conflict between rule 109 and token LCOMM resolved as reduce (LCOMM < LANDNOT).
    Conflict between rule 109 and token LEQ resolved as reduce (LEQ < LANDNOT).
    Conflict between rule 109 and token LGE resolved as reduce (LGE < LANDNOT).
    Conflict between rule 109 and token LGT resolved as reduce (LGT < LANDNOT).
    Conflict between rule 109 and token LLE resolved as reduce (LLE < LANDNOT).
    Conflict between rule 109 and token LLSH resolved as reduce (%left LLSH).
    Conflict between rule 109 and token LLT resolved as reduce (LLT < LANDNOT).
    Conflict between rule 109 and token LNE resolved as reduce (LNE < LANDNOT).
    Conflict between rule 109 and token LOROR resolved as reduce (LOROR < LANDNOT).
    Conflict between rule 109 and token LRSH resolved as reduce (%left LRSH).
    Conflict between rule 109 and token '+' resolved as reduce ('+' < LANDNOT).
    Conflict between rule 109 and token '-' resolved as reduce ('-' < LANDNOT).
    Conflict between rule 109 and token '|' resolved as reduce ('|' < LANDNOT).
    Conflict between rule 109 and token '^' resolved as reduce ('^' < LANDNOT).
    Conflict between rule 109 and token '*' resolved as reduce (%left '*').
    Conflict between rule 109 and token '/' resolved as reduce (%left '/').
    Conflict between rule 109 and token '%' resolved as reduce (%left '%').
    Conflict between rule 109 and token '&' resolved as reduce (%left '&').


state 296

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr
  112     | expr LCOMM expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LBODY, LCOMM, LDEC, LINC, ')', ';', '=', ':', '}', ']', ',']

    LANDAND  shift, and go to state 177
    LANDNOT  shift, and go to state 178
    LEQ      shift, and go to state 181
    LGE      shift, and go to state 182
    LGT      shift, and go to state 183
    LLE      shift, and go to state 185
    LLSH     shift, and go to state 186
    LLT      shift, and go to state 187
    LNE      shift, and go to state 188
    LOROR    shift, and go to state 189
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 112 (expr)

    Conflict between rule 112 and token LANDAND resolved as shift (LCOMM < LANDAND).
    Conflict between rule 112 and token LANDNOT resolved as shift (LCOMM < LANDNOT).
    Conflict between rule 112 and token LCOMM resolved as reduce (%left LCOMM).
    Conflict between rule 112 and token LEQ resolved as shift (LCOMM < LEQ).
    Conflict between rule 112 and token LGE resolved as shift (LCOMM < LGE).
    Conflict between rule 112 and token LGT resolved as shift (LCOMM < LGT).
    Conflict between rule 112 and token LLE resolved as shift (LCOMM < LLE).
    Conflict between rule 112 and token LLSH resolved as shift (LCOMM < LLSH).
    Conflict between rule 112 and token LLT resolved as shift (LCOMM < LLT).
    Conflict between rule 112 and token LNE resolved as shift (LCOMM < LNE).
    Conflict between rule 112 and token LOROR resolved as shift (LCOMM < LOROR).
    Conflict between rule 112 and token LRSH resolved as shift (LCOMM < LRSH).
    Conflict between rule 112 and token '+' resolved as shift (LCOMM < '+').
    Conflict between rule 112 and token '-' resolved as shift (LCOMM < '-').
    Conflict between rule 112 and token '|' resolved as shift (LCOMM < '|').
    Conflict between rule 112 and token '^' resolved as shift (LCOMM < '^').
    Conflict between rule 112 and token '*' resolved as shift (LCOMM < '*').
    Conflict between rule 112 and token '/' resolved as shift (LCOMM < '/').
    Conflict between rule 112 and token '%' resolved as shift (LCOMM < '%').
    Conflict between rule 112 and token '&' resolved as shift (LCOMM < '&').


state 297

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   95     | expr LEQ expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLT, LNE, LOROR, ')', ';', '=', ':', '}', ']', ',']
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    LANDNOT  shift, and go to state 178
    LLSH     shift, and go to state 186
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 95 (expr)

    Conflict between rule 95 and token LANDAND resolved as reduce (LANDAND < LEQ).
    Conflict between rule 95 and token LANDNOT resolved as shift (LEQ < LANDNOT).
    Conflict between rule 95 and token LCOMM resolved as reduce (LCOMM < LEQ).
    Conflict between rule 95 and token LEQ resolved as reduce (%left LEQ).
    Conflict between rule 95 and token LGE resolved as reduce (%left LGE).
    Conflict between rule 95 and token LGT resolved as reduce (%left LGT).
    Conflict between rule 95 and token LLE resolved as reduce (%left LLE).
    Conflict between rule 95 and token LLSH resolved as shift (LEQ < LLSH).
    Conflict between rule 95 and token LLT resolved as reduce (%left LLT).
    Conflict between rule 95 and token LNE resolved as reduce (%left LNE).
    Conflict between rule 95 and token LOROR resolved as reduce (LOROR < LEQ).
    Conflict between rule 95 and token LRSH resolved as shift (LEQ < LRSH).
    Conflict between rule 95 and token '+' resolved as shift (LEQ < '+').
    Conflict between rule 95 and token '-' resolved as shift (LEQ < '-').
    Conflict between rule 95 and token '|' resolved as shift (LEQ < '|').
    Conflict between rule 95 and token '^' resolved as shift (LEQ < '^').
    Conflict between rule 95 and token '*' resolved as shift (LEQ < '*').
    Conflict between rule 95 and token '/' resolved as shift (LEQ < '/').
    Conflict between rule 95 and token '%' resolved as shift (LEQ < '%').
    Conflict between rule 95 and token '&' resolved as shift (LEQ < '&').


state 298

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
   99     | expr LGE expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLT, LNE, LOROR, ')', ';', '=', ':', '}', ']', ',']
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    LANDNOT  shift, and go to state 178
    LLSH     shift, and go to state 186
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 99 (expr)

    Conflict between rule 99 and token LANDAND resolved as reduce (LANDAND < LGE).
    Conflict between rule 99 and token LANDNOT resolved as shift (LGE < LANDNOT).
    Conflict between rule 99 and token LCOMM resolved as reduce (LCOMM < LGE).
    Conflict between rule 99 and token LEQ resolved as reduce (%left LEQ).
    Conflict between rule 99 and token LGE resolved as reduce (%left LGE).
    Conflict between rule 99 and token LGT resolved as reduce (%left LGT).
    Conflict between rule 99 and token LLE resolved as reduce (%left LLE).
    Conflict between rule 99 and token LLSH resolved as shift (LGE < LLSH).
    Conflict between rule 99 and token LLT resolved as reduce (%left LLT).
    Conflict between rule 99 and token LNE resolved as reduce (%left LNE).
    Conflict between rule 99 and token LOROR resolved as reduce (LOROR < LGE).
    Conflict between rule 99 and token LRSH resolved as shift (LGE < LRSH).
    Conflict between rule 99 and token '+' resolved as shift (LGE < '+').
    Conflict between rule 99 and token '-' resolved as shift (LGE < '-').
    Conflict between rule 99 and token '|' resolved as shift (LGE < '|').
    Conflict between rule 99 and token '^' resolved as shift (LGE < '^').
    Conflict between rule 99 and token '*' resolved as shift (LGE < '*').
    Conflict between rule 99 and token '/' resolved as shift (LGE < '/').
    Conflict between rule 99 and token '%' resolved as shift (LGE < '%').
    Conflict between rule 99 and token '&' resolved as shift (LGE < '&').


state 299

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  100     | expr LGT expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLT, LNE, LOROR, ')', ';', '=', ':', '}', ']', ',']
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    LANDNOT  shift, and go to state 178
    LLSH     shift, and go to state 186
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 100 (expr)

    Conflict between rule 100 and token LANDAND resolved as reduce (LANDAND < LGT).
    Conflict between rule 100 and token LANDNOT resolved as shift (LGT < LANDNOT).
    Conflict between rule 100 and token LCOMM resolved as reduce (LCOMM < LGT).
    Conflict between rule 100 and token LEQ resolved as reduce (%left LEQ).
    Conflict between rule 100 and token LGE resolved as reduce (%left LGE).
    Conflict between rule 100 and token LGT resolved as reduce (%left LGT).
    Conflict between rule 100 and token LLE resolved as reduce (%left LLE).
    Conflict between rule 100 and token LLSH resolved as shift (LGT < LLSH).
    Conflict between rule 100 and token LLT resolved as reduce (%left LLT).
    Conflict between rule 100 and token LNE resolved as reduce (%left LNE).
    Conflict between rule 100 and token LOROR resolved as reduce (LOROR < LGT).
    Conflict between rule 100 and token LRSH resolved as shift (LGT < LRSH).
    Conflict between rule 100 and token '+' resolved as shift (LGT < '+').
    Conflict between rule 100 and token '-' resolved as shift (LGT < '-').
    Conflict between rule 100 and token '|' resolved as shift (LGT < '|').
    Conflict between rule 100 and token '^' resolved as shift (LGT < '^').
    Conflict between rule 100 and token '*' resolved as shift (LGT < '*').
    Conflict between rule 100 and token '/' resolved as shift (LGT < '/').
    Conflict between rule 100 and token '%' resolved as shift (LGT < '%').
    Conflict between rule 100 and token '&' resolved as shift (LGT < '&').


state 300

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   98     | expr LLE expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLT, LNE, LOROR, ')', ';', '=', ':', '}', ']', ',']
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    LANDNOT  shift, and go to state 178
    LLSH     shift, and go to state 186
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 98 (expr)

    Conflict between rule 98 and token LANDAND resolved as reduce (LANDAND < LLE).
    Conflict between rule 98 and token LANDNOT resolved as shift (LLE < LANDNOT).
    Conflict between rule 98 and token LCOMM resolved as reduce (LCOMM < LLE).
    Conflict between rule 98 and token LEQ resolved as reduce (%left LEQ).
    Conflict between rule 98 and token LGE resolved as reduce (%left LGE).
    Conflict between rule 98 and token LGT resolved as reduce (%left LGT).
    Conflict between rule 98 and token LLE resolved as reduce (%left LLE).
    Conflict between rule 98 and token LLSH resolved as shift (LLE < LLSH).
    Conflict between rule 98 and token LLT resolved as reduce (%left LLT).
    Conflict between rule 98 and token LNE resolved as reduce (%left LNE).
    Conflict between rule 98 and token LOROR resolved as reduce (LOROR < LLE).
    Conflict between rule 98 and token LRSH resolved as shift (LLE < LRSH).
    Conflict between rule 98 and token '+' resolved as shift (LLE < '+').
    Conflict between rule 98 and token '-' resolved as shift (LLE < '-').
    Conflict between rule 98 and token '|' resolved as shift (LLE < '|').
    Conflict between rule 98 and token '^' resolved as shift (LLE < '^').
    Conflict between rule 98 and token '*' resolved as shift (LLE < '*').
    Conflict between rule 98 and token '/' resolved as shift (LLE < '/').
    Conflict between rule 98 and token '%' resolved as shift (LLE < '%').
    Conflict between rule 98 and token '&' resolved as shift (LLE < '&').


state 301

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  110     | expr LLSH expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LANDNOT, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLSH, LLT, LNE, LOROR, LRSH, '+', '-', '|', '^', '*', '/', '%', '&', ')', ';', '=', ':', '}', ']', ',']
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    $default  reduce using rule 110 (expr)

    Conflict between rule 110 and token LANDAND resolved as reduce (LANDAND < LLSH).
    Conflict between rule 110 and token LANDNOT resolved as reduce (%left LANDNOT).
    Conflict between rule 110 and token LCOMM resolved as reduce (LCOMM < LLSH).
    Conflict between rule 110 and token LEQ resolved as reduce (LEQ < LLSH).
    Conflict between rule 110 and token LGE resolved as reduce (LGE < LLSH).
    Conflict between rule 110 and token LGT resolved as reduce (LGT < LLSH).
    Conflict between rule 110 and token LLE resolved as reduce (LLE < LLSH).
    Conflict between rule 110 and token LLSH resolved as reduce (%left LLSH).
    Conflict between rule 110 and token LLT resolved as reduce (LLT < LLSH).
    Conflict between rule 110 and token LNE resolved as reduce (LNE < LLSH).
    Conflict between rule 110 and token LOROR resolved as reduce (LOROR < LLSH).
    Conflict between rule 110 and token LRSH resolved as reduce (%left LRSH).
    Conflict between rule 110 and token '+' resolved as reduce ('+' < LLSH).
    Conflict between rule 110 and token '-' resolved as reduce ('-' < LLSH).
    Conflict between rule 110 and token '|' resolved as reduce ('|' < LLSH).
    Conflict between rule 110 and token '^' resolved as reduce ('^' < LLSH).
    Conflict between rule 110 and token '*' resolved as reduce (%left '*').
    Conflict between rule 110 and token '/' resolved as reduce (%left '/').
    Conflict between rule 110 and token '%' resolved as reduce (%left '%').
    Conflict between rule 110 and token '&' resolved as reduce (%left '&').


state 302

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   97     | expr LLT expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLT, LNE, LOROR, ')', ';', '=', ':', '}', ']', ',']
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    LANDNOT  shift, and go to state 178
    LLSH     shift, and go to state 186
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 97 (expr)

    Conflict between rule 97 and token LANDAND resolved as reduce (LANDAND < LLT).
    Conflict between rule 97 and token LANDNOT resolved as shift (LLT < LANDNOT).
    Conflict between rule 97 and token LCOMM resolved as reduce (LCOMM < LLT).
    Conflict between rule 97 and token LEQ resolved as reduce (%left LEQ).
    Conflict between rule 97 and token LGE resolved as reduce (%left LGE).
    Conflict between rule 97 and token LGT resolved as reduce (%left LGT).
    Conflict between rule 97 and token LLE resolved as reduce (%left LLE).
    Conflict between rule 97 and token LLSH resolved as shift (LLT < LLSH).
    Conflict between rule 97 and token LLT resolved as reduce (%left LLT).
    Conflict between rule 97 and token LNE resolved as reduce (%left LNE).
    Conflict between rule 97 and token LOROR resolved as reduce (LOROR < LLT).
    Conflict between rule 97 and token LRSH resolved as shift (LLT < LRSH).
    Conflict between rule 97 and token '+' resolved as shift (LLT < '+').
    Conflict between rule 97 and token '-' resolved as shift (LLT < '-').
    Conflict between rule 97 and token '|' resolved as shift (LLT < '|').
    Conflict between rule 97 and token '^' resolved as shift (LLT < '^').
    Conflict between rule 97 and token '*' resolved as shift (LLT < '*').
    Conflict between rule 97 and token '/' resolved as shift (LLT < '/').
    Conflict between rule 97 and token '%' resolved as shift (LLT < '%').
    Conflict between rule 97 and token '&' resolved as shift (LLT < '&').


state 303

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   96     | expr LNE expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLT, LNE, LOROR, ')', ';', '=', ':', '}', ']', ',']
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    LANDNOT  shift, and go to state 178
    LLSH     shift, and go to state 186
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 96 (expr)

    Conflict between rule 96 and token LANDAND resolved as reduce (LANDAND < LNE).
    Conflict between rule 96 and token LANDNOT resolved as shift (LNE < LANDNOT).
    Conflict between rule 96 and token LCOMM resolved as reduce (LCOMM < LNE).
    Conflict between rule 96 and token LEQ resolved as reduce (%left LEQ).
    Conflict between rule 96 and token LGE resolved as reduce (%left LGE).
    Conflict between rule 96 and token LGT resolved as reduce (%left LGT).
    Conflict between rule 96 and token LLE resolved as reduce (%left LLE).
    Conflict between rule 96 and token LLSH resolved as shift (LNE < LLSH).
    Conflict between rule 96 and token LLT resolved as reduce (%left LLT).
    Conflict between rule 96 and token LNE resolved as reduce (%left LNE).
    Conflict between rule 96 and token LOROR resolved as reduce (LOROR < LNE).
    Conflict between rule 96 and token LRSH resolved as shift (LNE < LRSH).
    Conflict between rule 96 and token '+' resolved as shift (LNE < '+').
    Conflict between rule 96 and token '-' resolved as shift (LNE < '-').
    Conflict between rule 96 and token '|' resolved as shift (LNE < '|').
    Conflict between rule 96 and token '^' resolved as shift (LNE < '^').
    Conflict between rule 96 and token '*' resolved as shift (LNE < '*').
    Conflict between rule 96 and token '/' resolved as shift (LNE < '/').
    Conflict between rule 96 and token '%' resolved as shift (LNE < '%').
    Conflict between rule 96 and token '&' resolved as shift (LNE < '&').


state 304

   93 expr: expr . LOROR expr
   93     | expr LOROR expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LBODY, LCOMM, LDEC, LINC, LOROR, ')', ';', '=', ':', '}', ']', ',']
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    LANDAND  shift, and go to state 177
    LANDNOT  shift, and go to state 178
    LEQ      shift, and go to state 181
    LGE      shift, and go to state 182
    LGT      shift, and go to state 183
    LLE      shift, and go to state 185
    LLSH     shift, and go to state 186
    LLT      shift, and go to state 187
    LNE      shift, and go to state 188
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 93 (expr)

    Conflict between rule 93 and token LANDAND resolved as shift (LOROR < LANDAND).
    Conflict between rule 93 and token LANDNOT resolved as shift (LOROR < LANDNOT).
    Conflict between rule 93 and token LCOMM resolved as reduce (LCOMM < LOROR).
    Conflict between rule 93 and token LEQ resolved as shift (LOROR < LEQ).
    Conflict between rule 93 and token LGE resolved as shift (LOROR < LGE).
    Conflict between rule 93 and token LGT resolved as shift (LOROR < LGT).
    Conflict between rule 93 and token LLE resolved as shift (LOROR < LLE).
    Conflict between rule 93 and token LLSH resolved as shift (LOROR < LLSH).
    Conflict between rule 93 and token LLT resolved as shift (LOROR < LLT).
    Conflict between rule 93 and token LNE resolved as shift (LOROR < LNE).
    Conflict between rule 93 and token LOROR resolved as reduce (%left LOROR).
    Conflict between rule 93 and token LRSH resolved as shift (LOROR < LRSH).
    Conflict between rule 93 and token '+' resolved as shift (LOROR < '+').
    Conflict between rule 93 and token '-' resolved as shift (LOROR < '-').
    Conflict between rule 93 and token '|' resolved as shift (LOROR < '|').
    Conflict between rule 93 and token '^' resolved as shift (LOROR < '^').
    Conflict between rule 93 and token '*' resolved as shift (LOROR < '*').
    Conflict between rule 93 and token '/' resolved as shift (LOROR < '/').
    Conflict between rule 93 and token '%' resolved as shift (LOROR < '%').
    Conflict between rule 93 and token '&' resolved as shift (LOROR < '&').


state 305

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  111     | expr LRSH expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LANDNOT, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLSH, LLT, LNE, LOROR, LRSH, '+', '-', '|', '^', '*', '/', '%', '&', ')', ';', '=', ':', '}', ']', ',']
  112     | expr . LCOMM expr

    $default  reduce using rule 111 (expr)

    Conflict between rule 111 and token LANDAND resolved as reduce (LANDAND < LRSH).
    Conflict between rule 111 and token LANDNOT resolved as reduce (%left LANDNOT).
    Conflict between rule 111 and token LCOMM resolved as reduce (LCOMM < LRSH).
    Conflict between rule 111 and token LEQ resolved as reduce (LEQ < LRSH).
    Conflict between rule 111 and token LGE resolved as reduce (LGE < LRSH).
    Conflict between rule 111 and token LGT resolved as reduce (LGT < LRSH).
    Conflict between rule 111 and token LLE resolved as reduce (LLE < LRSH).
    Conflict between rule 111 and token LLSH resolved as reduce (%left LLSH).
    Conflict between rule 111 and token LLT resolved as reduce (LLT < LRSH).
    Conflict between rule 111 and token LNE resolved as reduce (LNE < LRSH).
    Conflict between rule 111 and token LOROR resolved as reduce (LOROR < LRSH).
    Conflict between rule 111 and token LRSH resolved as reduce (%left LRSH).
    Conflict between rule 111 and token '+' resolved as reduce ('+' < LRSH).
    Conflict between rule 111 and token '-' resolved as reduce ('-' < LRSH).
    Conflict between rule 111 and token '|' resolved as reduce ('|' < LRSH).
    Conflict between rule 111 and token '^' resolved as reduce ('^' < LRSH).
    Conflict between rule 111 and token '*' resolved as reduce (%left '*').
    Conflict between rule 111 and token '/' resolved as reduce (%left '/').
    Conflict between rule 111 and token '%' resolved as reduce (%left '%').
    Conflict between rule 111 and token '&' resolved as reduce (%left '&').


state 306

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  101     | expr '+' expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLT, LNE, LOROR, '+', '-', '|', '^', ')', ';', '=', ':', '}', ']', ',']
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    LANDNOT  shift, and go to state 178
    LLSH     shift, and go to state 186
    LRSH     shift, and go to state 190
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 101 (expr)

    Conflict between rule 101 and token LANDAND resolved as reduce (LANDAND < '+').
    Conflict between rule 101 and token LANDNOT resolved as shift ('+' < LANDNOT).
    Conflict between rule 101 and token LCOMM resolved as reduce (LCOMM < '+').
    Conflict between rule 101 and token LEQ resolved as reduce (LEQ < '+').
    Conflict between rule 101 and token LGE resolved as reduce (LGE < '+').
    Conflict between rule 101 and token LGT resolved as reduce (LGT < '+').
    Conflict between rule 101 and token LLE resolved as reduce (LLE < '+').
    Conflict between rule 101 and token LLSH resolved as shift ('+' < LLSH).
    Conflict between rule 101 and token LLT resolved as reduce (LLT < '+').
    Conflict between rule 101 and token LNE resolved as reduce (LNE < '+').
    Conflict between rule 101 and token LOROR resolved as reduce (LOROR < '+').
    Conflict between rule 101 and token LRSH resolved as shift ('+' < LRSH).
    Conflict between rule 101 and token '+' resolved as reduce (%left '+').
    Conflict between rule 101 and token '-' resolved as reduce (%left '-').
    Conflict between rule 101 and token '|' resolved as reduce (%left '|').
    Conflict between rule 101 and token '^' resolved as reduce (%left '^').
    Conflict between rule 101 and token '*' resolved as shift ('+' < '*').
    Conflict between rule 101 and token '/' resolved as shift ('+' < '/').
    Conflict between rule 101 and token '%' resolved as shift ('+' < '%').
    Conflict between rule 101 and token '&' resolved as shift ('+' < '&').


state 307

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  102     | expr '-' expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLT, LNE, LOROR, '+', '-', '|', '^', ')', ';', '=', ':', '}', ']', ',']
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    LANDNOT  shift, and go to state 178
    LLSH     shift, and go to state 186
    LRSH     shift, and go to state 190
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 102 (expr)

    Conflict between rule 102 and token LANDAND resolved as reduce (LANDAND < '-').
    Conflict between rule 102 and token LANDNOT resolved as shift ('-' < LANDNOT).
    Conflict between rule 102 and token LCOMM resolved as reduce (LCOMM < '-').
    Conflict between rule 102 and token LEQ resolved as reduce (LEQ < '-').
    Conflict between rule 102 and token LGE resolved as reduce (LGE < '-').
    Conflict between rule 102 and token LGT resolved as reduce (LGT < '-').
    Conflict between rule 102 and token LLE resolved as reduce (LLE < '-').
    Conflict between rule 102 and token LLSH resolved as shift ('-' < LLSH).
    Conflict between rule 102 and token LLT resolved as reduce (LLT < '-').
    Conflict between rule 102 and token LNE resolved as reduce (LNE < '-').
    Conflict between rule 102 and token LOROR resolved as reduce (LOROR < '-').
    Conflict between rule 102 and token LRSH resolved as shift ('-' < LRSH).
    Conflict between rule 102 and token '+' resolved as reduce (%left '+').
    Conflict between rule 102 and token '-' resolved as reduce (%left '-').
    Conflict between rule 102 and token '|' resolved as reduce (%left '|').
    Conflict between rule 102 and token '^' resolved as reduce (%left '^').
    Conflict between rule 102 and token '*' resolved as shift ('-' < '*').
    Conflict between rule 102 and token '/' resolved as shift ('-' < '/').
    Conflict between rule 102 and token '%' resolved as shift ('-' < '%').
    Conflict between rule 102 and token '&' resolved as shift ('-' < '&').


state 308

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  103     | expr '|' expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLT, LNE, LOROR, '+', '-', '|', '^', ')', ';', '=', ':', '}', ']', ',']
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    LANDNOT  shift, and go to state 178
    LLSH     shift, and go to state 186
    LRSH     shift, and go to state 190
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 103 (expr)

    Conflict between rule 103 and token LANDAND resolved as reduce (LANDAND < '|').
    Conflict between rule 103 and token LANDNOT resolved as shift ('|' < LANDNOT).
    Conflict between rule 103 and token LCOMM resolved as reduce (LCOMM < '|').
    Conflict between rule 103 and token LEQ resolved as reduce (LEQ < '|').
    Conflict between rule 103 and token LGE resolved as reduce (LGE < '|').
    Conflict between rule 103 and token LGT resolved as reduce (LGT < '|').
    Conflict between rule 103 and token LLE resolved as reduce (LLE < '|').
    Conflict between rule 103 and token LLSH resolved as shift ('|' < LLSH).
    Conflict between rule 103 and token LLT resolved as reduce (LLT < '|').
    Conflict between rule 103 and token LNE resolved as reduce (LNE < '|').
    Conflict between rule 103 and token LOROR resolved as reduce (LOROR < '|').
    Conflict between rule 103 and token LRSH resolved as shift ('|' < LRSH).
    Conflict between rule 103 and token '+' resolved as reduce (%left '+').
    Conflict between rule 103 and token '-' resolved as reduce (%left '-').
    Conflict between rule 103 and token '|' resolved as reduce (%left '|').
    Conflict between rule 103 and token '^' resolved as reduce (%left '^').
    Conflict between rule 103 and token '*' resolved as shift ('|' < '*').
    Conflict between rule 103 and token '/' resolved as shift ('|' < '/').
    Conflict between rule 103 and token '%' resolved as shift ('|' < '%').
    Conflict between rule 103 and token '&' resolved as shift ('|' < '&').


state 309

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  104     | expr '^' expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLT, LNE, LOROR, '+', '-', '|', '^', ')', ';', '=', ':', '}', ']', ',']
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    LANDNOT  shift, and go to state 178
    LLSH     shift, and go to state 186
    LRSH     shift, and go to state 190
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 104 (expr)

    Conflict between rule 104 and token LANDAND resolved as reduce (LANDAND < '^').
    Conflict between rule 104 and token LANDNOT resolved as shift ('^' < LANDNOT).
    Conflict between rule 104 and token LCOMM resolved as reduce (LCOMM < '^').
    Conflict between rule 104 and token LEQ resolved as reduce (LEQ < '^').
    Conflict between rule 104 and token LGE resolved as reduce (LGE < '^').
    Conflict between rule 104 and token LGT resolved as reduce (LGT < '^').
    Conflict between rule 104 and token LLE resolved as reduce (LLE < '^').
    Conflict between rule 104 and token LLSH resolved as shift ('^' < LLSH).
    Conflict between rule 104 and token LLT resolved as reduce (LLT < '^').
    Conflict between rule 104 and token LNE resolved as reduce (LNE < '^').
    Conflict between rule 104 and token LOROR resolved as reduce (LOROR < '^').
    Conflict between rule 104 and token LRSH resolved as shift ('^' < LRSH).
    Conflict between rule 104 and token '+' resolved as reduce (%left '+').
    Conflict between rule 104 and token '-' resolved as reduce (%left '-').
    Conflict between rule 104 and token '|' resolved as reduce (%left '|').
    Conflict between rule 104 and token '^' resolved as reduce (%left '^').
    Conflict between rule 104 and token '*' resolved as shift ('^' < '*').
    Conflict between rule 104 and token '/' resolved as shift ('^' < '/').
    Conflict between rule 104 and token '%' resolved as shift ('^' < '%').
    Conflict between rule 104 and token '&' resolved as shift ('^' < '&').


state 310

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  105     | expr '*' expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LANDNOT, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLSH, LLT, LNE, LOROR, LRSH, '+', '-', '|', '^', '*', '/', '%', '&', ')', ';', '=', ':', '}', ']', ',']
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    $default  reduce using rule 105 (expr)

    Conflict between rule 105 and token LANDAND resolved as reduce (LANDAND < '*').
    Conflict between rule 105 and token LANDNOT resolved as reduce (%left LANDNOT).
    Conflict between rule 105 and token LCOMM resolved as reduce (LCOMM < '*').
    Conflict between rule 105 and token LEQ resolved as reduce (LEQ < '*').
    Conflict between rule 105 and token LGE resolved as reduce (LGE < '*').
    Conflict between rule 105 and token LGT resolved as reduce (LGT < '*').
    Conflict between rule 105 and token LLE resolved as reduce (LLE < '*').
    Conflict between rule 105 and token LLSH resolved as reduce (%left LLSH).
    Conflict between rule 105 and token LLT resolved as reduce (LLT < '*').
    Conflict between rule 105 and token LNE resolved as reduce (LNE < '*').
    Conflict between rule 105 and token LOROR resolved as reduce (LOROR < '*').
    Conflict between rule 105 and token LRSH resolved as reduce (%left LRSH).
    Conflict between rule 105 and token '+' resolved as reduce ('+' < '*').
    Conflict between rule 105 and token '-' resolved as reduce ('-' < '*').
    Conflict between rule 105 and token '|' resolved as reduce ('|' < '*').
    Conflict between rule 105 and token '^' resolved as reduce ('^' < '*').
    Conflict between rule 105 and token '*' resolved as reduce (%left '*').
    Conflict between rule 105 and token '/' resolved as reduce (%left '/').
    Conflict between rule 105 and token '%' resolved as reduce (%left '%').
    Conflict between rule 105 and token '&' resolved as reduce (%left '&').


state 311

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  106     | expr '/' expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LANDNOT, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLSH, LLT, LNE, LOROR, LRSH, '+', '-', '|', '^', '*', '/', '%', '&', ')', ';', '=', ':', '}', ']', ',']
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    $default  reduce using rule 106 (expr)

    Conflict between rule 106 and token LANDAND resolved as reduce (LANDAND < '/').
    Conflict between rule 106 and token LANDNOT resolved as reduce (%left LANDNOT).
    Conflict between rule 106 and token LCOMM resolved as reduce (LCOMM < '/').
    Conflict between rule 106 and token LEQ resolved as reduce (LEQ < '/').
    Conflict between rule 106 and token LGE resolved as reduce (LGE < '/').
    Conflict between rule 106 and token LGT resolved as reduce (LGT < '/').
    Conflict between rule 106 and token LLE resolved as reduce (LLE < '/').
    Conflict between rule 106 and token LLSH resolved as reduce (%left LLSH).
    Conflict between rule 106 and token LLT resolved as reduce (LLT < '/').
    Conflict between rule 106 and token LNE resolved as reduce (LNE < '/').
    Conflict between rule 106 and token LOROR resolved as reduce (LOROR < '/').
    Conflict between rule 106 and token LRSH resolved as reduce (%left LRSH).
    Conflict between rule 106 and token '+' resolved as reduce ('+' < '/').
    Conflict between rule 106 and token '-' resolved as reduce ('-' < '/').
    Conflict between rule 106 and token '|' resolved as reduce ('|' < '/').
    Conflict between rule 106 and token '^' resolved as reduce ('^' < '/').
    Conflict between rule 106 and token '*' resolved as reduce (%left '*').
    Conflict between rule 106 and token '/' resolved as reduce (%left '/').
    Conflict between rule 106 and token '%' resolved as reduce (%left '%').
    Conflict between rule 106 and token '&' resolved as reduce (%left '&').


state 312

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  107     | expr '%' expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LANDNOT, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLSH, LLT, LNE, LOROR, LRSH, '+', '-', '|', '^', '*', '/', '%', '&', ')', ';', '=', ':', '}', ']', ',']
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    $default  reduce using rule 107 (expr)

    Conflict between rule 107 and token LANDAND resolved as reduce (LANDAND < '%').
    Conflict between rule 107 and token LANDNOT resolved as reduce (%left LANDNOT).
    Conflict between rule 107 and token LCOMM resolved as reduce (LCOMM < '%').
    Conflict between rule 107 and token LEQ resolved as reduce (LEQ < '%').
    Conflict between rule 107 and token LGE resolved as reduce (LGE < '%').
    Conflict between rule 107 and token LGT resolved as reduce (LGT < '%').
    Conflict between rule 107 and token LLE resolved as reduce (LLE < '%').
    Conflict between rule 107 and token LLSH resolved as reduce (%left LLSH).
    Conflict between rule 107 and token LLT resolved as reduce (LLT < '%').
    Conflict between rule 107 and token LNE resolved as reduce (LNE < '%').
    Conflict between rule 107 and token LOROR resolved as reduce (LOROR < '%').
    Conflict between rule 107 and token LRSH resolved as reduce (%left LRSH).
    Conflict between rule 107 and token '+' resolved as reduce ('+' < '%').
    Conflict between rule 107 and token '-' resolved as reduce ('-' < '%').
    Conflict between rule 107 and token '|' resolved as reduce ('|' < '%').
    Conflict between rule 107 and token '^' resolved as reduce ('^' < '%').
    Conflict between rule 107 and token '*' resolved as reduce (%left '*').
    Conflict between rule 107 and token '/' resolved as reduce (%left '/').
    Conflict between rule 107 and token '%' resolved as reduce (%left '%').
    Conflict between rule 107 and token '&' resolved as reduce (%left '&').


state 313

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  108     | expr '&' expr .  [LASOP, LCOLAS, LCASE, LDDD, LDEFAULT, LANDAND, LANDNOT, LBODY, LCOMM, LDEC, LEQ, LGE, LGT, LINC, LLE, LLSH, LLT, LNE, LOROR, LRSH, '+', '-', '|', '^', '*', '/', '%', '&', ')', ';', '=', ':', '}', ']', ',']
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    $default  reduce using rule 108 (expr)

    Conflict between rule 108 and token LANDAND resolved as reduce (LANDAND < '&').
    Conflict between rule 108 and token LANDNOT resolved as reduce (%left LANDNOT).
    Conflict between rule 108 and token LCOMM resolved as reduce (LCOMM < '&').
    Conflict between rule 108 and token LEQ resolved as reduce (LEQ < '&').
    Conflict between rule 108 and token LGE resolved as reduce (LGE < '&').
    Conflict between rule 108 and token LGT resolved as reduce (LGT < '&').
    Conflict between rule 108 and token LLE resolved as reduce (LLE < '&').
    Conflict between rule 108 and token LLSH resolved as reduce (%left LLSH).
    Conflict between rule 108 and token LLT resolved as reduce (LLT < '&').
    Conflict between rule 108 and token LNE resolved as reduce (LNE < '&').
    Conflict between rule 108 and token LOROR resolved as reduce (LOROR < '&').
    Conflict between rule 108 and token LRSH resolved as reduce (%left LRSH).
    Conflict between rule 108 and token '+' resolved as reduce ('+' < '&').
    Conflict between rule 108 and token '-' resolved as reduce ('-' < '&').
    Conflict between rule 108 and token '|' resolved as reduce ('|' < '&').
    Conflict between rule 108 and token '^' resolved as reduce ('^' < '&').
    Conflict between rule 108 and token '*' resolved as reduce (%left '*').
    Conflict between rule 108 and token '/' resolved as reduce (%left '/').
    Conflict between rule 108 and token '%' resolved as reduce (%left '%').
    Conflict between rule 108 and token '&' resolved as reduce (%left '&').


state 314

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  136               | pexpr_no_paren '{' start_complit . braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  140 keyval: . expr ':' complitexpr
  141 bare_complitexpr: . expr
  142                 | . '{' start_complit braced_keyval_list '}'
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  279 keyval_list: . keyval
  280            | . bare_complitexpr
  281            | . keyval_list ',' keyval
  282            | . keyval_list ',' bare_complitexpr
  283 braced_keyval_list: .  ['}']
  284                   | . keyval_list ocomma

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '{'         shift, and go to state 421
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 283 (braced_keyval_list)

    expr                go to state 422
    uexpr               go to state 74
    pseudocall          go to state 75
    pexpr_no_paren      go to state 76
    keyval              go to state 423
    bare_complitexpr    go to state 424
    pexpr               go to state 77
    sym                 go to state 117
    hidden_importsym    go to state 13
    name                go to state 80
    convtype            go to state 82
    comptype            go to state 83
    othertype           go to state 84
    structtype          go to state 85
    interfacetype       go to state 86
    fntype              go to state 88
    fnlitdcl            go to state 89
    fnliteral           go to state 90
    keyval_list         go to state 425
    braced_keyval_list  go to state 426


state 315

  122 pseudocall: pexpr '(' ')' .

    $default  reduce using rule 122 (pseudocall)


state 316

  277 expr_or_type_list: expr_or_type .

    $default  reduce using rule 277 (expr_or_type_list)


state 317

  123 pseudocall: pexpr '(' expr_or_type_list . ocomma ')'
  124           | pexpr '(' expr_or_type_list . LDDD ocomma ')'
  278 expr_or_type_list: expr_or_type_list . ',' expr_or_type
  287 ocomma: .  [')']
  288       | . ','

    LDDD  shift, and go to state 427
    ','   shift, and go to state 428

    $default  reduce using rule 287 (ocomma)

    ocomma  go to state 429


state 318

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  128               | pexpr '.' '(' . expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  129               | pexpr '.' '(' . LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  147 expr_or_type: . expr
  148             | . non_expr_type
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  171 non_expr_type: . recvchantype
  172              | . fntype
  173              | . othertype
  174              | . '*' non_expr_type
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LTYPE       shift, and go to state 430
    LCOMM       shift, and go to state 159
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 160
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 161
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    expr_or_type      go to state 431
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    non_expr_type     go to state 163
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 164
    recvchantype      go to state 165
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 166
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 319

  127 pexpr_no_paren: pexpr '.' sym .

    $default  reduce using rule 127 (pexpr_no_paren)


state 320

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr
  130 pexpr_no_paren: pexpr '[' expr . ']'
  290 oexpr: expr .  [':']

    LANDAND  shift, and go to state 177
    LANDNOT  shift, and go to state 178
    LCOMM    shift, and go to state 179
    LEQ      shift, and go to state 181
    LGE      shift, and go to state 182
    LGT      shift, and go to state 183
    LLE      shift, and go to state 185
    LLSH     shift, and go to state 186
    LLT      shift, and go to state 187
    LNE      shift, and go to state 188
    LOROR    shift, and go to state 189
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198
    ']'      shift, and go to state 432

    $default  reduce using rule 290 (oexpr)


state 321

  131 pexpr_no_paren: pexpr '[' oexpr . ':' oexpr ']'
  132               | pexpr '[' oexpr . ':' oexpr ':' oexpr ']'

    ':'  shift, and go to state 433


state 322

   28 common_dcl: . LVAR vardcl
   29           | . LVAR '(' vardcl_list osemi ')'
   30           | . LVAR '(' ')'
   31           | . lconst constdcl
   32           | . lconst '(' constdcl osemi ')'
   33           | . lconst '(' constdcl ';' constdcl_list osemi ')'
   34           | . lconst '(' ')'
   35           | . LTYPE typedcl
   36           | . LTYPE '(' typedcl_list osemi ')'
   37           | . LTYPE '(' ')'
   38 lconst: . LCONST
   49 simple_stmt: . expr
   50            | . expr LASOP expr
   51            | . expr_list '=' expr_list
   52            | . expr_list LCOLAS expr_list
   53            | . expr LINC
   54            | . expr LDEC
   60 compound_stmt: . '{' $@3 stmt_list '}'
   74 for_stmt: . LFOR $@6 for_body
   80 if_stmt: . LIF $@7 if_header $@8 loop_body $@9 elseif_list else
   89 switch_stmt: . LSWITCH $@11 if_header $@12 LBODY caseblock_list '}'
   91 select_stmt: . LSELECT $@13 LBODY caseblock_list '}'
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  152 new_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  162 labelname: . new_name
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  250 stmt: .  [LCASE, LDEFAULT, ';', '}']
  251     | . compound_stmt
  252     | . common_dcl
  253     | . non_dcl_stmt
  254     | . error
  255 non_dcl_stmt: . simple_stmt
  256             | . for_stmt
  257             | . switch_stmt
  258             | . select_stmt
  259             | . if_stmt
  261             | . labelname ':' $@14 stmt
  261             | labelname ':' $@14 . stmt
  262             | . LFALL
  263             | . LBREAK onew_name
  264             | . LCONTINUE onew_name
  265             | . LGO pseudocall
  266             | . LDEFER pseudocall
  267             | . LGOTO new_name
  268             | . LRETURN oexpr_list
  275 expr_list: . expr
  276          | . expr_list ',' expr

    error       shift, and go to state 325
    LLITERAL    shift, and go to state 35
    LBREAK      shift, and go to state 36
    LCHAN       shift, and go to state 37
    LCONST      shift, and go to state 38
    LCONTINUE   shift, and go to state 39
    LDEFER      shift, and go to state 40
    LFALL       shift, and go to state 41
    LFOR        shift, and go to state 42
    LFUNC       shift, and go to state 113
    LGO         shift, and go to state 44
    LGOTO       shift, and go to state 45
    LIF         shift, and go to state 46
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LRETURN     shift, and go to state 49
    LSELECT     shift, and go to state 50
    LSTRUCT     shift, and go to state 51
    LSWITCH     shift, and go to state 52
    LTYPE       shift, and go to state 53
    LVAR        shift, and go to state 54
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '{'         shift, and go to state 326
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    LCASE     reduce using rule 250 (stmt)
    LDEFAULT  reduce using rule 250 (stmt)
    ';'       reduce using rule 250 (stmt)
    '}'       reduce using rule 250 (stmt)

    common_dcl        go to state 327
    lconst            go to state 67
    simple_stmt       go to state 68
    compound_stmt     go to state 328
    for_stmt          go to state 69
    if_stmt           go to state 70
    switch_stmt       go to state 71
    select_stmt       go to state 72
    expr              go to state 73
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    new_name          go to state 78
    sym               go to state 79
    hidden_importsym  go to state 13
    name              go to state 80
    labelname         go to state 81
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    stmt              go to state 434
    non_dcl_stmt      go to state 330
    expr_list         go to state 92


state 323

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr
  134 pexpr_no_paren: convtype '(' expr . ocomma ')'
  287 ocomma: .  [')']
  288       | . ','

    LANDAND  shift, and go to state 177
    LANDNOT  shift, and go to state 178
    LCOMM    shift, and go to state 179
    LEQ      shift, and go to state 181
    LGE      shift, and go to state 182
    LGT      shift, and go to state 183
    LLE      shift, and go to state 185
    LLSH     shift, and go to state 186
    LLT      shift, and go to state 187
    LNE      shift, and go to state 188
    LOROR    shift, and go to state 189
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198
    ','      shift, and go to state 435

    $default  reduce using rule 287 (ocomma)

    ocomma  go to state 436


state 324

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  135               | comptype lbrace start_complit . braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  140 keyval: . expr ':' complitexpr
  141 bare_complitexpr: . expr
  142                 | . '{' start_complit braced_keyval_list '}'
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  279 keyval_list: . keyval
  280            | . bare_complitexpr
  281            | . keyval_list ',' keyval
  282            | . keyval_list ',' bare_complitexpr
  283 braced_keyval_list: .  ['}']
  284                   | . keyval_list ocomma

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '{'         shift, and go to state 421
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 283 (braced_keyval_list)

    expr                go to state 422
    uexpr               go to state 74
    pseudocall          go to state 75
    pexpr_no_paren      go to state 76
    keyval              go to state 423
    bare_complitexpr    go to state 424
    pexpr               go to state 77
    sym                 go to state 117
    hidden_importsym    go to state 13
    name                go to state 80
    convtype            go to state 82
    comptype            go to state 83
    othertype           go to state 84
    structtype          go to state 85
    interfacetype       go to state 86
    fntype              go to state 88
    fnlitdcl            go to state 89
    fnliteral           go to state 90
    keyval_list         go to state 425
    braced_keyval_list  go to state 437


state 325

  254 stmt: error .

    $default  reduce using rule 254 (stmt)


state 326

   59 $@3: .
   60 compound_stmt: '{' . $@3 stmt_list '}'

    $default  reduce using rule 59 ($@3)

    $@3  go to state 438


state 327

  252 stmt: common_dcl .

    $default  reduce using rule 252 (stmt)


state 328

  251 stmt: compound_stmt .

    $default  reduce using rule 251 (stmt)


state 329

  269 stmt_list: stmt .

    $default  reduce using rule 269 (stmt_list)


state 330

  253 stmt: non_dcl_stmt .

    $default  reduce using rule 253 (stmt)


state 331

  215 fnliteral: fnlitdcl lbrace stmt_list . '}'
  270 stmt_list: stmt_list . ';' stmt

    ';'  shift, and go to state 439
    '}'  shift, and go to state 440


state 332

   52 simple_stmt: expr_list LCOLAS expr_list .  [LCASE, LDEFAULT, LBODY, ';', '}']
  276 expr_list: expr_list . ',' expr

    ','  shift, and go to state 210

    $default  reduce using rule 52 (simple_stmt)


state 333

   51 simple_stmt: expr_list '=' expr_list .  [LCASE, LDEFAULT, LBODY, ';', '}']
  276 expr_list: expr_list . ',' expr

    ','  shift, and go to state 210

    $default  reduce using rule 51 (simple_stmt)


state 334

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr
  276 expr_list: expr_list ',' expr .  [LCOLAS, LCASE, LDEFAULT, LBODY, ')', ';', '=', '}', ',']

    LANDAND  shift, and go to state 177
    LANDNOT  shift, and go to state 178
    LCOMM    shift, and go to state 179
    LEQ      shift, and go to state 181
    LGE      shift, and go to state 182
    LGT      shift, and go to state 183
    LLE      shift, and go to state 185
    LLSH     shift, and go to state 186
    LLT      shift, and go to state 187
    LNE      shift, and go to state 188
    LOROR    shift, and go to state 189
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 276 (expr_list)


state 335

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  314 hidden_type_non_recv_chan: . hidden_type_misc
  315                          | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  324                 | LCHAN . hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  325                 | LCHAN . '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  326                 | LCHAN . LCOMM hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 339
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 441
    '*'         shift, and go to state 342
    '('         shift, and go to state 442
    '['         shift, and go to state 344
    '@'         shift, and go to state 11

    hidden_importsym           go to state 345
    hidden_type_non_recv_chan  go to state 443
    hidden_type_misc           go to state 444
    hidden_type_func           go to state 445


state 336

  328 hidden_type_func: LFUNC . '(' ohidden_funarg_list ')' ohidden_funres

    '('  shift, and go to state 446


state 337

  322 hidden_type_misc: LINTERFACE . '{' ohidden_interfacedcl_list '}'

    '{'  shift, and go to state 447


state 338

  320 hidden_type_misc: LMAP . '[' hidden_type ']' hidden_type

    '['  shift, and go to state 448


state 339

  317 hidden_type_misc: LNAME .

    $default  reduce using rule 317 (hidden_type_misc)


state 340

  321 hidden_type_misc: LSTRUCT . '{' ohidden_structdcl_list '}'

    '{'  shift, and go to state 449


state 341

  327 hidden_type_recv_chan: LCOMM . LCHAN hidden_type

    LCHAN  shift, and go to state 450


state 342

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  323                 | '*' . hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 339
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '['         shift, and go to state 344
    '@'         shift, and go to state 11

    hidden_importsym       go to state 345
    hidden_type            go to state 451
    hidden_type_misc       go to state 347
    hidden_type_recv_chan  go to state 348
    hidden_type_func       go to state 349


state 343

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  305 hidden_import: LCONST hidden_pkg_importsym '=' . hidden_constant ';'
  338 hidden_literal: . LLITERAL
  339               | . '-' LLITERAL
  340               | . sym
  341 hidden_constant: . hidden_literal
  342                | . '(' hidden_literal '+' hidden_literal ')'

    LLITERAL  shift, and go to state 452
    LNAME     shift, and go to state 9
    '-'       shift, and go to state 453
    '('       shift, and go to state 454
    '?'       shift, and go to state 10
    '@'       shift, and go to state 11

    sym               go to state 455
    hidden_importsym  go to state 13
    hidden_literal    go to state 456
    hidden_constant   go to state 457


state 344

  318 hidden_type_misc: '[' . ']' hidden_type
  319                 | '[' . LLITERAL ']' hidden_type

    LLITERAL  shift, and go to state 458
    ']'       shift, and go to state 459


state 345

  316 hidden_type_misc: hidden_importsym .

    $default  reduce using rule 316 (hidden_type_misc)


state 346

  306 hidden_import: LCONST hidden_pkg_importsym hidden_type . '=' hidden_constant ';'

    '='  shift, and go to state 460


state 347

  311 hidden_type: hidden_type_misc .

    $default  reduce using rule 311 (hidden_type)


state 348

  312 hidden_type: hidden_type_recv_chan .

    $default  reduce using rule 312 (hidden_type)


state 349

  313 hidden_type: hidden_type_func .

    $default  reduce using rule 313 (hidden_type)


state 350

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres
  329 hidden_funarg: sym . hidden_type oliteral
  330              | sym . LDDD hidden_type oliteral

    LCHAN       shift, and go to state 335
    LDDD        shift, and go to state 461
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 339
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '['         shift, and go to state 344
    '@'         shift, and go to state 11

    hidden_importsym       go to state 345
    hidden_type            go to state 462
    hidden_type_misc       go to state 347
    hidden_type_recv_chan  go to state 348
    hidden_type_func       go to state 349


state 351

  345 hidden_funarg_list: hidden_funarg .

    $default  reduce using rule 345 (hidden_funarg_list)


state 352

  207 hidden_fndcl: '(' hidden_funarg_list . ')' sym '(' ohidden_funarg_list ')' ohidden_funres
  346 hidden_funarg_list: hidden_funarg_list . ',' hidden_funarg

    ')'  shift, and go to state 463
    ','  shift, and go to state 464


state 353

  308 hidden_import: LFUNC hidden_fndcl fnbody . ';'

    ';'  shift, and go to state 465


state 354

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  206 hidden_fndcl: hidden_pkg_importsym '(' . ohidden_funarg_list ')' ohidden_funres
  295 ohidden_funarg_list: .  [')']
  296                    | . hidden_funarg_list
  329 hidden_funarg: . sym hidden_type oliteral
  330              | . sym LDDD hidden_type oliteral
  345 hidden_funarg_list: . hidden_funarg
  346                   | . hidden_funarg_list ',' hidden_funarg

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    $default  reduce using rule 295 (ohidden_funarg_list)

    sym                  go to state 350
    hidden_importsym     go to state 13
    ohidden_funarg_list  go to state 466
    hidden_funarg        go to state 351
    hidden_funarg_list   go to state 467


state 355

  303 hidden_import: LIMPORT LNAME LLITERAL . ';'

    ';'  shift, and go to state 468


state 356

  307 hidden_import: LTYPE hidden_pkgtype hidden_type . ';'

    ';'  shift, and go to state 469


state 357

  304 hidden_import: LVAR hidden_pkg_importsym hidden_type . ';'

    ';'  shift, and go to state 470


state 358

   14 import_stmt_list: import_stmt_list ';' import_stmt .

    $default  reduce using rule 14 (import_stmt_list)


state 359

    9 import: LIMPORT '(' import_stmt_list osemi ')' .

    $default  reduce using rule 9 (import)


state 360

  208 fntype: LFUNC '(' oarg_type_list_ocomma . ')' fnres

    ')'  shift, and go to state 471


state 361

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  198             | LCOMM LCHAN . ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    ntype             go to state 409
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232


state 362

  170 ntype: '(' ntype . ')'

    ')'  shift, and go to state 472


state 363

  179 non_recvchantype: '(' ntype ')' .

    $default  reduce using rule 179 (non_recvchantype)


state 364

  189 dotname: name '.' sym .

    $default  reduce using rule 189 (dotname)


state 365

   65 $@5: .
   66 loop_body: LBODY . $@5 stmt_list '}'

    $default  reduce using rule 65 ($@5)

    $@5  go to state 473


state 366

   72 for_body: for_header loop_body .

    $default  reduce using rule 72 (for_body)


state 367

   52 simple_stmt: expr_list LCOLAS . expr_list
   68 range_stmt: expr_list LCOLAS . LRANGE expr
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  275 expr_list: . expr
  276          | . expr_list ',' expr

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LRANGE      shift, and go to state 474
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 138
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    expr_list         go to state 332


state 368

   51 simple_stmt: expr_list '=' . expr_list
   67 range_stmt: expr_list '=' . LRANGE expr
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  275 expr_list: . expr
  276          | . expr_list ',' expr

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LRANGE      shift, and go to state 475
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 138
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    expr_list         go to state 333


state 369

   49 simple_stmt: . expr
   50            | . expr LASOP expr
   51            | . expr_list '=' expr_list
   52            | . expr_list LCOLAS expr_list
   53            | . expr LINC
   54            | . expr LDEC
   69 for_header: osimple_stmt ';' . osimple_stmt ';' osimple_stmt
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  275 expr_list: . expr
  276          | . expr_list ',' expr
  293 osimple_stmt: .  [';']
  294             | . simple_stmt

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 293 (osimple_stmt)

    simple_stmt       go to state 236
    expr              go to state 73
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    expr_list         go to state 92
    osimple_stmt      go to state 476


state 370

  164 dotdotdot: LDDD ntype .

    $default  reduce using rule 164 (dotdotdot)


state 371

  243 arg_type: sym name_or_type .

    $default  reduce using rule 243 (arg_type)


state 372

  244 arg_type: sym dotdotdot .

    $default  reduce using rule 244 (arg_type)


state 373

  149 name_or_type: . ntype
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  163 dotdotdot: . LDDD
  164          | . LDDD ntype
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  242 arg_type: . name_or_type
  243         | . sym name_or_type
  244         | . sym dotdotdot
  245         | . dotdotdot
  247 arg_type_list: arg_type_list ',' . arg_type
  288 ocomma: ',' .  [')']

    LCHAN       shift, and go to state 37
    LDDD        shift, and go to state 242
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 288 (ocomma)

    name_or_type      go to state 243
    sym               go to state 244
    hidden_importsym  go to state 13
    name              go to state 118
    dotdotdot         go to state 245
    ntype             go to state 246
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232
    arg_type          go to state 477


state 374

  249 oarg_type_list_ocomma: arg_type_list ocomma .

    $default  reduce using rule 249 (oarg_type_list_ocomma)


state 375

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  183 fnret_type: . recvchantype
  184           | . fntype
  185           | . othertype
  186           | . ptrtype
  187           | . dotname
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  205 fndcl: '(' oarg_type_list_ocomma ')' . sym '(' oarg_type_list_ocomma ')' fnres
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  208       | LFUNC '(' oarg_type_list_ocomma ')' . fnres
  211 fnres: .  [error, LBODY, '{']
  212      | . fnret_type
  213      | . '(' oarg_type_list_ocomma ')'

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 478
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 211 (fnres)

    sym               go to state 479
    hidden_importsym  go to state 13
    name              go to state 118
    fnret_type        go to state 480
    dotname           go to state 481
    othertype         go to state 482
    ptrtype           go to state 483
    recvchantype      go to state 484
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 485
    fnres             go to state 486

    Conflict between rule 211 and token '(' resolved as shift (NotParen < '(').


state 376

  204 fndcl: sym '(' oarg_type_list_ocomma . ')' fnres

    ')'  shift, and go to state 487


state 377

  210 fnbody: '{' stmt_list . '}'
  270 stmt_list: stmt_list . ';' stmt

    ';'  shift, and go to state 439
    '}'  shift, and go to state 488


state 378

   66 loop_body: . LBODY $@5 stmt_list '}'
   80 if_stmt: LIF $@7 if_header $@8 . loop_body $@9 elseif_list else

    LBODY  shift, and go to state 365

    loop_body  go to state 489


state 379

   49 simple_stmt: . expr
   50            | . expr LASOP expr
   51            | . expr_list '=' expr_list
   52            | . expr_list LCOLAS expr_list
   53            | . expr LINC
   54            | . expr LDEC
   76 if_header: osimple_stmt ';' . osimple_stmt
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  275 expr_list: . expr
  276          | . expr_list ',' expr
  293 osimple_stmt: .  [LBODY]
  294             | . simple_stmt

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 293 (osimple_stmt)

    simple_stmt       go to state 236
    expr              go to state 73
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    expr_list         go to state 92
    osimple_stmt      go to state 490


state 380

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  236 packname: LNAME '.' . sym

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    sym               go to state 491
    hidden_importsym  go to state 13


state 381

  235 packname: LNAME .  [LLITERAL, ')', ';', '}']
  236         | LNAME . '.' sym

    '.'  shift, and go to state 380

    $default  reduce using rule 235 (packname)


state 382

  240 interfacedcl: '(' packname . ')'

    ')'  shift, and go to state 492


state 383

  149 name_or_type: . ntype
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  163 dotdotdot: . LDDD
  164          | . LDDD ntype
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  241 indcl: '(' . oarg_type_list_ocomma ')' fnres
  242 arg_type: . name_or_type
  243         | . sym name_or_type
  244         | . sym dotdotdot
  245         | . dotdotdot
  246 arg_type_list: . arg_type
  247              | . arg_type_list ',' arg_type
  248 oarg_type_list_ocomma: .  [')']
  249                      | . arg_type_list ocomma

    LCHAN       shift, and go to state 37
    LDDD        shift, and go to state 242
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 248 (oarg_type_list_ocomma)

    name_or_type           go to state 243
    sym                    go to state 244
    hidden_importsym       go to state 13
    name                   go to state 118
    dotdotdot              go to state 245
    ntype                  go to state 246
    dotname                go to state 228
    othertype              go to state 229
    ptrtype                go to state 230
    recvchantype           go to state 231
    structtype             go to state 85
    interfacetype          go to state 86
    fntype                 go to state 232
    arg_type               go to state 247
    arg_type_list          go to state 248
    oarg_type_list_ocomma  go to state 493


state 384

  238 interfacedcl: new_name indcl .

    $default  reduce using rule 238 (interfacedcl)


state 385

  152 new_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  228 interfacedcl_list: interfacedcl_list ';' . interfacedcl
  235 packname: . LNAME
  236         | . LNAME '.' sym
  238 interfacedcl: . new_name indcl
  239             | . packname
  240             | . '(' packname ')'
  286 osemi: ';' .  ['}']

    LNAME  shift, and go to state 255
    '('    shift, and go to state 256
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    $default  reduce using rule 286 (osemi)

    new_name          go to state 258
    sym               go to state 112
    hidden_importsym  go to state 13
    packname          go to state 260
    interfacedcl      go to state 494


state 386

  201 interfacetype: LINTERFACE lbrace interfacedcl_list osemi . '}'

    '}'  shift, and go to state 495


state 387

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  194          | LMAP '[' ntype ']' . ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    ntype             go to state 496
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232


state 388

   55 case: . LCASE expr_or_type_list ':'
   56     | . LCASE expr_or_type_list '=' expr ':'
   57     | . LCASE expr_or_type_list LCOLAS expr ':'
   58     | . LDEFAULT ':'
   62 caseblock: . case $@4 stmt_list
   64 caseblock_list: caseblock_list . caseblock
   91 select_stmt: LSELECT $@13 LBODY caseblock_list . '}'

    LCASE     shift, and go to state 497
    LDEFAULT  shift, and go to state 498
    '}'       shift, and go to state 499

    case       go to state 500
    caseblock  go to state 501


state 389

  234 structdcl: '*' '(' . embed ')' oliteral
  235 packname: . LNAME
  236         | . LNAME '.' sym
  237 embed: . packname

    LNAME  shift, and go to state 381

    packname  go to state 270
    embed     go to state 502


state 390

  232 structdcl: '*' embed . oliteral
  301 oliteral: .  [';', '}']
  302         | . LLITERAL

    LLITERAL  shift, and go to state 395

    $default  reduce using rule 301 (oliteral)

    oliteral  go to state 503


state 391

  233 structdcl: '(' '*' . embed ')' oliteral
  235 packname: . LNAME
  236         | . LNAME '.' sym
  237 embed: . packname

    LNAME  shift, and go to state 381

    packname  go to state 270
    embed     go to state 504


state 392

  231 structdcl: '(' embed . ')' oliteral

    ')'  shift, and go to state 505


state 393

  152 new_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  226 structdcl_list: structdcl_list ';' . structdcl
  229 structdcl: . new_name_list ntype oliteral
  230          | . embed oliteral
  231          | . '(' embed ')' oliteral
  232          | . '*' embed oliteral
  233          | . '(' '*' embed ')' oliteral
  234          | . '*' '(' embed ')' oliteral
  235 packname: . LNAME
  236         | . LNAME '.' sym
  237 embed: . packname
  271 new_name_list: . new_name
  272              | . new_name_list ',' new_name
  286 osemi: ';' .  ['}']

    LNAME  shift, and go to state 255
    '*'    shift, and go to state 264
    '('    shift, and go to state 265
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    $default  reduce using rule 286 (osemi)

    new_name          go to state 267
    sym               go to state 112
    hidden_importsym  go to state 13
    structdcl         go to state 506
    packname          go to state 270
    embed             go to state 271
    new_name_list     go to state 272


state 394

  199 structtype: LSTRUCT lbrace structdcl_list osemi . '}'

    '}'  shift, and go to state 507


state 395

  302 oliteral: LLITERAL .

    $default  reduce using rule 302 (oliteral)


state 396

  230 structdcl: embed oliteral .

    $default  reduce using rule 230 (structdcl)


state 397

  152 new_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  272 new_name_list: new_name_list ',' . new_name

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    new_name          go to state 508
    sym               go to state 112
    hidden_importsym  go to state 13


state 398

  229 structdcl: new_name_list ntype . oliteral
  301 oliteral: .  [';', '}']
  302         | . LLITERAL

    LLITERAL  shift, and go to state 395

    $default  reduce using rule 301 (oliteral)

    oliteral  go to state 509


state 399

   89 switch_stmt: LSWITCH $@11 if_header $@12 . LBODY caseblock_list '}'

    LBODY  shift, and go to state 510


state 400

   47 typedclname: . sym
   48 typedcl: . typedclname ntype
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  224 typedcl_list: typedcl_list ';' . typedcl
  286 osemi: ';' .  [')']

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    $default  reduce using rule 286 (osemi)

    typedclname       go to state 145
    typedcl           go to state 511
    sym               go to state 147
    hidden_importsym  go to state 13


state 401

   36 common_dcl: LTYPE '(' typedcl_list osemi . ')'

    ')'  shift, and go to state 512


state 402

   39 vardcl: . dcl_name_list ntype
   40       | . dcl_name_list ntype '=' expr_list
   41       | . dcl_name_list '=' expr_list
  153 dcl_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  220 vardcl_list: vardcl_list ';' . vardcl
  273 dcl_name_list: . dcl_name
  274              | . dcl_name_list ',' dcl_name
  286 osemi: ';' .  [')']

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    $default  reduce using rule 286 (osemi)

    vardcl            go to state 513
    dcl_name          go to state 150
    sym               go to state 151
    hidden_importsym  go to state 13
    dcl_name_list     go to state 152


state 403

   29 common_dcl: LVAR '(' vardcl_list osemi . ')'

    ')'  shift, and go to state 514


state 404

   41 vardcl: dcl_name_list '=' expr_list .  [LCASE, LDEFAULT, ')', ';', '}']
  276 expr_list: expr_list . ',' expr

    ','  shift, and go to state 210

    $default  reduce using rule 41 (vardcl)


state 405

  274 dcl_name_list: dcl_name_list ',' dcl_name .

    $default  reduce using rule 274 (dcl_name_list)


state 406

   40 vardcl: dcl_name_list ntype '=' . expr_list
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  275 expr_list: . expr
  276          | . expr_list ',' expr

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 138
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    expr_list         go to state 515


state 407

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  193          | LCHAN LCOMM . ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  198             | LCOMM . LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres

    LCHAN       shift, and go to state 284
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    ntype             go to state 227
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232


state 408

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  170      | '(' . ntype ')'
  179 non_recvchantype: '(' . ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    ntype             go to state 516
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232


state 409

  198 recvchantype: LCOMM LCHAN ntype .

    $default  reduce using rule 198 (recvchantype)


state 410

  169 ntype: dotname .  [LCOLAS, LDDD, ')', '=', ':', ',']
  178 non_recvchantype: dotname .  [LBODY, '(', '{']

    LBODY     reduce using rule 178 (non_recvchantype)
    '('       reduce using rule 178 (non_recvchantype)
    '{'       reduce using rule 178 (non_recvchantype)
    $default  reduce using rule 169 (ntype)


state 411

  167 ntype: othertype .  [LCOLAS, LDDD, ')', '=', ':', ',']
  176 non_recvchantype: othertype .  [LBODY, '(', '{']

    LBODY     reduce using rule 176 (non_recvchantype)
    '('       reduce using rule 176 (non_recvchantype)
    '{'       reduce using rule 176 (non_recvchantype)
    $default  reduce using rule 167 (ntype)


state 412

  168 ntype: ptrtype .  [LCOLAS, LDDD, ')', '=', ':', ',']
  177 non_recvchantype: ptrtype .  [LBODY, '(', '{']

    LBODY     reduce using rule 177 (non_recvchantype)
    '('       reduce using rule 177 (non_recvchantype)
    '{'       reduce using rule 177 (non_recvchantype)
    $default  reduce using rule 168 (ntype)


state 413

  166 ntype: fntype .  [LCOLAS, LDDD, ')', '=', ':', ',']
  175 non_recvchantype: fntype .  [LBODY, '(', '{']

    LBODY     reduce using rule 175 (non_recvchantype)
    '('       reduce using rule 175 (non_recvchantype)
    '{'       reduce using rule 175 (non_recvchantype)
    $default  reduce using rule 166 (ntype)


state 414

  137 pexpr_no_paren: '(' expr_or_type ')' '{' . start_complit braced_keyval_list '}'
  139 start_complit: .

    $default  reduce using rule 139 (start_complit)

    start_complit  go to state 517


state 415

  191 othertype: '[' LDDD ']' ntype .

    $default  reduce using rule 191 (othertype)


state 416

  190 othertype: '[' oexpr ']' ntype .

    $default  reduce using rule 190 (othertype)


state 417

   33 common_dcl: lconst '(' constdcl ';' . constdcl_list osemi ')'
   42 constdcl: . dcl_name_list ntype '=' expr_list
   43         | . dcl_name_list '=' expr_list
   44 constdcl1: . constdcl
   45          | . dcl_name_list ntype
   46          | . dcl_name_list
  153 dcl_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  221 constdcl_list: . constdcl1
  222              | . constdcl_list ';' constdcl1
  273 dcl_name_list: . dcl_name
  274              | . dcl_name_list ',' dcl_name
  286 osemi: ';' .  [')']

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    $default  reduce using rule 286 (osemi)

    constdcl          go to state 518
    constdcl1         go to state 519
    dcl_name          go to state 150
    sym               go to state 151
    hidden_importsym  go to state 13
    constdcl_list     go to state 520
    dcl_name_list     go to state 521


state 418

   32 common_dcl: lconst '(' constdcl osemi . ')'

    ')'  shift, and go to state 522


state 419

   43 constdcl: dcl_name_list '=' expr_list .  [LCASE, LDEFAULT, ')', ';', '}']
  276 expr_list: expr_list . ',' expr

    ','  shift, and go to state 210

    $default  reduce using rule 43 (constdcl)


state 420

   42 constdcl: dcl_name_list ntype '=' . expr_list
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  275 expr_list: . expr
  276          | . expr_list ',' expr

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 138
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    expr_list         go to state 523


state 421

  139 start_complit: .
  142 bare_complitexpr: '{' . start_complit braced_keyval_list '}'

    $default  reduce using rule 139 (start_complit)

    start_complit  go to state 524


state 422

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr
  140 keyval: expr . ':' complitexpr
  141 bare_complitexpr: expr .  ['}', ',']

    LANDAND  shift, and go to state 177
    LANDNOT  shift, and go to state 178
    LCOMM    shift, and go to state 179
    LEQ      shift, and go to state 181
    LGE      shift, and go to state 182
    LGT      shift, and go to state 183
    LLE      shift, and go to state 185
    LLSH     shift, and go to state 186
    LLT      shift, and go to state 187
    LNE      shift, and go to state 188
    LOROR    shift, and go to state 189
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198
    ':'      shift, and go to state 525

    $default  reduce using rule 141 (bare_complitexpr)


state 423

  279 keyval_list: keyval .

    $default  reduce using rule 279 (keyval_list)


state 424

  280 keyval_list: bare_complitexpr .

    $default  reduce using rule 280 (keyval_list)


state 425

  281 keyval_list: keyval_list . ',' keyval
  282            | keyval_list . ',' bare_complitexpr
  284 braced_keyval_list: keyval_list . ocomma
  287 ocomma: .  ['}']
  288       | . ','

    ','  shift, and go to state 526

    $default  reduce using rule 287 (ocomma)

    ocomma  go to state 527


state 426

  136 pexpr_no_paren: pexpr_no_paren '{' start_complit braced_keyval_list . '}'

    '}'  shift, and go to state 528


state 427

  124 pseudocall: pexpr '(' expr_or_type_list LDDD . ocomma ')'
  287 ocomma: .  [')']
  288       | . ','

    ','  shift, and go to state 435

    $default  reduce using rule 287 (ocomma)

    ocomma  go to state 529


state 428

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  147 expr_or_type: . expr
  148             | . non_expr_type
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  171 non_expr_type: . recvchantype
  172              | . fntype
  173              | . othertype
  174              | . '*' non_expr_type
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  278 expr_or_type_list: expr_or_type_list ',' . expr_or_type
  288 ocomma: ',' .  [')']

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 159
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 160
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 288 (ocomma)

    expr              go to state 161
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    expr_or_type      go to state 530
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    non_expr_type     go to state 163
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 164
    recvchantype      go to state 165
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 166
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 429

  123 pseudocall: pexpr '(' expr_or_type_list ocomma . ')'

    ')'  shift, and go to state 531


state 430

  129 pexpr_no_paren: pexpr '.' '(' LTYPE . ')'

    ')'  shift, and go to state 532


state 431

  128 pexpr_no_paren: pexpr '.' '(' expr_or_type . ')'

    ')'  shift, and go to state 533


state 432

  130 pexpr_no_paren: pexpr '[' expr ']' .

    $default  reduce using rule 130 (pexpr_no_paren)


state 433

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  131               | pexpr '[' oexpr ':' . oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  132               | pexpr '[' oexpr ':' . oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  289 oexpr: .  [':', ']']
  290      | . expr

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 289 (oexpr)

    expr              go to state 170
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    oexpr             go to state 534


state 434

  261 non_dcl_stmt: labelname ':' $@14 stmt .

    $default  reduce using rule 261 (non_dcl_stmt)


state 435

  288 ocomma: ',' .

    $default  reduce using rule 288 (ocomma)


state 436

  134 pexpr_no_paren: convtype '(' expr ocomma . ')'

    ')'  shift, and go to state 535


state 437

  135 pexpr_no_paren: comptype lbrace start_complit braced_keyval_list . '}'

    '}'  shift, and go to state 536


state 438

   28 common_dcl: . LVAR vardcl
   29           | . LVAR '(' vardcl_list osemi ')'
   30           | . LVAR '(' ')'
   31           | . lconst constdcl
   32           | . lconst '(' constdcl osemi ')'
   33           | . lconst '(' constdcl ';' constdcl_list osemi ')'
   34           | . lconst '(' ')'
   35           | . LTYPE typedcl
   36           | . LTYPE '(' typedcl_list osemi ')'
   37           | . LTYPE '(' ')'
   38 lconst: . LCONST
   49 simple_stmt: . expr
   50            | . expr LASOP expr
   51            | . expr_list '=' expr_list
   52            | . expr_list LCOLAS expr_list
   53            | . expr LINC
   54            | . expr LDEC
   60 compound_stmt: . '{' $@3 stmt_list '}'
   60              | '{' $@3 . stmt_list '}'
   74 for_stmt: . LFOR $@6 for_body
   80 if_stmt: . LIF $@7 if_header $@8 loop_body $@9 elseif_list else
   89 switch_stmt: . LSWITCH $@11 if_header $@12 LBODY caseblock_list '}'
   91 select_stmt: . LSELECT $@13 LBODY caseblock_list '}'
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  152 new_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  162 labelname: . new_name
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  250 stmt: .  [';', '}']
  251     | . compound_stmt
  252     | . common_dcl
  253     | . non_dcl_stmt
  254     | . error
  255 non_dcl_stmt: . simple_stmt
  256             | . for_stmt
  257             | . switch_stmt
  258             | . select_stmt
  259             | . if_stmt
  261             | . labelname ':' $@14 stmt
  262             | . LFALL
  263             | . LBREAK onew_name
  264             | . LCONTINUE onew_name
  265             | . LGO pseudocall
  266             | . LDEFER pseudocall
  267             | . LGOTO new_name
  268             | . LRETURN oexpr_list
  269 stmt_list: . stmt
  270          | . stmt_list ';' stmt
  275 expr_list: . expr
  276          | . expr_list ',' expr

    error       shift, and go to state 325
    LLITERAL    shift, and go to state 35
    LBREAK      shift, and go to state 36
    LCHAN       shift, and go to state 37
    LCONST      shift, and go to state 38
    LCONTINUE   shift, and go to state 39
    LDEFER      shift, and go to state 40
    LFALL       shift, and go to state 41
    LFOR        shift, and go to state 42
    LFUNC       shift, and go to state 113
    LGO         shift, and go to state 44
    LGOTO       shift, and go to state 45
    LIF         shift, and go to state 46
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LRETURN     shift, and go to state 49
    LSELECT     shift, and go to state 50
    LSTRUCT     shift, and go to state 51
    LSWITCH     shift, and go to state 52
    LTYPE       shift, and go to state 53
    LVAR        shift, and go to state 54
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '{'         shift, and go to state 326
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    ';'  reduce using rule 250 (stmt)
    '}'  reduce using rule 250 (stmt)

    common_dcl        go to state 327
    lconst            go to state 67
    simple_stmt       go to state 68
    compound_stmt     go to state 328
    for_stmt          go to state 69
    if_stmt           go to state 70
    switch_stmt       go to state 71
    select_stmt       go to state 72
    expr              go to state 73
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    new_name          go to state 78
    sym               go to state 79
    hidden_importsym  go to state 13
    name              go to state 80
    labelname         go to state 81
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    stmt              go to state 329
    non_dcl_stmt      go to state 330
    stmt_list         go to state 537
    expr_list         go to state 92


state 439

   28 common_dcl: . LVAR vardcl
   29           | . LVAR '(' vardcl_list osemi ')'
   30           | . LVAR '(' ')'
   31           | . lconst constdcl
   32           | . lconst '(' constdcl osemi ')'
   33           | . lconst '(' constdcl ';' constdcl_list osemi ')'
   34           | . lconst '(' ')'
   35           | . LTYPE typedcl
   36           | . LTYPE '(' typedcl_list osemi ')'
   37           | . LTYPE '(' ')'
   38 lconst: . LCONST
   49 simple_stmt: . expr
   50            | . expr LASOP expr
   51            | . expr_list '=' expr_list
   52            | . expr_list LCOLAS expr_list
   53            | . expr LINC
   54            | . expr LDEC
   60 compound_stmt: . '{' $@3 stmt_list '}'
   74 for_stmt: . LFOR $@6 for_body
   80 if_stmt: . LIF $@7 if_header $@8 loop_body $@9 elseif_list else
   89 switch_stmt: . LSWITCH $@11 if_header $@12 LBODY caseblock_list '}'
   91 select_stmt: . LSELECT $@13 LBODY caseblock_list '}'
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  152 new_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  162 labelname: . new_name
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  250 stmt: .  [LCASE, LDEFAULT, ';', '}']
  251     | . compound_stmt
  252     | . common_dcl
  253     | . non_dcl_stmt
  254     | . error
  255 non_dcl_stmt: . simple_stmt
  256             | . for_stmt
  257             | . switch_stmt
  258             | . select_stmt
  259             | . if_stmt
  261             | . labelname ':' $@14 stmt
  262             | . LFALL
  263             | . LBREAK onew_name
  264             | . LCONTINUE onew_name
  265             | . LGO pseudocall
  266             | . LDEFER pseudocall
  267             | . LGOTO new_name
  268             | . LRETURN oexpr_list
  270 stmt_list: stmt_list ';' . stmt
  275 expr_list: . expr
  276          | . expr_list ',' expr

    error       shift, and go to state 325
    LLITERAL    shift, and go to state 35
    LBREAK      shift, and go to state 36
    LCHAN       shift, and go to state 37
    LCONST      shift, and go to state 38
    LCONTINUE   shift, and go to state 39
    LDEFER      shift, and go to state 40
    LFALL       shift, and go to state 41
    LFOR        shift, and go to state 42
    LFUNC       shift, and go to state 113
    LGO         shift, and go to state 44
    LGOTO       shift, and go to state 45
    LIF         shift, and go to state 46
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LRETURN     shift, and go to state 49
    LSELECT     shift, and go to state 50
    LSTRUCT     shift, and go to state 51
    LSWITCH     shift, and go to state 52
    LTYPE       shift, and go to state 53
    LVAR        shift, and go to state 54
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '{'         shift, and go to state 326
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    LCASE     reduce using rule 250 (stmt)
    LDEFAULT  reduce using rule 250 (stmt)
    ';'       reduce using rule 250 (stmt)
    '}'       reduce using rule 250 (stmt)

    common_dcl        go to state 327
    lconst            go to state 67
    simple_stmt       go to state 68
    compound_stmt     go to state 328
    for_stmt          go to state 69
    if_stmt           go to state 70
    switch_stmt       go to state 71
    select_stmt       go to state 72
    expr              go to state 73
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    new_name          go to state 78
    sym               go to state 79
    hidden_importsym  go to state 13
    name              go to state 80
    labelname         go to state 81
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    stmt              go to state 538
    non_dcl_stmt      go to state 330
    expr_list         go to state 92


state 440

  215 fnliteral: fnlitdcl lbrace stmt_list '}' .

    $default  reduce using rule 215 (fnliteral)


state 441

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  326                 | LCHAN LCOMM . hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 339
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '['         shift, and go to state 344
    '@'         shift, and go to state 11

    hidden_importsym       go to state 345
    hidden_type            go to state 539
    hidden_type_misc       go to state 347
    hidden_type_recv_chan  go to state 348
    hidden_type_func       go to state 349


state 442

  325 hidden_type_misc: LCHAN '(' . hidden_type_recv_chan ')'
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type

    LCOMM  shift, and go to state 341

    hidden_type_recv_chan  go to state 540


state 443

  324 hidden_type_misc: LCHAN hidden_type_non_recv_chan .

    $default  reduce using rule 324 (hidden_type_misc)


state 444

  314 hidden_type_non_recv_chan: hidden_type_misc .

    $default  reduce using rule 314 (hidden_type_non_recv_chan)


state 445

  315 hidden_type_non_recv_chan: hidden_type_func .

    $default  reduce using rule 315 (hidden_type_non_recv_chan)


state 446

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  295 ohidden_funarg_list: .  [')']
  296                    | . hidden_funarg_list
  328 hidden_type_func: LFUNC '(' . ohidden_funarg_list ')' ohidden_funres
  329 hidden_funarg: . sym hidden_type oliteral
  330              | . sym LDDD hidden_type oliteral
  345 hidden_funarg_list: . hidden_funarg
  346                   | . hidden_funarg_list ',' hidden_funarg

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    $default  reduce using rule 295 (ohidden_funarg_list)

    sym                  go to state 350
    hidden_importsym     go to state 13
    ohidden_funarg_list  go to state 541
    hidden_funarg        go to state 351
    hidden_funarg_list   go to state 467


state 447

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  299 ohidden_interfacedcl_list: .  ['}']
  300                          | . hidden_interfacedcl_list
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  322                 | LINTERFACE '{' . ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres
  332 hidden_interfacedcl: . sym '(' ohidden_funarg_list ')' ohidden_funres
  333                    | . hidden_type
  349 hidden_interfacedcl_list: . hidden_interfacedcl
  350                         | . hidden_interfacedcl_list ';' hidden_interfacedcl

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 542
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '['         shift, and go to state 344
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 299 (ohidden_interfacedcl_list)

    sym                        go to state 543
    hidden_importsym           go to state 544
    ohidden_interfacedcl_list  go to state 545
    hidden_type                go to state 546
    hidden_type_misc           go to state 347
    hidden_type_recv_chan      go to state 348
    hidden_type_func           go to state 349
    hidden_interfacedcl        go to state 547
    hidden_interfacedcl_list   go to state 548


state 448

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  320                 | LMAP '[' . hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 339
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '['         shift, and go to state 344
    '@'         shift, and go to state 11

    hidden_importsym       go to state 345
    hidden_type            go to state 549
    hidden_type_misc       go to state 347
    hidden_type_recv_chan  go to state 348
    hidden_type_func       go to state 349


state 449

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  297 ohidden_structdcl_list: .  ['}']
  298                       | . hidden_structdcl_list
  321 hidden_type_misc: LSTRUCT '{' . ohidden_structdcl_list '}'
  331 hidden_structdcl: . sym hidden_type oliteral
  347 hidden_structdcl_list: . hidden_structdcl
  348                      | . hidden_structdcl_list ';' hidden_structdcl

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    $default  reduce using rule 297 (ohidden_structdcl_list)

    sym                     go to state 550
    hidden_importsym        go to state 13
    ohidden_structdcl_list  go to state 551
    hidden_structdcl        go to state 552
    hidden_structdcl_list   go to state 553


state 450

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  327                      | LCOMM LCHAN . hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 339
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '['         shift, and go to state 344
    '@'         shift, and go to state 11

    hidden_importsym       go to state 345
    hidden_type            go to state 554
    hidden_type_misc       go to state 347
    hidden_type_recv_chan  go to state 348
    hidden_type_func       go to state 349


state 451

  323 hidden_type_misc: '*' hidden_type .

    $default  reduce using rule 323 (hidden_type_misc)


state 452

  338 hidden_literal: LLITERAL .

    $default  reduce using rule 338 (hidden_literal)


state 453

  339 hidden_literal: '-' . LLITERAL

    LLITERAL  shift, and go to state 555


state 454

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  338 hidden_literal: . LLITERAL
  339               | . '-' LLITERAL
  340               | . sym
  342 hidden_constant: '(' . hidden_literal '+' hidden_literal ')'

    LLITERAL  shift, and go to state 452
    LNAME     shift, and go to state 9
    '-'       shift, and go to state 453
    '?'       shift, and go to state 10
    '@'       shift, and go to state 11

    sym               go to state 455
    hidden_importsym  go to state 13
    hidden_literal    go to state 556


state 455

  340 hidden_literal: sym .

    $default  reduce using rule 340 (hidden_literal)


state 456

  341 hidden_constant: hidden_literal .

    $default  reduce using rule 341 (hidden_constant)


state 457

  305 hidden_import: LCONST hidden_pkg_importsym '=' hidden_constant . ';'

    ';'  shift, and go to state 557


state 458

  319 hidden_type_misc: '[' LLITERAL . ']' hidden_type

    ']'  shift, and go to state 558


state 459

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  318                 | '[' ']' . hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 339
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '['         shift, and go to state 344
    '@'         shift, and go to state 11

    hidden_importsym       go to state 345
    hidden_type            go to state 559
    hidden_type_misc       go to state 347
    hidden_type_recv_chan  go to state 348
    hidden_type_func       go to state 349


state 460

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  306 hidden_import: LCONST hidden_pkg_importsym hidden_type '=' . hidden_constant ';'
  338 hidden_literal: . LLITERAL
  339               | . '-' LLITERAL
  340               | . sym
  341 hidden_constant: . hidden_literal
  342                | . '(' hidden_literal '+' hidden_literal ')'

    LLITERAL  shift, and go to state 452
    LNAME     shift, and go to state 9
    '-'       shift, and go to state 453
    '('       shift, and go to state 454
    '?'       shift, and go to state 10
    '@'       shift, and go to state 11

    sym               go to state 455
    hidden_importsym  go to state 13
    hidden_literal    go to state 456
    hidden_constant   go to state 560


state 461

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres
  330 hidden_funarg: sym LDDD . hidden_type oliteral

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 339
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '['         shift, and go to state 344
    '@'         shift, and go to state 11

    hidden_importsym       go to state 345
    hidden_type            go to state 561
    hidden_type_misc       go to state 347
    hidden_type_recv_chan  go to state 348
    hidden_type_func       go to state 349


state 462

  301 oliteral: .  [')', ',']
  302         | . LLITERAL
  329 hidden_funarg: sym hidden_type . oliteral

    LLITERAL  shift, and go to state 395

    $default  reduce using rule 301 (oliteral)

    oliteral  go to state 562


state 463

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  207 hidden_fndcl: '(' hidden_funarg_list ')' . sym '(' ohidden_funarg_list ')' ohidden_funres

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    sym               go to state 563
    hidden_importsym  go to state 13


state 464

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  329 hidden_funarg: . sym hidden_type oliteral
  330              | . sym LDDD hidden_type oliteral
  346 hidden_funarg_list: hidden_funarg_list ',' . hidden_funarg

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    sym               go to state 350
    hidden_importsym  go to state 13
    hidden_funarg     go to state 564


state 465

  308 hidden_import: LFUNC hidden_fndcl fnbody ';' .

    $default  reduce using rule 308 (hidden_import)


state 466

  206 hidden_fndcl: hidden_pkg_importsym '(' ohidden_funarg_list . ')' ohidden_funres

    ')'  shift, and go to state 565


state 467

  296 ohidden_funarg_list: hidden_funarg_list .  [')']
  346 hidden_funarg_list: hidden_funarg_list . ',' hidden_funarg

    ','  shift, and go to state 464

    $default  reduce using rule 296 (ohidden_funarg_list)


state 468

  303 hidden_import: LIMPORT LNAME LLITERAL ';' .

    $default  reduce using rule 303 (hidden_import)


state 469

  307 hidden_import: LTYPE hidden_pkgtype hidden_type ';' .

    $default  reduce using rule 307 (hidden_import)


state 470

  304 hidden_import: LVAR hidden_pkg_importsym hidden_type ';' .

    $default  reduce using rule 304 (hidden_import)


state 471

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  183 fnret_type: . recvchantype
  184           | . fntype
  185           | . othertype
  186           | . ptrtype
  187           | . dotname
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  208       | LFUNC '(' oarg_type_list_ocomma ')' . fnres
  211 fnres: .  [error, LLITERAL, LCOLAS, LCASE, LDDD, LDEFAULT, LBODY, ')', ';', '=', ':', '{', '}', ']', ',']
  212      | . fnret_type
  213      | . '(' oarg_type_list_ocomma ')'

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 478
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 211 (fnres)

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    fnret_type        go to state 480
    dotname           go to state 481
    othertype         go to state 482
    ptrtype           go to state 483
    recvchantype      go to state 484
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 485
    fnres             go to state 486

    Conflict between rule 211 and token '(' resolved as shift (NotParen < '(').


state 472

  170 ntype: '(' ntype ')' .

    $default  reduce using rule 170 (ntype)


state 473

   28 common_dcl: . LVAR vardcl
   29           | . LVAR '(' vardcl_list osemi ')'
   30           | . LVAR '(' ')'
   31           | . lconst constdcl
   32           | . lconst '(' constdcl osemi ')'
   33           | . lconst '(' constdcl ';' constdcl_list osemi ')'
   34           | . lconst '(' ')'
   35           | . LTYPE typedcl
   36           | . LTYPE '(' typedcl_list osemi ')'
   37           | . LTYPE '(' ')'
   38 lconst: . LCONST
   49 simple_stmt: . expr
   50            | . expr LASOP expr
   51            | . expr_list '=' expr_list
   52            | . expr_list LCOLAS expr_list
   53            | . expr LINC
   54            | . expr LDEC
   60 compound_stmt: . '{' $@3 stmt_list '}'
   66 loop_body: LBODY $@5 . stmt_list '}'
   74 for_stmt: . LFOR $@6 for_body
   80 if_stmt: . LIF $@7 if_header $@8 loop_body $@9 elseif_list else
   89 switch_stmt: . LSWITCH $@11 if_header $@12 LBODY caseblock_list '}'
   91 select_stmt: . LSELECT $@13 LBODY caseblock_list '}'
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  152 new_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  162 labelname: . new_name
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  250 stmt: .  [';', '}']
  251     | . compound_stmt
  252     | . common_dcl
  253     | . non_dcl_stmt
  254     | . error
  255 non_dcl_stmt: . simple_stmt
  256             | . for_stmt
  257             | . switch_stmt
  258             | . select_stmt
  259             | . if_stmt
  261             | . labelname ':' $@14 stmt
  262             | . LFALL
  263             | . LBREAK onew_name
  264             | . LCONTINUE onew_name
  265             | . LGO pseudocall
  266             | . LDEFER pseudocall
  267             | . LGOTO new_name
  268             | . LRETURN oexpr_list
  269 stmt_list: . stmt
  270          | . stmt_list ';' stmt
  275 expr_list: . expr
  276          | . expr_list ',' expr

    error       shift, and go to state 325
    LLITERAL    shift, and go to state 35
    LBREAK      shift, and go to state 36
    LCHAN       shift, and go to state 37
    LCONST      shift, and go to state 38
    LCONTINUE   shift, and go to state 39
    LDEFER      shift, and go to state 40
    LFALL       shift, and go to state 41
    LFOR        shift, and go to state 42
    LFUNC       shift, and go to state 113
    LGO         shift, and go to state 44
    LGOTO       shift, and go to state 45
    LIF         shift, and go to state 46
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LRETURN     shift, and go to state 49
    LSELECT     shift, and go to state 50
    LSTRUCT     shift, and go to state 51
    LSWITCH     shift, and go to state 52
    LTYPE       shift, and go to state 53
    LVAR        shift, and go to state 54
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '{'         shift, and go to state 326
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    ';'  reduce using rule 250 (stmt)
    '}'  reduce using rule 250 (stmt)

    common_dcl        go to state 327
    lconst            go to state 67
    simple_stmt       go to state 68
    compound_stmt     go to state 328
    for_stmt          go to state 69
    if_stmt           go to state 70
    switch_stmt       go to state 71
    select_stmt       go to state 72
    expr              go to state 73
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    new_name          go to state 78
    sym               go to state 79
    hidden_importsym  go to state 13
    name              go to state 80
    labelname         go to state 81
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    stmt              go to state 329
    non_dcl_stmt      go to state 330
    stmt_list         go to state 566
    expr_list         go to state 92


state 474

   68 range_stmt: expr_list LCOLAS LRANGE . expr
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 567
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 475

   67 range_stmt: expr_list '=' LRANGE . expr
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 568
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 476

   69 for_header: osimple_stmt ';' osimple_stmt . ';' osimple_stmt

    ';'  shift, and go to state 569


state 477

  247 arg_type_list: arg_type_list ',' arg_type .

    $default  reduce using rule 247 (arg_type_list)


state 478

  149 name_or_type: . ntype
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  163 dotdotdot: . LDDD
  164          | . LDDD ntype
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  213 fnres: '(' . oarg_type_list_ocomma ')'
  242 arg_type: . name_or_type
  243         | . sym name_or_type
  244         | . sym dotdotdot
  245         | . dotdotdot
  246 arg_type_list: . arg_type
  247              | . arg_type_list ',' arg_type
  248 oarg_type_list_ocomma: .  [')']
  249                      | . arg_type_list ocomma

    LCHAN       shift, and go to state 37
    LDDD        shift, and go to state 242
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 248 (oarg_type_list_ocomma)

    name_or_type           go to state 243
    sym                    go to state 244
    hidden_importsym       go to state 13
    name                   go to state 118
    dotdotdot              go to state 245
    ntype                  go to state 246
    dotname                go to state 228
    othertype              go to state 229
    ptrtype                go to state 230
    recvchantype           go to state 231
    structtype             go to state 85
    interfacetype          go to state 86
    fntype                 go to state 232
    arg_type               go to state 247
    arg_type_list          go to state 248
    oarg_type_list_ocomma  go to state 570


state 479

  161 name: sym .  [error, LBODY, '.', '{']
  205 fndcl: '(' oarg_type_list_ocomma ')' sym . '(' oarg_type_list_ocomma ')' fnres

    '('  shift, and go to state 571

    $default  reduce using rule 161 (name)

    Conflict between rule 161 and token '(' resolved as shift (NotParen < '(').


state 480

  212 fnres: fnret_type .

    $default  reduce using rule 212 (fnres)


state 481

  187 fnret_type: dotname .

    $default  reduce using rule 187 (fnret_type)


state 482

  185 fnret_type: othertype .

    $default  reduce using rule 185 (fnret_type)


state 483

  186 fnret_type: ptrtype .

    $default  reduce using rule 186 (fnret_type)


state 484

  183 fnret_type: recvchantype .

    $default  reduce using rule 183 (fnret_type)


state 485

  184 fnret_type: fntype .

    $default  reduce using rule 184 (fnret_type)


state 486

  208 fntype: LFUNC '(' oarg_type_list_ocomma ')' fnres .

    $default  reduce using rule 208 (fntype)


state 487

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  183 fnret_type: . recvchantype
  184           | . fntype
  185           | . othertype
  186           | . ptrtype
  187           | . dotname
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  204 fndcl: sym '(' oarg_type_list_ocomma ')' . fnres
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  211 fnres: .  [';', '{']
  212      | . fnret_type
  213      | . '(' oarg_type_list_ocomma ')'

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 478
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 211 (fnres)

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    fnret_type        go to state 480
    dotname           go to state 481
    othertype         go to state 482
    ptrtype           go to state 483
    recvchantype      go to state 484
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 485
    fnres             go to state 572


state 488

  210 fnbody: '{' stmt_list '}' .

    $default  reduce using rule 210 (fnbody)


state 489

   79 $@9: .
   80 if_stmt: LIF $@7 if_header $@8 loop_body . $@9 elseif_list else

    $default  reduce using rule 79 ($@9)

    $@9  go to state 573


state 490

   76 if_header: osimple_stmt ';' osimple_stmt .

    $default  reduce using rule 76 (if_header)


state 491

  236 packname: LNAME '.' sym .

    $default  reduce using rule 236 (packname)


state 492

  240 interfacedcl: '(' packname ')' .

    $default  reduce using rule 240 (interfacedcl)


state 493

  241 indcl: '(' oarg_type_list_ocomma . ')' fnres

    ')'  shift, and go to state 574


state 494

  228 interfacedcl_list: interfacedcl_list ';' interfacedcl .

    $default  reduce using rule 228 (interfacedcl_list)


state 495

  201 interfacetype: LINTERFACE lbrace interfacedcl_list osemi '}' .

    $default  reduce using rule 201 (interfacetype)


state 496

  194 othertype: LMAP '[' ntype ']' ntype .

    $default  reduce using rule 194 (othertype)


state 497

   55 case: LCASE . expr_or_type_list ':'
   56     | LCASE . expr_or_type_list '=' expr ':'
   57     | LCASE . expr_or_type_list LCOLAS expr ':'
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  147 expr_or_type: . expr
  148             | . non_expr_type
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  171 non_expr_type: . recvchantype
  172              | . fntype
  173              | . othertype
  174              | . '*' non_expr_type
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  277 expr_or_type_list: . expr_or_type
  278                  | . expr_or_type_list ',' expr_or_type

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 159
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 160
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr               go to state 161
    uexpr              go to state 74
    pseudocall         go to state 75
    pexpr_no_paren     go to state 76
    pexpr              go to state 77
    expr_or_type       go to state 316
    sym                go to state 117
    hidden_importsym   go to state 13
    name               go to state 80
    non_expr_type      go to state 163
    convtype           go to state 82
    comptype           go to state 83
    othertype          go to state 164
    recvchantype       go to state 165
    structtype         go to state 85
    interfacetype      go to state 86
    fntype             go to state 166
    fnlitdcl           go to state 89
    fnliteral          go to state 90
    expr_or_type_list  go to state 575


state 498

   58 case: LDEFAULT . ':'

    ':'  shift, and go to state 576


state 499

   91 select_stmt: LSELECT $@13 LBODY caseblock_list '}' .

    $default  reduce using rule 91 (select_stmt)


state 500

   61 $@4: .
   62 caseblock: case . $@4 stmt_list

    $default  reduce using rule 61 ($@4)

    $@4  go to state 577


state 501

   64 caseblock_list: caseblock_list caseblock .

    $default  reduce using rule 64 (caseblock_list)


state 502

  234 structdcl: '*' '(' embed . ')' oliteral

    ')'  shift, and go to state 578


state 503

  232 structdcl: '*' embed oliteral .

    $default  reduce using rule 232 (structdcl)


state 504

  233 structdcl: '(' '*' embed . ')' oliteral

    ')'  shift, and go to state 579


state 505

  231 structdcl: '(' embed ')' . oliteral
  301 oliteral: .  [';', '}']
  302         | . LLITERAL

    LLITERAL  shift, and go to state 395

    $default  reduce using rule 301 (oliteral)

    oliteral  go to state 580


state 506

  226 structdcl_list: structdcl_list ';' structdcl .

    $default  reduce using rule 226 (structdcl_list)


state 507

  199 structtype: LSTRUCT lbrace structdcl_list osemi '}' .

    $default  reduce using rule 199 (structtype)


state 508

  272 new_name_list: new_name_list ',' new_name .

    $default  reduce using rule 272 (new_name_list)


state 509

  229 structdcl: new_name_list ntype oliteral .

    $default  reduce using rule 229 (structdcl)


state 510

   63 caseblock_list: .
   64               | . caseblock_list caseblock
   89 switch_stmt: LSWITCH $@11 if_header $@12 LBODY . caseblock_list '}'

    $default  reduce using rule 63 (caseblock_list)

    caseblock_list  go to state 581


state 511

  224 typedcl_list: typedcl_list ';' typedcl .

    $default  reduce using rule 224 (typedcl_list)


state 512

   36 common_dcl: LTYPE '(' typedcl_list osemi ')' .

    $default  reduce using rule 36 (common_dcl)


state 513

  220 vardcl_list: vardcl_list ';' vardcl .

    $default  reduce using rule 220 (vardcl_list)


state 514

   29 common_dcl: LVAR '(' vardcl_list osemi ')' .

    $default  reduce using rule 29 (common_dcl)


state 515

   40 vardcl: dcl_name_list ntype '=' expr_list .  [LCASE, LDEFAULT, ')', ';', '}']
  276 expr_list: expr_list . ',' expr

    ','  shift, and go to state 210

    $default  reduce using rule 40 (vardcl)


state 516

  170 ntype: '(' ntype . ')'
  179 non_recvchantype: '(' ntype . ')'

    ')'  shift, and go to state 582


state 517

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  137               | '(' expr_or_type ')' '{' start_complit . braced_keyval_list '}'
  138               | . fnliteral
  140 keyval: . expr ':' complitexpr
  141 bare_complitexpr: . expr
  142                 | . '{' start_complit braced_keyval_list '}'
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  279 keyval_list: . keyval
  280            | . bare_complitexpr
  281            | . keyval_list ',' keyval
  282            | . keyval_list ',' bare_complitexpr
  283 braced_keyval_list: .  ['}']
  284                   | . keyval_list ocomma

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '{'         shift, and go to state 421
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 283 (braced_keyval_list)

    expr                go to state 422
    uexpr               go to state 74
    pseudocall          go to state 75
    pexpr_no_paren      go to state 76
    keyval              go to state 423
    bare_complitexpr    go to state 424
    pexpr               go to state 77
    sym                 go to state 117
    hidden_importsym    go to state 13
    name                go to state 80
    convtype            go to state 82
    comptype            go to state 83
    othertype           go to state 84
    structtype          go to state 85
    interfacetype       go to state 86
    fntype              go to state 88
    fnlitdcl            go to state 89
    fnliteral           go to state 90
    keyval_list         go to state 425
    braced_keyval_list  go to state 583


state 518

   44 constdcl1: constdcl .

    $default  reduce using rule 44 (constdcl1)


state 519

  221 constdcl_list: constdcl1 .

    $default  reduce using rule 221 (constdcl_list)


state 520

   33 common_dcl: lconst '(' constdcl ';' constdcl_list . osemi ')'
  222 constdcl_list: constdcl_list . ';' constdcl1
  285 osemi: .  [')']
  286      | . ';'

    ';'  shift, and go to state 584

    $default  reduce using rule 285 (osemi)

    osemi  go to state 585


state 521

   42 constdcl: dcl_name_list . ntype '=' expr_list
   43         | dcl_name_list . '=' expr_list
   45 constdcl1: dcl_name_list . ntype
   46          | dcl_name_list .  [')', ';']
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  274 dcl_name_list: dcl_name_list . ',' dcl_name

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '='         shift, and go to state 291
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11
    ','         shift, and go to state 282

    $default  reduce using rule 46 (constdcl1)

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    ntype             go to state 586
    dotname           go to state 228
    othertype         go to state 229
    ptrtype           go to state 230
    recvchantype      go to state 231
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 232


state 522

   32 common_dcl: lconst '(' constdcl osemi ')' .

    $default  reduce using rule 32 (common_dcl)


state 523

   42 constdcl: dcl_name_list ntype '=' expr_list .  [LCASE, LDEFAULT, ')', ';', '}']
  276 expr_list: expr_list . ',' expr

    ','  shift, and go to state 210

    $default  reduce using rule 42 (constdcl)


state 524

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  140 keyval: . expr ':' complitexpr
  141 bare_complitexpr: . expr
  142                 | . '{' start_complit braced_keyval_list '}'
  142                 | '{' start_complit . braced_keyval_list '}'
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  279 keyval_list: . keyval
  280            | . bare_complitexpr
  281            | . keyval_list ',' keyval
  282            | . keyval_list ',' bare_complitexpr
  283 braced_keyval_list: .  ['}']
  284                   | . keyval_list ocomma

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '{'         shift, and go to state 421
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 283 (braced_keyval_list)

    expr                go to state 422
    uexpr               go to state 74
    pseudocall          go to state 75
    pexpr_no_paren      go to state 76
    keyval              go to state 423
    bare_complitexpr    go to state 424
    pexpr               go to state 77
    sym                 go to state 117
    hidden_importsym    go to state 13
    name                go to state 80
    convtype            go to state 82
    comptype            go to state 83
    othertype           go to state 84
    structtype          go to state 85
    interfacetype       go to state 86
    fntype              go to state 88
    fnlitdcl            go to state 89
    fnliteral           go to state 90
    keyval_list         go to state 425
    braced_keyval_list  go to state 587


state 525

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  140 keyval: expr ':' . complitexpr
  143 complitexpr: . expr
  144            | . '{' start_complit braced_keyval_list '}'
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '{'         shift, and go to state 588
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 589
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    complitexpr       go to state 590
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 526

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  140 keyval: . expr ':' complitexpr
  141 bare_complitexpr: . expr
  142                 | . '{' start_complit braced_keyval_list '}'
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  281 keyval_list: keyval_list ',' . keyval
  282            | keyval_list ',' . bare_complitexpr
  288 ocomma: ',' .  ['}']

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '{'         shift, and go to state 421
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 288 (ocomma)

    expr              go to state 422
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    keyval            go to state 591
    bare_complitexpr  go to state 592
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 527

  284 braced_keyval_list: keyval_list ocomma .

    $default  reduce using rule 284 (braced_keyval_list)


state 528

  136 pexpr_no_paren: pexpr_no_paren '{' start_complit braced_keyval_list '}' .

    $default  reduce using rule 136 (pexpr_no_paren)


state 529

  124 pseudocall: pexpr '(' expr_or_type_list LDDD ocomma . ')'

    ')'  shift, and go to state 593


state 530

  278 expr_or_type_list: expr_or_type_list ',' expr_or_type .

    $default  reduce using rule 278 (expr_or_type_list)


state 531

  123 pseudocall: pexpr '(' expr_or_type_list ocomma ')' .

    $default  reduce using rule 123 (pseudocall)


state 532

  129 pexpr_no_paren: pexpr '.' '(' LTYPE ')' .

    $default  reduce using rule 129 (pexpr_no_paren)


state 533

  128 pexpr_no_paren: pexpr '.' '(' expr_or_type ')' .

    $default  reduce using rule 128 (pexpr_no_paren)


state 534

  131 pexpr_no_paren: pexpr '[' oexpr ':' oexpr . ']'
  132               | pexpr '[' oexpr ':' oexpr . ':' oexpr ']'

    ':'  shift, and go to state 594
    ']'  shift, and go to state 595


state 535

  134 pexpr_no_paren: convtype '(' expr ocomma ')' .

    $default  reduce using rule 134 (pexpr_no_paren)


state 536

  135 pexpr_no_paren: comptype lbrace start_complit braced_keyval_list '}' .

    $default  reduce using rule 135 (pexpr_no_paren)


state 537

   60 compound_stmt: '{' $@3 stmt_list . '}'
  270 stmt_list: stmt_list . ';' stmt

    ';'  shift, and go to state 439
    '}'  shift, and go to state 596


state 538

  270 stmt_list: stmt_list ';' stmt .

    $default  reduce using rule 270 (stmt_list)


state 539

  326 hidden_type_misc: LCHAN LCOMM hidden_type .

    $default  reduce using rule 326 (hidden_type_misc)


state 540

  325 hidden_type_misc: LCHAN '(' hidden_type_recv_chan . ')'

    ')'  shift, and go to state 597


state 541

  328 hidden_type_func: LFUNC '(' ohidden_funarg_list . ')' ohidden_funres

    ')'  shift, and go to state 598


state 542

  156 sym: LNAME .  ['(']
  317 hidden_type_misc: LNAME .  [';', '}']

    '('       reduce using rule 156 (sym)
    $default  reduce using rule 317 (hidden_type_misc)


state 543

  332 hidden_interfacedcl: sym . '(' ohidden_funarg_list ')' ohidden_funres

    '('  shift, and go to state 599


state 544

  157 sym: hidden_importsym .  ['(']
  316 hidden_type_misc: hidden_importsym .  [';', '}']

    '('       reduce using rule 157 (sym)
    $default  reduce using rule 316 (hidden_type_misc)


state 545

  322 hidden_type_misc: LINTERFACE '{' ohidden_interfacedcl_list . '}'

    '}'  shift, and go to state 600


state 546

  333 hidden_interfacedcl: hidden_type .

    $default  reduce using rule 333 (hidden_interfacedcl)


state 547

  349 hidden_interfacedcl_list: hidden_interfacedcl .

    $default  reduce using rule 349 (hidden_interfacedcl_list)


state 548

  300 ohidden_interfacedcl_list: hidden_interfacedcl_list .  ['}']
  350 hidden_interfacedcl_list: hidden_interfacedcl_list . ';' hidden_interfacedcl

    ';'  shift, and go to state 601

    $default  reduce using rule 300 (ohidden_interfacedcl_list)


state 549

  320 hidden_type_misc: LMAP '[' hidden_type . ']' hidden_type

    ']'  shift, and go to state 602


state 550

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres
  331 hidden_structdcl: sym . hidden_type oliteral

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 339
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '['         shift, and go to state 344
    '@'         shift, and go to state 11

    hidden_importsym       go to state 345
    hidden_type            go to state 603
    hidden_type_misc       go to state 347
    hidden_type_recv_chan  go to state 348
    hidden_type_func       go to state 349


state 551

  321 hidden_type_misc: LSTRUCT '{' ohidden_structdcl_list . '}'

    '}'  shift, and go to state 604


state 552

  347 hidden_structdcl_list: hidden_structdcl .

    $default  reduce using rule 347 (hidden_structdcl_list)


state 553

  298 ohidden_structdcl_list: hidden_structdcl_list .  ['}']
  348 hidden_structdcl_list: hidden_structdcl_list . ';' hidden_structdcl

    ';'  shift, and go to state 605

    $default  reduce using rule 298 (ohidden_structdcl_list)


state 554

  327 hidden_type_recv_chan: LCOMM LCHAN hidden_type .

    $default  reduce using rule 327 (hidden_type_recv_chan)


state 555

  339 hidden_literal: '-' LLITERAL .

    $default  reduce using rule 339 (hidden_literal)


state 556

  342 hidden_constant: '(' hidden_literal . '+' hidden_literal ')'

    '+'  shift, and go to state 606


state 557

  305 hidden_import: LCONST hidden_pkg_importsym '=' hidden_constant ';' .

    $default  reduce using rule 305 (hidden_import)


state 558

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  319                 | '[' LLITERAL ']' . hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 339
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '['         shift, and go to state 344
    '@'         shift, and go to state 11

    hidden_importsym       go to state 345
    hidden_type            go to state 607
    hidden_type_misc       go to state 347
    hidden_type_recv_chan  go to state 348
    hidden_type_func       go to state 349


state 559

  318 hidden_type_misc: '[' ']' hidden_type .

    $default  reduce using rule 318 (hidden_type_misc)


state 560

  306 hidden_import: LCONST hidden_pkg_importsym hidden_type '=' hidden_constant . ';'

    ';'  shift, and go to state 608


state 561

  301 oliteral: .  [')', ',']
  302         | . LLITERAL
  330 hidden_funarg: sym LDDD hidden_type . oliteral

    LLITERAL  shift, and go to state 395

    $default  reduce using rule 301 (oliteral)

    oliteral  go to state 609


state 562

  329 hidden_funarg: sym hidden_type oliteral .

    $default  reduce using rule 329 (hidden_funarg)


state 563

  207 hidden_fndcl: '(' hidden_funarg_list ')' sym . '(' ohidden_funarg_list ')' ohidden_funres

    '('  shift, and go to state 610


state 564

  346 hidden_funarg_list: hidden_funarg_list ',' hidden_funarg .

    $default  reduce using rule 346 (hidden_funarg_list)


state 565

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  206 hidden_fndcl: hidden_pkg_importsym '(' ohidden_funarg_list ')' . ohidden_funres
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres
  334 ohidden_funres: .  [';', '{']
  335               | . hidden_funres
  336 hidden_funres: . '(' ohidden_funarg_list ')'
  337              | . hidden_type

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 339
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '('         shift, and go to state 611
    '['         shift, and go to state 344
    '@'         shift, and go to state 11

    $default  reduce using rule 334 (ohidden_funres)

    hidden_importsym       go to state 345
    hidden_type            go to state 612
    hidden_type_misc       go to state 347
    hidden_type_recv_chan  go to state 348
    hidden_type_func       go to state 349
    ohidden_funres         go to state 613
    hidden_funres          go to state 614


state 566

   66 loop_body: LBODY $@5 stmt_list . '}'
  270 stmt_list: stmt_list . ';' stmt

    ';'  shift, and go to state 439
    '}'  shift, and go to state 615


state 567

   68 range_stmt: expr_list LCOLAS LRANGE expr .  [LBODY]
   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    LANDAND  shift, and go to state 177
    LANDNOT  shift, and go to state 178
    LCOMM    shift, and go to state 179
    LEQ      shift, and go to state 181
    LGE      shift, and go to state 182
    LGT      shift, and go to state 183
    LLE      shift, and go to state 185
    LLSH     shift, and go to state 186
    LLT      shift, and go to state 187
    LNE      shift, and go to state 188
    LOROR    shift, and go to state 189
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 68 (range_stmt)


state 568

   67 range_stmt: expr_list '=' LRANGE expr .  [LBODY]
   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    LANDAND  shift, and go to state 177
    LANDNOT  shift, and go to state 178
    LCOMM    shift, and go to state 179
    LEQ      shift, and go to state 181
    LGE      shift, and go to state 182
    LGT      shift, and go to state 183
    LLE      shift, and go to state 185
    LLSH     shift, and go to state 186
    LLT      shift, and go to state 187
    LNE      shift, and go to state 188
    LOROR    shift, and go to state 189
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 67 (range_stmt)


state 569

   49 simple_stmt: . expr
   50            | . expr LASOP expr
   51            | . expr_list '=' expr_list
   52            | . expr_list LCOLAS expr_list
   53            | . expr LINC
   54            | . expr LDEC
   69 for_header: osimple_stmt ';' osimple_stmt ';' . osimple_stmt
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  275 expr_list: . expr
  276          | . expr_list ',' expr
  293 osimple_stmt: .  [LBODY]
  294             | . simple_stmt

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 293 (osimple_stmt)

    simple_stmt       go to state 236
    expr              go to state 73
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    expr_list         go to state 92
    osimple_stmt      go to state 616


state 570

  213 fnres: '(' oarg_type_list_ocomma . ')'

    ')'  shift, and go to state 617


state 571

  149 name_or_type: . ntype
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  163 dotdotdot: . LDDD
  164          | . LDDD ntype
  165 ntype: . recvchantype
  166      | . fntype
  167      | . othertype
  168      | . ptrtype
  169      | . dotname
  170      | . '(' ntype ')'
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  205 fndcl: '(' oarg_type_list_ocomma ')' sym '(' . oarg_type_list_ocomma ')' fnres
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  242 arg_type: . name_or_type
  243         | . sym name_or_type
  244         | . sym dotdotdot
  245         | . dotdotdot
  246 arg_type_list: . arg_type
  247              | . arg_type_list ',' arg_type
  248 oarg_type_list_ocomma: .  [')']
  249                      | . arg_type_list ocomma

    LCHAN       shift, and go to state 37
    LDDD        shift, and go to state 242
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 226
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 248 (oarg_type_list_ocomma)

    name_or_type           go to state 243
    sym                    go to state 244
    hidden_importsym       go to state 13
    name                   go to state 118
    dotdotdot              go to state 245
    ntype                  go to state 246
    dotname                go to state 228
    othertype              go to state 229
    ptrtype                go to state 230
    recvchantype           go to state 231
    structtype             go to state 85
    interfacetype          go to state 86
    fntype                 go to state 232
    arg_type               go to state 247
    arg_type_list          go to state 248
    oarg_type_list_ocomma  go to state 618


state 572

  204 fndcl: sym '(' oarg_type_list_ocomma ')' fnres .

    $default  reduce using rule 204 (fndcl)


state 573

   80 if_stmt: LIF $@7 if_header $@8 loop_body $@9 . elseif_list else
   83 elseif_list: .
   84            | . elseif_list elseif

    $default  reduce using rule 83 (elseif_list)

    elseif_list  go to state 619


state 574

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  183 fnret_type: . recvchantype
  184           | . fntype
  185           | . othertype
  186           | . ptrtype
  187           | . dotname
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  211 fnres: .  [';', '}']
  212      | . fnret_type
  213      | . '(' oarg_type_list_ocomma ')'
  241 indcl: '(' oarg_type_list_ocomma ')' . fnres

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 478
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 211 (fnres)

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    fnret_type        go to state 480
    dotname           go to state 481
    othertype         go to state 482
    ptrtype           go to state 483
    recvchantype      go to state 484
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 485
    fnres             go to state 620


state 575

   55 case: LCASE expr_or_type_list . ':'
   56     | LCASE expr_or_type_list . '=' expr ':'
   57     | LCASE expr_or_type_list . LCOLAS expr ':'
  278 expr_or_type_list: expr_or_type_list . ',' expr_or_type

    LCOLAS  shift, and go to state 621
    '='     shift, and go to state 622
    ':'     shift, and go to state 623
    ','     shift, and go to state 624


state 576

   58 case: LDEFAULT ':' .

    $default  reduce using rule 58 (case)


state 577

   28 common_dcl: . LVAR vardcl
   29           | . LVAR '(' vardcl_list osemi ')'
   30           | . LVAR '(' ')'
   31           | . lconst constdcl
   32           | . lconst '(' constdcl osemi ')'
   33           | . lconst '(' constdcl ';' constdcl_list osemi ')'
   34           | . lconst '(' ')'
   35           | . LTYPE typedcl
   36           | . LTYPE '(' typedcl_list osemi ')'
   37           | . LTYPE '(' ')'
   38 lconst: . LCONST
   49 simple_stmt: . expr
   50            | . expr LASOP expr
   51            | . expr_list '=' expr_list
   52            | . expr_list LCOLAS expr_list
   53            | . expr LINC
   54            | . expr LDEC
   60 compound_stmt: . '{' $@3 stmt_list '}'
   62 caseblock: case $@4 . stmt_list
   74 for_stmt: . LFOR $@6 for_body
   80 if_stmt: . LIF $@7 if_header $@8 loop_body $@9 elseif_list else
   89 switch_stmt: . LSWITCH $@11 if_header $@12 LBODY caseblock_list '}'
   91 select_stmt: . LSELECT $@13 LBODY caseblock_list '}'
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  152 new_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  162 labelname: . new_name
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  250 stmt: .  [LCASE, LDEFAULT, ';', '}']
  251     | . compound_stmt
  252     | . common_dcl
  253     | . non_dcl_stmt
  254     | . error
  255 non_dcl_stmt: . simple_stmt
  256             | . for_stmt
  257             | . switch_stmt
  258             | . select_stmt
  259             | . if_stmt
  261             | . labelname ':' $@14 stmt
  262             | . LFALL
  263             | . LBREAK onew_name
  264             | . LCONTINUE onew_name
  265             | . LGO pseudocall
  266             | . LDEFER pseudocall
  267             | . LGOTO new_name
  268             | . LRETURN oexpr_list
  269 stmt_list: . stmt
  270          | . stmt_list ';' stmt
  275 expr_list: . expr
  276          | . expr_list ',' expr

    error       shift, and go to state 325
    LLITERAL    shift, and go to state 35
    LBREAK      shift, and go to state 36
    LCHAN       shift, and go to state 37
    LCONST      shift, and go to state 38
    LCONTINUE   shift, and go to state 39
    LDEFER      shift, and go to state 40
    LFALL       shift, and go to state 41
    LFOR        shift, and go to state 42
    LFUNC       shift, and go to state 113
    LGO         shift, and go to state 44
    LGOTO       shift, and go to state 45
    LIF         shift, and go to state 46
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LRETURN     shift, and go to state 49
    LSELECT     shift, and go to state 50
    LSTRUCT     shift, and go to state 51
    LSWITCH     shift, and go to state 52
    LTYPE       shift, and go to state 53
    LVAR        shift, and go to state 54
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '{'         shift, and go to state 326
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    LCASE     reduce using rule 250 (stmt)
    LDEFAULT  reduce using rule 250 (stmt)
    ';'       reduce using rule 250 (stmt)
    '}'       reduce using rule 250 (stmt)

    common_dcl        go to state 327
    lconst            go to state 67
    simple_stmt       go to state 68
    compound_stmt     go to state 328
    for_stmt          go to state 69
    if_stmt           go to state 70
    switch_stmt       go to state 71
    select_stmt       go to state 72
    expr              go to state 73
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    new_name          go to state 78
    sym               go to state 79
    hidden_importsym  go to state 13
    name              go to state 80
    labelname         go to state 81
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    stmt              go to state 329
    non_dcl_stmt      go to state 330
    stmt_list         go to state 625
    expr_list         go to state 92


state 578

  234 structdcl: '*' '(' embed ')' . oliteral
  301 oliteral: .  [';', '}']
  302         | . LLITERAL

    LLITERAL  shift, and go to state 395

    $default  reduce using rule 301 (oliteral)

    oliteral  go to state 626


state 579

  233 structdcl: '(' '*' embed ')' . oliteral
  301 oliteral: .  [';', '}']
  302         | . LLITERAL

    LLITERAL  shift, and go to state 395

    $default  reduce using rule 301 (oliteral)

    oliteral  go to state 627


state 580

  231 structdcl: '(' embed ')' oliteral .

    $default  reduce using rule 231 (structdcl)


state 581

   55 case: . LCASE expr_or_type_list ':'
   56     | . LCASE expr_or_type_list '=' expr ':'
   57     | . LCASE expr_or_type_list LCOLAS expr ':'
   58     | . LDEFAULT ':'
   62 caseblock: . case $@4 stmt_list
   64 caseblock_list: caseblock_list . caseblock
   89 switch_stmt: LSWITCH $@11 if_header $@12 LBODY caseblock_list . '}'

    LCASE     shift, and go to state 497
    LDEFAULT  shift, and go to state 498
    '}'       shift, and go to state 628

    case       go to state 500
    caseblock  go to state 501


state 582

  170 ntype: '(' ntype ')' .  [LCOLAS, LDDD, ')', '=', ':', ',']
  179 non_recvchantype: '(' ntype ')' .  [LBODY, '(', '{']

    LBODY     reduce using rule 179 (non_recvchantype)
    '('       reduce using rule 179 (non_recvchantype)
    '{'       reduce using rule 179 (non_recvchantype)
    $default  reduce using rule 170 (ntype)


state 583

  137 pexpr_no_paren: '(' expr_or_type ')' '{' start_complit braced_keyval_list . '}'

    '}'  shift, and go to state 629


state 584

   42 constdcl: . dcl_name_list ntype '=' expr_list
   43         | . dcl_name_list '=' expr_list
   44 constdcl1: . constdcl
   45          | . dcl_name_list ntype
   46          | . dcl_name_list
  153 dcl_name: . sym
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  222 constdcl_list: constdcl_list ';' . constdcl1
  273 dcl_name_list: . dcl_name
  274              | . dcl_name_list ',' dcl_name
  286 osemi: ';' .  [')']

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    $default  reduce using rule 286 (osemi)

    constdcl          go to state 518
    constdcl1         go to state 630
    dcl_name          go to state 150
    sym               go to state 151
    hidden_importsym  go to state 13
    dcl_name_list     go to state 521


state 585

   33 common_dcl: lconst '(' constdcl ';' constdcl_list osemi . ')'

    ')'  shift, and go to state 631


state 586

   42 constdcl: dcl_name_list ntype . '=' expr_list
   45 constdcl1: dcl_name_list ntype .  [')', ';']

    '='  shift, and go to state 420

    $default  reduce using rule 45 (constdcl1)


state 587

  142 bare_complitexpr: '{' start_complit braced_keyval_list . '}'

    '}'  shift, and go to state 632


state 588

  139 start_complit: .
  144 complitexpr: '{' . start_complit braced_keyval_list '}'

    $default  reduce using rule 139 (start_complit)

    start_complit  go to state 633


state 589

   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr
  143 complitexpr: expr .  ['}', ',']

    LANDAND  shift, and go to state 177
    LANDNOT  shift, and go to state 178
    LCOMM    shift, and go to state 179
    LEQ      shift, and go to state 181
    LGE      shift, and go to state 182
    LGT      shift, and go to state 183
    LLE      shift, and go to state 185
    LLSH     shift, and go to state 186
    LLT      shift, and go to state 187
    LNE      shift, and go to state 188
    LOROR    shift, and go to state 189
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198

    $default  reduce using rule 143 (complitexpr)


state 590

  140 keyval: expr ':' complitexpr .

    $default  reduce using rule 140 (keyval)


state 591

  281 keyval_list: keyval_list ',' keyval .

    $default  reduce using rule 281 (keyval_list)


state 592

  282 keyval_list: keyval_list ',' bare_complitexpr .

    $default  reduce using rule 282 (keyval_list)


state 593

  124 pseudocall: pexpr '(' expr_or_type_list LDDD ocomma ')' .

    $default  reduce using rule 124 (pseudocall)


state 594

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  132               | pexpr '[' oexpr ':' oexpr ':' . oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  289 oexpr: .  [']']
  290      | . expr

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 289 (oexpr)

    expr              go to state 170
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    oexpr             go to state 634


state 595

  131 pexpr_no_paren: pexpr '[' oexpr ':' oexpr ']' .

    $default  reduce using rule 131 (pexpr_no_paren)


state 596

   60 compound_stmt: '{' $@3 stmt_list '}' .

    $default  reduce using rule 60 (compound_stmt)


state 597

  325 hidden_type_misc: LCHAN '(' hidden_type_recv_chan ')' .

    $default  reduce using rule 325 (hidden_type_misc)


state 598

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres
  328                 | LFUNC '(' ohidden_funarg_list ')' . ohidden_funres
  334 ohidden_funres: .  [LLITERAL, ')', ';', '=', '{', '}', ']', ',']
  335               | . hidden_funres
  336 hidden_funres: . '(' ohidden_funarg_list ')'
  337              | . hidden_type

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 339
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '('         shift, and go to state 611
    '['         shift, and go to state 344
    '@'         shift, and go to state 11

    $default  reduce using rule 334 (ohidden_funres)

    hidden_importsym       go to state 345
    hidden_type            go to state 612
    hidden_type_misc       go to state 347
    hidden_type_recv_chan  go to state 348
    hidden_type_func       go to state 349
    ohidden_funres         go to state 635
    hidden_funres          go to state 614


state 599

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  295 ohidden_funarg_list: .  [')']
  296                    | . hidden_funarg_list
  329 hidden_funarg: . sym hidden_type oliteral
  330              | . sym LDDD hidden_type oliteral
  332 hidden_interfacedcl: sym '(' . ohidden_funarg_list ')' ohidden_funres
  345 hidden_funarg_list: . hidden_funarg
  346                   | . hidden_funarg_list ',' hidden_funarg

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    $default  reduce using rule 295 (ohidden_funarg_list)

    sym                  go to state 350
    hidden_importsym     go to state 13
    ohidden_funarg_list  go to state 636
    hidden_funarg        go to state 351
    hidden_funarg_list   go to state 467


state 600

  322 hidden_type_misc: LINTERFACE '{' ohidden_interfacedcl_list '}' .

    $default  reduce using rule 322 (hidden_type_misc)


state 601

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres
  332 hidden_interfacedcl: . sym '(' ohidden_funarg_list ')' ohidden_funres
  333                    | . hidden_type
  350 hidden_interfacedcl_list: hidden_interfacedcl_list ';' . hidden_interfacedcl

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 542
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '['         shift, and go to state 344
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    sym                    go to state 543
    hidden_importsym       go to state 544
    hidden_type            go to state 546
    hidden_type_misc       go to state 347
    hidden_type_recv_chan  go to state 348
    hidden_type_func       go to state 349
    hidden_interfacedcl    go to state 637


state 602

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  320                 | LMAP '[' hidden_type ']' . hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 339
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '['         shift, and go to state 344
    '@'         shift, and go to state 11

    hidden_importsym       go to state 345
    hidden_type            go to state 638
    hidden_type_misc       go to state 347
    hidden_type_recv_chan  go to state 348
    hidden_type_func       go to state 349


state 603

  301 oliteral: .  [';', '}']
  302         | . LLITERAL
  331 hidden_structdcl: sym hidden_type . oliteral

    LLITERAL  shift, and go to state 395

    $default  reduce using rule 301 (oliteral)

    oliteral  go to state 639


state 604

  321 hidden_type_misc: LSTRUCT '{' ohidden_structdcl_list '}' .

    $default  reduce using rule 321 (hidden_type_misc)


state 605

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  331 hidden_structdcl: . sym hidden_type oliteral
  348 hidden_structdcl_list: hidden_structdcl_list ';' . hidden_structdcl

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    sym               go to state 550
    hidden_importsym  go to state 13
    hidden_structdcl  go to state 640


state 606

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  338 hidden_literal: . LLITERAL
  339               | . '-' LLITERAL
  340               | . sym
  342 hidden_constant: '(' hidden_literal '+' . hidden_literal ')'

    LLITERAL  shift, and go to state 452
    LNAME     shift, and go to state 9
    '-'       shift, and go to state 453
    '?'       shift, and go to state 10
    '@'       shift, and go to state 11

    sym               go to state 455
    hidden_importsym  go to state 13
    hidden_literal    go to state 641


state 607

  319 hidden_type_misc: '[' LLITERAL ']' hidden_type .

    $default  reduce using rule 319 (hidden_type_misc)


state 608

  306 hidden_import: LCONST hidden_pkg_importsym hidden_type '=' hidden_constant ';' .

    $default  reduce using rule 306 (hidden_import)


state 609

  330 hidden_funarg: sym LDDD hidden_type oliteral .

    $default  reduce using rule 330 (hidden_funarg)


state 610

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  207 hidden_fndcl: '(' hidden_funarg_list ')' sym '(' . ohidden_funarg_list ')' ohidden_funres
  295 ohidden_funarg_list: .  [')']
  296                    | . hidden_funarg_list
  329 hidden_funarg: . sym hidden_type oliteral
  330              | . sym LDDD hidden_type oliteral
  345 hidden_funarg_list: . hidden_funarg
  346                   | . hidden_funarg_list ',' hidden_funarg

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    $default  reduce using rule 295 (ohidden_funarg_list)

    sym                  go to state 350
    hidden_importsym     go to state 13
    ohidden_funarg_list  go to state 642
    hidden_funarg        go to state 351
    hidden_funarg_list   go to state 467


state 611

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  295 ohidden_funarg_list: .  [')']
  296                    | . hidden_funarg_list
  329 hidden_funarg: . sym hidden_type oliteral
  330              | . sym LDDD hidden_type oliteral
  336 hidden_funres: '(' . ohidden_funarg_list ')'
  345 hidden_funarg_list: . hidden_funarg
  346                   | . hidden_funarg_list ',' hidden_funarg

    LNAME  shift, and go to state 9
    '?'    shift, and go to state 10
    '@'    shift, and go to state 11

    $default  reduce using rule 295 (ohidden_funarg_list)

    sym                  go to state 350
    hidden_importsym     go to state 13
    ohidden_funarg_list  go to state 643
    hidden_funarg        go to state 351
    hidden_funarg_list   go to state 467


state 612

  337 hidden_funres: hidden_type .

    $default  reduce using rule 337 (hidden_funres)


state 613

  206 hidden_fndcl: hidden_pkg_importsym '(' ohidden_funarg_list ')' ohidden_funres .

    $default  reduce using rule 206 (hidden_fndcl)


state 614

  335 ohidden_funres: hidden_funres .

    $default  reduce using rule 335 (ohidden_funres)


state 615

   66 loop_body: LBODY $@5 stmt_list '}' .

    $default  reduce using rule 66 (loop_body)


state 616

   69 for_header: osimple_stmt ';' osimple_stmt ';' osimple_stmt .

    $default  reduce using rule 69 (for_header)


state 617

  213 fnres: '(' oarg_type_list_ocomma ')' .

    $default  reduce using rule 213 (fnres)


state 618

  205 fndcl: '(' oarg_type_list_ocomma ')' sym '(' oarg_type_list_ocomma . ')' fnres

    ')'  shift, and go to state 644


state 619

   80 if_stmt: LIF $@7 if_header $@8 loop_body $@9 elseif_list . else
   82 elseif: . LELSE LIF $@10 if_header loop_body
   84 elseif_list: elseif_list . elseif
   85 else: .  [LCASE, LDEFAULT, ';', '}']
   86     | . LELSE compound_stmt

    LELSE  shift, and go to state 645

    $default  reduce using rule 85 (else)

    elseif  go to state 646
    else    go to state 647


state 620

  241 indcl: '(' oarg_type_list_ocomma ')' fnres .

    $default  reduce using rule 241 (indcl)


state 621

   57 case: LCASE expr_or_type_list LCOLAS . expr ':'
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 648
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 622

   56 case: LCASE expr_or_type_list '=' . expr ':'
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 649
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 623

   55 case: LCASE expr_or_type_list ':' .

    $default  reduce using rule 55 (case)


state 624

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  147 expr_or_type: . expr
  148             | . non_expr_type
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  171 non_expr_type: . recvchantype
  172              | . fntype
  173              | . othertype
  174              | . '*' non_expr_type
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  278 expr_or_type_list: expr_or_type_list ',' . expr_or_type

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 159
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 160
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    expr              go to state 161
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    expr_or_type      go to state 530
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    non_expr_type     go to state 163
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 164
    recvchantype      go to state 165
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 166
    fnlitdcl          go to state 89
    fnliteral         go to state 90


state 625

   62 caseblock: case $@4 stmt_list .  [LCASE, LDEFAULT, '}']
  270 stmt_list: stmt_list . ';' stmt

    ';'  shift, and go to state 439

    $default  reduce using rule 62 (caseblock)


state 626

  234 structdcl: '*' '(' embed ')' oliteral .

    $default  reduce using rule 234 (structdcl)


state 627

  233 structdcl: '(' '*' embed ')' oliteral .

    $default  reduce using rule 233 (structdcl)


state 628

   89 switch_stmt: LSWITCH $@11 if_header $@12 LBODY caseblock_list '}' .

    $default  reduce using rule 89 (switch_stmt)


state 629

  137 pexpr_no_paren: '(' expr_or_type ')' '{' start_complit braced_keyval_list '}' .

    $default  reduce using rule 137 (pexpr_no_paren)


state 630

  222 constdcl_list: constdcl_list ';' constdcl1 .

    $default  reduce using rule 222 (constdcl_list)


state 631

   33 common_dcl: lconst '(' constdcl ';' constdcl_list osemi ')' .

    $default  reduce using rule 33 (common_dcl)


state 632

  142 bare_complitexpr: '{' start_complit braced_keyval_list '}' .

    $default  reduce using rule 142 (bare_complitexpr)


state 633

   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  140 keyval: . expr ':' complitexpr
  141 bare_complitexpr: . expr
  142                 | . '{' start_complit braced_keyval_list '}'
  144 complitexpr: '{' start_complit . braced_keyval_list '}'
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  279 keyval_list: . keyval
  280            | . bare_complitexpr
  281            | . keyval_list ',' keyval
  282            | . keyval_list ',' bare_complitexpr
  283 braced_keyval_list: .  ['}']
  284                   | . keyval_list ocomma

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '{'         shift, and go to state 421
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 283 (braced_keyval_list)

    expr                go to state 422
    uexpr               go to state 74
    pseudocall          go to state 75
    pexpr_no_paren      go to state 76
    keyval              go to state 423
    bare_complitexpr    go to state 424
    pexpr               go to state 77
    sym                 go to state 117
    hidden_importsym    go to state 13
    name                go to state 80
    convtype            go to state 82
    comptype            go to state 83
    othertype           go to state 84
    structtype          go to state 85
    interfacetype       go to state 86
    fntype              go to state 88
    fnlitdcl            go to state 89
    fnliteral           go to state 90
    keyval_list         go to state 425
    braced_keyval_list  go to state 650


state 634

  132 pexpr_no_paren: pexpr '[' oexpr ':' oexpr ':' oexpr . ']'

    ']'  shift, and go to state 651


state 635

  328 hidden_type_func: LFUNC '(' ohidden_funarg_list ')' ohidden_funres .

    $default  reduce using rule 328 (hidden_type_func)


state 636

  332 hidden_interfacedcl: sym '(' ohidden_funarg_list . ')' ohidden_funres

    ')'  shift, and go to state 652


state 637

  350 hidden_interfacedcl_list: hidden_interfacedcl_list ';' hidden_interfacedcl .

    $default  reduce using rule 350 (hidden_interfacedcl_list)


state 638

  320 hidden_type_misc: LMAP '[' hidden_type ']' hidden_type .

    $default  reduce using rule 320 (hidden_type_misc)


state 639

  331 hidden_structdcl: sym hidden_type oliteral .

    $default  reduce using rule 331 (hidden_structdcl)


state 640

  348 hidden_structdcl_list: hidden_structdcl_list ';' hidden_structdcl .

    $default  reduce using rule 348 (hidden_structdcl_list)


state 641

  342 hidden_constant: '(' hidden_literal '+' hidden_literal . ')'

    ')'  shift, and go to state 653


state 642

  207 hidden_fndcl: '(' hidden_funarg_list ')' sym '(' ohidden_funarg_list . ')' ohidden_funres

    ')'  shift, and go to state 654


state 643

  336 hidden_funres: '(' ohidden_funarg_list . ')'

    ')'  shift, and go to state 655


state 644

  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  183 fnret_type: . recvchantype
  184           | . fntype
  185           | . othertype
  186           | . ptrtype
  187           | . dotname
  188 dotname: . name
  189        | . name '.' sym
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  197 ptrtype: . '*' ntype
  198 recvchantype: . LCOMM LCHAN ntype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  205 fndcl: '(' oarg_type_list_ocomma ')' sym '(' oarg_type_list_ocomma ')' . fnres
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  211 fnres: .  [';', '{']
  212      | . fnret_type
  213      | . '(' oarg_type_list_ocomma ')'

    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 225
    '*'         shift, and go to state 115
    '('         shift, and go to state 478
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 211 (fnres)

    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 118
    fnret_type        go to state 480
    dotname           go to state 481
    othertype         go to state 482
    ptrtype           go to state 483
    recvchantype      go to state 484
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 485
    fnres             go to state 656


state 645

   60 compound_stmt: . '{' $@3 stmt_list '}'
   82 elseif: LELSE . LIF $@10 if_header loop_body
   86 else: LELSE . compound_stmt

    LIF  shift, and go to state 657
    '{'  shift, and go to state 326

    compound_stmt  go to state 658


state 646

   84 elseif_list: elseif_list elseif .

    $default  reduce using rule 84 (elseif_list)


state 647

   80 if_stmt: LIF $@7 if_header $@8 loop_body $@9 elseif_list else .

    $default  reduce using rule 80 (if_stmt)


state 648

   57 case: LCASE expr_or_type_list LCOLAS expr . ':'
   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    LANDAND  shift, and go to state 177
    LANDNOT  shift, and go to state 178
    LCOMM    shift, and go to state 179
    LEQ      shift, and go to state 181
    LGE      shift, and go to state 182
    LGT      shift, and go to state 183
    LLE      shift, and go to state 185
    LLSH     shift, and go to state 186
    LLT      shift, and go to state 187
    LNE      shift, and go to state 188
    LOROR    shift, and go to state 189
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198
    ':'      shift, and go to state 659


state 649

   56 case: LCASE expr_or_type_list '=' expr . ':'
   93 expr: expr . LOROR expr
   94     | expr . LANDAND expr
   95     | expr . LEQ expr
   96     | expr . LNE expr
   97     | expr . LLT expr
   98     | expr . LLE expr
   99     | expr . LGE expr
  100     | expr . LGT expr
  101     | expr . '+' expr
  102     | expr . '-' expr
  103     | expr . '|' expr
  104     | expr . '^' expr
  105     | expr . '*' expr
  106     | expr . '/' expr
  107     | expr . '%' expr
  108     | expr . '&' expr
  109     | expr . LANDNOT expr
  110     | expr . LLSH expr
  111     | expr . LRSH expr
  112     | expr . LCOMM expr

    LANDAND  shift, and go to state 177
    LANDNOT  shift, and go to state 178
    LCOMM    shift, and go to state 179
    LEQ      shift, and go to state 181
    LGE      shift, and go to state 182
    LGT      shift, and go to state 183
    LLE      shift, and go to state 185
    LLSH     shift, and go to state 186
    LLT      shift, and go to state 187
    LNE      shift, and go to state 188
    LOROR    shift, and go to state 189
    LRSH     shift, and go to state 190
    '+'      shift, and go to state 191
    '-'      shift, and go to state 192
    '|'      shift, and go to state 193
    '^'      shift, and go to state 194
    '*'      shift, and go to state 195
    '/'      shift, and go to state 196
    '%'      shift, and go to state 197
    '&'      shift, and go to state 198
    ':'      shift, and go to state 660


state 650

  144 complitexpr: '{' start_complit braced_keyval_list . '}'

    '}'  shift, and go to state 661


state 651

  132 pexpr_no_paren: pexpr '[' oexpr ':' oexpr ':' oexpr ']' .

    $default  reduce using rule 132 (pexpr_no_paren)


state 652

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres
  332 hidden_interfacedcl: sym '(' ohidden_funarg_list ')' . ohidden_funres
  334 ohidden_funres: .  [';', '}']
  335               | . hidden_funres
  336 hidden_funres: . '(' ohidden_funarg_list ')'
  337              | . hidden_type

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 339
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '('         shift, and go to state 611
    '['         shift, and go to state 344
    '@'         shift, and go to state 11

    $default  reduce using rule 334 (ohidden_funres)

    hidden_importsym       go to state 345
    hidden_type            go to state 612
    hidden_type_misc       go to state 347
    hidden_type_recv_chan  go to state 348
    hidden_type_func       go to state 349
    ohidden_funres         go to state 662
    hidden_funres          go to state 614


state 653

  342 hidden_constant: '(' hidden_literal '+' hidden_literal ')' .

    $default  reduce using rule 342 (hidden_constant)


state 654

  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  207 hidden_fndcl: '(' hidden_funarg_list ')' sym '(' ohidden_funarg_list ')' . ohidden_funres
  311 hidden_type: . hidden_type_misc
  312            | . hidden_type_recv_chan
  313            | . hidden_type_func
  316 hidden_type_misc: . hidden_importsym
  317                 | . LNAME
  318                 | . '[' ']' hidden_type
  319                 | . '[' LLITERAL ']' hidden_type
  320                 | . LMAP '[' hidden_type ']' hidden_type
  321                 | . LSTRUCT '{' ohidden_structdcl_list '}'
  322                 | . LINTERFACE '{' ohidden_interfacedcl_list '}'
  323                 | . '*' hidden_type
  324                 | . LCHAN hidden_type_non_recv_chan
  325                 | . LCHAN '(' hidden_type_recv_chan ')'
  326                 | . LCHAN LCOMM hidden_type
  327 hidden_type_recv_chan: . LCOMM LCHAN hidden_type
  328 hidden_type_func: . LFUNC '(' ohidden_funarg_list ')' ohidden_funres
  334 ohidden_funres: .  [';', '{']
  335               | . hidden_funres
  336 hidden_funres: . '(' ohidden_funarg_list ')'
  337              | . hidden_type

    LCHAN       shift, and go to state 335
    LFUNC       shift, and go to state 336
    LINTERFACE  shift, and go to state 337
    LMAP        shift, and go to state 338
    LNAME       shift, and go to state 339
    LSTRUCT     shift, and go to state 340
    LCOMM       shift, and go to state 341
    '*'         shift, and go to state 342
    '('         shift, and go to state 611
    '['         shift, and go to state 344
    '@'         shift, and go to state 11

    $default  reduce using rule 334 (ohidden_funres)

    hidden_importsym       go to state 345
    hidden_type            go to state 612
    hidden_type_misc       go to state 347
    hidden_type_recv_chan  go to state 348
    hidden_type_func       go to state 349
    ohidden_funres         go to state 663
    hidden_funres          go to state 614


state 655

  336 hidden_funres: '(' ohidden_funarg_list ')' .

    $default  reduce using rule 336 (hidden_funres)


state 656

  205 fndcl: '(' oarg_type_list_ocomma ')' sym '(' oarg_type_list_ocomma ')' fnres .

    $default  reduce using rule 205 (fndcl)


state 657

   81 $@10: .
   82 elseif: LELSE LIF . $@10 if_header loop_body

    $default  reduce using rule 81 ($@10)

    $@10  go to state 664


state 658

   86 else: LELSE compound_stmt .

    $default  reduce using rule 86 (else)


state 659

   57 case: LCASE expr_or_type_list LCOLAS expr ':' .

    $default  reduce using rule 57 (case)


state 660

   56 case: LCASE expr_or_type_list '=' expr ':' .

    $default  reduce using rule 56 (case)


state 661

  144 complitexpr: '{' start_complit braced_keyval_list '}' .

    $default  reduce using rule 144 (complitexpr)


state 662

  332 hidden_interfacedcl: sym '(' ohidden_funarg_list ')' ohidden_funres .

    $default  reduce using rule 332 (hidden_interfacedcl)


state 663

  207 hidden_fndcl: '(' hidden_funarg_list ')' sym '(' ohidden_funarg_list ')' ohidden_funres .

    $default  reduce using rule 207 (hidden_fndcl)


state 664

   49 simple_stmt: . expr
   50            | . expr LASOP expr
   51            | . expr_list '=' expr_list
   52            | . expr_list LCOLAS expr_list
   53            | . expr LINC
   54            | . expr LDEC
   75 if_header: . osimple_stmt
   76          | . osimple_stmt ';' osimple_stmt
   82 elseif: LELSE LIF $@10 . if_header loop_body
   92 expr: . uexpr
   93     | . expr LOROR expr
   94     | . expr LANDAND expr
   95     | . expr LEQ expr
   96     | . expr LNE expr
   97     | . expr LLT expr
   98     | . expr LLE expr
   99     | . expr LGE expr
  100     | . expr LGT expr
  101     | . expr '+' expr
  102     | . expr '-' expr
  103     | . expr '|' expr
  104     | . expr '^' expr
  105     | . expr '*' expr
  106     | . expr '/' expr
  107     | . expr '%' expr
  108     | . expr '&' expr
  109     | . expr LANDNOT expr
  110     | . expr LLSH expr
  111     | . expr LRSH expr
  112     | . expr LCOMM expr
  113 uexpr: . pexpr
  114      | . '*' uexpr
  115      | . '&' uexpr
  116      | . '+' uexpr
  117      | . '-' uexpr
  118      | . '!' uexpr
  119      | . '~' uexpr
  120      | . '^' uexpr
  121      | . LCOMM uexpr
  122 pseudocall: . pexpr '(' ')'
  123           | . pexpr '(' expr_or_type_list ocomma ')'
  124           | . pexpr '(' expr_or_type_list LDDD ocomma ')'
  125 pexpr_no_paren: . LLITERAL
  126               | . name
  127               | . pexpr '.' sym
  128               | . pexpr '.' '(' expr_or_type ')'
  129               | . pexpr '.' '(' LTYPE ')'
  130               | . pexpr '[' expr ']'
  131               | . pexpr '[' oexpr ':' oexpr ']'
  132               | . pexpr '[' oexpr ':' oexpr ':' oexpr ']'
  133               | . pseudocall
  134               | . convtype '(' expr ocomma ')'
  135               | . comptype lbrace start_complit braced_keyval_list '}'
  136               | . pexpr_no_paren '{' start_complit braced_keyval_list '}'
  137               | . '(' expr_or_type ')' '{' start_complit braced_keyval_list '}'
  138               | . fnliteral
  145 pexpr: . pexpr_no_paren
  146      | . '(' expr_or_type ')'
  156 sym: . LNAME
  157    | . hidden_importsym
  158    | . '?'
  159 hidden_importsym: . '@' LLITERAL '.' LNAME
  160                 | . '@' LLITERAL '.' '?'
  161 name: . sym
  180 convtype: . fntype
  181         | . othertype
  182 comptype: . othertype
  190 othertype: . '[' oexpr ']' ntype
  191          | . '[' LDDD ']' ntype
  192          | . LCHAN non_recvchantype
  193          | . LCHAN LCOMM ntype
  194          | . LMAP '[' ntype ']' ntype
  195          | . structtype
  196          | . interfacetype
  199 structtype: . LSTRUCT lbrace structdcl_list osemi '}'
  200           | . LSTRUCT lbrace '}'
  201 interfacetype: . LINTERFACE lbrace interfacedcl_list osemi '}'
  202              | . LINTERFACE lbrace '}'
  208 fntype: . LFUNC '(' oarg_type_list_ocomma ')' fnres
  214 fnlitdcl: . fntype
  215 fnliteral: . fnlitdcl lbrace stmt_list '}'
  216          | . fnlitdcl error
  275 expr_list: . expr
  276          | . expr_list ',' expr
  293 osimple_stmt: .  [LBODY, ';']
  294             | . simple_stmt

    LLITERAL    shift, and go to state 35
    LCHAN       shift, and go to state 37
    LFUNC       shift, and go to state 113
    LINTERFACE  shift, and go to state 47
    LMAP        shift, and go to state 48
    LNAME       shift, and go to state 9
    LSTRUCT     shift, and go to state 51
    LCOMM       shift, and go to state 55
    '+'         shift, and go to state 56
    '-'         shift, and go to state 57
    '^'         shift, and go to state 58
    '*'         shift, and go to state 59
    '&'         shift, and go to state 60
    '('         shift, and go to state 61
    '!'         shift, and go to state 62
    '~'         shift, and go to state 63
    '['         shift, and go to state 64
    '?'         shift, and go to state 10
    '@'         shift, and go to state 11

    $default  reduce using rule 293 (osimple_stmt)

    simple_stmt       go to state 236
    if_header         go to state 665
    expr              go to state 73
    uexpr             go to state 74
    pseudocall        go to state 75
    pexpr_no_paren    go to state 76
    pexpr             go to state 77
    sym               go to state 117
    hidden_importsym  go to state 13
    name              go to state 80
    convtype          go to state 82
    comptype          go to state 83
    othertype         go to state 84
    structtype        go to state 85
    interfacetype     go to state 86
    fntype            go to state 88
    fnlitdcl          go to state 89
    fnliteral         go to state 90
    expr_list         go to state 92
    osimple_stmt      go to state 254


state 665

   66 loop_body: . LBODY $@5 stmt_list '}'
   82 elseif: LELSE LIF $@10 if_header . loop_body

    LBODY  shift, and go to state 365

    loop_body  go to state 666


state 666

   82 elseif: LELSE LIF $@10 if_header loop_body .

    $default  reduce using rule 82 (elseif)
