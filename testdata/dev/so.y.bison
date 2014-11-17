State 97 conflicts: 1 shift/reduce


Grammar

    0 $accept: program $end

    1 program: declaration_list

    2 declaration_list: declaration_list declaration
    3                 | declaration

    4 declaration: var_declaration
    5            | fun_declaration

    6 var_declaration: type_specifier ID ';'
    7                | type_specifier ID '[' NUM ']' ';'

    8 type_specifier: INT
    9               | VOID

   10 fun_declaration: type_specifier ID '(' params ')' compound_stmt

   11 params: param_list
   12       | VOID

   13 param_list: param_list ',' param
   14           | param

   15 param: type_specifier ID
   16      | type_specifier ID '[' ']'

   17 compound_stmt: '{' local_declarations statement_list '}'

   18 local_declarations: local_declarations var_declaration
   19                   | /* empty */

   20 statement_list: statement_list statement
   21               | /* empty */

   22 statement: expression_stmt
   23          | compound_stmt
   24          | selection_stmt
   25          | iteration_stmt
   26          | return_stmt

   27 expression_stmt: expression ';'
   28                | ';'

   29 selection_stmt: IF '(' expression ')' statement
   30               | IF '(' expression ')' statement ELSE statement

   31 iteration_stmt: WHILE '(' expression ')' statement

   32 return_stmt: RETURN ';'
   33            | RETURN expression ';'

   34 expression: var '=' expression
   35           | simple_expression

   36 var: ID
   37    | ID '[' expression ']'

   38 simple_expression: additive_expression relop additive_expression
   39                  | additive_expression

   40 relop: LTE
   41      | '<'
   42      | '>'
   43      | GTE
   44      | EQUAL
   45      | NOTEQUAL

   46 additive_expression: additive_expression addop term
   47                    | term

   48 addop: '+'
   49      | '-'

   50 term: term mulop factor
   51     | factor

   52 mulop: '*'
   53      | '/'

   54 factor: '(' expression ')'
   55       | var
   56       | call
   57       | NUM

   58 call: ID '(' args ')'

   59 args: arg_list
   60     | /* empty */

   61 arg_list: arg_list ',' expression
   62         | expression


Terminals, with rules where they appear

$end (0) 0
'(' (40) 10 29 30 31 54 58
')' (41) 10 29 30 31 54 58
'*' (42) 52
'+' (43) 48
',' (44) 13 61
'-' (45) 49
'/' (47) 53
';' (59) 6 7 27 28 32 33
'<' (60) 41
'=' (61) 34
'>' (62) 42
'[' (91) 7 16 37
']' (93) 7 16 37
'{' (123) 17
'}' (125) 17
error (256)
ELSE (258) 30
IF (259) 29 30
INT (260) 8
RETURN (261) 32 33
VOID (262) 9 12
WHILE (263) 31
ID (264) 6 7 10 15 16 36 37 58
NUM (265) 7 57
LTE (266) 40
GTE (267) 43
EQUAL (268) 44
NOTEQUAL (269) 45
LOWER_THAN_ELSE (270)


Nonterminals, with rules where they appear

$accept (31)
    on left: 0
program (32)
    on left: 1, on right: 0
declaration_list (33)
    on left: 2 3, on right: 1 2
declaration (34)
    on left: 4 5, on right: 2 3
var_declaration (35)
    on left: 6 7, on right: 4 18
type_specifier (36)
    on left: 8 9, on right: 6 7 10 15 16
fun_declaration (37)
    on left: 10, on right: 5
params (38)
    on left: 11 12, on right: 10
param_list (39)
    on left: 13 14, on right: 11 13
param (40)
    on left: 15 16, on right: 13 14
compound_stmt (41)
    on left: 17, on right: 10 23
local_declarations (42)
    on left: 18 19, on right: 17 18
statement_list (43)
    on left: 20 21, on right: 17 20
statement (44)
    on left: 22 23 24 25 26, on right: 20 29 30 31
expression_stmt (45)
    on left: 27 28, on right: 22
selection_stmt (46)
    on left: 29 30, on right: 24
iteration_stmt (47)
    on left: 31, on right: 25
return_stmt (48)
    on left: 32 33, on right: 26
expression (49)
    on left: 34 35, on right: 27 29 30 31 33 34 37 54 61 62
var (50)
    on left: 36 37, on right: 34 55
simple_expression (51)
    on left: 38 39, on right: 35
