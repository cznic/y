Grammar

    0 $accept: StatementList $end

    1 AlterTableStmt: alter tableKwd TableName add ColumnDef
    2               | alter tableKwd TableName drop column ColumnName

    3 Assignment: ColumnName '=' Expression

    4 AssignmentList: Assignment AssignmentList1 AssignmentList2

    5 AssignmentList1: /* empty */
    6                | AssignmentList1 ',' Assignment

    7 AssignmentList2: /* empty */
    8                | ','

    9 BeginTransactionStmt: begin transaction

   10 Call: '(' Call1 ')'

   11 Call1: /* empty */
   12      | ExpressionList

   13 ColumnDef: ColumnName Type

   14 ColumnName: identifier

   15 ColumnNameList: ColumnName ColumnNameList1 ColumnNameList2

   16 ColumnNameList1: /* empty */
   17                | ColumnNameList1 ',' ColumnName

   18 ColumnNameList2: /* empty */
   19                | ','

   20 CommitStmt: commit

   21 Conversion: Type '(' Expression ')'

   22 CreateIndexStmt: create CreateIndexStmtUnique index CreateIndexIfNotExists identifier on identifier '(' identifier ')'
   23                | create CreateIndexStmtUnique index CreateIndexIfNotExists identifier on identifier '(' identifier '(' ')' ')'

   24 CreateIndexIfNotExists: /* empty */
   25                       | ifKwd not exists

   26 CreateIndexStmtUnique: /* empty */
   27                      | unique

   28 CreateTableStmt: create tableKwd TableName '(' ColumnDef CreateTableStmt1 CreateTableStmt2 ')'
   29                | create tableKwd ifKwd not exists TableName '(' ColumnDef CreateTableStmt1 CreateTableStmt2 ')'

   30 CreateTableStmt1: /* empty */
   31                 | CreateTableStmt1 ',' ColumnDef

   32 CreateTableStmt2: /* empty */
   33                 | ','

   34 DeleteFromStmt: deleteKwd from TableName
   35               | deleteKwd from TableName WhereClause

   36 DropIndexStmt: drop index DropIndexIfExists identifier

   37 DropIndexIfExists: /* empty */
   38                  | ifKwd exists

   39 DropTableStmt: drop tableKwd TableName
   40              | drop tableKwd ifKwd exists TableName

   41 EmptyStmt: /* empty */

   42 Expression: Term
   43           | Expression oror Term

   44 ExpressionList: Expression ExpressionList1 ExpressionList2

   45 ExpressionList1: /* empty */
   46                | ExpressionList1 ',' Expression

   47 ExpressionList2: /* empty */
   48                | ','

   49 Factor: Factor1
   50       | Factor1 in '(' ExpressionList ')'
   51       | Factor1 not in '(' ExpressionList ')'
   52       | Factor1 between PrimaryFactor and PrimaryFactor
   53       | Factor1 not between PrimaryFactor and PrimaryFactor
   54       | Factor1 is null
   55       | Factor1 is not null

   56 Factor1: PrimaryFactor
   57        | Factor1 ge PrimaryFactor
   58        | Factor1 '>' PrimaryFactor
   59        | Factor1 le PrimaryFactor
   60        | Factor1 '<' PrimaryFactor
   61        | Factor1 neq PrimaryFactor
   62        | Factor1 eq PrimaryFactor
   63        | Factor1 like PrimaryFactor

   64 Field: Expression Field1

   65 Field1: /* empty */
   66       | as identifier

   67 FieldList: Field
   68          | FieldList ',' Field

   69 GroupByClause: group by ColumnNameList

   70 Index: '[' Expression ']'

   71 InsertIntoStmt: insert into TableName InsertIntoStmt1 values '(' ExpressionList ')' InsertIntoStmt2 InsertIntoStmt3
   72               | insert into TableName InsertIntoStmt1 SelectStmt

   73 InsertIntoStmt1: /* empty */
   74                | '(' ColumnNameList ')'

   75 InsertIntoStmt2: /* empty */
   76                | InsertIntoStmt2 ',' '(' ExpressionList ')'

   77 InsertIntoStmt3: /* empty */
   78                | ','

   79 Literal: falseKwd
   80        | null
   81        | trueKwd
   82        | floatLit
   83        | imaginaryLit
   84        | intLit
   85        | stringLit

   86 Operand: Literal
   87        | qlParam
   88        | QualifiedIdent
   89        | '(' Expression ')'

   90 OrderBy: order by ExpressionList OrderBy1

   91 OrderBy1: /* empty */
   92         | asc
   93         | desc

   94 PrimaryExpression: Operand
   95                  | Conversion
   96                  | PrimaryExpression Index
   97                  | PrimaryExpression Slice
   98                  | PrimaryExpression Call

   99 PrimaryFactor: PrimaryTerm
  100              | PrimaryFactor '^' PrimaryTerm
  101              | PrimaryFactor '|' PrimaryTerm
  102              | PrimaryFactor '-' PrimaryTerm
  103              | PrimaryFactor '+' PrimaryTerm

  104 PrimaryTerm: UnaryExpr
  105            | PrimaryTerm andnot UnaryExpr
  106            | PrimaryTerm '&' UnaryExpr
  107            | PrimaryTerm lsh UnaryExpr
  108            | PrimaryTerm rsh UnaryExpr
  109            | PrimaryTerm '%' UnaryExpr
  110            | PrimaryTerm '/' UnaryExpr
  111            | PrimaryTerm '*' UnaryExpr

  112 QualifiedIdent: identifier
  113               | identifier '.' identifier

  114 RecordSet: RecordSet1 RecordSet2

  115 RecordSet1: identifier
  116           | '(' SelectStmt RecordSet11 ')'

  117 RecordSet11: /* empty */
  118            | ';'

  119 RecordSet2: /* empty */
  120           | as identifier

  121 RecordSetList: RecordSet
  122              | RecordSetList ',' RecordSet

  123 RollbackStmt: rollback

  124 SelectStmt: selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset
  125           | selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList ',' SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset

  126 SelectStmtLimit: /* empty */
  127                | limit Expression

  128 SelectStmtOffset: /* empty */
  129                 | offset Expression

  130 SelectStmtDistinct: /* empty */
  131                   | distinct

  132 SelectStmtFieldList: '*'
  133                    | FieldList
  134                    | FieldList ','

  135 SelectStmtWhere: /* empty */
  136                | WhereClause

  137 SelectStmtGroup: /* empty */
  138                | GroupByClause

  139 SelectStmtOrder: /* empty */
  140                | OrderBy

  141 Slice: '[' ':' ']'
  142      | '[' ':' Expression ']'
  143      | '[' Expression ':' ']'
  144      | '[' Expression ':' Expression ']'

  145 Statement: EmptyStmt
  146          | AlterTableStmt
  147          | BeginTransactionStmt
  148          | CommitStmt
  149          | CreateIndexStmt
  150          | CreateTableStmt
  151          | DeleteFromStmt
  152          | DropIndexStmt
  153          | DropTableStmt
  154          | InsertIntoStmt
  155          | RollbackStmt
  156          | SelectStmt
  157          | TruncateTableStmt
  158          | UpdateStmt

  159 StatementList: Statement
  160              | StatementList ';' Statement

  161 TableName: identifier

  162 Term: Factor
  163     | Term andand Factor

  164 TruncateTableStmt: truncate tableKwd TableName

  165 Type: bigIntType
  166     | bigRatType
  167     | blobType
  168     | boolType
  169     | byteType
  170     | complex128Type
  171     | complex64Type
  172     | durationType
  173     | floatType
  174     | float32Type
  175     | float64Type
  176     | intType
  177     | int16Type
  178     | int32Type
  179     | int64Type
  180     | int8Type
  181     | runeType
  182     | stringType
  183     | timeType
  184     | uintType
  185     | uint16Type
  186     | uint32Type
  187     | uint64Type
  188     | uint8Type

  189 UpdateStmt: update TableName oSet AssignmentList UpdateStmt1

  190 UpdateStmt1: /* empty */
  191            | WhereClause

  192 UnaryExpr: PrimaryExpression
  193          | '^' PrimaryExpression
  194          | '!' PrimaryExpression
  195          | '-' PrimaryExpression
  196          | '+' PrimaryExpression

  197 WhereClause: where Expression

  198 oSet: /* empty */
  199     | set


Terminals, with rules where they appear

$end (0) 0
'!' (33) 194
'%' (37) 109
'&' (38) 106
'(' (40) 10 21 22 23 28 29 50 51 71 74 76 89 116
')' (41) 10 21 22 23 28 29 50 51 71 74 76 89 116
'*' (42) 111 132
'+' (43) 103 196
',' (44) 6 8 17 19 31 33 46 48 68 76 78 122 125 134
'-' (45) 102 195
'.' (46) 113
'/' (47) 110
':' (58) 141 142 143 144
';' (59) 118 160
'<' (60) 60
'=' (61) 3
'>' (62) 58
'[' (91) 70 141 142 143 144
']' (93) 70 141 142 143 144
'^' (94) 100 193
'|' (124) 101
error (256)
add (258) 1
alter (259) 1 2
and (260) 52 53
andand (261) 163
andnot (262) 105
as (263) 66 120
asc (264) 92
begin (265) 9
between (266) 52 53
bigIntType (267) 165
bigRatType (268) 166
blobType (269) 167
boolType (270) 168
by (271) 69 90
byteType (272) 169
column (273) 2
commit (274) 20
complex128Type (275) 170
complex64Type (276) 171
create (277) 22 23 28 29
deleteKwd (278) 34 35
desc (279) 93
distinct (280) 131
drop (281) 2 36 39 40
durationType (282) 172
eq (283) 62
exists (284) 25 29 38 40
falseKwd (285) 79
floatType (286) 173
float32Type (287) 174
float64Type (288) 175
floatLit (289) 82
from (290) 34 35 124 125
ge (291) 57
group (292) 69
identifier (293) 14 22 23 36 66 112 113 115 120 161
ifKwd (294) 25 29 38 40
imaginaryLit (295) 83
in (296) 50 51
index (297) 22 23 36
insert (298) 71 72
intType (299) 176
int16Type (300) 177
int32Type (301) 178
int64Type (302) 179
int8Type (303) 180
into (304) 71 72
intLit (305) 84
is (306) 54 55
le (307) 59
like (308) 63
limit (309) 127
lsh (310) 107
neq (311) 61
not (312) 25 29 51 53 55
null (313) 54 55 80
offset (314) 129
on (315) 22 23
order (316) 90
oror (317) 43
qlParam (318) 87
rollback (319) 123
rsh (320) 108
runeType (321) 181
selectKwd (322) 124 125
set (323) 199
stringType (324) 182
stringLit (325) 85
tableKwd (326) 1 2 28 29 39 40 164
timeType (327) 183
transaction (328) 9
trueKwd (329) 81
truncate (330) 164
uintType (331) 184
uint16Type (332) 185
uint32Type (333) 186
uint64Type (334) 187
uint8Type (335) 188
unique (336) 27
update (337) 189
values (338) 71
where (339) 197


Nonterminals, with rules where they appear

$accept (105)
    on left: 0
AlterTableStmt (106)
    on left: 1 2, on right: 146
Assignment (107)
    on left: 3, on right: 4 6
AssignmentList (108)
    on left: 4, on right: 189
AssignmentList1 (109)
    on left: 5 6, on right: 4 6
AssignmentList2 (110)
    on left: 7 8, on right: 4
BeginTransactionStmt (111)
    on left: 9, on right: 147
Call (112)
    on left: 10, on right: 98
Call1 (113)
    on left: 11 12, on right: 10
ColumnDef (114)
    on left: 13, on right: 1 28 29 31
ColumnName (115)
    on left: 14, on right: 2 3 13 15 17
ColumnNameList (116)
    on left: 15, on right: 69 74
ColumnNameList1 (117)
    on left: 16 17, on right: 15 17
ColumnNameList2 (118)
    on left: 18 19, on right: 15
CommitStmt (119)
    on left: 20, on right: 148
Conversion (120)
    on left: 21, on right: 95
CreateIndexStmt (121)
    on left: 22 23, on right: 149
CreateIndexIfNotExists (122)
    on left: 24 25, on right: 22 23
CreateIndexStmtUnique (123)
    on left: 26 27, on right: 22 23
CreateTableStmt (124)
    on left: 28 29, on right: 150
CreateTableStmt1 (125)
    on left: 30 31, on right: 28 29 31
CreateTableStmt2 (126)
    on left: 32 33, on right: 28 29
DeleteFromStmt (127)
    on left: 34 35, on right: 151
DropIndexStmt (128)
    on left: 36, on right: 152
DropIndexIfExists (129)
    on left: 37 38, on right: 36
DropTableStmt (130)
    on left: 39 40, on right: 153
EmptyStmt (131)
    on left: 41, on right: 145
Expression (132)
    on left: 42 43, on right: 3 21 43 44 46 64 70 89 127 129 142 143
    144 197
ExpressionList (133)
    on left: 44, on right: 12 50 51 71 76 90
ExpressionList1 (134)
    on left: 45 46, on right: 44 46
ExpressionList2 (135)
    on left: 47 48, on right: 44
Factor (136)
    on left: 49 50 51 52 53 54 55, on right: 162 163
Factor1 (137)
    on left: 56 57 58 59 60 61 62 63, on right: 49 50 51 52 53 54 55
    57 58 59 60 61 62 63
