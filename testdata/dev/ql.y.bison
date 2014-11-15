Grammar

    0 $accept: Start $end

    1 AlterTableStmt: _ALTER _TABLE TableName AlterTableStmt1

    2 AlterTableStmt1: _ADD ColumnDef
    3                | _DROP _COLUMN ColumnName

    4 Assignment: ColumnName '=' Expression

    5 AssignmentList: Assignment AssignmentList1 AssignmentList2

    6 AssignmentList1: /* empty */
    7                | AssignmentList1 ',' Assignment

    8 AssignmentList2: /* empty */
    9                | ','

   10 BeginTransactionStmt: _BEGIN _TRANSACTION

   11 Call: '(' Call1 ')'

   12 Call1: /* empty */
   13      | ExpressionList

   14 ColumnDef: ColumnName Type

   15 ColumnName: _IDENTIFIER

   16 ColumnNameList: ColumnName ColumnNameList1 ColumnNameList2

   17 ColumnNameList1: /* empty */
   18                | ColumnNameList1 ',' ColumnName

   19 ColumnNameList2: /* empty */
   20                | ','

   21 CommitStmt: _COMMIT

   22 Conversion: Type '(' Expression ')'

   23 CreateIndexStmt: _CREATE CreateIndexStmt1 _INDEX CreateIndexStmt2 IndexName _ON TableName '(' CreateIndexStmt3 ')'

   24 CreateIndexStmt1: /* empty */
   25                 | _UNIQUE

   26 CreateIndexStmt2: /* empty */
   27                 | _IF _NOT _EXISTS

   28 CreateIndexStmt3: ColumnName
   29                 | _ID Call

   30 CreateTableStmt: _CREATE _TABLE CreateTableStmt1 TableName '(' ColumnDef CreateTableStmt2 CreateTableStmt3 ')'

   31 CreateTableStmt1: /* empty */
   32                 | _IF _NOT _EXISTS

   33 CreateTableStmt2: /* empty */
   34                 | CreateTableStmt2 ',' ColumnDef

   35 CreateTableStmt3: /* empty */
   36                 | ','

   37 DeleteFromStmt: _DELETE _FROM TableName DeleteFromStmt1

   38 DeleteFromStmt1: /* empty */
   39                | WhereClause

   40 DropIndexStmt: _DROP _INDEX DropIndexStmt1 IndexName

   41 DropIndexStmt1: /* empty */
   42               | _IF _EXISTS

   43 DropTableStmt: _DROP _TABLE DropTableStmt1 TableName

   44 DropTableStmt1: /* empty */
   45               | _IF _EXISTS

   46 EmptyStmt: /* empty */

   47 Expression: Term Expression1

   48 Expression1: /* empty */
   49            | Expression1 _OROR Term

   50 ExpressionList: Expression ExpressionList1 ExpressionList2

   51 ExpressionList1: /* empty */
   52                | ExpressionList1 ',' Expression

   53 ExpressionList2: /* empty */
   54                | ','

   55 Factor: PrimaryFactor Factor1 Factor2

   56 Factor1: /* empty */
   57        | Factor1 Factor11 PrimaryFactor

   58 Factor11: _GE
   59         | '>'
   60         | _LE
   61         | '<'
   62         | _NEQ
   63         | _EQ
   64         | _LIKE

   65 Factor2: /* empty */
   66        | Predicate

   67 Field: Expression Field1

   68 Field1: /* empty */
   69       | _AS _IDENTIFIER

   70 FieldList: Field FieldList1 FieldList2

   71 FieldList1: /* empty */
   72           | FieldList1 ',' Field

   73 FieldList2: /* empty */
   74           | ','

   75 GroupByClause: _GROUPBY ColumnNameList

   76 Index: '[' Expression ']'

   77 IndexName: _IDENTIFIER

   78 InsertIntoStmt: _INSERT _INTO TableName InsertIntoStmt1 InsertIntoStmt2

   79 InsertIntoStmt1: /* empty */
   80                | '(' ColumnNameList ')'

   81 InsertIntoStmt2: Values
   82                | SelectStmt

   83 Limit: _LIMIT Expression

   84 Literal: _FALSE
   85        | _NULL
   86        | _TRUE
   87        | _FLOAT_LIT
   88        | _IMAGINARY_LIT
   89        | _INT_LIT
   90        | _RUNE_LIT
   91        | _STRING_LIT
   92        | _QL_PARAMETER

   93 Offset: _OFFSET Expression

   94 Operand: Literal
   95        | QualifiedIdent
   96        | '(' Expression ')'

   97 OrderBy: _ORDER _BY ExpressionList OrderBy1

   98 OrderBy1: /* empty */
   99         | OrderBy11

  100 OrderBy11: _ASC
  101          | _DESC

  102 Predicate: Predicate1

  103 Predicate1: Predicate11 Predicate12
  104           | _IS Predicate13 _NULL

  105 Predicate11: /* empty */
  106            | _NOT

  107 Predicate12: _IN '(' ExpressionList ')'
  108            | _BETWEEN PrimaryFactor _AND PrimaryFactor

  109 Predicate13: /* empty */
  110            | _NOT

  111 PrimaryExpression: Operand
  112                  | Conversion
  113                  | PrimaryExpression Index
  114                  | PrimaryExpression Slice
  115                  | PrimaryExpression Call

  116 PrimaryFactor: PrimaryTerm PrimaryFactor1

  117 PrimaryFactor1: /* empty */
  118               | PrimaryFactor1 PrimaryFactor11 PrimaryTerm

  119 PrimaryFactor11: '^'
  120                | '|'
  121                | '-'
  122                | '+'

  123 PrimaryTerm: UnaryExpr PrimaryTerm1

  124 PrimaryTerm1: /* empty */
  125             | PrimaryTerm1 PrimaryTerm11 UnaryExpr

  126 PrimaryTerm11: _ANDNOT
  127              | '&'
  128              | _LSH
  129              | _RSH
  130              | '%'
  131              | '/'
  132              | '*'

  133 QualifiedIdent: _IDENTIFIER QualifiedIdent1

  134 QualifiedIdent1: /* empty */
  135                | '.' _IDENTIFIER

  136 RecordSet: RecordSet1 RecordSet2

  137 RecordSet1: TableName
  138           | '(' SelectStmt RecordSet11 ')'

  139 RecordSet11: /* empty */
  140            | ';'

  141 RecordSet2: /* empty */
  142           | _AS _IDENTIFIER

  143 RecordSetList: RecordSet RecordSetList1 RecordSetList2

  144 RecordSetList1: /* empty */
  145               | RecordSetList1 ',' RecordSet

  146 RecordSetList2: /* empty */
  147               | ','

  148 RollbackStmt: _ROLLBACK

  149 SelectStmt: _SELECT SelectStmt1 SelectStmt2 _FROM RecordSetList SelectStmt3 SelectStmt4 SelectStmt5 SelectStmt6 SelectStmt7

  150 SelectStmt1: /* empty */
  151            | _DISTINCT

  152 SelectStmt2: '*'
  153            | FieldList

  154 SelectStmt3: /* empty */
  155            | WhereClause

  156 SelectStmt4: /* empty */
  157            | GroupByClause

  158 SelectStmt5: /* empty */
  159            | OrderBy

  160 SelectStmt6: /* empty */
  161            | Limit

  162 SelectStmt7: /* empty */
  163            | Offset

  164 Slice: '[' Slice1 ':' Slice2 ']'

  165 Slice1: /* empty */
  166       | Expression

  167 Slice2: /* empty */
  168       | Expression

  169 Start: StatementList

  170 Statement: EmptyStmt
  171          | AlterTableStmt
  172          | BeginTransactionStmt
  173          | CommitStmt
  174          | CreateIndexStmt
  175          | CreateTableStmt
  176          | DeleteFromStmt
  177          | DropIndexStmt
  178          | DropTableStmt
  179          | InsertIntoStmt
  180          | RollbackStmt
  181          | SelectStmt
  182          | TruncateTableStmt
  183          | UpdateStmt

  184 StatementList: Statement StatementList1

  185 StatementList1: /* empty */
  186               | StatementList1 ';' Statement

  187 TableName: _IDENTIFIER

  188 Term: Factor Term1

  189 Term1: /* empty */
  190      | Term1 _ANDAND Factor

  191 TruncateTableStmt: _TRUNCATE _TABLE TableName

  192 Type: _BIGINT
  193     | _BIGRAT
  194     | _BLOB
  195     | _BOOL
  196     | _BYTE
  197     | _COMPLEX128
  198     | _COMPLEX64
  199     | _DURATION
  200     | _FLOAT
  201     | _FLOAT32
  202     | _FLOAT64
  203     | _INT
  204     | _INT16
  205     | _INT32
  206     | _INT64
  207     | _INT8
  208     | _RUNE
  209     | _STRING
  210     | _TIME
  211     | _UINT
  212     | _UINT16
  213     | _UINT32
  214     | _UINT64
  215     | _UINT8

  216 UnaryExpr: UnaryExpr1 PrimaryExpression

  217 UnaryExpr1: /* empty */
  218           | UnaryExpr11

  219 UnaryExpr11: '^'
  220            | '!'
  221            | '-'
  222            | '+'

  223 UpdateStmt: _UPDATE TableName UpdateStmt1 AssignmentList UpdateStmt2

  224 UpdateStmt1: /* empty */
  225            | _SET

  226 UpdateStmt2: /* empty */
  227            | WhereClause

  228 Values: _VALUES '(' ExpressionList ')' Values1 Values2

  229 Values1: /* empty */
  230        | Values1 ',' '(' ExpressionList ')'

  231 Values2: /* empty */
  232        | ','

  233 WhereClause: _WHERE Expression


Terminals, with rules where they appear

$end (0) 0
'!' (33) 220
'%' (37) 130
'&' (38) 127
'(' (40) 11 22 23 30 80 96 107 138 228 230
')' (41) 11 22 23 30 80 96 107 138 228 230
'*' (42) 132 152
'+' (43) 122 222
',' (44) 7 9 18 20 34 36 52 54 72 74 145 147 230 232
'-' (45) 121 221
'.' (46) 135
'/' (47) 131
':' (58) 164
';' (59) 140 186
'<' (60) 61
'=' (61) 4
'>' (62) 59
'[' (91) 76 164
']' (93) 76 164
'^' (94) 119 219
'|' (124) 120
error (256)
_ANDAND (258) 190
_ANDNOT (259) 126
_EQ (260) 63
_FLOAT_LIT (261) 87
_GE (262) 58
_IDENTIFIER (263) 15 69 77 133 135 142 187
_IMAGINARY_LIT (264) 88
_INT_LIT (265) 89
_LE (266) 60
_LSH (267) 128
_NEQ (268) 62
_OROR (269) 49
_QL_PARAMETER (270) 92
_RSH (271) 129
_RUNE_LIT (272) 90
_STRING_LIT (273) 91
_ADD (274) 2
_ALTER (275) 1
_AND (276) 108
_AS (277) 69 142
_ASC (278) 100
_BEGIN (279) 10
_BETWEEN (280) 108
_BIGINT (281) 192
_BIGRAT (282) 193
_BLOB (283) 194
_BOOL (284) 195
_BY (285) 97
_BYTE (286) 196
_COLUMN (287) 3
_COMMIT (288) 21
_COMPLEX128 (289) 197
_COMPLEX64 (290) 198
_CREATE (291) 23 30
_DELETE (292) 37
_DESC (293) 101
_DISTINCT (294) 151
_DROP (295) 3 40 43
_DURATION (296) 199
_EXISTS (297) 27 32 42 45
_FALSE (298) 84
_FLOAT (299) 200
_FLOAT32 (300) 201
_FLOAT64 (301) 202
_FROM (302) 37 149
_GROUPBY (303) 75
_ID (304) 29
_IF (305) 27 32 42 45
_IN (306) 107
_INDEX (307) 23 40
_INSERT (308) 78
_INT (309) 203
_INT16 (310) 204
_INT32 (311) 205
_INT64 (312) 206
_INT8 (313) 207
_INTO (314) 78
_IS (315) 104
_LIKE (316) 64
_LIMIT (317) 83
_NOT (318) 27 32 106 110
_NULL (319) 85 104
_OFFSET (320) 93
_ON (321) 23
_ORDER (322) 97
_ROLLBACK (323) 148
_RUNE (324) 208
_SELECT (325) 149
_SET (326) 225
_STRING (327) 209
_TABLE (328) 1 30 43 191
_TIME (329) 210
_TRANSACTION (330) 10
_TRUE (331) 86
_TRUNCATE (332) 191
_UINT (333) 211
_UINT16 (334) 212
_UINT32 (335) 213
_UINT64 (336) 214
_UINT8 (337) 215
_UNIQUE (338) 25
_UPDATE (339) 223
_VALUES (340) 228
_WHERE (341) 233