relop (52)
    on left: 40 41 42 43 44 45, on right: 38
additive_expression (53)
    on left: 46 47, on right: 38 39 46
addop (54)
    on left: 48 49, on right: 46
term (55)
    on left: 50 51, on right: 46 47 50
mulop (56)
    on left: 52 53, on right: 50
factor (57)
    on left: 54 55 56 57, on right: 50 51
call (58)
    on left: 58, on right: 56
args (59)
    on left: 59 60, on right: 58
arg_list (60)
    on left: 61 62, on right: 59 61


state 0

    0 $accept: . program $end
    1 program: . declaration_list
    2 declaration_list: . declaration_list declaration
    3                 | . declaration
    4 declaration: . var_declaration
    5            | . fun_declaration
    6 var_declaration: . type_specifier ID ';'
    7                | . type_specifier ID '[' NUM ']' ';'
    8 type_specifier: . INT
    9               | . VOID
   10 fun_declaration: . type_specifier ID '(' params ')' compound_stmt

    INT   shift, and go to state 1
    VOID  shift, and go to state 2

    program           go to state 3
    declaration_list  go to state 4
    declaration       go to state 5
    var_declaration   go to state 6
    type_specifier    go to state 7
    fun_declaration   go to state 8


state 1

    8 type_specifier: INT .

    $default  reduce using rule 8 (type_specifier)


state 2

    9 type_specifier: VOID .

    $default  reduce using rule 9 (type_specifier)


state 3

    0 $accept: program . $end

    $end  shift, and go to state 9


state 4

    1 program: declaration_list .  [$end]
    2 declaration_list: declaration_list . declaration
    4 declaration: . var_declaration
    5            | . fun_declaration
    6 var_declaration: . type_specifier ID ';'
    7                | . type_specifier ID '[' NUM ']' ';'
    8 type_specifier: . INT
    9               | . VOID
   10 fun_declaration: . type_specifier ID '(' params ')' compound_stmt

    INT   shift, and go to state 1
    VOID  shift, and go to state 2

    $default  reduce using rule 1 (program)

    declaration      go to state 10
    var_declaration  go to state 6
    type_specifier   go to state 7
    fun_declaration  go to state 8


state 5

    3 declaration_list: declaration .

    $default  reduce using rule 3 (declaration_list)


state 6

    4 declaration: var_declaration .

    $default  reduce using rule 4 (declaration)


state 7

    6 var_declaration: type_specifier . ID ';'
    7                | type_specifier . ID '[' NUM ']' ';'
   10 fun_declaration: type_specifier . ID '(' params ')' compound_stmt

    ID  shift, and go to state 11


state 8

    5 declaration: fun_declaration .

    $default  reduce using rule 5 (declaration)


state 9

    0 $accept: program $end .

    $default  accept


state 10

    2 declaration_list: declaration_list declaration .

    $default  reduce using rule 2 (declaration_list)


state 11

    6 var_declaration: type_specifier ID . ';'
    7                | type_specifier ID . '[' NUM ']' ';'
   10 fun_declaration: type_specifier ID . '(' params ')' compound_stmt

    ';'  shift, and go to state 12
    '['  shift, and go to state 13
    '('  shift, and go to state 14


state 12

    6 var_declaration: type_specifier ID ';' .

    $default  reduce using rule 6 (var_declaration)


state 13

    7 var_declaration: type_specifier ID '[' . NUM ']' ';'

    NUM  shift, and go to state 15


state 14

    8 type_specifier: . INT
    9               | . VOID
   10 fun_declaration: type_specifier ID '(' . params ')' compound_stmt
   11 params: . param_list
   12       | . VOID
   13 param_list: . param_list ',' param
   14           | . param
   15 param: . type_specifier ID
   16      | . type_specifier ID '[' ']'

    INT   shift, and go to state 1
    VOID  shift, and go to state 16

    type_specifier  go to state 17
    params          go to state 18
    param_list      go to state 19
    param           go to state 20


state 15

    7 var_declaration: type_specifier ID '[' NUM . ']' ';'

    ']'  shift, and go to state 21


state 16

    9 type_specifier: VOID .  [ID]
   12 params: VOID .  [')']

    ')'       reduce using rule 12 (params)
    $default  reduce using rule 9 (type_specifier)


state 17

   15 param: type_specifier . ID
   16      | type_specifier . ID '[' ']'

    ID  shift, and go to state 22