Field (138)
    on left: 64, on right: 67 68
Field1 (139)
    on left: 65 66, on right: 64
FieldList (140)
    on left: 67 68, on right: 68 133 134
GroupByClause (141)
    on left: 69, on right: 138
Index (142)
    on left: 70, on right: 96
InsertIntoStmt (143)
    on left: 71 72, on right: 154
InsertIntoStmt1 (144)
    on left: 73 74, on right: 71 72
InsertIntoStmt2 (145)
    on left: 75 76, on right: 71 76
InsertIntoStmt3 (146)
    on left: 77 78, on right: 71
Literal (147)
    on left: 79 80 81 82 83 84 85, on right: 86
Operand (148)
    on left: 86 87 88 89, on right: 94
OrderBy (149)
    on left: 90, on right: 140
OrderBy1 (150)
    on left: 91 92 93, on right: 90
PrimaryExpression (151)
    on left: 94 95 96 97 98, on right: 96 97 98 192 193 194 195 196
PrimaryFactor (152)
    on left: 99 100 101 102 103, on right: 52 53 56 57 58 59 60 61
    62 63 100 101 102 103
PrimaryTerm (153)
    on left: 104 105 106 107 108 109 110 111, on right: 99 100 101
    102 103 105 106 107 108 109 110 111
QualifiedIdent (154)
    on left: 112 113, on right: 88
RecordSet (155)
    on left: 114, on right: 121 122
RecordSet1 (156)
    on left: 115 116, on right: 114
RecordSet11 (157)
    on left: 117 118, on right: 116
RecordSet2 (158)
    on left: 119 120, on right: 114
RecordSetList (159)
    on left: 121 122, on right: 122 124 125
RollbackStmt (160)
    on left: 123, on right: 155
SelectStmt (161)
    on left: 124 125, on right: 72 116 156
SelectStmtLimit (162)
    on left: 126 127, on right: 124 125
SelectStmtOffset (163)
    on left: 128 129, on right: 124 125
SelectStmtDistinct (164)
    on left: 130 131, on right: 124 125
SelectStmtFieldList (165)
    on left: 132 133 134, on right: 124 125
SelectStmtWhere (166)
    on left: 135 136, on right: 124 125
SelectStmtGroup (167)
    on left: 137 138, on right: 124 125
SelectStmtOrder (168)
    on left: 139 140, on right: 124 125
Slice (169)
    on left: 141 142 143 144, on right: 97
Statement (170)
    on left: 145 146 147 148 149 150 151 152 153 154 155 156 157 158,
    on right: 159 160
StatementList (171)
    on left: 159 160, on right: 0 160
TableName (172)
    on left: 161, on right: 1 2 28 29 34 35 39 40 71 72 164 189
Term (173)
    on left: 162 163, on right: 42 43 163
TruncateTableStmt (174)
    on left: 164, on right: 157
Type (175)
    on left: 165 166 167 168 169 170 171 172 173 174 175 176 177 178
    179 180 181 182 183 184 185 186 187 188, on right: 13 21
UpdateStmt (176)
    on left: 189, on right: 158
UpdateStmt1 (177)
    on left: 190 191, on right: 189
UnaryExpr (178)
    on left: 192 193 194 195 196, on right: 104 105 106 107 108 109
    110 111
WhereClause (179)
    on left: 197, on right: 35 136 191
oSet (180)
    on left: 198 199, on right: 189


state 0

    0 $accept: . StatementList $end
    1 AlterTableStmt: . alter tableKwd TableName add ColumnDef
    2               | . alter tableKwd TableName drop column ColumnName
    9 BeginTransactionStmt: . begin transaction
   20 CommitStmt: . commit
   22 CreateIndexStmt: . create CreateIndexStmtUnique index CreateIndexIfNotExists identifier on identifier '(' identifier ')'
   23                | . create CreateIndexStmtUnique index CreateIndexIfNotExists identifier on identifier '(' identifier '(' ')' ')'
   28 CreateTableStmt: . create tableKwd TableName '(' ColumnDef CreateTableStmt1 CreateTableStmt2 ')'
   29                | . create tableKwd ifKwd not exists TableName '(' ColumnDef CreateTableStmt1 CreateTableStmt2 ')'
   34 DeleteFromStmt: . deleteKwd from TableName
   35               | . deleteKwd from TableName WhereClause
   36 DropIndexStmt: . drop index DropIndexIfExists identifier
   39 DropTableStmt: . drop tableKwd TableName
   40              | . drop tableKwd ifKwd exists TableName
   41 EmptyStmt: .  [$end, ';']
   71 InsertIntoStmt: . insert into TableName InsertIntoStmt1 values '(' ExpressionList ')' InsertIntoStmt2 InsertIntoStmt3
   72               | . insert into TableName InsertIntoStmt1 SelectStmt
  123 RollbackStmt: . rollback
  124 SelectStmt: . selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset
  125           | . selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList ',' SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset
  145 Statement: . EmptyStmt
  146          | . AlterTableStmt
  147          | . BeginTransactionStmt
  148          | . CommitStmt
  149          | . CreateIndexStmt
  150          | . CreateTableStmt
  151          | . DeleteFromStmt
  152          | . DropIndexStmt
  153          | . DropTableStmt
  154          | . InsertIntoStmt
  155          | . RollbackStmt
  156          | . SelectStmt
  157          | . TruncateTableStmt
  158          | . UpdateStmt
  159 StatementList: . Statement
  160              | . StatementList ';' Statement
  164 TruncateTableStmt: . truncate tableKwd TableName
  189 UpdateStmt: . update TableName oSet AssignmentList UpdateStmt1

    alter      shift, and go to state 1
    begin      shift, and go to state 2
    commit     shift, and go to state 3
    create     shift, and go to state 4
    deleteKwd  shift, and go to state 5
    drop       shift, and go to state 6
    insert     shift, and go to state 7
    rollback   shift, and go to state 8
    selectKwd  shift, and go to state 9
    truncate   shift, and go to state 10
    update     shift, and go to state 11

    $default  reduce using rule 41 (EmptyStmt)

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
    Statement             go to state 24
    StatementList         go to state 25
    TruncateTableStmt     go to state 26
    UpdateStmt            go to state 27


state 1

    1 AlterTableStmt: alter . tableKwd TableName add ColumnDef
    2               | alter . tableKwd TableName drop column ColumnName

    tableKwd  shift, and go to state 28


state 2

    9 BeginTransactionStmt: begin . transaction

    transaction  shift, and go to state 29


state 3

   20 CommitStmt: commit .

    $default  reduce using rule 20 (CommitStmt)


state 4

   22 CreateIndexStmt: create . CreateIndexStmtUnique index CreateIndexIfNotExists identifier on identifier '(' identifier ')'
   23                | create . CreateIndexStmtUnique index CreateIndexIfNotExists identifier on identifier '(' identifier '(' ')' ')'
   26 CreateIndexStmtUnique: .  [index]
   27                      | . unique
   28 CreateTableStmt: create . tableKwd TableName '(' ColumnDef CreateTableStmt1 CreateTableStmt2 ')'
   29                | create . tableKwd ifKwd not exists TableName '(' ColumnDef CreateTableStmt1 CreateTableStmt2 ')'

    tableKwd  shift, and go to state 30
    unique    shift, and go to state 31

    $default  reduce using rule 26 (CreateIndexStmtUnique)

    CreateIndexStmtUnique  go to state 32


state 5

   34 DeleteFromStmt: deleteKwd . from TableName
   35               | deleteKwd . from TableName WhereClause

    from  shift, and go to state 33


state 6

   36 DropIndexStmt: drop . index DropIndexIfExists identifier
   39 DropTableStmt: drop . tableKwd TableName
   40              | drop . tableKwd ifKwd exists TableName

    index     shift, and go to state 34
    tableKwd  shift, and go to state 35


state 7

   71 InsertIntoStmt: insert . into TableName InsertIntoStmt1 values '(' ExpressionList ')' InsertIntoStmt2 InsertIntoStmt3
   72               | insert . into TableName InsertIntoStmt1 SelectStmt

    into  shift, and go to state 36


state 8

  123 RollbackStmt: rollback .

    $default  reduce using rule 123 (RollbackStmt)


state 9

  124 SelectStmt: selectKwd . SelectStmtDistinct SelectStmtFieldList from RecordSetList SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset
  125           | selectKwd . SelectStmtDistinct SelectStmtFieldList from RecordSetList ',' SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset
  130 SelectStmtDistinct: .  [bigIntType, bigRatType, blobType, boolType, byteType, complex128Type, complex64Type, durationType, falseKwd, floatType, float32Type, float64Type, floatLit, identifier, imaginaryLit, intType, int16Type, int32Type, int64Type, int8Type, intLit, null, qlParam, runeType, stringType, stringLit, timeType, trueKwd, uintType, uint16Type, uint32Type, uint64Type, uint8Type, '(', '^', '-', '+', '*', '!']
  131                   | . distinct

    distinct  shift, and go to state 37

    $default  reduce using rule 130 (SelectStmtDistinct)

    SelectStmtDistinct  go to state 38


state 10

  164 TruncateTableStmt: truncate . tableKwd TableName

    tableKwd  shift, and go to state 39


state 11

  161 TableName: . identifier
  189 UpdateStmt: update . TableName oSet AssignmentList UpdateStmt1

    identifier  shift, and go to state 40

    TableName  go to state 41


state 12

  146 Statement: AlterTableStmt .

    $default  reduce using rule 146 (Statement)


state 13

  147 Statement: BeginTransactionStmt .

    $default  reduce using rule 147 (Statement)


state 14

  148 Statement: CommitStmt .

    $default  reduce using rule 148 (Statement)


state 15

  149 Statement: CreateIndexStmt .

    $default  reduce using rule 149 (Statement)


state 16

  150 Statement: CreateTableStmt .

    $default  reduce using rule 150 (Statement)


state 17

  151 Statement: DeleteFromStmt .

    $default  reduce using rule 151 (Statement)


state 18

  152 Statement: DropIndexStmt .

    $default  reduce using rule 152 (Statement)


state 19

  153 Statement: DropTableStmt .

    $default  reduce using rule 153 (Statement)


state 20

  145 Statement: EmptyStmt .

    $default  reduce using rule 145 (Statement)


state 21

  154 Statement: InsertIntoStmt .

    $default  reduce using rule 154 (Statement)


state 22

  155 Statement: RollbackStmt .

    $default  reduce using rule 155 (Statement)


state 23

  156 Statement: SelectStmt .

    $default  reduce using rule 156 (Statement)


state 24

  159 StatementList: Statement .

    $default  reduce using rule 159 (StatementList)


state 25

    0 $accept: StatementList . $end
  160 StatementList: StatementList . ';' Statement

    $end  shift, and go to state 42
    ';'   shift, and go to state 43


state 26

  157 Statement: TruncateTableStmt .

    $default  reduce using rule 157 (Statement)


state 27

  158 Statement: UpdateStmt .

    $default  reduce using rule 158 (Statement)


state 28

    1 AlterTableStmt: alter tableKwd . TableName add ColumnDef
    2               | alter tableKwd . TableName drop column ColumnName
  161 TableName: . identifier

    identifier  shift, and go to state 40

    TableName  go to state 44


state 29

    9 BeginTransactionStmt: begin transaction .

    $default  reduce using rule 9 (BeginTransactionStmt)


state 30

   28 CreateTableStmt: create tableKwd . TableName '(' ColumnDef CreateTableStmt1 CreateTableStmt2 ')'
   29                | create tableKwd . ifKwd not exists TableName '(' ColumnDef CreateTableStmt1 CreateTableStmt2 ')'
  161 TableName: . identifier

    identifier  shift, and go to state 40
    ifKwd       shift, and go to state 45

    TableName  go to state 46


state 31

   27 CreateIndexStmtUnique: unique .

    $default  reduce using rule 27 (CreateIndexStmtUnique)


state 32

   22 CreateIndexStmt: create CreateIndexStmtUnique . index CreateIndexIfNotExists identifier on identifier '(' identifier ')'
   23                | create CreateIndexStmtUnique . index CreateIndexIfNotExists identifier on identifier '(' identifier '(' ')' ')'

    index  shift, and go to state 47


state 33

   34 DeleteFromStmt: deleteKwd from . TableName
   35               | deleteKwd from . TableName WhereClause
  161 TableName: . identifier

    identifier  shift, and go to state 40

    TableName  go to state 48


state 34

   36 DropIndexStmt: drop index . DropIndexIfExists identifier
   37 DropIndexIfExists: .  [identifier]
   38                  | . ifKwd exists

    ifKwd  shift, and go to state 49

    $default  reduce using rule 37 (DropIndexIfExists)

    DropIndexIfExists  go to state 50


state 35

   39 DropTableStmt: drop tableKwd . TableName
   40              | drop tableKwd . ifKwd exists TableName
  161 TableName: . identifier

    identifier  shift, and go to state 40
    ifKwd       shift, and go to state 51

    TableName  go to state 52


state 36

   71 InsertIntoStmt: insert into . TableName InsertIntoStmt1 values '(' ExpressionList ')' InsertIntoStmt2 InsertIntoStmt3
   72               | insert into . TableName InsertIntoStmt1 SelectStmt
  161 TableName: . identifier

    identifier  shift, and go to state 40

    TableName  go to state 53


state 37

  131 SelectStmtDistinct: distinct .

    $default  reduce using rule 131 (SelectStmtDistinct)


