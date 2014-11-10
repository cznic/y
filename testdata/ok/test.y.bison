Terminals unused in grammar

   IGNORE
   XLEFT
   XRIGHT
   TEST1
   TEST2


Grammar

    0 $accept: File $end

    1 $@1: /* empty */

    2 File: PackageDecl $@1 Imports TopLevelDeclList

    3 PackageDecl: /* empty */
    4            | PACKAGE Symbol ';'

    5 Imports: /* empty */
    6        | Imports Import ';'

    7 Import: IMPORT ImportDecl
    8       | IMPORT '(' ImportDeclList oSemi ')'
    9       | IMPORT '(' ')'

   10 ImportDecl: LITERAL
   11           | Symbol LITERAL
   12           | '.' LITERAL

   13 ImportDeclList: ImportDecl
   14               | ImportDeclList ';' ImportDecl

   15 TopLevelDecl: /* empty */
   16             | CommonDecl
   17             | FuncDecl
   18             | NonDclStmt
   19             | error

   20 CommonDecl: VAR VarDecl
   21           | VAR '(' VarDeclList oSemi ')'
   22           | VAR '(' ')'
   23           | Const ConstDecl
   24           | Const '(' ConstDecl oSemi ')'
   25           | Const '(' ConstDecl ';' ConstDeclList oSemi ')'
   26           | Const '(' ')'
   27           | TYPE TypeDecl
   28           | TYPE '(' TypeDeclList oSemi ')'
   29           | TYPE '(' ')'

   30 Const: CONST

   31 VarDecl: DeclNameList Type
   32        | DeclNameList Type '=' ExprList
   33        | DeclNameList '=' ExprList

   34 ConstDecl: DeclNameList Type '=' ExprList
   35          | DeclNameList '=' ExprList

   36 ConstDecl1: ConstDecl
   37           | DeclNameList Type
   38           | DeclNameList

   39 TypeDeclName: Symbol

   40 TypeDecl: TypeDeclName Type

   41 SimpleStmt: Expr
   42           | Expr ASOP Expr
   43           | ExprList '=' ExprList
   44           | ExprList COLAS ExprList
   45           | Expr INC
   46           | Expr DEC

   47 Case: CASE ExprOrTypeList ':'
   48     | CASE ExprOrTypeList '=' Expr ':'
   49     | CASE ExprOrTypeList COLAS Expr ':'
   50     | DEFAULT ':'

   51 $@2: /* empty */

   52 CompoundStmt: '{' $@2 StmtList '}'

   53 $@3: /* empty */

   54 CaseBlock: Case $@3 StmtList

   55 CaseBlockList: /* empty */
   56              | CaseBlockList CaseBlock

   57 $@4: /* empty */

   58 LoopBody: BODY $@4 StmtList '}'

   59 RangeStmt: ExprList '=' RANGE Expr
   60          | ExprList COLAS RANGE Expr

   61 ForHeader: oSimpleStmt ';' oSimpleStmt ';' oSimpleStmt
   62          | oSimpleStmt
   63          | RangeStmt

   64 ForBody: ForHeader LoopBody

   65 $@5: /* empty */

   66 ForStmt: FOR $@5 ForBody

   67 IfHeader: oSimpleStmt
   68         | oSimpleStmt ';' oSimpleStmt

   69 $@6: /* empty */

   70 $@7: /* empty */

   71 IfStmt: IF $@6 IfHeader LoopBody $@7 ElseIfList Else

   72 $@8: /* empty */

   73 ElseIf: ELSE IF IfHeader $@8 LoopBody

   74 ElseIfList: /* empty */
   75           | ElseIfList ElseIf

   76 Else: /* empty */

   77 $@9: /* empty */

   78 Else: ELSE $@9 CompoundStmt

   79 $@10: /* empty */

   80 SwitchStmt: SWITCH $@10 IfHeader BODY CaseBlockList '}'

   81 $@11: /* empty */

   82 SelectStmt: SELECT $@11 BODY CaseBlockList '}'

   83 Expr: UnaryExpr
   84     | Expr OROR Expr
   85     | Expr ANDAND Expr
   86     | Expr EQ Expr
   87     | Expr NE Expr
   88     | Expr '<' Expr
   89     | Expr LE Expr
   90     | Expr GE Expr
   91     | Expr '>' Expr
   92     | Expr '+' Expr
   93     | Expr '-' Expr
   94     | Expr '|' Expr
   95     | Expr '^' Expr
   96     | Expr '*' Expr
   97     | Expr '/' Expr
   98     | Expr '%' Expr
   99     | Expr '&' Expr
  100     | Expr ANDNOT Expr
  101     | Expr LSH Expr
  102     | Expr RSH Expr
  103     | Expr COMM Expr

  104 UnaryExpr: PrimaryExpr
  105          | '*' UnaryExpr
  106          | '&' UnaryExpr
  107          | '+' UnaryExpr
  108          | '-' UnaryExpr
  109          | '!' UnaryExpr
  110          | '~' UnaryExpr
  111          | '^' UnaryExpr
  112          | COMM UnaryExpr

  113 PseudoCall: PrimaryExpr '(' ')'
  114           | PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | PrimaryExpr '(' ExprOrTypeList DDD oComma ')'

  116 PrimaryExprNoParen: LITERAL
  117                   | Name
  118                   | PrimaryExpr '.' Symbol
  119                   | PrimaryExpr '.' '(' ExprOrType ')'
  120                   | PrimaryExpr '.' '(' TYPE ')'
  121                   | PrimaryExpr '[' Expr ']'
  122                   | PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | PseudoCall
  125                   | ConvType '(' ExprList oComma ')'
  126                   | ConvType '(' ')'
  127                   | CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | FuncLit

  131 StartCompLit: /* empty */

  132 Keyval: Expr ':' CompLitExpr

  133 BareCompLitExpr: Expr
  134                | '{' StartCompLit BracedKeyvalList '}'

  135 CompLitExpr: Expr
  136            | '{' StartCompLit BracedKeyvalList '}'

  137 PrimaryExpr: PrimaryExprNoParen
  138            | '(' ExprOrType ')'

  139 ExprOrType: Expr
  140           | NonExprType

  141 NameOrType: Type

  142 LBrace: BODY
  143       | '{'

  144 NewName: Symbol

  145 DeclName: Symbol

  146 oNewName: /* empty */
  147         | NewName

  148 Symbol: IDENT

  149 Name: Symbol

  150 LabelName: NewName

  151 Ddd: DDD
  152    | DDD Type

  153 Type: RecvChanType
  154     | FuncType
  155     | OtherType
  156     | PtrType
  157     | TypeName
  158     | '(' Type ')'

  159 NonExprType: RecvChanType
  160            | FuncType
  161            | OtherType
  162            | '*' NonExprType

  163 NonRecvChanType: FuncType
  164                | OtherType
  165                | PtrType
  166                | TypeName
  167                | '(' Type ')'

  168 ConvType: FuncType
  169         | OtherType

  170 CompLitType: OtherType

  171 FuncRetType: RecvChanType
  172            | FuncType
  173            | OtherType
  174            | PtrType
  175            | TypeName

  176 TypeName: Name
  177         | Name '.' Symbol

  178 OtherType: '[' oExpr ']' Type
  179          | '[' DDD ']' Type
  180          | CHAN NonRecvChanType
  181          | CHAN COMM Type
  182          | MAP '[' Type ']' Type
  183          | StructType
  184          | UnionType
  185          | VariantType
  186          | InterfaceType

  187 PtrType: '*' Type

  188 RecvChanType: COMM CHAN Type

  189 StructType: STRUCT LBrace StructDeclList oSemi '}'
  190           | STRUCT LBrace '}'

  191 UnionType: UNION LBrace StructDeclList oSemi '}'
  192          | UNION LBrace '}'

  193 VariantType: VARIANT LBrace StructDeclList oSemi '}'
  194            | VARIANT LBrace '}'

  195 InterfaceType: INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | INTERFACE LBrace '}'

  197 FuncDecl: FUNC FuncDecl1 FuncBody

  198 FuncDecl1: Symbol '(' oArgTypeListOComma ')' FuncResult
  199          | '(' oArgTypeListOComma ')' Symbol '(' oArgTypeListOComma ')' FuncResult

  200 FuncType: FUNC '(' oArgTypeListOComma ')' FuncResult

  201 FuncBody: /* empty */
  202         | '{' StmtList '}'

  203 FuncResult: /* empty */
  204           | FuncRetType
  205           | '(' oArgTypeListOComma ')'

  206 FuncLitDecl: FuncType

  207 FuncLit: FuncLitDecl LBrace StmtList '}'
  208        | FuncLitDecl error

  209 TopLevelDeclList: /* empty */
  210                 | TopLevelDeclList TopLevelDecl ';'

  211 VarDeclList: VarDecl
  212            | VarDeclList ';' VarDecl

  213 ConstDeclList: ConstDecl1
  214              | ConstDeclList ';' ConstDecl1

  215 TypeDeclList: TypeDecl
  216             | TypeDeclList ';' TypeDecl

  217 StructDeclList: StructDecl
  218               | StructDeclList ';' StructDecl

  219 InterfaceDeclList: InterfaceDecl
  220                  | InterfaceDeclList ';' InterfaceDecl

  221 StructDecl: NewNameList Type oLiteral
  222           | Embedded oLiteral
  223           | '(' Embedded ')' oLiteral
  224           | '*' Embedded oLiteral
  225           | '(' '*' Embedded ')' oLiteral
  226           | '*' '(' Embedded ')' oLiteral

  227 Qualident: IDENT
  228          | IDENT '.' Symbol

  229 Embedded: Qualident

  230 InterfaceDecl: NewName InterfaceMethodDecl
  231              | Qualident
  232              | '(' Qualident ')'

  233 InterfaceMethodDecl: '(' oArgTypeListOComma ')' FuncResult

  234 ArgType: NameOrType
  235        | Symbol NameOrType
  236        | Symbol Ddd
  237        | Ddd

  238 ArgTypeList: ArgType
  239            | ArgTypeList ',' ArgType

  240 oArgTypeListOComma: /* empty */
  241                   | ArgTypeList oComma

  242 Statement: /* empty */
  243          | CompoundStmt
  244          | CommonDecl
  245          | NonDclStmt
  246          | error

  247 NonDclStmt: SimpleStmt
  248           | ForStmt
  249           | SwitchStmt
  250           | SelectStmt
  251           | IfStmt
  252           | LabelName ':' Statement
  253           | FALL
  254           | BREAK oNewName
  255           | CONTINUE oNewName
  256           | GO PseudoCall
  257           | DEFER PseudoCall
  258           | GOTO NewName
  259           | GOTO
  260           | RETURN oExprList

  261 StmtList: Statement
  262         | StmtList ';' Statement

  263 NewNameList: NewName
  264            | NewNameList ',' NewName

  265 DeclNameList: DeclName
  266             | DeclNameList ',' DeclName

  267 ExprList: Expr
  268         | ExprList ',' Expr

  269 ExprOrTypeList: ExprOrType
  270               | ExprOrTypeList ',' ExprOrType

  271 KeyvalList: Keyval
  272           | BareCompLitExpr
  273           | KeyvalList ',' Keyval
  274           | KeyvalList ',' BareCompLitExpr

  275 BracedKeyvalList: /* empty */
  276                 | KeyvalList oComma

  277 oSemi: /* empty */
  278      | ';'

  279 oComma: /* empty */
  280       | ','

  281 oExpr: /* empty */
  282      | Expr

  283 oExprList: /* empty */
  284          | ExprList

  285 oSimpleStmt: /* empty */
  286            | SimpleStmt

  287 oLiteral: /* empty */
  288         | LITERAL


Terminals, with rules where they appear

$end (0) 0
'!' (33) 109
'%' (37) 98
'&' (38) 99 106
'(' (40) 8 9 21 22 24 25 26 28 29 113 114 115 119 120 125 126 129 138
    158 167 198 199 200 205 223 225 226 232 233
')' (41) 8 9 21 22 24 25 26 28 29 113 114 115 119 120 125 126 129 138
    158 167 198 199 200 205 223 225 226 232 233
'*' (42) 96 105 162 187 224 225 226
'+' (43) 92 107
',' (44) 239 264 266 268 270 273 274 280
'-' (45) 93 108
'.' (46) 12 118 119 120 177 228
'/' (47) 97
':' (58) 47 48 49 50 122 123 132 252
';' (59) 4 6 14 25 61 68 210 212 214 216 218 220 262 278
'<' (60) 88
'=' (61) 32 33 34 35 43 48 59
'>' (62) 91
'[' (91) 121 122 123 178 179 182
']' (93) 121 122 123 178 179 182
'^' (94) 95 111
'{' (123) 52 128 129 134 136 143 202
'|' (124) 94
'}' (125) 52 58 80 82 127 128 129 134 136 189 190 191 192 193 194 195
    196 202 207
'~' (126) 110
error (256) 19 208 246
ANDAND (258) 85
ANDNOT (259) 100
ASOP (260) 42
BODY (261) 58 80 82 142
BREAK (262) 254
CASE (263) 47 48 49
CHAN (264) 180 181 188
COLAS (265) 44 49 60
COMM (266) 103 112 181 188
CONST (267) 30
CONTINUE (268) 255
DDD (269) 115 151 152 179
DEC (270) 46
DEFAULT (271) 50
DEFER (272) 257
ELSE (273) 73 78
EQ (274) 86
FALL (275) 253
FOR (276) 66
FUNC (277) 197 200
GE (278) 90
GO (279) 256
GOTO (280) 258 259
IDENT (281) 148 227 228
IF (282) 71 73
IGNORE (283)
IMPORT (284) 7 8 9
INC (285) 45
INTERFACE (286) 195 196
LE (287) 89
LITERAL (288) 10 11 12 116 288
LSH (289) 101
MAP (290) 182
NE (291) 87
OROR (292) 84
PACKAGE (293) 4
RANGE (294) 59 60
RETURN (295) 260
RSH (296) 102
SELECT (297) 82
STRUCT (298) 189 190
SWITCH (299) 80
TYPE (300) 27 28 29 120
UNION (301) 191 192
VAR (302) 20 21 22
VARIANT (303) 193 194
XLEFT (304)
XRIGHT (305)
TEST1 (306)
TEST2 (307)
notPackage (308)
notParen (309)
preferToRightParen (310)


Nonterminals, with rules where they appear

$accept (79)
    on left: 0
File (80)
    on left: 2, on right: 0
$@1 (81)
    on left: 1, on right: 2
PackageDecl (82)
    on left: 3 4, on right: 2
Imports (83)
    on left: 5 6, on right: 2 6
Import (84)
    on left: 7 8 9, on right: 6
ImportDecl (85)
    on left: 10 11 12, on right: 7 13 14
ImportDeclList (86)
    on left: 13 14, on right: 8 14
TopLevelDecl (87)
    on left: 15 16 17 18 19, on right: 210
CommonDecl (88)
    on left: 20 21 22 23 24 25 26 27 28 29, on right: 16 244
Const (89)
    on left: 30, on right: 23 24 25 26
VarDecl (90)
    on left: 31 32 33, on right: 20 211 212
ConstDecl (91)
    on left: 34 35, on right: 23 24 25 36
ConstDecl1 (92)
    on left: 36 37 38, on right: 213 214
TypeDeclName (93)
    on left: 39, on right: 40
TypeDecl (94)
    on left: 40, on right: 27 215 216
SimpleStmt (95)
    on left: 41 42 43 44 45 46, on right: 247 286
Case (96)
    on left: 47 48 49 50, on right: 54
CompoundStmt (97)
    on left: 52, on right: 78 243
$@2 (98)
    on left: 51, on right: 52
CaseBlock (99)
    on left: 54, on right: 56
$@3 (100)
    on left: 53, on right: 54
CaseBlockList (101)
    on left: 55 56, on right: 56 80 82
LoopBody (102)
    on left: 58, on right: 64 71 73
$@4 (103)
    on left: 57, on right: 58
RangeStmt (104)
    on left: 59 60, on right: 63
ForHeader (105)
    on left: 61 62 63, on right: 64
ForBody (106)
    on left: 64, on right: 66
ForStmt (107)
    on left: 66, on right: 248
$@5 (108)
    on left: 65, on right: 66
IfHeader (109)
    on left: 67 68, on right: 71 73 80
IfStmt (110)
    on left: 71, on right: 251
$@6 (111)
    on left: 69, on right: 71
$@7 (112)
    on left: 70, on right: 71
ElseIf (113)
    on left: 73, on right: 75
$@8 (114)
    on left: 72, on right: 73
ElseIfList (115)
    on left: 74 75, on right: 71 75
Else (116)
    on left: 76 78, on right: 71
$@9 (117)
    on left: 77, on right: 78
SwitchStmt (118)
    on left: 80, on right: 249
$@10 (119)
    on left: 79, on right: 80
SelectStmt (120)
    on left: 82, on right: 250
$@11 (121)
    on left: 81, on right: 82
Expr (122)
    on left: 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100
    101 102 103, on right: 41 42 45 46 48 49 59 60 84 85 86 87 88 89
    90 91 92 93 94 95 96 97 98 99 100 101 102 103 121 132 133 135 139
    267 268 282
UnaryExpr (123)
    on left: 104 105 106 107 108 109 110 111 112, on right: 83 105
    106 107 108 109 110 111 112
PseudoCall (124)
    on left: 113 114 115, on right: 124 256 257
PrimaryExprNoParen (125)
    on left: 116 117 118 119 120 121 122 123 124 125 126 127 128 129
    130, on right: 128 137
StartCompLit (126)
    on left: 131, on right: 127 128 129 134 136
Keyval (127)
    on left: 132, on right: 271 273
BareCompLitExpr (128)
    on left: 133 134, on right: 272 274
CompLitExpr (129)
    on left: 135 136, on right: 132
PrimaryExpr (130)
    on left: 137 138, on right: 104 113 114 115 118 119 120 121 122
    123
ExprOrType (131)
    on left: 139 140, on right: 119 129 138 269 270
NameOrType (132)
    on left: 141, on right: 234 235
LBrace (133)
    on left: 142 143, on right: 127 189 190 191 192 193 194 195 196
    207
NewName (134)
    on left: 144, on right: 147 150 230 258 263 264
DeclName (135)
    on left: 145, on right: 265 266
oNewName (136)
    on left: 146 147, on right: 254 255
Symbol (137)
    on left: 148, on right: 4 11 39 118 144 145 149 177 198 199 228
    235 236
Name (138)
    on left: 149, on right: 117 176 177
LabelName (139)
    on left: 150, on right: 252
Ddd (140)
    on left: 151 152, on right: 236 237
Type (141)
    on left: 153 154 155 156 157 158, on right: 31 32 34 37 40 141
    152 158 167 178 179 181 182 187 188 221
NonExprType (142)
    on left: 159 160 161 162, on right: 140 162
NonRecvChanType (143)
    on left: 163 164 165 166 167, on right: 180
ConvType (144)
    on left: 168 169, on right: 125 126
CompLitType (145)
    on left: 170, on right: 127
FuncRetType (146)
    on left: 171 172 173 174 175, on right: 204
TypeName (147)
    on left: 176 177, on right: 157 166 175
OtherType (148)
    on left: 178 179 180 181 182 183 184 185 186, on right: 155 161
    164 169 170 173
PtrType (149)
    on left: 187, on right: 156 165 174
RecvChanType (150)
    on left: 188, on right: 153 159 171
StructType (151)
    on left: 189 190, on right: 183
UnionType (152)
    on left: 191 192, on right: 184
VariantType (153)
    on left: 193 194, on right: 185
InterfaceType (154)
    on left: 195 196, on right: 186
FuncDecl (155)
    on left: 197, on right: 17
FuncDecl1 (156)
    on left: 198 199, on right: 197
FuncType (157)
    on left: 200, on right: 154 160 163 168 172 206
FuncBody (158)
    on left: 201 202, on right: 197
FuncResult (159)
    on left: 203 204 205, on right: 198 199 200 233
FuncLitDecl (160)
    on left: 206, on right: 207 208
FuncLit (161)
    on left: 207 208, on right: 130
TopLevelDeclList (162)
    on left: 209 210, on right: 2 210
VarDeclList (163)
    on left: 211 212, on right: 21 212
ConstDeclList (164)
    on left: 213 214, on right: 25 214
TypeDeclList (165)
    on left: 215 216, on right: 28 216
StructDeclList (166)
    on left: 217 218, on right: 189 191 193 218
InterfaceDeclList (167)
    on left: 219 220, on right: 195 220
StructDecl (168)
    on left: 221 222 223 224 225 226, on right: 217 218
Qualident (169)
    on left: 227 228, on right: 229 231 232
Embedded (170)
    on left: 229, on right: 222 223 224 225 226
InterfaceDecl (171)
    on left: 230 231 232, on right: 219 220
InterfaceMethodDecl (172)
    on left: 233, on right: 230
ArgType (173)
    on left: 234 235 236 237, on right: 238 239
ArgTypeList (174)
    on left: 238 239, on right: 239 241
oArgTypeListOComma (175)
    on left: 240 241, on right: 198 199 200 205 233
Statement (176)
    on left: 242 243 244 245 246, on right: 252 261 262
NonDclStmt (177)
    on left: 247 248 249 250 251 252 253 254 255 256 257 258 259 260,
    on right: 18 245
StmtList (178)
    on left: 261 262, on right: 52 54 58 202 207 262
NewNameList (179)
    on left: 263 264, on right: 221 264
DeclNameList (180)
    on left: 265 266, on right: 31 32 33 34 35 37 38 266
ExprList (181)
    on left: 267 268, on right: 32 33 34 35 43 44 59 60 125 268 284
ExprOrTypeList (182)
    on left: 269 270, on right: 47 48 49 114 115 270
KeyvalList (183)
    on left: 271 272 273 274, on right: 273 274 276
BracedKeyvalList (184)
    on left: 275 276, on right: 127 128 129 134 136
oSemi (185)
    on left: 277 278, on right: 8 21 24 25 28 189 191 193 195
oComma (186)
    on left: 279 280, on right: 114 115 125 241 276
oExpr (187)
    on left: 281 282, on right: 122 123 178
oExprList (188)
    on left: 283 284, on right: 260
oSimpleStmt (189)
    on left: 285 286, on right: 61 62 67 68
oLiteral (190)
    on left: 287 288, on right: 221 222 223 224 225 226


state 0

    0 $accept: . File $end
    2 File: . PackageDecl $@1 Imports TopLevelDeclList
    3 PackageDecl: .  [$end, error, BREAK, CHAN, COMM, CONST, CONTINUE, DEFER, FALL, FOR, FUNC, GO, GOTO, IDENT, IF, IMPORT, INTERFACE, LITERAL, MAP, RETURN, SELECT, STRUCT, SWITCH, TYPE, UNION, VAR, VARIANT, '!', '&', '(', '*', '+', '-', ';', '[', '^', '~']
    4            | . PACKAGE Symbol ';'

    PACKAGE  shift, and go to state 1

    $default  reduce using rule 3 (PackageDecl)

    File         go to state 2
    PackageDecl  go to state 3


state 1

    4 PackageDecl: PACKAGE . Symbol ';'
  148 Symbol: . IDENT

    IDENT  shift, and go to state 4

    Symbol  go to state 5


state 2

    0 $accept: File . $end

    $end  shift, and go to state 6


state 3

    1 $@1: .
    2 File: PackageDecl . $@1 Imports TopLevelDeclList

    $default  reduce using rule 1 ($@1)

    $@1  go to state 7


state 4

  148 Symbol: IDENT .

    $default  reduce using rule 148 (Symbol)


state 5

    4 PackageDecl: PACKAGE Symbol . ';'

    ';'  shift, and go to state 8


state 6

    0 $accept: File $end .

    $default  accept


state 7

    2 File: PackageDecl $@1 . Imports TopLevelDeclList
    5 Imports: .
    6        | . Imports Import ';'

    $default  reduce using rule 5 (Imports)

    Imports  go to state 9


state 8

    4 PackageDecl: PACKAGE Symbol ';' .

    $default  reduce using rule 4 (PackageDecl)


state 9

    2 File: PackageDecl $@1 Imports . TopLevelDeclList
    6 Imports: Imports . Import ';'
    7 Import: . IMPORT ImportDecl
    8       | . IMPORT '(' ImportDeclList oSemi ')'
    9       | . IMPORT '(' ')'
  209 TopLevelDeclList: .  [$end, error, BREAK, CHAN, COMM, CONST, CONTINUE, DEFER, FALL, FOR, FUNC, GO, GOTO, IDENT, IF, INTERFACE, LITERAL, MAP, RETURN, SELECT, STRUCT, SWITCH, TYPE, UNION, VAR, VARIANT, '!', '&', '(', '*', '+', '-', ';', '[', '^', '~']
  210                 | . TopLevelDeclList TopLevelDecl ';'

    IMPORT  shift, and go to state 10

    $default  reduce using rule 209 (TopLevelDeclList)

    Import            go to state 11
    TopLevelDeclList  go to state 12


state 10

    7 Import: IMPORT . ImportDecl
    8       | IMPORT . '(' ImportDeclList oSemi ')'
    9       | IMPORT . '(' ')'
   10 ImportDecl: . LITERAL
   11           | . Symbol LITERAL
   12           | . '.' LITERAL
  148 Symbol: . IDENT

    IDENT    shift, and go to state 4
    LITERAL  shift, and go to state 13
    '('      shift, and go to state 14
    '.'      shift, and go to state 15

    ImportDecl  go to state 16
    Symbol      go to state 17


state 11

    6 Imports: Imports Import . ';'

    ';'  shift, and go to state 18


state 12

    2 File: PackageDecl $@1 Imports TopLevelDeclList .  [$end]
   15 TopLevelDecl: .  [';']
   16             | . CommonDecl
   17             | . FuncDecl
   18             | . NonDclStmt
   19             | . error
   20 CommonDecl: . VAR VarDecl
   21           | . VAR '(' VarDeclList oSemi ')'
   22           | . VAR '(' ')'
   23           | . Const ConstDecl
   24           | . Const '(' ConstDecl oSemi ')'
   25           | . Const '(' ConstDecl ';' ConstDeclList oSemi ')'
   26           | . Const '(' ')'
   27           | . TYPE TypeDecl
   28           | . TYPE '(' TypeDeclList oSemi ')'
   29           | . TYPE '(' ')'
   30 Const: . CONST
   41 SimpleStmt: . Expr
   42           | . Expr ASOP Expr
   43           | . ExprList '=' ExprList
   44           | . ExprList COLAS ExprList
   45           | . Expr INC
   46           | . Expr DEC
   66 ForStmt: . FOR $@5 ForBody
   71 IfStmt: . IF $@6 IfHeader LoopBody $@7 ElseIfList Else
   80 SwitchStmt: . SWITCH $@10 IfHeader BODY CaseBlockList '}'
   82 SelectStmt: . SELECT $@11 BODY CaseBlockList '}'
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  144 NewName: . Symbol
  148 Symbol: . IDENT
  149 Name: . Symbol
  150 LabelName: . NewName
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  197 FuncDecl: . FUNC FuncDecl1 FuncBody
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  210 TopLevelDeclList: TopLevelDeclList . TopLevelDecl ';'
  247 NonDclStmt: . SimpleStmt
  248           | . ForStmt
  249           | . SwitchStmt
  250           | . SelectStmt
  251           | . IfStmt
  252           | . LabelName ':' Statement
  253           | . FALL
  254           | . BREAK oNewName
  255           | . CONTINUE oNewName
  256           | . GO PseudoCall
  257           | . DEFER PseudoCall
  258           | . GOTO NewName
  259           | . GOTO
  260           | . RETURN oExprList
  267 ExprList: . Expr
  268         | . ExprList ',' Expr

    error      shift, and go to state 19
    BREAK      shift, and go to state 20
    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    CONST      shift, and go to state 23
    CONTINUE   shift, and go to state 24
    DEFER      shift, and go to state 25
    FALL       shift, and go to state 26
    FOR        shift, and go to state 27
    FUNC       shift, and go to state 28
    GO         shift, and go to state 29
    GOTO       shift, and go to state 30
    IDENT      shift, and go to state 4
    IF         shift, and go to state 31
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    RETURN     shift, and go to state 35
    SELECT     shift, and go to state 36
    STRUCT     shift, and go to state 37
    SWITCH     shift, and go to state 38
    TYPE       shift, and go to state 39
    UNION      shift, and go to state 40
    VAR        shift, and go to state 41
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    $end  reduce using rule 2 (File)
    ';'   reduce using rule 15 (TopLevelDecl)

    TopLevelDecl        go to state 52
    CommonDecl          go to state 53
    Const               go to state 54
    SimpleStmt          go to state 55
    ForStmt             go to state 56
    IfStmt              go to state 57
    SwitchStmt          go to state 58
    SelectStmt          go to state 59
    Expr                go to state 60
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    NewName             go to state 65
    Symbol              go to state 66
    Name                go to state 67
    LabelName           go to state 68
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncDecl            go to state 76
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    NonDclStmt          go to state 80
    ExprList            go to state 81