state 18

   10 fun_declaration: type_specifier ID '(' params . ')' compound_stmt

    ')'  shift, and go to state 23


state 19

   11 params: param_list .  [')']
   13 param_list: param_list . ',' param

    ','  shift, and go to state 24

    $default  reduce using rule 11 (params)


state 20

   14 param_list: param .

    $default  reduce using rule 14 (param_list)


state 21

    7 var_declaration: type_specifier ID '[' NUM ']' . ';'

    ';'  shift, and go to state 25


state 22

   15 param: type_specifier ID .  [')', ',']
   16      | type_specifier ID . '[' ']'

    '['  shift, and go to state 26

    $default  reduce using rule 15 (param)


state 23

   10 fun_declaration: type_specifier ID '(' params ')' . compound_stmt
   17 compound_stmt: . '{' local_declarations statement_list '}'

    '{'  shift, and go to state 27

    compound_stmt  go to state 28


state 24

    8 type_specifier: . INT
    9               | . VOID
   13 param_list: param_list ',' . param
   15 param: . type_specifier ID
   16      | . type_specifier ID '[' ']'

    INT   shift, and go to state 1
    VOID  shift, and go to state 2

    type_specifier  go to state 17
    param           go to state 29


state 25

    7 var_declaration: type_specifier ID '[' NUM ']' ';' .

    $default  reduce using rule 7 (var_declaration)


state 26

   16 param: type_specifier ID '[' . ']'

    ']'  shift, and go to state 30


state 27

   17 compound_stmt: '{' . local_declarations statement_list '}'
   18 local_declarations: . local_declarations var_declaration
   19                   | .

    $default  reduce using rule 19 (local_declarations)

    local_declarations  go to state 31


state 28

   10 fun_declaration: type_specifier ID '(' params ')' compound_stmt .

    $default  reduce using rule 10 (fun_declaration)


state 29

   13 param_list: param_list ',' param .

    $default  reduce using rule 13 (param_list)


state 30

   16 param: type_specifier ID '[' ']' .

    $default  reduce using rule 16 (param)


state 31

    6 var_declaration: . type_specifier ID ';'
    7                | . type_specifier ID '[' NUM ']' ';'
    8 type_specifier: . INT
    9               | . VOID
   17 compound_stmt: '{' local_declarations . statement_list '}'
   18 local_declarations: local_declarations . var_declaration
   20 statement_list: . statement_list statement
   21               | .  [IF, RETURN, WHILE, ID, NUM, ';', '(', '{', '}']

    INT   shift, and go to state 1
    VOID  shift, and go to state 2

    $default  reduce using rule 21 (statement_list)

    var_declaration  go to state 32
    type_specifier   go to state 33
    statement_list   go to state 34


state 32

   18 local_declarations: local_declarations var_declaration .

    $default  reduce using rule 18 (local_declarations)


state 33

    6 var_declaration: type_specifier . ID ';'
    7                | type_specifier . ID '[' NUM ']' ';'

    ID  shift, and go to state 35


state 34

   17 compound_stmt: . '{' local_declarations statement_list '}'
   17              | '{' local_declarations statement_list . '}'
   20 statement_list: statement_list . statement
   22 statement: . expression_stmt
   23          | . compound_stmt
   24          | . selection_stmt
   25          | . iteration_stmt
   26          | . return_stmt
   27 expression_stmt: . expression ';'
   28                | . ';'
   29 selection_stmt: . IF '(' expression ')' statement
   30               | . IF '(' expression ')' statement ELSE statement
   31 iteration_stmt: . WHILE '(' expression ')' statement
   32 return_stmt: . RETURN ';'
   33            | . RETURN expression ';'
   34 expression: . var '=' expression
   35           | . simple_expression
   36 var: . ID
   37    | . ID '[' expression ']'
   38 simple_expression: . additive_expression relop additive_expression
   39                  | . additive_expression
   46 additive_expression: . additive_expression addop term
   47                    | . term
   50 term: . term mulop factor
   51     | . factor
   54 factor: . '(' expression ')'
   55       | . var
   56       | . call
   57       | . NUM
   58 call: . ID '(' args ')'

    IF      shift, and go to state 36
    RETURN  shift, and go to state 37
    WHILE   shift, and go to state 38
    ID      shift, and go to state 39
    NUM     shift, and go to state 40
    ';'     shift, and go to state 41
    '('     shift, and go to state 42
    '{'     shift, and go to state 27
    '}'     shift, and go to state 43

    compound_stmt        go to state 44
    statement            go to state 45
    expression_stmt      go to state 46
    selection_stmt       go to state 47
    iteration_stmt       go to state 48
    return_stmt          go to state 49
    expression           go to state 50
    var                  go to state 51
    simple_expression    go to state 52
    additive_expression  go to state 53
    term                 go to state 54
    factor               go to state 55
    call                 go to state 56


