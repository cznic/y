Grammar

    0 $accept: E $end

    1 E: T E2

    2 E2: '+' T E2
    3   | /* empty */

    4 T: F T2

    5 T2: '*' F T2
    6   | /* empty */

    7 F: '(' E ')'
    8  | id


Terminals, with rules where they appear

$end (0) 0
'(' (40) 7
')' (41) 7
'*' (42) 5
'+' (43) 2
error (256)
id (258) 8


Nonterminals, with rules where they appear

$accept (8)
    on left: 0
E (9)
    on left: 1, on right: 0 7
E2 (10)
    on left: 2 3, on right: 1 2
T (11)
    on left: 4, on right: 1 2
T2 (12)
    on left: 5 6, on right: 4 5
F (13)
    on left: 7 8, on right: 4 5


state 0

    0 $accept: . E $end
    1 E: . T E2
    4 T: . F T2
    7 F: . '(' E ')'
    8  | . id

    id   shift, and go to state 1
    '('  shift, and go to state 2

    E  go to state 3
    T  go to state 4
    F  go to state 5


state 1

    8 F: id .

    $default  reduce using rule 8 (F)


state 2

    1 E: . T E2
    4 T: . F T2
    7 F: . '(' E ')'
    7  | '(' . E ')'
    8  | . id

    id   shift, and go to state 1
    '('  shift, and go to state 2

    E  go to state 6
    T  go to state 4
    F  go to state 5


state 3

    0 $accept: E . $end

    $end  shift, and go to state 7


state 4

    1 E: T . E2
    2 E2: . '+' T E2
    3   | .  [$end, ')']

    '+'  shift, and go to state 8

    $default  reduce using rule 3 (E2)

    E2  go to state 9


state 5

    4 T: F . T2
    5 T2: . '*' F T2
    6   | .  [$end, '+', ')']

    '*'  shift, and go to state 10

    $default  reduce using rule 6 (T2)

    T2  go to state 11


state 6

    7 F: '(' E . ')'

    ')'  shift, and go to state 12


state 7

    0 $accept: E $end .

    $default  accept


state 8

    2 E2: '+' . T E2
    4 T: . F T2
    7 F: . '(' E ')'
    8  | . id

    id   shift, and go to state 1
    '('  shift, and go to state 2

    T  go to state 13
    F  go to state 5


state 9

    1 E: T E2 .

    $default  reduce using rule 1 (E)


state 10

    5 T2: '*' . F T2
    7 F: . '(' E ')'
    8  | . id

    id   shift, and go to state 1
    '('  shift, and go to state 2

    F  go to state 14


state 11

    4 T: F T2 .

    $default  reduce using rule 4 (T)


state 12

    7 F: '(' E ')' .

    $default  reduce using rule 7 (F)


state 13

    2 E2: . '+' T E2
    2   | '+' T . E2
    3   | .  [$end, ')']

    '+'  shift, and go to state 8

    $default  reduce using rule 3 (E2)

    E2  go to state 15


state 14

    5 T2: . '*' F T2
    5   | '*' F . T2
    6   | .  [$end, '+', ')']

    '*'  shift, and go to state 10

    $default  reduce using rule 6 (T2)

    T2  go to state 16


state 15

    2 E2: '+' T E2 .

    $default  reduce using rule 2 (E2)


state 16

    5 T2: '*' F T2 .

    $default  reduce using rule 5 (T2)