state 13

   10 ImportDecl: LITERAL .

    $default  reduce using rule 10 (ImportDecl)


state 14

    8 Import: IMPORT '(' . ImportDeclList oSemi ')'
    9       | IMPORT '(' . ')'
   10 ImportDecl: . LITERAL
   11           | . Symbol LITERAL
   12           | . '.' LITERAL
   13 ImportDeclList: . ImportDecl
   14               | . ImportDeclList ';' ImportDecl
  148 Symbol: . IDENT

    IDENT    shift, and go to state 4
    LITERAL  shift, and go to state 13
    ')'      shift, and go to state 82
    '.'      shift, and go to state 15

    ImportDecl      go to state 83
    ImportDeclList  go to state 84
    Symbol          go to state 17


state 15

   12 ImportDecl: '.' . LITERAL

    LITERAL  shift, and go to state 85


state 16

    7 Import: IMPORT ImportDecl .

    $default  reduce using rule 7 (Import)


state 17

   11 ImportDecl: Symbol . LITERAL

    LITERAL  shift, and go to state 86


state 18

    6 Imports: Imports Import ';' .

    $default  reduce using rule 6 (Imports)


state 19

   19 TopLevelDecl: error .

    $default  reduce using rule 19 (TopLevelDecl)


state 20

  144 NewName: . Symbol
  146 oNewName: .  [CASE, DEFAULT, ';', '}']
  147         | . NewName
  148 Symbol: . IDENT
  254 NonDclStmt: BREAK . oNewName

    IDENT  shift, and go to state 4

    $default  reduce using rule 146 (oNewName)

    NewName   go to state 87
    oNewName  go to state 88
    Symbol    go to state 89


state 21

  148 Symbol: . IDENT
  149 Name: . Symbol
  163 NonRecvChanType: . FuncType
  164                | . OtherType
  165                | . PtrType
  166                | . TypeName
  167                | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  180          | CHAN . NonRecvChanType
  181          | . CHAN COMM Type
  181          | CHAN . COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 90
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 92
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    Symbol           go to state 94
    Name             go to state 95
    NonRecvChanType  go to state 96
    TypeName         go to state 97
    OtherType        go to state 98
    PtrType          go to state 99
    StructType       go to state 72
    UnionType        go to state 73
    VariantType      go to state 74
    InterfaceType    go to state 75
    FuncType         go to state 100


state 22

  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  112          | COMM . UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    UnaryExpr           go to state 101
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 23

   30 Const: CONST .

    $default  reduce using rule 30 (Const)


state 24

  144 NewName: . Symbol
  146 oNewName: .  [CASE, DEFAULT, ';', '}']
  147         | . NewName
  148 Symbol: . IDENT
  255 NonDclStmt: CONTINUE . oNewName

    IDENT  shift, and go to state 4

    $default  reduce using rule 146 (oNewName)

    NewName   go to state 87
    oNewName  go to state 102
    Symbol    go to state 89


state 25

  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  257 NonDclStmt: DEFER . PseudoCall

    CHAN       shift, and go to state 21
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 45
    '['        shift, and go to state 49

    PseudoCall          go to state 103
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 104
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 26

  253 NonDclStmt: FALL .

    $default  reduce using rule 253 (NonDclStmt)


state 27

   65 $@5: .
   66 ForStmt: FOR . $@5 ForBody

    $default  reduce using rule 65 ($@5)

    $@5  go to state 105


state 28

  148 Symbol: . IDENT
  197 FuncDecl: FUNC . FuncDecl1 FuncBody
  198 FuncDecl1: . Symbol '(' oArgTypeListOComma ')' FuncResult
  199          | . '(' oArgTypeListOComma ')' Symbol '(' oArgTypeListOComma ')' FuncResult
  200 FuncType: FUNC . '(' oArgTypeListOComma ')' FuncResult

    IDENT  shift, and go to state 4
    '('    shift, and go to state 106

    Symbol     go to state 107
    FuncDecl1  go to state 108


state 29

  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  256 NonDclStmt: GO . PseudoCall

    CHAN       shift, and go to state 21
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 45
    '['        shift, and go to state 49

    PseudoCall          go to state 109
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 104
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 30

  144 NewName: . Symbol
  148 Symbol: . IDENT
  258 NonDclStmt: GOTO . NewName
  259           | GOTO .  [CASE, DEFAULT, ';', '}']

    IDENT  shift, and go to state 4

    $default  reduce using rule 259 (NonDclStmt)

    NewName  go to state 110
    Symbol   go to state 89


state 31

   69 $@6: .
   71 IfStmt: IF . $@6 IfHeader LoopBody $@7 ElseIfList Else

    $default  reduce using rule 69 ($@6)

    $@6  go to state 111


state 32

  142 LBrace: . BODY
  143       | . '{'
  195 InterfaceType: INTERFACE . LBrace InterfaceDeclList oSemi '}'
  196              | INTERFACE . LBrace '}'

    BODY  shift, and go to state 112
    '{'   shift, and go to state 113

    LBrace  go to state 114


state 33

  116 PrimaryExprNoParen: LITERAL .

    $default  reduce using rule 116 (PrimaryExprNoParen)


state 34

  182 OtherType: MAP . '[' Type ']' Type

    '['  shift, and go to state 115


state 35

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  260 NonDclStmt: RETURN . oExprList
  267 ExprList: . Expr
  268         | . ExprList ',' Expr
  283 oExprList: .  [CASE, DEFAULT, ';', '}']
  284          | . ExprList

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    $default  reduce using rule 283 (oExprList)

    Expr                go to state 116
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprList            go to state 117
    oExprList           go to state 118


state 36

   81 $@11: .
   82 SelectStmt: SELECT . $@11 BODY CaseBlockList '}'

    $default  reduce using rule 81 ($@11)

    $@11  go to state 119


state 37

  142 LBrace: . BODY
  143       | . '{'
  189 StructType: STRUCT . LBrace StructDeclList oSemi '}'
  190           | STRUCT . LBrace '}'

    BODY  shift, and go to state 112
    '{'   shift, and go to state 113

    LBrace  go to state 120


state 38

   79 $@10: .
   80 SwitchStmt: SWITCH . $@10 IfHeader BODY CaseBlockList '}'

    $default  reduce using rule 79 ($@10)

    $@10  go to state 121


state 39

   27 CommonDecl: TYPE . TypeDecl
   28           | TYPE . '(' TypeDeclList oSemi ')'
   29           | TYPE . '(' ')'
   39 TypeDeclName: . Symbol
   40 TypeDecl: . TypeDeclName Type
  148 Symbol: . IDENT

    IDENT  shift, and go to state 4
    '('    shift, and go to state 122

    TypeDeclName  go to state 123
    TypeDecl      go to state 124
    Symbol        go to state 125


state 40

  142 LBrace: . BODY
  143       | . '{'
  191 UnionType: UNION . LBrace StructDeclList oSemi '}'
  192          | UNION . LBrace '}'

    BODY  shift, and go to state 112
    '{'   shift, and go to state 113

    LBrace  go to state 126


state 41

   20 CommonDecl: VAR . VarDecl
   21           | VAR . '(' VarDeclList oSemi ')'
   22           | VAR . '(' ')'
   31 VarDecl: . DeclNameList Type
   32        | . DeclNameList Type '=' ExprList
   33        | . DeclNameList '=' ExprList
  145 DeclName: . Symbol
  148 Symbol: . IDENT
  265 DeclNameList: . DeclName
  266             | . DeclNameList ',' DeclName

    IDENT  shift, and go to state 4
    '('    shift, and go to state 127

    VarDecl       go to state 128
    DeclName      go to state 129
    Symbol        go to state 130
    DeclNameList  go to state 131


state 42

  142 LBrace: . BODY
  143       | . '{'
  193 VariantType: VARIANT . LBrace StructDeclList oSemi '}'
  194            | VARIANT . LBrace '}'

    BODY  shift, and go to state 112
    '{'   shift, and go to state 113

    LBrace  go to state 132


state 43

  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  109          | '!' . UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    UnaryExpr           go to state 133
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 44

  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  106          | '&' . UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    UnaryExpr           go to state 134
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 45

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  129                   | '(' . ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  138            | '(' . ExprOrType ')'
  139 ExprOrType: . Expr
  140           | . NonExprType
  148 Symbol: . IDENT
  149 Name: . Symbol
  159 NonExprType: . RecvChanType
  160            | . FuncType
  161            | . OtherType
  162            | . '*' NonExprType
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 135
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 136
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 137
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    ExprOrType          go to state 138
    Symbol              go to state 94
    Name                go to state 67
    NonExprType         go to state 139
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 140
    RecvChanType        go to state 141
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 142
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 46

  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  105          | '*' . UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    UnaryExpr           go to state 143
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 47

  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  107          | '+' . UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    UnaryExpr           go to state 144
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 48

  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  108          | '-' . UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    UnaryExpr           go to state 145
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 49

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  178          | '[' . oExpr ']' Type
  179          | . '[' DDD ']' Type
  179          | '[' . DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  281 oExpr: .  [']']
  282      | . Expr

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    DDD        shift, and go to state 146
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    $default  reduce using rule 281 (oExpr)

    Expr                go to state 147
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    oExpr               go to state 148


state 50

  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  111          | '^' . UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    UnaryExpr           go to state 149
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 51

  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  110          | '~' . UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    UnaryExpr           go to state 150
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 52

  210 TopLevelDeclList: TopLevelDeclList TopLevelDecl . ';'

    ';'  shift, and go to state 151


state 53

   16 TopLevelDecl: CommonDecl .

    $default  reduce using rule 16 (TopLevelDecl)


state 54

   23 CommonDecl: Const . ConstDecl
   24           | Const . '(' ConstDecl oSemi ')'
   25           | Const . '(' ConstDecl ';' ConstDeclList oSemi ')'
   26           | Const . '(' ')'
   34 ConstDecl: . DeclNameList Type '=' ExprList
   35          | . DeclNameList '=' ExprList
  145 DeclName: . Symbol
  148 Symbol: . IDENT
  265 DeclNameList: . DeclName
  266             | . DeclNameList ',' DeclName

    IDENT  shift, and go to state 4
    '('    shift, and go to state 152

    ConstDecl     go to state 153
    DeclName      go to state 129
    Symbol        go to state 130
    DeclNameList  go to state 154


state 55

  247 NonDclStmt: SimpleStmt .

    $default  reduce using rule 247 (NonDclStmt)


state 56

  248 NonDclStmt: ForStmt .

    $default  reduce using rule 248 (NonDclStmt)


state 57

  251 NonDclStmt: IfStmt .

    $default  reduce using rule 251 (NonDclStmt)


state 58

  249 NonDclStmt: SwitchStmt .

    $default  reduce using rule 249 (NonDclStmt)


state 59

  250 NonDclStmt: SelectStmt .

    $default  reduce using rule 250 (NonDclStmt)


state 60

   41 SimpleStmt: Expr .  [BODY, CASE, DEFAULT, ';', '}']
   42           | Expr . ASOP Expr
   45           | Expr . INC
   46           | Expr . DEC
   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr
  267 ExprList: Expr .  [COLAS, '=', ',']

    ANDAND  shift, and go to state 155
    ANDNOT  shift, and go to state 156
    ASOP    shift, and go to state 157
    COMM    shift, and go to state 158
    DEC     shift, and go to state 159
    EQ      shift, and go to state 160
    GE      shift, and go to state 161
    INC     shift, and go to state 162
    LE      shift, and go to state 163
    LSH     shift, and go to state 164
    NE      shift, and go to state 165
    OROR    shift, and go to state 166
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '<'     shift, and go to state 174
    '>'     shift, and go to state 175
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    COLAS     reduce using rule 267 (ExprList)
    '='       reduce using rule 267 (ExprList)
    ','       reduce using rule 267 (ExprList)
    $default  reduce using rule 41 (SimpleStmt)


state 61

   83 Expr: UnaryExpr .

    $default  reduce using rule 83 (Expr)


state 62

  124 PrimaryExprNoParen: PseudoCall .

    $default  reduce using rule 124 (PrimaryExprNoParen)


state 63

  128 PrimaryExprNoParen: PrimaryExprNoParen . '{' StartCompLit BracedKeyvalList '}'
  137 PrimaryExpr: PrimaryExprNoParen .  [ANDAND, ANDNOT, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, LSH, NE, OROR, RSH, '%', '&', '(', ')', '*', '+', '-', '.', '/', ':', ';', '<', '=', '>', '[', '^', '|', '}', ']', ',']

    '{'  shift, and go to state 178

    $default  reduce using rule 137 (PrimaryExpr)


state 64

  104 UnaryExpr: PrimaryExpr .  [ANDAND, ANDNOT, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, LSH, NE, OROR, RSH, '%', '&', ')', '*', '+', '-', '/', ':', ';', '<', '=', '>', '^', '|', '}', ']', ',']
  113 PseudoCall: PrimaryExpr . '(' ')'
  114           | PrimaryExpr . '(' ExprOrTypeList oComma ')'
  115           | PrimaryExpr . '(' ExprOrTypeList DDD oComma ')'
  118 PrimaryExprNoParen: PrimaryExpr . '.' Symbol
  119                   | PrimaryExpr . '.' '(' ExprOrType ')'
  120                   | PrimaryExpr . '.' '(' TYPE ')'
  121                   | PrimaryExpr . '[' Expr ']'
  122                   | PrimaryExpr . '[' oExpr ':' oExpr ']'
  123                   | PrimaryExpr . '[' oExpr ':' oExpr ':' oExpr ']'

    '('  shift, and go to state 179
    '.'  shift, and go to state 180
    '['  shift, and go to state 181

    $default  reduce using rule 104 (UnaryExpr)


state 65

  150 LabelName: NewName .

    $default  reduce using rule 150 (LabelName)


state 66

  144 NewName: Symbol .  [':']
  149 Name: Symbol .  [ANDAND, ANDNOT, ASOP, CASE, COLAS, COMM, DEC, DEFAULT, EQ, GE, INC, LE, LSH, NE, OROR, RSH, '%', '&', '(', '*', '+', '-', '.', '/', ';', '<', '=', '>', '[', '^', '{', '|', '}', ',']

    ':'       reduce using rule 144 (NewName)
    $default  reduce using rule 149 (Name)


state 67

  117 PrimaryExprNoParen: Name .

    $default  reduce using rule 117 (PrimaryExprNoParen)


state 68

  252 NonDclStmt: LabelName . ':' Statement

    ':'  shift, and go to state 182


state 69

  125 PrimaryExprNoParen: ConvType . '(' ExprList oComma ')'
  126                   | ConvType . '(' ')'

    '('  shift, and go to state 183


state 70

  127 PrimaryExprNoParen: CompLitType . LBrace StartCompLit BracedKeyvalList '}'
  142 LBrace: . BODY
  143       | . '{'

    BODY  shift, and go to state 112
    '{'   shift, and go to state 113

    LBrace  go to state 184


state 71

  169 ConvType: OtherType .  ['(']
  170 CompLitType: OtherType .  [BODY, '{']

    '('       reduce using rule 169 (ConvType)
    $default  reduce using rule 170 (CompLitType)


state 72

  183 OtherType: StructType .

    $default  reduce using rule 183 (OtherType)


state 73

  184 OtherType: UnionType .

    $default  reduce using rule 184 (OtherType)


state 74

  185 OtherType: VariantType .

    $default  reduce using rule 185 (OtherType)


state 75

  186 OtherType: InterfaceType .

    $default  reduce using rule 186 (OtherType)


state 76

   17 TopLevelDecl: FuncDecl .

    $default  reduce using rule 17 (TopLevelDecl)


state 77

  168 ConvType: FuncType .  ['(']
  206 FuncLitDecl: FuncType .  [error, BODY, '{']

    '('       reduce using rule 168 (ConvType)
    $default  reduce using rule 206 (FuncLitDecl)


state 78

  142 LBrace: . BODY
  143       | . '{'
  207 FuncLit: FuncLitDecl . LBrace StmtList '}'
  208        | FuncLitDecl . error

    error  shift, and go to state 185
    BODY   shift, and go to state 112
    '{'    shift, and go to state 113

    LBrace  go to state 186


state 79

  130 PrimaryExprNoParen: FuncLit .

    $default  reduce using rule 130 (PrimaryExprNoParen)


state 80

   18 TopLevelDecl: NonDclStmt .

    $default  reduce using rule 18 (TopLevelDecl)


state 81

   43 SimpleStmt: ExprList . '=' ExprList
   44           | ExprList . COLAS ExprList
  268 ExprList: ExprList . ',' Expr

    COLAS  shift, and go to state 187
    '='    shift, and go to state 188
    ','    shift, and go to state 189


state 82

    9 Import: IMPORT '(' ')' .

    $default  reduce using rule 9 (Import)


state 83

   13 ImportDeclList: ImportDecl .

    $default  reduce using rule 13 (ImportDeclList)


state 84

    8 Import: IMPORT '(' ImportDeclList . oSemi ')'
   14 ImportDeclList: ImportDeclList . ';' ImportDecl
  277 oSemi: .  [')']
  278      | . ';'

    ';'  shift, and go to state 190

    $default  reduce using rule 277 (oSemi)

    oSemi  go to state 191


state 85

   12 ImportDecl: '.' LITERAL .

    $default  reduce using rule 12 (ImportDecl)


state 86

   11 ImportDecl: Symbol LITERAL .

    $default  reduce using rule 11 (ImportDecl)


state 87

  147 oNewName: NewName .

    $default  reduce using rule 147 (oNewName)


state 88

  254 NonDclStmt: BREAK oNewName .

    $default  reduce using rule 254 (NonDclStmt)


state 89

  144 NewName: Symbol .

    $default  reduce using rule 144 (NewName)


state 90

  148 Symbol: . IDENT
  149 Name: . Symbol
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  181          | CHAN COMM . Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    Symbol         go to state 94
    Name           go to state 95
    Type           go to state 194
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199


state 91

  200 FuncType: FUNC . '(' oArgTypeListOComma ')' FuncResult

    '('  shift, and go to state 200


state 92

  148 Symbol: . IDENT
  149 Name: . Symbol
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  167 NonRecvChanType: '(' . Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    Symbol         go to state 94
    Name           go to state 95
    Type           go to state 201
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199


state 93

  148 Symbol: . IDENT
  149 Name: . Symbol
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  187        | '*' . Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    Symbol         go to state 94
    Name           go to state 95
    Type           go to state 202
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199


state 94

  149 Name: Symbol .

    $default  reduce using rule 149 (Name)


state 95

  176 TypeName: Name .  [error, BODY, CASE, COLAS, DDD, DEFAULT, LITERAL, '(', ')', ':', ';', '=', '{', '}', ']', ',']
  177         | Name . '.' Symbol

    '.'  shift, and go to state 203

    $default  reduce using rule 176 (TypeName)


state 96

  180 OtherType: CHAN NonRecvChanType .

    $default  reduce using rule 180 (OtherType)


state 97

  166 NonRecvChanType: TypeName .

    $default  reduce using rule 166 (NonRecvChanType)


state 98

  164 NonRecvChanType: OtherType .

    $default  reduce using rule 164 (NonRecvChanType)


state 99

  165 NonRecvChanType: PtrType .

    $default  reduce using rule 165 (NonRecvChanType)


state 100

  163 NonRecvChanType: FuncType .

    $default  reduce using rule 163 (NonRecvChanType)


state 101

  112 UnaryExpr: COMM UnaryExpr .

    $default  reduce using rule 112 (UnaryExpr)


state 102

  255 NonDclStmt: CONTINUE oNewName .

    $default  reduce using rule 255 (NonDclStmt)


state 103

  124 PrimaryExprNoParen: PseudoCall .  ['(', '.', '[', '{']
  257 NonDclStmt: DEFER PseudoCall .  [CASE, DEFAULT, ';', '}']

    CASE      reduce using rule 257 (NonDclStmt)
    DEFAULT   reduce using rule 257 (NonDclStmt)
    ';'       reduce using rule 257 (NonDclStmt)
    '}'       reduce using rule 257 (NonDclStmt)
    $default  reduce using rule 124 (PrimaryExprNoParen)


state 104

  113 PseudoCall: PrimaryExpr . '(' ')'
  114           | PrimaryExpr . '(' ExprOrTypeList oComma ')'
  115           | PrimaryExpr . '(' ExprOrTypeList DDD oComma ')'
  118 PrimaryExprNoParen: PrimaryExpr . '.' Symbol
  119                   | PrimaryExpr . '.' '(' ExprOrType ')'
  120                   | PrimaryExpr . '.' '(' TYPE ')'
  121                   | PrimaryExpr . '[' Expr ']'
  122                   | PrimaryExpr . '[' oExpr ':' oExpr ']'
  123                   | PrimaryExpr . '[' oExpr ':' oExpr ':' oExpr ']'

    '('  shift, and go to state 179
    '.'  shift, and go to state 180
    '['  shift, and go to state 181


state 105

   41 SimpleStmt: . Expr
   42           | . Expr ASOP Expr
   43           | . ExprList '=' ExprList
   44           | . ExprList COLAS ExprList
   45           | . Expr INC
   46           | . Expr DEC
   59 RangeStmt: . ExprList '=' RANGE Expr
   60          | . ExprList COLAS RANGE Expr
   61 ForHeader: . oSimpleStmt ';' oSimpleStmt ';' oSimpleStmt
   62          | . oSimpleStmt
   63          | . RangeStmt
   64 ForBody: . ForHeader LoopBody
   66 ForStmt: FOR $@5 . ForBody
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  267 ExprList: . Expr
  268         | . ExprList ',' Expr
  285 oSimpleStmt: .  [BODY, ';']
  286            | . SimpleStmt

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    $default  reduce using rule 285 (oSimpleStmt)

    SimpleStmt          go to state 204
    RangeStmt           go to state 205
    ForHeader           go to state 206
    ForBody             go to state 207
    Expr                go to state 60
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprList            go to state 208
    oSimpleStmt         go to state 209


state 106

  141 NameOrType: . Type
  148 Symbol: . IDENT
  149 Name: . Symbol
  151 Ddd: . DDD
  152    | . DDD Type
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  199 FuncDecl1: '(' . oArgTypeListOComma ')' Symbol '(' oArgTypeListOComma ')' FuncResult
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  200         | FUNC '(' . oArgTypeListOComma ')' FuncResult
  234 ArgType: . NameOrType
  235        | . Symbol NameOrType
  236        | . Symbol Ddd
  237        | . Ddd
  238 ArgTypeList: . ArgType
  239            | . ArgTypeList ',' ArgType
  240 oArgTypeListOComma: .  [')']
  241                   | . ArgTypeList oComma

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    DDD        shift, and go to state 210
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    $default  reduce using rule 240 (oArgTypeListOComma)

    NameOrType          go to state 211
    Symbol              go to state 212
    Name                go to state 95
    Ddd                 go to state 213
    Type                go to state 214
    TypeName            go to state 195
    OtherType           go to state 196
    PtrType             go to state 197
    RecvChanType        go to state 198
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 199
    ArgType             go to state 215
    ArgTypeList         go to state 216
    oArgTypeListOComma  go to state 217


state 107

  198 FuncDecl1: Symbol . '(' oArgTypeListOComma ')' FuncResult

    '('  shift, and go to state 218


state 108

  197 FuncDecl: FUNC FuncDecl1 . FuncBody
  201 FuncBody: .  [';']
  202         | . '{' StmtList '}'

    '{'  shift, and go to state 219

    $default  reduce using rule 201 (FuncBody)

    FuncBody  go to state 220


state 109

  124 PrimaryExprNoParen: PseudoCall .  ['(', '.', '[', '{']
  256 NonDclStmt: GO PseudoCall .  [CASE, DEFAULT, ';', '}']

    CASE      reduce using rule 256 (NonDclStmt)
    DEFAULT   reduce using rule 256 (NonDclStmt)
    ';'       reduce using rule 256 (NonDclStmt)
    '}'       reduce using rule 256 (NonDclStmt)
    $default  reduce using rule 124 (PrimaryExprNoParen)


state 110

  258 NonDclStmt: GOTO NewName .

    $default  reduce using rule 258 (NonDclStmt)


state 111

   41 SimpleStmt: . Expr
   42           | . Expr ASOP Expr
   43           | . ExprList '=' ExprList
   44           | . ExprList COLAS ExprList
   45           | . Expr INC
   46           | . Expr DEC
   67 IfHeader: . oSimpleStmt
   68         | . oSimpleStmt ';' oSimpleStmt
   71 IfStmt: IF $@6 . IfHeader LoopBody $@7 ElseIfList Else
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  267 ExprList: . Expr
  268         | . ExprList ',' Expr
  285 oSimpleStmt: .  [BODY, ';']
  286            | . SimpleStmt

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    $default  reduce using rule 285 (oSimpleStmt)

    SimpleStmt          go to state 204
    IfHeader            go to state 221
    Expr                go to state 60
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprList            go to state 81
    oSimpleStmt         go to state 222


state 112

  142 LBrace: BODY .

    $default  reduce using rule 142 (LBrace)


state 113

  143 LBrace: '{' .

    $default  reduce using rule 143 (LBrace)


state 114

  144 NewName: . Symbol
  148 Symbol: . IDENT
  195 InterfaceType: INTERFACE LBrace . InterfaceDeclList oSemi '}'
  196              | INTERFACE LBrace . '}'
  219 InterfaceDeclList: . InterfaceDecl
  220                  | . InterfaceDeclList ';' InterfaceDecl
  227 Qualident: . IDENT
  228          | . IDENT '.' Symbol
  230 InterfaceDecl: . NewName InterfaceMethodDecl
  231              | . Qualident
  232              | . '(' Qualident ')'

    IDENT  shift, and go to state 223
    '('    shift, and go to state 224
    '}'    shift, and go to state 225

    NewName            go to state 226
    Symbol             go to state 89
    InterfaceDeclList  go to state 227
    Qualident          go to state 228
    InterfaceDecl      go to state 229


state 115

  148 Symbol: . IDENT
  149 Name: . Symbol
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  182          | MAP '[' . Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    Symbol         go to state 94
    Name           go to state 95
    Type           go to state 230
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199


state 116

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr
  267 ExprList: Expr .  [BODY, CASE, DEFAULT, ')', ';', '}', ',']

    ANDAND  shift, and go to state 155
    ANDNOT  shift, and go to state 156
    COMM    shift, and go to state 158
    EQ      shift, and go to state 160
    GE      shift, and go to state 161
    LE      shift, and go to state 163
    LSH     shift, and go to state 164
    NE      shift, and go to state 165
    OROR    shift, and go to state 166
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '<'     shift, and go to state 174
    '>'     shift, and go to state 175
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    $default  reduce using rule 267 (ExprList)