state 35

    6 var_declaration: type_specifier ID . ';'
    7                | type_specifier ID . '[' NUM ']' ';'

    ';'  shift, and go to state 12
    '['  shift, and go to state 13


state 36

   29 selection_stmt: IF . '(' expression ')' statement
   30               | IF . '(' expression ')' statement ELSE statement

    '('  shift, and go to state 57


state 37

   32 return_stmt: RETURN . ';'
   33            | RETURN . expression ';'
   34 expression: . var '=' expression
   35           | . simple_expression
   36 var: . ID
   37    | . ID '[' expression ']'
   38 simple_expression: . additive_expression relop additive_expression
   39                  | . additive_expression
   46 additive_expression: . additive_expression addop term
   47                    | . term
   50 term: . term mulop factor
   51     | . factor
   54 factor: . '(' expression ')'
   55       | . var
   56       | . call
   57       | . NUM
   58 call: . ID '(' args ')'

    ID   shift, and go to state 39
    NUM  shift, and go to state 40
    ';'  shift, and go to state 58
    '('  shift, and go to state 42

    expression           go to state 59
    var                  go to state 51
    simple_expression    go to state 52
    additive_expression  go to state 53
    term                 go to state 54
    factor               go to state 55
    call                 go to state 56


state 38

   31 iteration_stmt: WHILE . '(' expression ')' statement

    '('  shift, and go to state 60


state 39

   36 var: ID .  [LTE, GTE, EQUAL, NOTEQUAL, ';', ']', ')', ',', '=', '<', '>', '+', '-', '*', '/']
   37    | ID . '[' expression ']'
   58 call: ID . '(' args ')'

    '['  shift, and go to state 61
    '('  shift, and go to state 62

    $default  reduce using rule 36 (var)


state 40

   57 factor: NUM .

    $default  reduce using rule 57 (factor)


state 41

   28 expression_stmt: ';' .

    $default  reduce using rule 28 (expression_stmt)


state 42

   34 expression: . var '=' expression
   35           | . simple_expression
   36 var: . ID
   37    | . ID '[' expression ']'
   38 simple_expression: . additive_expression relop additive_expression
   39                  | . additive_expression
   46 additive_expression: . additive_expression addop term
   47                    | . term
   50 term: . term mulop factor
   51     | . factor
   54 factor: . '(' expression ')'
   54       | '(' . expression ')'
   55       | . var
   56       | . call
   57       | . NUM
   58 call: . ID '(' args ')'

    ID   shift, and go to state 39
    NUM  shift, and go to state 40
    '('  shift, and go to state 42

    expression           go to state 63
    var                  go to state 51
    simple_expression    go to state 52
    additive_expression  go to state 53
    term                 go to state 54
    factor               go to state 55
    call                 go to state 56


state 43

   17 compound_stmt: '{' local_declarations statement_list '}' .

    $default  reduce using rule 17 (compound_stmt)


state 44

   23 statement: compound_stmt .

    $default  reduce using rule 23 (statement)


state 45

   20 statement_list: statement_list statement .

    $default  reduce using rule 20 (statement_list)


state 46

   22 statement: expression_stmt .

    $default  reduce using rule 22 (statement)


state 47

   24 statement: selection_stmt .

    $default  reduce using rule 24 (statement)


state 48

   25 statement: iteration_stmt .

    $default  reduce using rule 25 (statement)


state 49

   26 statement: return_stmt .

    $default  reduce using rule 26 (statement)


state 50

   27 expression_stmt: expression . ';'

    ';'  shift, and go to state 64


state 51

   34 expression: var . '=' expression
   55 factor: var .  [LTE, GTE, EQUAL, NOTEQUAL, ';', ']', ')', ',', '<', '>', '+', '-', '*', '/']

    '='  shift, and go to state 65

    $default  reduce using rule 55 (factor)


state 52

   35 expression: simple_expression .

    $default  reduce using rule 35 (expression)


