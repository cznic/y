Grammar

    0 $accept: program $end

    1 program: program statement '\n'
    2        | program error '\n'
    3        | /* empty */

    4 statement: expression
    5          | VARIABLE '=' expression

    6 expression: INTEGER
    7           | VARIABLE
    8           | expression '+' expression
    9           | expression '-' expression
   10           | expression '*' expression
   11           | expression '/' expression
   12           | '(' expression ')'


Terminals, with rules where they appear

$end (0) 0
'\n' (10) 1 2
'(' (40) 12
')' (41) 12
'*' (42) 10
'+' (43) 8
'-' (45) 9
'/' (47) 11
'=' (61) 5
error (256) 2
INTEGER (258) 6
VARIABLE (259) 5 7


Nonterminals, with rules where they appear

$accept (13)
    on left: 0
program (14)
    on left: 1 2 3, on right: 0 1 2
statement (15)
    on left: 4 5, on right: 1
expression (16)
    on left: 6 7 8 9 10 11 12, on right: 4 5 8 9 10 11 12


state 0

    0 $accept: . program $end
    1 program: . program statement '\n'
    2        | . program error '\n'
    3        | .

    $default  reduce using rule 3 (program)

    program  go to state 1


state 1

    0 $accept: program . $end
    1 program: program . statement '\n'
    2        | program . error '\n'
    4 statement: . expression
    5          | . VARIABLE '=' expression
    6 expression: . INTEGER
    7           | . VARIABLE
    8           | . expression '+' expression
    9           | . expression '-' expression
   10           | . expression '*' expression
   11           | . expression '/' expression
   12           | . '(' expression ')'

    $end      shift, and go to state 2
    error     shift, and go to state 3
    INTEGER   shift, and go to state 4
    VARIABLE  shift, and go to state 5
    '('       shift, and go to state 6

    statement   go to state 7
    expression  go to state 8


state 2

    0 $accept: program $end .

    $default  accept


state 3

    2 program: program error . '\n'

    '\n'  shift, and go to state 9


state 4

    6 expression: INTEGER .

    $default  reduce using rule 6 (expression)


state 5

    5 statement: VARIABLE . '=' expression
    7 expression: VARIABLE .  ['+', '-', '*', '/', '\n']

    '='  shift, and go to state 10

    $default  reduce using rule 7 (expression)


state 6

    6 expression: . INTEGER
    7           | . VARIABLE
    8           | . expression '+' expression
    9           | . expression '-' expression
   10           | . expression '*' expression
   11           | . expression '/' expression
   12           | . '(' expression ')'
   12           | '(' . expression ')'

    INTEGER   shift, and go to state 4
    VARIABLE  shift, and go to state 11
    '('       shift, and go to state 6

    expression  go to state 12


state 7

    1 program: program statement . '\n'

    '\n'  shift, and go to state 13


state 8

    4 statement: expression .  ['\n']
    8 expression: expression . '+' expression
    9           | expression . '-' expression
   10           | expression . '*' expression
   11           | expression . '/' expression

    '+'  shift, and go to state 14
    '-'  shift, and go to state 15
    '*'  shift, and go to state 16
    '/'  shift, and go to state 17

    $default  reduce using rule 4 (statement)


state 9

    2 program: program error '\n' .

    $default  reduce using rule 2 (program)


state 10

    5 statement: VARIABLE '=' . expression
    6 expression: . INTEGER
    7           | . VARIABLE
    8           | . expression '+' expression
    9           | . expression '-' expression
   10           | . expression '*' expression
   11           | . expression '/' expression
   12           | . '(' expression ')'

    INTEGER   shift, and go to state 4
    VARIABLE  shift, and go to state 11
    '('       shift, and go to state 6

    expression  go to state 18


state 11

    7 expression: VARIABLE .

    $default  reduce using rule 7 (expression)


state 12

    8 expression: expression . '+' expression
    9           | expression . '-' expression
   10           | expression . '*' expression
   11           | expression . '/' expression
   12           | '(' expression . ')'

    '+'  shift, and go to state 14
    '-'  shift, and go to state 15
    '*'  shift, and go to state 16
    '/'  shift, and go to state 17
    ')'  shift, and go to state 19


state 13

    1 program: program statement '\n' .

    $default  reduce using rule 1 (program)