state 38

   21 Conversion: . Type '(' Expression ')'
   42 Expression: . Term
   43           | . Expression oror Term
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   64 Field: . Expression Field1
   67 FieldList: . Field
   68          | . FieldList ',' Field
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  124 SelectStmt: selectKwd SelectStmtDistinct . SelectStmtFieldList from RecordSetList SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset
  125           | selectKwd SelectStmtDistinct . SelectStmtFieldList from RecordSetList ',' SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset
  132 SelectStmtFieldList: . '*'
  133                    | . FieldList
  134                    | . FieldList ','
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '*'             shift, and go to state 91
    '!'             shift, and go to state 92

    Conversion           go to state 93
    Expression           go to state 94
    Factor               go to state 95
    Factor1              go to state 96
    Field                go to state 97
    FieldList            go to state 98
    Literal              go to state 99
    Operand              go to state 100
    PrimaryExpression    go to state 101
    PrimaryFactor        go to state 102
    PrimaryTerm          go to state 103
    QualifiedIdent       go to state 104
    SelectStmtFieldList  go to state 105
    Term                 go to state 106
    Type                 go to state 107
    UnaryExpr            go to state 108


state 39

  161 TableName: . identifier
  164 TruncateTableStmt: truncate tableKwd . TableName

    identifier  shift, and go to state 40

    TableName  go to state 109


state 40

  161 TableName: identifier .

    $default  reduce using rule 161 (TableName)


state 41

  189 UpdateStmt: update TableName . oSet AssignmentList UpdateStmt1
  198 oSet: .  [identifier]
  199     | . set

    set  shift, and go to state 110

    $default  reduce using rule 198 (oSet)

    oSet  go to state 111


state 42

    0 $accept: StatementList $end .

    $default  accept


state 43

    1 AlterTableStmt: . alter tableKwd TableName add ColumnDef
    2               | . alter tableKwd TableName drop column ColumnName
    9 BeginTransactionStmt: . begin transaction
   20 CommitStmt: . commit
   22 CreateIndexStmt: . create CreateIndexStmtUnique index CreateIndexIfNotExists identifier on identifier '(' identifier ')'
   23                | . create CreateIndexStmtUnique index CreateIndexIfNotExists identifier on identifier '(' identifier '(' ')' ')'
   28 CreateTableStmt: . create tableKwd TableName '(' ColumnDef CreateTableStmt1 CreateTableStmt2 ')'
   29                | . create tableKwd ifKwd not exists TableName '(' ColumnDef CreateTableStmt1 CreateTableStmt2 ')'
   34 DeleteFromStmt: . deleteKwd from TableName
   35               | . deleteKwd from TableName WhereClause
   36 DropIndexStmt: . drop index DropIndexIfExists identifier
   39 DropTableStmt: . drop tableKwd TableName
   40              | . drop tableKwd ifKwd exists TableName
   41 EmptyStmt: .  [$end, ';']
   71 InsertIntoStmt: . insert into TableName InsertIntoStmt1 values '(' ExpressionList ')' InsertIntoStmt2 InsertIntoStmt3
   72               | . insert into TableName InsertIntoStmt1 SelectStmt
  123 RollbackStmt: . rollback
  124 SelectStmt: . selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset
  125           | . selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList ',' SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset
  145 Statement: . EmptyStmt
  146          | . AlterTableStmt
  147          | . BeginTransactionStmt
  148          | . CommitStmt
  149          | . CreateIndexStmt
  150          | . CreateTableStmt
  151          | . DeleteFromStmt
  152          | . DropIndexStmt
  153          | . DropTableStmt
  154          | . InsertIntoStmt
  155          | . RollbackStmt
  156          | . SelectStmt
  157          | . TruncateTableStmt
  158          | . UpdateStmt
  160 StatementList: StatementList ';' . Statement
  164 TruncateTableStmt: . truncate tableKwd TableName
  189 UpdateStmt: . update TableName oSet AssignmentList UpdateStmt1

    alter      shift, and go to state 1
    begin      shift, and go to state 2
    commit     shift, and go to state 3
    create     shift, and go to state 4
    deleteKwd  shift, and go to state 5
    drop       shift, and go to state 6
    insert     shift, and go to state 7
    rollback   shift, and go to state 8
    selectKwd  shift, and go to state 9
    truncate   shift, and go to state 10
    update     shift, and go to state 11

    $default  reduce using rule 41 (EmptyStmt)

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
    Statement             go to state 112
    TruncateTableStmt     go to state 26
    UpdateStmt            go to state 27


state 44

    1 AlterTableStmt: alter tableKwd TableName . add ColumnDef
    2               | alter tableKwd TableName . drop column ColumnName

    add   shift, and go to state 113
    drop  shift, and go to state 114


state 45

   29 CreateTableStmt: create tableKwd ifKwd . not exists TableName '(' ColumnDef CreateTableStmt1 CreateTableStmt2 ')'

    not  shift, and go to state 115


state 46

   28 CreateTableStmt: create tableKwd TableName . '(' ColumnDef CreateTableStmt1 CreateTableStmt2 ')'

    '('  shift, and go to state 116


state 47

   22 CreateIndexStmt: create CreateIndexStmtUnique index . CreateIndexIfNotExists identifier on identifier '(' identifier ')'
   23                | create CreateIndexStmtUnique index . CreateIndexIfNotExists identifier on identifier '(' identifier '(' ')' ')'
   24 CreateIndexIfNotExists: .  [identifier]
   25                       | . ifKwd not exists

    ifKwd  shift, and go to state 117

    $default  reduce using rule 24 (CreateIndexIfNotExists)

    CreateIndexIfNotExists  go to state 118


state 48

   34 DeleteFromStmt: deleteKwd from TableName .  [$end, ';']
   35               | deleteKwd from TableName . WhereClause
  197 WhereClause: . where Expression

    where  shift, and go to state 119

    $default  reduce using rule 34 (DeleteFromStmt)

    WhereClause  go to state 120


state 49

   38 DropIndexIfExists: ifKwd . exists

    exists  shift, and go to state 121


state 50

   36 DropIndexStmt: drop index DropIndexIfExists . identifier

    identifier  shift, and go to state 122


state 51

   40 DropTableStmt: drop tableKwd ifKwd . exists TableName

    exists  shift, and go to state 123


state 52

   39 DropTableStmt: drop tableKwd TableName .

    $default  reduce using rule 39 (DropTableStmt)


state 53

   71 InsertIntoStmt: insert into TableName . InsertIntoStmt1 values '(' ExpressionList ')' InsertIntoStmt2 InsertIntoStmt3
   72               | insert into TableName . InsertIntoStmt1 SelectStmt
   73 InsertIntoStmt1: .  [selectKwd, values]
   74                | . '(' ColumnNameList ')'

    '('  shift, and go to state 124

    $default  reduce using rule 73 (InsertIntoStmt1)

    InsertIntoStmt1  go to state 125


state 54

  165 Type: bigIntType .

    $default  reduce using rule 165 (Type)


state 55

  166 Type: bigRatType .

    $default  reduce using rule 166 (Type)


state 56

  167 Type: blobType .

    $default  reduce using rule 167 (Type)


state 57

  168 Type: boolType .

    $default  reduce using rule 168 (Type)


state 58

  169 Type: byteType .

    $default  reduce using rule 169 (Type)


state 59

  170 Type: complex128Type .

    $default  reduce using rule 170 (Type)


state 60

  171 Type: complex64Type .

    $default  reduce using rule 171 (Type)


state 61

  172 Type: durationType .

    $default  reduce using rule 172 (Type)


state 62

   79 Literal: falseKwd .

    $default  reduce using rule 79 (Literal)


state 63

  173 Type: floatType .

    $default  reduce using rule 173 (Type)


state 64

  174 Type: float32Type .

    $default  reduce using rule 174 (Type)


state 65

  175 Type: float64Type .

    $default  reduce using rule 175 (Type)


state 66

   82 Literal: floatLit .

    $default  reduce using rule 82 (Literal)


state 67

  112 QualifiedIdent: identifier .  [$end, and, andand, andnot, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, lsh, neq, not, offset, order, oror, rsh, where, ',', '(', ')', '>', '<', '[', ']', '^', '|', '-', '+', '&', '%', '/', '*', ';', ':']
  113               | identifier . '.' identifier

    '.'  shift, and go to state 126

    $default  reduce using rule 112 (QualifiedIdent)


state 68

   83 Literal: imaginaryLit .

    $default  reduce using rule 83 (Literal)


state 69

  176 Type: intType .

    $default  reduce using rule 176 (Type)


state 70

  177 Type: int16Type .

    $default  reduce using rule 177 (Type)


state 71

  178 Type: int32Type .

    $default  reduce using rule 178 (Type)


state 72

  179 Type: int64Type .

    $default  reduce using rule 179 (Type)


state 73

  180 Type: int8Type .

    $default  reduce using rule 180 (Type)


state 74

   84 Literal: intLit .

    $default  reduce using rule 84 (Literal)


state 75

   80 Literal: null .

    $default  reduce using rule 80 (Literal)


state 76

   87 Operand: qlParam .

    $default  reduce using rule 87 (Operand)


state 77

  181 Type: runeType .

    $default  reduce using rule 181 (Type)


state 78

  182 Type: stringType .

    $default  reduce using rule 182 (Type)


state 79

   85 Literal: stringLit .

    $default  reduce using rule 85 (Literal)


state 80

  183 Type: timeType .

    $default  reduce using rule 183 (Type)


state 81

   81 Literal: trueKwd .

    $default  reduce using rule 81 (Literal)


state 82

  184 Type: uintType .

    $default  reduce using rule 184 (Type)


state 83

  185 Type: uint16Type .

    $default  reduce using rule 185 (Type)


state 84

  186 Type: uint32Type .

    $default  reduce using rule 186 (Type)


state 85

  187 Type: uint64Type .

    $default  reduce using rule 187 (Type)


state 86

  188 Type: uint8Type .

    $default  reduce using rule 188 (Type)


state 87

   21 Conversion: . Type '(' Expression ')'
   42 Expression: . Term
   43           | . Expression oror Term
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   89        | '(' . Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Expression         go to state 127
    Factor             go to state 95
    Factor1            go to state 96
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Term               go to state 106
    Type               go to state 107
    UnaryExpr          go to state 108


state 88

   21 Conversion: . Type '(' Expression ')'
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  193 UnaryExpr: '^' . PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 128
    QualifiedIdent     go to state 104
    Type               go to state 107


state 89

   21 Conversion: . Type '(' Expression ')'
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  195 UnaryExpr: '-' . PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 129
    QualifiedIdent     go to state 104
    Type               go to state 107


state 90

   21 Conversion: . Type '(' Expression ')'
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  196 UnaryExpr: '+' . PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 130
    QualifiedIdent     go to state 104
    Type               go to state 107


state 91

  132 SelectStmtFieldList: '*' .

    $default  reduce using rule 132 (SelectStmtFieldList)


state 92

   21 Conversion: . Type '(' Expression ')'
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  194 UnaryExpr: '!' . PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 131
    QualifiedIdent     go to state 104
    Type               go to state 107


state 93

   95 PrimaryExpression: Conversion .

    $default  reduce using rule 95 (PrimaryExpression)


state 94

   43 Expression: Expression . oror Term
   64 Field: Expression . Field1
   65 Field1: .  [from, ',']
   66       | . as identifier

    as    shift, and go to state 132
    oror  shift, and go to state 133

    $default  reduce using rule 65 (Field1)

    Field1  go to state 134


state 95

  162 Term: Factor .

    $default  reduce using rule 162 (Term)


state 96

   49 Factor: Factor1 .  [$end, andand, as, asc, desc, from, group, limit, offset, order, oror, where, ',', ')', ']', ';', ':']
   50       | Factor1 . in '(' ExpressionList ')'
   51       | Factor1 . not in '(' ExpressionList ')'
   52       | Factor1 . between PrimaryFactor and PrimaryFactor
   53       | Factor1 . not between PrimaryFactor and PrimaryFactor
   54       | Factor1 . is null
   55       | Factor1 . is not null
   57 Factor1: Factor1 . ge PrimaryFactor
   58        | Factor1 . '>' PrimaryFactor
   59        | Factor1 . le PrimaryFactor
   60        | Factor1 . '<' PrimaryFactor
   61        | Factor1 . neq PrimaryFactor
   62        | Factor1 . eq PrimaryFactor
   63        | Factor1 . like PrimaryFactor

    between  shift, and go to state 135
    eq       shift, and go to state 136
    ge       shift, and go to state 137
    in       shift, and go to state 138
    is       shift, and go to state 139
    le       shift, and go to state 140
    like     shift, and go to state 141
    neq      shift, and go to state 142
    not      shift, and go to state 143
    '>'      shift, and go to state 144
    '<'      shift, and go to state 145

    $default  reduce using rule 49 (Factor)


state 97

   67 FieldList: Field .

    $default  reduce using rule 67 (FieldList)


state 98

   68 FieldList: FieldList . ',' Field
  133 SelectStmtFieldList: FieldList .  [from]
  134                    | FieldList . ','

    ','  shift, and go to state 146

    $default  reduce using rule 133 (SelectStmtFieldList)


state 99

   86 Operand: Literal .

    $default  reduce using rule 86 (Operand)


state 100

   94 PrimaryExpression: Operand .

    $default  reduce using rule 94 (PrimaryExpression)