state 117

  268 ExprList: ExprList . ',' Expr
  284 oExprList: ExprList .  [CASE, DEFAULT, ';', '}']

    ','  shift, and go to state 189

    $default  reduce using rule 284 (oExprList)


state 118

  260 NonDclStmt: RETURN oExprList .

    $default  reduce using rule 260 (NonDclStmt)


state 119

   82 SelectStmt: SELECT $@11 . BODY CaseBlockList '}'

    BODY  shift, and go to state 231


state 120

  144 NewName: . Symbol
  148 Symbol: . IDENT
  189 StructType: STRUCT LBrace . StructDeclList oSemi '}'
  190           | STRUCT LBrace . '}'
  217 StructDeclList: . StructDecl
  218               | . StructDeclList ';' StructDecl
  221 StructDecl: . NewNameList Type oLiteral
  222           | . Embedded oLiteral
  223           | . '(' Embedded ')' oLiteral
  224           | . '*' Embedded oLiteral
  225           | . '(' '*' Embedded ')' oLiteral
  226           | . '*' '(' Embedded ')' oLiteral
  227 Qualident: . IDENT
  228          | . IDENT '.' Symbol
  229 Embedded: . Qualident
  263 NewNameList: . NewName
  264            | . NewNameList ',' NewName

    IDENT  shift, and go to state 223
    '('    shift, and go to state 232
    '*'    shift, and go to state 233
    '}'    shift, and go to state 234

    NewName         go to state 235
    Symbol          go to state 89
    StructDeclList  go to state 236
    StructDecl      go to state 237
    Qualident       go to state 238
    Embedded        go to state 239
    NewNameList     go to state 240


state 121

   41 SimpleStmt: . Expr
   42           | . Expr ASOP Expr
   43           | . ExprList '=' ExprList
   44           | . ExprList COLAS ExprList
   45           | . Expr INC
   46           | . Expr DEC
   67 IfHeader: . oSimpleStmt
   68         | . oSimpleStmt ';' oSimpleStmt
   80 SwitchStmt: SWITCH $@10 . IfHeader BODY CaseBlockList '}'
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  267 ExprList: . Expr
  268         | . ExprList ',' Expr
  285 oSimpleStmt: .  [BODY, ';']
  286            | . SimpleStmt

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    $default  reduce using rule 285 (oSimpleStmt)

    SimpleStmt          go to state 204
    IfHeader            go to state 241
    Expr                go to state 60
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprList            go to state 81
    oSimpleStmt         go to state 222


state 122

   28 CommonDecl: TYPE '(' . TypeDeclList oSemi ')'
   29           | TYPE '(' . ')'
   39 TypeDeclName: . Symbol
   40 TypeDecl: . TypeDeclName Type
  148 Symbol: . IDENT
  215 TypeDeclList: . TypeDecl
  216             | . TypeDeclList ';' TypeDecl

    IDENT  shift, and go to state 4
    ')'    shift, and go to state 242

    TypeDeclName  go to state 123
    TypeDecl      go to state 243
    Symbol        go to state 125
    TypeDeclList  go to state 244


state 123

   40 TypeDecl: TypeDeclName . Type
  148 Symbol: . IDENT
  149 Name: . Symbol
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    Symbol         go to state 94
    Name           go to state 95
    Type           go to state 245
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199


state 124

   27 CommonDecl: TYPE TypeDecl .

    $default  reduce using rule 27 (CommonDecl)


state 125

   39 TypeDeclName: Symbol .

    $default  reduce using rule 39 (TypeDeclName)


state 126

  144 NewName: . Symbol
  148 Symbol: . IDENT
  191 UnionType: UNION LBrace . StructDeclList oSemi '}'
  192          | UNION LBrace . '}'
  217 StructDeclList: . StructDecl
  218               | . StructDeclList ';' StructDecl
  221 StructDecl: . NewNameList Type oLiteral
  222           | . Embedded oLiteral
  223           | . '(' Embedded ')' oLiteral
  224           | . '*' Embedded oLiteral
  225           | . '(' '*' Embedded ')' oLiteral
  226           | . '*' '(' Embedded ')' oLiteral
  227 Qualident: . IDENT
  228          | . IDENT '.' Symbol
  229 Embedded: . Qualident
  263 NewNameList: . NewName
  264            | . NewNameList ',' NewName

    IDENT  shift, and go to state 223
    '('    shift, and go to state 232
    '*'    shift, and go to state 233
    '}'    shift, and go to state 246

    NewName         go to state 235
    Symbol          go to state 89
    StructDeclList  go to state 247
    StructDecl      go to state 237
    Qualident       go to state 238
    Embedded        go to state 239
    NewNameList     go to state 240


state 127

   21 CommonDecl: VAR '(' . VarDeclList oSemi ')'
   22           | VAR '(' . ')'
   31 VarDecl: . DeclNameList Type
   32        | . DeclNameList Type '=' ExprList
   33        | . DeclNameList '=' ExprList
  145 DeclName: . Symbol
  148 Symbol: . IDENT
  211 VarDeclList: . VarDecl
  212            | . VarDeclList ';' VarDecl
  265 DeclNameList: . DeclName
  266             | . DeclNameList ',' DeclName

    IDENT  shift, and go to state 4
    ')'    shift, and go to state 248

    VarDecl       go to state 249
    DeclName      go to state 129
    Symbol        go to state 130
    VarDeclList   go to state 250
    DeclNameList  go to state 131


state 128

   20 CommonDecl: VAR VarDecl .

    $default  reduce using rule 20 (CommonDecl)


state 129

  265 DeclNameList: DeclName .

    $default  reduce using rule 265 (DeclNameList)


state 130

  145 DeclName: Symbol .

    $default  reduce using rule 145 (DeclName)


state 131

   31 VarDecl: DeclNameList . Type
   32        | DeclNameList . Type '=' ExprList
   33        | DeclNameList . '=' ExprList
  148 Symbol: . IDENT
  149 Name: . Symbol
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  266 DeclNameList: DeclNameList . ',' DeclName

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '='        shift, and go to state 251
    '['        shift, and go to state 49
    ','        shift, and go to state 252

    Symbol         go to state 94
    Name           go to state 95
    Type           go to state 253
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199


state 132

  144 NewName: . Symbol
  148 Symbol: . IDENT
  193 VariantType: VARIANT LBrace . StructDeclList oSemi '}'
  194            | VARIANT LBrace . '}'
  217 StructDeclList: . StructDecl
  218               | . StructDeclList ';' StructDecl
  221 StructDecl: . NewNameList Type oLiteral
  222           | . Embedded oLiteral
  223           | . '(' Embedded ')' oLiteral
  224           | . '*' Embedded oLiteral
  225           | . '(' '*' Embedded ')' oLiteral
  226           | . '*' '(' Embedded ')' oLiteral
  227 Qualident: . IDENT
  228          | . IDENT '.' Symbol
  229 Embedded: . Qualident
  263 NewNameList: . NewName
  264            | . NewNameList ',' NewName

    IDENT  shift, and go to state 223
    '('    shift, and go to state 232
    '*'    shift, and go to state 233
    '}'    shift, and go to state 254

    NewName         go to state 235
    Symbol          go to state 89
    StructDeclList  go to state 255
    StructDecl      go to state 237
    Qualident       go to state 238
    Embedded        go to state 239
    NewNameList     go to state 240


state 133

  109 UnaryExpr: '!' UnaryExpr .

    $default  reduce using rule 109 (UnaryExpr)


state 134

  106 UnaryExpr: '&' UnaryExpr .

    $default  reduce using rule 106 (UnaryExpr)


state 135

  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  112          | COMM . UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  188 RecvChanType: COMM . CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 256
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    UnaryExpr           go to state 101
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 136

  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  105          | '*' . UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  159 NonExprType: . RecvChanType
  160            | . FuncType
  161            | . OtherType
  162            | . '*' NonExprType
  162            | '*' . NonExprType
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 135
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 136
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    UnaryExpr           go to state 143
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    NonExprType         go to state 257
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 140
    RecvChanType        go to state 141
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 142
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 137

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr
  139 ExprOrType: Expr .  [COLAS, DDD, ')', ':', '=', ',']

    ANDAND  shift, and go to state 155
    ANDNOT  shift, and go to state 156
    COMM    shift, and go to state 158
    EQ      shift, and go to state 160
    GE      shift, and go to state 161
    LE      shift, and go to state 163
    LSH     shift, and go to state 164
    NE      shift, and go to state 165
    OROR    shift, and go to state 166
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '<'     shift, and go to state 174
    '>'     shift, and go to state 175
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    $default  reduce using rule 139 (ExprOrType)


state 138

  129 PrimaryExprNoParen: '(' ExprOrType . ')' '{' StartCompLit BracedKeyvalList '}'
  138 PrimaryExpr: '(' ExprOrType . ')'

    ')'  shift, and go to state 258


state 139

  140 ExprOrType: NonExprType .

    $default  reduce using rule 140 (ExprOrType)


state 140

  161 NonExprType: OtherType .  [COLAS, DDD, ')', ':', '=', ',']
  169 ConvType: OtherType .  ['(']
  170 CompLitType: OtherType .  [BODY, '{']

    BODY      reduce using rule 170 (CompLitType)
    '('       reduce using rule 169 (ConvType)
    '{'       reduce using rule 170 (CompLitType)
    $default  reduce using rule 161 (NonExprType)


state 141

  159 NonExprType: RecvChanType .

    $default  reduce using rule 159 (NonExprType)


state 142

  160 NonExprType: FuncType .  [COLAS, DDD, ')', ':', '=', ',']
  168 ConvType: FuncType .  ['(']
  206 FuncLitDecl: FuncType .  [error, BODY, '{']

    error     reduce using rule 206 (FuncLitDecl)
    BODY      reduce using rule 206 (FuncLitDecl)
    '('       reduce using rule 168 (ConvType)
    '{'       reduce using rule 206 (FuncLitDecl)
    $default  reduce using rule 160 (NonExprType)


state 143

  105 UnaryExpr: '*' UnaryExpr .

    $default  reduce using rule 105 (UnaryExpr)


state 144

  107 UnaryExpr: '+' UnaryExpr .

    $default  reduce using rule 107 (UnaryExpr)


state 145

  108 UnaryExpr: '-' UnaryExpr .

    $default  reduce using rule 108 (UnaryExpr)


state 146

  179 OtherType: '[' DDD . ']' Type

    ']'  shift, and go to state 259


state 147

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr
  282 oExpr: Expr .  [':', ']']

    ANDAND  shift, and go to state 155
    ANDNOT  shift, and go to state 156
    COMM    shift, and go to state 158
    EQ      shift, and go to state 160
    GE      shift, and go to state 161
    LE      shift, and go to state 163
    LSH     shift, and go to state 164
    NE      shift, and go to state 165
    OROR    shift, and go to state 166
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '<'     shift, and go to state 174
    '>'     shift, and go to state 175
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    $default  reduce using rule 282 (oExpr)


state 148

  178 OtherType: '[' oExpr . ']' Type

    ']'  shift, and go to state 260


state 149

  111 UnaryExpr: '^' UnaryExpr .

    $default  reduce using rule 111 (UnaryExpr)


state 150

  110 UnaryExpr: '~' UnaryExpr .

    $default  reduce using rule 110 (UnaryExpr)


state 151

  210 TopLevelDeclList: TopLevelDeclList TopLevelDecl ';' .

    $default  reduce using rule 210 (TopLevelDeclList)


state 152

   24 CommonDecl: Const '(' . ConstDecl oSemi ')'
   25           | Const '(' . ConstDecl ';' ConstDeclList oSemi ')'
   26           | Const '(' . ')'
   34 ConstDecl: . DeclNameList Type '=' ExprList
   35          | . DeclNameList '=' ExprList
  145 DeclName: . Symbol
  148 Symbol: . IDENT
  265 DeclNameList: . DeclName
  266             | . DeclNameList ',' DeclName

    IDENT  shift, and go to state 4
    ')'    shift, and go to state 261

    ConstDecl     go to state 262
    DeclName      go to state 129
    Symbol        go to state 130
    DeclNameList  go to state 154


state 153

   23 CommonDecl: Const ConstDecl .

    $default  reduce using rule 23 (CommonDecl)


state 154

   34 ConstDecl: DeclNameList . Type '=' ExprList
   35          | DeclNameList . '=' ExprList
  148 Symbol: . IDENT
  149 Name: . Symbol
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  266 DeclNameList: DeclNameList . ',' DeclName

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '='        shift, and go to state 263
    '['        shift, and go to state 49
    ','        shift, and go to state 252

    Symbol         go to state 94
    Name           go to state 95
    Type           go to state 264
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199


state 155

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   85     | Expr ANDAND . Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 265
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 156

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  100     | Expr ANDNOT . Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 266
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 157

   42 SimpleStmt: Expr ASOP . Expr
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 267
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 158

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  103     | Expr COMM . Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 268
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 159

   46 SimpleStmt: Expr DEC .

    $default  reduce using rule 46 (SimpleStmt)


state 160

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   86     | Expr EQ . Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 269
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 161

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   90     | Expr GE . Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 270
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 162

   45 SimpleStmt: Expr INC .

    $default  reduce using rule 45 (SimpleStmt)


state 163

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   89     | Expr LE . Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 271
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 164

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  101     | Expr LSH . Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 272
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 165

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   87     | Expr NE . Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 273
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 166

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   84     | Expr OROR . Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 274
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 167

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  102     | Expr RSH . Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 275
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 168

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   98     | Expr '%' . Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 276
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 169

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
   99     | Expr '&' . Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 277
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 170

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   96     | Expr '*' . Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 278
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 171

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   92     | Expr '+' . Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 279
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 172

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   93     | Expr '-' . Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 280
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 173

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   97     | Expr '/' . Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 281
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 174

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   88     | Expr '<' . Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 282
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 175

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   91     | Expr '>' . Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 283
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 176

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   95     | Expr '^' . Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 284
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 177

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   94     | Expr '|' . Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 285
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 178

  128 PrimaryExprNoParen: PrimaryExprNoParen '{' . StartCompLit BracedKeyvalList '}'
  131 StartCompLit: .

    $default  reduce using rule 131 (StartCompLit)

    StartCompLit  go to state 286


state 179

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  113           | PrimaryExpr '(' . ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  114           | PrimaryExpr '(' . ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  115           | PrimaryExpr '(' . ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  139 ExprOrType: . Expr
  140           | . NonExprType
  148 Symbol: . IDENT
  149 Name: . Symbol
  159 NonExprType: . RecvChanType
  160            | . FuncType
  161            | . OtherType
  162            | . '*' NonExprType
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  269 ExprOrTypeList: . ExprOrType
  270               | . ExprOrTypeList ',' ExprOrType

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 135
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    ')'        shift, and go to state 287
    '*'        shift, and go to state 136
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 137
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    ExprOrType          go to state 288
    Symbol              go to state 94
    Name                go to state 67
    NonExprType         go to state 139
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 140
    RecvChanType        go to state 141
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 142
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprOrTypeList      go to state 289


state 180

  118 PrimaryExprNoParen: PrimaryExpr '.' . Symbol
  119                   | PrimaryExpr '.' . '(' ExprOrType ')'
  120                   | PrimaryExpr '.' . '(' TYPE ')'
  148 Symbol: . IDENT

    IDENT  shift, and go to state 4
    '('    shift, and go to state 290

    Symbol  go to state 291


state 181

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  121                   | PrimaryExpr '[' . Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  122                   | PrimaryExpr '[' . oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  123                   | PrimaryExpr '[' . oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  281 oExpr: .  [':']
  282      | . Expr

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    $default  reduce using rule 281 (oExpr)

    Expr                go to state 292
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    oExpr               go to state 293


state 182

   20 CommonDecl: . VAR VarDecl
   21           | . VAR '(' VarDeclList oSemi ')'
   22           | . VAR '(' ')'
   23           | . Const ConstDecl
   24           | . Const '(' ConstDecl oSemi ')'
   25           | . Const '(' ConstDecl ';' ConstDeclList oSemi ')'
   26           | . Const '(' ')'
   27           | . TYPE TypeDecl
   28           | . TYPE '(' TypeDeclList oSemi ')'
   29           | . TYPE '(' ')'
   30 Const: . CONST
   41 SimpleStmt: . Expr
   42           | . Expr ASOP Expr
   43           | . ExprList '=' ExprList
   44           | . ExprList COLAS ExprList
   45           | . Expr INC
   46           | . Expr DEC
   52 CompoundStmt: . '{' $@2 StmtList '}'
   66 ForStmt: . FOR $@5 ForBody
   71 IfStmt: . IF $@6 IfHeader LoopBody $@7 ElseIfList Else
   80 SwitchStmt: . SWITCH $@10 IfHeader BODY CaseBlockList '}'
   82 SelectStmt: . SELECT $@11 BODY CaseBlockList '}'
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  144 NewName: . Symbol
  148 Symbol: . IDENT
  149 Name: . Symbol
  150 LabelName: . NewName
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  242 Statement: .  [CASE, DEFAULT, ';', '}']
  243          | . CompoundStmt
  244          | . CommonDecl
  245          | . NonDclStmt
  246          | . error
  247 NonDclStmt: . SimpleStmt
  248           | . ForStmt
  249           | . SwitchStmt
  250           | . SelectStmt
  251           | . IfStmt
  252           | . LabelName ':' Statement
  252           | LabelName ':' . Statement
  253           | . FALL
  254           | . BREAK oNewName
  255           | . CONTINUE oNewName
  256           | . GO PseudoCall
  257           | . DEFER PseudoCall
  258           | . GOTO NewName
  259           | . GOTO
  260           | . RETURN oExprList
  267 ExprList: . Expr
  268         | . ExprList ',' Expr

    error      shift, and go to state 294
    BREAK      shift, and go to state 20
    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    CONST      shift, and go to state 23
    CONTINUE   shift, and go to state 24
    DEFER      shift, and go to state 25
    FALL       shift, and go to state 26
    FOR        shift, and go to state 27
    FUNC       shift, and go to state 91
    GO         shift, and go to state 29
    GOTO       shift, and go to state 30
    IDENT      shift, and go to state 4
    IF         shift, and go to state 31
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    RETURN     shift, and go to state 35
    SELECT     shift, and go to state 36
    STRUCT     shift, and go to state 37
    SWITCH     shift, and go to state 38
    TYPE       shift, and go to state 39
    UNION      shift, and go to state 40
    VAR        shift, and go to state 41
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '{'        shift, and go to state 295
    '~'        shift, and go to state 51

    CASE     reduce using rule 242 (Statement)
    DEFAULT  reduce using rule 242 (Statement)
    ';'      reduce using rule 242 (Statement)
    '}'      reduce using rule 242 (Statement)

    CommonDecl          go to state 296
    Const               go to state 54
    SimpleStmt          go to state 55
    CompoundStmt        go to state 297
    ForStmt             go to state 56
    IfStmt              go to state 57
    SwitchStmt          go to state 58
    SelectStmt          go to state 59
    Expr                go to state 60
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    NewName             go to state 65
    Symbol              go to state 66
    Name                go to state 67
    LabelName           go to state 68
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    Statement           go to state 298
    NonDclStmt          go to state 299
    ExprList            go to state 81


state 183

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  125                   | ConvType '(' . ExprList oComma ')'
  126                   | . ConvType '(' ')'
  126                   | ConvType '(' . ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  267 ExprList: . Expr
  268         | . ExprList ',' Expr

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    ')'        shift, and go to state 300
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 116
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprList            go to state 301


state 184

  127 PrimaryExprNoParen: CompLitType LBrace . StartCompLit BracedKeyvalList '}'
  131 StartCompLit: .

    $default  reduce using rule 131 (StartCompLit)

    StartCompLit  go to state 302


state 185

  208 FuncLit: FuncLitDecl error .

    $default  reduce using rule 208 (FuncLit)


state 186

   20 CommonDecl: . VAR VarDecl
   21           | . VAR '(' VarDeclList oSemi ')'
   22           | . VAR '(' ')'
   23           | . Const ConstDecl
   24           | . Const '(' ConstDecl oSemi ')'
   25           | . Const '(' ConstDecl ';' ConstDeclList oSemi ')'
   26           | . Const '(' ')'
   27           | . TYPE TypeDecl
   28           | . TYPE '(' TypeDeclList oSemi ')'
   29           | . TYPE '(' ')'
   30 Const: . CONST
   41 SimpleStmt: . Expr
   42           | . Expr ASOP Expr
   43           | . ExprList '=' ExprList
   44           | . ExprList COLAS ExprList
   45           | . Expr INC
   46           | . Expr DEC
   52 CompoundStmt: . '{' $@2 StmtList '}'
   66 ForStmt: . FOR $@5 ForBody
   71 IfStmt: . IF $@6 IfHeader LoopBody $@7 ElseIfList Else
   80 SwitchStmt: . SWITCH $@10 IfHeader BODY CaseBlockList '}'
   82 SelectStmt: . SELECT $@11 BODY CaseBlockList '}'
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  144 NewName: . Symbol
  148 Symbol: . IDENT
  149 Name: . Symbol
  150 LabelName: . NewName
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  207        | FuncLitDecl LBrace . StmtList '}'
  208        | . FuncLitDecl error
  242 Statement: .  [';', '}']
  243          | . CompoundStmt
  244          | . CommonDecl
  245          | . NonDclStmt
  246          | . error
  247 NonDclStmt: . SimpleStmt
  248           | . ForStmt
  249           | . SwitchStmt
  250           | . SelectStmt
  251           | . IfStmt
  252           | . LabelName ':' Statement
  253           | . FALL
  254           | . BREAK oNewName
  255           | . CONTINUE oNewName
  256           | . GO PseudoCall
  257           | . DEFER PseudoCall
  258           | . GOTO NewName
  259           | . GOTO
  260           | . RETURN oExprList
  261 StmtList: . Statement
  262         | . StmtList ';' Statement
  267 ExprList: . Expr
  268         | . ExprList ',' Expr

    error      shift, and go to state 294
    BREAK      shift, and go to state 20
    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    CONST      shift, and go to state 23
    CONTINUE   shift, and go to state 24
    DEFER      shift, and go to state 25
    FALL       shift, and go to state 26
    FOR        shift, and go to state 27
    FUNC       shift, and go to state 91
    GO         shift, and go to state 29
    GOTO       shift, and go to state 30
    IDENT      shift, and go to state 4
    IF         shift, and go to state 31
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    RETURN     shift, and go to state 35
    SELECT     shift, and go to state 36
    STRUCT     shift, and go to state 37
    SWITCH     shift, and go to state 38
    TYPE       shift, and go to state 39
    UNION      shift, and go to state 40
    VAR        shift, and go to state 41
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '{'        shift, and go to state 295
    '~'        shift, and go to state 51

    ';'  reduce using rule 242 (Statement)
    '}'  reduce using rule 242 (Statement)

    CommonDecl          go to state 296
    Const               go to state 54
    SimpleStmt          go to state 55
    CompoundStmt        go to state 297
    ForStmt             go to state 56
    IfStmt              go to state 57
    SwitchStmt          go to state 58
    SelectStmt          go to state 59
    Expr                go to state 60
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    NewName             go to state 65
    Symbol              go to state 66
    Name                go to state 67
    LabelName           go to state 68
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    Statement           go to state 303
    NonDclStmt          go to state 299
    StmtList            go to state 304
    ExprList            go to state 81


state 187

   44 SimpleStmt: ExprList COLAS . ExprList
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  267 ExprList: . Expr
  268         | . ExprList ',' Expr

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 116
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprList            go to state 305


state 188

   43 SimpleStmt: ExprList '=' . ExprList
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  267 ExprList: . Expr
  268         | . ExprList ',' Expr

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 116
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprList            go to state 306


state 189

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  268 ExprList: ExprList ',' . Expr

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 307
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 190

   10 ImportDecl: . LITERAL
   11           | . Symbol LITERAL
   12           | . '.' LITERAL
   14 ImportDeclList: ImportDeclList ';' . ImportDecl
  148 Symbol: . IDENT
  278 oSemi: ';' .  [')']

    IDENT    shift, and go to state 4
    LITERAL  shift, and go to state 13
    '.'      shift, and go to state 15

    $default  reduce using rule 278 (oSemi)

    ImportDecl  go to state 308
    Symbol      go to state 17


state 191

    8 Import: IMPORT '(' ImportDeclList oSemi . ')'

    ')'  shift, and go to state 309


state 192

  188 RecvChanType: COMM . CHAN Type

    CHAN  shift, and go to state 310


state 193

  148 Symbol: . IDENT
  149 Name: . Symbol
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  158     | '(' . Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    Symbol         go to state 94
    Name           go to state 95
    Type           go to state 311
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199


state 194

  181 OtherType: CHAN COMM Type .

    $default  reduce using rule 181 (OtherType)


state 195

  157 Type: TypeName .

    $default  reduce using rule 157 (Type)


state 196

  155 Type: OtherType .

    $default  reduce using rule 155 (Type)


state 197

  156 Type: PtrType .

    $default  reduce using rule 156 (Type)


state 198

  153 Type: RecvChanType .

    $default  reduce using rule 153 (Type)


state 199

  154 Type: FuncType .

    $default  reduce using rule 154 (Type)


state 200

  141 NameOrType: . Type
  148 Symbol: . IDENT
  149 Name: . Symbol
  151 Ddd: . DDD
  152    | . DDD Type
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  200         | FUNC '(' . oArgTypeListOComma ')' FuncResult
  234 ArgType: . NameOrType
  235        | . Symbol NameOrType
  236        | . Symbol Ddd
  237        | . Ddd
  238 ArgTypeList: . ArgType
  239            | . ArgTypeList ',' ArgType
  240 oArgTypeListOComma: .  [')']
  241                   | . ArgTypeList oComma

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    DDD        shift, and go to state 210
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    $default  reduce using rule 240 (oArgTypeListOComma)

    NameOrType          go to state 211
    Symbol              go to state 212
    Name                go to state 95
    Ddd                 go to state 213
    Type                go to state 214
    TypeName            go to state 195
    OtherType           go to state 196
    PtrType             go to state 197
    RecvChanType        go to state 198
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 199
    ArgType             go to state 215
    ArgTypeList         go to state 216
    oArgTypeListOComma  go to state 312


state 201

  167 NonRecvChanType: '(' Type . ')'

    ')'  shift, and go to state 313


state 202

  187 PtrType: '*' Type .

    $default  reduce using rule 187 (PtrType)


state 203

  148 Symbol: . IDENT
  177 TypeName: Name '.' . Symbol

    IDENT  shift, and go to state 4

    Symbol  go to state 314


state 204

  286 oSimpleStmt: SimpleStmt .

    $default  reduce using rule 286 (oSimpleStmt)


state 205

   63 ForHeader: RangeStmt .

    $default  reduce using rule 63 (ForHeader)


state 206

   58 LoopBody: . BODY $@4 StmtList '}'
   64 ForBody: ForHeader . LoopBody

    BODY  shift, and go to state 315

    LoopBody  go to state 316


state 207

   66 ForStmt: FOR $@5 ForBody .

    $default  reduce using rule 66 (ForStmt)


state 208

   43 SimpleStmt: ExprList . '=' ExprList
   44           | ExprList . COLAS ExprList
   59 RangeStmt: ExprList . '=' RANGE Expr
   60          | ExprList . COLAS RANGE Expr
  268 ExprList: ExprList . ',' Expr

    COLAS  shift, and go to state 317
    '='    shift, and go to state 318
    ','    shift, and go to state 189


state 209

   61 ForHeader: oSimpleStmt . ';' oSimpleStmt ';' oSimpleStmt
   62          | oSimpleStmt .  [BODY]

    ';'  shift, and go to state 319

    $default  reduce using rule 62 (ForHeader)