state 53

   38 simple_expression: additive_expression . relop additive_expression
   39                  | additive_expression .  [';', ']', ')', ',']
   40 relop: . LTE
   41      | . '<'
   42      | . '>'
   43      | . GTE
   44      | . EQUAL
   45      | . NOTEQUAL
   46 additive_expression: additive_expression . addop term
   48 addop: . '+'
   49      | . '-'

    LTE       shift, and go to state 66
    GTE       shift, and go to state 67
    EQUAL     shift, and go to state 68
    NOTEQUAL  shift, and go to state 69
    '<'       shift, and go to state 70
    '>'       shift, and go to state 71
    '+'       shift, and go to state 72
    '-'       shift, and go to state 73

    $default  reduce using rule 39 (simple_expression)

    relop  go to state 74
    addop  go to state 75


state 54

   47 additive_expression: term .  [LTE, GTE, EQUAL, NOTEQUAL, ';', ']', ')', ',', '<', '>', '+', '-']
   50 term: term . mulop factor
   52 mulop: . '*'
   53      | . '/'

    '*'  shift, and go to state 76
    '/'  shift, and go to state 77

    $default  reduce using rule 47 (additive_expression)

    mulop  go to state 78


state 55

   51 term: factor .

    $default  reduce using rule 51 (term)


state 56

   56 factor: call .

    $default  reduce using rule 56 (factor)


state 57

   29 selection_stmt: IF '(' . expression ')' statement
   30               | IF '(' . expression ')' statement ELSE statement
   34 expression: . var '=' expression
   35           | . simple_expression
   36 var: . ID
   37    | . ID '[' expression ']'
   38 simple_expression: . additive_expression relop additive_expression
   39                  | . additive_expression
   46 additive_expression: . additive_expression addop term
   47                    | . term
   50 term: . term mulop factor
   51     | . factor
   54 factor: . '(' expression ')'
   55       | . var
   56       | . call
   57       | . NUM
   58 call: . ID '(' args ')'

    ID   shift, and go to state 39
    NUM  shift, and go to state 40
    '('  shift, and go to state 42

    expression           go to state 79
    var                  go to state 51
    simple_expression    go to state 52
    additive_expression  go to state 53
    term                 go to state 54
    factor               go to state 55
    call                 go to state 56


state 58

   32 return_stmt: RETURN ';' .

    $default  reduce using rule 32 (return_stmt)


state 59

   33 return_stmt: RETURN expression . ';'

    ';'  shift, and go to state 80


state 60

   31 iteration_stmt: WHILE '(' . expression ')' statement
   34 expression: . var '=' expression
   35           | . simple_expression
   36 var: . ID
   37    | . ID '[' expression ']'
   38 simple_expression: . additive_expression relop additive_expression
   39                  | . additive_expression
   46 additive_expression: . additive_expression addop term
   47                    | . term
   50 term: . term mulop factor
   51     | . factor
   54 factor: . '(' expression ')'
   55       | . var
   56       | . call
   57       | . NUM
   58 call: . ID '(' args ')'

    ID   shift, and go to state 39
    NUM  shift, and go to state 40
    '('  shift, and go to state 42

    expression           go to state 81
    var                  go to state 51
    simple_expression    go to state 52
    additive_expression  go to state 53
    term                 go to state 54
    factor               go to state 55
    call                 go to state 56


state 61

   34 expression: . var '=' expression
   35           | . simple_expression
   36 var: . ID
   37    | . ID '[' expression ']'
   37    | ID '[' . expression ']'
   38 simple_expression: . additive_expression relop additive_expression
   39                  | . additive_expression
   46 additive_expression: . additive_expression addop term
   47                    | . term
   50 term: . term mulop factor
   51     | . factor
   54 factor: . '(' expression ')'
   55       | . var
   56       | . call
   57       | . NUM
   58 call: . ID '(' args ')'

    ID   shift, and go to state 39
    NUM  shift, and go to state 40
    '('  shift, and go to state 42

    expression           go to state 82
    var                  go to state 51
    simple_expression    go to state 52
    additive_expression  go to state 53
    term                 go to state 54
    factor               go to state 55
    call                 go to state 56