state 101

   10 Call: . '(' Call1 ')'
   70 Index: . '[' Expression ']'
   96 PrimaryExpression: PrimaryExpression . Index
   97                  | PrimaryExpression . Slice
   98                  | PrimaryExpression . Call
  141 Slice: . '[' ':' ']'
  142      | . '[' ':' Expression ']'
  143      | . '[' Expression ':' ']'
  144      | . '[' Expression ':' Expression ']'
  192 UnaryExpr: PrimaryExpression .  [$end, and, andand, andnot, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, lsh, neq, not, offset, order, oror, rsh, where, ',', ')', '>', '<', ']', '^', '|', '-', '+', '&', '%', '/', '*', ';', ':']

    '('  shift, and go to state 147
    '['  shift, and go to state 148

    $default  reduce using rule 192 (UnaryExpr)

    Call   go to state 149
    Index  go to state 150
    Slice  go to state 151


state 102

   56 Factor1: PrimaryFactor .  [$end, andand, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, neq, not, offset, order, oror, where, ',', ')', '>', '<', ']', ';', ':']
  100 PrimaryFactor: PrimaryFactor . '^' PrimaryTerm
  101              | PrimaryFactor . '|' PrimaryTerm
  102              | PrimaryFactor . '-' PrimaryTerm
  103              | PrimaryFactor . '+' PrimaryTerm

    '^'  shift, and go to state 152
    '|'  shift, and go to state 153
    '-'  shift, and go to state 154
    '+'  shift, and go to state 155

    $default  reduce using rule 56 (Factor1)


state 103

   99 PrimaryFactor: PrimaryTerm .  [$end, and, andand, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, neq, not, offset, order, oror, where, ',', ')', '>', '<', ']', '^', '|', '-', '+', ';', ':']
  105 PrimaryTerm: PrimaryTerm . andnot UnaryExpr
  106            | PrimaryTerm . '&' UnaryExpr
  107            | PrimaryTerm . lsh UnaryExpr
  108            | PrimaryTerm . rsh UnaryExpr
  109            | PrimaryTerm . '%' UnaryExpr
  110            | PrimaryTerm . '/' UnaryExpr
  111            | PrimaryTerm . '*' UnaryExpr

    andnot  shift, and go to state 156
    lsh     shift, and go to state 157
    rsh     shift, and go to state 158
    '&'     shift, and go to state 159
    '%'     shift, and go to state 160
    '/'     shift, and go to state 161
    '*'     shift, and go to state 162

    $default  reduce using rule 99 (PrimaryFactor)


state 104

   88 Operand: QualifiedIdent .

    $default  reduce using rule 88 (Operand)


state 105

  124 SelectStmt: selectKwd SelectStmtDistinct SelectStmtFieldList . from RecordSetList SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset
  125           | selectKwd SelectStmtDistinct SelectStmtFieldList . from RecordSetList ',' SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset

    from  shift, and go to state 163


state 106

   42 Expression: Term .  [$end, as, asc, desc, from, group, limit, offset, order, oror, where, ',', ')', ']', ';', ':']
  163 Term: Term . andand Factor

    andand  shift, and go to state 164

    $default  reduce using rule 42 (Expression)


state 107

   21 Conversion: Type . '(' Expression ')'

    '('  shift, and go to state 165


state 108

  104 PrimaryTerm: UnaryExpr .

    $default  reduce using rule 104 (PrimaryTerm)


state 109

  164 TruncateTableStmt: truncate tableKwd TableName .

    $default  reduce using rule 164 (TruncateTableStmt)


state 110

  199 oSet: set .

    $default  reduce using rule 199 (oSet)


state 111

    3 Assignment: . ColumnName '=' Expression
    4 AssignmentList: . Assignment AssignmentList1 AssignmentList2
   14 ColumnName: . identifier
  189 UpdateStmt: update TableName oSet . AssignmentList UpdateStmt1

    identifier  shift, and go to state 166

    Assignment      go to state 167
    AssignmentList  go to state 168
    ColumnName      go to state 169


state 112

  160 StatementList: StatementList ';' Statement .

    $default  reduce using rule 160 (StatementList)


state 113

    1 AlterTableStmt: alter tableKwd TableName add . ColumnDef
   13 ColumnDef: . ColumnName Type
   14 ColumnName: . identifier

    identifier  shift, and go to state 166

    ColumnDef   go to state 170
    ColumnName  go to state 171


state 114

    2 AlterTableStmt: alter tableKwd TableName drop . column ColumnName

    column  shift, and go to state 172


state 115

   29 CreateTableStmt: create tableKwd ifKwd not . exists TableName '(' ColumnDef CreateTableStmt1 CreateTableStmt2 ')'

    exists  shift, and go to state 173


state 116

   13 ColumnDef: . ColumnName Type
   14 ColumnName: . identifier
   28 CreateTableStmt: create tableKwd TableName '(' . ColumnDef CreateTableStmt1 CreateTableStmt2 ')'

    identifier  shift, and go to state 166

    ColumnDef   go to state 174
    ColumnName  go to state 171


state 117

   25 CreateIndexIfNotExists: ifKwd . not exists

    not  shift, and go to state 175


state 118

   22 CreateIndexStmt: create CreateIndexStmtUnique index CreateIndexIfNotExists . identifier on identifier '(' identifier ')'
   23                | create CreateIndexStmtUnique index CreateIndexIfNotExists . identifier on identifier '(' identifier '(' ')' ')'

    identifier  shift, and go to state 176


state 119

   21 Conversion: . Type '(' Expression ')'
   42 Expression: . Term
   43           | . Expression oror Term
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression
  197 WhereClause: where . Expression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Expression         go to state 177
    Factor             go to state 95
    Factor1            go to state 96
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Term               go to state 106
    Type               go to state 107
    UnaryExpr          go to state 108


state 120

   35 DeleteFromStmt: deleteKwd from TableName WhereClause .

    $default  reduce using rule 35 (DeleteFromStmt)


state 121

   38 DropIndexIfExists: ifKwd exists .

    $default  reduce using rule 38 (DropIndexIfExists)


state 122

   36 DropIndexStmt: drop index DropIndexIfExists identifier .

    $default  reduce using rule 36 (DropIndexStmt)


state 123

   40 DropTableStmt: drop tableKwd ifKwd exists . TableName
  161 TableName: . identifier

    identifier  shift, and go to state 40

    TableName  go to state 178


state 124

   14 ColumnName: . identifier
   15 ColumnNameList: . ColumnName ColumnNameList1 ColumnNameList2
   74 InsertIntoStmt1: '(' . ColumnNameList ')'

    identifier  shift, and go to state 166

    ColumnName      go to state 179
    ColumnNameList  go to state 180


state 125

   71 InsertIntoStmt: insert into TableName InsertIntoStmt1 . values '(' ExpressionList ')' InsertIntoStmt2 InsertIntoStmt3
   72               | insert into TableName InsertIntoStmt1 . SelectStmt
  124 SelectStmt: . selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset
  125           | . selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList ',' SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset

    selectKwd  shift, and go to state 9
    values     shift, and go to state 181

    SelectStmt  go to state 182


state 126

  113 QualifiedIdent: identifier '.' . identifier

    identifier  shift, and go to state 183


state 127

   43 Expression: Expression . oror Term
   89 Operand: '(' Expression . ')'

    oror  shift, and go to state 133
    ')'   shift, and go to state 184


state 128

   10 Call: . '(' Call1 ')'
   70 Index: . '[' Expression ']'
   96 PrimaryExpression: PrimaryExpression . Index
   97                  | PrimaryExpression . Slice
   98                  | PrimaryExpression . Call
  141 Slice: . '[' ':' ']'
  142      | . '[' ':' Expression ']'
  143      | . '[' Expression ':' ']'
  144      | . '[' Expression ':' Expression ']'
  193 UnaryExpr: '^' PrimaryExpression .  [$end, and, andand, andnot, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, lsh, neq, not, offset, order, oror, rsh, where, ',', ')', '>', '<', ']', '^', '|', '-', '+', '&', '%', '/', '*', ';', ':']

    '('  shift, and go to state 147
    '['  shift, and go to state 148

    $default  reduce using rule 193 (UnaryExpr)

    Call   go to state 149
    Index  go to state 150
    Slice  go to state 151


state 129

   10 Call: . '(' Call1 ')'
   70 Index: . '[' Expression ']'
   96 PrimaryExpression: PrimaryExpression . Index
   97                  | PrimaryExpression . Slice
   98                  | PrimaryExpression . Call
  141 Slice: . '[' ':' ']'
  142      | . '[' ':' Expression ']'
  143      | . '[' Expression ':' ']'
  144      | . '[' Expression ':' Expression ']'
  195 UnaryExpr: '-' PrimaryExpression .  [$end, and, andand, andnot, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, lsh, neq, not, offset, order, oror, rsh, where, ',', ')', '>', '<', ']', '^', '|', '-', '+', '&', '%', '/', '*', ';', ':']

    '('  shift, and go to state 147
    '['  shift, and go to state 148

    $default  reduce using rule 195 (UnaryExpr)

    Call   go to state 149
    Index  go to state 150
    Slice  go to state 151


state 130

   10 Call: . '(' Call1 ')'
   70 Index: . '[' Expression ']'
   96 PrimaryExpression: PrimaryExpression . Index
   97                  | PrimaryExpression . Slice
   98                  | PrimaryExpression . Call
  141 Slice: . '[' ':' ']'
  142      | . '[' ':' Expression ']'
  143      | . '[' Expression ':' ']'
  144      | . '[' Expression ':' Expression ']'
  196 UnaryExpr: '+' PrimaryExpression .  [$end, and, andand, andnot, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, lsh, neq, not, offset, order, oror, rsh, where, ',', ')', '>', '<', ']', '^', '|', '-', '+', '&', '%', '/', '*', ';', ':']

    '('  shift, and go to state 147
    '['  shift, and go to state 148

    $default  reduce using rule 196 (UnaryExpr)

    Call   go to state 149
    Index  go to state 150
    Slice  go to state 151


state 131

   10 Call: . '(' Call1 ')'
   70 Index: . '[' Expression ']'
   96 PrimaryExpression: PrimaryExpression . Index
   97                  | PrimaryExpression . Slice
   98                  | PrimaryExpression . Call
  141 Slice: . '[' ':' ']'
  142      | . '[' ':' Expression ']'
  143      | . '[' Expression ':' ']'
  144      | . '[' Expression ':' Expression ']'
  194 UnaryExpr: '!' PrimaryExpression .  [$end, and, andand, andnot, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, lsh, neq, not, offset, order, oror, rsh, where, ',', ')', '>', '<', ']', '^', '|', '-', '+', '&', '%', '/', '*', ';', ':']

    '('  shift, and go to state 147
    '['  shift, and go to state 148

    $default  reduce using rule 194 (UnaryExpr)

    Call   go to state 149
    Index  go to state 150
    Slice  go to state 151


state 132

   66 Field1: as . identifier

    identifier  shift, and go to state 185


state 133

   21 Conversion: . Type '(' Expression ')'
   43 Expression: Expression oror . Term
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Factor             go to state 95
    Factor1            go to state 96
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Term               go to state 186
    Type               go to state 107
    UnaryExpr          go to state 108


state 134

   64 Field: Expression Field1 .

    $default  reduce using rule 64 (Field)


state 135

   21 Conversion: . Type '(' Expression ')'
   52 Factor: Factor1 between . PrimaryFactor and PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 187
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 108


state 136

   21 Conversion: . Type '(' Expression ')'
   62 Factor1: Factor1 eq . PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 188
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 108


state 137

   21 Conversion: . Type '(' Expression ')'
   57 Factor1: Factor1 ge . PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 189
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 108


state 138

   50 Factor: Factor1 in . '(' ExpressionList ')'

    '('  shift, and go to state 190


state 139

   54 Factor: Factor1 is . null
   55       | Factor1 is . not null

    not   shift, and go to state 191
    null  shift, and go to state 192


state 140

   21 Conversion: . Type '(' Expression ')'
   59 Factor1: Factor1 le . PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 193
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 108


state 141

   21 Conversion: . Type '(' Expression ')'
   63 Factor1: Factor1 like . PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 194
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 108


state 142

   21 Conversion: . Type '(' Expression ')'
   61 Factor1: Factor1 neq . PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 195
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 108


state 143

   51 Factor: Factor1 not . in '(' ExpressionList ')'
   53       | Factor1 not . between PrimaryFactor and PrimaryFactor

    between  shift, and go to state 196
    in       shift, and go to state 197


state 144

   21 Conversion: . Type '(' Expression ')'
   58 Factor1: Factor1 '>' . PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 198
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 108


state 145

   21 Conversion: . Type '(' Expression ')'
   60 Factor1: Factor1 '<' . PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 199
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 108


state 146

   21 Conversion: . Type '(' Expression ')'
   42 Expression: . Term
   43           | . Expression oror Term
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   64 Field: . Expression Field1
   68 FieldList: FieldList ',' . Field
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  134 SelectStmtFieldList: FieldList ',' .  [from]
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    $default  reduce using rule 134 (SelectStmtFieldList)

    Conversion         go to state 93
    Expression         go to state 94
    Factor             go to state 95
    Factor1            go to state 96
    Field              go to state 200
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Term               go to state 106
    Type               go to state 107
    UnaryExpr          go to state 108