state 210

  148 Symbol: . IDENT
  149 Name: . Symbol
  151 Ddd: DDD .  [')', ',']
  152    | DDD . Type
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    $default  reduce using rule 151 (Ddd)

    Symbol         go to state 94
    Name           go to state 95
    Type           go to state 320
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199


state 211

  234 ArgType: NameOrType .

    $default  reduce using rule 234 (ArgType)


state 212

  141 NameOrType: . Type
  148 Symbol: . IDENT
  149 Name: . Symbol
  149     | Symbol .  [')', '.', ',']
  151 Ddd: . DDD
  152    | . DDD Type
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  235 ArgType: Symbol . NameOrType
  236        | Symbol . Ddd

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    DDD        shift, and go to state 210
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    $default  reduce using rule 149 (Name)

    NameOrType     go to state 321
    Symbol         go to state 94
    Name           go to state 95
    Ddd            go to state 322
    Type           go to state 214
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199


state 213

  237 ArgType: Ddd .

    $default  reduce using rule 237 (ArgType)


state 214

  141 NameOrType: Type .

    $default  reduce using rule 141 (NameOrType)


state 215

  238 ArgTypeList: ArgType .

    $default  reduce using rule 238 (ArgTypeList)


state 216

  239 ArgTypeList: ArgTypeList . ',' ArgType
  241 oArgTypeListOComma: ArgTypeList . oComma
  279 oComma: .  [')']
  280       | . ','

    ','  shift, and go to state 323

    $default  reduce using rule 279 (oComma)

    oComma  go to state 324


state 217

  199 FuncDecl1: '(' oArgTypeListOComma . ')' Symbol '(' oArgTypeListOComma ')' FuncResult
  200 FuncType: FUNC '(' oArgTypeListOComma . ')' FuncResult

    ')'  shift, and go to state 325


state 218

  141 NameOrType: . Type
  148 Symbol: . IDENT
  149 Name: . Symbol
  151 Ddd: . DDD
  152    | . DDD Type
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  198 FuncDecl1: Symbol '(' . oArgTypeListOComma ')' FuncResult
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  234 ArgType: . NameOrType
  235        | . Symbol NameOrType
  236        | . Symbol Ddd
  237        | . Ddd
  238 ArgTypeList: . ArgType
  239            | . ArgTypeList ',' ArgType
  240 oArgTypeListOComma: .  [')']
  241                   | . ArgTypeList oComma

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    DDD        shift, and go to state 210
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    $default  reduce using rule 240 (oArgTypeListOComma)

    NameOrType          go to state 211
    Symbol              go to state 212
    Name                go to state 95
    Ddd                 go to state 213
    Type                go to state 214
    TypeName            go to state 195
    OtherType           go to state 196
    PtrType             go to state 197
    RecvChanType        go to state 198
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 199
    ArgType             go to state 215
    ArgTypeList         go to state 216
    oArgTypeListOComma  go to state 326


state 219

   20 CommonDecl: . VAR VarDecl
   21           | . VAR '(' VarDeclList oSemi ')'
   22           | . VAR '(' ')'
   23           | . Const ConstDecl
   24           | . Const '(' ConstDecl oSemi ')'
   25           | . Const '(' ConstDecl ';' ConstDeclList oSemi ')'
   26           | . Const '(' ')'
   27           | . TYPE TypeDecl
   28           | . TYPE '(' TypeDeclList oSemi ')'
   29           | . TYPE '(' ')'
   30 Const: . CONST
   41 SimpleStmt: . Expr
   42           | . Expr ASOP Expr
   43           | . ExprList '=' ExprList
   44           | . ExprList COLAS ExprList
   45           | . Expr INC
   46           | . Expr DEC
   52 CompoundStmt: . '{' $@2 StmtList '}'
   66 ForStmt: . FOR $@5 ForBody
   71 IfStmt: . IF $@6 IfHeader LoopBody $@7 ElseIfList Else
   80 SwitchStmt: . SWITCH $@10 IfHeader BODY CaseBlockList '}'
   82 SelectStmt: . SELECT $@11 BODY CaseBlockList '}'
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  144 NewName: . Symbol
  148 Symbol: . IDENT
  149 Name: . Symbol
  150 LabelName: . NewName
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  202 FuncBody: '{' . StmtList '}'
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  242 Statement: .  [';', '}']
  243          | . CompoundStmt
  244          | . CommonDecl
  245          | . NonDclStmt
  246          | . error
  247 NonDclStmt: . SimpleStmt
  248           | . ForStmt
  249           | . SwitchStmt
  250           | . SelectStmt
  251           | . IfStmt
  252           | . LabelName ':' Statement
  253           | . FALL
  254           | . BREAK oNewName
  255           | . CONTINUE oNewName
  256           | . GO PseudoCall
  257           | . DEFER PseudoCall
  258           | . GOTO NewName
  259           | . GOTO
  260           | . RETURN oExprList
  261 StmtList: . Statement
  262         | . StmtList ';' Statement
  267 ExprList: . Expr
  268         | . ExprList ',' Expr

    error      shift, and go to state 294
    BREAK      shift, and go to state 20
    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    CONST      shift, and go to state 23
    CONTINUE   shift, and go to state 24
    DEFER      shift, and go to state 25
    FALL       shift, and go to state 26
    FOR        shift, and go to state 27
    FUNC       shift, and go to state 91
    GO         shift, and go to state 29
    GOTO       shift, and go to state 30
    IDENT      shift, and go to state 4
    IF         shift, and go to state 31
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    RETURN     shift, and go to state 35
    SELECT     shift, and go to state 36
    STRUCT     shift, and go to state 37
    SWITCH     shift, and go to state 38
    TYPE       shift, and go to state 39
    UNION      shift, and go to state 40
    VAR        shift, and go to state 41
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '{'        shift, and go to state 295
    '~'        shift, and go to state 51

    ';'  reduce using rule 242 (Statement)
    '}'  reduce using rule 242 (Statement)

    CommonDecl          go to state 296
    Const               go to state 54
    SimpleStmt          go to state 55
    CompoundStmt        go to state 297
    ForStmt             go to state 56
    IfStmt              go to state 57
    SwitchStmt          go to state 58
    SelectStmt          go to state 59
    Expr                go to state 60
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    NewName             go to state 65
    Symbol              go to state 66
    Name                go to state 67
    LabelName           go to state 68
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    Statement           go to state 303
    NonDclStmt          go to state 299
    StmtList            go to state 327
    ExprList            go to state 81


state 220

  197 FuncDecl: FUNC FuncDecl1 FuncBody .

    $default  reduce using rule 197 (FuncDecl)


state 221

   58 LoopBody: . BODY $@4 StmtList '}'
   71 IfStmt: IF $@6 IfHeader . LoopBody $@7 ElseIfList Else

    BODY  shift, and go to state 315

    LoopBody  go to state 328


state 222

   67 IfHeader: oSimpleStmt .  [BODY]
   68         | oSimpleStmt . ';' oSimpleStmt

    ';'  shift, and go to state 329

    $default  reduce using rule 67 (IfHeader)


state 223

  148 Symbol: IDENT .  [CHAN, COMM, FUNC, IDENT, INTERFACE, MAP, STRUCT, UNION, VARIANT, '(', '*', '[', ',']
  227 Qualident: IDENT .  [LITERAL, ';', '}']
  228          | IDENT . '.' Symbol

    '.'  shift, and go to state 330

    LITERAL   reduce using rule 227 (Qualident)
    ';'       reduce using rule 227 (Qualident)
    '}'       reduce using rule 227 (Qualident)
    $default  reduce using rule 148 (Symbol)


state 224

  227 Qualident: . IDENT
  228          | . IDENT '.' Symbol
  232 InterfaceDecl: '(' . Qualident ')'

    IDENT  shift, and go to state 331

    Qualident  go to state 332


state 225

  196 InterfaceType: INTERFACE LBrace '}' .

    $default  reduce using rule 196 (InterfaceType)


state 226

  230 InterfaceDecl: NewName . InterfaceMethodDecl
  233 InterfaceMethodDecl: . '(' oArgTypeListOComma ')' FuncResult

    '('  shift, and go to state 333

    InterfaceMethodDecl  go to state 334


state 227

  195 InterfaceType: INTERFACE LBrace InterfaceDeclList . oSemi '}'
  220 InterfaceDeclList: InterfaceDeclList . ';' InterfaceDecl
  277 oSemi: .  ['}']
  278      | . ';'

    ';'  shift, and go to state 335

    $default  reduce using rule 277 (oSemi)

    oSemi  go to state 336


state 228

  231 InterfaceDecl: Qualident .

    $default  reduce using rule 231 (InterfaceDecl)


state 229

  219 InterfaceDeclList: InterfaceDecl .

    $default  reduce using rule 219 (InterfaceDeclList)


state 230

  182 OtherType: MAP '[' Type . ']' Type

    ']'  shift, and go to state 337


state 231

   55 CaseBlockList: .
   56              | . CaseBlockList CaseBlock
   82 SelectStmt: SELECT $@11 BODY . CaseBlockList '}'

    $default  reduce using rule 55 (CaseBlockList)

    CaseBlockList  go to state 338


state 232

  223 StructDecl: '(' . Embedded ')' oLiteral
  225           | '(' . '*' Embedded ')' oLiteral
  227 Qualident: . IDENT
  228          | . IDENT '.' Symbol
  229 Embedded: . Qualident

    IDENT  shift, and go to state 331
    '*'    shift, and go to state 339

    Qualident  go to state 238
    Embedded   go to state 340


state 233

  224 StructDecl: '*' . Embedded oLiteral
  226           | '*' . '(' Embedded ')' oLiteral
  227 Qualident: . IDENT
  228          | . IDENT '.' Symbol
  229 Embedded: . Qualident

    IDENT  shift, and go to state 331
    '('    shift, and go to state 341

    Qualident  go to state 238
    Embedded   go to state 342


state 234

  190 StructType: STRUCT LBrace '}' .

    $default  reduce using rule 190 (StructType)


state 235

  263 NewNameList: NewName .

    $default  reduce using rule 263 (NewNameList)


state 236

  189 StructType: STRUCT LBrace StructDeclList . oSemi '}'
  218 StructDeclList: StructDeclList . ';' StructDecl
  277 oSemi: .  ['}']
  278      | . ';'

    ';'  shift, and go to state 343

    $default  reduce using rule 277 (oSemi)

    oSemi  go to state 344


state 237

  217 StructDeclList: StructDecl .

    $default  reduce using rule 217 (StructDeclList)


state 238

  229 Embedded: Qualident .

    $default  reduce using rule 229 (Embedded)


state 239

  222 StructDecl: Embedded . oLiteral
  287 oLiteral: .  [';', '}']
  288         | . LITERAL

    LITERAL  shift, and go to state 345

    $default  reduce using rule 287 (oLiteral)

    oLiteral  go to state 346


state 240

  148 Symbol: . IDENT
  149 Name: . Symbol
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  221 StructDecl: NewNameList . Type oLiteral
  264 NewNameList: NewNameList . ',' NewName

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49
    ','        shift, and go to state 347

    Symbol         go to state 94
    Name           go to state 95
    Type           go to state 348
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199


state 241

   80 SwitchStmt: SWITCH $@10 IfHeader . BODY CaseBlockList '}'

    BODY  shift, and go to state 349


state 242

   29 CommonDecl: TYPE '(' ')' .

    $default  reduce using rule 29 (CommonDecl)


state 243

  215 TypeDeclList: TypeDecl .

    $default  reduce using rule 215 (TypeDeclList)


state 244

   28 CommonDecl: TYPE '(' TypeDeclList . oSemi ')'
  216 TypeDeclList: TypeDeclList . ';' TypeDecl
  277 oSemi: .  [')']
  278      | . ';'

    ';'  shift, and go to state 350

    $default  reduce using rule 277 (oSemi)

    oSemi  go to state 351


state 245

   40 TypeDecl: TypeDeclName Type .

    $default  reduce using rule 40 (TypeDecl)


state 246

  192 UnionType: UNION LBrace '}' .

    $default  reduce using rule 192 (UnionType)


state 247

  191 UnionType: UNION LBrace StructDeclList . oSemi '}'
  218 StructDeclList: StructDeclList . ';' StructDecl
  277 oSemi: .  ['}']
  278      | . ';'

    ';'  shift, and go to state 343

    $default  reduce using rule 277 (oSemi)

    oSemi  go to state 352


state 248

   22 CommonDecl: VAR '(' ')' .

    $default  reduce using rule 22 (CommonDecl)


state 249

  211 VarDeclList: VarDecl .

    $default  reduce using rule 211 (VarDeclList)


state 250

   21 CommonDecl: VAR '(' VarDeclList . oSemi ')'
  212 VarDeclList: VarDeclList . ';' VarDecl
  277 oSemi: .  [')']
  278      | . ';'

    ';'  shift, and go to state 353

    $default  reduce using rule 277 (oSemi)

    oSemi  go to state 354


state 251

   33 VarDecl: DeclNameList '=' . ExprList
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  267 ExprList: . Expr
  268         | . ExprList ',' Expr

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 116
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprList            go to state 355


state 252

  145 DeclName: . Symbol
  148 Symbol: . IDENT
  266 DeclNameList: DeclNameList ',' . DeclName

    IDENT  shift, and go to state 4

    DeclName  go to state 356
    Symbol    go to state 130


state 253

   31 VarDecl: DeclNameList Type .  [CASE, DEFAULT, ')', ';', '}']
   32        | DeclNameList Type . '=' ExprList

    '='  shift, and go to state 357

    $default  reduce using rule 31 (VarDecl)


state 254

  194 VariantType: VARIANT LBrace '}' .

    $default  reduce using rule 194 (VariantType)


state 255

  193 VariantType: VARIANT LBrace StructDeclList . oSemi '}'
  218 StructDeclList: StructDeclList . ';' StructDecl
  277 oSemi: .  ['}']
  278      | . ';'

    ';'  shift, and go to state 343

    $default  reduce using rule 277 (oSemi)

    oSemi  go to state 358


state 256

  148 Symbol: . IDENT
  149 Name: . Symbol
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  163 NonRecvChanType: . FuncType
  164                | . OtherType
  165                | . PtrType
  166                | . TypeName
  167                | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  180          | CHAN . NonRecvChanType
  181          | . CHAN COMM Type
  181          | CHAN . COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  188             | COMM CHAN . Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 359
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 360
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    Symbol           go to state 94
    Name             go to state 95
    Type             go to state 361
    NonRecvChanType  go to state 96
    TypeName         go to state 362
    OtherType        go to state 363
    PtrType          go to state 364
    RecvChanType     go to state 198
    StructType       go to state 72
    UnionType        go to state 73
    VariantType      go to state 74
    InterfaceType    go to state 75
    FuncType         go to state 365


state 257

  162 NonExprType: '*' NonExprType .

    $default  reduce using rule 162 (NonExprType)


state 258

  129 PrimaryExprNoParen: '(' ExprOrType ')' . '{' StartCompLit BracedKeyvalList '}'
  138 PrimaryExpr: '(' ExprOrType ')' .  [ANDAND, ANDNOT, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, LSH, NE, OROR, RSH, '%', '&', '(', ')', '*', '+', '-', '.', '/', ':', ';', '<', '=', '>', '[', '^', '|', '}', ']', ',']

    '{'  shift, and go to state 366

    $default  reduce using rule 138 (PrimaryExpr)


state 259

  148 Symbol: . IDENT
  149 Name: . Symbol
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  179          | '[' DDD ']' . Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    Symbol         go to state 94
    Name           go to state 95
    Type           go to state 367
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199


state 260

  148 Symbol: . IDENT
  149 Name: . Symbol
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  178          | '[' oExpr ']' . Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    Symbol         go to state 94
    Name           go to state 95
    Type           go to state 368
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199


state 261

   26 CommonDecl: Const '(' ')' .

    $default  reduce using rule 26 (CommonDecl)


state 262

   24 CommonDecl: Const '(' ConstDecl . oSemi ')'
   25           | Const '(' ConstDecl . ';' ConstDeclList oSemi ')'
  277 oSemi: .  [')']
  278      | . ';'

    ';'  shift, and go to state 369

    $default  reduce using rule 277 (oSemi)

    oSemi  go to state 370


state 263

   35 ConstDecl: DeclNameList '=' . ExprList
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  267 ExprList: . Expr
  268         | . ExprList ',' Expr

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 116
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprList            go to state 371


state 264

   34 ConstDecl: DeclNameList Type . '=' ExprList

    '='  shift, and go to state 372


state 265

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   85     | Expr ANDAND Expr .  [ANDAND, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, INC, OROR, ')', ':', ';', '=', '}', ']', ',']
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    ANDNOT  shift, and go to state 156
    EQ      shift, and go to state 160
    GE      shift, and go to state 161
    LE      shift, and go to state 163
    LSH     shift, and go to state 164
    NE      shift, and go to state 165
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '<'     shift, and go to state 174
    '>'     shift, and go to state 175
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    $default  reduce using rule 85 (Expr)

    Conflict between rule 85 and token ANDAND resolved as reduce (%left ANDAND).
    Conflict between rule 85 and token ANDNOT resolved as shift (ANDAND < ANDNOT).
    Conflict between rule 85 and token COMM resolved as reduce (COMM < ANDAND).
    Conflict between rule 85 and token EQ resolved as shift (ANDAND < EQ).
    Conflict between rule 85 and token GE resolved as shift (ANDAND < GE).
    Conflict between rule 85 and token LE resolved as shift (ANDAND < LE).
    Conflict between rule 85 and token LSH resolved as shift (ANDAND < LSH).
    Conflict between rule 85 and token NE resolved as shift (ANDAND < NE).
    Conflict between rule 85 and token OROR resolved as reduce (OROR < ANDAND).
    Conflict between rule 85 and token RSH resolved as shift (ANDAND < RSH).
    Conflict between rule 85 and token '%' resolved as shift (ANDAND < '%').
    Conflict between rule 85 and token '&' resolved as shift (ANDAND < '&').
    Conflict between rule 85 and token '*' resolved as shift (ANDAND < '*').
    Conflict between rule 85 and token '+' resolved as shift (ANDAND < '+').
    Conflict between rule 85 and token '-' resolved as shift (ANDAND < '-').
    Conflict between rule 85 and token '/' resolved as shift (ANDAND < '/').
    Conflict between rule 85 and token '<' resolved as shift (ANDAND < '<').
    Conflict between rule 85 and token '>' resolved as shift (ANDAND < '>').
    Conflict between rule 85 and token '^' resolved as shift (ANDAND < '^').
    Conflict between rule 85 and token '|' resolved as shift (ANDAND < '|').


state 266

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  100     | Expr ANDNOT Expr .  [ANDAND, ANDNOT, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, LSH, NE, OROR, RSH, '%', '&', ')', '*', '+', '-', '/', ':', ';', '<', '=', '>', '^', '|', '}', ']', ',']
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    $default  reduce using rule 100 (Expr)

    Conflict between rule 100 and token ANDAND resolved as reduce (ANDAND < ANDNOT).
    Conflict between rule 100 and token ANDNOT resolved as reduce (%left ANDNOT).
    Conflict between rule 100 and token COMM resolved as reduce (COMM < ANDNOT).
    Conflict between rule 100 and token EQ resolved as reduce (EQ < ANDNOT).
    Conflict between rule 100 and token GE resolved as reduce (GE < ANDNOT).
    Conflict between rule 100 and token LE resolved as reduce (LE < ANDNOT).
    Conflict between rule 100 and token LSH resolved as reduce (%left LSH).
    Conflict between rule 100 and token NE resolved as reduce (NE < ANDNOT).
    Conflict between rule 100 and token OROR resolved as reduce (OROR < ANDNOT).
    Conflict between rule 100 and token RSH resolved as reduce (%left RSH).
    Conflict between rule 100 and token '%' resolved as reduce (%left '%').
    Conflict between rule 100 and token '&' resolved as reduce (%left '&').
    Conflict between rule 100 and token '*' resolved as reduce (%left '*').
    Conflict between rule 100 and token '+' resolved as reduce ('+' < ANDNOT).
    Conflict between rule 100 and token '-' resolved as reduce ('-' < ANDNOT).
    Conflict between rule 100 and token '/' resolved as reduce (%left '/').
    Conflict between rule 100 and token '<' resolved as reduce ('<' < ANDNOT).
    Conflict between rule 100 and token '>' resolved as reduce ('>' < ANDNOT).
    Conflict between rule 100 and token '^' resolved as reduce ('^' < ANDNOT).
    Conflict between rule 100 and token '|' resolved as reduce ('|' < ANDNOT).


state 267

   42 SimpleStmt: Expr ASOP Expr .  [BODY, CASE, DEFAULT, ';', '}']
   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    ANDAND  shift, and go to state 155
    ANDNOT  shift, and go to state 156
    COMM    shift, and go to state 158
    EQ      shift, and go to state 160
    GE      shift, and go to state 161
    LE      shift, and go to state 163
    LSH     shift, and go to state 164
    NE      shift, and go to state 165
    OROR    shift, and go to state 166
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '<'     shift, and go to state 174
    '>'     shift, and go to state 175
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    $default  reduce using rule 42 (SimpleStmt)


state 268

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr
  103     | Expr COMM Expr .  [ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, INC, ')', ':', ';', '=', '}', ']', ',']

    ANDAND  shift, and go to state 155
    ANDNOT  shift, and go to state 156
    EQ      shift, and go to state 160
    GE      shift, and go to state 161
    LE      shift, and go to state 163
    LSH     shift, and go to state 164
    NE      shift, and go to state 165
    OROR    shift, and go to state 166
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '<'     shift, and go to state 174
    '>'     shift, and go to state 175
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    $default  reduce using rule 103 (Expr)

    Conflict between rule 103 and token ANDAND resolved as shift (COMM < ANDAND).
    Conflict between rule 103 and token ANDNOT resolved as shift (COMM < ANDNOT).
    Conflict between rule 103 and token COMM resolved as reduce (%left COMM).
    Conflict between rule 103 and token EQ resolved as shift (COMM < EQ).
    Conflict between rule 103 and token GE resolved as shift (COMM < GE).
    Conflict between rule 103 and token LE resolved as shift (COMM < LE).
    Conflict between rule 103 and token LSH resolved as shift (COMM < LSH).
    Conflict between rule 103 and token NE resolved as shift (COMM < NE).
    Conflict between rule 103 and token OROR resolved as shift (COMM < OROR).
    Conflict between rule 103 and token RSH resolved as shift (COMM < RSH).
    Conflict between rule 103 and token '%' resolved as shift (COMM < '%').
    Conflict between rule 103 and token '&' resolved as shift (COMM < '&').
    Conflict between rule 103 and token '*' resolved as shift (COMM < '*').
    Conflict between rule 103 and token '+' resolved as shift (COMM < '+').
    Conflict between rule 103 and token '-' resolved as shift (COMM < '-').
    Conflict between rule 103 and token '/' resolved as shift (COMM < '/').
    Conflict between rule 103 and token '<' resolved as shift (COMM < '<').
    Conflict between rule 103 and token '>' resolved as shift (COMM < '>').
    Conflict between rule 103 and token '^' resolved as shift (COMM < '^').
    Conflict between rule 103 and token '|' resolved as shift (COMM < '|').


state 269

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   86     | Expr EQ Expr .  [ANDAND, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, NE, OROR, ')', ':', ';', '<', '=', '>', '}', ']', ',']
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    ANDNOT  shift, and go to state 156
    LSH     shift, and go to state 164
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    $default  reduce using rule 86 (Expr)

    Conflict between rule 86 and token ANDAND resolved as reduce (ANDAND < EQ).
    Conflict between rule 86 and token ANDNOT resolved as shift (EQ < ANDNOT).
    Conflict between rule 86 and token COMM resolved as reduce (COMM < EQ).
    Conflict between rule 86 and token EQ resolved as reduce (%left EQ).
    Conflict between rule 86 and token GE resolved as reduce (%left GE).
    Conflict between rule 86 and token LE resolved as reduce (%left LE).
    Conflict between rule 86 and token LSH resolved as shift (EQ < LSH).
    Conflict between rule 86 and token NE resolved as reduce (%left NE).
    Conflict between rule 86 and token OROR resolved as reduce (OROR < EQ).
    Conflict between rule 86 and token RSH resolved as shift (EQ < RSH).
    Conflict between rule 86 and token '%' resolved as shift (EQ < '%').
    Conflict between rule 86 and token '&' resolved as shift (EQ < '&').
    Conflict between rule 86 and token '*' resolved as shift (EQ < '*').
    Conflict between rule 86 and token '+' resolved as shift (EQ < '+').
    Conflict between rule 86 and token '-' resolved as shift (EQ < '-').
    Conflict between rule 86 and token '/' resolved as shift (EQ < '/').
    Conflict between rule 86 and token '<' resolved as reduce (%left '<').
    Conflict between rule 86 and token '>' resolved as reduce (%left '>').
    Conflict between rule 86 and token '^' resolved as shift (EQ < '^').
    Conflict between rule 86 and token '|' resolved as shift (EQ < '|').


state 270

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   90     | Expr GE Expr .  [ANDAND, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, NE, OROR, ')', ':', ';', '<', '=', '>', '}', ']', ',']
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    ANDNOT  shift, and go to state 156
    LSH     shift, and go to state 164
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    $default  reduce using rule 90 (Expr)

    Conflict between rule 90 and token ANDAND resolved as reduce (ANDAND < GE).
    Conflict between rule 90 and token ANDNOT resolved as shift (GE < ANDNOT).
    Conflict between rule 90 and token COMM resolved as reduce (COMM < GE).
    Conflict between rule 90 and token EQ resolved as reduce (%left EQ).
    Conflict between rule 90 and token GE resolved as reduce (%left GE).
    Conflict between rule 90 and token LE resolved as reduce (%left LE).
    Conflict between rule 90 and token LSH resolved as shift (GE < LSH).
    Conflict between rule 90 and token NE resolved as reduce (%left NE).
    Conflict between rule 90 and token OROR resolved as reduce (OROR < GE).
    Conflict between rule 90 and token RSH resolved as shift (GE < RSH).
    Conflict between rule 90 and token '%' resolved as shift (GE < '%').
    Conflict between rule 90 and token '&' resolved as shift (GE < '&').
    Conflict between rule 90 and token '*' resolved as shift (GE < '*').
    Conflict between rule 90 and token '+' resolved as shift (GE < '+').
    Conflict between rule 90 and token '-' resolved as shift (GE < '-').
    Conflict between rule 90 and token '/' resolved as shift (GE < '/').
    Conflict between rule 90 and token '<' resolved as reduce (%left '<').
    Conflict between rule 90 and token '>' resolved as reduce (%left '>').
    Conflict between rule 90 and token '^' resolved as shift (GE < '^').
    Conflict between rule 90 and token '|' resolved as shift (GE < '|').


state 271

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   89     | Expr LE Expr .  [ANDAND, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, NE, OROR, ')', ':', ';', '<', '=', '>', '}', ']', ',']
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    ANDNOT  shift, and go to state 156
    LSH     shift, and go to state 164
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    $default  reduce using rule 89 (Expr)

    Conflict between rule 89 and token ANDAND resolved as reduce (ANDAND < LE).
    Conflict between rule 89 and token ANDNOT resolved as shift (LE < ANDNOT).
    Conflict between rule 89 and token COMM resolved as reduce (COMM < LE).
    Conflict between rule 89 and token EQ resolved as reduce (%left EQ).
    Conflict between rule 89 and token GE resolved as reduce (%left GE).
    Conflict between rule 89 and token LE resolved as reduce (%left LE).
    Conflict between rule 89 and token LSH resolved as shift (LE < LSH).
    Conflict between rule 89 and token NE resolved as reduce (%left NE).
    Conflict between rule 89 and token OROR resolved as reduce (OROR < LE).
    Conflict between rule 89 and token RSH resolved as shift (LE < RSH).
    Conflict between rule 89 and token '%' resolved as shift (LE < '%').
    Conflict between rule 89 and token '&' resolved as shift (LE < '&').
    Conflict between rule 89 and token '*' resolved as shift (LE < '*').
    Conflict between rule 89 and token '+' resolved as shift (LE < '+').
    Conflict between rule 89 and token '-' resolved as shift (LE < '-').
    Conflict between rule 89 and token '/' resolved as shift (LE < '/').
    Conflict between rule 89 and token '<' resolved as reduce (%left '<').
    Conflict between rule 89 and token '>' resolved as reduce (%left '>').
    Conflict between rule 89 and token '^' resolved as shift (LE < '^').
    Conflict between rule 89 and token '|' resolved as shift (LE < '|').