state 62

   34 expression: . var '=' expression
   35           | . simple_expression
   36 var: . ID
   37    | . ID '[' expression ']'
   38 simple_expression: . additive_expression relop additive_expression
   39                  | . additive_expression
   46 additive_expression: . additive_expression addop term
   47                    | . term
   50 term: . term mulop factor
   51     | . factor
   54 factor: . '(' expression ')'
   55       | . var
   56       | . call
   57       | . NUM
   58 call: . ID '(' args ')'
   58     | ID '(' . args ')'
   59 args: . arg_list
   60     | .  [')']
   61 arg_list: . arg_list ',' expression
   62         | . expression

    ID   shift, and go to state 39
    NUM  shift, and go to state 40
    '('  shift, and go to state 42

    $default  reduce using rule 60 (args)

    expression           go to state 83
    var                  go to state 51
    simple_expression    go to state 52
    additive_expression  go to state 53
    term                 go to state 54
    factor               go to state 55
    call                 go to state 56
    args                 go to state 84
    arg_list             go to state 85


state 63

   54 factor: '(' expression . ')'

    ')'  shift, and go to state 86


state 64

   27 expression_stmt: expression ';' .

    $default  reduce using rule 27 (expression_stmt)


state 65

   34 expression: . var '=' expression
   34           | var '=' . expression
   35           | . simple_expression
   36 var: . ID
   37    | . ID '[' expression ']'
   38 simple_expression: . additive_expression relop additive_expression
   39                  | . additive_expression
   46 additive_expression: . additive_expression addop term
   47                    | . term
   50 term: . term mulop factor
   51     | . factor
   54 factor: . '(' expression ')'
   55       | . var
   56       | . call
   57       | . NUM
   58 call: . ID '(' args ')'

    ID   shift, and go to state 39
    NUM  shift, and go to state 40
    '('  shift, and go to state 42

    expression           go to state 87
    var                  go to state 51
    simple_expression    go to state 52
    additive_expression  go to state 53
    term                 go to state 54
    factor               go to state 55
    call                 go to state 56


state 66

   40 relop: LTE .

    $default  reduce using rule 40 (relop)


state 67

   43 relop: GTE .

    $default  reduce using rule 43 (relop)


state 68

   44 relop: EQUAL .

    $default  reduce using rule 44 (relop)


state 69

   45 relop: NOTEQUAL .

    $default  reduce using rule 45 (relop)


state 70

   41 relop: '<' .

    $default  reduce using rule 41 (relop)


state 71

   42 relop: '>' .

    $default  reduce using rule 42 (relop)


state 72

   48 addop: '+' .

    $default  reduce using rule 48 (addop)


state 73

   49 addop: '-' .

    $default  reduce using rule 49 (addop)


state 74

   36 var: . ID
   37    | . ID '[' expression ']'
   38 simple_expression: additive_expression relop . additive_expression
   46 additive_expression: . additive_expression addop term
   47                    | . term
   50 term: . term mulop factor
   51     | . factor
   54 factor: . '(' expression ')'
   55       | . var
   56       | . call
   57       | . NUM
   58 call: . ID '(' args ')'

    ID   shift, and go to state 39
    NUM  shift, and go to state 40
    '('  shift, and go to state 42

    var                  go to state 88
    additive_expression  go to state 89
    term                 go to state 54
    factor               go to state 55
    call                 go to state 56


state 75

   36 var: . ID
   37    | . ID '[' expression ']'
   46 additive_expression: additive_expression addop . term
   50 term: . term mulop factor
   51     | . factor
   54 factor: . '(' expression ')'
   55       | . var
   56       | . call
   57       | . NUM
   58 call: . ID '(' args ')'

    ID   shift, and go to state 39
    NUM  shift, and go to state 40
    '('  shift, and go to state 42

    var     go to state 88
    term    go to state 90
    factor  go to state 55
    call    go to state 56


state 76

   52 mulop: '*' .

    $default  reduce using rule 52 (mulop)


state 77

   53 mulop: '/' .

    $default  reduce using rule 53 (mulop)


state 78

   36 var: . ID
   37    | . ID '[' expression ']'
   50 term: term mulop . factor
   54 factor: . '(' expression ')'
   55       | . var
   56       | . call
   57       | . NUM
   58 call: . ID '(' args ')'

    ID   shift, and go to state 39
    NUM  shift, and go to state 40
    '('  shift, and go to state 42

    var     go to state 88
    factor  go to state 91
    call    go to state 56


state 79

   29 selection_stmt: IF '(' expression . ')' statement
   30               | IF '(' expression . ')' statement ELSE statement

    ')'  shift, and go to state 92


state 80

   33 return_stmt: RETURN expression ';' .

    $default  reduce using rule 33 (return_stmt)


