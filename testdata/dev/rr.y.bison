Grammar

    0 $accept: E $end

    1 E: A '1'
    2  | B '2'

    3 A: '1'

    4 B: '1'


Terminals, with rules where they appear

$end (0) 0
'1' (49) 1 3 4
'2' (50) 2
error (256)


Nonterminals, with rules where they appear

$accept (5)
    on left: 0
E (6)
    on left: 1 2, on right: 0
A (7)
    on left: 3, on right: 1
B (8)
    on left: 4, on right: 2


state 0

    0 $accept: . E $end
    1 E: . A '1'
    2  | . B '2'
    3 A: . '1'
    4 B: . '1'

    '1'  shift, and go to state 1

    E  go to state 2
    A  go to state 3
    B  go to state 4


state 1

    3 A: '1' .  ['1']
    4 B: '1' .  ['2']

    '2'       reduce using rule 4 (B)
    $default  reduce using rule 3 (A)


state 2

    0 $accept: E . $end

    $end  shift, and go to state 5


state 3

    1 E: A . '1'

    '1'  shift, and go to state 6


state 4

    2 E: B . '2'

    '2'  shift, and go to state 7


state 5

    0 $accept: E $end .

    $default  accept


state 6

    1 E: A '1' .

    $default  reduce using rule 1 (E)


state 7

    2 E: B '2' .

    $default  reduce using rule 2 (E)
