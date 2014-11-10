Grammar

    0 $accept: top $end

    1 top: expr

    2 expr: expr1
    3     | '+' expr
    4     | '-' expr

    5 expr1: expr2
    6      | expr1 '+' expr2
    7      | expr1 '-' expr2

    8 expr2: expr3
    9      | expr2 '*' expr3
   10      | expr2 '/' expr3

   11 expr3: NUM
   12      | '(' expr ')'


Terminals, with rules where they appear

$end (0) 0
'(' (40) 12
')' (41) 12
'*' (42) 9
'+' (43) 3 6
'-' (45) 4 7
'/' (47) 10
error (256)
NUM (258) 11


Nonterminals, with rules where they appear

$accept (10)
    on left: 0
top (11)
    on left: 1, on right: 0
expr (12)
    on left: 2 3 4, on right: 1 3 4 12
expr1 (13)
    on left: 5 6 7, on right: 2 6 7
expr2 (14)
    on left: 8 9 10, on right: 5 6 7 9 10
expr3 (15)
    on left: 11 12, on right: 8 9 10


state 0

    0 $accept: . top $end
    1 top: . expr
    2 expr: . expr1
    3     | . '+' expr
    4     | . '-' expr
    5 expr1: . expr2
    6      | . expr1 '+' expr2
    7      | . expr1 '-' expr2
    8 expr2: . expr3
    9      | . expr2 '*' expr3
   10      | . expr2 '/' expr3
   11 expr3: . NUM
   12      | . '(' expr ')'

    NUM  shift, and go to state 1
    '+'  shift, and go to state 2
    '-'  shift, and go to state 3
    '('  shift, and go to state 4

    top    go to state 5
    expr   go to state 6
    expr1  go to state 7
    expr2  go to state 8
    expr3  go to state 9


state 1

   11 expr3: NUM .

    $default  reduce using rule 11 (expr3)


state 2

    2 expr: . expr1
    3     | . '+' expr
    3     | '+' . expr
    4     | . '-' expr
    5 expr1: . expr2
    6      | . expr1 '+' expr2
    7      | . expr1 '-' expr2
    8 expr2: . expr3
    9      | . expr2 '*' expr3
   10      | . expr2 '/' expr3
   11 expr3: . NUM
   12      | . '(' expr ')'

    NUM  shift, and go to state 1
    '+'  shift, and go to state 2
    '-'  shift, and go to state 3
    '('  shift, and go to state 4

    expr   go to state 10
    expr1  go to state 7
    expr2  go to state 8
    expr3  go to state 9


state 3

    2 expr: . expr1
    3     | . '+' expr
    4     | . '-' expr
    4     | '-' . expr
    5 expr1: . expr2
    6      | . expr1 '+' expr2
    7      | . expr1 '-' expr2
    8 expr2: . expr3
    9      | . expr2 '*' expr3
   10      | . expr2 '/' expr3
   11 expr3: . NUM
   12      | . '(' expr ')'

    NUM  shift, and go to state 1
    '+'  shift, and go to state 2
    '-'  shift, and go to state 3
    '('  shift, and go to state 4

    expr   go to state 11
    expr1  go to state 7
    expr2  go to state 8
    expr3  go to state 9


state 4

    2 expr: . expr1
    3     | . '+' expr
    4     | . '-' expr
    5 expr1: . expr2
    6      | . expr1 '+' expr2
    7      | . expr1 '-' expr2
    8 expr2: . expr3
    9      | . expr2 '*' expr3
   10      | . expr2 '/' expr3
   11 expr3: . NUM
   12      | . '(' expr ')'
   12      | '(' . expr ')'

    NUM  shift, and go to state 1
    '+'  shift, and go to state 2
    '-'  shift, and go to state 3
    '('  shift, and go to state 4

    expr   go to state 12
    expr1  go to state 7
    expr2  go to state 8
    expr3  go to state 9


state 5

    0 $accept: top . $end

    $end  shift, and go to state 13


state 6

    1 top: expr .

    $default  reduce using rule 1 (top)


state 7

    2 expr: expr1 .  [$end, ')']
    6 expr1: expr1 . '+' expr2
    7      | expr1 . '-' expr2

    '+'  shift, and go to state 14
    '-'  shift, and go to state 15

    $default  reduce using rule 2 (expr)


state 8

    5 expr1: expr2 .  [$end, '+', '-', ')']
    9 expr2: expr2 . '*' expr3
   10      | expr2 . '/' expr3

    '*'  shift, and go to state 16
    '/'  shift, and go to state 17

    $default  reduce using rule 5 (expr1)


state 9

    8 expr2: expr3 .

    $default  reduce using rule 8 (expr2)


state 10

    3 expr: '+' expr .

    $default  reduce using rule 3 (expr)


state 11

    4 expr: '-' expr .

    $default  reduce using rule 4 (expr)


state 12

   12 expr3: '(' expr . ')'

    ')'  shift, and go to state 18


state 13

    0 $accept: top $end .

    $default  accept


state 14

    6 expr1: expr1 '+' . expr2
    8 expr2: . expr3
    9      | . expr2 '*' expr3
   10      | . expr2 '/' expr3
   11 expr3: . NUM
   12      | . '(' expr ')'

    NUM  shift, and go to state 1
    '('  shift, and go to state 4

    expr2  go to state 19
    expr3  go to state 9


state 15

    7 expr1: expr1 '-' . expr2
    8 expr2: . expr3
    9      | . expr2 '*' expr3
   10      | . expr2 '/' expr3
   11 expr3: . NUM
   12      | . '(' expr ')'

    NUM  shift, and go to state 1
    '('  shift, and go to state 4

    expr2  go to state 20
    expr3  go to state 9


state 16

    9 expr2: expr2 '*' . expr3
   11 expr3: . NUM
   12      | . '(' expr ')'

    NUM  shift, and go to state 1
    '('  shift, and go to state 4

    expr3  go to state 21


state 17

   10 expr2: expr2 '/' . expr3
   11 expr3: . NUM
   12      | . '(' expr ')'

    NUM  shift, and go to state 1
    '('  shift, and go to state 4

    expr3  go to state 22


state 18

   12 expr3: '(' expr ')' .

    $default  reduce using rule 12 (expr3)


state 19

    6 expr1: expr1 '+' expr2 .  [$end, '+', '-', ')']
    9 expr2: expr2 . '*' expr3
   10      | expr2 . '/' expr3

    '*'  shift, and go to state 16
    '/'  shift, and go to state 17

    $default  reduce using rule 6 (expr1)


state 20

    7 expr1: expr1 '-' expr2 .  [$end, '+', '-', ')']
    9 expr2: expr2 . '*' expr3
   10      | expr2 . '/' expr3

    '*'  shift, and go to state 16
    '/'  shift, and go to state 17

    $default  reduce using rule 7 (expr1)


state 21

    9 expr2: expr2 '*' expr3 .

    $default  reduce using rule 9 (expr2)


state 22

   10 expr2: expr2 '/' expr3 .

    $default  reduce using rule 10 (expr2)