state 81

   31 iteration_stmt: WHILE '(' expression . ')' statement

    ')'  shift, and go to state 93


state 82

   37 var: ID '[' expression . ']'

    ']'  shift, and go to state 94


state 83

   62 arg_list: expression .

    $default  reduce using rule 62 (arg_list)


state 84

   58 call: ID '(' args . ')'

    ')'  shift, and go to state 95


state 85

   59 args: arg_list .  [')']
   61 arg_list: arg_list . ',' expression

    ','  shift, and go to state 96

    $default  reduce using rule 59 (args)


state 86

   54 factor: '(' expression ')' .

    $default  reduce using rule 54 (factor)


state 87

   34 expression: var '=' expression .

    $default  reduce using rule 34 (expression)


state 88

   55 factor: var .

    $default  reduce using rule 55 (factor)


state 89

   38 simple_expression: additive_expression relop additive_expression .  [';', ']', ')', ',']
   46 additive_expression: additive_expression . addop term
   48 addop: . '+'
   49      | . '-'

    '+'  shift, and go to state 72
    '-'  shift, and go to state 73

    $default  reduce using rule 38 (simple_expression)

    addop  go to state 75


state 90

   46 additive_expression: additive_expression addop term .  [LTE, GTE, EQUAL, NOTEQUAL, ';', ']', ')', ',', '<', '>', '+', '-']
   50 term: term . mulop factor
   52 mulop: . '*'
   53      | . '/'

    '*'  shift, and go to state 76
    '/'  shift, and go to state 77

    $default  reduce using rule 46 (additive_expression)

    mulop  go to state 78


state 91

   50 term: term mulop factor .

    $default  reduce using rule 50 (term)


state 92

   17 compound_stmt: . '{' local_declarations statement_list '}'
   22 statement: . expression_stmt
   23          | . compound_stmt
   24          | . selection_stmt
   25          | . iteration_stmt
   26          | . return_stmt
   27 expression_stmt: . expression ';'
   28                | . ';'
   29 selection_stmt: . IF '(' expression ')' statement
   29               | IF '(' expression ')' . statement
   30               | . IF '(' expression ')' statement ELSE statement
   30               | IF '(' expression ')' . statement ELSE statement
   31 iteration_stmt: . WHILE '(' expression ')' statement
   32 return_stmt: . RETURN ';'
   33            | . RETURN expression ';'
   34 expression: . var '=' expression
   35           | . simple_expression
   36 var: . ID
   37    | . ID '[' expression ']'
   38 simple_expression: . additive_expression relop additive_expression
   39                  | . additive_expression
   46 additive_expression: . additive_expression addop term
   47                    | . term
   50 term: . term mulop factor
   51     | . factor
   54 factor: . '(' expression ')'
   55       | . var
   56       | . call
   57       | . NUM
   58 call: . ID '(' args ')'

    IF      shift, and go to state 36
    RETURN  shift, and go to state 37
    WHILE   shift, and go to state 38
    ID      shift, and go to state 39
    NUM     shift, and go to state 40
    ';'     shift, and go to state 41
    '('     shift, and go to state 42
    '{'     shift, and go to state 27

    compound_stmt        go to state 44
    statement            go to state 97
    expression_stmt      go to state 46
    selection_stmt       go to state 47
    iteration_stmt       go to state 48
    return_stmt          go to state 49
    expression           go to state 50
    var                  go to state 51
    simple_expression    go to state 52
    additive_expression  go to state 53
    term                 go to state 54
    factor               go to state 55
    call                 go to state 56


state 93

   17 compound_stmt: . '{' local_declarations statement_list '}'
   22 statement: . expression_stmt
   23          | . compound_stmt
   24          | . selection_stmt
   25          | . iteration_stmt
   26          | . return_stmt
   27 expression_stmt: . expression ';'
   28                | . ';'
   29 selection_stmt: . IF '(' expression ')' statement
   30               | . IF '(' expression ')' statement ELSE statement
   31 iteration_stmt: . WHILE '(' expression ')' statement
   31               | WHILE '(' expression ')' . statement
   32 return_stmt: . RETURN ';'
   33            | . RETURN expression ';'
   34 expression: . var '=' expression
   35           | . simple_expression
   36 var: . ID
   37    | . ID '[' expression ']'
   38 simple_expression: . additive_expression relop additive_expression
   39                  | . additive_expression
   46 additive_expression: . additive_expression addop term
   47                    | . term
   50 term: . term mulop factor
   51     | . factor
   54 factor: . '(' expression ')'
   55       | . var
   56       | . call
   57       | . NUM
   58 call: . ID '(' args ')'

    IF      shift, and go to state 36
    RETURN  shift, and go to state 37
    WHILE   shift, and go to state 38
    ID      shift, and go to state 39
    NUM     shift, and go to state 40
    ';'     shift, and go to state 41
    '('     shift, and go to state 42
    '{'     shift, and go to state 27

    compound_stmt        go to state 44
    statement            go to state 98
    expression_stmt      go to state 46
    selection_stmt       go to state 47
    iteration_stmt       go to state 48
    return_stmt          go to state 49
    expression           go to state 50
    var                  go to state 51
    simple_expression    go to state 52
    additive_expression  go to state 53
    term                 go to state 54
    factor               go to state 55
    call                 go to state 56