state 14

    6 expression: . INTEGER
    7           | . VARIABLE
    8           | . expression '+' expression
    8           | expression '+' . expression
    9           | . expression '-' expression
   10           | . expression '*' expression
   11           | . expression '/' expression
   12           | . '(' expression ')'

    INTEGER   shift, and go to state 4
    VARIABLE  shift, and go to state 11
    '('       shift, and go to state 6

    expression  go to state 20


state 15

    6 expression: . INTEGER
    7           | . VARIABLE
    8           | . expression '+' expression
    9           | . expression '-' expression
    9           | expression '-' . expression
   10           | . expression '*' expression
   11           | . expression '/' expression
   12           | . '(' expression ')'

    INTEGER   shift, and go to state 4
    VARIABLE  shift, and go to state 11
    '('       shift, and go to state 6

    expression  go to state 21


state 16

    6 expression: . INTEGER
    7           | . VARIABLE
    8           | . expression '+' expression
    9           | . expression '-' expression
   10           | . expression '*' expression
   10           | expression '*' . expression
   11           | . expression '/' expression
   12           | . '(' expression ')'

    INTEGER   shift, and go to state 4
    VARIABLE  shift, and go to state 11
    '('       shift, and go to state 6

    expression  go to state 22


state 17

    6 expression: . INTEGER
    7           | . VARIABLE
    8           | . expression '+' expression
    9           | . expression '-' expression
   10           | . expression '*' expression
   11           | . expression '/' expression
   11           | expression '/' . expression
   12           | . '(' expression ')'

    INTEGER   shift, and go to state 4
    VARIABLE  shift, and go to state 11
    '('       shift, and go to state 6

    expression  go to state 23


state 18

    5 statement: VARIABLE '=' expression .  ['\n']
    8 expression: expression . '+' expression
    9           | expression . '-' expression
   10           | expression . '*' expression
   11           | expression . '/' expression

    '+'  shift, and go to state 14
    '-'  shift, and go to state 15
    '*'  shift, and go to state 16
    '/'  shift, and go to state 17

    $default  reduce using rule 5 (statement)


state 19

   12 expression: '(' expression ')' .

    $default  reduce using rule 12 (expression)


state 20

    8 expression: expression . '+' expression
    8           | expression '+' expression .  ['+', '-', '\n', ')']
    9           | expression . '-' expression
   10           | expression . '*' expression
   11           | expression . '/' expression

    '*'  shift, and go to state 16
    '/'  shift, and go to state 17

    $default  reduce using rule 8 (expression)

    Conflict between rule 8 and token '+' resolved as reduce (%left '+').
    Conflict between rule 8 and token '-' resolved as reduce (%left '-').
    Conflict between rule 8 and token '*' resolved as shift ('+' < '*').
    Conflict between rule 8 and token '/' resolved as shift ('+' < '/').


state 21

    8 expression: expression . '+' expression
    9           | expression . '-' expression
    9           | expression '-' expression .  ['+', '-', '\n', ')']
   10           | expression . '*' expression
   11           | expression . '/' expression

    '*'  shift, and go to state 16
    '/'  shift, and go to state 17

    $default  reduce using rule 9 (expression)

    Conflict between rule 9 and token '+' resolved as reduce (%left '+').
    Conflict between rule 9 and token '-' resolved as reduce (%left '-').
    Conflict between rule 9 and token '*' resolved as shift ('-' < '*').
    Conflict between rule 9 and token '/' resolved as shift ('-' < '/').


state 22

    8 expression: expression . '+' expression
    9           | expression . '-' expression
   10           | expression . '*' expression
   10           | expression '*' expression .  ['+', '-', '*', '/', '\n', ')']
   11           | expression . '/' expression

    $default  reduce using rule 10 (expression)

    Conflict between rule 10 and token '+' resolved as reduce ('+' < '*').
    Conflict between rule 10 and token '-' resolved as reduce ('-' < '*').
    Conflict between rule 10 and token '*' resolved as reduce (%left '*').
    Conflict between rule 10 and token '/' resolved as reduce (%left '/').


state 23

    8 expression: expression . '+' expression
    9           | expression . '-' expression
   10           | expression . '*' expression
   11           | expression . '/' expression
   11           | expression '/' expression .  ['+', '-', '*', '/', '\n', ')']

    $default  reduce using rule 11 (expression)

    Conflict between rule 11 and token '+' resolved as reduce ('+' < '/').
    Conflict between rule 11 and token '-' resolved as reduce ('-' < '/').
    Conflict between rule 11 and token '*' resolved as reduce (%left '*').
    Conflict between rule 11 and token '/' resolved as reduce (%left '/').