state 147

   10 Call: '(' . Call1 ')'
   11 Call1: .  [')']
   12      | . ExpressionList
   21 Conversion: . Type '(' Expression ')'
   42 Expression: . Term
   43           | . Expression oror Term
   44 ExpressionList: . Expression ExpressionList1 ExpressionList2
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    $default  reduce using rule 11 (Call1)

    Call1              go to state 201
    Conversion         go to state 93
    Expression         go to state 202
    ExpressionList     go to state 203
    Factor             go to state 95
    Factor1            go to state 96
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Term               go to state 106
    Type               go to state 107
    UnaryExpr          go to state 108


state 148

   21 Conversion: . Type '(' Expression ')'
   42 Expression: . Term
   43           | . Expression oror Term
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   70 Index: '[' . Expression ']'
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  141 Slice: '[' . ':' ']'
  142      | '[' . ':' Expression ']'
  143      | '[' . Expression ':' ']'
  144      | '[' . Expression ':' Expression ']'
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    ':'             shift, and go to state 204
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Expression         go to state 205
    Factor             go to state 95
    Factor1            go to state 96
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Term               go to state 106
    Type               go to state 107
    UnaryExpr          go to state 108


state 149

   98 PrimaryExpression: PrimaryExpression Call .

    $default  reduce using rule 98 (PrimaryExpression)


state 150

   96 PrimaryExpression: PrimaryExpression Index .

    $default  reduce using rule 96 (PrimaryExpression)


state 151

   97 PrimaryExpression: PrimaryExpression Slice .

    $default  reduce using rule 97 (PrimaryExpression)


state 152

   21 Conversion: . Type '(' Expression ')'
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
  100 PrimaryFactor: PrimaryFactor '^' . PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryTerm        go to state 206
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 108


state 153

   21 Conversion: . Type '(' Expression ')'
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
  101 PrimaryFactor: PrimaryFactor '|' . PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryTerm        go to state 207
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 108


state 154

   21 Conversion: . Type '(' Expression ')'
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
  102 PrimaryFactor: PrimaryFactor '-' . PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryTerm        go to state 208
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 108


state 155

   21 Conversion: . Type '(' Expression ')'
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
  103 PrimaryFactor: PrimaryFactor '+' . PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryTerm        go to state 209
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 108


state 156

   21 Conversion: . Type '(' Expression ')'
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
  105 PrimaryTerm: PrimaryTerm andnot . UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 210


state 157

   21 Conversion: . Type '(' Expression ')'
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
  107 PrimaryTerm: PrimaryTerm lsh . UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 211


state 158

   21 Conversion: . Type '(' Expression ')'
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
  108 PrimaryTerm: PrimaryTerm rsh . UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 212


state 159

   21 Conversion: . Type '(' Expression ')'
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
  106 PrimaryTerm: PrimaryTerm '&' . UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 213


state 160

   21 Conversion: . Type '(' Expression ')'
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
  109 PrimaryTerm: PrimaryTerm '%' . UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 214


state 161

   21 Conversion: . Type '(' Expression ')'
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
  110 PrimaryTerm: PrimaryTerm '/' . UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 215


state 162

   21 Conversion: . Type '(' Expression ')'
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
  111 PrimaryTerm: PrimaryTerm '*' . UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 216


state 163

  114 RecordSet: . RecordSet1 RecordSet2
  115 RecordSet1: . identifier
  116           | . '(' SelectStmt RecordSet11 ')'
  121 RecordSetList: . RecordSet
  122              | . RecordSetList ',' RecordSet
  124 SelectStmt: selectKwd SelectStmtDistinct SelectStmtFieldList from . RecordSetList SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset
  125           | selectKwd SelectStmtDistinct SelectStmtFieldList from . RecordSetList ',' SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset

    identifier  shift, and go to state 217
    '('         shift, and go to state 218

    RecordSet      go to state 219
    RecordSet1     go to state 220
    RecordSetList  go to state 221


state 164

   21 Conversion: . Type '(' Expression ')'
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  163 Term: Term andand . Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Factor             go to state 222
    Factor1            go to state 96
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 108


state 165

   21 Conversion: . Type '(' Expression ')'
   21           | Type '(' . Expression ')'
   42 Expression: . Term
   43           | . Expression oror Term
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Expression         go to state 223
    Factor             go to state 95
    Factor1            go to state 96
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Term               go to state 106
    Type               go to state 107
    UnaryExpr          go to state 108


state 166

   14 ColumnName: identifier .

    $default  reduce using rule 14 (ColumnName)


state 167

    4 AssignmentList: Assignment . AssignmentList1 AssignmentList2
    5 AssignmentList1: .
    6                | . AssignmentList1 ',' Assignment

    $default  reduce using rule 5 (AssignmentList1)

    AssignmentList1  go to state 224


state 168

  189 UpdateStmt: update TableName oSet AssignmentList . UpdateStmt1
  190 UpdateStmt1: .  [$end, ';']
  191            | . WhereClause
  197 WhereClause: . where Expression

    where  shift, and go to state 119

    $default  reduce using rule 190 (UpdateStmt1)

    UpdateStmt1  go to state 225
    WhereClause  go to state 226


state 169

    3 Assignment: ColumnName . '=' Expression

    '='  shift, and go to state 227


state 170

    1 AlterTableStmt: alter tableKwd TableName add ColumnDef .

    $default  reduce using rule 1 (AlterTableStmt)


state 171

   13 ColumnDef: ColumnName . Type
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    timeType        shift, and go to state 80
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86

    Type  go to state 228


state 172

    2 AlterTableStmt: alter tableKwd TableName drop column . ColumnName
   14 ColumnName: . identifier

    identifier  shift, and go to state 166

    ColumnName  go to state 229


state 173

   29 CreateTableStmt: create tableKwd ifKwd not exists . TableName '(' ColumnDef CreateTableStmt1 CreateTableStmt2 ')'
  161 TableName: . identifier

    identifier  shift, and go to state 40

    TableName  go to state 230


state 174

   28 CreateTableStmt: create tableKwd TableName '(' ColumnDef . CreateTableStmt1 CreateTableStmt2 ')'
   30 CreateTableStmt1: .
   31                 | . CreateTableStmt1 ',' ColumnDef

    $default  reduce using rule 30 (CreateTableStmt1)

    CreateTableStmt1  go to state 231


state 175

   25 CreateIndexIfNotExists: ifKwd not . exists

    exists  shift, and go to state 232


state 176

   22 CreateIndexStmt: create CreateIndexStmtUnique index CreateIndexIfNotExists identifier . on identifier '(' identifier ')'
   23                | create CreateIndexStmtUnique index CreateIndexIfNotExists identifier . on identifier '(' identifier '(' ')' ')'

    on  shift, and go to state 233


state 177

   43 Expression: Expression . oror Term
  197 WhereClause: where Expression .  [$end, group, limit, offset, order, ')', ';']

    oror  shift, and go to state 133

    $default  reduce using rule 197 (WhereClause)


state 178

   40 DropTableStmt: drop tableKwd ifKwd exists TableName .

    $default  reduce using rule 40 (DropTableStmt)


state 179

   15 ColumnNameList: ColumnName . ColumnNameList1 ColumnNameList2
   16 ColumnNameList1: .
   17                | . ColumnNameList1 ',' ColumnName

    $default  reduce using rule 16 (ColumnNameList1)

    ColumnNameList1  go to state 234


state 180

   74 InsertIntoStmt1: '(' ColumnNameList . ')'

    ')'  shift, and go to state 235


state 181

   71 InsertIntoStmt: insert into TableName InsertIntoStmt1 values . '(' ExpressionList ')' InsertIntoStmt2 InsertIntoStmt3

    '('  shift, and go to state 236


state 182

   72 InsertIntoStmt: insert into TableName InsertIntoStmt1 SelectStmt .

    $default  reduce using rule 72 (InsertIntoStmt)


state 183

  113 QualifiedIdent: identifier '.' identifier .

    $default  reduce using rule 113 (QualifiedIdent)


state 184

   89 Operand: '(' Expression ')' .

    $default  reduce using rule 89 (Operand)


state 185

   66 Field1: as identifier .

    $default  reduce using rule 66 (Field1)


state 186

   43 Expression: Expression oror Term .  [$end, as, asc, desc, from, group, limit, offset, order, oror, where, ',', ')', ']', ';', ':']
  163 Term: Term . andand Factor

    andand  shift, and go to state 164

    $default  reduce using rule 43 (Expression)


state 187

   52 Factor: Factor1 between PrimaryFactor . and PrimaryFactor
  100 PrimaryFactor: PrimaryFactor . '^' PrimaryTerm
  101              | PrimaryFactor . '|' PrimaryTerm
  102              | PrimaryFactor . '-' PrimaryTerm
  103              | PrimaryFactor . '+' PrimaryTerm

    and  shift, and go to state 237
    '^'  shift, and go to state 152
    '|'  shift, and go to state 153
    '-'  shift, and go to state 154
    '+'  shift, and go to state 155


state 188

   62 Factor1: Factor1 eq PrimaryFactor .  [$end, andand, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, neq, not, offset, order, oror, where, ',', ')', '>', '<', ']', ';', ':']
  100 PrimaryFactor: PrimaryFactor . '^' PrimaryTerm
  101              | PrimaryFactor . '|' PrimaryTerm
  102              | PrimaryFactor . '-' PrimaryTerm
  103              | PrimaryFactor . '+' PrimaryTerm

    '^'  shift, and go to state 152
    '|'  shift, and go to state 153
    '-'  shift, and go to state 154
    '+'  shift, and go to state 155

    $default  reduce using rule 62 (Factor1)


state 189

   57 Factor1: Factor1 ge PrimaryFactor .  [$end, andand, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, neq, not, offset, order, oror, where, ',', ')', '>', '<', ']', ';', ':']
  100 PrimaryFactor: PrimaryFactor . '^' PrimaryTerm
  101              | PrimaryFactor . '|' PrimaryTerm
  102              | PrimaryFactor . '-' PrimaryTerm
  103              | PrimaryFactor . '+' PrimaryTerm

    '^'  shift, and go to state 152
    '|'  shift, and go to state 153
    '-'  shift, and go to state 154
    '+'  shift, and go to state 155

    $default  reduce using rule 57 (Factor1)


state 190

   21 Conversion: . Type '(' Expression ')'
   42 Expression: . Term
   43           | . Expression oror Term
   44 ExpressionList: . Expression ExpressionList1 ExpressionList2
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   50       | Factor1 in '(' . ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Expression         go to state 202
    ExpressionList     go to state 238
    Factor             go to state 95
    Factor1            go to state 96
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Term               go to state 106
    Type               go to state 107
    UnaryExpr          go to state 108


state 191

   55 Factor: Factor1 is not . null

    null  shift, and go to state 239


state 192

   54 Factor: Factor1 is null .

    $default  reduce using rule 54 (Factor)


state 193

   59 Factor1: Factor1 le PrimaryFactor .  [$end, andand, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, neq, not, offset, order, oror, where, ',', ')', '>', '<', ']', ';', ':']
  100 PrimaryFactor: PrimaryFactor . '^' PrimaryTerm
  101              | PrimaryFactor . '|' PrimaryTerm
  102              | PrimaryFactor . '-' PrimaryTerm
  103              | PrimaryFactor . '+' PrimaryTerm

    '^'  shift, and go to state 152
    '|'  shift, and go to state 153
    '-'  shift, and go to state 154
    '+'  shift, and go to state 155

    $default  reduce using rule 59 (Factor1)


state 194

   63 Factor1: Factor1 like PrimaryFactor .  [$end, andand, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, neq, not, offset, order, oror, where, ',', ')', '>', '<', ']', ';', ':']
  100 PrimaryFactor: PrimaryFactor . '^' PrimaryTerm
  101              | PrimaryFactor . '|' PrimaryTerm
  102              | PrimaryFactor . '-' PrimaryTerm
  103              | PrimaryFactor . '+' PrimaryTerm

    '^'  shift, and go to state 152
    '|'  shift, and go to state 153
    '-'  shift, and go to state 154
    '+'  shift, and go to state 155

    $default  reduce using rule 63 (Factor1)


state 195

   61 Factor1: Factor1 neq PrimaryFactor .  [$end, andand, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, neq, not, offset, order, oror, where, ',', ')', '>', '<', ']', ';', ':']
  100 PrimaryFactor: PrimaryFactor . '^' PrimaryTerm
  101              | PrimaryFactor . '|' PrimaryTerm
  102              | PrimaryFactor . '-' PrimaryTerm
  103              | PrimaryFactor . '+' PrimaryTerm

    '^'  shift, and go to state 152
    '|'  shift, and go to state 153
    '-'  shift, and go to state 154
    '+'  shift, and go to state 155

    $default  reduce using rule 61 (Factor1)


state 196

   21 Conversion: . Type '(' Expression ')'
   53 Factor: Factor1 not between . PrimaryFactor and PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 240
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 108


state 197

   51 Factor: Factor1 not in . '(' ExpressionList ')'

    '('  shift, and go to state 241


state 198

   58 Factor1: Factor1 '>' PrimaryFactor .  [$end, andand, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, neq, not, offset, order, oror, where, ',', ')', '>', '<', ']', ';', ':']
  100 PrimaryFactor: PrimaryFactor . '^' PrimaryTerm
  101              | PrimaryFactor . '|' PrimaryTerm
  102              | PrimaryFactor . '-' PrimaryTerm
  103              | PrimaryFactor . '+' PrimaryTerm

    '^'  shift, and go to state 152
    '|'  shift, and go to state 153
    '-'  shift, and go to state 154
    '+'  shift, and go to state 155

    $default  reduce using rule 58 (Factor1)


