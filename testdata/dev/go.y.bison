Rules useless in parser due to conflicts

    2 AnonymousField1: /* empty */

  100 ForClause1: /* empty */

  104 ForClause3: /* empty */

  126 IfStmt1: /* empty */

  224 RecvStmt1: /* empty */

  322 TypeSwitchStmt1: /* empty */
  323                | SimpleStmt ';'


State 41 conflicts: 1 shift/reduce
State 59 conflicts: 1 shift/reduce
State 85 conflicts: 1 shift/reduce
State 88 conflicts: 1 shift/reduce
State 111 conflicts: 1 shift/reduce, 5 reduce/reduce
State 135 conflicts: 17 shift/reduce, 1 reduce/reduce
State 136 conflicts: 5 reduce/reduce
State 141 conflicts: 1 reduce/reduce
State 155 conflicts: 10 shift/reduce
State 179 conflicts: 1 shift/reduce
State 192 conflicts: 16 shift/reduce
State 212 conflicts: 1 shift/reduce
State 223 conflicts: 1 shift/reduce
State 243 conflicts: 1 shift/reduce
State 245 conflicts: 1 shift/reduce
State 250 conflicts: 1 shift/reduce, 3 reduce/reduce
State 259 conflicts: 1 shift/reduce
State 264 conflicts: 1 shift/reduce
State 272 conflicts: 1 shift/reduce
State 275 conflicts: 1 shift/reduce, 4 reduce/reduce
State 280 conflicts: 1 reduce/reduce
State 283 conflicts: 16 shift/reduce
State 286 conflicts: 16 shift/reduce, 15 reduce/reduce
State 335 conflicts: 1 shift/reduce
State 344 conflicts: 16 shift/reduce
State 359 conflicts: 1 shift/reduce, 4 reduce/reduce
State 381 conflicts: 1 shift/reduce
State 392 conflicts: 16 shift/reduce
State 393 conflicts: 1 shift/reduce
State 408 conflicts: 15 reduce/reduce
State 423 conflicts: 16 shift/reduce
State 432 conflicts: 1 reduce/reduce


Grammar

    0 $accept: Start $end

    1 AnonymousField: AnonymousField1 TypeName

    2 AnonymousField1: /* empty */
    3                | '*'

    4 ArgumentList: ExpressionList ArgumentList1

    5 ArgumentList1: /* empty */
    6              | TOK4

    7 ArrayLength: Expression

    8 ArrayType: '[' ArrayLength ']' ElementType

    9 Assignment: ExpressionList ASSIGN_OP ExpressionList

   10 BaseType: Type

   11 BaseTypeName: IDENTIFIER

   12 BasicLit: INT_LIT
   13         | FLOAT_LIT
   14         | IMAGINARY_LIT
   15         | RUNE_LIT
   16         | STRING_LIT

   17 Block: '{' StatementList '}'

   18 BreakStmt: BREAK BreakStmt1

   19 BreakStmt1: /* empty */
   20           | Label

   21 BuiltinArgs: Type BuiltinArgs1
   22            | ArgumentList

   23 BuiltinArgs1: /* empty */
   24             | ',' ArgumentList

   25 BuiltinCall: IDENTIFIER '(' BuiltinCall1 ')'

   26 BuiltinCall1: /* empty */
   27             | BuiltinArgs BuiltinCall11

   28 BuiltinCall11: /* empty */
   29              | ','

   30 Call: '(' Call1 ')'

   31 Call1: /* empty */
   32      | ArgumentList Call11

   33 Call11: /* empty */
   34       | ','

   35 Channel: Expression

   36 ChannelType: ChannelType1 ElementType

   37 ChannelType1: CHAN
   38             | CHAN TOK5
   39             | TOK5 CHAN

   40 CommCase: CASE CommCase1
   41         | DEFAULT

   42 CommCase1: SendStmt
   43          | RecvStmt

   44 CommClause: CommCase ':' StatementList

   45 CompositeLit: LiteralType LiteralValue

   46 Condition: Expression

   47 ConstDecl: CONST ConstDecl1

   48 ConstDecl1: ConstSpec
   49           | '(' ConstDecl11 ')'

   50 ConstDecl11: /* empty */
   51            | ConstDecl11 ConstSpec ';'

   52 ConstSpec: IdentifierList ConstSpec1

   53 ConstSpec1: /* empty */
   54           | ConstSpec11 '=' ExpressionList

   55 ConstSpec11: /* empty */
   56            | Type

   57 ContinueStmt: CONTINUE ContinueStmt1

   58 ContinueStmt1: /* empty */
   59              | Label

   60 Conversion: Type '(' Expression Conversion1 ')'

   61 Conversion1: /* empty */
   62            | ','

   63 Declaration: ConstDecl
   64            | TypeDecl
   65            | VarDecl

   66 DeferStmt: DEFER Expression

   67 Element: Element1 Value

   68 Element1: /* empty */
   69         | Key ':'

   70 ElementIndex: Expression

   71 ElementList: Element ElementList1

   72 ElementList1: /* empty */
   73             | ElementList1 ',' Element

   74 ElementType: Type

   75 EmptyStmt: /* empty */

   76 ExprCaseClause: ExprSwitchCase ':' StatementList

   77 ExprSwitchCase: CASE ExpressionList
   78               | DEFAULT

   79 ExprSwitchStmt: SWITCH ExprSwitchStmt1 ExprSwitchStmt2 '{' ExprSwitchStmt3 '}'

   80 ExprSwitchStmt1: /* empty */
   81                | SimpleStmt ';'

   82 ExprSwitchStmt2: /* empty */
   83                | Expression

   84 ExprSwitchStmt3: /* empty */
   85                | ExprSwitchStmt3 ExprCaseClause

   86 Expression: UnaryExpr
   87           | Expression BINARY_OP UnaryExpr

   88 ExpressionList: Expression ExpressionList1

   89 ExpressionList1: /* empty */
   90                | ExpressionList1 ',' Expression

   91 ExpressionStmt: Expression

   92 FallthroughStmt: FALLTHROUGH

   93 FieldDecl: FieldDecl1 FieldDecl2

   94 FieldDecl1: IdentifierList Type
   95           | AnonymousField

   96 FieldDecl2: /* empty */
   97           | Tag

   98 FieldName: IDENTIFIER

   99 ForClause: ForClause1 ';' ForClause2 ';' ForClause3

  100 ForClause1: /* empty */
  101           | InitStmt

  102 ForClause2: /* empty */
  103           | Condition

  104 ForClause3: /* empty */
  105           | PostStmt

  106 ForStmt: FOR ForStmt1 Block

  107 ForStmt1: /* empty */
  108         | ForStmt11

  109 ForStmt11: Condition
  110          | ForClause
  111          | RangeClause

  112 Function: Signature FunctionBody

  113 FunctionBody: Block

  114 FunctionDecl: FUNC FunctionName FunctionDecl1

  115 FunctionDecl1: Function
  116              | Signature

  117 FunctionLit: FUNC Function

  118 FunctionName: IDENTIFIER

  119 FunctionType: FUNC Signature

  120 GoStmt: GO Expression

  121 GotoStmt: GOTO Label

  122 IdentifierList: IDENTIFIER IdentifierList1

  123 IdentifierList1: /* empty */
  124                | IdentifierList1 ',' IDENTIFIER

  125 IfStmt: IF IfStmt1 Expression Block IfStmt2

  126 IfStmt1: /* empty */
  127        | SimpleStmt ';'

  128 IfStmt2: /* empty */
  129        | ELSE IfStmt21

  130 IfStmt21: IfStmt
  131         | Block

  132 ImportDecl: IMPORT ImportDecl1

  133 ImportDecl1: ImportSpec
  134            | '(' ImportDecl11 ')'

  135 ImportDecl11: /* empty */
  136             | ImportDecl11 ImportSpec ';'

  137 ImportPath: STRING_LIT

  138 ImportSpec: ImportSpec1 ImportPath

  139 ImportSpec1: /* empty */
  140            | ImportSpec11

  141 ImportSpec11: '.'
  142             | PackageName

  143 IncDecStmt: Expression IncDecStmt1

  144 IncDecStmt1: TOK2
  145            | TOK1

  146 Index: '[' Expression ']'

  147 InitStmt: SimpleStmt

  148 InterfaceType: INTERFACE '{' InterfaceType1 '}'

  149 InterfaceType1: /* empty */
  150               | InterfaceType1 MethodSpec ';'

  151 InterfaceTypeName: TypeName

  152 Key: FieldName
  153    | ElementIndex

  154 KeyType: Type

  155 Label: IDENTIFIER

  156 LabeledStmt: Label ':' Statement

  157 Literal: BasicLit
  158        | CompositeLit
  159        | FunctionLit

  160 LiteralType: StructType
  161            | ArrayType
  162            | '[' TOK4 ']' ElementType
  163            | SliceType
  164            | MapType
  165            | TypeName

  166 LiteralValue: '{' LiteralValue1 '}'

  167 LiteralValue1: /* empty */
  168              | ElementList LiteralValue11

  169 LiteralValue11: /* empty */
  170               | ','

  171 MapType: MAP '[' KeyType ']' ElementType

  172 MethodDecl: FUNC Receiver MethodName MethodDecl1

  173 MethodDecl1: Function
  174            | Signature

  175 MethodExpr: ReceiverType '.' MethodName

  176 MethodName: IDENTIFIER

  177 MethodSpec: MethodName Signature
  178           | InterfaceTypeName

  179 Operand: Literal
  180        | OperandName
  181        | MethodExpr
  182        | '(' Expression ')'

  183 OperandName: IDENTIFIER
  184            | QualifiedIdent

  185 PackageClause: PACKAGE PackageName

  186 PackageName: IDENTIFIER

  187 ParameterDecl: ParameterDecl1 ParameterDecl2 Type

  188 ParameterDecl1: /* empty */
  189               | IdentifierList

  190 ParameterDecl2: /* empty */
  191               | TOK4

  192 ParameterList: ParameterDecl ParameterList1

  193 ParameterList1: /* empty */
  194               | ParameterList1 ',' ParameterDecl

  195 Parameters: '(' Parameters1 ')'

  196 Parameters1: /* empty */
  197            | ParameterList Parameters11

  198 Parameters11: /* empty */
  199             | ','

  200 PointerType: '*' BaseType

  201 PostStmt: SimpleStmt

  202 PrimaryExpr: Operand
  203            | Conversion
  204            | BuiltinCall
  205            | PrimaryExpr Selector
  206            | PrimaryExpr Index
  207            | PrimaryExpr Slice
  208            | PrimaryExpr TypeAssertion
  209            | PrimaryExpr Call

  210 QualifiedIdent: PackageName '.' IDENTIFIER

  211 RangeClause: RangeClause1 RANGE Expression

  212 RangeClause1: ExpressionList '='
  213             | IdentifierList TOK3

  214 Receiver: '(' Receiver1 Receiver2 BaseTypeName ')'

  215 Receiver1: /* empty */
  216          | IDENTIFIER

  217 Receiver2: /* empty */
  218          | '*'

  219 ReceiverType: TypeName
  220             | '(' '*' TypeName ')'
  221             | '(' ReceiverType ')'

  222 RecvExpr: Expression

  223 RecvStmt: RecvStmt1 RecvExpr

  224 RecvStmt1: /* empty */
  225          | RecvStmt11

  226 RecvStmt11: ExpressionList '='
  227           | IdentifierList TOK3

  228 Result: Parameters
  229       | Type

  230 ReturnStmt: RETURN ReturnStmt1

  231 ReturnStmt1: /* empty */
  232            | ExpressionList

  233 SelectStmt: SELECT '{' SelectStmt1 '}'

  234 SelectStmt1: /* empty */
  235            | SelectStmt1 CommClause

  236 Selector: '.' IDENTIFIER

  237 SendStmt: Channel TOK5 Expression

  238 ShortVarDecl: IdentifierList TOK3 ExpressionList

  239 Signature: Parameters Signature1

  240 Signature1: /* empty */
  241           | Result

  242 SimpleStmt: EmptyStmt
  243           | ExpressionStmt
  244           | SendStmt
  245           | IncDecStmt
  246           | Assignment
  247           | ShortVarDecl

  248 Slice: '[' Slice1
  249      | Slice2 ']'

  250 Slice1: Slice11 ':' Slice12

  251 Slice11: /* empty */
  252        | Expression

  253 Slice12: /* empty */
  254        | Expression

  255 Slice2: Slice21 ':' Expression ':' Expression

  256 Slice21: /* empty */
  257        | Expression

  258 SliceType: '[' ']' ElementType

  259 SourceFile: PackageClause ';' SourceFile1 SourceFile2

  260 SourceFile1: /* empty */
  261            | SourceFile1 ImportDecl ';'

  262 SourceFile2: /* empty */
  263            | SourceFile2 TopLevelDecl ';'

  264 Start: SourceFile

  265 Statement: Declaration
  266          | LabeledStmt
  267          | SimpleStmt
  268          | GoStmt
  269          | ReturnStmt
  270          | BreakStmt
  271          | ContinueStmt
  272          | GotoStmt
  273          | FallthroughStmt
  274          | Block
  275          | IfStmt
  276          | SwitchStmt
  277          | SelectStmt
  278          | ForStmt
  279          | DeferStmt

  280 StatementList: StatementList1

  281 StatementList1: /* empty */
  282               | StatementList1 Statement ';'

  283 StructType: STRUCT '{' StructType1 '}'

  284 StructType1: /* empty */
  285            | StructType1 FieldDecl ';'

  286 SwitchStmt: ExprSwitchStmt
  287           | TypeSwitchStmt

  288 Tag: STRING_LIT

  289 TopLevelDecl: Declaration
  290             | FunctionDecl
  291             | MethodDecl

  292 Type: TypeName
  293     | TypeLit
  294     | '(' Type ')'

  295 TypeAssertion: '.' '(' Type ')'

  296 TypeCaseClause: TypeSwitchCase ':' StatementList

  297 TypeDecl: TYPE TypeDecl1

  298 TypeDecl1: TypeSpec
  299          | '(' TypeDecl11 ')'

  300 TypeDecl11: /* empty */
  301           | TypeDecl11 TypeSpec ';'

  302 TypeList: Type TypeList1

  303 TypeList1: /* empty */
  304          | TypeList1 ',' Type

  305 TypeLit: ArrayType
  306        | StructType
  307        | PointerType
  308        | FunctionType
  309        | InterfaceType
  310        | SliceType
  311        | MapType
  312        | ChannelType

  313 TypeName: IDENTIFIER
  314         | QualifiedIdent

  315 TypeSpec: IDENTIFIER Type

  316 TypeSwitchCase: CASE TypeList
  317               | DEFAULT

  318 TypeSwitchGuard: TypeSwitchGuard1 PrimaryExpr '.' '(' TYPE ')'

  319 TypeSwitchGuard1: /* empty */
  320                 | IDENTIFIER TOK3

  321 TypeSwitchStmt: SWITCH TypeSwitchStmt1 TypeSwitchGuard '{' TypeSwitchStmt2 '}'

  322 TypeSwitchStmt1: /* empty */
  323                | SimpleStmt ';'

  324 TypeSwitchStmt2: /* empty */
  325                | TypeSwitchStmt2 TypeCaseClause

  326 UnaryExpr: PrimaryExpr
  327          | UNARY_OP UnaryExpr

  328 Value: Expression
  329      | LiteralValue

  330 VarDecl: VAR VarDecl1

  331 VarDecl1: VarSpec
  332         | '(' VarDecl11 ')'

  333 VarDecl11: /* empty */
  334          | VarDecl11 VarSpec ';'

  335 VarSpec: IdentifierList VarSpec1

  336 VarSpec1: Type VarSpec11
  337         | '=' ExpressionList

  338 VarSpec11: /* empty */
  339          | '=' ExpressionList


Terminals, with rules where they appear

$end (0) 0
'(' (40) 25 30 49 60 134 182 195 214 220 221 294 295 299 318 332
')' (41) 25 30 49 60 134 182 195 214 220 221 294 295 299 318 332
'*' (42) 3 200 218 220
',' (44) 24 29 34 62 73 90 124 170 194 199 304
'.' (46) 141 175 210 236 295 318
':' (58) 44 69 76 156 250 255 296
';' (59) 51 81 99 127 136 150 259 261 263 282 285 301 323 334
'=' (61) 54 212 226 337 339
'[' (91) 8 146 162 171 248 258
']' (93) 8 146 162 171 249 258
'{' (123) 17 79 148 166 233 283 321
'}' (125) 17 79 148 166 233 283 321
error (256)
ASSIGN_OP (258) 9
BINARY_OP (259) 87
FLOAT_LIT (260) 13
IDENTIFIER (261) 11 25 98 118 122 124 155 176 183 186 210 216 236 313
    315 320
IMAGINARY_LIT (262) 14
INT_LIT (263) 12
RUNE_LIT (264) 15
STRING_LIT (265) 16 137 288
UNARY_OP (266) 327
TOK1 (267) 145
TOK2 (268) 144
TOK3 (269) 213 227 238 320
TOK4 (270) 6 162 191
TOK5 (271) 38 39 237
BREAK (272) 18
CASE (273) 40 77 316
CHAN (274) 37 38 39
CONST (275) 47
CONTINUE (276) 57
DEFAULT (277) 41 78 317
DEFER (278) 66
ELSE (279) 129
FALLTHROUGH (280) 92
FOR (281) 106
FUNC (282) 114 117 119 172
GO (283) 120
GOTO (284) 121
IF (285) 125
IMPORT (286) 132
INTERFACE (287) 148
MAP (288) 171
PACKAGE (289) 185
RANGE (290) 211
RETURN (291) 230
SELECT (292) 233
STRUCT (293) 283
SWITCH (294) 79 321
TYPE (295) 297 318
VAR (296) 330


Nonterminals, with rules where they appear

$accept (54)
    on left: 0
AnonymousField (55)
    on left: 1, on right: 95
AnonymousField1 (56)
    on left: 2 3, on right: 1
ArgumentList (57)
    on left: 4, on right: 22 24 32
ArgumentList1 (58)
    on left: 5 6, on right: 4
ArrayLength (59)
    on left: 7, on right: 8
ArrayType (60)
    on left: 8, on right: 161 305
Assignment (61)
    on left: 9, on right: 246
BaseType (62)
    on left: 10, on right: 200
BaseTypeName (63)
    on left: 11, on right: 214
BasicLit (64)
    on left: 12 13 14 15 16, on right: 157
Block (65)
    on left: 17, on right: 106 113 125 131 274
BreakStmt (66)
    on left: 18, on right: 270
BreakStmt1 (67)
    on left: 19 20, on right: 18
BuiltinArgs (68)
    on left: 21 22, on right: 27
BuiltinArgs1 (69)
    on left: 23 24, on right: 21
BuiltinCall (70)
    on left: 25, on right: 204
BuiltinCall1 (71)
    on left: 26 27, on right: 25
BuiltinCall11 (72)
    on left: 28 29, on right: 27
Call (73)
    on left: 30, on right: 209
Call1 (74)
    on left: 31 32, on right: 30
Call11 (75)
    on left: 33 34, on right: 32
Channel (76)
    on left: 35, on right: 237
ChannelType (77)
    on left: 36, on right: 312
ChannelType1 (78)
    on left: 37 38 39, on right: 36
CommCase (79)
    on left: 40 41, on right: 44
CommCase1 (80)
    on left: 42 43, on right: 40
CommClause (81)
    on left: 44, on right: 235
CompositeLit (82)
    on left: 45, on right: 158
Condition (83)
    on left: 46, on right: 103 109
ConstDecl (84)
    on left: 47, on right: 63
ConstDecl1 (85)
    on left: 48 49, on right: 47
ConstDecl11 (86)
    on left: 50 51, on right: 49 51
ConstSpec (87)
    on left: 52, on right: 48 51
ConstSpec1 (88)
    on left: 53 54, on right: 52
ConstSpec11 (89)
    on left: 55 56, on right: 54
ContinueStmt (90)
    on left: 57, on right: 271
ContinueStmt1 (91)
    on left: 58 59, on right: 57
Conversion (92)
    on left: 60, on right: 203
Conversion1 (93)
    on left: 61 62, on right: 60
Declaration (94)
    on left: 63 64 65, on right: 265 289
DeferStmt (95)
    on left: 66, on right: 279
Element (96)
    on left: 67, on right: 71 73
Element1 (97)
    on left: 68 69, on right: 67
ElementIndex (98)
    on left: 70, on right: 153
ElementList (99)
    on left: 71, on right: 168
ElementList1 (100)
    on left: 72 73, on right: 71 73
ElementType (101)
    on left: 74, on right: 8 36 162 171 258
EmptyStmt (102)
    on left: 75, on right: 242
ExprCaseClause (103)
    on left: 76, on right: 85
ExprSwitchCase (104)
    on left: 77 78, on right: 76
ExprSwitchStmt (105)
    on left: 79, on right: 286
ExprSwitchStmt1 (106)
    on left: 80 81, on right: 79
ExprSwitchStmt2 (107)
    on left: 82 83, on right: 79
ExprSwitchStmt3 (108)
    on left: 84 85, on right: 79 85
Expression (109)
    on left: 86 87, on right: 7 35 46 60 66 70 83 87 88 90 91 120 125
    143 146 182 211 222 237 252 254 255 257 328
ExpressionList (110)
    on left: 88, on right: 4 9 54 77 212 226 232 238 337 339