Nonterminals, with rules where they appear

$accept (107)
    on left: 0
AlterTableStmt (108)
    on left: 1, on right: 171
AlterTableStmt1 (109)
    on left: 2 3, on right: 1
Assignment (110)
    on left: 4, on right: 5 7
AssignmentList (111)
    on left: 5, on right: 223
AssignmentList1 (112)
    on left: 6 7, on right: 5 7
AssignmentList2 (113)
    on left: 8 9, on right: 5
BeginTransactionStmt (114)
    on left: 10, on right: 172
Call (115)
    on left: 11, on right: 29 115
Call1 (116)
    on left: 12 13, on right: 11
ColumnDef (117)
    on left: 14, on right: 2 30 34
ColumnName (118)
    on left: 15, on right: 3 4 14 16 18 28
ColumnNameList (119)
    on left: 16, on right: 75 80
ColumnNameList1 (120)
    on left: 17 18, on right: 16 18
ColumnNameList2 (121)
    on left: 19 20, on right: 16
CommitStmt (122)
    on left: 21, on right: 173
Conversion (123)
    on left: 22, on right: 112
CreateIndexStmt (124)
    on left: 23, on right: 174
CreateIndexStmt1 (125)
    on left: 24 25, on right: 23
CreateIndexStmt2 (126)
    on left: 26 27, on right: 23
CreateIndexStmt3 (127)
    on left: 28 29, on right: 23
CreateTableStmt (128)
    on left: 30, on right: 175
CreateTableStmt1 (129)
    on left: 31 32, on right: 30
CreateTableStmt2 (130)
    on left: 33 34, on right: 30 34
CreateTableStmt3 (131)
    on left: 35 36, on right: 30
DeleteFromStmt (132)
    on left: 37, on right: 176
DeleteFromStmt1 (133)
    on left: 38 39, on right: 37
DropIndexStmt (134)
    on left: 40, on right: 177
DropIndexStmt1 (135)
    on left: 41 42, on right: 40
DropTableStmt (136)
    on left: 43, on right: 178
DropTableStmt1 (137)
    on left: 44 45, on right: 43
EmptyStmt (138)
    on left: 46, on right: 170
Expression (139)
    on left: 47, on right: 4 22 50 52 67 76 83 93 96 166 168 233
Expression1 (140)
    on left: 48 49, on right: 47 49
ExpressionList (141)
    on left: 50, on right: 13 97 107 228 230
ExpressionList1 (142)
    on left: 51 52, on right: 50 52
ExpressionList2 (143)
    on left: 53 54, on right: 50
Factor (144)
    on left: 55, on right: 188 190
Factor1 (145)
    on left: 56 57, on right: 55 57
Factor11 (146)
    on left: 58 59 60 61 62 63 64, on right: 57
Factor2 (147)
    on left: 65 66, on right: 55
Field (148)
    on left: 67, on right: 70 72
Field1 (149)
    on left: 68 69, on right: 67
FieldList (150)
    on left: 70, on right: 153
FieldList1 (151)
    on left: 71 72, on right: 70 72
FieldList2 (152)
    on left: 73 74, on right: 70
GroupByClause (153)
    on left: 75, on right: 157
Index (154)
    on left: 76, on right: 113
IndexName (155)
    on left: 77, on right: 23 40
InsertIntoStmt (156)
    on left: 78, on right: 179
InsertIntoStmt1 (157)
    on left: 79 80, on right: 78
InsertIntoStmt2 (158)
    on left: 81 82, on right: 78
Limit (159)
    on left: 83, on right: 161
Literal (160)
    on left: 84 85 86 87 88 89 90 91 92, on right: 94
Offset (161)
    on left: 93, on right: 163
Operand (162)
    on left: 94 95 96, on right: 111
OrderBy (163)
    on left: 97, on right: 159
OrderBy1 (164)
    on left: 98 99, on right: 97
OrderBy11 (165)
    on left: 100 101, on right: 99
Predicate (166)
    on left: 102, on right: 66
Predicate1 (167)
    on left: 103 104, on right: 102
Predicate11 (168)
    on left: 105 106, on right: 103
Predicate12 (169)
    on left: 107 108, on right: 103
Predicate13 (170)
    on left: 109 110, on right: 104
PrimaryExpression (171)
    on left: 111 112 113 114 115, on right: 113 114 115 216
PrimaryFactor (172)
    on left: 116, on right: 55 57 108
PrimaryFactor1 (173)
    on left: 117 118, on right: 116 118
PrimaryFactor11 (174)
    on left: 119 120 121 122, on right: 118
PrimaryTerm (175)
    on left: 123, on right: 116 118
PrimaryTerm1 (176)
    on left: 124 125, on right: 123 125
PrimaryTerm11 (177)
    on left: 126 127 128 129 130 131 132, on right: 125
QualifiedIdent (178)
    on left: 133, on right: 95
QualifiedIdent1 (179)
    on left: 134 135, on right: 133
RecordSet (180)
    on left: 136, on right: 143 145
RecordSet1 (181)
    on left: 137 138, on right: 136
RecordSet11 (182)
    on left: 139 140, on right: 138
RecordSet2 (183)
    on left: 141 142, on right: 136
RecordSetList (184)
    on left: 143, on right: 149
RecordSetList1 (185)
    on left: 144 145, on right: 143 145
RecordSetList2 (186)
    on left: 146 147, on right: 143
RollbackStmt (187)
    on left: 148, on right: 180
SelectStmt (188)
    on left: 149, on right: 82 138 181
SelectStmt1 (189)
    on left: 150 151, on right: 149
SelectStmt2 (190)
    on left: 152 153, on right: 149
SelectStmt3 (191)
    on left: 154 155, on right: 149
SelectStmt4 (192)
    on left: 156 157, on right: 149
SelectStmt5 (193)
    on left: 158 159, on right: 149
SelectStmt6 (194)
    on left: 160 161, on right: 149
SelectStmt7 (195)
    on left: 162 163, on right: 149
Slice (196)
    on left: 164, on right: 114
Slice1 (197)
    on left: 165 166, on right: 164
Slice2 (198)
    on left: 167 168, on right: 164
Start (199)
    on left: 169, on right: 0
Statement (200)
    on left: 170 171 172 173 174 175 176 177 178 179 180 181 182 183,
    on right: 184 186
StatementList (201)
    on left: 184, on right: 169
StatementList1 (202)
    on left: 185 186, on right: 184 186
TableName (203)
    on left: 187, on right: 1 23 30 37 43 78 137 191 223
Term (204)
    on left: 188, on right: 47 49
Term1 (205)
    on left: 189 190, on right: 188 190
TruncateTableStmt (206)
    on left: 191, on right: 182
Type (207)
    on left: 192 193 194 195 196 197 198 199 200 201 202 203 204 205
    206 207 208 209 210 211 212 213 214 215, on right: 14 22
UnaryExpr (208)
    on left: 216, on right: 123 125
UnaryExpr1 (209)
    on left: 217 218, on right: 216
UnaryExpr11 (210)
    on left: 219 220 221 222, on right: 218
UpdateStmt (211)
    on left: 223, on right: 183
UpdateStmt1 (212)
    on left: 224 225, on right: 223
UpdateStmt2 (213)
    on left: 226 227, on right: 223
Values (214)
    on left: 228, on right: 81
Values1 (215)
    on left: 229 230, on right: 228 230
Values2 (216)
    on left: 231 232, on right: 228
WhereClause (217)
    on left: 233, on right: 39 155 227


state 0

    0 $accept: . Start $end
    1 AlterTableStmt: . _ALTER _TABLE TableName AlterTableStmt1
   10 BeginTransactionStmt: . _BEGIN _TRANSACTION
   21 CommitStmt: . _COMMIT
   23 CreateIndexStmt: . _CREATE CreateIndexStmt1 _INDEX CreateIndexStmt2 IndexName _ON TableName '(' CreateIndexStmt3 ')'
   30 CreateTableStmt: . _CREATE _TABLE CreateTableStmt1 TableName '(' ColumnDef CreateTableStmt2 CreateTableStmt3 ')'
   37 DeleteFromStmt: . _DELETE _FROM TableName DeleteFromStmt1
   40 DropIndexStmt: . _DROP _INDEX DropIndexStmt1 IndexName
   43 DropTableStmt: . _DROP _TABLE DropTableStmt1 TableName
   46 EmptyStmt: .  [$end, ';']
   78 InsertIntoStmt: . _INSERT _INTO TableName InsertIntoStmt1 InsertIntoStmt2
  148 RollbackStmt: . _ROLLBACK
  149 SelectStmt: . _SELECT SelectStmt1 SelectStmt2 _FROM RecordSetList SelectStmt3 SelectStmt4 SelectStmt5 SelectStmt6 SelectStmt7
  169 Start: . StatementList
  170 Statement: . EmptyStmt
  171          | . AlterTableStmt
  172          | . BeginTransactionStmt
  173          | . CommitStmt
  174          | . CreateIndexStmt
  175          | . CreateTableStmt
  176          | . DeleteFromStmt
  177          | . DropIndexStmt
  178          | . DropTableStmt
  179          | . InsertIntoStmt
  180          | . RollbackStmt
  181          | . SelectStmt
  182          | . TruncateTableStmt
  183          | . UpdateStmt
  184 StatementList: . Statement StatementList1
  191 TruncateTableStmt: . _TRUNCATE _TABLE TableName
  223 UpdateStmt: . _UPDATE TableName UpdateStmt1 AssignmentList UpdateStmt2

    _ALTER     shift, and go to state 1
    _BEGIN     shift, and go to state 2
    _COMMIT    shift, and go to state 3
    _CREATE    shift, and go to state 4
    _DELETE    shift, and go to state 5
    _DROP      shift, and go to state 6
    _INSERT    shift, and go to state 7
    _ROLLBACK  shift, and go to state 8
    _SELECT    shift, and go to state 9
    _TRUNCATE  shift, and go to state 10
    _UPDATE    shift, and go to state 11

    $default  reduce using rule 46 (EmptyStmt)

    AlterTableStmt        go to state 12
    BeginTransactionStmt  go to state 13
    CommitStmt            go to state 14
    CreateIndexStmt       go to state 15
    CreateTableStmt       go to state 16
    DeleteFromStmt        go to state 17
    DropIndexStmt         go to state 18
    DropTableStmt         go to state 19
    EmptyStmt             go to state 20
    InsertIntoStmt        go to state 21
    RollbackStmt          go to state 22
    SelectStmt            go to state 23
    Start                 go to state 24
    Statement             go to state 25
    StatementList         go to state 26
    TruncateTableStmt     go to state 27
    UpdateStmt            go to state 28


state 1

    1 AlterTableStmt: _ALTER . _TABLE TableName AlterTableStmt1

    _TABLE  shift, and go to state 29


state 2

   10 BeginTransactionStmt: _BEGIN . _TRANSACTION

    _TRANSACTION  shift, and go to state 30


state 3

   21 CommitStmt: _COMMIT .

    $default  reduce using rule 21 (CommitStmt)


state 4

   23 CreateIndexStmt: _CREATE . CreateIndexStmt1 _INDEX CreateIndexStmt2 IndexName _ON TableName '(' CreateIndexStmt3 ')'
   24 CreateIndexStmt1: .  [_INDEX]
   25                 | . _UNIQUE
   30 CreateTableStmt: _CREATE . _TABLE CreateTableStmt1 TableName '(' ColumnDef CreateTableStmt2 CreateTableStmt3 ')'

    _TABLE   shift, and go to state 31
    _UNIQUE  shift, and go to state 32

    $default  reduce using rule 24 (CreateIndexStmt1)

    CreateIndexStmt1  go to state 33


state 5

   37 DeleteFromStmt: _DELETE . _FROM TableName DeleteFromStmt1

    _FROM  shift, and go to state 34


state 6

   40 DropIndexStmt: _DROP . _INDEX DropIndexStmt1 IndexName
   43 DropTableStmt: _DROP . _TABLE DropTableStmt1 TableName

    _INDEX  shift, and go to state 35
    _TABLE  shift, and go to state 36


state 7

   78 InsertIntoStmt: _INSERT . _INTO TableName InsertIntoStmt1 InsertIntoStmt2

    _INTO  shift, and go to state 37


state 8

  148 RollbackStmt: _ROLLBACK .

    $default  reduce using rule 148 (RollbackStmt)