state 199

   60 Factor1: Factor1 '<' PrimaryFactor .  [$end, andand, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, neq, not, offset, order, oror, where, ',', ')', '>', '<', ']', ';', ':']
  100 PrimaryFactor: PrimaryFactor . '^' PrimaryTerm
  101              | PrimaryFactor . '|' PrimaryTerm
  102              | PrimaryFactor . '-' PrimaryTerm
  103              | PrimaryFactor . '+' PrimaryTerm

    '^'  shift, and go to state 152
    '|'  shift, and go to state 153
    '-'  shift, and go to state 154
    '+'  shift, and go to state 155

    $default  reduce using rule 60 (Factor1)


state 200

   68 FieldList: FieldList ',' Field .

    $default  reduce using rule 68 (FieldList)


state 201

   10 Call: '(' Call1 . ')'

    ')'  shift, and go to state 242


state 202

   43 Expression: Expression . oror Term
   44 ExpressionList: Expression . ExpressionList1 ExpressionList2
   45 ExpressionList1: .  [$end, asc, desc, limit, offset, ',', ')', ';']
   46                | . ExpressionList1 ',' Expression

    oror  shift, and go to state 133

    $default  reduce using rule 45 (ExpressionList1)

    ExpressionList1  go to state 243


state 203

   12 Call1: ExpressionList .

    $default  reduce using rule 12 (Call1)


state 204

   21 Conversion: . Type '(' Expression ')'
   42 Expression: . Term
   43           | . Expression oror Term
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  141 Slice: '[' ':' . ']'
  142      | '[' ':' . Expression ']'
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    ']'             shift, and go to state 244
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Expression         go to state 245
    Factor             go to state 95
    Factor1            go to state 96
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Term               go to state 106
    Type               go to state 107
    UnaryExpr          go to state 108


state 205

   43 Expression: Expression . oror Term
   70 Index: '[' Expression . ']'
  143 Slice: '[' Expression . ':' ']'
  144      | '[' Expression . ':' Expression ']'

    oror  shift, and go to state 133
    ']'   shift, and go to state 246
    ':'   shift, and go to state 247


state 206

  100 PrimaryFactor: PrimaryFactor '^' PrimaryTerm .  [$end, and, andand, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, neq, not, offset, order, oror, where, ',', ')', '>', '<', ']', '^', '|', '-', '+', ';', ':']
  105 PrimaryTerm: PrimaryTerm . andnot UnaryExpr
  106            | PrimaryTerm . '&' UnaryExpr
  107            | PrimaryTerm . lsh UnaryExpr
  108            | PrimaryTerm . rsh UnaryExpr
  109            | PrimaryTerm . '%' UnaryExpr
  110            | PrimaryTerm . '/' UnaryExpr
  111            | PrimaryTerm . '*' UnaryExpr

    andnot  shift, and go to state 156
    lsh     shift, and go to state 157
    rsh     shift, and go to state 158
    '&'     shift, and go to state 159
    '%'     shift, and go to state 160
    '/'     shift, and go to state 161
    '*'     shift, and go to state 162

    $default  reduce using rule 100 (PrimaryFactor)


state 207

  101 PrimaryFactor: PrimaryFactor '|' PrimaryTerm .  [$end, and, andand, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, neq, not, offset, order, oror, where, ',', ')', '>', '<', ']', '^', '|', '-', '+', ';', ':']
  105 PrimaryTerm: PrimaryTerm . andnot UnaryExpr
  106            | PrimaryTerm . '&' UnaryExpr
  107            | PrimaryTerm . lsh UnaryExpr
  108            | PrimaryTerm . rsh UnaryExpr
  109            | PrimaryTerm . '%' UnaryExpr
  110            | PrimaryTerm . '/' UnaryExpr
  111            | PrimaryTerm . '*' UnaryExpr

    andnot  shift, and go to state 156
    lsh     shift, and go to state 157
    rsh     shift, and go to state 158
    '&'     shift, and go to state 159
    '%'     shift, and go to state 160
    '/'     shift, and go to state 161
    '*'     shift, and go to state 162

    $default  reduce using rule 101 (PrimaryFactor)


state 208

  102 PrimaryFactor: PrimaryFactor '-' PrimaryTerm .  [$end, and, andand, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, neq, not, offset, order, oror, where, ',', ')', '>', '<', ']', '^', '|', '-', '+', ';', ':']
  105 PrimaryTerm: PrimaryTerm . andnot UnaryExpr
  106            | PrimaryTerm . '&' UnaryExpr
  107            | PrimaryTerm . lsh UnaryExpr
  108            | PrimaryTerm . rsh UnaryExpr
  109            | PrimaryTerm . '%' UnaryExpr
  110            | PrimaryTerm . '/' UnaryExpr
  111            | PrimaryTerm . '*' UnaryExpr

    andnot  shift, and go to state 156
    lsh     shift, and go to state 157
    rsh     shift, and go to state 158
    '&'     shift, and go to state 159
    '%'     shift, and go to state 160
    '/'     shift, and go to state 161
    '*'     shift, and go to state 162

    $default  reduce using rule 102 (PrimaryFactor)


state 209

  103 PrimaryFactor: PrimaryFactor '+' PrimaryTerm .  [$end, and, andand, as, asc, between, desc, eq, from, ge, group, in, is, le, like, limit, neq, not, offset, order, oror, where, ',', ')', '>', '<', ']', '^', '|', '-', '+', ';', ':']
  105 PrimaryTerm: PrimaryTerm . andnot UnaryExpr
  106            | PrimaryTerm . '&' UnaryExpr
  107            | PrimaryTerm . lsh UnaryExpr
  108            | PrimaryTerm . rsh UnaryExpr
  109            | PrimaryTerm . '%' UnaryExpr
  110            | PrimaryTerm . '/' UnaryExpr
  111            | PrimaryTerm . '*' UnaryExpr

    andnot  shift, and go to state 156
    lsh     shift, and go to state 157
    rsh     shift, and go to state 158
    '&'     shift, and go to state 159
    '%'     shift, and go to state 160
    '/'     shift, and go to state 161
    '*'     shift, and go to state 162

    $default  reduce using rule 103 (PrimaryFactor)


state 210

  105 PrimaryTerm: PrimaryTerm andnot UnaryExpr .

    $default  reduce using rule 105 (PrimaryTerm)


state 211

  107 PrimaryTerm: PrimaryTerm lsh UnaryExpr .

    $default  reduce using rule 107 (PrimaryTerm)


state 212

  108 PrimaryTerm: PrimaryTerm rsh UnaryExpr .

    $default  reduce using rule 108 (PrimaryTerm)


state 213

  106 PrimaryTerm: PrimaryTerm '&' UnaryExpr .

    $default  reduce using rule 106 (PrimaryTerm)


state 214

  109 PrimaryTerm: PrimaryTerm '%' UnaryExpr .

    $default  reduce using rule 109 (PrimaryTerm)


state 215

  110 PrimaryTerm: PrimaryTerm '/' UnaryExpr .

    $default  reduce using rule 110 (PrimaryTerm)


state 216

  111 PrimaryTerm: PrimaryTerm '*' UnaryExpr .

    $default  reduce using rule 111 (PrimaryTerm)


state 217

  115 RecordSet1: identifier .

    $default  reduce using rule 115 (RecordSet1)


state 218

  116 RecordSet1: '(' . SelectStmt RecordSet11 ')'
  124 SelectStmt: . selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset
  125           | . selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList ',' SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset

    selectKwd  shift, and go to state 9

    SelectStmt  go to state 248


state 219

  121 RecordSetList: RecordSet .

    $default  reduce using rule 121 (RecordSetList)


state 220

  114 RecordSet: RecordSet1 . RecordSet2
  119 RecordSet2: .  [$end, group, limit, offset, order, where, ',', ')', ';']
  120           | . as identifier

    as  shift, and go to state 249

    $default  reduce using rule 119 (RecordSet2)

    RecordSet2  go to state 250


state 221

  122 RecordSetList: RecordSetList . ',' RecordSet
  124 SelectStmt: selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList . SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset
  125           | selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList . ',' SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset
  135 SelectStmtWhere: .  [$end, group, limit, offset, order, ')', ';']
  136                | . WhereClause
  197 WhereClause: . where Expression

    where  shift, and go to state 119
    ','    shift, and go to state 251

    $default  reduce using rule 135 (SelectStmtWhere)

    SelectStmtWhere  go to state 252
    WhereClause      go to state 253


state 222

  163 Term: Term andand Factor .

    $default  reduce using rule 163 (Term)


state 223

   21 Conversion: Type '(' Expression . ')'
   43 Expression: Expression . oror Term

    oror  shift, and go to state 133
    ')'   shift, and go to state 254


state 224

    4 AssignmentList: Assignment AssignmentList1 . AssignmentList2
    6 AssignmentList1: AssignmentList1 . ',' Assignment
    7 AssignmentList2: .  [$end, where, ';']
    8                | . ','

    ','  shift, and go to state 255

    $default  reduce using rule 7 (AssignmentList2)

    AssignmentList2  go to state 256


state 225

  189 UpdateStmt: update TableName oSet AssignmentList UpdateStmt1 .

    $default  reduce using rule 189 (UpdateStmt)


state 226

  191 UpdateStmt1: WhereClause .

    $default  reduce using rule 191 (UpdateStmt1)


state 227

    3 Assignment: ColumnName '=' . Expression
   21 Conversion: . Type '(' Expression ')'
   42 Expression: . Term
   43           | . Expression oror Term
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Expression         go to state 257
    Factor             go to state 95
    Factor1            go to state 96
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Term               go to state 106
    Type               go to state 107
    UnaryExpr          go to state 108


state 228

   13 ColumnDef: ColumnName Type .

    $default  reduce using rule 13 (ColumnDef)


state 229

    2 AlterTableStmt: alter tableKwd TableName drop column ColumnName .

    $default  reduce using rule 2 (AlterTableStmt)


state 230

   29 CreateTableStmt: create tableKwd ifKwd not exists TableName . '(' ColumnDef CreateTableStmt1 CreateTableStmt2 ')'

    '('  shift, and go to state 258


state 231

   28 CreateTableStmt: create tableKwd TableName '(' ColumnDef CreateTableStmt1 . CreateTableStmt2 ')'
   31 CreateTableStmt1: CreateTableStmt1 . ',' ColumnDef
   32 CreateTableStmt2: .  [')']
   33                 | . ','

    ','  shift, and go to state 259

    $default  reduce using rule 32 (CreateTableStmt2)

    CreateTableStmt2  go to state 260


state 232

   25 CreateIndexIfNotExists: ifKwd not exists .

    $default  reduce using rule 25 (CreateIndexIfNotExists)


state 233

   22 CreateIndexStmt: create CreateIndexStmtUnique index CreateIndexIfNotExists identifier on . identifier '(' identifier ')'
   23                | create CreateIndexStmtUnique index CreateIndexIfNotExists identifier on . identifier '(' identifier '(' ')' ')'

    identifier  shift, and go to state 261


state 234

   15 ColumnNameList: ColumnName ColumnNameList1 . ColumnNameList2
   17 ColumnNameList1: ColumnNameList1 . ',' ColumnName
   18 ColumnNameList2: .  [$end, limit, offset, order, ')', ';']
   19                | . ','

    ','  shift, and go to state 262

    $default  reduce using rule 18 (ColumnNameList2)

    ColumnNameList2  go to state 263


state 235

   74 InsertIntoStmt1: '(' ColumnNameList ')' .

    $default  reduce using rule 74 (InsertIntoStmt1)


state 236

   21 Conversion: . Type '(' Expression ')'
   42 Expression: . Term
   43           | . Expression oror Term
   44 ExpressionList: . Expression ExpressionList1 ExpressionList2
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   71 InsertIntoStmt: insert into TableName InsertIntoStmt1 values '(' . ExpressionList ')' InsertIntoStmt2 InsertIntoStmt3
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Expression         go to state 202
    ExpressionList     go to state 264
    Factor             go to state 95
    Factor1            go to state 96
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Term               go to state 106
    Type               go to state 107
    UnaryExpr          go to state 108


state 237

   21 Conversion: . Type '(' Expression ')'
   52 Factor: Factor1 between PrimaryFactor and . PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 265
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 108


state 238

   50 Factor: Factor1 in '(' ExpressionList . ')'

    ')'  shift, and go to state 266


state 239

   55 Factor: Factor1 is not null .

    $default  reduce using rule 55 (Factor)


state 240

   53 Factor: Factor1 not between PrimaryFactor . and PrimaryFactor
  100 PrimaryFactor: PrimaryFactor . '^' PrimaryTerm
  101              | PrimaryFactor . '|' PrimaryTerm
  102              | PrimaryFactor . '-' PrimaryTerm
  103              | PrimaryFactor . '+' PrimaryTerm

    and  shift, and go to state 267
    '^'  shift, and go to state 152
    '|'  shift, and go to state 153
    '-'  shift, and go to state 154
    '+'  shift, and go to state 155