state 272

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  101     | Expr LSH Expr .  [ANDAND, ANDNOT, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, LSH, NE, OROR, RSH, '%', '&', ')', '*', '+', '-', '/', ':', ';', '<', '=', '>', '^', '|', '}', ']', ',']
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    $default  reduce using rule 101 (Expr)

    Conflict between rule 101 and token ANDAND resolved as reduce (ANDAND < LSH).
    Conflict between rule 101 and token ANDNOT resolved as reduce (%left ANDNOT).
    Conflict between rule 101 and token COMM resolved as reduce (COMM < LSH).
    Conflict between rule 101 and token EQ resolved as reduce (EQ < LSH).
    Conflict between rule 101 and token GE resolved as reduce (GE < LSH).
    Conflict between rule 101 and token LE resolved as reduce (LE < LSH).
    Conflict between rule 101 and token LSH resolved as reduce (%left LSH).
    Conflict between rule 101 and token NE resolved as reduce (NE < LSH).
    Conflict between rule 101 and token OROR resolved as reduce (OROR < LSH).
    Conflict between rule 101 and token RSH resolved as reduce (%left RSH).
    Conflict between rule 101 and token '%' resolved as reduce (%left '%').
    Conflict between rule 101 and token '&' resolved as reduce (%left '&').
    Conflict between rule 101 and token '*' resolved as reduce (%left '*').
    Conflict between rule 101 and token '+' resolved as reduce ('+' < LSH).
    Conflict between rule 101 and token '-' resolved as reduce ('-' < LSH).
    Conflict between rule 101 and token '/' resolved as reduce (%left '/').
    Conflict between rule 101 and token '<' resolved as reduce ('<' < LSH).
    Conflict between rule 101 and token '>' resolved as reduce ('>' < LSH).
    Conflict between rule 101 and token '^' resolved as reduce ('^' < LSH).
    Conflict between rule 101 and token '|' resolved as reduce ('|' < LSH).


state 273

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   87     | Expr NE Expr .  [ANDAND, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, NE, OROR, ')', ':', ';', '<', '=', '>', '}', ']', ',']
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    ANDNOT  shift, and go to state 156
    LSH     shift, and go to state 164
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    $default  reduce using rule 87 (Expr)

    Conflict between rule 87 and token ANDAND resolved as reduce (ANDAND < NE).
    Conflict between rule 87 and token ANDNOT resolved as shift (NE < ANDNOT).
    Conflict between rule 87 and token COMM resolved as reduce (COMM < NE).
    Conflict between rule 87 and token EQ resolved as reduce (%left EQ).
    Conflict between rule 87 and token GE resolved as reduce (%left GE).
    Conflict between rule 87 and token LE resolved as reduce (%left LE).
    Conflict between rule 87 and token LSH resolved as shift (NE < LSH).
    Conflict between rule 87 and token NE resolved as reduce (%left NE).
    Conflict between rule 87 and token OROR resolved as reduce (OROR < NE).
    Conflict between rule 87 and token RSH resolved as shift (NE < RSH).
    Conflict between rule 87 and token '%' resolved as shift (NE < '%').
    Conflict between rule 87 and token '&' resolved as shift (NE < '&').
    Conflict between rule 87 and token '*' resolved as shift (NE < '*').
    Conflict between rule 87 and token '+' resolved as shift (NE < '+').
    Conflict between rule 87 and token '-' resolved as shift (NE < '-').
    Conflict between rule 87 and token '/' resolved as shift (NE < '/').
    Conflict between rule 87 and token '<' resolved as reduce (%left '<').
    Conflict between rule 87 and token '>' resolved as reduce (%left '>').
    Conflict between rule 87 and token '^' resolved as shift (NE < '^').
    Conflict between rule 87 and token '|' resolved as shift (NE < '|').


state 274

   84 Expr: Expr . OROR Expr
   84     | Expr OROR Expr .  [ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, INC, OROR, ')', ':', ';', '=', '}', ']', ',']
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    ANDAND  shift, and go to state 155
    ANDNOT  shift, and go to state 156
    EQ      shift, and go to state 160
    GE      shift, and go to state 161
    LE      shift, and go to state 163
    LSH     shift, and go to state 164
    NE      shift, and go to state 165
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '<'     shift, and go to state 174
    '>'     shift, and go to state 175
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    $default  reduce using rule 84 (Expr)

    Conflict between rule 84 and token ANDAND resolved as shift (OROR < ANDAND).
    Conflict between rule 84 and token ANDNOT resolved as shift (OROR < ANDNOT).
    Conflict between rule 84 and token COMM resolved as reduce (COMM < OROR).
    Conflict between rule 84 and token EQ resolved as shift (OROR < EQ).
    Conflict between rule 84 and token GE resolved as shift (OROR < GE).
    Conflict between rule 84 and token LE resolved as shift (OROR < LE).
    Conflict between rule 84 and token LSH resolved as shift (OROR < LSH).
    Conflict between rule 84 and token NE resolved as shift (OROR < NE).
    Conflict between rule 84 and token OROR resolved as reduce (%left OROR).
    Conflict between rule 84 and token RSH resolved as shift (OROR < RSH).
    Conflict between rule 84 and token '%' resolved as shift (OROR < '%').
    Conflict between rule 84 and token '&' resolved as shift (OROR < '&').
    Conflict between rule 84 and token '*' resolved as shift (OROR < '*').
    Conflict between rule 84 and token '+' resolved as shift (OROR < '+').
    Conflict between rule 84 and token '-' resolved as shift (OROR < '-').
    Conflict between rule 84 and token '/' resolved as shift (OROR < '/').
    Conflict between rule 84 and token '<' resolved as shift (OROR < '<').
    Conflict between rule 84 and token '>' resolved as shift (OROR < '>').
    Conflict between rule 84 and token '^' resolved as shift (OROR < '^').
    Conflict between rule 84 and token '|' resolved as shift (OROR < '|').


state 275

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  102     | Expr RSH Expr .  [ANDAND, ANDNOT, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, LSH, NE, OROR, RSH, '%', '&', ')', '*', '+', '-', '/', ':', ';', '<', '=', '>', '^', '|', '}', ']', ',']
  103     | Expr . COMM Expr

    $default  reduce using rule 102 (Expr)

    Conflict between rule 102 and token ANDAND resolved as reduce (ANDAND < RSH).
    Conflict between rule 102 and token ANDNOT resolved as reduce (%left ANDNOT).
    Conflict between rule 102 and token COMM resolved as reduce (COMM < RSH).
    Conflict between rule 102 and token EQ resolved as reduce (EQ < RSH).
    Conflict between rule 102 and token GE resolved as reduce (GE < RSH).
    Conflict between rule 102 and token LE resolved as reduce (LE < RSH).
    Conflict between rule 102 and token LSH resolved as reduce (%left LSH).
    Conflict between rule 102 and token NE resolved as reduce (NE < RSH).
    Conflict between rule 102 and token OROR resolved as reduce (OROR < RSH).
    Conflict between rule 102 and token RSH resolved as reduce (%left RSH).
    Conflict between rule 102 and token '%' resolved as reduce (%left '%').
    Conflict between rule 102 and token '&' resolved as reduce (%left '&').
    Conflict between rule 102 and token '*' resolved as reduce (%left '*').
    Conflict between rule 102 and token '+' resolved as reduce ('+' < RSH).
    Conflict between rule 102 and token '-' resolved as reduce ('-' < RSH).
    Conflict between rule 102 and token '/' resolved as reduce (%left '/').
    Conflict between rule 102 and token '<' resolved as reduce ('<' < RSH).
    Conflict between rule 102 and token '>' resolved as reduce ('>' < RSH).
    Conflict between rule 102 and token '^' resolved as reduce ('^' < RSH).
    Conflict between rule 102 and token '|' resolved as reduce ('|' < RSH).


state 276

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   98     | Expr '%' Expr .  [ANDAND, ANDNOT, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, LSH, NE, OROR, RSH, '%', '&', ')', '*', '+', '-', '/', ':', ';', '<', '=', '>', '^', '|', '}', ']', ',']
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    $default  reduce using rule 98 (Expr)

    Conflict between rule 98 and token ANDAND resolved as reduce (ANDAND < '%').
    Conflict between rule 98 and token ANDNOT resolved as reduce (%left ANDNOT).
    Conflict between rule 98 and token COMM resolved as reduce (COMM < '%').
    Conflict between rule 98 and token EQ resolved as reduce (EQ < '%').
    Conflict between rule 98 and token GE resolved as reduce (GE < '%').
    Conflict between rule 98 and token LE resolved as reduce (LE < '%').
    Conflict between rule 98 and token LSH resolved as reduce (%left LSH).
    Conflict between rule 98 and token NE resolved as reduce (NE < '%').
    Conflict between rule 98 and token OROR resolved as reduce (OROR < '%').
    Conflict between rule 98 and token RSH resolved as reduce (%left RSH).
    Conflict between rule 98 and token '%' resolved as reduce (%left '%').
    Conflict between rule 98 and token '&' resolved as reduce (%left '&').
    Conflict between rule 98 and token '*' resolved as reduce (%left '*').
    Conflict between rule 98 and token '+' resolved as reduce ('+' < '%').
    Conflict between rule 98 and token '-' resolved as reduce ('-' < '%').
    Conflict between rule 98 and token '/' resolved as reduce (%left '/').
    Conflict between rule 98 and token '<' resolved as reduce ('<' < '%').
    Conflict between rule 98 and token '>' resolved as reduce ('>' < '%').
    Conflict between rule 98 and token '^' resolved as reduce ('^' < '%').
    Conflict between rule 98 and token '|' resolved as reduce ('|' < '%').


state 277

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
   99     | Expr '&' Expr .  [ANDAND, ANDNOT, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, LSH, NE, OROR, RSH, '%', '&', ')', '*', '+', '-', '/', ':', ';', '<', '=', '>', '^', '|', '}', ']', ',']
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    $default  reduce using rule 99 (Expr)

    Conflict between rule 99 and token ANDAND resolved as reduce (ANDAND < '&').
    Conflict between rule 99 and token ANDNOT resolved as reduce (%left ANDNOT).
    Conflict between rule 99 and token COMM resolved as reduce (COMM < '&').
    Conflict between rule 99 and token EQ resolved as reduce (EQ < '&').
    Conflict between rule 99 and token GE resolved as reduce (GE < '&').
    Conflict between rule 99 and token LE resolved as reduce (LE < '&').
    Conflict between rule 99 and token LSH resolved as reduce (%left LSH).
    Conflict between rule 99 and token NE resolved as reduce (NE < '&').
    Conflict between rule 99 and token OROR resolved as reduce (OROR < '&').
    Conflict between rule 99 and token RSH resolved as reduce (%left RSH).
    Conflict between rule 99 and token '%' resolved as reduce (%left '%').
    Conflict between rule 99 and token '&' resolved as reduce (%left '&').
    Conflict between rule 99 and token '*' resolved as reduce (%left '*').
    Conflict between rule 99 and token '+' resolved as reduce ('+' < '&').
    Conflict between rule 99 and token '-' resolved as reduce ('-' < '&').
    Conflict between rule 99 and token '/' resolved as reduce (%left '/').
    Conflict between rule 99 and token '<' resolved as reduce ('<' < '&').
    Conflict between rule 99 and token '>' resolved as reduce ('>' < '&').
    Conflict between rule 99 and token '^' resolved as reduce ('^' < '&').
    Conflict between rule 99 and token '|' resolved as reduce ('|' < '&').


state 278

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   96     | Expr '*' Expr .  [ANDAND, ANDNOT, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, LSH, NE, OROR, RSH, '%', '&', ')', '*', '+', '-', '/', ':', ';', '<', '=', '>', '^', '|', '}', ']', ',']
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    $default  reduce using rule 96 (Expr)

    Conflict between rule 96 and token ANDAND resolved as reduce (ANDAND < '*').
    Conflict between rule 96 and token ANDNOT resolved as reduce (%left ANDNOT).
    Conflict between rule 96 and token COMM resolved as reduce (COMM < '*').
    Conflict between rule 96 and token EQ resolved as reduce (EQ < '*').
    Conflict between rule 96 and token GE resolved as reduce (GE < '*').
    Conflict between rule 96 and token LE resolved as reduce (LE < '*').
    Conflict between rule 96 and token LSH resolved as reduce (%left LSH).
    Conflict between rule 96 and token NE resolved as reduce (NE < '*').
    Conflict between rule 96 and token OROR resolved as reduce (OROR < '*').
    Conflict between rule 96 and token RSH resolved as reduce (%left RSH).
    Conflict between rule 96 and token '%' resolved as reduce (%left '%').
    Conflict between rule 96 and token '&' resolved as reduce (%left '&').
    Conflict between rule 96 and token '*' resolved as reduce (%left '*').
    Conflict between rule 96 and token '+' resolved as reduce ('+' < '*').
    Conflict between rule 96 and token '-' resolved as reduce ('-' < '*').
    Conflict between rule 96 and token '/' resolved as reduce (%left '/').
    Conflict between rule 96 and token '<' resolved as reduce ('<' < '*').
    Conflict between rule 96 and token '>' resolved as reduce ('>' < '*').
    Conflict between rule 96 and token '^' resolved as reduce ('^' < '*').
    Conflict between rule 96 and token '|' resolved as reduce ('|' < '*').


state 279

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   92     | Expr '+' Expr .  [ANDAND, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, NE, OROR, ')', '+', '-', ':', ';', '<', '=', '>', '^', '|', '}', ']', ',']
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    ANDNOT  shift, and go to state 156
    LSH     shift, and go to state 164
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '/'     shift, and go to state 173

    $default  reduce using rule 92 (Expr)

    Conflict between rule 92 and token ANDAND resolved as reduce (ANDAND < '+').
    Conflict between rule 92 and token ANDNOT resolved as shift ('+' < ANDNOT).
    Conflict between rule 92 and token COMM resolved as reduce (COMM < '+').
    Conflict between rule 92 and token EQ resolved as reduce (EQ < '+').
    Conflict between rule 92 and token GE resolved as reduce (GE < '+').
    Conflict between rule 92 and token LE resolved as reduce (LE < '+').
    Conflict between rule 92 and token LSH resolved as shift ('+' < LSH).
    Conflict between rule 92 and token NE resolved as reduce (NE < '+').
    Conflict between rule 92 and token OROR resolved as reduce (OROR < '+').
    Conflict between rule 92 and token RSH resolved as shift ('+' < RSH).
    Conflict between rule 92 and token '%' resolved as shift ('+' < '%').
    Conflict between rule 92 and token '&' resolved as shift ('+' < '&').
    Conflict between rule 92 and token '*' resolved as shift ('+' < '*').
    Conflict between rule 92 and token '+' resolved as reduce (%left '+').
    Conflict between rule 92 and token '-' resolved as reduce (%left '-').
    Conflict between rule 92 and token '/' resolved as shift ('+' < '/').
    Conflict between rule 92 and token '<' resolved as reduce ('<' < '+').
    Conflict between rule 92 and token '>' resolved as reduce ('>' < '+').
    Conflict between rule 92 and token '^' resolved as reduce (%left '^').
    Conflict between rule 92 and token '|' resolved as reduce (%left '|').


state 280

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   93     | Expr '-' Expr .  [ANDAND, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, NE, OROR, ')', '+', '-', ':', ';', '<', '=', '>', '^', '|', '}', ']', ',']
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    ANDNOT  shift, and go to state 156
    LSH     shift, and go to state 164
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '/'     shift, and go to state 173

    $default  reduce using rule 93 (Expr)

    Conflict between rule 93 and token ANDAND resolved as reduce (ANDAND < '-').
    Conflict between rule 93 and token ANDNOT resolved as shift ('-' < ANDNOT).
    Conflict between rule 93 and token COMM resolved as reduce (COMM < '-').
    Conflict between rule 93 and token EQ resolved as reduce (EQ < '-').
    Conflict between rule 93 and token GE resolved as reduce (GE < '-').
    Conflict between rule 93 and token LE resolved as reduce (LE < '-').
    Conflict between rule 93 and token LSH resolved as shift ('-' < LSH).
    Conflict between rule 93 and token NE resolved as reduce (NE < '-').
    Conflict between rule 93 and token OROR resolved as reduce (OROR < '-').
    Conflict between rule 93 and token RSH resolved as shift ('-' < RSH).
    Conflict between rule 93 and token '%' resolved as shift ('-' < '%').
    Conflict between rule 93 and token '&' resolved as shift ('-' < '&').
    Conflict between rule 93 and token '*' resolved as shift ('-' < '*').
    Conflict between rule 93 and token '+' resolved as reduce (%left '+').
    Conflict between rule 93 and token '-' resolved as reduce (%left '-').
    Conflict between rule 93 and token '/' resolved as shift ('-' < '/').
    Conflict between rule 93 and token '<' resolved as reduce ('<' < '-').
    Conflict between rule 93 and token '>' resolved as reduce ('>' < '-').
    Conflict between rule 93 and token '^' resolved as reduce (%left '^').
    Conflict between rule 93 and token '|' resolved as reduce (%left '|').


state 281

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   97     | Expr '/' Expr .  [ANDAND, ANDNOT, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, LSH, NE, OROR, RSH, '%', '&', ')', '*', '+', '-', '/', ':', ';', '<', '=', '>', '^', '|', '}', ']', ',']
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    $default  reduce using rule 97 (Expr)

    Conflict between rule 97 and token ANDAND resolved as reduce (ANDAND < '/').
    Conflict between rule 97 and token ANDNOT resolved as reduce (%left ANDNOT).
    Conflict between rule 97 and token COMM resolved as reduce (COMM < '/').
    Conflict between rule 97 and token EQ resolved as reduce (EQ < '/').
    Conflict between rule 97 and token GE resolved as reduce (GE < '/').
    Conflict between rule 97 and token LE resolved as reduce (LE < '/').
    Conflict between rule 97 and token LSH resolved as reduce (%left LSH).
    Conflict between rule 97 and token NE resolved as reduce (NE < '/').
    Conflict between rule 97 and token OROR resolved as reduce (OROR < '/').
    Conflict between rule 97 and token RSH resolved as reduce (%left RSH).
    Conflict between rule 97 and token '%' resolved as reduce (%left '%').
    Conflict between rule 97 and token '&' resolved as reduce (%left '&').
    Conflict between rule 97 and token '*' resolved as reduce (%left '*').
    Conflict between rule 97 and token '+' resolved as reduce ('+' < '/').
    Conflict between rule 97 and token '-' resolved as reduce ('-' < '/').
    Conflict between rule 97 and token '/' resolved as reduce (%left '/').
    Conflict between rule 97 and token '<' resolved as reduce ('<' < '/').
    Conflict between rule 97 and token '>' resolved as reduce ('>' < '/').
    Conflict between rule 97 and token '^' resolved as reduce ('^' < '/').
    Conflict between rule 97 and token '|' resolved as reduce ('|' < '/').


state 282

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   88     | Expr '<' Expr .  [ANDAND, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, NE, OROR, ')', ':', ';', '<', '=', '>', '}', ']', ',']
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    ANDNOT  shift, and go to state 156
    LSH     shift, and go to state 164
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    $default  reduce using rule 88 (Expr)

    Conflict between rule 88 and token ANDAND resolved as reduce (ANDAND < '<').
    Conflict between rule 88 and token ANDNOT resolved as shift ('<' < ANDNOT).
    Conflict between rule 88 and token COMM resolved as reduce (COMM < '<').
    Conflict between rule 88 and token EQ resolved as reduce (%left EQ).
    Conflict between rule 88 and token GE resolved as reduce (%left GE).
    Conflict between rule 88 and token LE resolved as reduce (%left LE).
    Conflict between rule 88 and token LSH resolved as shift ('<' < LSH).
    Conflict between rule 88 and token NE resolved as reduce (%left NE).
    Conflict between rule 88 and token OROR resolved as reduce (OROR < '<').
    Conflict between rule 88 and token RSH resolved as shift ('<' < RSH).
    Conflict between rule 88 and token '%' resolved as shift ('<' < '%').
    Conflict between rule 88 and token '&' resolved as shift ('<' < '&').
    Conflict between rule 88 and token '*' resolved as shift ('<' < '*').
    Conflict between rule 88 and token '+' resolved as shift ('<' < '+').
    Conflict between rule 88 and token '-' resolved as shift ('<' < '-').
    Conflict between rule 88 and token '/' resolved as shift ('<' < '/').
    Conflict between rule 88 and token '<' resolved as reduce (%left '<').
    Conflict between rule 88 and token '>' resolved as reduce (%left '>').
    Conflict between rule 88 and token '^' resolved as shift ('<' < '^').
    Conflict between rule 88 and token '|' resolved as shift ('<' < '|').


state 283

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   91     | Expr '>' Expr .  [ANDAND, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, NE, OROR, ')', ':', ';', '<', '=', '>', '}', ']', ',']
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    ANDNOT  shift, and go to state 156
    LSH     shift, and go to state 164
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    $default  reduce using rule 91 (Expr)

    Conflict between rule 91 and token ANDAND resolved as reduce (ANDAND < '>').
    Conflict between rule 91 and token ANDNOT resolved as shift ('>' < ANDNOT).
    Conflict between rule 91 and token COMM resolved as reduce (COMM < '>').
    Conflict between rule 91 and token EQ resolved as reduce (%left EQ).
    Conflict between rule 91 and token GE resolved as reduce (%left GE).
    Conflict between rule 91 and token LE resolved as reduce (%left LE).
    Conflict between rule 91 and token LSH resolved as shift ('>' < LSH).
    Conflict between rule 91 and token NE resolved as reduce (%left NE).
    Conflict between rule 91 and token OROR resolved as reduce (OROR < '>').
    Conflict between rule 91 and token RSH resolved as shift ('>' < RSH).
    Conflict between rule 91 and token '%' resolved as shift ('>' < '%').
    Conflict between rule 91 and token '&' resolved as shift ('>' < '&').
    Conflict between rule 91 and token '*' resolved as shift ('>' < '*').
    Conflict between rule 91 and token '+' resolved as shift ('>' < '+').
    Conflict between rule 91 and token '-' resolved as shift ('>' < '-').
    Conflict between rule 91 and token '/' resolved as shift ('>' < '/').
    Conflict between rule 91 and token '<' resolved as reduce (%left '<').
    Conflict between rule 91 and token '>' resolved as reduce (%left '>').
    Conflict between rule 91 and token '^' resolved as shift ('>' < '^').
    Conflict between rule 91 and token '|' resolved as shift ('>' < '|').


state 284

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   95     | Expr '^' Expr .  [ANDAND, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, NE, OROR, ')', '+', '-', ':', ';', '<', '=', '>', '^', '|', '}', ']', ',']
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    ANDNOT  shift, and go to state 156
    LSH     shift, and go to state 164
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '/'     shift, and go to state 173

    $default  reduce using rule 95 (Expr)

    Conflict between rule 95 and token ANDAND resolved as reduce (ANDAND < '^').
    Conflict between rule 95 and token ANDNOT resolved as shift ('^' < ANDNOT).
    Conflict between rule 95 and token COMM resolved as reduce (COMM < '^').
    Conflict between rule 95 and token EQ resolved as reduce (EQ < '^').
    Conflict between rule 95 and token GE resolved as reduce (GE < '^').
    Conflict between rule 95 and token LE resolved as reduce (LE < '^').
    Conflict between rule 95 and token LSH resolved as shift ('^' < LSH).
    Conflict between rule 95 and token NE resolved as reduce (NE < '^').
    Conflict between rule 95 and token OROR resolved as reduce (OROR < '^').
    Conflict between rule 95 and token RSH resolved as shift ('^' < RSH).
    Conflict between rule 95 and token '%' resolved as shift ('^' < '%').
    Conflict between rule 95 and token '&' resolved as shift ('^' < '&').
    Conflict between rule 95 and token '*' resolved as shift ('^' < '*').
    Conflict between rule 95 and token '+' resolved as reduce (%left '+').
    Conflict between rule 95 and token '-' resolved as reduce (%left '-').
    Conflict between rule 95 and token '/' resolved as shift ('^' < '/').
    Conflict between rule 95 and token '<' resolved as reduce ('<' < '^').
    Conflict between rule 95 and token '>' resolved as reduce ('>' < '^').
    Conflict between rule 95 and token '^' resolved as reduce (%left '^').
    Conflict between rule 95 and token '|' resolved as reduce (%left '|').


state 285

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   94     | Expr '|' Expr .  [ANDAND, ASOP, BODY, CASE, COLAS, COMM, DDD, DEC, DEFAULT, EQ, GE, INC, LE, NE, OROR, ')', '+', '-', ':', ';', '<', '=', '>', '^', '|', '}', ']', ',']
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    ANDNOT  shift, and go to state 156
    LSH     shift, and go to state 164
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '/'     shift, and go to state 173

    $default  reduce using rule 94 (Expr)

    Conflict between rule 94 and token ANDAND resolved as reduce (ANDAND < '|').
    Conflict between rule 94 and token ANDNOT resolved as shift ('|' < ANDNOT).
    Conflict between rule 94 and token COMM resolved as reduce (COMM < '|').
    Conflict between rule 94 and token EQ resolved as reduce (EQ < '|').
    Conflict between rule 94 and token GE resolved as reduce (GE < '|').
    Conflict between rule 94 and token LE resolved as reduce (LE < '|').
    Conflict between rule 94 and token LSH resolved as shift ('|' < LSH).
    Conflict between rule 94 and token NE resolved as reduce (NE < '|').
    Conflict between rule 94 and token OROR resolved as reduce (OROR < '|').
    Conflict between rule 94 and token RSH resolved as shift ('|' < RSH).
    Conflict between rule 94 and token '%' resolved as shift ('|' < '%').
    Conflict between rule 94 and token '&' resolved as shift ('|' < '&').
    Conflict between rule 94 and token '*' resolved as shift ('|' < '*').
    Conflict between rule 94 and token '+' resolved as reduce (%left '+').
    Conflict between rule 94 and token '-' resolved as reduce (%left '-').
    Conflict between rule 94 and token '/' resolved as shift ('|' < '/').
    Conflict between rule 94 and token '<' resolved as reduce ('<' < '|').
    Conflict between rule 94 and token '>' resolved as reduce ('>' < '|').
    Conflict between rule 94 and token '^' resolved as reduce (%left '^').
    Conflict between rule 94 and token '|' resolved as reduce (%left '|').


state 286

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  128                   | PrimaryExprNoParen '{' StartCompLit . BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  132 Keyval: . Expr ':' CompLitExpr
  133 BareCompLitExpr: . Expr
  134                | . '{' StartCompLit BracedKeyvalList '}'
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  271 KeyvalList: . Keyval
  272           | . BareCompLitExpr
  273           | . KeyvalList ',' Keyval
  274           | . KeyvalList ',' BareCompLitExpr
  275 BracedKeyvalList: .  ['}']
  276                 | . KeyvalList oComma

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '{'        shift, and go to state 373
    '~'        shift, and go to state 51

    $default  reduce using rule 275 (BracedKeyvalList)

    Expr                go to state 374
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    Keyval              go to state 375
    BareCompLitExpr     go to state 376
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    KeyvalList          go to state 377
    BracedKeyvalList    go to state 378