state 9

  149 SelectStmt: _SELECT . SelectStmt1 SelectStmt2 _FROM RecordSetList SelectStmt3 SelectStmt4 SelectStmt5 SelectStmt6 SelectStmt7
  150 SelectStmt1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(', '^', '-', '+', '*', '!']
  151            | . _DISTINCT

    _DISTINCT  shift, and go to state 38

    $default  reduce using rule 150 (SelectStmt1)

    SelectStmt1  go to state 39


state 10

  191 TruncateTableStmt: _TRUNCATE . _TABLE TableName

    _TABLE  shift, and go to state 40


state 11

  187 TableName: . _IDENTIFIER
  223 UpdateStmt: _UPDATE . TableName UpdateStmt1 AssignmentList UpdateStmt2

    _IDENTIFIER  shift, and go to state 41

    TableName  go to state 42


state 12

  171 Statement: AlterTableStmt .

    $default  reduce using rule 171 (Statement)


state 13

  172 Statement: BeginTransactionStmt .

    $default  reduce using rule 172 (Statement)


state 14

  173 Statement: CommitStmt .

    $default  reduce using rule 173 (Statement)


state 15

  174 Statement: CreateIndexStmt .

    $default  reduce using rule 174 (Statement)


state 16

  175 Statement: CreateTableStmt .

    $default  reduce using rule 175 (Statement)


state 17

  176 Statement: DeleteFromStmt .

    $default  reduce using rule 176 (Statement)


state 18

  177 Statement: DropIndexStmt .

    $default  reduce using rule 177 (Statement)


state 19

  178 Statement: DropTableStmt .

    $default  reduce using rule 178 (Statement)


state 20

  170 Statement: EmptyStmt .

    $default  reduce using rule 170 (Statement)


state 21

  179 Statement: InsertIntoStmt .

    $default  reduce using rule 179 (Statement)


state 22

  180 Statement: RollbackStmt .

    $default  reduce using rule 180 (Statement)


state 23

  181 Statement: SelectStmt .

    $default  reduce using rule 181 (Statement)


state 24

    0 $accept: Start . $end

    $end  shift, and go to state 43


state 25

  184 StatementList: Statement . StatementList1
  185 StatementList1: .
  186               | . StatementList1 ';' Statement

    $default  reduce using rule 185 (StatementList1)

    StatementList1  go to state 44


state 26

  169 Start: StatementList .

    $default  reduce using rule 169 (Start)


state 27

  182 Statement: TruncateTableStmt .

    $default  reduce using rule 182 (Statement)


state 28

  183 Statement: UpdateStmt .

    $default  reduce using rule 183 (Statement)


state 29

    1 AlterTableStmt: _ALTER _TABLE . TableName AlterTableStmt1
  187 TableName: . _IDENTIFIER

    _IDENTIFIER  shift, and go to state 41

    TableName  go to state 45


state 30

   10 BeginTransactionStmt: _BEGIN _TRANSACTION .

    $default  reduce using rule 10 (BeginTransactionStmt)


state 31

   30 CreateTableStmt: _CREATE _TABLE . CreateTableStmt1 TableName '(' ColumnDef CreateTableStmt2 CreateTableStmt3 ')'
   31 CreateTableStmt1: .  [_IDENTIFIER]
   32                 | . _IF _NOT _EXISTS

    _IF  shift, and go to state 46

    $default  reduce using rule 31 (CreateTableStmt1)

    CreateTableStmt1  go to state 47


state 32

   25 CreateIndexStmt1: _UNIQUE .

    $default  reduce using rule 25 (CreateIndexStmt1)


state 33

   23 CreateIndexStmt: _CREATE CreateIndexStmt1 . _INDEX CreateIndexStmt2 IndexName _ON TableName '(' CreateIndexStmt3 ')'

    _INDEX  shift, and go to state 48


state 34

   37 DeleteFromStmt: _DELETE _FROM . TableName DeleteFromStmt1
  187 TableName: . _IDENTIFIER

    _IDENTIFIER  shift, and go to state 41

    TableName  go to state 49


state 35

   40 DropIndexStmt: _DROP _INDEX . DropIndexStmt1 IndexName
   41 DropIndexStmt1: .  [_IDENTIFIER]
   42               | . _IF _EXISTS

    _IF  shift, and go to state 50

    $default  reduce using rule 41 (DropIndexStmt1)

    DropIndexStmt1  go to state 51


state 36

   43 DropTableStmt: _DROP _TABLE . DropTableStmt1 TableName
   44 DropTableStmt1: .  [_IDENTIFIER]
   45               | . _IF _EXISTS

    _IF  shift, and go to state 52

    $default  reduce using rule 44 (DropTableStmt1)

    DropTableStmt1  go to state 53


state 37

   78 InsertIntoStmt: _INSERT _INTO . TableName InsertIntoStmt1 InsertIntoStmt2
  187 TableName: . _IDENTIFIER

    _IDENTIFIER  shift, and go to state 41

    TableName  go to state 54


state 38

  151 SelectStmt1: _DISTINCT .

    $default  reduce using rule 151 (SelectStmt1)


state 39

   47 Expression: . Term Expression1
   55 Factor: . PrimaryFactor Factor1 Factor2
   67 Field: . Expression Field1
   70 FieldList: . Field FieldList1 FieldList2
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  149 SelectStmt: _SELECT SelectStmt1 . SelectStmt2 _FROM RecordSetList SelectStmt3 SelectStmt4 SelectStmt5 SelectStmt6 SelectStmt7
  152 SelectStmt2: . '*'
  153            | . FieldList
  188 Term: . Factor Term1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '*'  shift, and go to state 58
    '!'  shift, and go to state 59

    $default  reduce using rule 217 (UnaryExpr1)

    Expression     go to state 60
    Factor         go to state 61
    Field          go to state 62
    FieldList      go to state 63
    PrimaryFactor  go to state 64
    PrimaryTerm    go to state 65
    SelectStmt2    go to state 66
    Term           go to state 67
    UnaryExpr      go to state 68
    UnaryExpr1     go to state 69
    UnaryExpr11    go to state 70


state 40

  187 TableName: . _IDENTIFIER
  191 TruncateTableStmt: _TRUNCATE _TABLE . TableName

    _IDENTIFIER  shift, and go to state 41

    TableName  go to state 71


state 41

  187 TableName: _IDENTIFIER .

    $default  reduce using rule 187 (TableName)


state 42

  223 UpdateStmt: _UPDATE TableName . UpdateStmt1 AssignmentList UpdateStmt2
  224 UpdateStmt1: .  [_IDENTIFIER]
  225            | . _SET

    _SET  shift, and go to state 72

    $default  reduce using rule 224 (UpdateStmt1)

    UpdateStmt1  go to state 73


state 43

    0 $accept: Start $end .

    $default  accept


state 44

  184 StatementList: Statement StatementList1 .  [$end]
  186 StatementList1: StatementList1 . ';' Statement

    ';'  shift, and go to state 74

    $default  reduce using rule 184 (StatementList)


state 45

    1 AlterTableStmt: _ALTER _TABLE TableName . AlterTableStmt1
    2 AlterTableStmt1: . _ADD ColumnDef
    3                | . _DROP _COLUMN ColumnName

    _ADD   shift, and go to state 75
    _DROP  shift, and go to state 76

    AlterTableStmt1  go to state 77


state 46

   32 CreateTableStmt1: _IF . _NOT _EXISTS

    _NOT  shift, and go to state 78


state 47

   30 CreateTableStmt: _CREATE _TABLE CreateTableStmt1 . TableName '(' ColumnDef CreateTableStmt2 CreateTableStmt3 ')'
  187 TableName: . _IDENTIFIER

    _IDENTIFIER  shift, and go to state 41

    TableName  go to state 79


state 48

   23 CreateIndexStmt: _CREATE CreateIndexStmt1 _INDEX . CreateIndexStmt2 IndexName _ON TableName '(' CreateIndexStmt3 ')'
   26 CreateIndexStmt2: .  [_IDENTIFIER]
   27                 | . _IF _NOT _EXISTS

    _IF  shift, and go to state 80

    $default  reduce using rule 26 (CreateIndexStmt2)

    CreateIndexStmt2  go to state 81


state 49

   37 DeleteFromStmt: _DELETE _FROM TableName . DeleteFromStmt1
   38 DeleteFromStmt1: .  [$end, ';']
   39                | . WhereClause
  233 WhereClause: . _WHERE Expression

    _WHERE  shift, and go to state 82

    $default  reduce using rule 38 (DeleteFromStmt1)

    DeleteFromStmt1  go to state 83
    WhereClause      go to state 84


state 50

   42 DropIndexStmt1: _IF . _EXISTS

    _EXISTS  shift, and go to state 85


state 51

   40 DropIndexStmt: _DROP _INDEX DropIndexStmt1 . IndexName
   77 IndexName: . _IDENTIFIER

    _IDENTIFIER  shift, and go to state 86

    IndexName  go to state 87


state 52

   45 DropTableStmt1: _IF . _EXISTS

    _EXISTS  shift, and go to state 88


state 53

   43 DropTableStmt: _DROP _TABLE DropTableStmt1 . TableName
  187 TableName: . _IDENTIFIER

    _IDENTIFIER  shift, and go to state 41

    TableName  go to state 89


state 54

   78 InsertIntoStmt: _INSERT _INTO TableName . InsertIntoStmt1 InsertIntoStmt2
   79 InsertIntoStmt1: .  [_SELECT, _VALUES]
   80                | . '(' ColumnNameList ')'

    '('  shift, and go to state 90

    $default  reduce using rule 79 (InsertIntoStmt1)

    InsertIntoStmt1  go to state 91


state 55

  219 UnaryExpr11: '^' .

    $default  reduce using rule 219 (UnaryExpr11)


state 56

  221 UnaryExpr11: '-' .

    $default  reduce using rule 221 (UnaryExpr11)


state 57

  222 UnaryExpr11: '+' .

    $default  reduce using rule 222 (UnaryExpr11)


state 58

  152 SelectStmt2: '*' .

    $default  reduce using rule 152 (SelectStmt2)


state 59

  220 UnaryExpr11: '!' .

    $default  reduce using rule 220 (UnaryExpr11)


state 60

   67 Field: Expression . Field1
   68 Field1: .  [_FROM, ',']
   69       | . _AS _IDENTIFIER

    _AS  shift, and go to state 92

    $default  reduce using rule 68 (Field1)

    Field1  go to state 93


state 61

  188 Term: Factor . Term1
  189 Term1: .
  190      | . Term1 _ANDAND Factor

    $default  reduce using rule 189 (Term1)

    Term1  go to state 94


state 62

   70 FieldList: Field . FieldList1 FieldList2
   71 FieldList1: .
   72           | . FieldList1 ',' Field

    $default  reduce using rule 71 (FieldList1)

    FieldList1  go to state 95


state 63

  153 SelectStmt2: FieldList .

    $default  reduce using rule 153 (SelectStmt2)


state 64

   55 Factor: PrimaryFactor . Factor1 Factor2
   56 Factor1: .
   57        | . Factor1 Factor11 PrimaryFactor

    $default  reduce using rule 56 (Factor1)

    Factor1  go to state 96


state 65

  116 PrimaryFactor: PrimaryTerm . PrimaryFactor1
  117 PrimaryFactor1: .
  118               | . PrimaryFactor1 PrimaryFactor11 PrimaryTerm

    $default  reduce using rule 117 (PrimaryFactor1)

    PrimaryFactor1  go to state 97


state 66

  149 SelectStmt: _SELECT SelectStmt1 SelectStmt2 . _FROM RecordSetList SelectStmt3 SelectStmt4 SelectStmt5 SelectStmt6 SelectStmt7

    _FROM  shift, and go to state 98


state 67

   47 Expression: Term . Expression1
   48 Expression1: .
   49            | . Expression1 _OROR Term

    $default  reduce using rule 48 (Expression1)

    Expression1  go to state 99


state 68

  123 PrimaryTerm: UnaryExpr . PrimaryTerm1
  124 PrimaryTerm1: .
  125             | . PrimaryTerm1 PrimaryTerm11 UnaryExpr

    $default  reduce using rule 124 (PrimaryTerm1)

    PrimaryTerm1  go to state 100


state 69

   22 Conversion: . Type '(' Expression ')'
   84 Literal: . _FALSE
   85        | . _NULL
   86        | . _TRUE
   87        | . _FLOAT_LIT
   88        | . _IMAGINARY_LIT
   89        | . _INT_LIT
   90        | . _RUNE_LIT
   91        | . _STRING_LIT
   92        | . _QL_PARAMETER
   94 Operand: . Literal
   95        | . QualifiedIdent
   96        | . '(' Expression ')'
  111 PrimaryExpression: . Operand
  112                  | . Conversion
  113                  | . PrimaryExpression Index
  114                  | . PrimaryExpression Slice
  115                  | . PrimaryExpression Call
  133 QualifiedIdent: . _IDENTIFIER QualifiedIdent1
  192 Type: . _BIGINT
  193     | . _BIGRAT
  194     | . _BLOB
  195     | . _BOOL
  196     | . _BYTE
  197     | . _COMPLEX128
  198     | . _COMPLEX64
  199     | . _DURATION
  200     | . _FLOAT
  201     | . _FLOAT32
  202     | . _FLOAT64
  203     | . _INT
  204     | . _INT16
  205     | . _INT32
  206     | . _INT64
  207     | . _INT8
  208     | . _RUNE
  209     | . _STRING
  210     | . _TIME
  211     | . _UINT
  212     | . _UINT16
  213     | . _UINT32
  214     | . _UINT64
  215     | . _UINT8
  216 UnaryExpr: UnaryExpr1 . PrimaryExpression

    _FLOAT_LIT      shift, and go to state 101
    _IDENTIFIER     shift, and go to state 102
    _IMAGINARY_LIT  shift, and go to state 103
    _INT_LIT        shift, and go to state 104
    _QL_PARAMETER   shift, and go to state 105
    _RUNE_LIT       shift, and go to state 106
    _STRING_LIT     shift, and go to state 107
    _BIGINT         shift, and go to state 108
    _BIGRAT         shift, and go to state 109
    _BLOB           shift, and go to state 110
    _BOOL           shift, and go to state 111
    _BYTE           shift, and go to state 112
    _COMPLEX128     shift, and go to state 113
    _COMPLEX64      shift, and go to state 114
    _DURATION       shift, and go to state 115
    _FALSE          shift, and go to state 116
    _FLOAT          shift, and go to state 117
    _FLOAT32        shift, and go to state 118
    _FLOAT64        shift, and go to state 119
    _INT            shift, and go to state 120
    _INT16          shift, and go to state 121
    _INT32          shift, and go to state 122
    _INT64          shift, and go to state 123
    _INT8           shift, and go to state 124
    _NULL           shift, and go to state 125
    _RUNE           shift, and go to state 126
    _STRING         shift, and go to state 127
    _TIME           shift, and go to state 128
    _TRUE           shift, and go to state 129
    _UINT           shift, and go to state 130
    _UINT16         shift, and go to state 131
    _UINT32         shift, and go to state 132
    _UINT64         shift, and go to state 133
    _UINT8          shift, and go to state 134
    '('             shift, and go to state 135

    Conversion         go to state 136
    Literal            go to state 137
    Operand            go to state 138
    PrimaryExpression  go to state 139
    QualifiedIdent     go to state 140
    Type               go to state 141


state 70

  218 UnaryExpr1: UnaryExpr11 .

    $default  reduce using rule 218 (UnaryExpr1)


state 71

  191 TruncateTableStmt: _TRUNCATE _TABLE TableName .

    $default  reduce using rule 191 (TruncateTableStmt)


state 72

  225 UpdateStmt1: _SET .

    $default  reduce using rule 225 (UpdateStmt1)


state 73

    4 Assignment: . ColumnName '=' Expression
    5 AssignmentList: . Assignment AssignmentList1 AssignmentList2
   15 ColumnName: . _IDENTIFIER
  223 UpdateStmt: _UPDATE TableName UpdateStmt1 . AssignmentList UpdateStmt2

    _IDENTIFIER  shift, and go to state 142

    Assignment      go to state 143
    AssignmentList  go to state 144
    ColumnName      go to state 145


state 74

    1 AlterTableStmt: . _ALTER _TABLE TableName AlterTableStmt1
   10 BeginTransactionStmt: . _BEGIN _TRANSACTION
   21 CommitStmt: . _COMMIT
   23 CreateIndexStmt: . _CREATE CreateIndexStmt1 _INDEX CreateIndexStmt2 IndexName _ON TableName '(' CreateIndexStmt3 ')'
   30 CreateTableStmt: . _CREATE _TABLE CreateTableStmt1 TableName '(' ColumnDef CreateTableStmt2 CreateTableStmt3 ')'
   37 DeleteFromStmt: . _DELETE _FROM TableName DeleteFromStmt1
   40 DropIndexStmt: . _DROP _INDEX DropIndexStmt1 IndexName
   43 DropTableStmt: . _DROP _TABLE DropTableStmt1 TableName
   46 EmptyStmt: .  [$end, ';']
   78 InsertIntoStmt: . _INSERT _INTO TableName InsertIntoStmt1 InsertIntoStmt2
  148 RollbackStmt: . _ROLLBACK
  149 SelectStmt: . _SELECT SelectStmt1 SelectStmt2 _FROM RecordSetList SelectStmt3 SelectStmt4 SelectStmt5 SelectStmt6 SelectStmt7
  170 Statement: . EmptyStmt
  171          | . AlterTableStmt
  172          | . BeginTransactionStmt
  173          | . CommitStmt
  174          | . CreateIndexStmt
  175          | . CreateTableStmt
  176          | . DeleteFromStmt
  177          | . DropIndexStmt
  178          | . DropTableStmt
  179          | . InsertIntoStmt
  180          | . RollbackStmt
  181          | . SelectStmt
  182          | . TruncateTableStmt
  183          | . UpdateStmt
  186 StatementList1: StatementList1 ';' . Statement
  191 TruncateTableStmt: . _TRUNCATE _TABLE TableName
  223 UpdateStmt: . _UPDATE TableName UpdateStmt1 AssignmentList UpdateStmt2

    _ALTER     shift, and go to state 1
    _BEGIN     shift, and go to state 2
    _COMMIT    shift, and go to state 3
    _CREATE    shift, and go to state 4
    _DELETE    shift, and go to state 5
    _DROP      shift, and go to state 6
    _INSERT    shift, and go to state 7
    _ROLLBACK  shift, and go to state 8
    _SELECT    shift, and go to state 9
    _TRUNCATE  shift, and go to state 10
    _UPDATE    shift, and go to state 11

    $default  reduce using rule 46 (EmptyStmt)

    AlterTableStmt        go to state 12
    BeginTransactionStmt  go to state 13
    CommitStmt            go to state 14
    CreateIndexStmt       go to state 15
    CreateTableStmt       go to state 16
    DeleteFromStmt        go to state 17
    DropIndexStmt         go to state 18
    DropTableStmt         go to state 19
    EmptyStmt             go to state 20
    InsertIntoStmt        go to state 21
    RollbackStmt          go to state 22
    SelectStmt            go to state 23
    Statement             go to state 146
    TruncateTableStmt     go to state 27
    UpdateStmt            go to state 28


state 75

    2 AlterTableStmt1: _ADD . ColumnDef
   14 ColumnDef: . ColumnName Type
   15 ColumnName: . _IDENTIFIER

    _IDENTIFIER  shift, and go to state 142

    ColumnDef   go to state 147
    ColumnName  go to state 148


state 76

    3 AlterTableStmt1: _DROP . _COLUMN ColumnName

    _COLUMN  shift, and go to state 149


state 77

    1 AlterTableStmt: _ALTER _TABLE TableName AlterTableStmt1 .

    $default  reduce using rule 1 (AlterTableStmt)


state 78

   32 CreateTableStmt1: _IF _NOT . _EXISTS

    _EXISTS  shift, and go to state 150


state 79

   30 CreateTableStmt: _CREATE _TABLE CreateTableStmt1 TableName . '(' ColumnDef CreateTableStmt2 CreateTableStmt3 ')'

    '('  shift, and go to state 151


state 80

   27 CreateIndexStmt2: _IF . _NOT _EXISTS

    _NOT  shift, and go to state 152


state 81

   23 CreateIndexStmt: _CREATE CreateIndexStmt1 _INDEX CreateIndexStmt2 . IndexName _ON TableName '(' CreateIndexStmt3 ')'
   77 IndexName: . _IDENTIFIER

    _IDENTIFIER  shift, and go to state 86

    IndexName  go to state 153


state 82

   47 Expression: . Term Expression1
   55 Factor: . PrimaryFactor Factor1 Factor2
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  188 Term: . Factor Term1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'
  233 WhereClause: _WHERE . Expression

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    $default  reduce using rule 217 (UnaryExpr1)

    Expression     go to state 154
    Factor         go to state 61
    PrimaryFactor  go to state 64
    PrimaryTerm    go to state 65
    Term           go to state 67
    UnaryExpr      go to state 68
    UnaryExpr1     go to state 69
    UnaryExpr11    go to state 70


state 83

   37 DeleteFromStmt: _DELETE _FROM TableName DeleteFromStmt1 .

    $default  reduce using rule 37 (DeleteFromStmt)


state 84

   39 DeleteFromStmt1: WhereClause .

    $default  reduce using rule 39 (DeleteFromStmt1)


state 85

   42 DropIndexStmt1: _IF _EXISTS .

    $default  reduce using rule 42 (DropIndexStmt1)


state 86

   77 IndexName: _IDENTIFIER .

    $default  reduce using rule 77 (IndexName)


state 87

   40 DropIndexStmt: _DROP _INDEX DropIndexStmt1 IndexName .

    $default  reduce using rule 40 (DropIndexStmt)


state 88

   45 DropTableStmt1: _IF _EXISTS .

    $default  reduce using rule 45 (DropTableStmt1)


state 89

   43 DropTableStmt: _DROP _TABLE DropTableStmt1 TableName .

    $default  reduce using rule 43 (DropTableStmt)


state 90

   15 ColumnName: . _IDENTIFIER
   16 ColumnNameList: . ColumnName ColumnNameList1 ColumnNameList2
   80 InsertIntoStmt1: '(' . ColumnNameList ')'

    _IDENTIFIER  shift, and go to state 142

    ColumnName      go to state 155
    ColumnNameList  go to state 156


state 91

   78 InsertIntoStmt: _INSERT _INTO TableName InsertIntoStmt1 . InsertIntoStmt2
   81 InsertIntoStmt2: . Values
   82                | . SelectStmt
  149 SelectStmt: . _SELECT SelectStmt1 SelectStmt2 _FROM RecordSetList SelectStmt3 SelectStmt4 SelectStmt5 SelectStmt6 SelectStmt7
  228 Values: . _VALUES '(' ExpressionList ')' Values1 Values2

    _SELECT  shift, and go to state 9
    _VALUES  shift, and go to state 157

    InsertIntoStmt2  go to state 158
    SelectStmt       go to state 159
    Values           go to state 160


state 92

   69 Field1: _AS . _IDENTIFIER

    _IDENTIFIER  shift, and go to state 161


state 93

   67 Field: Expression Field1 .

    $default  reduce using rule 67 (Field)


state 94

  188 Term: Factor Term1 .  [$end, _OROR, _AS, _ASC, _DESC, _FROM, _GROUPBY, _LIMIT, _OFFSET, _ORDER, _WHERE, ',', ')', ']', ';', ':']
  190 Term1: Term1 . _ANDAND Factor

    _ANDAND  shift, and go to state 162

    $default  reduce using rule 188 (Term)


state 95

   70 FieldList: Field FieldList1 . FieldList2
   72 FieldList1: FieldList1 . ',' Field
   73 FieldList2: .  [_FROM]
   74           | . ','

    ','  shift, and go to state 163

    $default  reduce using rule 73 (FieldList2)

    FieldList2  go to state 164


state 96

   55 Factor: PrimaryFactor Factor1 . Factor2
   57 Factor1: Factor1 . Factor11 PrimaryFactor
   58 Factor11: . _GE
   59         | . '>'
   60         | . _LE
   61         | . '<'
   62         | . _NEQ
   63         | . _EQ
   64         | . _LIKE
   65 Factor2: .  [$end, _ANDAND, _OROR, _AS, _ASC, _DESC, _FROM, _GROUPBY, _LIMIT, _OFFSET, _ORDER, _WHERE, ',', ')', ']', ';', ':']
   66        | . Predicate
  102 Predicate: . Predicate1
  103 Predicate1: . Predicate11 Predicate12
  104           | . _IS Predicate13 _NULL
  105 Predicate11: .  [_BETWEEN, _IN]
  106            | . _NOT

    _EQ    shift, and go to state 165
    _GE    shift, and go to state 166
    _LE    shift, and go to state 167
    _NEQ   shift, and go to state 168
    _IS    shift, and go to state 169
    _LIKE  shift, and go to state 170
    _NOT   shift, and go to state 171
    '>'    shift, and go to state 172
    '<'    shift, and go to state 173

    _BETWEEN  reduce using rule 105 (Predicate11)
    _IN       reduce using rule 105 (Predicate11)
    $default  reduce using rule 65 (Factor2)

    Factor11     go to state 174
    Factor2      go to state 175
    Predicate    go to state 176
    Predicate1   go to state 177
    Predicate11  go to state 178


state 97

  116 PrimaryFactor: PrimaryTerm PrimaryFactor1 .  [$end, _ANDAND, _EQ, _GE, _LE, _NEQ, _OROR, _AND, _AS, _ASC, _BETWEEN, _DESC, _FROM, _GROUPBY, _IN, _IS, _LIKE, _LIMIT, _NOT, _OFFSET, _ORDER, _WHERE, ',', ')', '>', '<', ']', ';', ':']
  118 PrimaryFactor1: PrimaryFactor1 . PrimaryFactor11 PrimaryTerm
  119 PrimaryFactor11: . '^'
  120                | . '|'
  121                | . '-'
  122                | . '+'

    '^'  shift, and go to state 179
    '|'  shift, and go to state 180
    '-'  shift, and go to state 181
    '+'  shift, and go to state 182

    $default  reduce using rule 116 (PrimaryFactor)

    PrimaryFactor11  go to state 183


state 98

  136 RecordSet: . RecordSet1 RecordSet2
  137 RecordSet1: . TableName
  138           | . '(' SelectStmt RecordSet11 ')'
  143 RecordSetList: . RecordSet RecordSetList1 RecordSetList2
  149 SelectStmt: _SELECT SelectStmt1 SelectStmt2 _FROM . RecordSetList SelectStmt3 SelectStmt4 SelectStmt5 SelectStmt6 SelectStmt7
  187 TableName: . _IDENTIFIER

    _IDENTIFIER  shift, and go to state 41
    '('          shift, and go to state 184

    RecordSet      go to state 185
    RecordSet1     go to state 186
    RecordSetList  go to state 187
    TableName      go to state 188


state 99

   47 Expression: Term Expression1 .  [$end, _AS, _ASC, _DESC, _FROM, _GROUPBY, _LIMIT, _OFFSET, _ORDER, _WHERE, ',', ')', ']', ';', ':']
   49 Expression1: Expression1 . _OROR Term

    _OROR  shift, and go to state 189

    $default  reduce using rule 47 (Expression)


state 100

  123 PrimaryTerm: UnaryExpr PrimaryTerm1 .  [$end, _ANDAND, _EQ, _GE, _LE, _NEQ, _OROR, _AND, _AS, _ASC, _BETWEEN, _DESC, _FROM, _GROUPBY, _IN, _IS, _LIKE, _LIMIT, _NOT, _OFFSET, _ORDER, _WHERE, ',', ')', '>', '<', ']', '^', '|', '-', '+', ';', ':']
  125 PrimaryTerm1: PrimaryTerm1 . PrimaryTerm11 UnaryExpr
  126 PrimaryTerm11: . _ANDNOT
  127              | . '&'
  128              | . _LSH
  129              | . _RSH
  130              | . '%'
  131              | . '/'
  132              | . '*'

    _ANDNOT  shift, and go to state 190
    _LSH     shift, and go to state 191
    _RSH     shift, and go to state 192
    '&'      shift, and go to state 193
    '%'      shift, and go to state 194
    '/'      shift, and go to state 195
    '*'      shift, and go to state 196

    $default  reduce using rule 123 (PrimaryTerm)

    PrimaryTerm11  go to state 197


state 101

   87 Literal: _FLOAT_LIT .

    $default  reduce using rule 87 (Literal)


state 102

  133 QualifiedIdent: _IDENTIFIER . QualifiedIdent1
  134 QualifiedIdent1: .  [$end, _ANDAND, _ANDNOT, _EQ, _GE, _LE, _LSH, _NEQ, _OROR, _RSH, _AND, _AS, _ASC, _BETWEEN, _DESC, _FROM, _GROUPBY, _IN, _IS, _LIKE, _LIMIT, _NOT, _OFFSET, _ORDER, _WHERE, ',', '(', ')', '>', '<', '[', ']', '^', '|', '-', '+', '&', '%', '/', '*', ';', ':']
  135                | . '.' _IDENTIFIER

    '.'  shift, and go to state 198

    $default  reduce using rule 134 (QualifiedIdent1)

    QualifiedIdent1  go to state 199


state 103

   88 Literal: _IMAGINARY_LIT .

    $default  reduce using rule 88 (Literal)


state 104

   89 Literal: _INT_LIT .

    $default  reduce using rule 89 (Literal)


state 105

   92 Literal: _QL_PARAMETER .

    $default  reduce using rule 92 (Literal)


state 106

   90 Literal: _RUNE_LIT .

    $default  reduce using rule 90 (Literal)


state 107

   91 Literal: _STRING_LIT .

    $default  reduce using rule 91 (Literal)


state 108

  192 Type: _BIGINT .

    $default  reduce using rule 192 (Type)


state 109

  193 Type: _BIGRAT .

    $default  reduce using rule 193 (Type)


state 110

  194 Type: _BLOB .

    $default  reduce using rule 194 (Type)


state 111

  195 Type: _BOOL .

    $default  reduce using rule 195 (Type)


state 112

  196 Type: _BYTE .

    $default  reduce using rule 196 (Type)


state 113

  197 Type: _COMPLEX128 .

    $default  reduce using rule 197 (Type)


state 114

  198 Type: _COMPLEX64 .

    $default  reduce using rule 198 (Type)


state 115

  199 Type: _DURATION .

    $default  reduce using rule 199 (Type)


state 116

   84 Literal: _FALSE .

    $default  reduce using rule 84 (Literal)


state 117

  200 Type: _FLOAT .

    $default  reduce using rule 200 (Type)


state 118

  201 Type: _FLOAT32 .

    $default  reduce using rule 201 (Type)


state 119

  202 Type: _FLOAT64 .

    $default  reduce using rule 202 (Type)


state 120

  203 Type: _INT .

    $default  reduce using rule 203 (Type)


state 121

  204 Type: _INT16 .

    $default  reduce using rule 204 (Type)


state 122

  205 Type: _INT32 .

    $default  reduce using rule 205 (Type)


state 123

  206 Type: _INT64 .

    $default  reduce using rule 206 (Type)


state 124

  207 Type: _INT8 .

    $default  reduce using rule 207 (Type)


state 125

   85 Literal: _NULL .

    $default  reduce using rule 85 (Literal)


state 126

  208 Type: _RUNE .

    $default  reduce using rule 208 (Type)


state 127

  209 Type: _STRING .

    $default  reduce using rule 209 (Type)


state 128

  210 Type: _TIME .

    $default  reduce using rule 210 (Type)


state 129

   86 Literal: _TRUE .

    $default  reduce using rule 86 (Literal)


state 130

  211 Type: _UINT .

    $default  reduce using rule 211 (Type)


state 131

  212 Type: _UINT16 .

    $default  reduce using rule 212 (Type)


state 132

  213 Type: _UINT32 .

    $default  reduce using rule 213 (Type)


state 133

  214 Type: _UINT64 .

    $default  reduce using rule 214 (Type)


state 134

  215 Type: _UINT8 .

    $default  reduce using rule 215 (Type)


state 135

   47 Expression: . Term Expression1
   55 Factor: . PrimaryFactor Factor1 Factor2
   96 Operand: '(' . Expression ')'
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  188 Term: . Factor Term1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    $default  reduce using rule 217 (UnaryExpr1)

    Expression     go to state 200
    Factor         go to state 61
    PrimaryFactor  go to state 64
    PrimaryTerm    go to state 65
    Term           go to state 67
    UnaryExpr      go to state 68
    UnaryExpr1     go to state 69
    UnaryExpr11    go to state 70


state 136

  112 PrimaryExpression: Conversion .

    $default  reduce using rule 112 (PrimaryExpression)


state 137

   94 Operand: Literal .

    $default  reduce using rule 94 (Operand)


state 138

  111 PrimaryExpression: Operand .

    $default  reduce using rule 111 (PrimaryExpression)


state 139

   11 Call: . '(' Call1 ')'
   76 Index: . '[' Expression ']'
  113 PrimaryExpression: PrimaryExpression . Index
  114                  | PrimaryExpression . Slice
  115                  | PrimaryExpression . Call
  164 Slice: . '[' Slice1 ':' Slice2 ']'
  216 UnaryExpr: UnaryExpr1 PrimaryExpression .  [$end, _ANDAND, _ANDNOT, _EQ, _GE, _LE, _LSH, _NEQ, _OROR, _RSH, _AND, _AS, _ASC, _BETWEEN, _DESC, _FROM, _GROUPBY, _IN, _IS, _LIKE, _LIMIT, _NOT, _OFFSET, _ORDER, _WHERE, ',', ')', '>', '<', ']', '^', '|', '-', '+', '&', '%', '/', '*', ';', ':']

    '('  shift, and go to state 201
    '['  shift, and go to state 202

    $default  reduce using rule 216 (UnaryExpr)

    Call   go to state 203
    Index  go to state 204
    Slice  go to state 205


state 140

   95 Operand: QualifiedIdent .

    $default  reduce using rule 95 (Operand)


state 141

   22 Conversion: Type . '(' Expression ')'

    '('  shift, and go to state 206


state 142

   15 ColumnName: _IDENTIFIER .

    $default  reduce using rule 15 (ColumnName)


state 143

    5 AssignmentList: Assignment . AssignmentList1 AssignmentList2
    6 AssignmentList1: .
    7                | . AssignmentList1 ',' Assignment

    $default  reduce using rule 6 (AssignmentList1)

    AssignmentList1  go to state 207


state 144

  223 UpdateStmt: _UPDATE TableName UpdateStmt1 AssignmentList . UpdateStmt2
  226 UpdateStmt2: .  [$end, ';']
  227            | . WhereClause
  233 WhereClause: . _WHERE Expression

    _WHERE  shift, and go to state 82

    $default  reduce using rule 226 (UpdateStmt2)

    UpdateStmt2  go to state 208
    WhereClause  go to state 209


state 145

    4 Assignment: ColumnName . '=' Expression

    '='  shift, and go to state 210


state 146

  186 StatementList1: StatementList1 ';' Statement .

    $default  reduce using rule 186 (StatementList1)


state 147

    2 AlterTableStmt1: _ADD ColumnDef .

    $default  reduce using rule 2 (AlterTableStmt1)


state 148

   14 ColumnDef: ColumnName . Type
  192 Type: . _BIGINT
  193     | . _BIGRAT
  194     | . _BLOB
  195     | . _BOOL
  196     | . _BYTE
  197     | . _COMPLEX128
  198     | . _COMPLEX64
  199     | . _DURATION
  200     | . _FLOAT
  201     | . _FLOAT32
  202     | . _FLOAT64
  203     | . _INT
  204     | . _INT16
  205     | . _INT32
  206     | . _INT64
  207     | . _INT8
  208     | . _RUNE
  209     | . _STRING
  210     | . _TIME
  211     | . _UINT
  212     | . _UINT16
  213     | . _UINT32
  214     | . _UINT64
  215     | . _UINT8

    _BIGINT      shift, and go to state 108
    _BIGRAT      shift, and go to state 109
    _BLOB        shift, and go to state 110
    _BOOL        shift, and go to state 111
    _BYTE        shift, and go to state 112
    _COMPLEX128  shift, and go to state 113
    _COMPLEX64   shift, and go to state 114
    _DURATION    shift, and go to state 115
    _FLOAT       shift, and go to state 117
    _FLOAT32     shift, and go to state 118
    _FLOAT64     shift, and go to state 119
    _INT         shift, and go to state 120
    _INT16       shift, and go to state 121
    _INT32       shift, and go to state 122
    _INT64       shift, and go to state 123
    _INT8        shift, and go to state 124
    _RUNE        shift, and go to state 126
    _STRING      shift, and go to state 127
    _TIME        shift, and go to state 128
    _UINT        shift, and go to state 130
    _UINT16      shift, and go to state 131
    _UINT32      shift, and go to state 132
    _UINT64      shift, and go to state 133
    _UINT8       shift, and go to state 134

    Type  go to state 211


state 149

    3 AlterTableStmt1: _DROP _COLUMN . ColumnName
   15 ColumnName: . _IDENTIFIER

    _IDENTIFIER  shift, and go to state 142

    ColumnName  go to state 212


state 150

   32 CreateTableStmt1: _IF _NOT _EXISTS .

    $default  reduce using rule 32 (CreateTableStmt1)


state 151

   14 ColumnDef: . ColumnName Type
   15 ColumnName: . _IDENTIFIER
   30 CreateTableStmt: _CREATE _TABLE CreateTableStmt1 TableName '(' . ColumnDef CreateTableStmt2 CreateTableStmt3 ')'

    _IDENTIFIER  shift, and go to state 142

    ColumnDef   go to state 213
    ColumnName  go to state 148


state 152

   27 CreateIndexStmt2: _IF _NOT . _EXISTS

    _EXISTS  shift, and go to state 214


state 153

   23 CreateIndexStmt: _CREATE CreateIndexStmt1 _INDEX CreateIndexStmt2 IndexName . _ON TableName '(' CreateIndexStmt3 ')'

    _ON  shift, and go to state 215


state 154

  233 WhereClause: _WHERE Expression .

    $default  reduce using rule 233 (WhereClause)


state 155

   16 ColumnNameList: ColumnName . ColumnNameList1 ColumnNameList2
   17 ColumnNameList1: .
   18                | . ColumnNameList1 ',' ColumnName

    $default  reduce using rule 17 (ColumnNameList1)

    ColumnNameList1  go to state 216


state 156

   80 InsertIntoStmt1: '(' ColumnNameList . ')'

    ')'  shift, and go to state 217


state 157

  228 Values: _VALUES . '(' ExpressionList ')' Values1 Values2

    '('  shift, and go to state 218


state 158

   78 InsertIntoStmt: _INSERT _INTO TableName InsertIntoStmt1 InsertIntoStmt2 .

    $default  reduce using rule 78 (InsertIntoStmt)


state 159

   82 InsertIntoStmt2: SelectStmt .

    $default  reduce using rule 82 (InsertIntoStmt2)


state 160

   81 InsertIntoStmt2: Values .

    $default  reduce using rule 81 (InsertIntoStmt2)


state 161

   69 Field1: _AS _IDENTIFIER .

    $default  reduce using rule 69 (Field1)


state 162

   55 Factor: . PrimaryFactor Factor1 Factor2
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  190 Term1: Term1 _ANDAND . Factor
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    $default  reduce using rule 217 (UnaryExpr1)

    Factor         go to state 219
    PrimaryFactor  go to state 64
    PrimaryTerm    go to state 65
    UnaryExpr      go to state 68
    UnaryExpr1     go to state 69
    UnaryExpr11    go to state 70


state 163

   47 Expression: . Term Expression1
   55 Factor: . PrimaryFactor Factor1 Factor2
   67 Field: . Expression Field1
   72 FieldList1: FieldList1 ',' . Field
   74 FieldList2: ',' .  [_FROM]
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  188 Term: . Factor Term1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    _FROM     reduce using rule 74 (FieldList2)
    $default  reduce using rule 217 (UnaryExpr1)

    Expression     go to state 60
    Factor         go to state 61
    Field          go to state 220
    PrimaryFactor  go to state 64
    PrimaryTerm    go to state 65
    Term           go to state 67
    UnaryExpr      go to state 68
    UnaryExpr1     go to state 69
    UnaryExpr11    go to state 70


state 164

   70 FieldList: Field FieldList1 FieldList2 .

    $default  reduce using rule 70 (FieldList)


state 165

   63 Factor11: _EQ .

    $default  reduce using rule 63 (Factor11)


state 166

   58 Factor11: _GE .

    $default  reduce using rule 58 (Factor11)


state 167

   60 Factor11: _LE .

    $default  reduce using rule 60 (Factor11)


state 168

   62 Factor11: _NEQ .

    $default  reduce using rule 62 (Factor11)


state 169

  104 Predicate1: _IS . Predicate13 _NULL
  109 Predicate13: .  [_NULL]
  110            | . _NOT

    _NOT  shift, and go to state 221

    $default  reduce using rule 109 (Predicate13)

    Predicate13  go to state 222


state 170

   64 Factor11: _LIKE .

    $default  reduce using rule 64 (Factor11)


state 171

  106 Predicate11: _NOT .

    $default  reduce using rule 106 (Predicate11)


state 172

   59 Factor11: '>' .

    $default  reduce using rule 59 (Factor11)


state 173

   61 Factor11: '<' .

    $default  reduce using rule 61 (Factor11)


state 174

   57 Factor1: Factor1 Factor11 . PrimaryFactor
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    $default  reduce using rule 217 (UnaryExpr1)

    PrimaryFactor  go to state 223
    PrimaryTerm    go to state 65
    UnaryExpr      go to state 68
    UnaryExpr1     go to state 69
    UnaryExpr11    go to state 70


state 175

   55 Factor: PrimaryFactor Factor1 Factor2 .

    $default  reduce using rule 55 (Factor)


state 176

   66 Factor2: Predicate .

    $default  reduce using rule 66 (Factor2)


state 177

  102 Predicate: Predicate1 .

    $default  reduce using rule 102 (Predicate)


state 178

  103 Predicate1: Predicate11 . Predicate12
  107 Predicate12: . _IN '(' ExpressionList ')'
  108            | . _BETWEEN PrimaryFactor _AND PrimaryFactor

    _BETWEEN  shift, and go to state 224
    _IN       shift, and go to state 225

    Predicate12  go to state 226


state 179

  119 PrimaryFactor11: '^' .

    $default  reduce using rule 119 (PrimaryFactor11)


state 180

  120 PrimaryFactor11: '|' .

    $default  reduce using rule 120 (PrimaryFactor11)


state 181

  121 PrimaryFactor11: '-' .

    $default  reduce using rule 121 (PrimaryFactor11)


state 182

  122 PrimaryFactor11: '+' .

    $default  reduce using rule 122 (PrimaryFactor11)


state 183

  118 PrimaryFactor1: PrimaryFactor1 PrimaryFactor11 . PrimaryTerm
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    $default  reduce using rule 217 (UnaryExpr1)

    PrimaryTerm  go to state 227
    UnaryExpr    go to state 68
    UnaryExpr1   go to state 69
    UnaryExpr11  go to state 70


state 184

  138 RecordSet1: '(' . SelectStmt RecordSet11 ')'
  149 SelectStmt: . _SELECT SelectStmt1 SelectStmt2 _FROM RecordSetList SelectStmt3 SelectStmt4 SelectStmt5 SelectStmt6 SelectStmt7

    _SELECT  shift, and go to state 9

    SelectStmt  go to state 228


state 185

  143 RecordSetList: RecordSet . RecordSetList1 RecordSetList2
  144 RecordSetList1: .
  145               | . RecordSetList1 ',' RecordSet

    $default  reduce using rule 144 (RecordSetList1)

    RecordSetList1  go to state 229


state 186

  136 RecordSet: RecordSet1 . RecordSet2
  141 RecordSet2: .  [$end, _GROUPBY, _LIMIT, _OFFSET, _ORDER, _WHERE, ',', ')', ';']
  142           | . _AS _IDENTIFIER

    _AS  shift, and go to state 230

    $default  reduce using rule 141 (RecordSet2)

    RecordSet2  go to state 231


state 187

  149 SelectStmt: _SELECT SelectStmt1 SelectStmt2 _FROM RecordSetList . SelectStmt3 SelectStmt4 SelectStmt5 SelectStmt6 SelectStmt7
  154 SelectStmt3: .  [$end, _GROUPBY, _LIMIT, _OFFSET, _ORDER, ')', ';']
  155            | . WhereClause
  233 WhereClause: . _WHERE Expression

    _WHERE  shift, and go to state 82

    $default  reduce using rule 154 (SelectStmt3)

    SelectStmt3  go to state 232
    WhereClause  go to state 233


state 188

  137 RecordSet1: TableName .

    $default  reduce using rule 137 (RecordSet1)


state 189

   49 Expression1: Expression1 _OROR . Term
   55 Factor: . PrimaryFactor Factor1 Factor2
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  188 Term: . Factor Term1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    $default  reduce using rule 217 (UnaryExpr1)

    Factor         go to state 61
    PrimaryFactor  go to state 64
    PrimaryTerm    go to state 65
    Term           go to state 234
    UnaryExpr      go to state 68
    UnaryExpr1     go to state 69
    UnaryExpr11    go to state 70


state 190

  126 PrimaryTerm11: _ANDNOT .

    $default  reduce using rule 126 (PrimaryTerm11)


state 191

  128 PrimaryTerm11: _LSH .

    $default  reduce using rule 128 (PrimaryTerm11)


state 192

  129 PrimaryTerm11: _RSH .

    $default  reduce using rule 129 (PrimaryTerm11)


state 193

  127 PrimaryTerm11: '&' .

    $default  reduce using rule 127 (PrimaryTerm11)


state 194

  130 PrimaryTerm11: '%' .

    $default  reduce using rule 130 (PrimaryTerm11)


state 195

  131 PrimaryTerm11: '/' .

    $default  reduce using rule 131 (PrimaryTerm11)


state 196

  132 PrimaryTerm11: '*' .

    $default  reduce using rule 132 (PrimaryTerm11)


state 197

  125 PrimaryTerm1: PrimaryTerm1 PrimaryTerm11 . UnaryExpr
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    $default  reduce using rule 217 (UnaryExpr1)

    UnaryExpr    go to state 235
    UnaryExpr1   go to state 69
    UnaryExpr11  go to state 70


state 198

  135 QualifiedIdent1: '.' . _IDENTIFIER

    _IDENTIFIER  shift, and go to state 236


state 199

  133 QualifiedIdent: _IDENTIFIER QualifiedIdent1 .

    $default  reduce using rule 133 (QualifiedIdent)


state 200

   96 Operand: '(' Expression . ')'

    ')'  shift, and go to state 237


state 201

   11 Call: '(' . Call1 ')'
   12 Call1: .  [')']
   13      | . ExpressionList
   47 Expression: . Term Expression1
   50 ExpressionList: . Expression ExpressionList1 ExpressionList2
   55 Factor: . PrimaryFactor Factor1 Factor2
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  188 Term: . Factor Term1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    ')'       reduce using rule 12 (Call1)
    $default  reduce using rule 217 (UnaryExpr1)

    Call1           go to state 238
    Expression      go to state 239
    ExpressionList  go to state 240
    Factor          go to state 61
    PrimaryFactor   go to state 64
    PrimaryTerm     go to state 65
    Term            go to state 67
    UnaryExpr       go to state 68
    UnaryExpr1      go to state 69
    UnaryExpr11     go to state 70


state 202

   47 Expression: . Term Expression1
   55 Factor: . PrimaryFactor Factor1 Factor2
   76 Index: '[' . Expression ']'
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  164 Slice: '[' . Slice1 ':' Slice2 ']'
  165 Slice1: .  [':']
  166       | . Expression
  188 Term: . Factor Term1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    ':'       reduce using rule 165 (Slice1)
    $default  reduce using rule 217 (UnaryExpr1)

    Expression     go to state 241
    Factor         go to state 61
    PrimaryFactor  go to state 64
    PrimaryTerm    go to state 65
    Slice1         go to state 242
    Term           go to state 67
    UnaryExpr      go to state 68
    UnaryExpr1     go to state 69
    UnaryExpr11    go to state 70


state 203

  115 PrimaryExpression: PrimaryExpression Call .

    $default  reduce using rule 115 (PrimaryExpression)


state 204

  113 PrimaryExpression: PrimaryExpression Index .

    $default  reduce using rule 113 (PrimaryExpression)


state 205

  114 PrimaryExpression: PrimaryExpression Slice .

    $default  reduce using rule 114 (PrimaryExpression)


state 206

   22 Conversion: Type '(' . Expression ')'
   47 Expression: . Term Expression1
   55 Factor: . PrimaryFactor Factor1 Factor2
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  188 Term: . Factor Term1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    $default  reduce using rule 217 (UnaryExpr1)

    Expression     go to state 243
    Factor         go to state 61
    PrimaryFactor  go to state 64
    PrimaryTerm    go to state 65
    Term           go to state 67
    UnaryExpr      go to state 68
    UnaryExpr1     go to state 69
    UnaryExpr11    go to state 70


state 207

    5 AssignmentList: Assignment AssignmentList1 . AssignmentList2
    7 AssignmentList1: AssignmentList1 . ',' Assignment
    8 AssignmentList2: .  [$end, _WHERE, ';']
    9                | . ','

    ','  shift, and go to state 244

    $default  reduce using rule 8 (AssignmentList2)

    AssignmentList2  go to state 245


state 208

  223 UpdateStmt: _UPDATE TableName UpdateStmt1 AssignmentList UpdateStmt2 .

    $default  reduce using rule 223 (UpdateStmt)


state 209

  227 UpdateStmt2: WhereClause .

    $default  reduce using rule 227 (UpdateStmt2)


state 210

    4 Assignment: ColumnName '=' . Expression
   47 Expression: . Term Expression1
   55 Factor: . PrimaryFactor Factor1 Factor2
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  188 Term: . Factor Term1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    $default  reduce using rule 217 (UnaryExpr1)

    Expression     go to state 246
    Factor         go to state 61
    PrimaryFactor  go to state 64
    PrimaryTerm    go to state 65
    Term           go to state 67
    UnaryExpr      go to state 68
    UnaryExpr1     go to state 69
    UnaryExpr11    go to state 70


state 211

   14 ColumnDef: ColumnName Type .

    $default  reduce using rule 14 (ColumnDef)


state 212

    3 AlterTableStmt1: _DROP _COLUMN ColumnName .

    $default  reduce using rule 3 (AlterTableStmt1)


state 213

   30 CreateTableStmt: _CREATE _TABLE CreateTableStmt1 TableName '(' ColumnDef . CreateTableStmt2 CreateTableStmt3 ')'
   33 CreateTableStmt2: .
   34                 | . CreateTableStmt2 ',' ColumnDef

    $default  reduce using rule 33 (CreateTableStmt2)

    CreateTableStmt2  go to state 247


state 214

   27 CreateIndexStmt2: _IF _NOT _EXISTS .

    $default  reduce using rule 27 (CreateIndexStmt2)


state 215

   23 CreateIndexStmt: _CREATE CreateIndexStmt1 _INDEX CreateIndexStmt2 IndexName _ON . TableName '(' CreateIndexStmt3 ')'
  187 TableName: . _IDENTIFIER

    _IDENTIFIER  shift, and go to state 41

    TableName  go to state 248


state 216

   16 ColumnNameList: ColumnName ColumnNameList1 . ColumnNameList2
   18 ColumnNameList1: ColumnNameList1 . ',' ColumnName
   19 ColumnNameList2: .  [$end, _LIMIT, _OFFSET, _ORDER, ')', ';']
   20                | . ','

    ','  shift, and go to state 249

    $default  reduce using rule 19 (ColumnNameList2)

    ColumnNameList2  go to state 250


state 217

   80 InsertIntoStmt1: '(' ColumnNameList ')' .

    $default  reduce using rule 80 (InsertIntoStmt1)


state 218

   47 Expression: . Term Expression1
   50 ExpressionList: . Expression ExpressionList1 ExpressionList2
   55 Factor: . PrimaryFactor Factor1 Factor2
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  188 Term: . Factor Term1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'
  228 Values: _VALUES '(' . ExpressionList ')' Values1 Values2

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    $default  reduce using rule 217 (UnaryExpr1)

    Expression      go to state 239
    ExpressionList  go to state 251
    Factor          go to state 61
    PrimaryFactor   go to state 64
    PrimaryTerm     go to state 65
    Term            go to state 67
    UnaryExpr       go to state 68
    UnaryExpr1      go to state 69
    UnaryExpr11     go to state 70


state 219

  190 Term1: Term1 _ANDAND Factor .

    $default  reduce using rule 190 (Term1)


state 220

   72 FieldList1: FieldList1 ',' Field .

    $default  reduce using rule 72 (FieldList1)


state 221

  110 Predicate13: _NOT .

    $default  reduce using rule 110 (Predicate13)


state 222

  104 Predicate1: _IS Predicate13 . _NULL

    _NULL  shift, and go to state 252


state 223

   57 Factor1: Factor1 Factor11 PrimaryFactor .

    $default  reduce using rule 57 (Factor1)


state 224

  108 Predicate12: _BETWEEN . PrimaryFactor _AND PrimaryFactor
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    $default  reduce using rule 217 (UnaryExpr1)

    PrimaryFactor  go to state 253
    PrimaryTerm    go to state 65
    UnaryExpr      go to state 68
    UnaryExpr1     go to state 69
    UnaryExpr11    go to state 70


state 225

  107 Predicate12: _IN . '(' ExpressionList ')'

    '('  shift, and go to state 254


state 226

  103 Predicate1: Predicate11 Predicate12 .

    $default  reduce using rule 103 (Predicate1)


state 227

  118 PrimaryFactor1: PrimaryFactor1 PrimaryFactor11 PrimaryTerm .

    $default  reduce using rule 118 (PrimaryFactor1)


state 228

  138 RecordSet1: '(' SelectStmt . RecordSet11 ')'
  139 RecordSet11: .  [')']
  140            | . ';'

    ';'  shift, and go to state 255

    $default  reduce using rule 139 (RecordSet11)

    RecordSet11  go to state 256


state 229

  143 RecordSetList: RecordSet RecordSetList1 . RecordSetList2
  145 RecordSetList1: RecordSetList1 . ',' RecordSet
  146 RecordSetList2: .  [$end, _GROUPBY, _LIMIT, _OFFSET, _ORDER, _WHERE, ')', ';']
  147               | . ','

    ','  shift, and go to state 257

    $default  reduce using rule 146 (RecordSetList2)

    RecordSetList2  go to state 258


state 230

  142 RecordSet2: _AS . _IDENTIFIER

    _IDENTIFIER  shift, and go to state 259


state 231

  136 RecordSet: RecordSet1 RecordSet2 .

    $default  reduce using rule 136 (RecordSet)


state 232

   75 GroupByClause: . _GROUPBY ColumnNameList
  149 SelectStmt: _SELECT SelectStmt1 SelectStmt2 _FROM RecordSetList SelectStmt3 . SelectStmt4 SelectStmt5 SelectStmt6 SelectStmt7
  156 SelectStmt4: .  [$end, _LIMIT, _OFFSET, _ORDER, ')', ';']
  157            | . GroupByClause

    _GROUPBY  shift, and go to state 260

    $default  reduce using rule 156 (SelectStmt4)

    GroupByClause  go to state 261
    SelectStmt4    go to state 262


state 233

  155 SelectStmt3: WhereClause .

    $default  reduce using rule 155 (SelectStmt3)


state 234

   49 Expression1: Expression1 _OROR Term .

    $default  reduce using rule 49 (Expression1)


state 235

  125 PrimaryTerm1: PrimaryTerm1 PrimaryTerm11 UnaryExpr .

    $default  reduce using rule 125 (PrimaryTerm1)


state 236

  135 QualifiedIdent1: '.' _IDENTIFIER .

    $default  reduce using rule 135 (QualifiedIdent1)


state 237

   96 Operand: '(' Expression ')' .

    $default  reduce using rule 96 (Operand)


state 238

   11 Call: '(' Call1 . ')'

    ')'  shift, and go to state 263


state 239

   50 ExpressionList: Expression . ExpressionList1 ExpressionList2
   51 ExpressionList1: .
   52                | . ExpressionList1 ',' Expression

    $default  reduce using rule 51 (ExpressionList1)

    ExpressionList1  go to state 264


state 240

   13 Call1: ExpressionList .

    $default  reduce using rule 13 (Call1)


state 241

   76 Index: '[' Expression . ']'
  166 Slice1: Expression .  [':']

    ']'  shift, and go to state 265

    $default  reduce using rule 166 (Slice1)


state 242

  164 Slice: '[' Slice1 . ':' Slice2 ']'

    ':'  shift, and go to state 266


state 243

   22 Conversion: Type '(' Expression . ')'

    ')'  shift, and go to state 267


state 244

    4 Assignment: . ColumnName '=' Expression
    7 AssignmentList1: AssignmentList1 ',' . Assignment
    9 AssignmentList2: ',' .  [$end, _WHERE, ';']
   15 ColumnName: . _IDENTIFIER

    _IDENTIFIER  shift, and go to state 142

    $default  reduce using rule 9 (AssignmentList2)

    Assignment  go to state 268
    ColumnName  go to state 145


state 245

    5 AssignmentList: Assignment AssignmentList1 AssignmentList2 .

    $default  reduce using rule 5 (AssignmentList)


state 246

    4 Assignment: ColumnName '=' Expression .

    $default  reduce using rule 4 (Assignment)


state 247

   30 CreateTableStmt: _CREATE _TABLE CreateTableStmt1 TableName '(' ColumnDef CreateTableStmt2 . CreateTableStmt3 ')'
   34 CreateTableStmt2: CreateTableStmt2 . ',' ColumnDef
   35 CreateTableStmt3: .  [')']
   36                 | . ','

    ','  shift, and go to state 269

    $default  reduce using rule 35 (CreateTableStmt3)

    CreateTableStmt3  go to state 270


state 248

   23 CreateIndexStmt: _CREATE CreateIndexStmt1 _INDEX CreateIndexStmt2 IndexName _ON TableName . '(' CreateIndexStmt3 ')'

    '('  shift, and go to state 271


state 249

   15 ColumnName: . _IDENTIFIER
   18 ColumnNameList1: ColumnNameList1 ',' . ColumnName
   20 ColumnNameList2: ',' .  [$end, _LIMIT, _OFFSET, _ORDER, ')', ';']

    _IDENTIFIER  shift, and go to state 142

    $default  reduce using rule 20 (ColumnNameList2)

    ColumnName  go to state 272


state 250

   16 ColumnNameList: ColumnName ColumnNameList1 ColumnNameList2 .

    $default  reduce using rule 16 (ColumnNameList)


state 251

  228 Values: _VALUES '(' ExpressionList . ')' Values1 Values2

    ')'  shift, and go to state 273


state 252

  104 Predicate1: _IS Predicate13 _NULL .

    $default  reduce using rule 104 (Predicate1)


state 253

  108 Predicate12: _BETWEEN PrimaryFactor . _AND PrimaryFactor

    _AND  shift, and go to state 274


state 254

   47 Expression: . Term Expression1
   50 ExpressionList: . Expression ExpressionList1 ExpressionList2
   55 Factor: . PrimaryFactor Factor1 Factor2
  107 Predicate12: _IN '(' . ExpressionList ')'
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  188 Term: . Factor Term1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    $default  reduce using rule 217 (UnaryExpr1)

    Expression      go to state 239
    ExpressionList  go to state 275
    Factor          go to state 61
    PrimaryFactor   go to state 64
    PrimaryTerm     go to state 65
    Term            go to state 67
    UnaryExpr       go to state 68
    UnaryExpr1      go to state 69
    UnaryExpr11     go to state 70


state 255

  140 RecordSet11: ';' .

    $default  reduce using rule 140 (RecordSet11)


state 256

  138 RecordSet1: '(' SelectStmt RecordSet11 . ')'

    ')'  shift, and go to state 276


state 257

  136 RecordSet: . RecordSet1 RecordSet2
  137 RecordSet1: . TableName
  138           | . '(' SelectStmt RecordSet11 ')'
  145 RecordSetList1: RecordSetList1 ',' . RecordSet
  147 RecordSetList2: ',' .  [$end, _GROUPBY, _LIMIT, _OFFSET, _ORDER, _WHERE, ')', ';']
  187 TableName: . _IDENTIFIER

    _IDENTIFIER  shift, and go to state 41
    '('          shift, and go to state 184

    $default  reduce using rule 147 (RecordSetList2)

    RecordSet   go to state 277
    RecordSet1  go to state 186
    TableName   go to state 188


state 258

  143 RecordSetList: RecordSet RecordSetList1 RecordSetList2 .

    $default  reduce using rule 143 (RecordSetList)


state 259

  142 RecordSet2: _AS _IDENTIFIER .

    $default  reduce using rule 142 (RecordSet2)


state 260

   15 ColumnName: . _IDENTIFIER
   16 ColumnNameList: . ColumnName ColumnNameList1 ColumnNameList2
   75 GroupByClause: _GROUPBY . ColumnNameList

    _IDENTIFIER  shift, and go to state 142

    ColumnName      go to state 155
    ColumnNameList  go to state 278


state 261

  157 SelectStmt4: GroupByClause .

    $default  reduce using rule 157 (SelectStmt4)


state 262

   97 OrderBy: . _ORDER _BY ExpressionList OrderBy1
  149 SelectStmt: _SELECT SelectStmt1 SelectStmt2 _FROM RecordSetList SelectStmt3 SelectStmt4 . SelectStmt5 SelectStmt6 SelectStmt7
  158 SelectStmt5: .  [$end, _LIMIT, _OFFSET, ')', ';']
  159            | . OrderBy

    _ORDER  shift, and go to state 279

    $default  reduce using rule 158 (SelectStmt5)

    OrderBy      go to state 280
    SelectStmt5  go to state 281


state 263

   11 Call: '(' Call1 ')' .

    $default  reduce using rule 11 (Call)


state 264

   50 ExpressionList: Expression ExpressionList1 . ExpressionList2
   52 ExpressionList1: ExpressionList1 . ',' Expression
   53 ExpressionList2: .  [$end, _ASC, _DESC, _LIMIT, _OFFSET, ')', ';']
   54                | . ','

    ','  shift, and go to state 282

    $default  reduce using rule 53 (ExpressionList2)

    ExpressionList2  go to state 283


state 265

   76 Index: '[' Expression ']' .

    $default  reduce using rule 76 (Index)


state 266

   47 Expression: . Term Expression1
   55 Factor: . PrimaryFactor Factor1 Factor2
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  164 Slice: '[' Slice1 ':' . Slice2 ']'
  167 Slice2: .  [']']
  168       | . Expression
  188 Term: . Factor Term1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    ']'       reduce using rule 167 (Slice2)
    $default  reduce using rule 217 (UnaryExpr1)

    Expression     go to state 284
    Factor         go to state 61
    PrimaryFactor  go to state 64
    PrimaryTerm    go to state 65
    Slice2         go to state 285
    Term           go to state 67
    UnaryExpr      go to state 68
    UnaryExpr1     go to state 69
    UnaryExpr11    go to state 70


state 267

   22 Conversion: Type '(' Expression ')' .

    $default  reduce using rule 22 (Conversion)


state 268

    7 AssignmentList1: AssignmentList1 ',' Assignment .

    $default  reduce using rule 7 (AssignmentList1)


state 269

   14 ColumnDef: . ColumnName Type
   15 ColumnName: . _IDENTIFIER
   34 CreateTableStmt2: CreateTableStmt2 ',' . ColumnDef
   36 CreateTableStmt3: ',' .  [')']

    _IDENTIFIER  shift, and go to state 142

    $default  reduce using rule 36 (CreateTableStmt3)

    ColumnDef   go to state 286
    ColumnName  go to state 148


state 270

   30 CreateTableStmt: _CREATE _TABLE CreateTableStmt1 TableName '(' ColumnDef CreateTableStmt2 CreateTableStmt3 . ')'

    ')'  shift, and go to state 287


state 271

   15 ColumnName: . _IDENTIFIER
   23 CreateIndexStmt: _CREATE CreateIndexStmt1 _INDEX CreateIndexStmt2 IndexName _ON TableName '(' . CreateIndexStmt3 ')'
   28 CreateIndexStmt3: . ColumnName
   29                 | . _ID Call

    _IDENTIFIER  shift, and go to state 142
    _ID          shift, and go to state 288

    ColumnName        go to state 289
    CreateIndexStmt3  go to state 290


state 272

   18 ColumnNameList1: ColumnNameList1 ',' ColumnName .

    $default  reduce using rule 18 (ColumnNameList1)


state 273

  228 Values: _VALUES '(' ExpressionList ')' . Values1 Values2
  229 Values1: .
  230        | . Values1 ',' '(' ExpressionList ')'

    $default  reduce using rule 229 (Values1)

    Values1  go to state 291


state 274

  108 Predicate12: _BETWEEN PrimaryFactor _AND . PrimaryFactor
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    $default  reduce using rule 217 (UnaryExpr1)

    PrimaryFactor  go to state 292
    PrimaryTerm    go to state 65
    UnaryExpr      go to state 68
    UnaryExpr1     go to state 69
    UnaryExpr11    go to state 70


state 275

  107 Predicate12: _IN '(' ExpressionList . ')'

    ')'  shift, and go to state 293


state 276

  138 RecordSet1: '(' SelectStmt RecordSet11 ')' .

    $default  reduce using rule 138 (RecordSet1)


state 277

  145 RecordSetList1: RecordSetList1 ',' RecordSet .

    $default  reduce using rule 145 (RecordSetList1)


state 278

   75 GroupByClause: _GROUPBY ColumnNameList .

    $default  reduce using rule 75 (GroupByClause)


state 279

   97 OrderBy: _ORDER . _BY ExpressionList OrderBy1

    _BY  shift, and go to state 294


state 280

  159 SelectStmt5: OrderBy .

    $default  reduce using rule 159 (SelectStmt5)


state 281

   83 Limit: . _LIMIT Expression
  149 SelectStmt: _SELECT SelectStmt1 SelectStmt2 _FROM RecordSetList SelectStmt3 SelectStmt4 SelectStmt5 . SelectStmt6 SelectStmt7
  160 SelectStmt6: .  [$end, _OFFSET, ')', ';']
  161            | . Limit

    _LIMIT  shift, and go to state 295

    $default  reduce using rule 160 (SelectStmt6)

    Limit        go to state 296
    SelectStmt6  go to state 297


state 282

   47 Expression: . Term Expression1
   52 ExpressionList1: ExpressionList1 ',' . Expression
   54 ExpressionList2: ',' .  [$end, _ASC, _DESC, _LIMIT, _OFFSET, ')', ';']
   55 Factor: . PrimaryFactor Factor1 Factor2
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  188 Term: . Factor Term1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    $end      reduce using rule 54 (ExpressionList2)
    _ASC      reduce using rule 54 (ExpressionList2)
    _DESC     reduce using rule 54 (ExpressionList2)
    _LIMIT    reduce using rule 54 (ExpressionList2)
    _OFFSET   reduce using rule 54 (ExpressionList2)
    ')'       reduce using rule 54 (ExpressionList2)
    ';'       reduce using rule 54 (ExpressionList2)
    $default  reduce using rule 217 (UnaryExpr1)

    Expression     go to state 298
    Factor         go to state 61
    PrimaryFactor  go to state 64
    PrimaryTerm    go to state 65
    Term           go to state 67
    UnaryExpr      go to state 68
    UnaryExpr1     go to state 69
    UnaryExpr11    go to state 70


state 283

   50 ExpressionList: Expression ExpressionList1 ExpressionList2 .

    $default  reduce using rule 50 (ExpressionList)


state 284

  168 Slice2: Expression .

    $default  reduce using rule 168 (Slice2)


state 285

  164 Slice: '[' Slice1 ':' Slice2 . ']'

    ']'  shift, and go to state 299


state 286

   34 CreateTableStmt2: CreateTableStmt2 ',' ColumnDef .

    $default  reduce using rule 34 (CreateTableStmt2)


state 287

   30 CreateTableStmt: _CREATE _TABLE CreateTableStmt1 TableName '(' ColumnDef CreateTableStmt2 CreateTableStmt3 ')' .

    $default  reduce using rule 30 (CreateTableStmt)


state 288

   11 Call: . '(' Call1 ')'
   29 CreateIndexStmt3: _ID . Call

    '('  shift, and go to state 201

    Call  go to state 300


state 289

   28 CreateIndexStmt3: ColumnName .

    $default  reduce using rule 28 (CreateIndexStmt3)


state 290

   23 CreateIndexStmt: _CREATE CreateIndexStmt1 _INDEX CreateIndexStmt2 IndexName _ON TableName '(' CreateIndexStmt3 . ')'

    ')'  shift, and go to state 301


state 291

  228 Values: _VALUES '(' ExpressionList ')' Values1 . Values2
  230 Values1: Values1 . ',' '(' ExpressionList ')'
  231 Values2: .  [$end, ';']
  232        | . ','

    ','  shift, and go to state 302

    $default  reduce using rule 231 (Values2)

    Values2  go to state 303


state 292

  108 Predicate12: _BETWEEN PrimaryFactor _AND PrimaryFactor .

    $default  reduce using rule 108 (Predicate12)


state 293

  107 Predicate12: _IN '(' ExpressionList ')' .

    $default  reduce using rule 107 (Predicate12)


state 294

   47 Expression: . Term Expression1
   50 ExpressionList: . Expression ExpressionList1 ExpressionList2
   55 Factor: . PrimaryFactor Factor1 Factor2
   97 OrderBy: _ORDER _BY . ExpressionList OrderBy1
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  188 Term: . Factor Term1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    $default  reduce using rule 217 (UnaryExpr1)

    Expression      go to state 239
    ExpressionList  go to state 304
    Factor          go to state 61
    PrimaryFactor   go to state 64
    PrimaryTerm     go to state 65
    Term            go to state 67
    UnaryExpr       go to state 68
    UnaryExpr1      go to state 69
    UnaryExpr11     go to state 70


state 295

   47 Expression: . Term Expression1
   55 Factor: . PrimaryFactor Factor1 Factor2
   83 Limit: _LIMIT . Expression
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  188 Term: . Factor Term1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    $default  reduce using rule 217 (UnaryExpr1)

    Expression     go to state 305
    Factor         go to state 61
    PrimaryFactor  go to state 64
    PrimaryTerm    go to state 65
    Term           go to state 67
    UnaryExpr      go to state 68
    UnaryExpr1     go to state 69
    UnaryExpr11    go to state 70


state 296

  161 SelectStmt6: Limit .

    $default  reduce using rule 161 (SelectStmt6)


state 297

   93 Offset: . _OFFSET Expression
  149 SelectStmt: _SELECT SelectStmt1 SelectStmt2 _FROM RecordSetList SelectStmt3 SelectStmt4 SelectStmt5 SelectStmt6 . SelectStmt7
  162 SelectStmt7: .  [$end, ')', ';']
  163            | . Offset

    _OFFSET  shift, and go to state 306

    $default  reduce using rule 162 (SelectStmt7)

    Offset       go to state 307
    SelectStmt7  go to state 308


state 298

   52 ExpressionList1: ExpressionList1 ',' Expression .

    $default  reduce using rule 52 (ExpressionList1)


state 299

  164 Slice: '[' Slice1 ':' Slice2 ']' .

    $default  reduce using rule 164 (Slice)


state 300

   29 CreateIndexStmt3: _ID Call .

    $default  reduce using rule 29 (CreateIndexStmt3)


state 301

   23 CreateIndexStmt: _CREATE CreateIndexStmt1 _INDEX CreateIndexStmt2 IndexName _ON TableName '(' CreateIndexStmt3 ')' .

    $default  reduce using rule 23 (CreateIndexStmt)


state 302

  230 Values1: Values1 ',' . '(' ExpressionList ')'
  232 Values2: ',' .  [$end, ';']

    '('  shift, and go to state 309

    $default  reduce using rule 232 (Values2)


state 303

  228 Values: _VALUES '(' ExpressionList ')' Values1 Values2 .

    $default  reduce using rule 228 (Values)


state 304

   97 OrderBy: _ORDER _BY ExpressionList . OrderBy1
   98 OrderBy1: .  [$end, _LIMIT, _OFFSET, ')', ';']
   99         | . OrderBy11
  100 OrderBy11: . _ASC
  101          | . _DESC

    _ASC   shift, and go to state 310
    _DESC  shift, and go to state 311

    $default  reduce using rule 98 (OrderBy1)

    OrderBy1   go to state 312
    OrderBy11  go to state 313


state 305

   83 Limit: _LIMIT Expression .

    $default  reduce using rule 83 (Limit)


state 306

   47 Expression: . Term Expression1
   55 Factor: . PrimaryFactor Factor1 Factor2
   93 Offset: _OFFSET . Expression
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  188 Term: . Factor Term1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    $default  reduce using rule 217 (UnaryExpr1)

    Expression     go to state 314
    Factor         go to state 61
    PrimaryFactor  go to state 64
    PrimaryTerm    go to state 65
    Term           go to state 67
    UnaryExpr      go to state 68
    UnaryExpr1     go to state 69
    UnaryExpr11    go to state 70


state 307

  163 SelectStmt7: Offset .

    $default  reduce using rule 163 (SelectStmt7)


state 308

  149 SelectStmt: _SELECT SelectStmt1 SelectStmt2 _FROM RecordSetList SelectStmt3 SelectStmt4 SelectStmt5 SelectStmt6 SelectStmt7 .

    $default  reduce using rule 149 (SelectStmt)


state 309

   47 Expression: . Term Expression1
   50 ExpressionList: . Expression ExpressionList1 ExpressionList2
   55 Factor: . PrimaryFactor Factor1 Factor2
  116 PrimaryFactor: . PrimaryTerm PrimaryFactor1
  123 PrimaryTerm: . UnaryExpr PrimaryTerm1
  188 Term: . Factor Term1
  216 UnaryExpr: . UnaryExpr1 PrimaryExpression
  217 UnaryExpr1: .  [_FLOAT_LIT, _IDENTIFIER, _IMAGINARY_LIT, _INT_LIT, _QL_PARAMETER, _RUNE_LIT, _STRING_LIT, _BIGINT, _BIGRAT, _BLOB, _BOOL, _BYTE, _COMPLEX128, _COMPLEX64, _DURATION, _FALSE, _FLOAT, _FLOAT32, _FLOAT64, _INT, _INT16, _INT32, _INT64, _INT8, _NULL, _RUNE, _STRING, _TIME, _TRUE, _UINT, _UINT16, _UINT32, _UINT64, _UINT8, '(']
  218           | . UnaryExpr11
  219 UnaryExpr11: . '^'
  220            | . '!'
  221            | . '-'
  222            | . '+'
  230 Values1: Values1 ',' '(' . ExpressionList ')'

    '^'  shift, and go to state 55
    '-'  shift, and go to state 56
    '+'  shift, and go to state 57
    '!'  shift, and go to state 59

    $default  reduce using rule 217 (UnaryExpr1)

    Expression      go to state 239
    ExpressionList  go to state 315
    Factor          go to state 61
    PrimaryFactor   go to state 64
    PrimaryTerm     go to state 65
    Term            go to state 67
    UnaryExpr       go to state 68
    UnaryExpr1      go to state 69
    UnaryExpr11     go to state 70


state 310

  100 OrderBy11: _ASC .

    $default  reduce using rule 100 (OrderBy11)


state 311

  101 OrderBy11: _DESC .

    $default  reduce using rule 101 (OrderBy11)


state 312

   97 OrderBy: _ORDER _BY ExpressionList OrderBy1 .

    $default  reduce using rule 97 (OrderBy)


state 313

   99 OrderBy1: OrderBy11 .

    $default  reduce using rule 99 (OrderBy1)


state 314

   93 Offset: _OFFSET Expression .

    $default  reduce using rule 93 (Offset)


state 315

  230 Values1: Values1 ',' '(' ExpressionList . ')'

    ')'  shift, and go to state 316


state 316

  230 Values1: Values1 ',' '(' ExpressionList ')' .

    $default  reduce using rule 230 (Values1)