state 241

   21 Conversion: . Type '(' Expression ')'
   42 Expression: . Term
   43           | . Expression oror Term
   44 ExpressionList: . Expression ExpressionList1 ExpressionList2
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   51       | Factor1 not in '(' . ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Expression         go to state 202
    ExpressionList     go to state 268
    Factor             go to state 95
    Factor1            go to state 96
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Term               go to state 106
    Type               go to state 107
    UnaryExpr          go to state 108


state 242

   10 Call: '(' Call1 ')' .

    $default  reduce using rule 10 (Call)


state 243

   44 ExpressionList: Expression ExpressionList1 . ExpressionList2
   46 ExpressionList1: ExpressionList1 . ',' Expression
   47 ExpressionList2: .  [$end, asc, desc, limit, offset, ')', ';']
   48                | . ','

    ','  shift, and go to state 269

    $default  reduce using rule 47 (ExpressionList2)

    ExpressionList2  go to state 270


state 244

  141 Slice: '[' ':' ']' .

    $default  reduce using rule 141 (Slice)


state 245

   43 Expression: Expression . oror Term
  142 Slice: '[' ':' Expression . ']'

    oror  shift, and go to state 133
    ']'   shift, and go to state 271


state 246

   70 Index: '[' Expression ']' .

    $default  reduce using rule 70 (Index)


state 247

   21 Conversion: . Type '(' Expression ')'
   42 Expression: . Term
   43           | . Expression oror Term
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  143 Slice: '[' Expression ':' . ']'
  144      | '[' Expression ':' . Expression ']'
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    ']'             shift, and go to state 272
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Expression         go to state 273
    Factor             go to state 95
    Factor1            go to state 96
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Term               go to state 106
    Type               go to state 107
    UnaryExpr          go to state 108


state 248

  116 RecordSet1: '(' SelectStmt . RecordSet11 ')'
  117 RecordSet11: .  [')']
  118            | . ';'

    ';'  shift, and go to state 274

    $default  reduce using rule 117 (RecordSet11)

    RecordSet11  go to state 275


state 249

  120 RecordSet2: as . identifier

    identifier  shift, and go to state 276


state 250

  114 RecordSet: RecordSet1 RecordSet2 .

    $default  reduce using rule 114 (RecordSet)


state 251

  114 RecordSet: . RecordSet1 RecordSet2
  115 RecordSet1: . identifier
  116           | . '(' SelectStmt RecordSet11 ')'
  122 RecordSetList: RecordSetList ',' . RecordSet
  125 SelectStmt: selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList ',' . SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset
  135 SelectStmtWhere: .  [$end, group, limit, offset, order, ')', ';']
  136                | . WhereClause
  197 WhereClause: . where Expression

    identifier  shift, and go to state 217
    where       shift, and go to state 119
    '('         shift, and go to state 218

    $default  reduce using rule 135 (SelectStmtWhere)

    RecordSet        go to state 277
    RecordSet1       go to state 220
    SelectStmtWhere  go to state 278
    WhereClause      go to state 253


state 252

   69 GroupByClause: . group by ColumnNameList
  124 SelectStmt: selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList SelectStmtWhere . SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset
  137 SelectStmtGroup: .  [$end, limit, offset, order, ')', ';']
  138                | . GroupByClause

    group  shift, and go to state 279

    $default  reduce using rule 137 (SelectStmtGroup)

    GroupByClause    go to state 280
    SelectStmtGroup  go to state 281


state 253

  136 SelectStmtWhere: WhereClause .

    $default  reduce using rule 136 (SelectStmtWhere)


state 254

   21 Conversion: Type '(' Expression ')' .

    $default  reduce using rule 21 (Conversion)


state 255

    3 Assignment: . ColumnName '=' Expression
    6 AssignmentList1: AssignmentList1 ',' . Assignment
    8 AssignmentList2: ',' .  [$end, where, ';']
   14 ColumnName: . identifier

    identifier  shift, and go to state 166

    $default  reduce using rule 8 (AssignmentList2)

    Assignment  go to state 282
    ColumnName  go to state 169


state 256

    4 AssignmentList: Assignment AssignmentList1 AssignmentList2 .

    $default  reduce using rule 4 (AssignmentList)


state 257

    3 Assignment: ColumnName '=' Expression .  [$end, where, ',', ';']
   43 Expression: Expression . oror Term

    oror  shift, and go to state 133

    $default  reduce using rule 3 (Assignment)


state 258

   13 ColumnDef: . ColumnName Type
   14 ColumnName: . identifier
   29 CreateTableStmt: create tableKwd ifKwd not exists TableName '(' . ColumnDef CreateTableStmt1 CreateTableStmt2 ')'

    identifier  shift, and go to state 166

    ColumnDef   go to state 283
    ColumnName  go to state 171


state 259

   13 ColumnDef: . ColumnName Type
   14 ColumnName: . identifier
   31 CreateTableStmt1: CreateTableStmt1 ',' . ColumnDef
   33 CreateTableStmt2: ',' .  [')']

    identifier  shift, and go to state 166

    $default  reduce using rule 33 (CreateTableStmt2)

    ColumnDef   go to state 284
    ColumnName  go to state 171


state 260

   28 CreateTableStmt: create tableKwd TableName '(' ColumnDef CreateTableStmt1 CreateTableStmt2 . ')'

    ')'  shift, and go to state 285


state 261

   22 CreateIndexStmt: create CreateIndexStmtUnique index CreateIndexIfNotExists identifier on identifier . '(' identifier ')'
   23                | create CreateIndexStmtUnique index CreateIndexIfNotExists identifier on identifier . '(' identifier '(' ')' ')'

    '('  shift, and go to state 286


state 262

   14 ColumnName: . identifier
   17 ColumnNameList1: ColumnNameList1 ',' . ColumnName
   19 ColumnNameList2: ',' .  [$end, limit, offset, order, ')', ';']

    identifier  shift, and go to state 166

    $default  reduce using rule 19 (ColumnNameList2)

    ColumnName  go to state 287


state 263

   15 ColumnNameList: ColumnName ColumnNameList1 ColumnNameList2 .

    $default  reduce using rule 15 (ColumnNameList)


state 264

   71 InsertIntoStmt: insert into TableName InsertIntoStmt1 values '(' ExpressionList . ')' InsertIntoStmt2 InsertIntoStmt3

    ')'  shift, and go to state 288


state 265

   52 Factor: Factor1 between PrimaryFactor and PrimaryFactor .  [$end, andand, as, asc, desc, from, group, limit, offset, order, oror, where, ',', ')', ']', ';', ':']
  100 PrimaryFactor: PrimaryFactor . '^' PrimaryTerm
  101              | PrimaryFactor . '|' PrimaryTerm
  102              | PrimaryFactor . '-' PrimaryTerm
  103              | PrimaryFactor . '+' PrimaryTerm

    '^'  shift, and go to state 152
    '|'  shift, and go to state 153
    '-'  shift, and go to state 154
    '+'  shift, and go to state 155

    $default  reduce using rule 52 (Factor)


state 266

   50 Factor: Factor1 in '(' ExpressionList ')' .

    $default  reduce using rule 50 (Factor)


state 267

   21 Conversion: . Type '(' Expression ')'
   53 Factor: Factor1 not between PrimaryFactor and . PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 289
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Type               go to state 107
    UnaryExpr          go to state 108


state 268

   51 Factor: Factor1 not in '(' ExpressionList . ')'

    ')'  shift, and go to state 290


state 269

   21 Conversion: . Type '(' Expression ')'
   42 Expression: . Term
   43           | . Expression oror Term
   46 ExpressionList1: ExpressionList1 ',' . Expression
   48 ExpressionList2: ',' .  [$end, asc, desc, limit, offset, ')', ';']
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    $default  reduce using rule 48 (ExpressionList2)

    Conversion         go to state 93
    Expression         go to state 291
    Factor             go to state 95
    Factor1            go to state 96
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Term               go to state 106
    Type               go to state 107
    UnaryExpr          go to state 108


state 270

   44 ExpressionList: Expression ExpressionList1 ExpressionList2 .

    $default  reduce using rule 44 (ExpressionList)


state 271

  142 Slice: '[' ':' Expression ']' .

    $default  reduce using rule 142 (Slice)


state 272

  143 Slice: '[' Expression ':' ']' .

    $default  reduce using rule 143 (Slice)


state 273

   43 Expression: Expression . oror Term
  144 Slice: '[' Expression ':' Expression . ']'

    oror  shift, and go to state 133
    ']'   shift, and go to state 292


state 274

  118 RecordSet11: ';' .

    $default  reduce using rule 118 (RecordSet11)


state 275

  116 RecordSet1: '(' SelectStmt RecordSet11 . ')'

    ')'  shift, and go to state 293


state 276

  120 RecordSet2: as identifier .

    $default  reduce using rule 120 (RecordSet2)


state 277

  122 RecordSetList: RecordSetList ',' RecordSet .

    $default  reduce using rule 122 (RecordSetList)


state 278

   69 GroupByClause: . group by ColumnNameList
  125 SelectStmt: selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList ',' SelectStmtWhere . SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset
  137 SelectStmtGroup: .  [$end, limit, offset, order, ')', ';']
  138                | . GroupByClause

    group  shift, and go to state 279

    $default  reduce using rule 137 (SelectStmtGroup)

    GroupByClause    go to state 280
    SelectStmtGroup  go to state 294


state 279

   69 GroupByClause: group . by ColumnNameList

    by  shift, and go to state 295


state 280

  138 SelectStmtGroup: GroupByClause .

    $default  reduce using rule 138 (SelectStmtGroup)


state 281

   90 OrderBy: . order by ExpressionList OrderBy1
  124 SelectStmt: selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList SelectStmtWhere SelectStmtGroup . SelectStmtOrder SelectStmtLimit SelectStmtOffset
  139 SelectStmtOrder: .  [$end, limit, offset, ')', ';']
  140                | . OrderBy

    order  shift, and go to state 296

    $default  reduce using rule 139 (SelectStmtOrder)

    OrderBy          go to state 297
    SelectStmtOrder  go to state 298


state 282

    6 AssignmentList1: AssignmentList1 ',' Assignment .

    $default  reduce using rule 6 (AssignmentList1)


state 283

   29 CreateTableStmt: create tableKwd ifKwd not exists TableName '(' ColumnDef . CreateTableStmt1 CreateTableStmt2 ')'
   30 CreateTableStmt1: .
   31                 | . CreateTableStmt1 ',' ColumnDef

    $default  reduce using rule 30 (CreateTableStmt1)

    CreateTableStmt1  go to state 299


state 284

   31 CreateTableStmt1: CreateTableStmt1 ',' ColumnDef .

    $default  reduce using rule 31 (CreateTableStmt1)


state 285

   28 CreateTableStmt: create tableKwd TableName '(' ColumnDef CreateTableStmt1 CreateTableStmt2 ')' .

    $default  reduce using rule 28 (CreateTableStmt)


state 286

   22 CreateIndexStmt: create CreateIndexStmtUnique index CreateIndexIfNotExists identifier on identifier '(' . identifier ')'
   23                | create CreateIndexStmtUnique index CreateIndexIfNotExists identifier on identifier '(' . identifier '(' ')' ')'

    identifier  shift, and go to state 300


state 287

   17 ColumnNameList1: ColumnNameList1 ',' ColumnName .

    $default  reduce using rule 17 (ColumnNameList1)


state 288

   71 InsertIntoStmt: insert into TableName InsertIntoStmt1 values '(' ExpressionList ')' . InsertIntoStmt2 InsertIntoStmt3
   75 InsertIntoStmt2: .
   76                | . InsertIntoStmt2 ',' '(' ExpressionList ')'

    $default  reduce using rule 75 (InsertIntoStmt2)

    InsertIntoStmt2  go to state 301


state 289

   53 Factor: Factor1 not between PrimaryFactor and PrimaryFactor .  [$end, andand, as, asc, desc, from, group, limit, offset, order, oror, where, ',', ')', ']', ';', ':']
  100 PrimaryFactor: PrimaryFactor . '^' PrimaryTerm
  101              | PrimaryFactor . '|' PrimaryTerm
  102              | PrimaryFactor . '-' PrimaryTerm
  103              | PrimaryFactor . '+' PrimaryTerm

    '^'  shift, and go to state 152
    '|'  shift, and go to state 153
    '-'  shift, and go to state 154
    '+'  shift, and go to state 155

    $default  reduce using rule 53 (Factor)


state 290

   51 Factor: Factor1 not in '(' ExpressionList ')' .

    $default  reduce using rule 51 (Factor)


state 291

   43 Expression: Expression . oror Term
   46 ExpressionList1: ExpressionList1 ',' Expression .  [$end, asc, desc, limit, offset, ',', ')', ';']

    oror  shift, and go to state 133

    $default  reduce using rule 46 (ExpressionList1)


state 292

  144 Slice: '[' Expression ':' Expression ']' .

    $default  reduce using rule 144 (Slice)


state 293

  116 RecordSet1: '(' SelectStmt RecordSet11 ')' .

    $default  reduce using rule 116 (RecordSet1)


state 294

   90 OrderBy: . order by ExpressionList OrderBy1
  125 SelectStmt: selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList ',' SelectStmtWhere SelectStmtGroup . SelectStmtOrder SelectStmtLimit SelectStmtOffset
  139 SelectStmtOrder: .  [$end, limit, offset, ')', ';']
  140                | . OrderBy

    order  shift, and go to state 296

    $default  reduce using rule 139 (SelectStmtOrder)

    OrderBy          go to state 297
    SelectStmtOrder  go to state 302