state 287

  113 PseudoCall: PrimaryExpr '(' ')' .

    $default  reduce using rule 113 (PseudoCall)


state 288

  269 ExprOrTypeList: ExprOrType .

    $default  reduce using rule 269 (ExprOrTypeList)


state 289

  114 PseudoCall: PrimaryExpr '(' ExprOrTypeList . oComma ')'
  115           | PrimaryExpr '(' ExprOrTypeList . DDD oComma ')'
  270 ExprOrTypeList: ExprOrTypeList . ',' ExprOrType
  279 oComma: .  [')']
  280       | . ','

    DDD  shift, and go to state 379
    ','  shift, and go to state 380

    $default  reduce using rule 279 (oComma)

    oComma  go to state 381


state 290

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  119                   | PrimaryExpr '.' '(' . ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  120                   | PrimaryExpr '.' '(' . TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  139 ExprOrType: . Expr
  140           | . NonExprType
  148 Symbol: . IDENT
  149 Name: . Symbol
  159 NonExprType: . RecvChanType
  160            | . FuncType
  161            | . OtherType
  162            | . '*' NonExprType
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 135
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    TYPE       shift, and go to state 382
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 136
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 137
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    ExprOrType          go to state 383
    Symbol              go to state 94
    Name                go to state 67
    NonExprType         go to state 139
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 140
    RecvChanType        go to state 141
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 142
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 291

  118 PrimaryExprNoParen: PrimaryExpr '.' Symbol .

    $default  reduce using rule 118 (PrimaryExprNoParen)


state 292

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr
  121 PrimaryExprNoParen: PrimaryExpr '[' Expr . ']'
  282 oExpr: Expr .  [':']

    ANDAND  shift, and go to state 155
    ANDNOT  shift, and go to state 156
    COMM    shift, and go to state 158
    EQ      shift, and go to state 160
    GE      shift, and go to state 161
    LE      shift, and go to state 163
    LSH     shift, and go to state 164
    NE      shift, and go to state 165
    OROR    shift, and go to state 166
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '<'     shift, and go to state 174
    '>'     shift, and go to state 175
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177
    ']'     shift, and go to state 384

    $default  reduce using rule 282 (oExpr)


state 293

  122 PrimaryExprNoParen: PrimaryExpr '[' oExpr . ':' oExpr ']'
  123                   | PrimaryExpr '[' oExpr . ':' oExpr ':' oExpr ']'

    ':'  shift, and go to state 385


state 294

  246 Statement: error .

    $default  reduce using rule 246 (Statement)


state 295

   51 $@2: .
   52 CompoundStmt: '{' . $@2 StmtList '}'

    $default  reduce using rule 51 ($@2)

    $@2  go to state 386


state 296

  244 Statement: CommonDecl .

    $default  reduce using rule 244 (Statement)


state 297

  243 Statement: CompoundStmt .

    $default  reduce using rule 243 (Statement)


state 298

  252 NonDclStmt: LabelName ':' Statement .

    $default  reduce using rule 252 (NonDclStmt)


state 299

  245 Statement: NonDclStmt .

    $default  reduce using rule 245 (Statement)


state 300

  126 PrimaryExprNoParen: ConvType '(' ')' .

    $default  reduce using rule 126 (PrimaryExprNoParen)


state 301

  125 PrimaryExprNoParen: ConvType '(' ExprList . oComma ')'
  268 ExprList: ExprList . ',' Expr
  279 oComma: .  [')']
  280       | . ','

    ','  shift, and go to state 387

    $default  reduce using rule 279 (oComma)

    oComma  go to state 388


state 302

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  127                   | CompLitType LBrace StartCompLit . BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  132 Keyval: . Expr ':' CompLitExpr
  133 BareCompLitExpr: . Expr
  134                | . '{' StartCompLit BracedKeyvalList '}'
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  271 KeyvalList: . Keyval
  272           | . BareCompLitExpr
  273           | . KeyvalList ',' Keyval
  274           | . KeyvalList ',' BareCompLitExpr
  275 BracedKeyvalList: .  ['}']
  276                 | . KeyvalList oComma

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '{'        shift, and go to state 373
    '~'        shift, and go to state 51

    $default  reduce using rule 275 (BracedKeyvalList)

    Expr                go to state 374
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    Keyval              go to state 375
    BareCompLitExpr     go to state 376
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    KeyvalList          go to state 377
    BracedKeyvalList    go to state 389


state 303

  261 StmtList: Statement .

    $default  reduce using rule 261 (StmtList)


state 304

  207 FuncLit: FuncLitDecl LBrace StmtList . '}'
  262 StmtList: StmtList . ';' Statement

    ';'  shift, and go to state 390
    '}'  shift, and go to state 391


state 305

   44 SimpleStmt: ExprList COLAS ExprList .  [BODY, CASE, DEFAULT, ';', '}']
  268 ExprList: ExprList . ',' Expr

    ','  shift, and go to state 189

    $default  reduce using rule 44 (SimpleStmt)


state 306

   43 SimpleStmt: ExprList '=' ExprList .  [BODY, CASE, DEFAULT, ';', '}']
  268 ExprList: ExprList . ',' Expr

    ','  shift, and go to state 189

    $default  reduce using rule 43 (SimpleStmt)


state 307

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr
  268 ExprList: ExprList ',' Expr .  [BODY, CASE, COLAS, DEFAULT, ')', ';', '=', '}', ',']

    ANDAND  shift, and go to state 155
    ANDNOT  shift, and go to state 156
    COMM    shift, and go to state 158
    EQ      shift, and go to state 160
    GE      shift, and go to state 161
    LE      shift, and go to state 163
    LSH     shift, and go to state 164
    NE      shift, and go to state 165
    OROR    shift, and go to state 166
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '<'     shift, and go to state 174
    '>'     shift, and go to state 175
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    $default  reduce using rule 268 (ExprList)


state 308

   14 ImportDeclList: ImportDeclList ';' ImportDecl .

    $default  reduce using rule 14 (ImportDeclList)


state 309

    8 Import: IMPORT '(' ImportDeclList oSemi ')' .

    $default  reduce using rule 8 (Import)


state 310

  148 Symbol: . IDENT
  149 Name: . Symbol
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  188             | COMM CHAN . Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    Symbol         go to state 94
    Name           go to state 95
    Type           go to state 361
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199


state 311

  158 Type: '(' Type . ')'

    ')'  shift, and go to state 392


state 312

  200 FuncType: FUNC '(' oArgTypeListOComma . ')' FuncResult

    ')'  shift, and go to state 393


state 313

  167 NonRecvChanType: '(' Type ')' .

    $default  reduce using rule 167 (NonRecvChanType)


state 314

  177 TypeName: Name '.' Symbol .

    $default  reduce using rule 177 (TypeName)


state 315

   57 $@4: .
   58 LoopBody: BODY . $@4 StmtList '}'

    $default  reduce using rule 57 ($@4)

    $@4  go to state 394


state 316

   64 ForBody: ForHeader LoopBody .

    $default  reduce using rule 64 (ForBody)


state 317

   44 SimpleStmt: ExprList COLAS . ExprList
   60 RangeStmt: ExprList COLAS . RANGE Expr
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  267 ExprList: . Expr
  268         | . ExprList ',' Expr

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    RANGE      shift, and go to state 395
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 116
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprList            go to state 305


state 318

   43 SimpleStmt: ExprList '=' . ExprList
   59 RangeStmt: ExprList '=' . RANGE Expr
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  267 ExprList: . Expr
  268         | . ExprList ',' Expr

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    RANGE      shift, and go to state 396
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 116
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprList            go to state 306


state 319

   41 SimpleStmt: . Expr
   42           | . Expr ASOP Expr
   43           | . ExprList '=' ExprList
   44           | . ExprList COLAS ExprList
   45           | . Expr INC
   46           | . Expr DEC
   61 ForHeader: oSimpleStmt ';' . oSimpleStmt ';' oSimpleStmt
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  267 ExprList: . Expr
  268         | . ExprList ',' Expr
  285 oSimpleStmt: .  [';']
  286            | . SimpleStmt

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    $default  reduce using rule 285 (oSimpleStmt)

    SimpleStmt          go to state 204
    Expr                go to state 60
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprList            go to state 81
    oSimpleStmt         go to state 397


state 320

  152 Ddd: DDD Type .

    $default  reduce using rule 152 (Ddd)


state 321

  235 ArgType: Symbol NameOrType .

    $default  reduce using rule 235 (ArgType)


state 322

  236 ArgType: Symbol Ddd .

    $default  reduce using rule 236 (ArgType)


state 323

  141 NameOrType: . Type
  148 Symbol: . IDENT
  149 Name: . Symbol
  151 Ddd: . DDD
  152    | . DDD Type
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  234 ArgType: . NameOrType
  235        | . Symbol NameOrType
  236        | . Symbol Ddd
  237        | . Ddd
  239 ArgTypeList: ArgTypeList ',' . ArgType
  280 oComma: ',' .  [')']

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    DDD        shift, and go to state 210
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    $default  reduce using rule 280 (oComma)

    NameOrType     go to state 211
    Symbol         go to state 212
    Name           go to state 95
    Ddd            go to state 213
    Type           go to state 214
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199
    ArgType        go to state 398


state 324

  241 oArgTypeListOComma: ArgTypeList oComma .

    $default  reduce using rule 241 (oArgTypeListOComma)


state 325

  148 Symbol: . IDENT
  149 Name: . Symbol
  171 FuncRetType: . RecvChanType
  172            | . FuncType
  173            | . OtherType
  174            | . PtrType
  175            | . TypeName
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  199 FuncDecl1: '(' oArgTypeListOComma ')' . Symbol '(' oArgTypeListOComma ')' FuncResult
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  200         | FUNC '(' oArgTypeListOComma ')' . FuncResult
  203 FuncResult: .  [error, BODY, '{']
  204           | . FuncRetType
  205           | . '(' oArgTypeListOComma ')'

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 399
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    $default  reduce using rule 203 (FuncResult)

    Symbol         go to state 400
    Name           go to state 95
    FuncRetType    go to state 401
    TypeName       go to state 402
    OtherType      go to state 403
    PtrType        go to state 404
    RecvChanType   go to state 405
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 406
    FuncResult     go to state 407

    Conflict between rule 203 and token '(' resolved as shift (notParen < '(').


state 326

  198 FuncDecl1: Symbol '(' oArgTypeListOComma . ')' FuncResult

    ')'  shift, and go to state 408


state 327

  202 FuncBody: '{' StmtList . '}'
  262 StmtList: StmtList . ';' Statement

    ';'  shift, and go to state 390
    '}'  shift, and go to state 409


state 328

   70 $@7: .
   71 IfStmt: IF $@6 IfHeader LoopBody . $@7 ElseIfList Else

    $default  reduce using rule 70 ($@7)

    $@7  go to state 410


state 329

   41 SimpleStmt: . Expr
   42           | . Expr ASOP Expr
   43           | . ExprList '=' ExprList
   44           | . ExprList COLAS ExprList
   45           | . Expr INC
   46           | . Expr DEC
   68 IfHeader: oSimpleStmt ';' . oSimpleStmt
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  267 ExprList: . Expr
  268         | . ExprList ',' Expr
  285 oSimpleStmt: .  [BODY]
  286            | . SimpleStmt

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    $default  reduce using rule 285 (oSimpleStmt)

    SimpleStmt          go to state 204
    Expr                go to state 60
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprList            go to state 81
    oSimpleStmt         go to state 411


state 330

  148 Symbol: . IDENT
  228 Qualident: IDENT '.' . Symbol

    IDENT  shift, and go to state 4

    Symbol  go to state 412


state 331

  227 Qualident: IDENT .  [LITERAL, ')', ';', '}']
  228          | IDENT . '.' Symbol

    '.'  shift, and go to state 330

    $default  reduce using rule 227 (Qualident)


state 332

  232 InterfaceDecl: '(' Qualident . ')'

    ')'  shift, and go to state 413


state 333

  141 NameOrType: . Type
  148 Symbol: . IDENT
  149 Name: . Symbol
  151 Ddd: . DDD
  152    | . DDD Type
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  233 InterfaceMethodDecl: '(' . oArgTypeListOComma ')' FuncResult
  234 ArgType: . NameOrType
  235        | . Symbol NameOrType
  236        | . Symbol Ddd
  237        | . Ddd
  238 ArgTypeList: . ArgType
  239            | . ArgTypeList ',' ArgType
  240 oArgTypeListOComma: .  [')']
  241                   | . ArgTypeList oComma

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    DDD        shift, and go to state 210
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    $default  reduce using rule 240 (oArgTypeListOComma)

    NameOrType          go to state 211
    Symbol              go to state 212
    Name                go to state 95
    Ddd                 go to state 213
    Type                go to state 214
    TypeName            go to state 195
    OtherType           go to state 196
    PtrType             go to state 197
    RecvChanType        go to state 198
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 199
    ArgType             go to state 215
    ArgTypeList         go to state 216
    oArgTypeListOComma  go to state 414


state 334

  230 InterfaceDecl: NewName InterfaceMethodDecl .

    $default  reduce using rule 230 (InterfaceDecl)


state 335

  144 NewName: . Symbol
  148 Symbol: . IDENT
  220 InterfaceDeclList: InterfaceDeclList ';' . InterfaceDecl
  227 Qualident: . IDENT
  228          | . IDENT '.' Symbol
  230 InterfaceDecl: . NewName InterfaceMethodDecl
  231              | . Qualident
  232              | . '(' Qualident ')'
  278 oSemi: ';' .  ['}']

    IDENT  shift, and go to state 223
    '('    shift, and go to state 224

    $default  reduce using rule 278 (oSemi)

    NewName        go to state 226
    Symbol         go to state 89
    Qualident      go to state 228
    InterfaceDecl  go to state 415


state 336

  195 InterfaceType: INTERFACE LBrace InterfaceDeclList oSemi . '}'

    '}'  shift, and go to state 416


state 337

  148 Symbol: . IDENT
  149 Name: . Symbol
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  182          | MAP '[' Type ']' . Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    Symbol         go to state 94
    Name           go to state 95
    Type           go to state 417
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199


state 338

   47 Case: . CASE ExprOrTypeList ':'
   48     | . CASE ExprOrTypeList '=' Expr ':'
   49     | . CASE ExprOrTypeList COLAS Expr ':'
   50     | . DEFAULT ':'
   54 CaseBlock: . Case $@3 StmtList
   56 CaseBlockList: CaseBlockList . CaseBlock
   82 SelectStmt: SELECT $@11 BODY CaseBlockList . '}'

    CASE     shift, and go to state 418
    DEFAULT  shift, and go to state 419
    '}'      shift, and go to state 420

    Case       go to state 421
    CaseBlock  go to state 422


state 339

  225 StructDecl: '(' '*' . Embedded ')' oLiteral
  227 Qualident: . IDENT
  228          | . IDENT '.' Symbol
  229 Embedded: . Qualident

    IDENT  shift, and go to state 331

    Qualident  go to state 238
    Embedded   go to state 423


state 340

  223 StructDecl: '(' Embedded . ')' oLiteral

    ')'  shift, and go to state 424


state 341

  226 StructDecl: '*' '(' . Embedded ')' oLiteral
  227 Qualident: . IDENT
  228          | . IDENT '.' Symbol
  229 Embedded: . Qualident

    IDENT  shift, and go to state 331

    Qualident  go to state 238
    Embedded   go to state 425


state 342

  224 StructDecl: '*' Embedded . oLiteral
  287 oLiteral: .  [';', '}']
  288         | . LITERAL

    LITERAL  shift, and go to state 345

    $default  reduce using rule 287 (oLiteral)

    oLiteral  go to state 426


state 343

  144 NewName: . Symbol
  148 Symbol: . IDENT
  218 StructDeclList: StructDeclList ';' . StructDecl
  221 StructDecl: . NewNameList Type oLiteral
  222           | . Embedded oLiteral
  223           | . '(' Embedded ')' oLiteral
  224           | . '*' Embedded oLiteral
  225           | . '(' '*' Embedded ')' oLiteral
  226           | . '*' '(' Embedded ')' oLiteral
  227 Qualident: . IDENT
  228          | . IDENT '.' Symbol
  229 Embedded: . Qualident
  263 NewNameList: . NewName
  264            | . NewNameList ',' NewName
  278 oSemi: ';' .  ['}']

    IDENT  shift, and go to state 223
    '('    shift, and go to state 232
    '*'    shift, and go to state 233

    $default  reduce using rule 278 (oSemi)

    NewName      go to state 235
    Symbol       go to state 89
    StructDecl   go to state 427
    Qualident    go to state 238
    Embedded     go to state 239
    NewNameList  go to state 240


state 344

  189 StructType: STRUCT LBrace StructDeclList oSemi . '}'

    '}'  shift, and go to state 428


state 345

  288 oLiteral: LITERAL .

    $default  reduce using rule 288 (oLiteral)


state 346

  222 StructDecl: Embedded oLiteral .

    $default  reduce using rule 222 (StructDecl)


state 347

  144 NewName: . Symbol
  148 Symbol: . IDENT
  264 NewNameList: NewNameList ',' . NewName

    IDENT  shift, and go to state 4

    NewName  go to state 429
    Symbol   go to state 89


state 348

  221 StructDecl: NewNameList Type . oLiteral
  287 oLiteral: .  [';', '}']
  288         | . LITERAL

    LITERAL  shift, and go to state 345

    $default  reduce using rule 287 (oLiteral)

    oLiteral  go to state 430


state 349

   55 CaseBlockList: .
   56              | . CaseBlockList CaseBlock
   80 SwitchStmt: SWITCH $@10 IfHeader BODY . CaseBlockList '}'

    $default  reduce using rule 55 (CaseBlockList)

    CaseBlockList  go to state 431


state 350

   39 TypeDeclName: . Symbol
   40 TypeDecl: . TypeDeclName Type
  148 Symbol: . IDENT
  216 TypeDeclList: TypeDeclList ';' . TypeDecl
  278 oSemi: ';' .  [')']

    IDENT  shift, and go to state 4

    $default  reduce using rule 278 (oSemi)

    TypeDeclName  go to state 123
    TypeDecl      go to state 432
    Symbol        go to state 125


state 351

   28 CommonDecl: TYPE '(' TypeDeclList oSemi . ')'

    ')'  shift, and go to state 433


state 352

  191 UnionType: UNION LBrace StructDeclList oSemi . '}'

    '}'  shift, and go to state 434


state 353

   31 VarDecl: . DeclNameList Type
   32        | . DeclNameList Type '=' ExprList
   33        | . DeclNameList '=' ExprList
  145 DeclName: . Symbol
  148 Symbol: . IDENT
  212 VarDeclList: VarDeclList ';' . VarDecl
  265 DeclNameList: . DeclName
  266             | . DeclNameList ',' DeclName
  278 oSemi: ';' .  [')']

    IDENT  shift, and go to state 4

    $default  reduce using rule 278 (oSemi)

    VarDecl       go to state 435
    DeclName      go to state 129
    Symbol        go to state 130
    DeclNameList  go to state 131


state 354

   21 CommonDecl: VAR '(' VarDeclList oSemi . ')'

    ')'  shift, and go to state 436


state 355

   33 VarDecl: DeclNameList '=' ExprList .  [CASE, DEFAULT, ')', ';', '}']
  268 ExprList: ExprList . ',' Expr

    ','  shift, and go to state 189

    $default  reduce using rule 33 (VarDecl)


state 356

  266 DeclNameList: DeclNameList ',' DeclName .

    $default  reduce using rule 266 (DeclNameList)


state 357

   32 VarDecl: DeclNameList Type '=' . ExprList
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  267 ExprList: . Expr
  268         | . ExprList ',' Expr

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 116
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprList            go to state 437


state 358

  193 VariantType: VARIANT LBrace StructDeclList oSemi . '}'

    '}'  shift, and go to state 438


state 359

  148 Symbol: . IDENT
  149 Name: . Symbol
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  181          | CHAN COMM . Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  188             | COMM . CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult

    CHAN       shift, and go to state 256
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    Symbol         go to state 94
    Name           go to state 95
    Type           go to state 194
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199


state 360

  148 Symbol: . IDENT
  149 Name: . Symbol
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  158     | '(' . Type ')'
  167 NonRecvChanType: '(' . Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    Symbol         go to state 94
    Name           go to state 95
    Type           go to state 439
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199


state 361

  188 RecvChanType: COMM CHAN Type .

    $default  reduce using rule 188 (RecvChanType)


state 362

  157 Type: TypeName .  [COLAS, DDD, ')', ':', '=', ',']
  166 NonRecvChanType: TypeName .  [BODY, '(', '{']

    BODY      reduce using rule 166 (NonRecvChanType)
    '('       reduce using rule 166 (NonRecvChanType)
    '{'       reduce using rule 166 (NonRecvChanType)
    $default  reduce using rule 157 (Type)


state 363

  155 Type: OtherType .  [COLAS, DDD, ')', ':', '=', ',']
  164 NonRecvChanType: OtherType .  [BODY, '(', '{']

    BODY      reduce using rule 164 (NonRecvChanType)
    '('       reduce using rule 164 (NonRecvChanType)
    '{'       reduce using rule 164 (NonRecvChanType)
    $default  reduce using rule 155 (Type)


state 364

  156 Type: PtrType .  [COLAS, DDD, ')', ':', '=', ',']
  165 NonRecvChanType: PtrType .  [BODY, '(', '{']

    BODY      reduce using rule 165 (NonRecvChanType)
    '('       reduce using rule 165 (NonRecvChanType)
    '{'       reduce using rule 165 (NonRecvChanType)
    $default  reduce using rule 156 (Type)


state 365

  154 Type: FuncType .  [COLAS, DDD, ')', ':', '=', ',']
  163 NonRecvChanType: FuncType .  [BODY, '(', '{']

    BODY      reduce using rule 163 (NonRecvChanType)
    '('       reduce using rule 163 (NonRecvChanType)
    '{'       reduce using rule 163 (NonRecvChanType)
    $default  reduce using rule 154 (Type)


state 366

  129 PrimaryExprNoParen: '(' ExprOrType ')' '{' . StartCompLit BracedKeyvalList '}'
  131 StartCompLit: .

    $default  reduce using rule 131 (StartCompLit)

    StartCompLit  go to state 440


state 367

  179 OtherType: '[' DDD ']' Type .

    $default  reduce using rule 179 (OtherType)


state 368

  178 OtherType: '[' oExpr ']' Type .

    $default  reduce using rule 178 (OtherType)


state 369

   25 CommonDecl: Const '(' ConstDecl ';' . ConstDeclList oSemi ')'
   34 ConstDecl: . DeclNameList Type '=' ExprList
   35          | . DeclNameList '=' ExprList
   36 ConstDecl1: . ConstDecl
   37           | . DeclNameList Type
   38           | . DeclNameList
  145 DeclName: . Symbol
  148 Symbol: . IDENT
  213 ConstDeclList: . ConstDecl1
  214              | . ConstDeclList ';' ConstDecl1
  265 DeclNameList: . DeclName
  266             | . DeclNameList ',' DeclName
  278 oSemi: ';' .  [')']

    IDENT  shift, and go to state 4

    $default  reduce using rule 278 (oSemi)

    ConstDecl      go to state 441
    ConstDecl1     go to state 442
    DeclName       go to state 129
    Symbol         go to state 130
    ConstDeclList  go to state 443
    DeclNameList   go to state 444


state 370

   24 CommonDecl: Const '(' ConstDecl oSemi . ')'

    ')'  shift, and go to state 445


state 371

   35 ConstDecl: DeclNameList '=' ExprList .  [CASE, DEFAULT, ')', ';', '}']
  268 ExprList: ExprList . ',' Expr

    ','  shift, and go to state 189

    $default  reduce using rule 35 (ConstDecl)


state 372

   34 ConstDecl: DeclNameList Type '=' . ExprList
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  267 ExprList: . Expr
  268         | . ExprList ',' Expr

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 116
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprList            go to state 446


state 373

  131 StartCompLit: .
  134 BareCompLitExpr: '{' . StartCompLit BracedKeyvalList '}'

    $default  reduce using rule 131 (StartCompLit)

    StartCompLit  go to state 447


state 374

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr
  132 Keyval: Expr . ':' CompLitExpr
  133 BareCompLitExpr: Expr .  ['}', ',']

    ANDAND  shift, and go to state 155
    ANDNOT  shift, and go to state 156
    COMM    shift, and go to state 158
    EQ      shift, and go to state 160
    GE      shift, and go to state 161
    LE      shift, and go to state 163
    LSH     shift, and go to state 164
    NE      shift, and go to state 165
    OROR    shift, and go to state 166
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    ':'     shift, and go to state 448
    '<'     shift, and go to state 174
    '>'     shift, and go to state 175
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    $default  reduce using rule 133 (BareCompLitExpr)


state 375

  271 KeyvalList: Keyval .

    $default  reduce using rule 271 (KeyvalList)


state 376

  272 KeyvalList: BareCompLitExpr .

    $default  reduce using rule 272 (KeyvalList)


state 377

  273 KeyvalList: KeyvalList . ',' Keyval
  274           | KeyvalList . ',' BareCompLitExpr
  276 BracedKeyvalList: KeyvalList . oComma
  279 oComma: .  ['}']
  280       | . ','

    ','  shift, and go to state 449

    $default  reduce using rule 279 (oComma)

    oComma  go to state 450


state 378

  128 PrimaryExprNoParen: PrimaryExprNoParen '{' StartCompLit BracedKeyvalList . '}'

    '}'  shift, and go to state 451


state 379

  115 PseudoCall: PrimaryExpr '(' ExprOrTypeList DDD . oComma ')'
  279 oComma: .  [')']
  280       | . ','

    ','  shift, and go to state 452

    $default  reduce using rule 279 (oComma)

    oComma  go to state 453


state 380

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  139 ExprOrType: . Expr
  140           | . NonExprType
  148 Symbol: . IDENT
  149 Name: . Symbol
  159 NonExprType: . RecvChanType
  160            | . FuncType
  161            | . OtherType
  162            | . '*' NonExprType
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  270 ExprOrTypeList: ExprOrTypeList ',' . ExprOrType
  280 oComma: ',' .  [')']

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 135
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 136
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    $default  reduce using rule 280 (oComma)

    Expr                go to state 137
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    ExprOrType          go to state 454
    Symbol              go to state 94
    Name                go to state 67
    NonExprType         go to state 139
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 140
    RecvChanType        go to state 141
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 142
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 381

  114 PseudoCall: PrimaryExpr '(' ExprOrTypeList oComma . ')'

    ')'  shift, and go to state 455


state 382

  120 PrimaryExprNoParen: PrimaryExpr '.' '(' TYPE . ')'

    ')'  shift, and go to state 456


state 383

  119 PrimaryExprNoParen: PrimaryExpr '.' '(' ExprOrType . ')'

    ')'  shift, and go to state 457


state 384

  121 PrimaryExprNoParen: PrimaryExpr '[' Expr ']' .

    $default  reduce using rule 121 (PrimaryExprNoParen)


state 385

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  122                   | PrimaryExpr '[' oExpr ':' . oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  123                   | PrimaryExpr '[' oExpr ':' . oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  281 oExpr: .  [':', ']']
  282      | . Expr

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    $default  reduce using rule 281 (oExpr)

    Expr                go to state 147
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    oExpr               go to state 458