state 94

   37 var: ID '[' expression ']' .

    $default  reduce using rule 37 (var)


state 95

   58 call: ID '(' args ')' .

    $default  reduce using rule 58 (call)


state 96

   34 expression: . var '=' expression
   35           | . simple_expression
   36 var: . ID
   37    | . ID '[' expression ']'
   38 simple_expression: . additive_expression relop additive_expression
   39                  | . additive_expression
   46 additive_expression: . additive_expression addop term
   47                    | . term
   50 term: . term mulop factor
   51     | . factor
   54 factor: . '(' expression ')'
   55       | . var
   56       | . call
   57       | . NUM
   58 call: . ID '(' args ')'
   61 arg_list: arg_list ',' . expression

    ID   shift, and go to state 39
    NUM  shift, and go to state 40
    '('  shift, and go to state 42

    expression           go to state 99
    var                  go to state 51
    simple_expression    go to state 52
    additive_expression  go to state 53
    term                 go to state 54
    factor               go to state 55
    call                 go to state 56


state 97

   29 selection_stmt: IF '(' expression ')' statement .  [ELSE, IF, RETURN, WHILE, ID, NUM, ';', '(', '{', '}']
   30               | IF '(' expression ')' statement . ELSE statement

    ELSE  shift, and go to state 100

    ELSE      [reduce using rule 29 (selection_stmt)]
    $default  reduce using rule 29 (selection_stmt)


state 98

   31 iteration_stmt: WHILE '(' expression ')' statement .

    $default  reduce using rule 31 (iteration_stmt)


state 99

   61 arg_list: arg_list ',' expression .

    $default  reduce using rule 61 (arg_list)


state 100

   17 compound_stmt: . '{' local_declarations statement_list '}'
   22 statement: . expression_stmt
   23          | . compound_stmt
   24          | . selection_stmt
   25          | . iteration_stmt
   26          | . return_stmt
   27 expression_stmt: . expression ';'
   28                | . ';'
   29 selection_stmt: . IF '(' expression ')' statement
   30               | . IF '(' expression ')' statement ELSE statement
   30               | IF '(' expression ')' statement ELSE . statement
   31 iteration_stmt: . WHILE '(' expression ')' statement
   32 return_stmt: . RETURN ';'
   33            | . RETURN expression ';'
   34 expression: . var '=' expression
   35           | . simple_expression
   36 var: . ID
   37    | . ID '[' expression ']'
   38 simple_expression: . additive_expression relop additive_expression
   39                  | . additive_expression
   46 additive_expression: . additive_expression addop term
   47                    | . term
   50 term: . term mulop factor
   51     | . factor
   54 factor: . '(' expression ')'
   55       | . var
   56       | . call
   57       | . NUM
   58 call: . ID '(' args ')'

    IF      shift, and go to state 36
    RETURN  shift, and go to state 37
    WHILE   shift, and go to state 38
    ID      shift, and go to state 39
    NUM     shift, and go to state 40
    ';'     shift, and go to state 41
    '('     shift, and go to state 42
    '{'     shift, and go to state 27

    compound_stmt        go to state 44
    statement            go to state 101
    expression_stmt      go to state 46
    selection_stmt       go to state 47
    iteration_stmt       go to state 48
    return_stmt          go to state 49
    expression           go to state 50
    var                  go to state 51
    simple_expression    go to state 52
    additive_expression  go to state 53
    term                 go to state 54
    factor               go to state 55
    call                 go to state 56


state 101

   30 selection_stmt: IF '(' expression ')' statement ELSE statement .

    $default  reduce using rule 30 (selection_stmt)