ExpressionList1 (111)
    on left: 89 90, on right: 88 90
ExpressionStmt (112)
    on left: 91, on right: 243
FallthroughStmt (113)
    on left: 92, on right: 273
FieldDecl (114)
    on left: 93, on right: 285
FieldDecl1 (115)
    on left: 94 95, on right: 93
FieldDecl2 (116)
    on left: 96 97, on right: 93
FieldName (117)
    on left: 98, on right: 152
ForClause (118)
    on left: 99, on right: 110
ForClause1 (119)
    on left: 100 101, on right: 99
ForClause2 (120)
    on left: 102 103, on right: 99
ForClause3 (121)
    on left: 104 105, on right: 99
ForStmt (122)
    on left: 106, on right: 278
ForStmt1 (123)
    on left: 107 108, on right: 106
ForStmt11 (124)
    on left: 109 110 111, on right: 108
Function (125)
    on left: 112, on right: 115 117 173
FunctionBody (126)
    on left: 113, on right: 112
FunctionDecl (127)
    on left: 114, on right: 290
FunctionDecl1 (128)
    on left: 115 116, on right: 114
FunctionLit (129)
    on left: 117, on right: 159
FunctionName (130)
    on left: 118, on right: 114
FunctionType (131)
    on left: 119, on right: 308
GoStmt (132)
    on left: 120, on right: 268
GotoStmt (133)
    on left: 121, on right: 272
IdentifierList (134)
    on left: 122, on right: 52 94 189 213 227 238 335
IdentifierList1 (135)
    on left: 123 124, on right: 122 124
IfStmt (136)
    on left: 125, on right: 130 275
IfStmt1 (137)
    on left: 126 127, on right: 125
IfStmt2 (138)
    on left: 128 129, on right: 125
IfStmt21 (139)
    on left: 130 131, on right: 129
ImportDecl (140)
    on left: 132, on right: 261
ImportDecl1 (141)
    on left: 133 134, on right: 132
ImportDecl11 (142)
    on left: 135 136, on right: 134 136
ImportPath (143)
    on left: 137, on right: 138
ImportSpec (144)
    on left: 138, on right: 133 136
ImportSpec1 (145)
    on left: 139 140, on right: 138
ImportSpec11 (146)
    on left: 141 142, on right: 140
IncDecStmt (147)
    on left: 143, on right: 245
IncDecStmt1 (148)
    on left: 144 145, on right: 143
Index (149)
    on left: 146, on right: 206
InitStmt (150)
    on left: 147, on right: 101
InterfaceType (151)
    on left: 148, on right: 309
InterfaceType1 (152)
    on left: 149 150, on right: 148 150
InterfaceTypeName (153)
    on left: 151, on right: 178
Key (154)
    on left: 152 153, on right: 69
KeyType (155)
    on left: 154, on right: 171
Label (156)
    on left: 155, on right: 20 59 121 156
LabeledStmt (157)
    on left: 156, on right: 266
Literal (158)
    on left: 157 158 159, on right: 179
LiteralType (159)
    on left: 160 161 162 163 164 165, on right: 45
LiteralValue (160)
    on left: 166, on right: 45 329
LiteralValue1 (161)
    on left: 167 168, on right: 166
LiteralValue11 (162)
    on left: 169 170, on right: 168
MapType (163)
    on left: 171, on right: 164 311
MethodDecl (164)
    on left: 172, on right: 291
MethodDecl1 (165)
    on left: 173 174, on right: 172
MethodExpr (166)
    on left: 175, on right: 181
MethodName (167)
    on left: 176, on right: 172 175 177
MethodSpec (168)
    on left: 177 178, on right: 150
Operand (169)
    on left: 179 180 181 182, on right: 202
OperandName (170)
    on left: 183 184, on right: 180
PackageClause (171)
    on left: 185, on right: 259
PackageName (172)
    on left: 186, on right: 142 185 210
ParameterDecl (173)
    on left: 187, on right: 192 194
ParameterDecl1 (174)
    on left: 188 189, on right: 187
ParameterDecl2 (175)
    on left: 190 191, on right: 187
ParameterList (176)
    on left: 192, on right: 197
ParameterList1 (177)
    on left: 193 194, on right: 192 194
Parameters (178)
    on left: 195, on right: 228 239
Parameters1 (179)
    on left: 196 197, on right: 195
Parameters11 (180)
    on left: 198 199, on right: 197
PointerType (181)
    on left: 200, on right: 307
PostStmt (182)
    on left: 201, on right: 105
PrimaryExpr (183)
    on left: 202 203 204 205 206 207 208 209, on right: 205 206 207
    208 209 318 326
QualifiedIdent (184)
    on left: 210, on right: 184 314
RangeClause (185)
    on left: 211, on right: 111
RangeClause1 (186)
    on left: 212 213, on right: 211
Receiver (187)
    on left: 214, on right: 172
Receiver1 (188)
    on left: 215 216, on right: 214
Receiver2 (189)
    on left: 217 218, on right: 214
ReceiverType (190)
    on left: 219 220 221, on right: 175 221
RecvExpr (191)
    on left: 222, on right: 223
RecvStmt (192)
    on left: 223, on right: 43
RecvStmt1 (193)
    on left: 224 225, on right: 223
RecvStmt11 (194)
    on left: 226 227, on right: 225
Result (195)
    on left: 228 229, on right: 241
ReturnStmt (196)
    on left: 230, on right: 269
ReturnStmt1 (197)
    on left: 231 232, on right: 230
SelectStmt (198)
    on left: 233, on right: 277
SelectStmt1 (199)
    on left: 234 235, on right: 233 235
Selector (200)
    on left: 236, on right: 205
SendStmt (201)
    on left: 237, on right: 42 244
ShortVarDecl (202)
    on left: 238, on right: 247
Signature (203)
    on left: 239, on right: 112 116 119 174 177
Signature1 (204)
    on left: 240 241, on right: 239
SimpleStmt (205)
    on left: 242 243 244 245 246 247, on right: 81 127 147 201 267
    323
Slice (206)
    on left: 248 249, on right: 207
Slice1 (207)
    on left: 250, on right: 248
Slice11 (208)
    on left: 251 252, on right: 250
Slice12 (209)
    on left: 253 254, on right: 250
Slice2 (210)
    on left: 255, on right: 249
Slice21 (211)
    on left: 256 257, on right: 255
SliceType (212)
    on left: 258, on right: 163 310
SourceFile (213)
    on left: 259, on right: 264
SourceFile1 (214)
    on left: 260 261, on right: 259 261
SourceFile2 (215)
    on left: 262 263, on right: 259 263
Start (216)
    on left: 264, on right: 0
Statement (217)
    on left: 265 266 267 268 269 270 271 272 273 274 275 276 277 278
    279, on right: 156 282
StatementList (218)
    on left: 280, on right: 17 44 76 296
StatementList1 (219)
    on left: 281 282, on right: 280 282
StructType (220)
    on left: 283, on right: 160 306
StructType1 (221)
    on left: 284 285, on right: 283 285
SwitchStmt (222)
    on left: 286 287, on right: 276
Tag (223)
    on left: 288, on right: 97
TopLevelDecl (224)
    on left: 289 290 291, on right: 263
Type (225)
    on left: 292 293 294, on right: 10 21 56 60 74 94 154 187 229 294
    295 302 304 315 336
TypeAssertion (226)
    on left: 295, on right: 208
TypeCaseClause (227)
    on left: 296, on right: 325
TypeDecl (228)
    on left: 297, on right: 64
TypeDecl1 (229)
    on left: 298 299, on right: 297
TypeDecl11 (230)
    on left: 300 301, on right: 299 301
TypeList (231)
    on left: 302, on right: 316
TypeList1 (232)
    on left: 303 304, on right: 302 304
TypeLit (233)
    on left: 305 306 307 308 309 310 311 312, on right: 293
TypeName (234)
    on left: 313 314, on right: 1 151 165 219 220 292
TypeSpec (235)
    on left: 315, on right: 298 301
TypeSwitchCase (236)
    on left: 316 317, on right: 296
TypeSwitchGuard (237)
    on left: 318, on right: 321
TypeSwitchGuard1 (238)
    on left: 319 320, on right: 318
TypeSwitchStmt (239)
    on left: 321, on right: 287
TypeSwitchStmt1 (240)
    on left: 322 323, on right: 321
TypeSwitchStmt2 (241)
    on left: 324 325, on right: 321 325
UnaryExpr (242)
    on left: 326 327, on right: 86 87 327
Value (243)
    on left: 328 329, on right: 67
VarDecl (244)
    on left: 330, on right: 65
VarDecl1 (245)
    on left: 331 332, on right: 330
VarDecl11 (246)
    on left: 333 334, on right: 332 334
VarSpec (247)
    on left: 335, on right: 331 334
VarSpec1 (248)
    on left: 336 337, on right: 335
VarSpec11 (249)
    on left: 338 339, on right: 336


state 0

    0 $accept: . Start $end
  185 PackageClause: . PACKAGE PackageName
  259 SourceFile: . PackageClause ';' SourceFile1 SourceFile2
  264 Start: . SourceFile

    PACKAGE  shift, and go to state 1

    PackageClause  go to state 2
    SourceFile     go to state 3
    Start          go to state 4


state 1

  185 PackageClause: PACKAGE . PackageName
  186 PackageName: . IDENTIFIER

    IDENTIFIER  shift, and go to state 5

    PackageName  go to state 6


state 2

  259 SourceFile: PackageClause . ';' SourceFile1 SourceFile2

    ';'  shift, and go to state 7


state 3

  264 Start: SourceFile .

    $default  reduce using rule 264 (Start)


state 4

    0 $accept: Start . $end

    $end  shift, and go to state 8


state 5

  186 PackageName: IDENTIFIER .

    $default  reduce using rule 186 (PackageName)


state 6

  185 PackageClause: PACKAGE PackageName .

    $default  reduce using rule 185 (PackageClause)


state 7

  259 SourceFile: PackageClause ';' . SourceFile1 SourceFile2
  260 SourceFile1: .
  261            | . SourceFile1 ImportDecl ';'

    $default  reduce using rule 260 (SourceFile1)

    SourceFile1  go to state 9


state 8

    0 $accept: Start $end .

    $default  accept


state 9

  132 ImportDecl: . IMPORT ImportDecl1
  259 SourceFile: PackageClause ';' SourceFile1 . SourceFile2
  261 SourceFile1: SourceFile1 . ImportDecl ';'
  262 SourceFile2: .  [$end, CONST, FUNC, TYPE, VAR]
  263            | . SourceFile2 TopLevelDecl ';'

    IMPORT  shift, and go to state 10

    $default  reduce using rule 262 (SourceFile2)

    ImportDecl   go to state 11
    SourceFile2  go to state 12


state 10

  132 ImportDecl: IMPORT . ImportDecl1
  133 ImportDecl1: . ImportSpec
  134            | . '(' ImportDecl11 ')'
  138 ImportSpec: . ImportSpec1 ImportPath
  139 ImportSpec1: .  [STRING_LIT]
  140            | . ImportSpec11
  141 ImportSpec11: . '.'
  142             | . PackageName
  186 PackageName: . IDENTIFIER

    IDENTIFIER  shift, and go to state 5
    '('         shift, and go to state 13
    '.'         shift, and go to state 14

    $default  reduce using rule 139 (ImportSpec1)

    ImportDecl1   go to state 15
    ImportSpec    go to state 16
    ImportSpec1   go to state 17
    ImportSpec11  go to state 18
    PackageName   go to state 19


state 11

  261 SourceFile1: SourceFile1 ImportDecl . ';'

    ';'  shift, and go to state 20


state 12

   47 ConstDecl: . CONST ConstDecl1
   63 Declaration: . ConstDecl
   64            | . TypeDecl
   65            | . VarDecl
  114 FunctionDecl: . FUNC FunctionName FunctionDecl1
  172 MethodDecl: . FUNC Receiver MethodName MethodDecl1
  259 SourceFile: PackageClause ';' SourceFile1 SourceFile2 .  [$end]
  263 SourceFile2: SourceFile2 . TopLevelDecl ';'
  289 TopLevelDecl: . Declaration
  290             | . FunctionDecl
  291             | . MethodDecl
  297 TypeDecl: . TYPE TypeDecl1
  330 VarDecl: . VAR VarDecl1

    CONST  shift, and go to state 21
    FUNC   shift, and go to state 22
    TYPE   shift, and go to state 23
    VAR    shift, and go to state 24

    $default  reduce using rule 259 (SourceFile)

    ConstDecl     go to state 25
    Declaration   go to state 26
    FunctionDecl  go to state 27
    MethodDecl    go to state 28
    TopLevelDecl  go to state 29
    TypeDecl      go to state 30
    VarDecl       go to state 31


state 13

  134 ImportDecl1: '(' . ImportDecl11 ')'
  135 ImportDecl11: .
  136             | . ImportDecl11 ImportSpec ';'

    $default  reduce using rule 135 (ImportDecl11)

    ImportDecl11  go to state 32


state 14

  141 ImportSpec11: '.' .

    $default  reduce using rule 141 (ImportSpec11)


state 15

  132 ImportDecl: IMPORT ImportDecl1 .

    $default  reduce using rule 132 (ImportDecl)


state 16

  133 ImportDecl1: ImportSpec .

    $default  reduce using rule 133 (ImportDecl1)


state 17

  137 ImportPath: . STRING_LIT
  138 ImportSpec: ImportSpec1 . ImportPath

    STRING_LIT  shift, and go to state 33

    ImportPath  go to state 34


state 18

  140 ImportSpec1: ImportSpec11 .

    $default  reduce using rule 140 (ImportSpec1)


state 19

  142 ImportSpec11: PackageName .

    $default  reduce using rule 142 (ImportSpec11)


state 20

  261 SourceFile1: SourceFile1 ImportDecl ';' .

    $default  reduce using rule 261 (SourceFile1)


state 21

   47 ConstDecl: CONST . ConstDecl1
   48 ConstDecl1: . ConstSpec
   49           | . '(' ConstDecl11 ')'
   52 ConstSpec: . IdentifierList ConstSpec1
  122 IdentifierList: . IDENTIFIER IdentifierList1

    IDENTIFIER  shift, and go to state 35
    '('         shift, and go to state 36

    ConstDecl1      go to state 37
    ConstSpec       go to state 38
    IdentifierList  go to state 39


state 22

  114 FunctionDecl: FUNC . FunctionName FunctionDecl1
  118 FunctionName: . IDENTIFIER
  172 MethodDecl: FUNC . Receiver MethodName MethodDecl1
  214 Receiver: . '(' Receiver1 Receiver2 BaseTypeName ')'

    IDENTIFIER  shift, and go to state 40
    '('         shift, and go to state 41

    FunctionName  go to state 42
    Receiver      go to state 43


state 23

  297 TypeDecl: TYPE . TypeDecl1
  298 TypeDecl1: . TypeSpec
  299          | . '(' TypeDecl11 ')'
  315 TypeSpec: . IDENTIFIER Type

    IDENTIFIER  shift, and go to state 44
    '('         shift, and go to state 45

    TypeDecl1  go to state 46
    TypeSpec   go to state 47


state 24

  122 IdentifierList: . IDENTIFIER IdentifierList1
  330 VarDecl: VAR . VarDecl1
  331 VarDecl1: . VarSpec
  332         | . '(' VarDecl11 ')'
  335 VarSpec: . IdentifierList VarSpec1

    IDENTIFIER  shift, and go to state 35
    '('         shift, and go to state 48

    IdentifierList  go to state 49
    VarDecl1        go to state 50
    VarSpec         go to state 51


state 25

   63 Declaration: ConstDecl .

    $default  reduce using rule 63 (Declaration)


state 26

  289 TopLevelDecl: Declaration .

    $default  reduce using rule 289 (TopLevelDecl)


state 27

  290 TopLevelDecl: FunctionDecl .

    $default  reduce using rule 290 (TopLevelDecl)


state 28

  291 TopLevelDecl: MethodDecl .

    $default  reduce using rule 291 (TopLevelDecl)


state 29

  263 SourceFile2: SourceFile2 TopLevelDecl . ';'

    ';'  shift, and go to state 52


state 30

   64 Declaration: TypeDecl .

    $default  reduce using rule 64 (Declaration)


state 31

   65 Declaration: VarDecl .

    $default  reduce using rule 65 (Declaration)


state 32

  134 ImportDecl1: '(' ImportDecl11 . ')'
  136 ImportDecl11: ImportDecl11 . ImportSpec ';'
  138 ImportSpec: . ImportSpec1 ImportPath
  139 ImportSpec1: .  [STRING_LIT]
  140            | . ImportSpec11
  141 ImportSpec11: . '.'
  142             | . PackageName
  186 PackageName: . IDENTIFIER

    IDENTIFIER  shift, and go to state 5
    ')'         shift, and go to state 53
    '.'         shift, and go to state 14

    $default  reduce using rule 139 (ImportSpec1)

    ImportSpec    go to state 54
    ImportSpec1   go to state 17
    ImportSpec11  go to state 18
    PackageName   go to state 19


state 33

  137 ImportPath: STRING_LIT .

    $default  reduce using rule 137 (ImportPath)


state 34

  138 ImportSpec: ImportSpec1 ImportPath .

    $default  reduce using rule 138 (ImportSpec)


state 35

  122 IdentifierList: IDENTIFIER . IdentifierList1
  123 IdentifierList1: .
  124                | . IdentifierList1 ',' IDENTIFIER

    $default  reduce using rule 123 (IdentifierList1)

    IdentifierList1  go to state 55


state 36

   49 ConstDecl1: '(' . ConstDecl11 ')'
   50 ConstDecl11: .
   51            | . ConstDecl11 ConstSpec ';'

    $default  reduce using rule 50 (ConstDecl11)

    ConstDecl11  go to state 56


state 37

   47 ConstDecl: CONST ConstDecl1 .

    $default  reduce using rule 47 (ConstDecl)


state 38

   48 ConstDecl1: ConstSpec .

    $default  reduce using rule 48 (ConstDecl1)


state 39

    8 ArrayType: . '[' ArrayLength ']' ElementType
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   52 ConstSpec: IdentifierList . ConstSpec1
   53 ConstSpec1: .  [';']
   54           | . ConstSpec11 '=' ExpressionList
   55 ConstSpec11: .  ['=']
   56            | . Type
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66

    '='       reduce using rule 55 (ConstSpec11)
    $default  reduce using rule 53 (ConstSpec1)

    ArrayType       go to state 67
    ChannelType     go to state 68
    ChannelType1    go to state 69
    ConstSpec1      go to state 70
    ConstSpec11     go to state 71
    FunctionType    go to state 72
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 80
    TypeLit         go to state 81
    TypeName        go to state 82


state 40

  118 FunctionName: IDENTIFIER .

    $default  reduce using rule 118 (FunctionName)


state 41

  214 Receiver: '(' . Receiver1 Receiver2 BaseTypeName ')'
  215 Receiver1: .  [IDENTIFIER, '*']
  216          | . IDENTIFIER

    IDENTIFIER  shift, and go to state 83

    IDENTIFIER  [reduce using rule 215 (Receiver1)]
    $default    reduce using rule 215 (Receiver1)

    Receiver1  go to state 84


state 42

  112 Function: . Signature FunctionBody
  114 FunctionDecl: FUNC FunctionName . FunctionDecl1
  115 FunctionDecl1: . Function
  116              | . Signature
  195 Parameters: . '(' Parameters1 ')'
  239 Signature: . Parameters Signature1

    '('  shift, and go to state 85

    Function       go to state 86
    FunctionDecl1  go to state 87
    Parameters     go to state 88
    Signature      go to state 89


state 43

  172 MethodDecl: FUNC Receiver . MethodName MethodDecl1
  176 MethodName: . IDENTIFIER

    IDENTIFIER  shift, and go to state 90

    MethodName  go to state 91


state 44

    8 ArrayType: . '[' ArrayLength ']' ElementType
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  315 TypeSpec: IDENTIFIER . Type

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66

    ArrayType       go to state 67
    ChannelType     go to state 68
    ChannelType1    go to state 69
    FunctionType    go to state 72
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 92
    TypeLit         go to state 81
    TypeName        go to state 82


state 45

  299 TypeDecl1: '(' . TypeDecl11 ')'
  300 TypeDecl11: .
  301           | . TypeDecl11 TypeSpec ';'

    $default  reduce using rule 300 (TypeDecl11)

    TypeDecl11  go to state 93


state 46

  297 TypeDecl: TYPE TypeDecl1 .

    $default  reduce using rule 297 (TypeDecl)


state 47

  298 TypeDecl1: TypeSpec .

    $default  reduce using rule 298 (TypeDecl1)


state 48

  332 VarDecl1: '(' . VarDecl11 ')'
  333 VarDecl11: .
  334          | . VarDecl11 VarSpec ';'

    $default  reduce using rule 333 (VarDecl11)

    VarDecl11  go to state 94


state 49

    8 ArrayType: . '[' ArrayLength ']' ElementType
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  335 VarSpec: IdentifierList . VarSpec1
  336 VarSpec1: . Type VarSpec11
  337         | . '=' ExpressionList

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66
    '='         shift, and go to state 95

    ArrayType       go to state 67
    ChannelType     go to state 68
    ChannelType1    go to state 69
    FunctionType    go to state 72
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 96
    TypeLit         go to state 81
    TypeName        go to state 82
    VarSpec1        go to state 97