state 386

   20 CommonDecl: . VAR VarDecl
   21           | . VAR '(' VarDeclList oSemi ')'
   22           | . VAR '(' ')'
   23           | . Const ConstDecl
   24           | . Const '(' ConstDecl oSemi ')'
   25           | . Const '(' ConstDecl ';' ConstDeclList oSemi ')'
   26           | . Const '(' ')'
   27           | . TYPE TypeDecl
   28           | . TYPE '(' TypeDeclList oSemi ')'
   29           | . TYPE '(' ')'
   30 Const: . CONST
   41 SimpleStmt: . Expr
   42           | . Expr ASOP Expr
   43           | . ExprList '=' ExprList
   44           | . ExprList COLAS ExprList
   45           | . Expr INC
   46           | . Expr DEC
   52 CompoundStmt: . '{' $@2 StmtList '}'
   52             | '{' $@2 . StmtList '}'
   66 ForStmt: . FOR $@5 ForBody
   71 IfStmt: . IF $@6 IfHeader LoopBody $@7 ElseIfList Else
   80 SwitchStmt: . SWITCH $@10 IfHeader BODY CaseBlockList '}'
   82 SelectStmt: . SELECT $@11 BODY CaseBlockList '}'
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  144 NewName: . Symbol
  148 Symbol: . IDENT
  149 Name: . Symbol
  150 LabelName: . NewName
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  242 Statement: .  [';', '}']
  243          | . CompoundStmt
  244          | . CommonDecl
  245          | . NonDclStmt
  246          | . error
  247 NonDclStmt: . SimpleStmt
  248           | . ForStmt
  249           | . SwitchStmt
  250           | . SelectStmt
  251           | . IfStmt
  252           | . LabelName ':' Statement
  253           | . FALL
  254           | . BREAK oNewName
  255           | . CONTINUE oNewName
  256           | . GO PseudoCall
  257           | . DEFER PseudoCall
  258           | . GOTO NewName
  259           | . GOTO
  260           | . RETURN oExprList
  261 StmtList: . Statement
  262         | . StmtList ';' Statement
  267 ExprList: . Expr
  268         | . ExprList ',' Expr

    error      shift, and go to state 294
    BREAK      shift, and go to state 20
    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    CONST      shift, and go to state 23
    CONTINUE   shift, and go to state 24
    DEFER      shift, and go to state 25
    FALL       shift, and go to state 26
    FOR        shift, and go to state 27
    FUNC       shift, and go to state 91
    GO         shift, and go to state 29
    GOTO       shift, and go to state 30
    IDENT      shift, and go to state 4
    IF         shift, and go to state 31
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    RETURN     shift, and go to state 35
    SELECT     shift, and go to state 36
    STRUCT     shift, and go to state 37
    SWITCH     shift, and go to state 38
    TYPE       shift, and go to state 39
    UNION      shift, and go to state 40
    VAR        shift, and go to state 41
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '{'        shift, and go to state 295
    '~'        shift, and go to state 51

    ';'  reduce using rule 242 (Statement)
    '}'  reduce using rule 242 (Statement)

    CommonDecl          go to state 296
    Const               go to state 54
    SimpleStmt          go to state 55
    CompoundStmt        go to state 297
    ForStmt             go to state 56
    IfStmt              go to state 57
    SwitchStmt          go to state 58
    SelectStmt          go to state 59
    Expr                go to state 60
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    NewName             go to state 65
    Symbol              go to state 66
    Name                go to state 67
    LabelName           go to state 68
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    Statement           go to state 303
    NonDclStmt          go to state 299
    StmtList            go to state 459
    ExprList            go to state 81


state 387

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  268 ExprList: ExprList ',' . Expr
  280 oComma: ',' .  [')']

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    $default  reduce using rule 280 (oComma)

    Expr                go to state 307
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 388

  125 PrimaryExprNoParen: ConvType '(' ExprList oComma . ')'

    ')'  shift, and go to state 460


state 389

  127 PrimaryExprNoParen: CompLitType LBrace StartCompLit BracedKeyvalList . '}'

    '}'  shift, and go to state 461


state 390

   20 CommonDecl: . VAR VarDecl
   21           | . VAR '(' VarDeclList oSemi ')'
   22           | . VAR '(' ')'
   23           | . Const ConstDecl
   24           | . Const '(' ConstDecl oSemi ')'
   25           | . Const '(' ConstDecl ';' ConstDeclList oSemi ')'
   26           | . Const '(' ')'
   27           | . TYPE TypeDecl
   28           | . TYPE '(' TypeDeclList oSemi ')'
   29           | . TYPE '(' ')'
   30 Const: . CONST
   41 SimpleStmt: . Expr
   42           | . Expr ASOP Expr
   43           | . ExprList '=' ExprList
   44           | . ExprList COLAS ExprList
   45           | . Expr INC
   46           | . Expr DEC
   52 CompoundStmt: . '{' $@2 StmtList '}'
   66 ForStmt: . FOR $@5 ForBody
   71 IfStmt: . IF $@6 IfHeader LoopBody $@7 ElseIfList Else
   80 SwitchStmt: . SWITCH $@10 IfHeader BODY CaseBlockList '}'
   82 SelectStmt: . SELECT $@11 BODY CaseBlockList '}'
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  144 NewName: . Symbol
  148 Symbol: . IDENT
  149 Name: . Symbol
  150 LabelName: . NewName
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  242 Statement: .  [CASE, DEFAULT, ';', '}']
  243          | . CompoundStmt
  244          | . CommonDecl
  245          | . NonDclStmt
  246          | . error
  247 NonDclStmt: . SimpleStmt
  248           | . ForStmt
  249           | . SwitchStmt
  250           | . SelectStmt
  251           | . IfStmt
  252           | . LabelName ':' Statement
  253           | . FALL
  254           | . BREAK oNewName
  255           | . CONTINUE oNewName
  256           | . GO PseudoCall
  257           | . DEFER PseudoCall
  258           | . GOTO NewName
  259           | . GOTO
  260           | . RETURN oExprList
  262 StmtList: StmtList ';' . Statement
  267 ExprList: . Expr
  268         | . ExprList ',' Expr

    error      shift, and go to state 294
    BREAK      shift, and go to state 20
    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    CONST      shift, and go to state 23
    CONTINUE   shift, and go to state 24
    DEFER      shift, and go to state 25
    FALL       shift, and go to state 26
    FOR        shift, and go to state 27
    FUNC       shift, and go to state 91
    GO         shift, and go to state 29
    GOTO       shift, and go to state 30
    IDENT      shift, and go to state 4
    IF         shift, and go to state 31
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    RETURN     shift, and go to state 35
    SELECT     shift, and go to state 36
    STRUCT     shift, and go to state 37
    SWITCH     shift, and go to state 38
    TYPE       shift, and go to state 39
    UNION      shift, and go to state 40
    VAR        shift, and go to state 41
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '{'        shift, and go to state 295
    '~'        shift, and go to state 51

    CASE     reduce using rule 242 (Statement)
    DEFAULT  reduce using rule 242 (Statement)
    ';'      reduce using rule 242 (Statement)
    '}'      reduce using rule 242 (Statement)

    CommonDecl          go to state 296
    Const               go to state 54
    SimpleStmt          go to state 55
    CompoundStmt        go to state 297
    ForStmt             go to state 56
    IfStmt              go to state 57
    SwitchStmt          go to state 58
    SelectStmt          go to state 59
    Expr                go to state 60
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    NewName             go to state 65
    Symbol              go to state 66
    Name                go to state 67
    LabelName           go to state 68
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    Statement           go to state 462
    NonDclStmt          go to state 299
    ExprList            go to state 81


state 391

  207 FuncLit: FuncLitDecl LBrace StmtList '}' .

    $default  reduce using rule 207 (FuncLit)


state 392

  158 Type: '(' Type ')' .

    $default  reduce using rule 158 (Type)


state 393

  148 Symbol: . IDENT
  149 Name: . Symbol
  171 FuncRetType: . RecvChanType
  172            | . FuncType
  173            | . OtherType
  174            | . PtrType
  175            | . TypeName
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  200         | FUNC '(' oArgTypeListOComma ')' . FuncResult
  203 FuncResult: .  [error, BODY, CASE, COLAS, DDD, DEFAULT, LITERAL, ')', ':', ';', '=', '{', '}', ']', ',']
  204           | . FuncRetType
  205           | . '(' oArgTypeListOComma ')'

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 399
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    $default  reduce using rule 203 (FuncResult)

    Symbol         go to state 94
    Name           go to state 95
    FuncRetType    go to state 401
    TypeName       go to state 402
    OtherType      go to state 403
    PtrType        go to state 404
    RecvChanType   go to state 405
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 406
    FuncResult     go to state 407

    Conflict between rule 203 and token '(' resolved as shift (notParen < '(').


state 394

   20 CommonDecl: . VAR VarDecl
   21           | . VAR '(' VarDeclList oSemi ')'
   22           | . VAR '(' ')'
   23           | . Const ConstDecl
   24           | . Const '(' ConstDecl oSemi ')'
   25           | . Const '(' ConstDecl ';' ConstDeclList oSemi ')'
   26           | . Const '(' ')'
   27           | . TYPE TypeDecl
   28           | . TYPE '(' TypeDeclList oSemi ')'
   29           | . TYPE '(' ')'
   30 Const: . CONST
   41 SimpleStmt: . Expr
   42           | . Expr ASOP Expr
   43           | . ExprList '=' ExprList
   44           | . ExprList COLAS ExprList
   45           | . Expr INC
   46           | . Expr DEC
   52 CompoundStmt: . '{' $@2 StmtList '}'
   58 LoopBody: BODY $@4 . StmtList '}'
   66 ForStmt: . FOR $@5 ForBody
   71 IfStmt: . IF $@6 IfHeader LoopBody $@7 ElseIfList Else
   80 SwitchStmt: . SWITCH $@10 IfHeader BODY CaseBlockList '}'
   82 SelectStmt: . SELECT $@11 BODY CaseBlockList '}'
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  144 NewName: . Symbol
  148 Symbol: . IDENT
  149 Name: . Symbol
  150 LabelName: . NewName
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  242 Statement: .  [';', '}']
  243          | . CompoundStmt
  244          | . CommonDecl
  245          | . NonDclStmt
  246          | . error
  247 NonDclStmt: . SimpleStmt
  248           | . ForStmt
  249           | . SwitchStmt
  250           | . SelectStmt
  251           | . IfStmt
  252           | . LabelName ':' Statement
  253           | . FALL
  254           | . BREAK oNewName
  255           | . CONTINUE oNewName
  256           | . GO PseudoCall
  257           | . DEFER PseudoCall
  258           | . GOTO NewName
  259           | . GOTO
  260           | . RETURN oExprList
  261 StmtList: . Statement
  262         | . StmtList ';' Statement
  267 ExprList: . Expr
  268         | . ExprList ',' Expr

    error      shift, and go to state 294
    BREAK      shift, and go to state 20
    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    CONST      shift, and go to state 23
    CONTINUE   shift, and go to state 24
    DEFER      shift, and go to state 25
    FALL       shift, and go to state 26
    FOR        shift, and go to state 27
    FUNC       shift, and go to state 91
    GO         shift, and go to state 29
    GOTO       shift, and go to state 30
    IDENT      shift, and go to state 4
    IF         shift, and go to state 31
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    RETURN     shift, and go to state 35
    SELECT     shift, and go to state 36
    STRUCT     shift, and go to state 37
    SWITCH     shift, and go to state 38
    TYPE       shift, and go to state 39
    UNION      shift, and go to state 40
    VAR        shift, and go to state 41
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '{'        shift, and go to state 295
    '~'        shift, and go to state 51

    ';'  reduce using rule 242 (Statement)
    '}'  reduce using rule 242 (Statement)

    CommonDecl          go to state 296
    Const               go to state 54
    SimpleStmt          go to state 55
    CompoundStmt        go to state 297
    ForStmt             go to state 56
    IfStmt              go to state 57
    SwitchStmt          go to state 58
    SelectStmt          go to state 59
    Expr                go to state 60
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    NewName             go to state 65
    Symbol              go to state 66
    Name                go to state 67
    LabelName           go to state 68
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    Statement           go to state 303
    NonDclStmt          go to state 299
    StmtList            go to state 463
    ExprList            go to state 81


state 395

   60 RangeStmt: ExprList COLAS RANGE . Expr
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 464
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 396

   59 RangeStmt: ExprList '=' RANGE . Expr
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 465
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 397

   61 ForHeader: oSimpleStmt ';' oSimpleStmt . ';' oSimpleStmt

    ';'  shift, and go to state 466


state 398

  239 ArgTypeList: ArgTypeList ',' ArgType .

    $default  reduce using rule 239 (ArgTypeList)


state 399

  141 NameOrType: . Type
  148 Symbol: . IDENT
  149 Name: . Symbol
  151 Ddd: . DDD
  152    | . DDD Type
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  205 FuncResult: '(' . oArgTypeListOComma ')'
  234 ArgType: . NameOrType
  235        | . Symbol NameOrType
  236        | . Symbol Ddd
  237        | . Ddd
  238 ArgTypeList: . ArgType
  239            | . ArgTypeList ',' ArgType
  240 oArgTypeListOComma: .  [')']
  241                   | . ArgTypeList oComma

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    DDD        shift, and go to state 210
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    $default  reduce using rule 240 (oArgTypeListOComma)

    NameOrType          go to state 211
    Symbol              go to state 212
    Name                go to state 95
    Ddd                 go to state 213
    Type                go to state 214
    TypeName            go to state 195
    OtherType           go to state 196
    PtrType             go to state 197
    RecvChanType        go to state 198
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 199
    ArgType             go to state 215
    ArgTypeList         go to state 216
    oArgTypeListOComma  go to state 467


state 400

  149 Name: Symbol .  [error, BODY, '.', '{']
  199 FuncDecl1: '(' oArgTypeListOComma ')' Symbol . '(' oArgTypeListOComma ')' FuncResult

    '('  shift, and go to state 468

    $default  reduce using rule 149 (Name)

    Conflict between rule 149 and token '(' resolved as shift (notParen < '(').


state 401

  204 FuncResult: FuncRetType .

    $default  reduce using rule 204 (FuncResult)


state 402

  175 FuncRetType: TypeName .

    $default  reduce using rule 175 (FuncRetType)


state 403

  173 FuncRetType: OtherType .

    $default  reduce using rule 173 (FuncRetType)


state 404

  174 FuncRetType: PtrType .

    $default  reduce using rule 174 (FuncRetType)


state 405

  171 FuncRetType: RecvChanType .

    $default  reduce using rule 171 (FuncRetType)


state 406

  172 FuncRetType: FuncType .

    $default  reduce using rule 172 (FuncRetType)


state 407

  200 FuncType: FUNC '(' oArgTypeListOComma ')' FuncResult .

    $default  reduce using rule 200 (FuncType)


state 408

  148 Symbol: . IDENT
  149 Name: . Symbol
  171 FuncRetType: . RecvChanType
  172            | . FuncType
  173            | . OtherType
  174            | . PtrType
  175            | . TypeName
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  198 FuncDecl1: Symbol '(' oArgTypeListOComma ')' . FuncResult
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  203 FuncResult: .  [';', '{']
  204           | . FuncRetType
  205           | . '(' oArgTypeListOComma ')'

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 399
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    $default  reduce using rule 203 (FuncResult)

    Symbol         go to state 94
    Name           go to state 95
    FuncRetType    go to state 401
    TypeName       go to state 402
    OtherType      go to state 403
    PtrType        go to state 404
    RecvChanType   go to state 405
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 406
    FuncResult     go to state 469


state 409

  202 FuncBody: '{' StmtList '}' .

    $default  reduce using rule 202 (FuncBody)


state 410

   71 IfStmt: IF $@6 IfHeader LoopBody $@7 . ElseIfList Else
   74 ElseIfList: .
   75           | . ElseIfList ElseIf

    $default  reduce using rule 74 (ElseIfList)

    ElseIfList  go to state 470


state 411

   68 IfHeader: oSimpleStmt ';' oSimpleStmt .

    $default  reduce using rule 68 (IfHeader)


state 412

  228 Qualident: IDENT '.' Symbol .

    $default  reduce using rule 228 (Qualident)


state 413

  232 InterfaceDecl: '(' Qualident ')' .

    $default  reduce using rule 232 (InterfaceDecl)


state 414

  233 InterfaceMethodDecl: '(' oArgTypeListOComma . ')' FuncResult

    ')'  shift, and go to state 471


state 415

  220 InterfaceDeclList: InterfaceDeclList ';' InterfaceDecl .

    $default  reduce using rule 220 (InterfaceDeclList)


state 416

  195 InterfaceType: INTERFACE LBrace InterfaceDeclList oSemi '}' .

    $default  reduce using rule 195 (InterfaceType)


state 417

  182 OtherType: MAP '[' Type ']' Type .

    $default  reduce using rule 182 (OtherType)


state 418

   47 Case: CASE . ExprOrTypeList ':'
   48     | CASE . ExprOrTypeList '=' Expr ':'
   49     | CASE . ExprOrTypeList COLAS Expr ':'
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  139 ExprOrType: . Expr
  140           | . NonExprType
  148 Symbol: . IDENT
  149 Name: . Symbol
  159 NonExprType: . RecvChanType
  160            | . FuncType
  161            | . OtherType
  162            | . '*' NonExprType
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  269 ExprOrTypeList: . ExprOrType
  270               | . ExprOrTypeList ',' ExprOrType

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 135
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 136
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 137
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    ExprOrType          go to state 288
    Symbol              go to state 94
    Name                go to state 67
    NonExprType         go to state 139
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 140
    RecvChanType        go to state 141
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 142
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprOrTypeList      go to state 472


state 419

   50 Case: DEFAULT . ':'

    ':'  shift, and go to state 473


state 420

   82 SelectStmt: SELECT $@11 BODY CaseBlockList '}' .

    $default  reduce using rule 82 (SelectStmt)


state 421

   53 $@3: .
   54 CaseBlock: Case . $@3 StmtList

    $default  reduce using rule 53 ($@3)

    $@3  go to state 474


state 422

   56 CaseBlockList: CaseBlockList CaseBlock .

    $default  reduce using rule 56 (CaseBlockList)


state 423

  225 StructDecl: '(' '*' Embedded . ')' oLiteral

    ')'  shift, and go to state 475


state 424

  223 StructDecl: '(' Embedded ')' . oLiteral
  287 oLiteral: .  [';', '}']
  288         | . LITERAL

    LITERAL  shift, and go to state 345

    $default  reduce using rule 287 (oLiteral)

    oLiteral  go to state 476


state 425

  226 StructDecl: '*' '(' Embedded . ')' oLiteral

    ')'  shift, and go to state 477


state 426

  224 StructDecl: '*' Embedded oLiteral .

    $default  reduce using rule 224 (StructDecl)


state 427

  218 StructDeclList: StructDeclList ';' StructDecl .

    $default  reduce using rule 218 (StructDeclList)


state 428

  189 StructType: STRUCT LBrace StructDeclList oSemi '}' .

    $default  reduce using rule 189 (StructType)


state 429

  264 NewNameList: NewNameList ',' NewName .

    $default  reduce using rule 264 (NewNameList)


state 430

  221 StructDecl: NewNameList Type oLiteral .

    $default  reduce using rule 221 (StructDecl)


state 431

   47 Case: . CASE ExprOrTypeList ':'
   48     | . CASE ExprOrTypeList '=' Expr ':'
   49     | . CASE ExprOrTypeList COLAS Expr ':'
   50     | . DEFAULT ':'
   54 CaseBlock: . Case $@3 StmtList
   56 CaseBlockList: CaseBlockList . CaseBlock
   80 SwitchStmt: SWITCH $@10 IfHeader BODY CaseBlockList . '}'

    CASE     shift, and go to state 418
    DEFAULT  shift, and go to state 419
    '}'      shift, and go to state 478

    Case       go to state 421
    CaseBlock  go to state 422


state 432

  216 TypeDeclList: TypeDeclList ';' TypeDecl .

    $default  reduce using rule 216 (TypeDeclList)


state 433

   28 CommonDecl: TYPE '(' TypeDeclList oSemi ')' .

    $default  reduce using rule 28 (CommonDecl)


state 434

  191 UnionType: UNION LBrace StructDeclList oSemi '}' .

    $default  reduce using rule 191 (UnionType)


state 435

  212 VarDeclList: VarDeclList ';' VarDecl .

    $default  reduce using rule 212 (VarDeclList)


state 436

   21 CommonDecl: VAR '(' VarDeclList oSemi ')' .

    $default  reduce using rule 21 (CommonDecl)


state 437

   32 VarDecl: DeclNameList Type '=' ExprList .  [CASE, DEFAULT, ')', ';', '}']
  268 ExprList: ExprList . ',' Expr

    ','  shift, and go to state 189

    $default  reduce using rule 32 (VarDecl)


state 438

  193 VariantType: VARIANT LBrace StructDeclList oSemi '}' .

    $default  reduce using rule 193 (VariantType)


state 439

  158 Type: '(' Type . ')'
  167 NonRecvChanType: '(' Type . ')'

    ')'  shift, and go to state 479


state 440

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  129                   | '(' ExprOrType ')' '{' StartCompLit . BracedKeyvalList '}'
  130                   | . FuncLit
  132 Keyval: . Expr ':' CompLitExpr
  133 BareCompLitExpr: . Expr
  134                | . '{' StartCompLit BracedKeyvalList '}'
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  271 KeyvalList: . Keyval
  272           | . BareCompLitExpr
  273           | . KeyvalList ',' Keyval
  274           | . KeyvalList ',' BareCompLitExpr
  275 BracedKeyvalList: .  ['}']
  276                 | . KeyvalList oComma

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '{'        shift, and go to state 373
    '~'        shift, and go to state 51

    $default  reduce using rule 275 (BracedKeyvalList)

    Expr                go to state 374
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    Keyval              go to state 375
    BareCompLitExpr     go to state 376
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    KeyvalList          go to state 377
    BracedKeyvalList    go to state 480


state 441

   36 ConstDecl1: ConstDecl .

    $default  reduce using rule 36 (ConstDecl1)


state 442

  213 ConstDeclList: ConstDecl1 .

    $default  reduce using rule 213 (ConstDeclList)


state 443

   25 CommonDecl: Const '(' ConstDecl ';' ConstDeclList . oSemi ')'
  214 ConstDeclList: ConstDeclList . ';' ConstDecl1
  277 oSemi: .  [')']
  278      | . ';'

    ';'  shift, and go to state 481

    $default  reduce using rule 277 (oSemi)

    oSemi  go to state 482


state 444

   34 ConstDecl: DeclNameList . Type '=' ExprList
   35          | DeclNameList . '=' ExprList
   37 ConstDecl1: DeclNameList . Type
   38           | DeclNameList .  [')', ';']
  148 Symbol: . IDENT
  149 Name: . Symbol
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  266 DeclNameList: DeclNameList . ',' DeclName

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '='        shift, and go to state 263
    '['        shift, and go to state 49
    ','        shift, and go to state 252

    $default  reduce using rule 38 (ConstDecl1)

    Symbol         go to state 94
    Name           go to state 95
    Type           go to state 483
    TypeName       go to state 195
    OtherType      go to state 196
    PtrType        go to state 197
    RecvChanType   go to state 198
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 199


state 445

   24 CommonDecl: Const '(' ConstDecl oSemi ')' .

    $default  reduce using rule 24 (CommonDecl)


state 446

   34 ConstDecl: DeclNameList Type '=' ExprList .  [CASE, DEFAULT, ')', ';', '}']
  268 ExprList: ExprList . ',' Expr

    ','  shift, and go to state 189

    $default  reduce using rule 34 (ConstDecl)


state 447

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  132 Keyval: . Expr ':' CompLitExpr
  133 BareCompLitExpr: . Expr
  134                | . '{' StartCompLit BracedKeyvalList '}'
  134                | '{' StartCompLit . BracedKeyvalList '}'
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  271 KeyvalList: . Keyval
  272           | . BareCompLitExpr
  273           | . KeyvalList ',' Keyval
  274           | . KeyvalList ',' BareCompLitExpr
  275 BracedKeyvalList: .  ['}']
  276                 | . KeyvalList oComma

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '{'        shift, and go to state 373
    '~'        shift, and go to state 51

    $default  reduce using rule 275 (BracedKeyvalList)

    Expr                go to state 374
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    Keyval              go to state 375
    BareCompLitExpr     go to state 376
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    KeyvalList          go to state 377
    BracedKeyvalList    go to state 484


state 448

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  132 Keyval: Expr ':' . CompLitExpr
  135 CompLitExpr: . Expr
  136            | . '{' StartCompLit BracedKeyvalList '}'
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '{'        shift, and go to state 485
    '~'        shift, and go to state 51

    Expr                go to state 486
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    CompLitExpr         go to state 487
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 449

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  132 Keyval: . Expr ':' CompLitExpr
  133 BareCompLitExpr: . Expr
  134                | . '{' StartCompLit BracedKeyvalList '}'
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  273 KeyvalList: KeyvalList ',' . Keyval
  274           | KeyvalList ',' . BareCompLitExpr
  280 oComma: ',' .  ['}']

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '{'        shift, and go to state 373
    '~'        shift, and go to state 51

    $default  reduce using rule 280 (oComma)

    Expr                go to state 374
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    Keyval              go to state 488
    BareCompLitExpr     go to state 489
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 450

  276 BracedKeyvalList: KeyvalList oComma .

    $default  reduce using rule 276 (BracedKeyvalList)


state 451

  128 PrimaryExprNoParen: PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}' .

    $default  reduce using rule 128 (PrimaryExprNoParen)


state 452

  280 oComma: ',' .

    $default  reduce using rule 280 (oComma)


state 453

  115 PseudoCall: PrimaryExpr '(' ExprOrTypeList DDD oComma . ')'

    ')'  shift, and go to state 490


state 454

  270 ExprOrTypeList: ExprOrTypeList ',' ExprOrType .

    $default  reduce using rule 270 (ExprOrTypeList)


state 455

  114 PseudoCall: PrimaryExpr '(' ExprOrTypeList oComma ')' .

    $default  reduce using rule 114 (PseudoCall)


state 456

  120 PrimaryExprNoParen: PrimaryExpr '.' '(' TYPE ')' .

    $default  reduce using rule 120 (PrimaryExprNoParen)


state 457

  119 PrimaryExprNoParen: PrimaryExpr '.' '(' ExprOrType ')' .

    $default  reduce using rule 119 (PrimaryExprNoParen)


state 458

  122 PrimaryExprNoParen: PrimaryExpr '[' oExpr ':' oExpr . ']'
  123                   | PrimaryExpr '[' oExpr ':' oExpr . ':' oExpr ']'

    ':'  shift, and go to state 491
    ']'  shift, and go to state 492


state 459

   52 CompoundStmt: '{' $@2 StmtList . '}'
  262 StmtList: StmtList . ';' Statement

    ';'  shift, and go to state 390
    '}'  shift, and go to state 493


state 460

  125 PrimaryExprNoParen: ConvType '(' ExprList oComma ')' .

    $default  reduce using rule 125 (PrimaryExprNoParen)


state 461

  127 PrimaryExprNoParen: CompLitType LBrace StartCompLit BracedKeyvalList '}' .

    $default  reduce using rule 127 (PrimaryExprNoParen)


state 462

  262 StmtList: StmtList ';' Statement .

    $default  reduce using rule 262 (StmtList)


state 463

   58 LoopBody: BODY $@4 StmtList . '}'
  262 StmtList: StmtList . ';' Statement

    ';'  shift, and go to state 390
    '}'  shift, and go to state 494


state 464

   60 RangeStmt: ExprList COLAS RANGE Expr .  [BODY]
   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    ANDAND  shift, and go to state 155
    ANDNOT  shift, and go to state 156
    COMM    shift, and go to state 158
    EQ      shift, and go to state 160
    GE      shift, and go to state 161
    LE      shift, and go to state 163
    LSH     shift, and go to state 164
    NE      shift, and go to state 165
    OROR    shift, and go to state 166
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '<'     shift, and go to state 174
    '>'     shift, and go to state 175
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    $default  reduce using rule 60 (RangeStmt)


