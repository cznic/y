Rules useless in parser due to conflicts

    6 F: 'e'


State 4 conflicts: 2 reduce/reduce


Grammar

    0 $accept: S $end

    1 S: 'a' E 'c'
    2  | 'a' F 'd'
    3  | 'b' F 'c'
    4  | 'b' E 'd'

    5 E: 'e'

    6 F: 'e'


Terminals, with rules where they appear

$end (0) 0
'a' (97) 1 2
'b' (98) 3 4
'c' (99) 1 3
'd' (100) 2 4
'e' (101) 5 6
error (256)


Nonterminals, with rules where they appear

$accept (8)
    on left: 0
S (9)
    on left: 1 2 3 4, on right: 0
E (10)
    on left: 5, on right: 1 4
F (11)
    on left: 6, on right: 2 3


state 0

    0 $accept: . S $end
    1 S: . 'a' E 'c'
    2  | . 'a' F 'd'
    3  | . 'b' F 'c'
    4  | . 'b' E 'd'

    'a'  shift, and go to state 1
    'b'  shift, and go to state 2

    S  go to state 3


state 1

    1 S: 'a' . E 'c'
    2  | 'a' . F 'd'
    5 E: . 'e'
    6 F: . 'e'

    'e'  shift, and go to state 4

    E  go to state 5
    F  go to state 6


state 2

    3 S: 'b' . F 'c'
    4  | 'b' . E 'd'
    5 E: . 'e'
    6 F: . 'e'

    'e'  shift, and go to state 4

    E  go to state 7
    F  go to state 8


state 3

    0 $accept: S . $end

    $end  shift, and go to state 9


state 4

    5 E: 'e' .  ['c', 'd']
    6 F: 'e' .  ['c', 'd']

    'c'       reduce using rule 5 (E)
    'c'       [reduce using rule 6 (F)]
    'd'       reduce using rule 5 (E)
    'd'       [reduce using rule 6 (F)]
    $default  reduce using rule 5 (E)


state 5

    1 S: 'a' E . 'c'

    'c'  shift, and go to state 10


state 6

    2 S: 'a' F . 'd'

    'd'  shift, and go to state 11


state 7

    4 S: 'b' E . 'd'

    'd'  shift, and go to state 12


state 8

    3 S: 'b' F . 'c'

    'c'  shift, and go to state 13


state 9

    0 $accept: S $end .

    $default  accept


state 10

    1 S: 'a' E 'c' .

    $default  reduce using rule 1 (S)


state 11

    2 S: 'a' F 'd' .

    $default  reduce using rule 2 (S)


state 12

    4 S: 'b' E 'd' .

    $default  reduce using rule 4 (S)


state 13

    3 S: 'b' F 'c' .

    $default  reduce using rule 3 (S)