state 295

   14 ColumnName: . identifier
   15 ColumnNameList: . ColumnName ColumnNameList1 ColumnNameList2
   69 GroupByClause: group by . ColumnNameList

    identifier  shift, and go to state 166

    ColumnName      go to state 179
    ColumnNameList  go to state 303


state 296

   90 OrderBy: order . by ExpressionList OrderBy1

    by  shift, and go to state 304


state 297

  140 SelectStmtOrder: OrderBy .

    $default  reduce using rule 140 (SelectStmtOrder)


state 298

  124 SelectStmt: selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList SelectStmtWhere SelectStmtGroup SelectStmtOrder . SelectStmtLimit SelectStmtOffset
  126 SelectStmtLimit: .  [$end, offset, ')', ';']
  127                | . limit Expression

    limit  shift, and go to state 305

    $default  reduce using rule 126 (SelectStmtLimit)

    SelectStmtLimit  go to state 306


state 299

   29 CreateTableStmt: create tableKwd ifKwd not exists TableName '(' ColumnDef CreateTableStmt1 . CreateTableStmt2 ')'
   31 CreateTableStmt1: CreateTableStmt1 . ',' ColumnDef
   32 CreateTableStmt2: .  [')']
   33                 | . ','

    ','  shift, and go to state 259

    $default  reduce using rule 32 (CreateTableStmt2)

    CreateTableStmt2  go to state 307


state 300

   22 CreateIndexStmt: create CreateIndexStmtUnique index CreateIndexIfNotExists identifier on identifier '(' identifier . ')'
   23                | create CreateIndexStmtUnique index CreateIndexIfNotExists identifier on identifier '(' identifier . '(' ')' ')'

    '('  shift, and go to state 308
    ')'  shift, and go to state 309


state 301

   71 InsertIntoStmt: insert into TableName InsertIntoStmt1 values '(' ExpressionList ')' InsertIntoStmt2 . InsertIntoStmt3
   76 InsertIntoStmt2: InsertIntoStmt2 . ',' '(' ExpressionList ')'
   77 InsertIntoStmt3: .  [$end, ';']
   78                | . ','

    ','  shift, and go to state 310

    $default  reduce using rule 77 (InsertIntoStmt3)

    InsertIntoStmt3  go to state 311


state 302

  125 SelectStmt: selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList ',' SelectStmtWhere SelectStmtGroup SelectStmtOrder . SelectStmtLimit SelectStmtOffset
  126 SelectStmtLimit: .  [$end, offset, ')', ';']
  127                | . limit Expression

    limit  shift, and go to state 305

    $default  reduce using rule 126 (SelectStmtLimit)

    SelectStmtLimit  go to state 312


state 303

   69 GroupByClause: group by ColumnNameList .

    $default  reduce using rule 69 (GroupByClause)


state 304

   21 Conversion: . Type '(' Expression ')'
   42 Expression: . Term
   43           | . Expression oror Term
   44 ExpressionList: . Expression ExpressionList1 ExpressionList2
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   90 OrderBy: order by . ExpressionList OrderBy1
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Expression         go to state 202
    ExpressionList     go to state 313
    Factor             go to state 95
    Factor1            go to state 96
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Term               go to state 106
    Type               go to state 107
    UnaryExpr          go to state 108


state 305

   21 Conversion: . Type '(' Expression ')'
   42 Expression: . Term
   43           | . Expression oror Term
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  127 SelectStmtLimit: limit . Expression
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Expression         go to state 314
    Factor             go to state 95
    Factor1            go to state 96
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Term               go to state 106
    Type               go to state 107
    UnaryExpr          go to state 108


state 306

  124 SelectStmt: selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit . SelectStmtOffset
  128 SelectStmtOffset: .  [$end, ')', ';']
  129                 | . offset Expression

    offset  shift, and go to state 315

    $default  reduce using rule 128 (SelectStmtOffset)

    SelectStmtOffset  go to state 316


state 307

   29 CreateTableStmt: create tableKwd ifKwd not exists TableName '(' ColumnDef CreateTableStmt1 CreateTableStmt2 . ')'

    ')'  shift, and go to state 317


state 308

   23 CreateIndexStmt: create CreateIndexStmtUnique index CreateIndexIfNotExists identifier on identifier '(' identifier '(' . ')' ')'

    ')'  shift, and go to state 318


state 309

   22 CreateIndexStmt: create CreateIndexStmtUnique index CreateIndexIfNotExists identifier on identifier '(' identifier ')' .

    $default  reduce using rule 22 (CreateIndexStmt)


state 310

   76 InsertIntoStmt2: InsertIntoStmt2 ',' . '(' ExpressionList ')'
   78 InsertIntoStmt3: ',' .  [$end, ';']

    '('  shift, and go to state 319

    $default  reduce using rule 78 (InsertIntoStmt3)


state 311

   71 InsertIntoStmt: insert into TableName InsertIntoStmt1 values '(' ExpressionList ')' InsertIntoStmt2 InsertIntoStmt3 .

    $default  reduce using rule 71 (InsertIntoStmt)


state 312

  125 SelectStmt: selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList ',' SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit . SelectStmtOffset
  128 SelectStmtOffset: .  [$end, ')', ';']
  129                 | . offset Expression

    offset  shift, and go to state 315

    $default  reduce using rule 128 (SelectStmtOffset)

    SelectStmtOffset  go to state 320


state 313

   90 OrderBy: order by ExpressionList . OrderBy1
   91 OrderBy1: .  [$end, limit, offset, ')', ';']
   92         | . asc
   93         | . desc

    asc   shift, and go to state 321
    desc  shift, and go to state 322

    $default  reduce using rule 91 (OrderBy1)

    OrderBy1  go to state 323


state 314

   43 Expression: Expression . oror Term
  127 SelectStmtLimit: limit Expression .  [$end, offset, ')', ';']

    oror  shift, and go to state 133

    $default  reduce using rule 127 (SelectStmtLimit)


state 315

   21 Conversion: . Type '(' Expression ')'
   42 Expression: . Term
   43           | . Expression oror Term
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  129 SelectStmtOffset: offset . Expression
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Expression         go to state 324
    Factor             go to state 95
    Factor1            go to state 96
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Term               go to state 106
    Type               go to state 107
    UnaryExpr          go to state 108


state 316

  124 SelectStmt: selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset .

    $default  reduce using rule 124 (SelectStmt)


state 317

   29 CreateTableStmt: create tableKwd ifKwd not exists TableName '(' ColumnDef CreateTableStmt1 CreateTableStmt2 ')' .

    $default  reduce using rule 29 (CreateTableStmt)


state 318

   23 CreateIndexStmt: create CreateIndexStmtUnique index CreateIndexIfNotExists identifier on identifier '(' identifier '(' ')' . ')'

    ')'  shift, and go to state 325


state 319

   21 Conversion: . Type '(' Expression ')'
   42 Expression: . Term
   43           | . Expression oror Term
   44 ExpressionList: . Expression ExpressionList1 ExpressionList2
   49 Factor: . Factor1
   50       | . Factor1 in '(' ExpressionList ')'
   51       | . Factor1 not in '(' ExpressionList ')'
   52       | . Factor1 between PrimaryFactor and PrimaryFactor
   53       | . Factor1 not between PrimaryFactor and PrimaryFactor
   54       | . Factor1 is null
   55       | . Factor1 is not null
   56 Factor1: . PrimaryFactor
   57        | . Factor1 ge PrimaryFactor
   58        | . Factor1 '>' PrimaryFactor
   59        | . Factor1 le PrimaryFactor
   60        | . Factor1 '<' PrimaryFactor
   61        | . Factor1 neq PrimaryFactor
   62        | . Factor1 eq PrimaryFactor
   63        | . Factor1 like PrimaryFactor
   76 InsertIntoStmt2: InsertIntoStmt2 ',' '(' . ExpressionList ')'
   79 Literal: . falseKwd
   80        | . null
   81        | . trueKwd
   82        | . floatLit
   83        | . imaginaryLit
   84        | . intLit
   85        | . stringLit
   86 Operand: . Literal
   87        | . qlParam
   88        | . QualifiedIdent
   89        | . '(' Expression ')'
   94 PrimaryExpression: . Operand
   95                  | . Conversion
   96                  | . PrimaryExpression Index
   97                  | . PrimaryExpression Slice
   98                  | . PrimaryExpression Call
   99 PrimaryFactor: . PrimaryTerm
  100              | . PrimaryFactor '^' PrimaryTerm
  101              | . PrimaryFactor '|' PrimaryTerm
  102              | . PrimaryFactor '-' PrimaryTerm
  103              | . PrimaryFactor '+' PrimaryTerm
  104 PrimaryTerm: . UnaryExpr
  105            | . PrimaryTerm andnot UnaryExpr
  106            | . PrimaryTerm '&' UnaryExpr
  107            | . PrimaryTerm lsh UnaryExpr
  108            | . PrimaryTerm rsh UnaryExpr
  109            | . PrimaryTerm '%' UnaryExpr
  110            | . PrimaryTerm '/' UnaryExpr
  111            | . PrimaryTerm '*' UnaryExpr
  112 QualifiedIdent: . identifier
  113               | . identifier '.' identifier
  162 Term: . Factor
  163     | . Term andand Factor
  165 Type: . bigIntType
  166     | . bigRatType
  167     | . blobType
  168     | . boolType
  169     | . byteType
  170     | . complex128Type
  171     | . complex64Type
  172     | . durationType
  173     | . floatType
  174     | . float32Type
  175     | . float64Type
  176     | . intType
  177     | . int16Type
  178     | . int32Type
  179     | . int64Type
  180     | . int8Type
  181     | . runeType
  182     | . stringType
  183     | . timeType
  184     | . uintType
  185     | . uint16Type
  186     | . uint32Type
  187     | . uint64Type
  188     | . uint8Type
  192 UnaryExpr: . PrimaryExpression
  193          | . '^' PrimaryExpression
  194          | . '!' PrimaryExpression
  195          | . '-' PrimaryExpression
  196          | . '+' PrimaryExpression

    bigIntType      shift, and go to state 54
    bigRatType      shift, and go to state 55
    blobType        shift, and go to state 56
    boolType        shift, and go to state 57
    byteType        shift, and go to state 58
    complex128Type  shift, and go to state 59
    complex64Type   shift, and go to state 60
    durationType    shift, and go to state 61
    falseKwd        shift, and go to state 62
    floatType       shift, and go to state 63
    float32Type     shift, and go to state 64
    float64Type     shift, and go to state 65
    floatLit        shift, and go to state 66
    identifier      shift, and go to state 67
    imaginaryLit    shift, and go to state 68
    intType         shift, and go to state 69
    int16Type       shift, and go to state 70
    int32Type       shift, and go to state 71
    int64Type       shift, and go to state 72
    int8Type        shift, and go to state 73
    intLit          shift, and go to state 74
    null            shift, and go to state 75
    qlParam         shift, and go to state 76
    runeType        shift, and go to state 77
    stringType      shift, and go to state 78
    stringLit       shift, and go to state 79
    timeType        shift, and go to state 80
    trueKwd         shift, and go to state 81
    uintType        shift, and go to state 82
    uint16Type      shift, and go to state 83
    uint32Type      shift, and go to state 84
    uint64Type      shift, and go to state 85
    uint8Type       shift, and go to state 86
    '('             shift, and go to state 87
    '^'             shift, and go to state 88
    '-'             shift, and go to state 89
    '+'             shift, and go to state 90
    '!'             shift, and go to state 92

    Conversion         go to state 93
    Expression         go to state 202
    ExpressionList     go to state 326
    Factor             go to state 95
    Factor1            go to state 96
    Literal            go to state 99
    Operand            go to state 100
    PrimaryExpression  go to state 101
    PrimaryFactor      go to state 102
    PrimaryTerm        go to state 103
    QualifiedIdent     go to state 104
    Term               go to state 106
    Type               go to state 107
    UnaryExpr          go to state 108


state 320

  125 SelectStmt: selectKwd SelectStmtDistinct SelectStmtFieldList from RecordSetList ',' SelectStmtWhere SelectStmtGroup SelectStmtOrder SelectStmtLimit SelectStmtOffset .

    $default  reduce using rule 125 (SelectStmt)


state 321

   92 OrderBy1: asc .

    $default  reduce using rule 92 (OrderBy1)


state 322

   93 OrderBy1: desc .

    $default  reduce using rule 93 (OrderBy1)


state 323

   90 OrderBy: order by ExpressionList OrderBy1 .

    $default  reduce using rule 90 (OrderBy)


state 324

   43 Expression: Expression . oror Term
  129 SelectStmtOffset: offset Expression .  [$end, ')', ';']

    oror  shift, and go to state 133

    $default  reduce using rule 129 (SelectStmtOffset)


state 325

   23 CreateIndexStmt: create CreateIndexStmtUnique index CreateIndexIfNotExists identifier on identifier '(' identifier '(' ')' ')' .

    $default  reduce using rule 23 (CreateIndexStmt)


state 326

   76 InsertIntoStmt2: InsertIntoStmt2 ',' '(' ExpressionList . ')'

    ')'  shift, and go to state 327


state 327

   76 InsertIntoStmt2: InsertIntoStmt2 ',' '(' ExpressionList ')' .

    $default  reduce using rule 76 (InsertIntoStmt2)