state 465

   59 RangeStmt: ExprList '=' RANGE Expr .  [BODY]
   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    ANDAND  shift, and go to state 155
    ANDNOT  shift, and go to state 156
    COMM    shift, and go to state 158
    EQ      shift, and go to state 160
    GE      shift, and go to state 161
    LE      shift, and go to state 163
    LSH     shift, and go to state 164
    NE      shift, and go to state 165
    OROR    shift, and go to state 166
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '<'     shift, and go to state 174
    '>'     shift, and go to state 175
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    $default  reduce using rule 59 (RangeStmt)


state 466

   41 SimpleStmt: . Expr
   42           | . Expr ASOP Expr
   43           | . ExprList '=' ExprList
   44           | . ExprList COLAS ExprList
   45           | . Expr INC
   46           | . Expr DEC
   61 ForHeader: oSimpleStmt ';' oSimpleStmt ';' . oSimpleStmt
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  267 ExprList: . Expr
  268         | . ExprList ',' Expr
  285 oSimpleStmt: .  [BODY]
  286            | . SimpleStmt

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    $default  reduce using rule 285 (oSimpleStmt)

    SimpleStmt          go to state 204
    Expr                go to state 60
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprList            go to state 81
    oSimpleStmt         go to state 495


state 467

  205 FuncResult: '(' oArgTypeListOComma . ')'

    ')'  shift, and go to state 496


state 468

  141 NameOrType: . Type
  148 Symbol: . IDENT
  149 Name: . Symbol
  151 Ddd: . DDD
  152    | . DDD Type
  153 Type: . RecvChanType
  154     | . FuncType
  155     | . OtherType
  156     | . PtrType
  157     | . TypeName
  158     | . '(' Type ')'
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  199 FuncDecl1: '(' oArgTypeListOComma ')' Symbol '(' . oArgTypeListOComma ')' FuncResult
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  234 ArgType: . NameOrType
  235        | . Symbol NameOrType
  236        | . Symbol Ddd
  237        | . Ddd
  238 ArgTypeList: . ArgType
  239            | . ArgTypeList ',' ArgType
  240 oArgTypeListOComma: .  [')']
  241                   | . ArgTypeList oComma

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    DDD        shift, and go to state 210
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 193
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    $default  reduce using rule 240 (oArgTypeListOComma)

    NameOrType          go to state 211
    Symbol              go to state 212
    Name                go to state 95
    Ddd                 go to state 213
    Type                go to state 214
    TypeName            go to state 195
    OtherType           go to state 196
    PtrType             go to state 197
    RecvChanType        go to state 198
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 199
    ArgType             go to state 215
    ArgTypeList         go to state 216
    oArgTypeListOComma  go to state 497


state 469

  198 FuncDecl1: Symbol '(' oArgTypeListOComma ')' FuncResult .

    $default  reduce using rule 198 (FuncDecl1)


state 470

   71 IfStmt: IF $@6 IfHeader LoopBody $@7 ElseIfList . Else
   73 ElseIf: . ELSE IF IfHeader $@8 LoopBody
   75 ElseIfList: ElseIfList . ElseIf
   76 Else: .  [CASE, DEFAULT, ';', '}']
   78     | . ELSE $@9 CompoundStmt

    ELSE  shift, and go to state 498

    $default  reduce using rule 76 (Else)

    ElseIf  go to state 499
    Else    go to state 500


state 471

  148 Symbol: . IDENT
  149 Name: . Symbol
  171 FuncRetType: . RecvChanType
  172            | . FuncType
  173            | . OtherType
  174            | . PtrType
  175            | . TypeName
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  203 FuncResult: .  [';', '}']
  204           | . FuncRetType
  205           | . '(' oArgTypeListOComma ')'
  233 InterfaceMethodDecl: '(' oArgTypeListOComma ')' . FuncResult

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 399
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    $default  reduce using rule 203 (FuncResult)

    Symbol         go to state 94
    Name           go to state 95
    FuncRetType    go to state 401
    TypeName       go to state 402
    OtherType      go to state 403
    PtrType        go to state 404
    RecvChanType   go to state 405
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 406
    FuncResult     go to state 501


state 472

   47 Case: CASE ExprOrTypeList . ':'
   48     | CASE ExprOrTypeList . '=' Expr ':'
   49     | CASE ExprOrTypeList . COLAS Expr ':'
  270 ExprOrTypeList: ExprOrTypeList . ',' ExprOrType

    COLAS  shift, and go to state 502
    ':'    shift, and go to state 503
    '='    shift, and go to state 504
    ','    shift, and go to state 505


state 473

   50 Case: DEFAULT ':' .

    $default  reduce using rule 50 (Case)


state 474

   20 CommonDecl: . VAR VarDecl
   21           | . VAR '(' VarDeclList oSemi ')'
   22           | . VAR '(' ')'
   23           | . Const ConstDecl
   24           | . Const '(' ConstDecl oSemi ')'
   25           | . Const '(' ConstDecl ';' ConstDeclList oSemi ')'
   26           | . Const '(' ')'
   27           | . TYPE TypeDecl
   28           | . TYPE '(' TypeDeclList oSemi ')'
   29           | . TYPE '(' ')'
   30 Const: . CONST
   41 SimpleStmt: . Expr
   42           | . Expr ASOP Expr
   43           | . ExprList '=' ExprList
   44           | . ExprList COLAS ExprList
   45           | . Expr INC
   46           | . Expr DEC
   52 CompoundStmt: . '{' $@2 StmtList '}'
   54 CaseBlock: Case $@3 . StmtList
   66 ForStmt: . FOR $@5 ForBody
   71 IfStmt: . IF $@6 IfHeader LoopBody $@7 ElseIfList Else
   80 SwitchStmt: . SWITCH $@10 IfHeader BODY CaseBlockList '}'
   82 SelectStmt: . SELECT $@11 BODY CaseBlockList '}'
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  144 NewName: . Symbol
  148 Symbol: . IDENT
  149 Name: . Symbol
  150 LabelName: . NewName
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  242 Statement: .  [CASE, DEFAULT, ';', '}']
  243          | . CompoundStmt
  244          | . CommonDecl
  245          | . NonDclStmt
  246          | . error
  247 NonDclStmt: . SimpleStmt
  248           | . ForStmt
  249           | . SwitchStmt
  250           | . SelectStmt
  251           | . IfStmt
  252           | . LabelName ':' Statement
  253           | . FALL
  254           | . BREAK oNewName
  255           | . CONTINUE oNewName
  256           | . GO PseudoCall
  257           | . DEFER PseudoCall
  258           | . GOTO NewName
  259           | . GOTO
  260           | . RETURN oExprList
  261 StmtList: . Statement
  262         | . StmtList ';' Statement
  267 ExprList: . Expr
  268         | . ExprList ',' Expr

    error      shift, and go to state 294
    BREAK      shift, and go to state 20
    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    CONST      shift, and go to state 23
    CONTINUE   shift, and go to state 24
    DEFER      shift, and go to state 25
    FALL       shift, and go to state 26
    FOR        shift, and go to state 27
    FUNC       shift, and go to state 91
    GO         shift, and go to state 29
    GOTO       shift, and go to state 30
    IDENT      shift, and go to state 4
    IF         shift, and go to state 31
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    RETURN     shift, and go to state 35
    SELECT     shift, and go to state 36
    STRUCT     shift, and go to state 37
    SWITCH     shift, and go to state 38
    TYPE       shift, and go to state 39
    UNION      shift, and go to state 40
    VAR        shift, and go to state 41
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '{'        shift, and go to state 295
    '~'        shift, and go to state 51

    CASE     reduce using rule 242 (Statement)
    DEFAULT  reduce using rule 242 (Statement)
    ';'      reduce using rule 242 (Statement)
    '}'      reduce using rule 242 (Statement)

    CommonDecl          go to state 296
    Const               go to state 54
    SimpleStmt          go to state 55
    CompoundStmt        go to state 297
    ForStmt             go to state 56
    IfStmt              go to state 57
    SwitchStmt          go to state 58
    SelectStmt          go to state 59
    Expr                go to state 60
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    NewName             go to state 65
    Symbol              go to state 66
    Name                go to state 67
    LabelName           go to state 68
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    Statement           go to state 303
    NonDclStmt          go to state 299
    StmtList            go to state 506
    ExprList            go to state 81


state 475

  225 StructDecl: '(' '*' Embedded ')' . oLiteral
  287 oLiteral: .  [';', '}']
  288         | . LITERAL

    LITERAL  shift, and go to state 345

    $default  reduce using rule 287 (oLiteral)

    oLiteral  go to state 507


state 476

  223 StructDecl: '(' Embedded ')' oLiteral .

    $default  reduce using rule 223 (StructDecl)


state 477

  226 StructDecl: '*' '(' Embedded ')' . oLiteral
  287 oLiteral: .  [';', '}']
  288         | . LITERAL

    LITERAL  shift, and go to state 345

    $default  reduce using rule 287 (oLiteral)

    oLiteral  go to state 508


state 478

   80 SwitchStmt: SWITCH $@10 IfHeader BODY CaseBlockList '}' .

    $default  reduce using rule 80 (SwitchStmt)


state 479

  158 Type: '(' Type ')' .  [COLAS, DDD, ')', ':', '=', ',']
  167 NonRecvChanType: '(' Type ')' .  [BODY, '(', '{']

    BODY      reduce using rule 167 (NonRecvChanType)
    '('       reduce using rule 167 (NonRecvChanType)
    '{'       reduce using rule 167 (NonRecvChanType)
    $default  reduce using rule 158 (Type)


state 480

  129 PrimaryExprNoParen: '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList . '}'

    '}'  shift, and go to state 509


state 481

   34 ConstDecl: . DeclNameList Type '=' ExprList
   35          | . DeclNameList '=' ExprList
   36 ConstDecl1: . ConstDecl
   37           | . DeclNameList Type
   38           | . DeclNameList
  145 DeclName: . Symbol
  148 Symbol: . IDENT
  214 ConstDeclList: ConstDeclList ';' . ConstDecl1
  265 DeclNameList: . DeclName
  266             | . DeclNameList ',' DeclName
  278 oSemi: ';' .  [')']

    IDENT  shift, and go to state 4

    $default  reduce using rule 278 (oSemi)

    ConstDecl     go to state 441
    ConstDecl1    go to state 510
    DeclName      go to state 129
    Symbol        go to state 130
    DeclNameList  go to state 444


state 482

   25 CommonDecl: Const '(' ConstDecl ';' ConstDeclList oSemi . ')'

    ')'  shift, and go to state 511


state 483

   34 ConstDecl: DeclNameList Type . '=' ExprList
   37 ConstDecl1: DeclNameList Type .  [')', ';']

    '='  shift, and go to state 372

    $default  reduce using rule 37 (ConstDecl1)


state 484

  134 BareCompLitExpr: '{' StartCompLit BracedKeyvalList . '}'

    '}'  shift, and go to state 512


state 485

  131 StartCompLit: .
  136 CompLitExpr: '{' . StartCompLit BracedKeyvalList '}'

    $default  reduce using rule 131 (StartCompLit)

    StartCompLit  go to state 513


state 486

   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr
  135 CompLitExpr: Expr .  ['}', ',']

    ANDAND  shift, and go to state 155
    ANDNOT  shift, and go to state 156
    COMM    shift, and go to state 158
    EQ      shift, and go to state 160
    GE      shift, and go to state 161
    LE      shift, and go to state 163
    LSH     shift, and go to state 164
    NE      shift, and go to state 165
    OROR    shift, and go to state 166
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    '<'     shift, and go to state 174
    '>'     shift, and go to state 175
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177

    $default  reduce using rule 135 (CompLitExpr)


state 487

  132 Keyval: Expr ':' CompLitExpr .

    $default  reduce using rule 132 (Keyval)


state 488

  273 KeyvalList: KeyvalList ',' Keyval .

    $default  reduce using rule 273 (KeyvalList)


state 489

  274 KeyvalList: KeyvalList ',' BareCompLitExpr .

    $default  reduce using rule 274 (KeyvalList)


state 490

  115 PseudoCall: PrimaryExpr '(' ExprOrTypeList DDD oComma ')' .

    $default  reduce using rule 115 (PseudoCall)


state 491

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  123                   | PrimaryExpr '[' oExpr ':' oExpr ':' . oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  281 oExpr: .  [']']
  282      | . Expr

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    $default  reduce using rule 281 (oExpr)

    Expr                go to state 147
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    oExpr               go to state 514


state 492

  122 PrimaryExprNoParen: PrimaryExpr '[' oExpr ':' oExpr ']' .

    $default  reduce using rule 122 (PrimaryExprNoParen)


state 493

   52 CompoundStmt: '{' $@2 StmtList '}' .

    $default  reduce using rule 52 (CompoundStmt)


state 494

   58 LoopBody: BODY $@4 StmtList '}' .

    $default  reduce using rule 58 (LoopBody)


state 495

   61 ForHeader: oSimpleStmt ';' oSimpleStmt ';' oSimpleStmt .

    $default  reduce using rule 61 (ForHeader)


state 496

  205 FuncResult: '(' oArgTypeListOComma ')' .

    $default  reduce using rule 205 (FuncResult)


state 497

  199 FuncDecl1: '(' oArgTypeListOComma ')' Symbol '(' oArgTypeListOComma . ')' FuncResult

    ')'  shift, and go to state 515


state 498

   73 ElseIf: ELSE . IF IfHeader $@8 LoopBody
   77 $@9: .  ['{']
   78 Else: ELSE . $@9 CompoundStmt

    IF  shift, and go to state 516

    $default  reduce using rule 77 ($@9)

    $@9  go to state 517


state 499

   75 ElseIfList: ElseIfList ElseIf .

    $default  reduce using rule 75 (ElseIfList)


state 500

   71 IfStmt: IF $@6 IfHeader LoopBody $@7 ElseIfList Else .

    $default  reduce using rule 71 (IfStmt)


state 501

  233 InterfaceMethodDecl: '(' oArgTypeListOComma ')' FuncResult .

    $default  reduce using rule 233 (InterfaceMethodDecl)


state 502

   49 Case: CASE ExprOrTypeList COLAS . Expr ':'
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 518
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 503

   47 Case: CASE ExprOrTypeList ':' .

    $default  reduce using rule 47 (Case)


state 504

   48 Case: CASE ExprOrTypeList '=' . Expr ':'
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 519
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 505

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  139 ExprOrType: . Expr
  140           | . NonExprType
  148 Symbol: . IDENT
  149 Name: . Symbol
  159 NonExprType: . RecvChanType
  160            | . FuncType
  161            | . OtherType
  162            | . '*' NonExprType
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  270 ExprOrTypeList: ExprOrTypeList ',' . ExprOrType

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 135
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 136
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    Expr                go to state 137
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    ExprOrType          go to state 454
    Symbol              go to state 94
    Name                go to state 67
    NonExprType         go to state 139
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 140
    RecvChanType        go to state 141
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 142
    FuncLitDecl         go to state 78
    FuncLit             go to state 79


state 506

   54 CaseBlock: Case $@3 StmtList .  [CASE, DEFAULT, '}']
  262 StmtList: StmtList . ';' Statement

    ';'  shift, and go to state 390

    $default  reduce using rule 54 (CaseBlock)


state 507

  225 StructDecl: '(' '*' Embedded ')' oLiteral .

    $default  reduce using rule 225 (StructDecl)


state 508

  226 StructDecl: '*' '(' Embedded ')' oLiteral .

    $default  reduce using rule 226 (StructDecl)


state 509

  129 PrimaryExprNoParen: '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}' .

    $default  reduce using rule 129 (PrimaryExprNoParen)


state 510

  214 ConstDeclList: ConstDeclList ';' ConstDecl1 .

    $default  reduce using rule 214 (ConstDeclList)


state 511

   25 CommonDecl: Const '(' ConstDecl ';' ConstDeclList oSemi ')' .

    $default  reduce using rule 25 (CommonDecl)


state 512

  134 BareCompLitExpr: '{' StartCompLit BracedKeyvalList '}' .

    $default  reduce using rule 134 (BareCompLitExpr)


state 513

   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  132 Keyval: . Expr ':' CompLitExpr
  133 BareCompLitExpr: . Expr
  134                | . '{' StartCompLit BracedKeyvalList '}'
  136 CompLitExpr: '{' StartCompLit . BracedKeyvalList '}'
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  271 KeyvalList: . Keyval
  272           | . BareCompLitExpr
  273           | . KeyvalList ',' Keyval
  274           | . KeyvalList ',' BareCompLitExpr
  275 BracedKeyvalList: .  ['}']
  276                 | . KeyvalList oComma

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '{'        shift, and go to state 373
    '~'        shift, and go to state 51

    $default  reduce using rule 275 (BracedKeyvalList)

    Expr                go to state 374
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    Keyval              go to state 375
    BareCompLitExpr     go to state 376
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    KeyvalList          go to state 377
    BracedKeyvalList    go to state 520


state 514

  123 PrimaryExprNoParen: PrimaryExpr '[' oExpr ':' oExpr ':' oExpr . ']'

    ']'  shift, and go to state 521


state 515

  148 Symbol: . IDENT
  149 Name: . Symbol
  171 FuncRetType: . RecvChanType
  172            | . FuncType
  173            | . OtherType
  174            | . PtrType
  175            | . TypeName
  176 TypeName: . Name
  177         | . Name '.' Symbol
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  187 PtrType: . '*' Type
  188 RecvChanType: . COMM CHAN Type
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  199 FuncDecl1: '(' oArgTypeListOComma ')' Symbol '(' oArgTypeListOComma ')' . FuncResult
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  203 FuncResult: .  [';', '{']
  204           | . FuncRetType
  205           | . '(' oArgTypeListOComma ')'

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 192
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '('        shift, and go to state 399
    '*'        shift, and go to state 93
    '['        shift, and go to state 49

    $default  reduce using rule 203 (FuncResult)

    Symbol         go to state 94
    Name           go to state 95
    FuncRetType    go to state 401
    TypeName       go to state 402
    OtherType      go to state 403
    PtrType        go to state 404
    RecvChanType   go to state 405
    StructType     go to state 72
    UnionType      go to state 73
    VariantType    go to state 74
    InterfaceType  go to state 75
    FuncType       go to state 406
    FuncResult     go to state 522


state 516

   41 SimpleStmt: . Expr
   42           | . Expr ASOP Expr
   43           | . ExprList '=' ExprList
   44           | . ExprList COLAS ExprList
   45           | . Expr INC
   46           | . Expr DEC
   67 IfHeader: . oSimpleStmt
   68         | . oSimpleStmt ';' oSimpleStmt
   73 ElseIf: ELSE IF . IfHeader $@8 LoopBody
   83 Expr: . UnaryExpr
   84     | . Expr OROR Expr
   85     | . Expr ANDAND Expr
   86     | . Expr EQ Expr
   87     | . Expr NE Expr
   88     | . Expr '<' Expr
   89     | . Expr LE Expr
   90     | . Expr GE Expr
   91     | . Expr '>' Expr
   92     | . Expr '+' Expr
   93     | . Expr '-' Expr
   94     | . Expr '|' Expr
   95     | . Expr '^' Expr
   96     | . Expr '*' Expr
   97     | . Expr '/' Expr
   98     | . Expr '%' Expr
   99     | . Expr '&' Expr
  100     | . Expr ANDNOT Expr
  101     | . Expr LSH Expr
  102     | . Expr RSH Expr
  103     | . Expr COMM Expr
  104 UnaryExpr: . PrimaryExpr
  105          | . '*' UnaryExpr
  106          | . '&' UnaryExpr
  107          | . '+' UnaryExpr
  108          | . '-' UnaryExpr
  109          | . '!' UnaryExpr
  110          | . '~' UnaryExpr
  111          | . '^' UnaryExpr
  112          | . COMM UnaryExpr
  113 PseudoCall: . PrimaryExpr '(' ')'
  114           | . PrimaryExpr '(' ExprOrTypeList oComma ')'
  115           | . PrimaryExpr '(' ExprOrTypeList DDD oComma ')'
  116 PrimaryExprNoParen: . LITERAL
  117                   | . Name
  118                   | . PrimaryExpr '.' Symbol
  119                   | . PrimaryExpr '.' '(' ExprOrType ')'
  120                   | . PrimaryExpr '.' '(' TYPE ')'
  121                   | . PrimaryExpr '[' Expr ']'
  122                   | . PrimaryExpr '[' oExpr ':' oExpr ']'
  123                   | . PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']'
  124                   | . PseudoCall
  125                   | . ConvType '(' ExprList oComma ')'
  126                   | . ConvType '(' ')'
  127                   | . CompLitType LBrace StartCompLit BracedKeyvalList '}'
  128                   | . PrimaryExprNoParen '{' StartCompLit BracedKeyvalList '}'
  129                   | . '(' ExprOrType ')' '{' StartCompLit BracedKeyvalList '}'
  130                   | . FuncLit
  137 PrimaryExpr: . PrimaryExprNoParen
  138            | . '(' ExprOrType ')'
  148 Symbol: . IDENT
  149 Name: . Symbol
  168 ConvType: . FuncType
  169         | . OtherType
  170 CompLitType: . OtherType
  178 OtherType: . '[' oExpr ']' Type
  179          | . '[' DDD ']' Type
  180          | . CHAN NonRecvChanType
  181          | . CHAN COMM Type
  182          | . MAP '[' Type ']' Type
  183          | . StructType
  184          | . UnionType
  185          | . VariantType
  186          | . InterfaceType
  189 StructType: . STRUCT LBrace StructDeclList oSemi '}'
  190           | . STRUCT LBrace '}'
  191 UnionType: . UNION LBrace StructDeclList oSemi '}'
  192          | . UNION LBrace '}'
  193 VariantType: . VARIANT LBrace StructDeclList oSemi '}'
  194            | . VARIANT LBrace '}'
  195 InterfaceType: . INTERFACE LBrace InterfaceDeclList oSemi '}'
  196              | . INTERFACE LBrace '}'
  200 FuncType: . FUNC '(' oArgTypeListOComma ')' FuncResult
  206 FuncLitDecl: . FuncType
  207 FuncLit: . FuncLitDecl LBrace StmtList '}'
  208        | . FuncLitDecl error
  267 ExprList: . Expr
  268         | . ExprList ',' Expr
  285 oSimpleStmt: .  [BODY, ';']
  286            | . SimpleStmt

    CHAN       shift, and go to state 21
    COMM       shift, and go to state 22
    FUNC       shift, and go to state 91
    IDENT      shift, and go to state 4
    INTERFACE  shift, and go to state 32
    LITERAL    shift, and go to state 33
    MAP        shift, and go to state 34
    STRUCT     shift, and go to state 37
    UNION      shift, and go to state 40
    VARIANT    shift, and go to state 42
    '!'        shift, and go to state 43
    '&'        shift, and go to state 44
    '('        shift, and go to state 45
    '*'        shift, and go to state 46
    '+'        shift, and go to state 47
    '-'        shift, and go to state 48
    '['        shift, and go to state 49
    '^'        shift, and go to state 50
    '~'        shift, and go to state 51

    $default  reduce using rule 285 (oSimpleStmt)

    SimpleStmt          go to state 204
    IfHeader            go to state 523
    Expr                go to state 60
    UnaryExpr           go to state 61
    PseudoCall          go to state 62
    PrimaryExprNoParen  go to state 63
    PrimaryExpr         go to state 64
    Symbol              go to state 94
    Name                go to state 67
    ConvType            go to state 69
    CompLitType         go to state 70
    OtherType           go to state 71
    StructType          go to state 72
    UnionType           go to state 73
    VariantType         go to state 74
    InterfaceType       go to state 75
    FuncType            go to state 77
    FuncLitDecl         go to state 78
    FuncLit             go to state 79
    ExprList            go to state 81
    oSimpleStmt         go to state 222


state 517

   52 CompoundStmt: . '{' $@2 StmtList '}'
   78 Else: ELSE $@9 . CompoundStmt

    '{'  shift, and go to state 295

    CompoundStmt  go to state 524


state 518

   49 Case: CASE ExprOrTypeList COLAS Expr . ':'
   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    ANDAND  shift, and go to state 155
    ANDNOT  shift, and go to state 156
    COMM    shift, and go to state 158
    EQ      shift, and go to state 160
    GE      shift, and go to state 161
    LE      shift, and go to state 163
    LSH     shift, and go to state 164
    NE      shift, and go to state 165
    OROR    shift, and go to state 166
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    ':'     shift, and go to state 525
    '<'     shift, and go to state 174
    '>'     shift, and go to state 175
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177


state 519

   48 Case: CASE ExprOrTypeList '=' Expr . ':'
   84 Expr: Expr . OROR Expr
   85     | Expr . ANDAND Expr
   86     | Expr . EQ Expr
   87     | Expr . NE Expr
   88     | Expr . '<' Expr
   89     | Expr . LE Expr
   90     | Expr . GE Expr
   91     | Expr . '>' Expr
   92     | Expr . '+' Expr
   93     | Expr . '-' Expr
   94     | Expr . '|' Expr
   95     | Expr . '^' Expr
   96     | Expr . '*' Expr
   97     | Expr . '/' Expr
   98     | Expr . '%' Expr
   99     | Expr . '&' Expr
  100     | Expr . ANDNOT Expr
  101     | Expr . LSH Expr
  102     | Expr . RSH Expr
  103     | Expr . COMM Expr

    ANDAND  shift, and go to state 155
    ANDNOT  shift, and go to state 156
    COMM    shift, and go to state 158
    EQ      shift, and go to state 160
    GE      shift, and go to state 161
    LE      shift, and go to state 163
    LSH     shift, and go to state 164
    NE      shift, and go to state 165
    OROR    shift, and go to state 166
    RSH     shift, and go to state 167
    '%'     shift, and go to state 168
    '&'     shift, and go to state 169
    '*'     shift, and go to state 170
    '+'     shift, and go to state 171
    '-'     shift, and go to state 172
    '/'     shift, and go to state 173
    ':'     shift, and go to state 526
    '<'     shift, and go to state 174
    '>'     shift, and go to state 175
    '^'     shift, and go to state 176
    '|'     shift, and go to state 177


state 520

  136 CompLitExpr: '{' StartCompLit BracedKeyvalList . '}'

    '}'  shift, and go to state 527


state 521

  123 PrimaryExprNoParen: PrimaryExpr '[' oExpr ':' oExpr ':' oExpr ']' .

    $default  reduce using rule 123 (PrimaryExprNoParen)


state 522

  199 FuncDecl1: '(' oArgTypeListOComma ')' Symbol '(' oArgTypeListOComma ')' FuncResult .

    $default  reduce using rule 199 (FuncDecl1)


state 523

   72 $@8: .
   73 ElseIf: ELSE IF IfHeader . $@8 LoopBody

    $default  reduce using rule 72 ($@8)

    $@8  go to state 528


state 524

   78 Else: ELSE $@9 CompoundStmt .

    $default  reduce using rule 78 (Else)


state 525

   49 Case: CASE ExprOrTypeList COLAS Expr ':' .

    $default  reduce using rule 49 (Case)


state 526

   48 Case: CASE ExprOrTypeList '=' Expr ':' .

    $default  reduce using rule 48 (Case)


state 527

  136 CompLitExpr: '{' StartCompLit BracedKeyvalList '}' .

    $default  reduce using rule 136 (CompLitExpr)


state 528

   58 LoopBody: . BODY $@4 StmtList '}'
   73 ElseIf: ELSE IF IfHeader $@8 . LoopBody

    BODY  shift, and go to state 315

    LoopBody  go to state 529


state 529

   73 ElseIf: ELSE IF IfHeader $@8 LoopBody .

    $default  reduce using rule 73 (ElseIf)