state 50

  330 VarDecl: VAR VarDecl1 .

    $default  reduce using rule 330 (VarDecl)


state 51

  331 VarDecl1: VarSpec .

    $default  reduce using rule 331 (VarDecl1)


state 52

  263 SourceFile2: SourceFile2 TopLevelDecl ';' .

    $default  reduce using rule 263 (SourceFile2)


state 53

  134 ImportDecl1: '(' ImportDecl11 ')' .

    $default  reduce using rule 134 (ImportDecl1)


state 54

  136 ImportDecl11: ImportDecl11 ImportSpec . ';'

    ';'  shift, and go to state 98


state 55

  122 IdentifierList: IDENTIFIER IdentifierList1 .  [IDENTIFIER, TOK3, TOK4, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', '(', ';', '=']
  124 IdentifierList1: IdentifierList1 . ',' IDENTIFIER

    ','  shift, and go to state 99

    $default  reduce using rule 122 (IdentifierList)


state 56

   49 ConstDecl1: '(' ConstDecl11 . ')'
   51 ConstDecl11: ConstDecl11 . ConstSpec ';'
   52 ConstSpec: . IdentifierList ConstSpec1
  122 IdentifierList: . IDENTIFIER IdentifierList1

    IDENTIFIER  shift, and go to state 35
    ')'         shift, and go to state 100

    ConstSpec       go to state 101
    IdentifierList  go to state 39


state 57

  186 PackageName: IDENTIFIER .  ['.']
  313 TypeName: IDENTIFIER .  [STRING_LIT, ']', '{', ',', '(', ')', ':', ';', '=']

    '.'       reduce using rule 186 (PackageName)
    $default  reduce using rule 313 (TypeName)


state 58

   39 ChannelType1: TOK5 . CHAN

    CHAN  shift, and go to state 102


state 59

   37 ChannelType1: CHAN .  [IDENTIFIER, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', '(']
   38             | CHAN . TOK5

    TOK5  shift, and go to state 103

    TOK5      [reduce using rule 37 (ChannelType1)]
    $default  reduce using rule 37 (ChannelType1)


state 60

  119 FunctionType: FUNC . Signature
  195 Parameters: . '(' Parameters1 ')'
  239 Signature: . Parameters Signature1

    '('  shift, and go to state 85

    Parameters  go to state 88
    Signature   go to state 104


state 61

  148 InterfaceType: INTERFACE . '{' InterfaceType1 '}'

    '{'  shift, and go to state 105


state 62

  171 MapType: MAP . '[' KeyType ']' ElementType

    '['  shift, and go to state 106


state 63

  283 StructType: STRUCT . '{' StructType1 '}'

    '{'  shift, and go to state 107


state 64

    8 ArrayType: . '[' ArrayLength ']' ElementType
   10 BaseType: . Type
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  200            | '*' . BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66

    ArrayType       go to state 67
    BaseType        go to state 108
    ChannelType     go to state 68
    ChannelType1    go to state 69
    FunctionType    go to state 72
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 109
    TypeLit         go to state 81
    TypeName        go to state 82


state 65

    7 ArrayLength: . Expression
    8 ArrayType: . '[' ArrayLength ']' ElementType
    8          | '[' . ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  258          | '[' . ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    ']'            shift, and go to state 119
    '('            shift, and go to state 120

    ArrayLength     go to state 121
    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 127
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 66

    8 ArrayType: . '[' ArrayLength ']' ElementType
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  294     | '(' . Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66

    ArrayType       go to state 67
    ChannelType     go to state 68
    ChannelType1    go to state 69
    FunctionType    go to state 72
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 143
    TypeLit         go to state 81
    TypeName        go to state 82


state 67

  305 TypeLit: ArrayType .

    $default  reduce using rule 305 (TypeLit)


state 68

  312 TypeLit: ChannelType .

    $default  reduce using rule 312 (TypeLit)


state 69

    8 ArrayType: . '[' ArrayLength ']' ElementType
   36 ChannelType: . ChannelType1 ElementType
   36            | ChannelType1 . ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   74 ElementType: . Type
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66

    ArrayType       go to state 67
    ChannelType     go to state 68
    ChannelType1    go to state 69
    ElementType     go to state 144
    FunctionType    go to state 72
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 145
    TypeLit         go to state 81
    TypeName        go to state 82


state 70

   52 ConstSpec: IdentifierList ConstSpec1 .

    $default  reduce using rule 52 (ConstSpec)


state 71

   54 ConstSpec1: ConstSpec11 . '=' ExpressionList

    '='  shift, and go to state 146


state 72

  308 TypeLit: FunctionType .

    $default  reduce using rule 308 (TypeLit)


state 73

  309 TypeLit: InterfaceType .

    $default  reduce using rule 309 (TypeLit)


state 74

  311 TypeLit: MapType .

    $default  reduce using rule 311 (TypeLit)


state 75

  210 QualifiedIdent: PackageName . '.' IDENTIFIER

    '.'  shift, and go to state 147


state 76

  307 TypeLit: PointerType .

    $default  reduce using rule 307 (TypeLit)


state 77

  314 TypeName: QualifiedIdent .

    $default  reduce using rule 314 (TypeName)


state 78

  310 TypeLit: SliceType .

    $default  reduce using rule 310 (TypeLit)


state 79

  306 TypeLit: StructType .

    $default  reduce using rule 306 (TypeLit)


state 80

   56 ConstSpec11: Type .

    $default  reduce using rule 56 (ConstSpec11)


state 81

  293 Type: TypeLit .

    $default  reduce using rule 293 (Type)


state 82

  292 Type: TypeName .

    $default  reduce using rule 292 (Type)


state 83

  216 Receiver1: IDENTIFIER .

    $default  reduce using rule 216 (Receiver1)


state 84

  214 Receiver: '(' Receiver1 . Receiver2 BaseTypeName ')'
  217 Receiver2: .  [IDENTIFIER]
  218          | . '*'

    '*'  shift, and go to state 148

    $default  reduce using rule 217 (Receiver2)

    Receiver2  go to state 149


state 85

  122 IdentifierList: . IDENTIFIER IdentifierList1
  187 ParameterDecl: . ParameterDecl1 ParameterDecl2 Type
  188 ParameterDecl1: .  [IDENTIFIER, TOK4, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', '(']
  189               | . IdentifierList
  192 ParameterList: . ParameterDecl ParameterList1
  195 Parameters: '(' . Parameters1 ')'
  196 Parameters1: .  [')']
  197            | . ParameterList Parameters11

    IDENTIFIER  shift, and go to state 35

    IDENTIFIER  [reduce using rule 188 (ParameterDecl1)]
    ')'         reduce using rule 196 (Parameters1)
    $default    reduce using rule 188 (ParameterDecl1)

    IdentifierList  go to state 150
    ParameterDecl   go to state 151
    ParameterDecl1  go to state 152
    ParameterList   go to state 153
    Parameters1     go to state 154


state 86

  115 FunctionDecl1: Function .

    $default  reduce using rule 115 (FunctionDecl1)


state 87

  114 FunctionDecl: FUNC FunctionName FunctionDecl1 .

    $default  reduce using rule 114 (FunctionDecl)


state 88

    8 ArrayType: . '[' ArrayLength ']' ElementType
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  195 Parameters: . '(' Parameters1 ')'
  200 PointerType: . '*' BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  228 Result: . Parameters
  229       | . Type
  239 Signature: Parameters . Signature1
  240 Signature1: .  [STRING_LIT, ']', '{', ',', '(', ')', ':', ';', '=']
  241           | . Result
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 155

    '('       [reduce using rule 240 (Signature1)]
    $default  reduce using rule 240 (Signature1)

    ArrayType       go to state 67
    ChannelType     go to state 68
    ChannelType1    go to state 69
    FunctionType    go to state 72
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    Parameters      go to state 156
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    Result          go to state 157
    Signature1      go to state 158
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 159
    TypeLit         go to state 81
    TypeName        go to state 82


state 89

   17 Block: . '{' StatementList '}'
  112 Function: Signature . FunctionBody
  113 FunctionBody: . Block
  116 FunctionDecl1: Signature .  [';']

    '{'  shift, and go to state 160

    $default  reduce using rule 116 (FunctionDecl1)

    Block         go to state 161
    FunctionBody  go to state 162


state 90

  176 MethodName: IDENTIFIER .

    $default  reduce using rule 176 (MethodName)


state 91

  112 Function: . Signature FunctionBody
  172 MethodDecl: FUNC Receiver MethodName . MethodDecl1
  173 MethodDecl1: . Function
  174            | . Signature
  195 Parameters: . '(' Parameters1 ')'
  239 Signature: . Parameters Signature1

    '('  shift, and go to state 85

    Function     go to state 163
    MethodDecl1  go to state 164
    Parameters   go to state 88
    Signature    go to state 165


state 92

  315 TypeSpec: IDENTIFIER Type .

    $default  reduce using rule 315 (TypeSpec)


state 93

  299 TypeDecl1: '(' TypeDecl11 . ')'
  301 TypeDecl11: TypeDecl11 . TypeSpec ';'
  315 TypeSpec: . IDENTIFIER Type

    IDENTIFIER  shift, and go to state 44
    ')'         shift, and go to state 166

    TypeSpec  go to state 167


state 94

  122 IdentifierList: . IDENTIFIER IdentifierList1
  332 VarDecl1: '(' VarDecl11 . ')'
  334 VarDecl11: VarDecl11 . VarSpec ';'
  335 VarSpec: . IdentifierList VarSpec1

    IDENTIFIER  shift, and go to state 35
    ')'         shift, and go to state 168

    IdentifierList  go to state 49
    VarSpec         go to state 169


state 95

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   88 ExpressionList: . Expression ExpressionList1
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr
  337 VarSpec1: '=' . ExpressionList

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 170
    ExpressionList  go to state 171
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 96

  336 VarSpec1: Type . VarSpec11
  338 VarSpec11: .  [';']
  339          | . '=' ExpressionList

    '='  shift, and go to state 172

    $default  reduce using rule 338 (VarSpec11)

    VarSpec11  go to state 173


state 97

  335 VarSpec: IdentifierList VarSpec1 .

    $default  reduce using rule 335 (VarSpec)


state 98

  136 ImportDecl11: ImportDecl11 ImportSpec ';' .

    $default  reduce using rule 136 (ImportDecl11)


state 99

  124 IdentifierList1: IdentifierList1 ',' . IDENTIFIER

    IDENTIFIER  shift, and go to state 174


state 100

   49 ConstDecl1: '(' ConstDecl11 ')' .

    $default  reduce using rule 49 (ConstDecl1)


state 101

   51 ConstDecl11: ConstDecl11 ConstSpec . ';'

    ';'  shift, and go to state 175


state 102

   39 ChannelType1: TOK5 CHAN .

    $default  reduce using rule 39 (ChannelType1)


state 103

   38 ChannelType1: CHAN TOK5 .

    $default  reduce using rule 38 (ChannelType1)


state 104

  119 FunctionType: FUNC Signature .

    $default  reduce using rule 119 (FunctionType)


state 105

  148 InterfaceType: INTERFACE '{' . InterfaceType1 '}'
  149 InterfaceType1: .
  150               | . InterfaceType1 MethodSpec ';'

    $default  reduce using rule 149 (InterfaceType1)

    InterfaceType1  go to state 176


state 106

    8 ArrayType: . '[' ArrayLength ']' ElementType
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  154 KeyType: . Type
  171 MapType: . MAP '[' KeyType ']' ElementType
  171        | MAP '[' . KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66

    ArrayType       go to state 67
    ChannelType     go to state 68
    ChannelType1    go to state 69
    FunctionType    go to state 72
    InterfaceType   go to state 73
    KeyType         go to state 177
    MapType         go to state 74
    PackageName     go to state 75
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 178
    TypeLit         go to state 81
    TypeName        go to state 82


state 107

  283 StructType: STRUCT '{' . StructType1 '}'
  284 StructType1: .
  285            | . StructType1 FieldDecl ';'

    $default  reduce using rule 284 (StructType1)

    StructType1  go to state 179


state 108

  200 PointerType: '*' BaseType .

    $default  reduce using rule 200 (PointerType)


state 109

   10 BaseType: Type .

    $default  reduce using rule 10 (BaseType)


state 110

   13 BasicLit: FLOAT_LIT .

    $default  reduce using rule 13 (BasicLit)


state 111

   25 BuiltinCall: IDENTIFIER . '(' BuiltinCall1 ')'
  183 OperandName: IDENTIFIER .  [ASSIGN_OP, BINARY_OP, FLOAT_LIT, IDENTIFIER, IMAGINARY_LIT, INT_LIT, RUNE_LIT, STRING_LIT, UNARY_OP, TOK1, TOK2, TOK4, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', ']', '{', '}', ',', '(', ')', ':', ';', '=', '.']
  186 PackageName: IDENTIFIER .  ['.']
  313 TypeName: IDENTIFIER .  ['{', ',', '(', ')', '.']

    '('  shift, and go to state 180

    '{'       reduce using rule 183 (OperandName)
    '{'       [reduce using rule 313 (TypeName)]
    ','       reduce using rule 183 (OperandName)
    ','       [reduce using rule 313 (TypeName)]
    '('       [reduce using rule 183 (OperandName)]
    '('       [reduce using rule 313 (TypeName)]
    ')'       reduce using rule 183 (OperandName)
    ')'       [reduce using rule 313 (TypeName)]
    '.'       reduce using rule 183 (OperandName)
    '.'       [reduce using rule 186 (PackageName)]
    '.'       [reduce using rule 313 (TypeName)]
    $default  reduce using rule 183 (OperandName)


state 112

   14 BasicLit: IMAGINARY_LIT .

    $default  reduce using rule 14 (BasicLit)


state 113

   12 BasicLit: INT_LIT .

    $default  reduce using rule 12 (BasicLit)


state 114

   15 BasicLit: RUNE_LIT .

    $default  reduce using rule 15 (BasicLit)


state 115

   16 BasicLit: STRING_LIT .

    $default  reduce using rule 16 (BasicLit)


state 116

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr
  327          | UNARY_OP . UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 181


state 117

  112 Function: . Signature FunctionBody
  117 FunctionLit: FUNC . Function
  119 FunctionType: FUNC . Signature
  195 Parameters: . '(' Parameters1 ')'
  239 Signature: . Parameters Signature1

    '('  shift, and go to state 85

    Function    go to state 182
    Parameters  go to state 88
    Signature   go to state 183


state 118

    7 ArrayLength: . Expression
    8 ArrayType: . '[' ArrayLength ']' ElementType
    8          | '[' . ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  162            | '[' . TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  258          | '[' . ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK4           shift, and go to state 184
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    ']'            shift, and go to state 119
    '('            shift, and go to state 120

    ArrayLength     go to state 121
    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 127
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 119

    8 ArrayType: . '[' ArrayLength ']' ElementType
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   74 ElementType: . Type
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  258 SliceType: . '[' ']' ElementType
  258          | '[' ']' . ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66

    ArrayType       go to state 67
    ChannelType     go to state 68
    ChannelType1    go to state 69
    ElementType     go to state 185
    FunctionType    go to state 72
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 145
    TypeLit         go to state 81
    TypeName        go to state 82


state 120

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  182        | '(' . Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  220             | '(' . '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  221             | '(' . ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  294     | '(' . Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 186
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 187
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 188
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 189
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 121

    8 ArrayType: '[' ArrayLength . ']' ElementType

    ']'  shift, and go to state 190


state 122

  161 LiteralType: ArrayType .  ['{']
  305 TypeLit: ArrayType .  [',', '(', ')']

    '{'       reduce using rule 161 (LiteralType)
    $default  reduce using rule 305 (TypeLit)


state 123

  157 Literal: BasicLit .

    $default  reduce using rule 157 (Literal)


state 124

  204 PrimaryExpr: BuiltinCall .

    $default  reduce using rule 204 (PrimaryExpr)


state 125

  158 Literal: CompositeLit .

    $default  reduce using rule 158 (Literal)


state 126

  203 PrimaryExpr: Conversion .

    $default  reduce using rule 203 (PrimaryExpr)


state 127

    7 ArrayLength: Expression .  [']']
   87 Expression: Expression . BINARY_OP UnaryExpr

    BINARY_OP  shift, and go to state 191

    $default  reduce using rule 7 (ArrayLength)


state 128

  159 Literal: FunctionLit .

    $default  reduce using rule 159 (Literal)


state 129

  179 Operand: Literal .

    $default  reduce using rule 179 (Operand)


state 130

   45 CompositeLit: LiteralType . LiteralValue
  166 LiteralValue: . '{' LiteralValue1 '}'

    '{'  shift, and go to state 192

    LiteralValue  go to state 193


state 131

  164 LiteralType: MapType .  ['{']
  311 TypeLit: MapType .  [',', '(', ')']

    '{'       reduce using rule 164 (LiteralType)
    $default  reduce using rule 311 (TypeLit)


state 132

  181 Operand: MethodExpr .

    $default  reduce using rule 181 (Operand)


state 133

  202 PrimaryExpr: Operand .

    $default  reduce using rule 202 (PrimaryExpr)


state 134

  180 Operand: OperandName .

    $default  reduce using rule 180 (Operand)


state 135

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   30 Call: . '(' Call1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  146 Index: . '[' Expression ']'
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  205            | PrimaryExpr . Selector
  206            | . PrimaryExpr Index
  206            | PrimaryExpr . Index
  207            | . PrimaryExpr Slice
  207            | PrimaryExpr . Slice
  208            | . PrimaryExpr TypeAssertion
  208            | PrimaryExpr . TypeAssertion
  209            | . PrimaryExpr Call
  209            | PrimaryExpr . Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  236 Selector: . '.' IDENTIFIER
  248 Slice: . '[' Slice1
  249      | . Slice2 ']'
  255 Slice2: . Slice21 ':' Expression ':' Expression
  256 Slice21: .  [':']
  257        | . Expression
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  295 TypeAssertion: . '.' '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  326          | PrimaryExpr .  [ASSIGN_OP, BINARY_OP, FLOAT_LIT, IDENTIFIER, IMAGINARY_LIT, INT_LIT, RUNE_LIT, STRING_LIT, UNARY_OP, TOK1, TOK2, TOK4, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', ']', '{', '}', ',', '(', ')', ':', ';', '=', '.']
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 194
    '('            shift, and go to state 195
    '.'            shift, and go to state 196

    FLOAT_LIT      [reduce using rule 326 (UnaryExpr)]
    IDENTIFIER     [reduce using rule 326 (UnaryExpr)]
    IMAGINARY_LIT  [reduce using rule 326 (UnaryExpr)]
    INT_LIT        [reduce using rule 326 (UnaryExpr)]
    RUNE_LIT       [reduce using rule 326 (UnaryExpr)]
    STRING_LIT     [reduce using rule 326 (UnaryExpr)]
    UNARY_OP       [reduce using rule 326 (UnaryExpr)]
    TOK5           [reduce using rule 326 (UnaryExpr)]
    CHAN           [reduce using rule 326 (UnaryExpr)]
    FUNC           [reduce using rule 326 (UnaryExpr)]
    INTERFACE      [reduce using rule 326 (UnaryExpr)]
    MAP            [reduce using rule 326 (UnaryExpr)]
    STRUCT         [reduce using rule 326 (UnaryExpr)]
    '*'            [reduce using rule 326 (UnaryExpr)]
    '['            [reduce using rule 326 (UnaryExpr)]
    '('            [reduce using rule 326 (UnaryExpr)]
    ':'            reduce using rule 256 (Slice21)
    ':'            [reduce using rule 326 (UnaryExpr)]
    '.'            [reduce using rule 326 (UnaryExpr)]
    $default       reduce using rule 326 (UnaryExpr)

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    Call            go to state 197
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 198
    FunctionLit     go to state 128
    FunctionType    go to state 72
    Index           go to state 199
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    Selector        go to state 200
    Slice           go to state 201
    Slice2          go to state 202
    Slice21         go to state 203
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeAssertion   go to state 204
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 136

  184 OperandName: QualifiedIdent .  [ASSIGN_OP, BINARY_OP, FLOAT_LIT, IDENTIFIER, IMAGINARY_LIT, INT_LIT, RUNE_LIT, STRING_LIT, UNARY_OP, TOK1, TOK2, TOK4, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', ']', '{', '}', ',', '(', ')', ':', ';', '=', '.']
  314 TypeName: QualifiedIdent .  ['{', ',', '(', ')', '.']

    '{'       reduce using rule 184 (OperandName)
    '{'       [reduce using rule 314 (TypeName)]
    ','       reduce using rule 184 (OperandName)
    ','       [reduce using rule 314 (TypeName)]
    '('       reduce using rule 184 (OperandName)
    '('       [reduce using rule 314 (TypeName)]
    ')'       reduce using rule 184 (OperandName)
    ')'       [reduce using rule 314 (TypeName)]
    '.'       reduce using rule 184 (OperandName)
    '.'       [reduce using rule 314 (TypeName)]
    $default  reduce using rule 184 (OperandName)


state 137

  175 MethodExpr: ReceiverType . '.' MethodName

    '.'  shift, and go to state 205


state 138

  163 LiteralType: SliceType .  ['{']
  310 TypeLit: SliceType .  [',', '(', ')']

    '{'       reduce using rule 163 (LiteralType)
    $default  reduce using rule 310 (TypeLit)


state 139

  160 LiteralType: StructType .  ['{']
  306 TypeLit: StructType .  [',', '(', ')']

    '{'       reduce using rule 160 (LiteralType)
    $default  reduce using rule 306 (TypeLit)


state 140

   60 Conversion: Type . '(' Expression Conversion1 ')'

    '('  shift, and go to state 206


state 141

  165 LiteralType: TypeName .  ['{']
  219 ReceiverType: TypeName .  [')', '.']
  292 Type: TypeName .  [',', '(', ')']

    '{'       reduce using rule 165 (LiteralType)
    ','       reduce using rule 292 (Type)
    '('       reduce using rule 292 (Type)
    ')'       reduce using rule 219 (ReceiverType)
    ')'       [reduce using rule 292 (Type)]
    $default  reduce using rule 219 (ReceiverType)


state 142

   86 Expression: UnaryExpr .

    $default  reduce using rule 86 (Expression)


state 143

  294 Type: '(' Type . ')'

    ')'  shift, and go to state 207


state 144

   36 ChannelType: ChannelType1 ElementType .

    $default  reduce using rule 36 (ChannelType)


state 145

   74 ElementType: Type .

    $default  reduce using rule 74 (ElementType)


state 146

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   54 ConstSpec1: ConstSpec11 '=' . ExpressionList
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   88 ExpressionList: . Expression ExpressionList1
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 170
    ExpressionList  go to state 208
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 147

  210 QualifiedIdent: PackageName '.' . IDENTIFIER

    IDENTIFIER  shift, and go to state 209


state 148

  218 Receiver2: '*' .

    $default  reduce using rule 218 (Receiver2)


state 149

   11 BaseTypeName: . IDENTIFIER
  214 Receiver: '(' Receiver1 Receiver2 . BaseTypeName ')'

    IDENTIFIER  shift, and go to state 210

    BaseTypeName  go to state 211


state 150

  189 ParameterDecl1: IdentifierList .

    $default  reduce using rule 189 (ParameterDecl1)


state 151

  192 ParameterList: ParameterDecl . ParameterList1
  193 ParameterList1: .
  194               | . ParameterList1 ',' ParameterDecl

    $default  reduce using rule 193 (ParameterList1)

    ParameterList1  go to state 212


state 152

  187 ParameterDecl: ParameterDecl1 . ParameterDecl2 Type
  190 ParameterDecl2: .  [IDENTIFIER, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', '(']
  191               | . TOK4

    TOK4  shift, and go to state 213

    $default  reduce using rule 190 (ParameterDecl2)

    ParameterDecl2  go to state 214


state 153

  197 Parameters1: ParameterList . Parameters11
  198 Parameters11: .  [')']
  199             | . ','

    ','  shift, and go to state 215

    $default  reduce using rule 198 (Parameters11)

    Parameters11  go to state 216


state 154

  195 Parameters: '(' Parameters1 . ')'

    ')'  shift, and go to state 217


state 155

    8 ArrayType: . '[' ArrayLength ']' ElementType
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
  119 FunctionType: . FUNC Signature
  122 IdentifierList: . IDENTIFIER IdentifierList1
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  187 ParameterDecl: . ParameterDecl1 ParameterDecl2 Type
  188 ParameterDecl1: .  [IDENTIFIER, TOK4, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', '(']
  189               | . IdentifierList
  192 ParameterList: . ParameterDecl ParameterList1
  195 Parameters: '(' . Parameters1 ')'
  196 Parameters1: .  [')']
  197            | . ParameterList Parameters11
  200 PointerType: . '*' BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  294     | '(' . Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent

    IDENTIFIER  shift, and go to state 218
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66

    IDENTIFIER  [reduce using rule 188 (ParameterDecl1)]
    TOK5        [reduce using rule 188 (ParameterDecl1)]
    CHAN        [reduce using rule 188 (ParameterDecl1)]
    FUNC        [reduce using rule 188 (ParameterDecl1)]
    INTERFACE   [reduce using rule 188 (ParameterDecl1)]
    MAP         [reduce using rule 188 (ParameterDecl1)]
    STRUCT      [reduce using rule 188 (ParameterDecl1)]
    '*'         [reduce using rule 188 (ParameterDecl1)]
    '['         [reduce using rule 188 (ParameterDecl1)]
    '('         [reduce using rule 188 (ParameterDecl1)]
    ')'         reduce using rule 196 (Parameters1)
    $default    reduce using rule 188 (ParameterDecl1)

    ArrayType       go to state 67
    ChannelType     go to state 68
    ChannelType1    go to state 69
    FunctionType    go to state 72
    IdentifierList  go to state 150
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    ParameterDecl   go to state 151
    ParameterDecl1  go to state 152
    ParameterList   go to state 153
    Parameters1     go to state 154
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 143
    TypeLit         go to state 81
    TypeName        go to state 82


state 156

  228 Result: Parameters .

    $default  reduce using rule 228 (Result)


state 157

  241 Signature1: Result .

    $default  reduce using rule 241 (Signature1)


state 158

  239 Signature: Parameters Signature1 .

    $default  reduce using rule 239 (Signature)


state 159

  229 Result: Type .

    $default  reduce using rule 229 (Result)


state 160

   17 Block: '{' . StatementList '}'
  280 StatementList: . StatementList1
  281 StatementList1: .
  282               | . StatementList1 Statement ';'

    $default  reduce using rule 281 (StatementList1)

    StatementList   go to state 219
    StatementList1  go to state 220


state 161

  113 FunctionBody: Block .

    $default  reduce using rule 113 (FunctionBody)


state 162

  112 Function: Signature FunctionBody .

    $default  reduce using rule 112 (Function)


state 163

  173 MethodDecl1: Function .

    $default  reduce using rule 173 (MethodDecl1)


state 164

  172 MethodDecl: FUNC Receiver MethodName MethodDecl1 .

    $default  reduce using rule 172 (MethodDecl)


state 165

   17 Block: . '{' StatementList '}'
  112 Function: Signature . FunctionBody
  113 FunctionBody: . Block
  174 MethodDecl1: Signature .  [';']

    '{'  shift, and go to state 160

    $default  reduce using rule 174 (MethodDecl1)

    Block         go to state 161
    FunctionBody  go to state 162


state 166

  299 TypeDecl1: '(' TypeDecl11 ')' .

    $default  reduce using rule 299 (TypeDecl1)


state 167

  301 TypeDecl11: TypeDecl11 TypeSpec . ';'

    ';'  shift, and go to state 221


state 168

  332 VarDecl1: '(' VarDecl11 ')' .

    $default  reduce using rule 332 (VarDecl1)


state 169

  334 VarDecl11: VarDecl11 VarSpec . ';'

    ';'  shift, and go to state 222


state 170

   87 Expression: Expression . BINARY_OP UnaryExpr
   88 ExpressionList: Expression . ExpressionList1
   89 ExpressionList1: .  [TOK4, '{', ',', ')', ':', ';']
   90                | . ExpressionList1 ',' Expression

    BINARY_OP  shift, and go to state 191

    $default  reduce using rule 89 (ExpressionList1)

    ExpressionList1  go to state 223


state 171

  337 VarSpec1: '=' ExpressionList .

    $default  reduce using rule 337 (VarSpec1)


state 172

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   88 ExpressionList: . Expression ExpressionList1
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr
  339 VarSpec11: '=' . ExpressionList

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 170
    ExpressionList  go to state 224
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 173

  336 VarSpec1: Type VarSpec11 .

    $default  reduce using rule 336 (VarSpec1)


state 174

  124 IdentifierList1: IdentifierList1 ',' IDENTIFIER .

    $default  reduce using rule 124 (IdentifierList1)


state 175

   51 ConstDecl11: ConstDecl11 ConstSpec ';' .

    $default  reduce using rule 51 (ConstDecl11)


state 176

  148 InterfaceType: INTERFACE '{' InterfaceType1 . '}'
  150 InterfaceType1: InterfaceType1 . MethodSpec ';'
  151 InterfaceTypeName: . TypeName
  176 MethodName: . IDENTIFIER
  177 MethodSpec: . MethodName Signature
  178           | . InterfaceTypeName
  186 PackageName: . IDENTIFIER
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent

    IDENTIFIER  shift, and go to state 225
    '}'         shift, and go to state 226

    InterfaceTypeName  go to state 227
    MethodName         go to state 228
    MethodSpec         go to state 229
    PackageName        go to state 75
    QualifiedIdent     go to state 77
    TypeName           go to state 230


state 177

  171 MapType: MAP '[' KeyType . ']' ElementType

    ']'  shift, and go to state 231


state 178

  154 KeyType: Type .

    $default  reduce using rule 154 (KeyType)


state 179

    1 AnonymousField: . AnonymousField1 TypeName
    2 AnonymousField1: .  [IDENTIFIER]
    3                | . '*'
   93 FieldDecl: . FieldDecl1 FieldDecl2
   94 FieldDecl1: . IdentifierList Type
   95           | . AnonymousField
  122 IdentifierList: . IDENTIFIER IdentifierList1
  283 StructType: STRUCT '{' StructType1 . '}'
  285 StructType1: StructType1 . FieldDecl ';'

    IDENTIFIER  shift, and go to state 35
    '*'         shift, and go to state 232
    '}'         shift, and go to state 233

    IDENTIFIER  [reduce using rule 2 (AnonymousField1)]

    AnonymousField   go to state 234
    AnonymousField1  go to state 235
    FieldDecl        go to state 236
    FieldDecl1       go to state 237
    IdentifierList   go to state 238


state 180

    4 ArgumentList: . ExpressionList ArgumentList1
    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   21 BuiltinArgs: . Type BuiltinArgs1
   22            | . ArgumentList
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   25            | IDENTIFIER '(' . BuiltinCall1 ')'
   26 BuiltinCall1: .  [')']
   27             | . BuiltinArgs BuiltinCall11
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   88 ExpressionList: . Expression ExpressionList1
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    $default  reduce using rule 26 (BuiltinCall1)

    ArgumentList    go to state 239
    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinArgs     go to state 240
    BuiltinCall     go to state 124
    BuiltinCall1    go to state 241
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 170
    ExpressionList  go to state 242
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 243
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 181

  327 UnaryExpr: UNARY_OP UnaryExpr .

    $default  reduce using rule 327 (UnaryExpr)


state 182

  117 FunctionLit: FUNC Function .

    $default  reduce using rule 117 (FunctionLit)


state 183

   17 Block: . '{' StatementList '}'
  112 Function: Signature . FunctionBody
  113 FunctionBody: . Block
  119 FunctionType: FUNC Signature .  [',', '(', ')']

    '{'  shift, and go to state 160

    $default  reduce using rule 119 (FunctionType)

    Block         go to state 161
    FunctionBody  go to state 162


state 184

  162 LiteralType: '[' TOK4 . ']' ElementType

    ']'  shift, and go to state 244


state 185

  258 SliceType: '[' ']' ElementType .

    $default  reduce using rule 258 (SliceType)


state 186

    8 ArrayType: . '[' ArrayLength ']' ElementType
   10 BaseType: . Type
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  200            | '*' . BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  220 ReceiverType: '(' '*' . TypeName ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66

    ArrayType       go to state 67
    BaseType        go to state 108
    ChannelType     go to state 68
    ChannelType1    go to state 69
    FunctionType    go to state 72
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 109
    TypeLit         go to state 81
    TypeName        go to state 245


state 187

   87 Expression: Expression . BINARY_OP UnaryExpr
  182 Operand: '(' Expression . ')'

    BINARY_OP  shift, and go to state 191
    ')'        shift, and go to state 246


state 188

  175 MethodExpr: ReceiverType . '.' MethodName
  221 ReceiverType: '(' ReceiverType . ')'

    ')'  shift, and go to state 247
    '.'  shift, and go to state 205


state 189

   60 Conversion: Type . '(' Expression Conversion1 ')'
  294 Type: '(' Type . ')'

    '('  shift, and go to state 206
    ')'  shift, and go to state 207


state 190

    8 ArrayType: . '[' ArrayLength ']' ElementType
    8          | '[' ArrayLength ']' . ElementType
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   74 ElementType: . Type
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66

    ArrayType       go to state 67
    ChannelType     go to state 68
    ChannelType1    go to state 69
    ElementType     go to state 248
    FunctionType    go to state 72
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 145
    TypeLit         go to state 81
    TypeName        go to state 82


state 191

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   87 Expression: Expression BINARY_OP . UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 249


state 192

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   67 Element: . Element1 Value
   68 Element1: .  [FLOAT_LIT, IDENTIFIER, IMAGINARY_LIT, INT_LIT, RUNE_LIT, STRING_LIT, UNARY_OP, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', '{', '(']
   69         | . Key ':'
   70 ElementIndex: . Expression
   71 ElementList: . Element ElementList1
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   98 FieldName: . IDENTIFIER
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  152 Key: . FieldName
  153    | . ElementIndex
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  166 LiteralValue: '{' . LiteralValue1 '}'
  167 LiteralValue1: .  ['}']
  168              | . ElementList LiteralValue11
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 250
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    FLOAT_LIT      [reduce using rule 68 (Element1)]
    IDENTIFIER     [reduce using rule 68 (Element1)]
    IMAGINARY_LIT  [reduce using rule 68 (Element1)]
    INT_LIT        [reduce using rule 68 (Element1)]
    RUNE_LIT       [reduce using rule 68 (Element1)]
    STRING_LIT     [reduce using rule 68 (Element1)]
    UNARY_OP       [reduce using rule 68 (Element1)]
    TOK5           [reduce using rule 68 (Element1)]
    CHAN           [reduce using rule 68 (Element1)]
    FUNC           [reduce using rule 68 (Element1)]
    INTERFACE      [reduce using rule 68 (Element1)]
    MAP            [reduce using rule 68 (Element1)]
    STRUCT         [reduce using rule 68 (Element1)]
    '*'            [reduce using rule 68 (Element1)]
    '['            [reduce using rule 68 (Element1)]
    '}'            reduce using rule 167 (LiteralValue1)
    '('            [reduce using rule 68 (Element1)]
    $default       reduce using rule 68 (Element1)

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Element         go to state 251
    Element1        go to state 252
    ElementIndex    go to state 253
    ElementList     go to state 254
    Expression      go to state 255
    FieldName       go to state 256
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Key             go to state 257
    Literal         go to state 129
    LiteralType     go to state 130
    LiteralValue1   go to state 258
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 193

   45 CompositeLit: LiteralType LiteralValue .

    $default  reduce using rule 45 (CompositeLit)


state 194

    7 ArrayLength: . Expression
    8 ArrayType: . '[' ArrayLength ']' ElementType
    8          | '[' . ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  146 Index: '[' . Expression ']'
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  162            | '[' . TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  248 Slice: '[' . Slice1
  250 Slice1: . Slice11 ':' Slice12
  251 Slice11: .  [':']
  252        | . Expression
  258 SliceType: . '[' ']' ElementType
  258          | '[' . ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK4           shift, and go to state 184
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    ']'            shift, and go to state 119
    '('            shift, and go to state 120

    $default  reduce using rule 251 (Slice11)

    ArrayLength     go to state 121
    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 259
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    Slice1          go to state 260
    Slice11         go to state 261
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 195

    4 ArgumentList: . ExpressionList ArgumentList1
    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   30 Call: '(' . Call1 ')'
   31 Call1: .  [')']
   32      | . ArgumentList Call11
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   88 ExpressionList: . Expression ExpressionList1
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  182        | '(' . Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  220             | '(' . '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  221             | '(' . ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  294     | '(' . Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 186
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    $default  reduce using rule 31 (Call1)

    ArgumentList    go to state 262
    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    Call1           go to state 263
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 264
    ExpressionList  go to state 242
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 188
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 189
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 196

  236 Selector: '.' . IDENTIFIER
  295 TypeAssertion: '.' . '(' Type ')'

    IDENTIFIER  shift, and go to state 265
    '('         shift, and go to state 266


state 197

  209 PrimaryExpr: PrimaryExpr Call .

    $default  reduce using rule 209 (PrimaryExpr)


state 198

   87 Expression: Expression . BINARY_OP UnaryExpr
  257 Slice21: Expression .  [':']

    BINARY_OP  shift, and go to state 191

    $default  reduce using rule 257 (Slice21)


state 199

  206 PrimaryExpr: PrimaryExpr Index .

    $default  reduce using rule 206 (PrimaryExpr)


state 200

  205 PrimaryExpr: PrimaryExpr Selector .

    $default  reduce using rule 205 (PrimaryExpr)


state 201

  207 PrimaryExpr: PrimaryExpr Slice .

    $default  reduce using rule 207 (PrimaryExpr)


state 202

  249 Slice: Slice2 . ']'

    ']'  shift, and go to state 267


state 203

  255 Slice2: Slice21 . ':' Expression ':' Expression

    ':'  shift, and go to state 268


state 204

  208 PrimaryExpr: PrimaryExpr TypeAssertion .

    $default  reduce using rule 208 (PrimaryExpr)


state 205

  175 MethodExpr: ReceiverType '.' . MethodName
  176 MethodName: . IDENTIFIER

    IDENTIFIER  shift, and go to state 90

    MethodName  go to state 269


state 206

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   60           | Type '(' . Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 270
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 207

  294 Type: '(' Type ')' .

    $default  reduce using rule 294 (Type)


state 208

   54 ConstSpec1: ConstSpec11 '=' ExpressionList .

    $default  reduce using rule 54 (ConstSpec1)


state 209

  210 QualifiedIdent: PackageName '.' IDENTIFIER .

    $default  reduce using rule 210 (QualifiedIdent)


state 210

   11 BaseTypeName: IDENTIFIER .

    $default  reduce using rule 11 (BaseTypeName)


state 211

  214 Receiver: '(' Receiver1 Receiver2 BaseTypeName . ')'

    ')'  shift, and go to state 271


state 212

  192 ParameterList: ParameterDecl ParameterList1 .  [',', ')']
  194 ParameterList1: ParameterList1 . ',' ParameterDecl

    ','  shift, and go to state 272

    ','       [reduce using rule 192 (ParameterList)]
    $default  reduce using rule 192 (ParameterList)


state 213

  191 ParameterDecl2: TOK4 .

    $default  reduce using rule 191 (ParameterDecl2)


state 214

    8 ArrayType: . '[' ArrayLength ']' ElementType
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  187 ParameterDecl: ParameterDecl1 ParameterDecl2 . Type
  200 PointerType: . '*' BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66

    ArrayType       go to state 67
    ChannelType     go to state 68
    ChannelType1    go to state 69
    FunctionType    go to state 72
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 273
    TypeLit         go to state 81
    TypeName        go to state 82


state 215

  199 Parameters11: ',' .

    $default  reduce using rule 199 (Parameters11)


state 216

  197 Parameters1: ParameterList Parameters11 .

    $default  reduce using rule 197 (Parameters1)


state 217

  195 Parameters: '(' Parameters1 ')' .

    $default  reduce using rule 195 (Parameters)


state 218

  122 IdentifierList: IDENTIFIER . IdentifierList1
  123 IdentifierList1: .  [IDENTIFIER, TOK4, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', ',', '(']
  124                | . IdentifierList1 ',' IDENTIFIER
  186 PackageName: IDENTIFIER .  ['.']
  313 TypeName: IDENTIFIER .  [')']

    ')'       reduce using rule 313 (TypeName)
    '.'       reduce using rule 186 (PackageName)
    $default  reduce using rule 123 (IdentifierList1)

    IdentifierList1  go to state 55


state 219

   17 Block: '{' StatementList . '}'

    '}'  shift, and go to state 274


state 220

    8 ArrayType: . '[' ArrayLength ']' ElementType
    9 Assignment: . ExpressionList ASSIGN_OP ExpressionList
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   17 Block: . '{' StatementList '}'
   18 BreakStmt: . BREAK BreakStmt1
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   35 Channel: . Expression
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   47 ConstDecl: . CONST ConstDecl1
   57 ContinueStmt: . CONTINUE ContinueStmt1
   60 Conversion: . Type '(' Expression Conversion1 ')'
   63 Declaration: . ConstDecl
   64            | . TypeDecl
   65            | . VarDecl
   66 DeferStmt: . DEFER Expression
   75 EmptyStmt: .  [';']
   79 ExprSwitchStmt: . SWITCH ExprSwitchStmt1 ExprSwitchStmt2 '{' ExprSwitchStmt3 '}'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   88 ExpressionList: . Expression ExpressionList1
   91 ExpressionStmt: . Expression
   92 FallthroughStmt: . FALLTHROUGH
  106 ForStmt: . FOR ForStmt1 Block
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  120 GoStmt: . GO Expression
  121 GotoStmt: . GOTO Label
  122 IdentifierList: . IDENTIFIER IdentifierList1
  125 IfStmt: . IF IfStmt1 Expression Block IfStmt2
  143 IncDecStmt: . Expression IncDecStmt1
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  155 Label: . IDENTIFIER
  156 LabeledStmt: . Label ':' Statement
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  230 ReturnStmt: . RETURN ReturnStmt1
  233 SelectStmt: . SELECT '{' SelectStmt1 '}'
  237 SendStmt: . Channel TOK5 Expression
  238 ShortVarDecl: . IdentifierList TOK3 ExpressionList
  242 SimpleStmt: . EmptyStmt
  243           | . ExpressionStmt
  244           | . SendStmt
  245           | . IncDecStmt
  246           | . Assignment
  247           | . ShortVarDecl
  258 SliceType: . '[' ']' ElementType
  265 Statement: . Declaration
  266          | . LabeledStmt
  267          | . SimpleStmt
  268          | . GoStmt
  269          | . ReturnStmt
  270          | . BreakStmt
  271          | . ContinueStmt
  272          | . GotoStmt
  273          | . FallthroughStmt
  274          | . Block
  275          | . IfStmt
  276          | . SwitchStmt
  277          | . SelectStmt
  278          | . ForStmt
  279          | . DeferStmt
  280 StatementList: StatementList1 .  [CASE, DEFAULT, '}']
  282 StatementList1: StatementList1 . Statement ';'
  283 StructType: . STRUCT '{' StructType1 '}'
  286 SwitchStmt: . ExprSwitchStmt
  287           | . TypeSwitchStmt
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  297 TypeDecl: . TYPE TypeDecl1
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  321 TypeSwitchStmt: . SWITCH TypeSwitchStmt1 TypeSwitchGuard '{' TypeSwitchStmt2 '}'
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr
  330 VarDecl: . VAR VarDecl1

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 275
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    BREAK          shift, and go to state 276
    CHAN           shift, and go to state 59
    CONST          shift, and go to state 21
    CONTINUE       shift, and go to state 277
    DEFER          shift, and go to state 278
    FALLTHROUGH    shift, and go to state 279
    FOR            shift, and go to state 280
    FUNC           shift, and go to state 117
    GO             shift, and go to state 281
    GOTO           shift, and go to state 282
    IF             shift, and go to state 283
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    RETURN         shift, and go to state 284
    SELECT         shift, and go to state 285
    STRUCT         shift, and go to state 63
    SWITCH         shift, and go to state 286
    TYPE           shift, and go to state 23
    VAR            shift, and go to state 24
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '{'            shift, and go to state 160
    '('            shift, and go to state 120

    ';'       reduce using rule 75 (EmptyStmt)
    $default  reduce using rule 280 (StatementList)

    ArrayType        go to state 122
    Assignment       go to state 287
    BasicLit         go to state 123
    Block            go to state 288
    BreakStmt        go to state 289
    BuiltinCall      go to state 124
    Channel          go to state 290
    ChannelType      go to state 68
    ChannelType1     go to state 69
    CompositeLit     go to state 125
    ConstDecl        go to state 25
    ContinueStmt     go to state 291
    Conversion       go to state 126
    Declaration      go to state 292
    DeferStmt        go to state 293
    EmptyStmt        go to state 294
    ExprSwitchStmt   go to state 295
    Expression       go to state 296
    ExpressionList   go to state 297
    ExpressionStmt   go to state 298
    FallthroughStmt  go to state 299
    ForStmt          go to state 300
    FunctionLit      go to state 128
    FunctionType     go to state 72
    GoStmt           go to state 301
    GotoStmt         go to state 302
    IdentifierList   go to state 303
    IfStmt           go to state 304
    IncDecStmt       go to state 305
    InterfaceType    go to state 73
    Label            go to state 306
    LabeledStmt      go to state 307
    Literal          go to state 129
    LiteralType      go to state 130
    MapType          go to state 131
    MethodExpr       go to state 132
    Operand          go to state 133
    OperandName      go to state 134
    PackageName      go to state 75
    PointerType      go to state 76
    PrimaryExpr      go to state 135
    QualifiedIdent   go to state 136
    ReceiverType     go to state 137
    ReturnStmt       go to state 308
    SelectStmt       go to state 309
    SendStmt         go to state 310
    ShortVarDecl     go to state 311
    SimpleStmt       go to state 312
    SliceType        go to state 138
    Statement        go to state 313
    StructType       go to state 139
    SwitchStmt       go to state 314
    Type             go to state 140
    TypeDecl         go to state 30
    TypeLit          go to state 81
    TypeName         go to state 141
    TypeSwitchStmt   go to state 315
    UnaryExpr        go to state 142
    VarDecl          go to state 31


state 221

  301 TypeDecl11: TypeDecl11 TypeSpec ';' .

    $default  reduce using rule 301 (TypeDecl11)


state 222

  334 VarDecl11: VarDecl11 VarSpec ';' .

    $default  reduce using rule 334 (VarDecl11)


state 223

   88 ExpressionList: Expression ExpressionList1 .  [ASSIGN_OP, TOK4, '{', ',', ')', ':', ';', '=']
   90 ExpressionList1: ExpressionList1 . ',' Expression

    ','  shift, and go to state 316

    ','       [reduce using rule 88 (ExpressionList)]
    $default  reduce using rule 88 (ExpressionList)


state 224

  339 VarSpec11: '=' ExpressionList .

    $default  reduce using rule 339 (VarSpec11)


state 225

  176 MethodName: IDENTIFIER .  ['(']
  186 PackageName: IDENTIFIER .  ['.']
  313 TypeName: IDENTIFIER .  [';']

    ';'       reduce using rule 313 (TypeName)
    '.'       reduce using rule 186 (PackageName)
    $default  reduce using rule 176 (MethodName)


state 226

  148 InterfaceType: INTERFACE '{' InterfaceType1 '}' .

    $default  reduce using rule 148 (InterfaceType)


state 227

  178 MethodSpec: InterfaceTypeName .

    $default  reduce using rule 178 (MethodSpec)


state 228

  177 MethodSpec: MethodName . Signature
  195 Parameters: . '(' Parameters1 ')'
  239 Signature: . Parameters Signature1

    '('  shift, and go to state 85

    Parameters  go to state 88
    Signature   go to state 317


state 229

  150 InterfaceType1: InterfaceType1 MethodSpec . ';'

    ';'  shift, and go to state 318


state 230

  151 InterfaceTypeName: TypeName .

    $default  reduce using rule 151 (InterfaceTypeName)


state 231

    8 ArrayType: . '[' ArrayLength ']' ElementType
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   74 ElementType: . Type
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  171        | MAP '[' KeyType ']' . ElementType
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66

    ArrayType       go to state 67
    ChannelType     go to state 68
    ChannelType1    go to state 69
    ElementType     go to state 319
    FunctionType    go to state 72
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 145
    TypeLit         go to state 81
    TypeName        go to state 82


state 232

    3 AnonymousField1: '*' .

    $default  reduce using rule 3 (AnonymousField1)


state 233

  283 StructType: STRUCT '{' StructType1 '}' .

    $default  reduce using rule 283 (StructType)


state 234

   95 FieldDecl1: AnonymousField .

    $default  reduce using rule 95 (FieldDecl1)


state 235

    1 AnonymousField: AnonymousField1 . TypeName
  186 PackageName: . IDENTIFIER
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent

    IDENTIFIER  shift, and go to state 57

    PackageName     go to state 75
    QualifiedIdent  go to state 77
    TypeName        go to state 320


state 236

  285 StructType1: StructType1 FieldDecl . ';'

    ';'  shift, and go to state 321


state 237

   93 FieldDecl: FieldDecl1 . FieldDecl2
   96 FieldDecl2: .  [';']
   97           | . Tag
  288 Tag: . STRING_LIT

    STRING_LIT  shift, and go to state 322

    $default  reduce using rule 96 (FieldDecl2)

    FieldDecl2  go to state 323
    Tag         go to state 324


state 238

    8 ArrayType: . '[' ArrayLength ']' ElementType
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   94 FieldDecl1: IdentifierList . Type
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66

    ArrayType       go to state 67
    ChannelType     go to state 68
    ChannelType1    go to state 69
    FunctionType    go to state 72
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 325
    TypeLit         go to state 81
    TypeName        go to state 82


state 239

   22 BuiltinArgs: ArgumentList .

    $default  reduce using rule 22 (BuiltinArgs)


state 240

   27 BuiltinCall1: BuiltinArgs . BuiltinCall11
   28 BuiltinCall11: .  [')']
   29              | . ','

    ','  shift, and go to state 326

    $default  reduce using rule 28 (BuiltinCall11)

    BuiltinCall11  go to state 327


state 241

   25 BuiltinCall: IDENTIFIER '(' BuiltinCall1 . ')'

    ')'  shift, and go to state 328


state 242

    4 ArgumentList: ExpressionList . ArgumentList1
    5 ArgumentList1: .  [',', ')']
    6              | . TOK4

    TOK4  shift, and go to state 329

    $default  reduce using rule 5 (ArgumentList1)

    ArgumentList1  go to state 330


state 243

   21 BuiltinArgs: Type . BuiltinArgs1
   23 BuiltinArgs1: .  [',', ')']
   24             | . ',' ArgumentList
   60 Conversion: Type . '(' Expression Conversion1 ')'

    ','  shift, and go to state 331
    '('  shift, and go to state 206

    ','       [reduce using rule 23 (BuiltinArgs1)]
    $default  reduce using rule 23 (BuiltinArgs1)

    BuiltinArgs1  go to state 332


state 244

    8 ArrayType: . '[' ArrayLength ']' ElementType
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   74 ElementType: . Type
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  162 LiteralType: '[' TOK4 ']' . ElementType
  171 MapType: . MAP '[' KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66

    ArrayType       go to state 67
    ChannelType     go to state 68
    ChannelType1    go to state 69
    ElementType     go to state 333
    FunctionType    go to state 72
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 145
    TypeLit         go to state 81
    TypeName        go to state 82


state 245

  220 ReceiverType: '(' '*' TypeName . ')'
  292 Type: TypeName .  ['(', ')']

    ')'  shift, and go to state 334

    ')'       [reduce using rule 292 (Type)]
    $default  reduce using rule 292 (Type)


state 246

  182 Operand: '(' Expression ')' .

    $default  reduce using rule 182 (Operand)


state 247

  221 ReceiverType: '(' ReceiverType ')' .

    $default  reduce using rule 221 (ReceiverType)


state 248

    8 ArrayType: '[' ArrayLength ']' ElementType .

    $default  reduce using rule 8 (ArrayType)


state 249

   87 Expression: Expression BINARY_OP UnaryExpr .

    $default  reduce using rule 87 (Expression)


state 250

   25 BuiltinCall: IDENTIFIER . '(' BuiltinCall1 ')'
   98 FieldName: IDENTIFIER .  [':']
  183 OperandName: IDENTIFIER .  [BINARY_OP, FLOAT_LIT, IDENTIFIER, IMAGINARY_LIT, INT_LIT, RUNE_LIT, STRING_LIT, UNARY_OP, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', '(', ':', '.']
  186 PackageName: IDENTIFIER .  ['.']
  313 TypeName: IDENTIFIER .  ['{', '(', '.']

    '('  shift, and go to state 180

    '{'       reduce using rule 313 (TypeName)
    '('       [reduce using rule 183 (OperandName)]
    '('       [reduce using rule 313 (TypeName)]
    ':'       reduce using rule 98 (FieldName)
    ':'       [reduce using rule 183 (OperandName)]
    '.'       reduce using rule 183 (OperandName)
    '.'       [reduce using rule 186 (PackageName)]
    '.'       [reduce using rule 313 (TypeName)]
    $default  reduce using rule 183 (OperandName)


state 251

   71 ElementList: Element . ElementList1
   72 ElementList1: .
   73             | . ElementList1 ',' Element

    $default  reduce using rule 72 (ElementList1)

    ElementList1  go to state 335


state 252

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   67 Element: Element1 . Value
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  166 LiteralValue: . '{' LiteralValue1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr
  328 Value: . Expression
  329      | . LiteralValue

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '{'            shift, and go to state 192
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 336
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    LiteralValue    go to state 337
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142
    Value           go to state 338


state 253

  153 Key: ElementIndex .

    $default  reduce using rule 153 (Key)


state 254

  168 LiteralValue1: ElementList . LiteralValue11
  169 LiteralValue11: .  ['}']
  170               | . ','

    ','  shift, and go to state 339

    $default  reduce using rule 169 (LiteralValue11)

    LiteralValue11  go to state 340


state 255

   70 ElementIndex: Expression .  [':']
   87 Expression: Expression . BINARY_OP UnaryExpr

    BINARY_OP  shift, and go to state 191

    $default  reduce using rule 70 (ElementIndex)


state 256

  152 Key: FieldName .

    $default  reduce using rule 152 (Key)


state 257

   69 Element1: Key . ':'

    ':'  shift, and go to state 341


state 258

  166 LiteralValue: '{' LiteralValue1 . '}'

    '}'  shift, and go to state 342


state 259

    7 ArrayLength: Expression .  [']']
   87 Expression: Expression . BINARY_OP UnaryExpr
  146 Index: '[' Expression . ']'
  252 Slice11: Expression .  [':']

    BINARY_OP  shift, and go to state 191
    ']'        shift, and go to state 343

    ']'       [reduce using rule 7 (ArrayLength)]
    $default  reduce using rule 252 (Slice11)


state 260

  248 Slice: '[' Slice1 .

    $default  reduce using rule 248 (Slice)


state 261

  250 Slice1: Slice11 . ':' Slice12

    ':'  shift, and go to state 344


state 262

   32 Call1: ArgumentList . Call11
   33 Call11: .  [')']
   34       | . ','

    ','  shift, and go to state 345

    $default  reduce using rule 33 (Call11)

    Call11  go to state 346


state 263

   30 Call: '(' Call1 . ')'

    ')'  shift, and go to state 347


state 264

   87 Expression: Expression . BINARY_OP UnaryExpr
   88 ExpressionList: Expression . ExpressionList1
   89 ExpressionList1: .  [TOK4, ',', ')']
   90                | . ExpressionList1 ',' Expression
  182 Operand: '(' Expression . ')'

    BINARY_OP  shift, and go to state 191
    ')'        shift, and go to state 246

    ')'       [reduce using rule 89 (ExpressionList1)]
    $default  reduce using rule 89 (ExpressionList1)

    ExpressionList1  go to state 223


state 265

  236 Selector: '.' IDENTIFIER .

    $default  reduce using rule 236 (Selector)


state 266

    8 ArrayType: . '[' ArrayLength ']' ElementType
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  295 TypeAssertion: '.' '(' . Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66

    ArrayType       go to state 67
    ChannelType     go to state 68
    ChannelType1    go to state 69
    FunctionType    go to state 72
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 348
    TypeLit         go to state 81
    TypeName        go to state 82


state 267

  249 Slice: Slice2 ']' .

    $default  reduce using rule 249 (Slice)


state 268

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  255 Slice2: Slice21 ':' . Expression ':' Expression
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 349
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 269

  175 MethodExpr: ReceiverType '.' MethodName .

    $default  reduce using rule 175 (MethodExpr)


state 270

   60 Conversion: Type '(' Expression . Conversion1 ')'
   61 Conversion1: .  [')']
   62            | . ','
   87 Expression: Expression . BINARY_OP UnaryExpr

    BINARY_OP  shift, and go to state 191
    ','        shift, and go to state 350

    $default  reduce using rule 61 (Conversion1)

    Conversion1  go to state 351


state 271

  214 Receiver: '(' Receiver1 Receiver2 BaseTypeName ')' .

    $default  reduce using rule 214 (Receiver)


state 272

  122 IdentifierList: . IDENTIFIER IdentifierList1
  187 ParameterDecl: . ParameterDecl1 ParameterDecl2 Type
  188 ParameterDecl1: .  [IDENTIFIER, TOK4, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', '(']
  189               | . IdentifierList
  194 ParameterList1: ParameterList1 ',' . ParameterDecl

    IDENTIFIER  shift, and go to state 35

    IDENTIFIER  [reduce using rule 188 (ParameterDecl1)]
    $default    reduce using rule 188 (ParameterDecl1)

    IdentifierList  go to state 150
    ParameterDecl   go to state 352
    ParameterDecl1  go to state 152


state 273

  187 ParameterDecl: ParameterDecl1 ParameterDecl2 Type .

    $default  reduce using rule 187 (ParameterDecl)


state 274

   17 Block: '{' StatementList '}' .

    $default  reduce using rule 17 (Block)


state 275

   25 BuiltinCall: IDENTIFIER . '(' BuiltinCall1 ')'
  122 IdentifierList: IDENTIFIER . IdentifierList1
  123 IdentifierList1: .  [TOK3, ',']
  124                | . IdentifierList1 ',' IDENTIFIER
  155 Label: IDENTIFIER .  [':']
  183 OperandName: IDENTIFIER .  [ASSIGN_OP, BINARY_OP, FLOAT_LIT, IDENTIFIER, IMAGINARY_LIT, INT_LIT, RUNE_LIT, STRING_LIT, UNARY_OP, TOK1, TOK2, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', ',', '(', ':', ';', '.']
  186 PackageName: IDENTIFIER .  ['.']
  313 TypeName: IDENTIFIER .  ['{', '(', '.']

    '('  shift, and go to state 180

    TOK3      reduce using rule 123 (IdentifierList1)
    '{'       reduce using rule 313 (TypeName)
    ','       reduce using rule 123 (IdentifierList1)
    ','       [reduce using rule 183 (OperandName)]
    '('       [reduce using rule 183 (OperandName)]
    '('       [reduce using rule 313 (TypeName)]
    ':'       reduce using rule 155 (Label)
    ':'       [reduce using rule 183 (OperandName)]
    '.'       reduce using rule 183 (OperandName)
    '.'       [reduce using rule 186 (PackageName)]
    '.'       [reduce using rule 313 (TypeName)]
    $default  reduce using rule 183 (OperandName)

    IdentifierList1  go to state 55


state 276

   18 BreakStmt: BREAK . BreakStmt1
   19 BreakStmt1: .  [';']
   20           | . Label
  155 Label: . IDENTIFIER

    IDENTIFIER  shift, and go to state 353

    $default  reduce using rule 19 (BreakStmt1)

    BreakStmt1  go to state 354
    Label       go to state 355


state 277

   57 ContinueStmt: CONTINUE . ContinueStmt1
   58 ContinueStmt1: .  [';']
   59              | . Label
  155 Label: . IDENTIFIER

    IDENTIFIER  shift, and go to state 353

    $default  reduce using rule 58 (ContinueStmt1)

    ContinueStmt1  go to state 356
    Label          go to state 357


state 278

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   66 DeferStmt: DEFER . Expression
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 358
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 279

   92 FallthroughStmt: FALLTHROUGH .

    $default  reduce using rule 92 (FallthroughStmt)


state 280

    8 ArrayType: . '[' ArrayLength ']' ElementType
    9 Assignment: . ExpressionList ASSIGN_OP ExpressionList
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   35 Channel: . Expression
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   46 Condition: . Expression
   60 Conversion: . Type '(' Expression Conversion1 ')'
   75 EmptyStmt: .  [';']
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   88 ExpressionList: . Expression ExpressionList1
   91 ExpressionStmt: . Expression
   99 ForClause: . ForClause1 ';' ForClause2 ';' ForClause3
  100 ForClause1: .  [';']
  101           | . InitStmt
  106 ForStmt: FOR . ForStmt1 Block
  107 ForStmt1: .  ['{']
  108         | . ForStmt11
  109 ForStmt11: . Condition
  110          | . ForClause
  111          | . RangeClause
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  122 IdentifierList: . IDENTIFIER IdentifierList1
  143 IncDecStmt: . Expression IncDecStmt1
  147 InitStmt: . SimpleStmt
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  211 RangeClause: . RangeClause1 RANGE Expression
  212 RangeClause1: . ExpressionList '='
  213             | . IdentifierList TOK3
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  237 SendStmt: . Channel TOK5 Expression
  238 ShortVarDecl: . IdentifierList TOK3 ExpressionList
  242 SimpleStmt: . EmptyStmt
  243           | . ExpressionStmt
  244           | . SendStmt
  245           | . IncDecStmt
  246           | . Assignment
  247           | . ShortVarDecl
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 359
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    '{'       reduce using rule 107 (ForStmt1)
    ';'       reduce using rule 75 (EmptyStmt)
    ';'       [reduce using rule 100 (ForClause1)]
    $default  reduce using rule 75 (EmptyStmt)

    ArrayType       go to state 122
    Assignment      go to state 287
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    Channel         go to state 290
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Condition       go to state 360
    Conversion      go to state 126
    EmptyStmt       go to state 294
    Expression      go to state 361
    ExpressionList  go to state 362
    ExpressionStmt  go to state 298
    ForClause       go to state 363
    ForClause1      go to state 364
    ForStmt1        go to state 365
    ForStmt11       go to state 366
    FunctionLit     go to state 128
    FunctionType    go to state 72
    IdentifierList  go to state 367
    IncDecStmt      go to state 305
    InitStmt        go to state 368
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    RangeClause     go to state 369
    RangeClause1    go to state 370
    ReceiverType    go to state 137
    SendStmt        go to state 310
    ShortVarDecl    go to state 311
    SimpleStmt      go to state 371
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 281

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  120 GoStmt: GO . Expression
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 372
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 282

  121 GotoStmt: GOTO . Label
  155 Label: . IDENTIFIER

    IDENTIFIER  shift, and go to state 353

    Label  go to state 373


state 283

    8 ArrayType: . '[' ArrayLength ']' ElementType
    9 Assignment: . ExpressionList ASSIGN_OP ExpressionList
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   35 Channel: . Expression
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   75 EmptyStmt: .  [';']
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   88 ExpressionList: . Expression ExpressionList1
   91 ExpressionStmt: . Expression
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  122 IdentifierList: . IDENTIFIER IdentifierList1
  125 IfStmt: IF . IfStmt1 Expression Block IfStmt2
  126 IfStmt1: .  [FLOAT_LIT, IDENTIFIER, IMAGINARY_LIT, INT_LIT, RUNE_LIT, STRING_LIT, UNARY_OP, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', '(']
  127        | . SimpleStmt ';'
  143 IncDecStmt: . Expression IncDecStmt1
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  237 SendStmt: . Channel TOK5 Expression
  238 ShortVarDecl: . IdentifierList TOK3 ExpressionList
  242 SimpleStmt: . EmptyStmt
  243           | . ExpressionStmt
  244           | . SendStmt
  245           | . IncDecStmt
  246           | . Assignment
  247           | . ShortVarDecl
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 359
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    FLOAT_LIT      [reduce using rule 126 (IfStmt1)]
    IDENTIFIER     [reduce using rule 126 (IfStmt1)]
    IMAGINARY_LIT  [reduce using rule 126 (IfStmt1)]
    INT_LIT        [reduce using rule 126 (IfStmt1)]
    RUNE_LIT       [reduce using rule 126 (IfStmt1)]
    STRING_LIT     [reduce using rule 126 (IfStmt1)]
    UNARY_OP       [reduce using rule 126 (IfStmt1)]
    TOK5           [reduce using rule 126 (IfStmt1)]
    CHAN           [reduce using rule 126 (IfStmt1)]
    FUNC           [reduce using rule 126 (IfStmt1)]
    INTERFACE      [reduce using rule 126 (IfStmt1)]
    MAP            [reduce using rule 126 (IfStmt1)]
    STRUCT         [reduce using rule 126 (IfStmt1)]
    '*'            [reduce using rule 126 (IfStmt1)]
    '['            [reduce using rule 126 (IfStmt1)]
    '('            [reduce using rule 126 (IfStmt1)]
    $default       reduce using rule 75 (EmptyStmt)

    ArrayType       go to state 122
    Assignment      go to state 287
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    Channel         go to state 290
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    EmptyStmt       go to state 294
    Expression      go to state 296
    ExpressionList  go to state 297
    ExpressionStmt  go to state 298
    FunctionLit     go to state 128
    FunctionType    go to state 72
    IdentifierList  go to state 303
    IfStmt1         go to state 374
    IncDecStmt      go to state 305
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SendStmt        go to state 310
    ShortVarDecl    go to state 311
    SimpleStmt      go to state 375
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 284

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   88 ExpressionList: . Expression ExpressionList1
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  230 ReturnStmt: RETURN . ReturnStmt1
  231 ReturnStmt1: .  [';']
  232            | . ExpressionList
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    $default  reduce using rule 231 (ReturnStmt1)

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 170
    ExpressionList  go to state 376
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    ReturnStmt1     go to state 377
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 285

  233 SelectStmt: SELECT . '{' SelectStmt1 '}'

    '{'  shift, and go to state 378


state 286

    8 ArrayType: . '[' ArrayLength ']' ElementType
    9 Assignment: . ExpressionList ASSIGN_OP ExpressionList
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   35 Channel: . Expression
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   75 EmptyStmt: .  [';']
   79 ExprSwitchStmt: SWITCH . ExprSwitchStmt1 ExprSwitchStmt2 '{' ExprSwitchStmt3 '}'
   80 ExprSwitchStmt1: .  [FLOAT_LIT, IDENTIFIER, IMAGINARY_LIT, INT_LIT, RUNE_LIT, STRING_LIT, UNARY_OP, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', '{', '(']
   81                | . SimpleStmt ';'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   88 ExpressionList: . Expression ExpressionList1
   91 ExpressionStmt: . Expression
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  122 IdentifierList: . IDENTIFIER IdentifierList1
  143 IncDecStmt: . Expression IncDecStmt1
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  237 SendStmt: . Channel TOK5 Expression
  238 ShortVarDecl: . IdentifierList TOK3 ExpressionList
  242 SimpleStmt: . EmptyStmt
  243           | . ExpressionStmt
  244           | . SendStmt
  245           | . IncDecStmt
  246           | . Assignment
  247           | . ShortVarDecl
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  321 TypeSwitchStmt: SWITCH . TypeSwitchStmt1 TypeSwitchGuard '{' TypeSwitchStmt2 '}'
  322 TypeSwitchStmt1: .  [FLOAT_LIT, IDENTIFIER, IMAGINARY_LIT, INT_LIT, RUNE_LIT, STRING_LIT, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', '(']
  323                | . SimpleStmt ';'
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 359
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    FLOAT_LIT      [reduce using rule 80 (ExprSwitchStmt1)]
    FLOAT_LIT      [reduce using rule 322 (TypeSwitchStmt1)]
    IDENTIFIER     [reduce using rule 80 (ExprSwitchStmt1)]
    IDENTIFIER     [reduce using rule 322 (TypeSwitchStmt1)]
    IMAGINARY_LIT  [reduce using rule 80 (ExprSwitchStmt1)]
    IMAGINARY_LIT  [reduce using rule 322 (TypeSwitchStmt1)]
    INT_LIT        [reduce using rule 80 (ExprSwitchStmt1)]
    INT_LIT        [reduce using rule 322 (TypeSwitchStmt1)]
    RUNE_LIT       [reduce using rule 80 (ExprSwitchStmt1)]
    RUNE_LIT       [reduce using rule 322 (TypeSwitchStmt1)]
    STRING_LIT     [reduce using rule 80 (ExprSwitchStmt1)]
    STRING_LIT     [reduce using rule 322 (TypeSwitchStmt1)]
    UNARY_OP       [reduce using rule 80 (ExprSwitchStmt1)]
    TOK5           [reduce using rule 80 (ExprSwitchStmt1)]
    TOK5           [reduce using rule 322 (TypeSwitchStmt1)]
    CHAN           [reduce using rule 80 (ExprSwitchStmt1)]
    CHAN           [reduce using rule 322 (TypeSwitchStmt1)]
    FUNC           [reduce using rule 80 (ExprSwitchStmt1)]
    FUNC           [reduce using rule 322 (TypeSwitchStmt1)]
    INTERFACE      [reduce using rule 80 (ExprSwitchStmt1)]
    INTERFACE      [reduce using rule 322 (TypeSwitchStmt1)]
    MAP            [reduce using rule 80 (ExprSwitchStmt1)]
    MAP            [reduce using rule 322 (TypeSwitchStmt1)]
    STRUCT         [reduce using rule 80 (ExprSwitchStmt1)]
    STRUCT         [reduce using rule 322 (TypeSwitchStmt1)]
    '*'            [reduce using rule 80 (ExprSwitchStmt1)]
    '*'            [reduce using rule 322 (TypeSwitchStmt1)]
    '['            [reduce using rule 80 (ExprSwitchStmt1)]
    '['            [reduce using rule 322 (TypeSwitchStmt1)]
    '{'            reduce using rule 80 (ExprSwitchStmt1)
    '('            [reduce using rule 80 (ExprSwitchStmt1)]
    '('            [reduce using rule 322 (TypeSwitchStmt1)]
    $default       reduce using rule 75 (EmptyStmt)

    ArrayType        go to state 122
    Assignment       go to state 287
    BasicLit         go to state 123
    BuiltinCall      go to state 124
    Channel          go to state 290
    ChannelType      go to state 68
    ChannelType1     go to state 69
    CompositeLit     go to state 125
    Conversion       go to state 126
    EmptyStmt        go to state 294
    ExprSwitchStmt1  go to state 379
    Expression       go to state 296
    ExpressionList   go to state 297
    ExpressionStmt   go to state 298
    FunctionLit      go to state 128
    FunctionType     go to state 72
    IdentifierList   go to state 303
    IncDecStmt       go to state 305
    InterfaceType    go to state 73
    Literal          go to state 129
    LiteralType      go to state 130
    MapType          go to state 131
    MethodExpr       go to state 132
    Operand          go to state 133
    OperandName      go to state 134
    PackageName      go to state 75
    PointerType      go to state 76
    PrimaryExpr      go to state 135
    QualifiedIdent   go to state 136
    ReceiverType     go to state 137
    SendStmt         go to state 310
    ShortVarDecl     go to state 311
    SimpleStmt       go to state 380
    SliceType        go to state 138
    StructType       go to state 139
    Type             go to state 140
    TypeLit          go to state 81
    TypeName         go to state 141
    TypeSwitchStmt1  go to state 381
    UnaryExpr        go to state 142


state 287

  246 SimpleStmt: Assignment .

    $default  reduce using rule 246 (SimpleStmt)


state 288

  274 Statement: Block .

    $default  reduce using rule 274 (Statement)


state 289

  270 Statement: BreakStmt .

    $default  reduce using rule 270 (Statement)


state 290

  237 SendStmt: Channel . TOK5 Expression

    TOK5  shift, and go to state 382


state 291

  271 Statement: ContinueStmt .

    $default  reduce using rule 271 (Statement)


state 292

  265 Statement: Declaration .

    $default  reduce using rule 265 (Statement)


state 293

  279 Statement: DeferStmt .

    $default  reduce using rule 279 (Statement)


state 294

  242 SimpleStmt: EmptyStmt .

    $default  reduce using rule 242 (SimpleStmt)


state 295

  286 SwitchStmt: ExprSwitchStmt .

    $default  reduce using rule 286 (SwitchStmt)


state 296

   35 Channel: Expression .  [TOK5]
   87 Expression: Expression . BINARY_OP UnaryExpr
   88 ExpressionList: Expression . ExpressionList1
   89 ExpressionList1: .  [ASSIGN_OP, ',']
   90                | . ExpressionList1 ',' Expression
   91 ExpressionStmt: Expression .  ['{', ';']
  143 IncDecStmt: Expression . IncDecStmt1
  144 IncDecStmt1: . TOK2
  145            | . TOK1

    BINARY_OP  shift, and go to state 191
    TOK1       shift, and go to state 383
    TOK2       shift, and go to state 384

    TOK5      reduce using rule 35 (Channel)
    '{'       reduce using rule 91 (ExpressionStmt)
    ';'       reduce using rule 91 (ExpressionStmt)
    $default  reduce using rule 89 (ExpressionList1)

    ExpressionList1  go to state 223
    IncDecStmt1      go to state 385


state 297

    9 Assignment: ExpressionList . ASSIGN_OP ExpressionList

    ASSIGN_OP  shift, and go to state 386


state 298

  243 SimpleStmt: ExpressionStmt .

    $default  reduce using rule 243 (SimpleStmt)


state 299

  273 Statement: FallthroughStmt .

    $default  reduce using rule 273 (Statement)


state 300

  278 Statement: ForStmt .

    $default  reduce using rule 278 (Statement)


state 301

  268 Statement: GoStmt .

    $default  reduce using rule 268 (Statement)


state 302

  272 Statement: GotoStmt .

    $default  reduce using rule 272 (Statement)


state 303

  238 ShortVarDecl: IdentifierList . TOK3 ExpressionList

    TOK3  shift, and go to state 387


state 304

  275 Statement: IfStmt .

    $default  reduce using rule 275 (Statement)


state 305

  245 SimpleStmt: IncDecStmt .

    $default  reduce using rule 245 (SimpleStmt)


state 306

  156 LabeledStmt: Label . ':' Statement

    ':'  shift, and go to state 388


state 307

  266 Statement: LabeledStmt .

    $default  reduce using rule 266 (Statement)


state 308

  269 Statement: ReturnStmt .

    $default  reduce using rule 269 (Statement)


state 309

  277 Statement: SelectStmt .

    $default  reduce using rule 277 (Statement)


state 310

  244 SimpleStmt: SendStmt .

    $default  reduce using rule 244 (SimpleStmt)


state 311

  247 SimpleStmt: ShortVarDecl .

    $default  reduce using rule 247 (SimpleStmt)


state 312

  267 Statement: SimpleStmt .

    $default  reduce using rule 267 (Statement)


state 313

  282 StatementList1: StatementList1 Statement . ';'

    ';'  shift, and go to state 389


state 314

  276 Statement: SwitchStmt .

    $default  reduce using rule 276 (Statement)


state 315

  287 SwitchStmt: TypeSwitchStmt .

    $default  reduce using rule 287 (SwitchStmt)


state 316

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   90 ExpressionList1: ExpressionList1 ',' . Expression
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 390
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 317

  177 MethodSpec: MethodName Signature .

    $default  reduce using rule 177 (MethodSpec)


state 318

  150 InterfaceType1: InterfaceType1 MethodSpec ';' .

    $default  reduce using rule 150 (InterfaceType1)


state 319

  171 MapType: MAP '[' KeyType ']' ElementType .

    $default  reduce using rule 171 (MapType)


state 320

    1 AnonymousField: AnonymousField1 TypeName .

    $default  reduce using rule 1 (AnonymousField)


state 321

  285 StructType1: StructType1 FieldDecl ';' .

    $default  reduce using rule 285 (StructType1)


state 322

  288 Tag: STRING_LIT .

    $default  reduce using rule 288 (Tag)


state 323

   93 FieldDecl: FieldDecl1 FieldDecl2 .

    $default  reduce using rule 93 (FieldDecl)


state 324

   97 FieldDecl2: Tag .

    $default  reduce using rule 97 (FieldDecl2)


state 325

   94 FieldDecl1: IdentifierList Type .

    $default  reduce using rule 94 (FieldDecl1)


state 326

   29 BuiltinCall11: ',' .

    $default  reduce using rule 29 (BuiltinCall11)


state 327

   27 BuiltinCall1: BuiltinArgs BuiltinCall11 .

    $default  reduce using rule 27 (BuiltinCall1)


state 328

   25 BuiltinCall: IDENTIFIER '(' BuiltinCall1 ')' .

    $default  reduce using rule 25 (BuiltinCall)


state 329

    6 ArgumentList1: TOK4 .

    $default  reduce using rule 6 (ArgumentList1)


state 330

    4 ArgumentList: ExpressionList ArgumentList1 .

    $default  reduce using rule 4 (ArgumentList)


state 331

    4 ArgumentList: . ExpressionList ArgumentList1
    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   24 BuiltinArgs1: ',' . ArgumentList
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   88 ExpressionList: . Expression ExpressionList1
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArgumentList    go to state 391
    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 170
    ExpressionList  go to state 242
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 332

   21 BuiltinArgs: Type BuiltinArgs1 .

    $default  reduce using rule 21 (BuiltinArgs)


state 333

  162 LiteralType: '[' TOK4 ']' ElementType .

    $default  reduce using rule 162 (LiteralType)


state 334

  220 ReceiverType: '(' '*' TypeName ')' .

    $default  reduce using rule 220 (ReceiverType)


state 335

   71 ElementList: Element ElementList1 .  ['}', ',']
   73 ElementList1: ElementList1 . ',' Element

    ','  shift, and go to state 392

    ','       [reduce using rule 71 (ElementList)]
    $default  reduce using rule 71 (ElementList)


state 336

   87 Expression: Expression . BINARY_OP UnaryExpr
  328 Value: Expression .  ['}', ',']

    BINARY_OP  shift, and go to state 191

    $default  reduce using rule 328 (Value)


state 337

  329 Value: LiteralValue .

    $default  reduce using rule 329 (Value)


state 338

   67 Element: Element1 Value .

    $default  reduce using rule 67 (Element)


state 339

  170 LiteralValue11: ',' .

    $default  reduce using rule 170 (LiteralValue11)


state 340

  168 LiteralValue1: ElementList LiteralValue11 .

    $default  reduce using rule 168 (LiteralValue1)


state 341

   69 Element1: Key ':' .

    $default  reduce using rule 69 (Element1)


state 342

  166 LiteralValue: '{' LiteralValue1 '}' .

    $default  reduce using rule 166 (LiteralValue)


state 343

  146 Index: '[' Expression ']' .

    $default  reduce using rule 146 (Index)


state 344

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  250 Slice1: Slice11 ':' . Slice12
  253 Slice12: .  [ASSIGN_OP, BINARY_OP, FLOAT_LIT, IDENTIFIER, IMAGINARY_LIT, INT_LIT, RUNE_LIT, STRING_LIT, UNARY_OP, TOK1, TOK2, TOK4, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', ']', '{', '}', ',', '(', ')', ':', ';', '=', '.']
  254        | . Expression
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    FLOAT_LIT      [reduce using rule 253 (Slice12)]
    IDENTIFIER     [reduce using rule 253 (Slice12)]
    IMAGINARY_LIT  [reduce using rule 253 (Slice12)]
    INT_LIT        [reduce using rule 253 (Slice12)]
    RUNE_LIT       [reduce using rule 253 (Slice12)]
    STRING_LIT     [reduce using rule 253 (Slice12)]
    UNARY_OP       [reduce using rule 253 (Slice12)]
    TOK5           [reduce using rule 253 (Slice12)]
    CHAN           [reduce using rule 253 (Slice12)]
    FUNC           [reduce using rule 253 (Slice12)]
    INTERFACE      [reduce using rule 253 (Slice12)]
    MAP            [reduce using rule 253 (Slice12)]
    STRUCT         [reduce using rule 253 (Slice12)]
    '*'            [reduce using rule 253 (Slice12)]
    '['            [reduce using rule 253 (Slice12)]
    '('            [reduce using rule 253 (Slice12)]
    $default       reduce using rule 253 (Slice12)

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 393
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    Slice12         go to state 394
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 345

   34 Call11: ',' .

    $default  reduce using rule 34 (Call11)


state 346

   32 Call1: ArgumentList Call11 .

    $default  reduce using rule 32 (Call1)


state 347

   30 Call: '(' Call1 ')' .

    $default  reduce using rule 30 (Call)


state 348

  295 TypeAssertion: '.' '(' Type . ')'

    ')'  shift, and go to state 395


state 349

   87 Expression: Expression . BINARY_OP UnaryExpr
  255 Slice2: Slice21 ':' Expression . ':' Expression

    BINARY_OP  shift, and go to state 191
    ':'        shift, and go to state 396


state 350

   62 Conversion1: ',' .

    $default  reduce using rule 62 (Conversion1)


state 351

   60 Conversion: Type '(' Expression Conversion1 . ')'

    ')'  shift, and go to state 397


state 352

  194 ParameterList1: ParameterList1 ',' ParameterDecl .

    $default  reduce using rule 194 (ParameterList1)


state 353

  155 Label: IDENTIFIER .

    $default  reduce using rule 155 (Label)


state 354

   18 BreakStmt: BREAK BreakStmt1 .

    $default  reduce using rule 18 (BreakStmt)


state 355

   20 BreakStmt1: Label .

    $default  reduce using rule 20 (BreakStmt1)


state 356

   57 ContinueStmt: CONTINUE ContinueStmt1 .

    $default  reduce using rule 57 (ContinueStmt)


state 357

   59 ContinueStmt1: Label .

    $default  reduce using rule 59 (ContinueStmt1)


state 358

   66 DeferStmt: DEFER Expression .  [';']
   87 Expression: Expression . BINARY_OP UnaryExpr

    BINARY_OP  shift, and go to state 191

    $default  reduce using rule 66 (DeferStmt)


state 359

   25 BuiltinCall: IDENTIFIER . '(' BuiltinCall1 ')'
  122 IdentifierList: IDENTIFIER . IdentifierList1
  123 IdentifierList1: .  [TOK3, ',']
  124                | . IdentifierList1 ',' IDENTIFIER
  183 OperandName: IDENTIFIER .  [ASSIGN_OP, BINARY_OP, FLOAT_LIT, IDENTIFIER, IMAGINARY_LIT, INT_LIT, RUNE_LIT, STRING_LIT, UNARY_OP, TOK1, TOK2, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', '{', ',', '(', ':', ';', '=', '.']
  186 PackageName: IDENTIFIER .  ['.']
  313 TypeName: IDENTIFIER .  ['{', '(', '.']

    '('  shift, and go to state 180

    TOK3      reduce using rule 123 (IdentifierList1)
    '{'       reduce using rule 183 (OperandName)
    '{'       [reduce using rule 313 (TypeName)]
    ','       reduce using rule 123 (IdentifierList1)
    ','       [reduce using rule 183 (OperandName)]
    '('       [reduce using rule 183 (OperandName)]
    '('       [reduce using rule 313 (TypeName)]
    '.'       reduce using rule 183 (OperandName)
    '.'       [reduce using rule 186 (PackageName)]
    '.'       [reduce using rule 313 (TypeName)]
    $default  reduce using rule 183 (OperandName)

    IdentifierList1  go to state 55


state 360

  109 ForStmt11: Condition .

    $default  reduce using rule 109 (ForStmt11)


state 361

   35 Channel: Expression .  [TOK5]
   46 Condition: Expression .  ['{']
   87 Expression: Expression . BINARY_OP UnaryExpr
   88 ExpressionList: Expression . ExpressionList1
   89 ExpressionList1: .  [ASSIGN_OP, ',', '=']
   90                | . ExpressionList1 ',' Expression
   91 ExpressionStmt: Expression .  [';']
  143 IncDecStmt: Expression . IncDecStmt1
  144 IncDecStmt1: . TOK2
  145            | . TOK1

    BINARY_OP  shift, and go to state 191
    TOK1       shift, and go to state 383
    TOK2       shift, and go to state 384

    TOK5      reduce using rule 35 (Channel)
    '{'       reduce using rule 46 (Condition)
    ';'       reduce using rule 91 (ExpressionStmt)
    $default  reduce using rule 89 (ExpressionList1)

    ExpressionList1  go to state 223
    IncDecStmt1      go to state 385


state 362

    9 Assignment: ExpressionList . ASSIGN_OP ExpressionList
  212 RangeClause1: ExpressionList . '='

    ASSIGN_OP  shift, and go to state 386
    '='        shift, and go to state 398


state 363

  110 ForStmt11: ForClause .

    $default  reduce using rule 110 (ForStmt11)


state 364

   99 ForClause: ForClause1 . ';' ForClause2 ';' ForClause3

    ';'  shift, and go to state 399


state 365

   17 Block: . '{' StatementList '}'
  106 ForStmt: FOR ForStmt1 . Block

    '{'  shift, and go to state 160

    Block  go to state 400


state 366

  108 ForStmt1: ForStmt11 .

    $default  reduce using rule 108 (ForStmt1)


state 367

  213 RangeClause1: IdentifierList . TOK3
  238 ShortVarDecl: IdentifierList . TOK3 ExpressionList

    TOK3  shift, and go to state 401


state 368

  101 ForClause1: InitStmt .

    $default  reduce using rule 101 (ForClause1)


state 369

  111 ForStmt11: RangeClause .

    $default  reduce using rule 111 (ForStmt11)


state 370

  211 RangeClause: RangeClause1 . RANGE Expression

    RANGE  shift, and go to state 402


state 371

  147 InitStmt: SimpleStmt .

    $default  reduce using rule 147 (InitStmt)


state 372

   87 Expression: Expression . BINARY_OP UnaryExpr
  120 GoStmt: GO Expression .  [';']

    BINARY_OP  shift, and go to state 191

    $default  reduce using rule 120 (GoStmt)


state 373

  121 GotoStmt: GOTO Label .

    $default  reduce using rule 121 (GotoStmt)


state 374

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  125 IfStmt: IF IfStmt1 . Expression Block IfStmt2
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 403
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 375

  127 IfStmt1: SimpleStmt . ';'

    ';'  shift, and go to state 404


state 376

  232 ReturnStmt1: ExpressionList .

    $default  reduce using rule 232 (ReturnStmt1)


state 377

  230 ReturnStmt: RETURN ReturnStmt1 .

    $default  reduce using rule 230 (ReturnStmt)


state 378

  233 SelectStmt: SELECT '{' . SelectStmt1 '}'
  234 SelectStmt1: .
  235            | . SelectStmt1 CommClause

    $default  reduce using rule 234 (SelectStmt1)

    SelectStmt1  go to state 405


state 379

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   79 ExprSwitchStmt: SWITCH ExprSwitchStmt1 . ExprSwitchStmt2 '{' ExprSwitchStmt3 '}'
   82 ExprSwitchStmt2: .  ['{']
   83                | . Expression
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    $default  reduce using rule 82 (ExprSwitchStmt2)

    ArrayType        go to state 122
    BasicLit         go to state 123
    BuiltinCall      go to state 124
    ChannelType      go to state 68
    ChannelType1     go to state 69
    CompositeLit     go to state 125
    Conversion       go to state 126
    ExprSwitchStmt2  go to state 406
    Expression       go to state 407
    FunctionLit      go to state 128
    FunctionType     go to state 72
    InterfaceType    go to state 73
    Literal          go to state 129
    LiteralType      go to state 130
    MapType          go to state 131
    MethodExpr       go to state 132
    Operand          go to state 133
    OperandName      go to state 134
    PackageName      go to state 75
    PointerType      go to state 76
    PrimaryExpr      go to state 135
    QualifiedIdent   go to state 136
    ReceiverType     go to state 137
    SliceType        go to state 138
    StructType       go to state 139
    Type             go to state 140
    TypeLit          go to state 81
    TypeName         go to state 141
    UnaryExpr        go to state 142


state 380

   81 ExprSwitchStmt1: SimpleStmt . ';'
  323 TypeSwitchStmt1: SimpleStmt . ';'

    ';'  shift, and go to state 408


state 381

  318 TypeSwitchGuard: . TypeSwitchGuard1 PrimaryExpr '.' '(' TYPE ')'
  319 TypeSwitchGuard1: .  [FLOAT_LIT, IDENTIFIER, IMAGINARY_LIT, INT_LIT, RUNE_LIT, STRING_LIT, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', '(']
  320                 | . IDENTIFIER TOK3
  321 TypeSwitchStmt: SWITCH TypeSwitchStmt1 . TypeSwitchGuard '{' TypeSwitchStmt2 '}'

    IDENTIFIER  shift, and go to state 409

    IDENTIFIER  [reduce using rule 319 (TypeSwitchGuard1)]
    $default    reduce using rule 319 (TypeSwitchGuard1)

    TypeSwitchGuard   go to state 410
    TypeSwitchGuard1  go to state 411


state 382

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  237 SendStmt: Channel TOK5 . Expression
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 412
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 383

  145 IncDecStmt1: TOK1 .

    $default  reduce using rule 145 (IncDecStmt1)


state 384

  144 IncDecStmt1: TOK2 .

    $default  reduce using rule 144 (IncDecStmt1)


state 385

  143 IncDecStmt: Expression IncDecStmt1 .

    $default  reduce using rule 143 (IncDecStmt)


state 386

    8 ArrayType: . '[' ArrayLength ']' ElementType
    9 Assignment: ExpressionList ASSIGN_OP . ExpressionList
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   88 ExpressionList: . Expression ExpressionList1
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 170
    ExpressionList  go to state 413
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 387

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   88 ExpressionList: . Expression ExpressionList1
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  238 ShortVarDecl: IdentifierList TOK3 . ExpressionList
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 170
    ExpressionList  go to state 414
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 388

    8 ArrayType: . '[' ArrayLength ']' ElementType
    9 Assignment: . ExpressionList ASSIGN_OP ExpressionList
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   17 Block: . '{' StatementList '}'
   18 BreakStmt: . BREAK BreakStmt1
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   35 Channel: . Expression
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   47 ConstDecl: . CONST ConstDecl1
   57 ContinueStmt: . CONTINUE ContinueStmt1
   60 Conversion: . Type '(' Expression Conversion1 ')'
   63 Declaration: . ConstDecl
   64            | . TypeDecl
   65            | . VarDecl
   66 DeferStmt: . DEFER Expression
   75 EmptyStmt: .  [';']
   79 ExprSwitchStmt: . SWITCH ExprSwitchStmt1 ExprSwitchStmt2 '{' ExprSwitchStmt3 '}'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   88 ExpressionList: . Expression ExpressionList1
   91 ExpressionStmt: . Expression
   92 FallthroughStmt: . FALLTHROUGH
  106 ForStmt: . FOR ForStmt1 Block
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  120 GoStmt: . GO Expression
  121 GotoStmt: . GOTO Label
  122 IdentifierList: . IDENTIFIER IdentifierList1
  125 IfStmt: . IF IfStmt1 Expression Block IfStmt2
  143 IncDecStmt: . Expression IncDecStmt1
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  155 Label: . IDENTIFIER
  156 LabeledStmt: . Label ':' Statement
  156            | Label ':' . Statement
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  230 ReturnStmt: . RETURN ReturnStmt1
  233 SelectStmt: . SELECT '{' SelectStmt1 '}'
  237 SendStmt: . Channel TOK5 Expression
  238 ShortVarDecl: . IdentifierList TOK3 ExpressionList
  242 SimpleStmt: . EmptyStmt
  243           | . ExpressionStmt
  244           | . SendStmt
  245           | . IncDecStmt
  246           | . Assignment
  247           | . ShortVarDecl
  258 SliceType: . '[' ']' ElementType
  265 Statement: . Declaration
  266          | . LabeledStmt
  267          | . SimpleStmt
  268          | . GoStmt
  269          | . ReturnStmt
  270          | . BreakStmt
  271          | . ContinueStmt
  272          | . GotoStmt
  273          | . FallthroughStmt
  274          | . Block
  275          | . IfStmt
  276          | . SwitchStmt
  277          | . SelectStmt
  278          | . ForStmt
  279          | . DeferStmt
  283 StructType: . STRUCT '{' StructType1 '}'
  286 SwitchStmt: . ExprSwitchStmt
  287           | . TypeSwitchStmt
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  297 TypeDecl: . TYPE TypeDecl1
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  321 TypeSwitchStmt: . SWITCH TypeSwitchStmt1 TypeSwitchGuard '{' TypeSwitchStmt2 '}'
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr
  330 VarDecl: . VAR VarDecl1

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 275
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    BREAK          shift, and go to state 276
    CHAN           shift, and go to state 59
    CONST          shift, and go to state 21
    CONTINUE       shift, and go to state 277
    DEFER          shift, and go to state 278
    FALLTHROUGH    shift, and go to state 279
    FOR            shift, and go to state 280
    FUNC           shift, and go to state 117
    GO             shift, and go to state 281
    GOTO           shift, and go to state 282
    IF             shift, and go to state 283
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    RETURN         shift, and go to state 284
    SELECT         shift, and go to state 285
    STRUCT         shift, and go to state 63
    SWITCH         shift, and go to state 286
    TYPE           shift, and go to state 23
    VAR            shift, and go to state 24
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '{'            shift, and go to state 160
    '('            shift, and go to state 120

    $default  reduce using rule 75 (EmptyStmt)

    ArrayType        go to state 122
    Assignment       go to state 287
    BasicLit         go to state 123
    Block            go to state 288
    BreakStmt        go to state 289
    BuiltinCall      go to state 124
    Channel          go to state 290
    ChannelType      go to state 68
    ChannelType1     go to state 69
    CompositeLit     go to state 125
    ConstDecl        go to state 25
    ContinueStmt     go to state 291
    Conversion       go to state 126
    Declaration      go to state 292
    DeferStmt        go to state 293
    EmptyStmt        go to state 294
    ExprSwitchStmt   go to state 295
    Expression       go to state 296
    ExpressionList   go to state 297
    ExpressionStmt   go to state 298
    FallthroughStmt  go to state 299
    ForStmt          go to state 300
    FunctionLit      go to state 128
    FunctionType     go to state 72
    GoStmt           go to state 301
    GotoStmt         go to state 302
    IdentifierList   go to state 303
    IfStmt           go to state 304
    IncDecStmt       go to state 305
    InterfaceType    go to state 73
    Label            go to state 306
    LabeledStmt      go to state 307
    Literal          go to state 129
    LiteralType      go to state 130
    MapType          go to state 131
    MethodExpr       go to state 132
    Operand          go to state 133
    OperandName      go to state 134
    PackageName      go to state 75
    PointerType      go to state 76
    PrimaryExpr      go to state 135
    QualifiedIdent   go to state 136
    ReceiverType     go to state 137
    ReturnStmt       go to state 308
    SelectStmt       go to state 309
    SendStmt         go to state 310
    ShortVarDecl     go to state 311
    SimpleStmt       go to state 312
    SliceType        go to state 138
    Statement        go to state 415
    StructType       go to state 139
    SwitchStmt       go to state 314
    Type             go to state 140
    TypeDecl         go to state 30
    TypeLit          go to state 81
    TypeName         go to state 141
    TypeSwitchStmt   go to state 315
    UnaryExpr        go to state 142
    VarDecl          go to state 31


state 389

  282 StatementList1: StatementList1 Statement ';' .

    $default  reduce using rule 282 (StatementList1)


state 390

   87 Expression: Expression . BINARY_OP UnaryExpr
   90 ExpressionList1: ExpressionList1 ',' Expression .  [ASSIGN_OP, TOK4, '{', ',', ')', ':', ';', '=']

    BINARY_OP  shift, and go to state 191

    $default  reduce using rule 90 (ExpressionList1)


state 391

   24 BuiltinArgs1: ',' ArgumentList .

    $default  reduce using rule 24 (BuiltinArgs1)


state 392

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   67 Element: . Element1 Value
   68 Element1: .  [FLOAT_LIT, IDENTIFIER, IMAGINARY_LIT, INT_LIT, RUNE_LIT, STRING_LIT, UNARY_OP, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', '{', '(']
   69         | . Key ':'
   70 ElementIndex: . Expression
   73 ElementList1: ElementList1 ',' . Element
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   98 FieldName: . IDENTIFIER
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  152 Key: . FieldName
  153    | . ElementIndex
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 250
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    FLOAT_LIT      [reduce using rule 68 (Element1)]
    IDENTIFIER     [reduce using rule 68 (Element1)]
    IMAGINARY_LIT  [reduce using rule 68 (Element1)]
    INT_LIT        [reduce using rule 68 (Element1)]
    RUNE_LIT       [reduce using rule 68 (Element1)]
    STRING_LIT     [reduce using rule 68 (Element1)]
    UNARY_OP       [reduce using rule 68 (Element1)]
    TOK5           [reduce using rule 68 (Element1)]
    CHAN           [reduce using rule 68 (Element1)]
    FUNC           [reduce using rule 68 (Element1)]
    INTERFACE      [reduce using rule 68 (Element1)]
    MAP            [reduce using rule 68 (Element1)]
    STRUCT         [reduce using rule 68 (Element1)]
    '*'            [reduce using rule 68 (Element1)]
    '['            [reduce using rule 68 (Element1)]
    '('            [reduce using rule 68 (Element1)]
    $default       reduce using rule 68 (Element1)

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Element         go to state 416
    Element1        go to state 252
    ElementIndex    go to state 253
    Expression      go to state 255
    FieldName       go to state 256
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Key             go to state 257
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 393

   87 Expression: Expression . BINARY_OP UnaryExpr
  254 Slice12: Expression .  [ASSIGN_OP, BINARY_OP, FLOAT_LIT, IDENTIFIER, IMAGINARY_LIT, INT_LIT, RUNE_LIT, STRING_LIT, UNARY_OP, TOK1, TOK2, TOK4, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', ']', '{', '}', ',', '(', ')', ':', ';', '=', '.']

    BINARY_OP  shift, and go to state 191

    BINARY_OP  [reduce using rule 254 (Slice12)]
    $default   reduce using rule 254 (Slice12)


state 394

  250 Slice1: Slice11 ':' Slice12 .

    $default  reduce using rule 250 (Slice1)


state 395

  295 TypeAssertion: '.' '(' Type ')' .

    $default  reduce using rule 295 (TypeAssertion)


state 396

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  255 Slice2: Slice21 ':' Expression ':' . Expression
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 417
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 397

   60 Conversion: Type '(' Expression Conversion1 ')' .

    $default  reduce using rule 60 (Conversion)


state 398

  212 RangeClause1: ExpressionList '=' .

    $default  reduce using rule 212 (RangeClause1)


state 399

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   46 Condition: . Expression
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   99 ForClause: ForClause1 ';' . ForClause2 ';' ForClause3
  102 ForClause2: .  [';']
  103           | . Condition
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    $default  reduce using rule 102 (ForClause2)

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Condition       go to state 418
    Conversion      go to state 126
    Expression      go to state 419
    ForClause2      go to state 420
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 400

  106 ForStmt: FOR ForStmt1 Block .

    $default  reduce using rule 106 (ForStmt)


state 401

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   88 ExpressionList: . Expression ExpressionList1
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  213 RangeClause1: IdentifierList TOK3 .  [RANGE]
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  238 ShortVarDecl: IdentifierList TOK3 . ExpressionList
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    $default  reduce using rule 213 (RangeClause1)

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 170
    ExpressionList  go to state 414
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 402

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  211 RangeClause: RangeClause1 RANGE . Expression
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 421
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 403

   17 Block: . '{' StatementList '}'
   87 Expression: Expression . BINARY_OP UnaryExpr
  125 IfStmt: IF IfStmt1 Expression . Block IfStmt2

    BINARY_OP  shift, and go to state 191
    '{'        shift, and go to state 160

    Block  go to state 422


state 404

  127 IfStmt1: SimpleStmt ';' .

    $default  reduce using rule 127 (IfStmt1)


state 405

   40 CommCase: . CASE CommCase1
   41         | . DEFAULT
   44 CommClause: . CommCase ':' StatementList
  233 SelectStmt: SELECT '{' SelectStmt1 . '}'
  235 SelectStmt1: SelectStmt1 . CommClause

    CASE     shift, and go to state 423
    DEFAULT  shift, and go to state 424
    '}'      shift, and go to state 425

    CommCase    go to state 426
    CommClause  go to state 427


state 406

   79 ExprSwitchStmt: SWITCH ExprSwitchStmt1 ExprSwitchStmt2 . '{' ExprSwitchStmt3 '}'

    '{'  shift, and go to state 428


state 407

   83 ExprSwitchStmt2: Expression .  ['{']
   87 Expression: Expression . BINARY_OP UnaryExpr

    BINARY_OP  shift, and go to state 191

    $default  reduce using rule 83 (ExprSwitchStmt2)


state 408

   81 ExprSwitchStmt1: SimpleStmt ';' .  [FLOAT_LIT, IDENTIFIER, IMAGINARY_LIT, INT_LIT, RUNE_LIT, STRING_LIT, UNARY_OP, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', '{', '(']
  323 TypeSwitchStmt1: SimpleStmt ';' .  [FLOAT_LIT, IDENTIFIER, IMAGINARY_LIT, INT_LIT, RUNE_LIT, STRING_LIT, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', '(']

    FLOAT_LIT      reduce using rule 81 (ExprSwitchStmt1)
    FLOAT_LIT      [reduce using rule 323 (TypeSwitchStmt1)]
    IDENTIFIER     reduce using rule 81 (ExprSwitchStmt1)
    IDENTIFIER     [reduce using rule 323 (TypeSwitchStmt1)]
    IMAGINARY_LIT  reduce using rule 81 (ExprSwitchStmt1)
    IMAGINARY_LIT  [reduce using rule 323 (TypeSwitchStmt1)]
    INT_LIT        reduce using rule 81 (ExprSwitchStmt1)
    INT_LIT        [reduce using rule 323 (TypeSwitchStmt1)]
    RUNE_LIT       reduce using rule 81 (ExprSwitchStmt1)
    RUNE_LIT       [reduce using rule 323 (TypeSwitchStmt1)]
    STRING_LIT     reduce using rule 81 (ExprSwitchStmt1)
    STRING_LIT     [reduce using rule 323 (TypeSwitchStmt1)]
    TOK5           reduce using rule 81 (ExprSwitchStmt1)
    TOK5           [reduce using rule 323 (TypeSwitchStmt1)]
    CHAN           reduce using rule 81 (ExprSwitchStmt1)
    CHAN           [reduce using rule 323 (TypeSwitchStmt1)]
    FUNC           reduce using rule 81 (ExprSwitchStmt1)
    FUNC           [reduce using rule 323 (TypeSwitchStmt1)]
    INTERFACE      reduce using rule 81 (ExprSwitchStmt1)
    INTERFACE      [reduce using rule 323 (TypeSwitchStmt1)]
    MAP            reduce using rule 81 (ExprSwitchStmt1)
    MAP            [reduce using rule 323 (TypeSwitchStmt1)]
    STRUCT         reduce using rule 81 (ExprSwitchStmt1)
    STRUCT         [reduce using rule 323 (TypeSwitchStmt1)]
    '*'            reduce using rule 81 (ExprSwitchStmt1)
    '*'            [reduce using rule 323 (TypeSwitchStmt1)]
    '['            reduce using rule 81 (ExprSwitchStmt1)
    '['            [reduce using rule 323 (TypeSwitchStmt1)]
    '('            reduce using rule 81 (ExprSwitchStmt1)
    '('            [reduce using rule 323 (TypeSwitchStmt1)]
    $default       reduce using rule 81 (ExprSwitchStmt1)


state 409

  320 TypeSwitchGuard1: IDENTIFIER . TOK3

    TOK3  shift, and go to state 429


state 410

  321 TypeSwitchStmt: SWITCH TypeSwitchStmt1 TypeSwitchGuard . '{' TypeSwitchStmt2 '}'

    '{'  shift, and go to state 430


state 411

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  318 TypeSwitchGuard: TypeSwitchGuard1 . PrimaryExpr '.' '(' TYPE ')'

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 431
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141


state 412

   87 Expression: Expression . BINARY_OP UnaryExpr
  237 SendStmt: Channel TOK5 Expression .  ['{', ':', ';']

    BINARY_OP  shift, and go to state 191

    $default  reduce using rule 237 (SendStmt)


state 413

    9 Assignment: ExpressionList ASSIGN_OP ExpressionList .

    $default  reduce using rule 9 (Assignment)


state 414

  238 ShortVarDecl: IdentifierList TOK3 ExpressionList .

    $default  reduce using rule 238 (ShortVarDecl)


state 415

  156 LabeledStmt: Label ':' Statement .

    $default  reduce using rule 156 (LabeledStmt)


state 416

   73 ElementList1: ElementList1 ',' Element .

    $default  reduce using rule 73 (ElementList1)


state 417

   87 Expression: Expression . BINARY_OP UnaryExpr
  255 Slice2: Slice21 ':' Expression ':' Expression .  [']']

    BINARY_OP  shift, and go to state 191

    $default  reduce using rule 255 (Slice2)


state 418

  103 ForClause2: Condition .

    $default  reduce using rule 103 (ForClause2)


state 419

   46 Condition: Expression .  [';']
   87 Expression: Expression . BINARY_OP UnaryExpr

    BINARY_OP  shift, and go to state 191

    $default  reduce using rule 46 (Condition)


state 420

   99 ForClause: ForClause1 ';' ForClause2 . ';' ForClause3

    ';'  shift, and go to state 432


state 421

   87 Expression: Expression . BINARY_OP UnaryExpr
  211 RangeClause: RangeClause1 RANGE Expression .  ['{']

    BINARY_OP  shift, and go to state 191

    $default  reduce using rule 211 (RangeClause)


state 422

  125 IfStmt: IF IfStmt1 Expression Block . IfStmt2
  128 IfStmt2: .  [';']
  129        | . ELSE IfStmt21

    ELSE  shift, and go to state 433

    $default  reduce using rule 128 (IfStmt2)

    IfStmt2  go to state 434


state 423

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   35 Channel: . Expression
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   40 CommCase: CASE . CommCase1
   42 CommCase1: . SendStmt
   43          | . RecvStmt
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   88 ExpressionList: . Expression ExpressionList1
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  122 IdentifierList: . IDENTIFIER IdentifierList1
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  223 RecvStmt: . RecvStmt1 RecvExpr
  224 RecvStmt1: .  [FLOAT_LIT, IDENTIFIER, IMAGINARY_LIT, INT_LIT, RUNE_LIT, STRING_LIT, UNARY_OP, TOK5, CHAN, FUNC, INTERFACE, MAP, STRUCT, '*', '[', '(']
  225          | . RecvStmt11
  226 RecvStmt11: . ExpressionList '='
  227           | . IdentifierList TOK3
  237 SendStmt: . Channel TOK5 Expression
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 359
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    FLOAT_LIT      [reduce using rule 224 (RecvStmt1)]
    IDENTIFIER     [reduce using rule 224 (RecvStmt1)]
    IMAGINARY_LIT  [reduce using rule 224 (RecvStmt1)]
    INT_LIT        [reduce using rule 224 (RecvStmt1)]
    RUNE_LIT       [reduce using rule 224 (RecvStmt1)]
    STRING_LIT     [reduce using rule 224 (RecvStmt1)]
    UNARY_OP       [reduce using rule 224 (RecvStmt1)]
    TOK5           [reduce using rule 224 (RecvStmt1)]
    CHAN           [reduce using rule 224 (RecvStmt1)]
    FUNC           [reduce using rule 224 (RecvStmt1)]
    INTERFACE      [reduce using rule 224 (RecvStmt1)]
    MAP            [reduce using rule 224 (RecvStmt1)]
    STRUCT         [reduce using rule 224 (RecvStmt1)]
    '*'            [reduce using rule 224 (RecvStmt1)]
    '['            [reduce using rule 224 (RecvStmt1)]
    '('            [reduce using rule 224 (RecvStmt1)]

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    Channel         go to state 290
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CommCase1       go to state 435
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 436
    ExpressionList  go to state 437
    FunctionLit     go to state 128
    FunctionType    go to state 72
    IdentifierList  go to state 438
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    RecvStmt        go to state 439
    RecvStmt1       go to state 440
    RecvStmt11      go to state 441
    SendStmt        go to state 442
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 424

   41 CommCase: DEFAULT .

    $default  reduce using rule 41 (CommCase)


state 425

  233 SelectStmt: SELECT '{' SelectStmt1 '}' .

    $default  reduce using rule 233 (SelectStmt)


state 426

   44 CommClause: CommCase . ':' StatementList

    ':'  shift, and go to state 443


state 427

  235 SelectStmt1: SelectStmt1 CommClause .

    $default  reduce using rule 235 (SelectStmt1)


state 428

   79 ExprSwitchStmt: SWITCH ExprSwitchStmt1 ExprSwitchStmt2 '{' . ExprSwitchStmt3 '}'
   84 ExprSwitchStmt3: .
   85                | . ExprSwitchStmt3 ExprCaseClause

    $default  reduce using rule 84 (ExprSwitchStmt3)

    ExprSwitchStmt3  go to state 444


state 429

  320 TypeSwitchGuard1: IDENTIFIER TOK3 .

    $default  reduce using rule 320 (TypeSwitchGuard1)


state 430

  321 TypeSwitchStmt: SWITCH TypeSwitchStmt1 TypeSwitchGuard '{' . TypeSwitchStmt2 '}'
  324 TypeSwitchStmt2: .
  325                | . TypeSwitchStmt2 TypeCaseClause

    $default  reduce using rule 324 (TypeSwitchStmt2)

    TypeSwitchStmt2  go to state 445


state 431

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   30 Call: . '(' Call1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  146 Index: . '[' Expression ']'
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  205            | PrimaryExpr . Selector
  206            | . PrimaryExpr Index
  206            | PrimaryExpr . Index
  207            | . PrimaryExpr Slice
  207            | PrimaryExpr . Slice
  208            | . PrimaryExpr TypeAssertion
  208            | PrimaryExpr . TypeAssertion
  209            | . PrimaryExpr Call
  209            | PrimaryExpr . Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  236 Selector: . '.' IDENTIFIER
  248 Slice: . '[' Slice1
  249      | . Slice2 ']'
  255 Slice2: . Slice21 ':' Expression ':' Expression
  256 Slice21: .  [':']
  257        | . Expression
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  295 TypeAssertion: . '.' '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  318 TypeSwitchGuard: TypeSwitchGuard1 PrimaryExpr . '.' '(' TYPE ')'
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 194
    '('            shift, and go to state 195
    '.'            shift, and go to state 446

    $default  reduce using rule 256 (Slice21)

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    Call            go to state 197
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 198
    FunctionLit     go to state 128
    FunctionType    go to state 72
    Index           go to state 199
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    Selector        go to state 200
    Slice           go to state 201
    Slice2          go to state 202
    Slice21         go to state 203
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeAssertion   go to state 204
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 432

    8 ArrayType: . '[' ArrayLength ']' ElementType
    9 Assignment: . ExpressionList ASSIGN_OP ExpressionList
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   35 Channel: . Expression
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   75 EmptyStmt: .  ['{']
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   88 ExpressionList: . Expression ExpressionList1
   91 ExpressionStmt: . Expression
   99 ForClause: ForClause1 ';' ForClause2 ';' . ForClause3
  104 ForClause3: .  ['{']
  105           | . PostStmt
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  122 IdentifierList: . IDENTIFIER IdentifierList1
  143 IncDecStmt: . Expression IncDecStmt1
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  201 PostStmt: . SimpleStmt
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  237 SendStmt: . Channel TOK5 Expression
  238 ShortVarDecl: . IdentifierList TOK3 ExpressionList
  242 SimpleStmt: . EmptyStmt
  243           | . ExpressionStmt
  244           | . SendStmt
  245           | . IncDecStmt
  246           | . Assignment
  247           | . ShortVarDecl
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 359
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    '{'       reduce using rule 75 (EmptyStmt)
    '{'       [reduce using rule 104 (ForClause3)]
    $default  reduce using rule 75 (EmptyStmt)

    ArrayType       go to state 122
    Assignment      go to state 287
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    Channel         go to state 290
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    EmptyStmt       go to state 294
    Expression      go to state 296
    ExpressionList  go to state 297
    ExpressionStmt  go to state 298
    ForClause3      go to state 447
    FunctionLit     go to state 128
    FunctionType    go to state 72
    IdentifierList  go to state 303
    IncDecStmt      go to state 305
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PostStmt        go to state 448
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SendStmt        go to state 310
    ShortVarDecl    go to state 311
    SimpleStmt      go to state 449
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 433

   17 Block: . '{' StatementList '}'
  125 IfStmt: . IF IfStmt1 Expression Block IfStmt2
  129 IfStmt2: ELSE . IfStmt21
  130 IfStmt21: . IfStmt
  131         | . Block

    IF   shift, and go to state 283
    '{'  shift, and go to state 160

    Block     go to state 450
    IfStmt    go to state 451
    IfStmt21  go to state 452


state 434

  125 IfStmt: IF IfStmt1 Expression Block IfStmt2 .

    $default  reduce using rule 125 (IfStmt)


state 435

   40 CommCase: CASE CommCase1 .

    $default  reduce using rule 40 (CommCase)


state 436

   35 Channel: Expression .  [TOK5]
   87 Expression: Expression . BINARY_OP UnaryExpr
   88 ExpressionList: Expression . ExpressionList1
   89 ExpressionList1: .  [',', '=']
   90                | . ExpressionList1 ',' Expression

    BINARY_OP  shift, and go to state 191

    TOK5      reduce using rule 35 (Channel)
    $default  reduce using rule 89 (ExpressionList1)

    ExpressionList1  go to state 223


state 437

  226 RecvStmt11: ExpressionList . '='

    '='  shift, and go to state 453


state 438

  227 RecvStmt11: IdentifierList . TOK3

    TOK3  shift, and go to state 454


state 439

   43 CommCase1: RecvStmt .

    $default  reduce using rule 43 (CommCase1)


state 440

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  222 RecvExpr: . Expression
  223 RecvStmt: RecvStmt1 . RecvExpr
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 455
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    RecvExpr        go to state 456
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 441

  225 RecvStmt1: RecvStmt11 .

    $default  reduce using rule 225 (RecvStmt1)


state 442

   42 CommCase1: SendStmt .

    $default  reduce using rule 42 (CommCase1)


state 443

   44 CommClause: CommCase ':' . StatementList
  280 StatementList: . StatementList1
  281 StatementList1: .
  282               | . StatementList1 Statement ';'

    $default  reduce using rule 281 (StatementList1)

    StatementList   go to state 457
    StatementList1  go to state 220


state 444

   76 ExprCaseClause: . ExprSwitchCase ':' StatementList
   77 ExprSwitchCase: . CASE ExpressionList
   78               | . DEFAULT
   79 ExprSwitchStmt: SWITCH ExprSwitchStmt1 ExprSwitchStmt2 '{' ExprSwitchStmt3 . '}'
   85 ExprSwitchStmt3: ExprSwitchStmt3 . ExprCaseClause

    CASE     shift, and go to state 458
    DEFAULT  shift, and go to state 459
    '}'      shift, and go to state 460

    ExprCaseClause  go to state 461
    ExprSwitchCase  go to state 462


state 445

  296 TypeCaseClause: . TypeSwitchCase ':' StatementList
  316 TypeSwitchCase: . CASE TypeList
  317               | . DEFAULT
  321 TypeSwitchStmt: SWITCH TypeSwitchStmt1 TypeSwitchGuard '{' TypeSwitchStmt2 . '}'
  325 TypeSwitchStmt2: TypeSwitchStmt2 . TypeCaseClause

    CASE     shift, and go to state 463
    DEFAULT  shift, and go to state 464
    '}'      shift, and go to state 465

    TypeCaseClause  go to state 466
    TypeSwitchCase  go to state 467


state 446

  236 Selector: '.' . IDENTIFIER
  295 TypeAssertion: '.' . '(' Type ')'
  318 TypeSwitchGuard: TypeSwitchGuard1 PrimaryExpr '.' . '(' TYPE ')'

    IDENTIFIER  shift, and go to state 265
    '('         shift, and go to state 468


state 447

   99 ForClause: ForClause1 ';' ForClause2 ';' ForClause3 .

    $default  reduce using rule 99 (ForClause)


state 448

  105 ForClause3: PostStmt .

    $default  reduce using rule 105 (ForClause3)


state 449

  201 PostStmt: SimpleStmt .

    $default  reduce using rule 201 (PostStmt)


state 450

  131 IfStmt21: Block .

    $default  reduce using rule 131 (IfStmt21)


state 451

  130 IfStmt21: IfStmt .

    $default  reduce using rule 130 (IfStmt21)


state 452

  129 IfStmt2: ELSE IfStmt21 .

    $default  reduce using rule 129 (IfStmt2)


state 453

  226 RecvStmt11: ExpressionList '=' .

    $default  reduce using rule 226 (RecvStmt11)


state 454

  227 RecvStmt11: IdentifierList TOK3 .

    $default  reduce using rule 227 (RecvStmt11)


state 455

   87 Expression: Expression . BINARY_OP UnaryExpr
  222 RecvExpr: Expression .  [':']

    BINARY_OP  shift, and go to state 191

    $default  reduce using rule 222 (RecvExpr)


state 456

  223 RecvStmt: RecvStmt1 RecvExpr .

    $default  reduce using rule 223 (RecvStmt)


state 457

   44 CommClause: CommCase ':' StatementList .

    $default  reduce using rule 44 (CommClause)


state 458

    8 ArrayType: . '[' ArrayLength ']' ElementType
   12 BasicLit: . INT_LIT
   13         | . FLOAT_LIT
   14         | . IMAGINARY_LIT
   15         | . RUNE_LIT
   16         | . STRING_LIT
   25 BuiltinCall: . IDENTIFIER '(' BuiltinCall1 ')'
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
   45 CompositeLit: . LiteralType LiteralValue
   60 Conversion: . Type '(' Expression Conversion1 ')'
   77 ExprSwitchCase: CASE . ExpressionList
   86 Expression: . UnaryExpr
   87           | . Expression BINARY_OP UnaryExpr
   88 ExpressionList: . Expression ExpressionList1
  117 FunctionLit: . FUNC Function
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  157 Literal: . BasicLit
  158        | . CompositeLit
  159        | . FunctionLit
  160 LiteralType: . StructType
  161            | . ArrayType
  162            | . '[' TOK4 ']' ElementType
  163            | . SliceType
  164            | . MapType
  165            | . TypeName
  171 MapType: . MAP '[' KeyType ']' ElementType
  175 MethodExpr: . ReceiverType '.' MethodName
  179 Operand: . Literal
  180        | . OperandName
  181        | . MethodExpr
  182        | . '(' Expression ')'
  183 OperandName: . IDENTIFIER
  184            | . QualifiedIdent
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  202 PrimaryExpr: . Operand
  203            | . Conversion
  204            | . BuiltinCall
  205            | . PrimaryExpr Selector
  206            | . PrimaryExpr Index
  207            | . PrimaryExpr Slice
  208            | . PrimaryExpr TypeAssertion
  209            | . PrimaryExpr Call
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  219 ReceiverType: . TypeName
  220             | . '(' '*' TypeName ')'
  221             | . '(' ReceiverType ')'
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  326 UnaryExpr: . PrimaryExpr
  327          | . UNARY_OP UnaryExpr

    FLOAT_LIT      shift, and go to state 110
    IDENTIFIER     shift, and go to state 111
    IMAGINARY_LIT  shift, and go to state 112
    INT_LIT        shift, and go to state 113
    RUNE_LIT       shift, and go to state 114
    STRING_LIT     shift, and go to state 115
    UNARY_OP       shift, and go to state 116
    TOK5           shift, and go to state 58
    CHAN           shift, and go to state 59
    FUNC           shift, and go to state 117
    INTERFACE      shift, and go to state 61
    MAP            shift, and go to state 62
    STRUCT         shift, and go to state 63
    '*'            shift, and go to state 64
    '['            shift, and go to state 118
    '('            shift, and go to state 120

    ArrayType       go to state 122
    BasicLit        go to state 123
    BuiltinCall     go to state 124
    ChannelType     go to state 68
    ChannelType1    go to state 69
    CompositeLit    go to state 125
    Conversion      go to state 126
    Expression      go to state 170
    ExpressionList  go to state 469
    FunctionLit     go to state 128
    FunctionType    go to state 72
    InterfaceType   go to state 73
    Literal         go to state 129
    LiteralType     go to state 130
    MapType         go to state 131
    MethodExpr      go to state 132
    Operand         go to state 133
    OperandName     go to state 134
    PackageName     go to state 75
    PointerType     go to state 76
    PrimaryExpr     go to state 135
    QualifiedIdent  go to state 136
    ReceiverType    go to state 137
    SliceType       go to state 138
    StructType      go to state 139
    Type            go to state 140
    TypeLit         go to state 81
    TypeName        go to state 141
    UnaryExpr       go to state 142


state 459

   78 ExprSwitchCase: DEFAULT .

    $default  reduce using rule 78 (ExprSwitchCase)


state 460

   79 ExprSwitchStmt: SWITCH ExprSwitchStmt1 ExprSwitchStmt2 '{' ExprSwitchStmt3 '}' .

    $default  reduce using rule 79 (ExprSwitchStmt)


state 461

   85 ExprSwitchStmt3: ExprSwitchStmt3 ExprCaseClause .

    $default  reduce using rule 85 (ExprSwitchStmt3)


state 462

   76 ExprCaseClause: ExprSwitchCase . ':' StatementList

    ':'  shift, and go to state 470


state 463

    8 ArrayType: . '[' ArrayLength ']' ElementType
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  302 TypeList: . Type TypeList1
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  316 TypeSwitchCase: CASE . TypeList

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66

    ArrayType       go to state 67
    ChannelType     go to state 68
    ChannelType1    go to state 69
    FunctionType    go to state 72
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 471
    TypeList        go to state 472
    TypeLit         go to state 81
    TypeName        go to state 82


state 464

  317 TypeSwitchCase: DEFAULT .

    $default  reduce using rule 317 (TypeSwitchCase)


state 465

  321 TypeSwitchStmt: SWITCH TypeSwitchStmt1 TypeSwitchGuard '{' TypeSwitchStmt2 '}' .

    $default  reduce using rule 321 (TypeSwitchStmt)


state 466

  325 TypeSwitchStmt2: TypeSwitchStmt2 TypeCaseClause .

    $default  reduce using rule 325 (TypeSwitchStmt2)


state 467

  296 TypeCaseClause: TypeSwitchCase . ':' StatementList

    ':'  shift, and go to state 473


state 468

    8 ArrayType: . '[' ArrayLength ']' ElementType
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  295 TypeAssertion: '.' '(' . Type ')'
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent
  318 TypeSwitchGuard: TypeSwitchGuard1 PrimaryExpr '.' '(' . TYPE ')'

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    TYPE        shift, and go to state 474
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66

    ArrayType       go to state 67
    ChannelType     go to state 68
    ChannelType1    go to state 69
    FunctionType    go to state 72
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 348
    TypeLit         go to state 81
    TypeName        go to state 82


state 469

   77 ExprSwitchCase: CASE ExpressionList .

    $default  reduce using rule 77 (ExprSwitchCase)


state 470

   76 ExprCaseClause: ExprSwitchCase ':' . StatementList
  280 StatementList: . StatementList1
  281 StatementList1: .
  282               | . StatementList1 Statement ';'

    $default  reduce using rule 281 (StatementList1)

    StatementList   go to state 475
    StatementList1  go to state 220


state 471

  302 TypeList: Type . TypeList1
  303 TypeList1: .
  304          | . TypeList1 ',' Type

    $default  reduce using rule 303 (TypeList1)

    TypeList1  go to state 476


state 472

  316 TypeSwitchCase: CASE TypeList .

    $default  reduce using rule 316 (TypeSwitchCase)


state 473

  280 StatementList: . StatementList1
  281 StatementList1: .
  282               | . StatementList1 Statement ';'
  296 TypeCaseClause: TypeSwitchCase ':' . StatementList

    $default  reduce using rule 281 (StatementList1)

    StatementList   go to state 477
    StatementList1  go to state 220


state 474

  318 TypeSwitchGuard: TypeSwitchGuard1 PrimaryExpr '.' '(' TYPE . ')'

    ')'  shift, and go to state 478


state 475

   76 ExprCaseClause: ExprSwitchCase ':' StatementList .

    $default  reduce using rule 76 (ExprCaseClause)


state 476

  302 TypeList: Type TypeList1 .  [':']
  304 TypeList1: TypeList1 . ',' Type

    ','  shift, and go to state 479

    $default  reduce using rule 302 (TypeList)


state 477

  296 TypeCaseClause: TypeSwitchCase ':' StatementList .

    $default  reduce using rule 296 (TypeCaseClause)


state 478

  318 TypeSwitchGuard: TypeSwitchGuard1 PrimaryExpr '.' '(' TYPE ')' .

    $default  reduce using rule 318 (TypeSwitchGuard)


state 479

    8 ArrayType: . '[' ArrayLength ']' ElementType
   36 ChannelType: . ChannelType1 ElementType
   37 ChannelType1: . CHAN
   38             | . CHAN TOK5
   39             | . TOK5 CHAN
  119 FunctionType: . FUNC Signature
  148 InterfaceType: . INTERFACE '{' InterfaceType1 '}'
  171 MapType: . MAP '[' KeyType ']' ElementType
  186 PackageName: . IDENTIFIER
  200 PointerType: . '*' BaseType
  210 QualifiedIdent: . PackageName '.' IDENTIFIER
  258 SliceType: . '[' ']' ElementType
  283 StructType: . STRUCT '{' StructType1 '}'
  292 Type: . TypeName
  293     | . TypeLit
  294     | . '(' Type ')'
  304 TypeList1: TypeList1 ',' . Type
  305 TypeLit: . ArrayType
  306        | . StructType
  307        | . PointerType
  308        | . FunctionType
  309        | . InterfaceType
  310        | . SliceType
  311        | . MapType
  312        | . ChannelType
  313 TypeName: . IDENTIFIER
  314         | . QualifiedIdent

    IDENTIFIER  shift, and go to state 57
    TOK5        shift, and go to state 58
    CHAN        shift, and go to state 59
    FUNC        shift, and go to state 60
    INTERFACE   shift, and go to state 61
    MAP         shift, and go to state 62
    STRUCT      shift, and go to state 63
    '*'         shift, and go to state 64
    '['         shift, and go to state 65
    '('         shift, and go to state 66

    ArrayType       go to state 67
    ChannelType     go to state 68
    ChannelType1    go to state 69
    FunctionType    go to state 72
    InterfaceType   go to state 73
    MapType         go to state 74
    PackageName     go to state 75
    PointerType     go to state 76
    QualifiedIdent  go to state 77
    SliceType       go to state 78
    StructType      go to state 79
    Type            go to state 480
    TypeLit         go to state 81
    TypeName        go to state 82


state 480

  304 TypeList1: TypeList1 ',' Type .

    $default  reduce using rule 304 (TypeList1)
