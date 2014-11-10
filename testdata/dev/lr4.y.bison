Grammar

    0 $accept: S $end

    1 S: T

    2 T: A B

    3 A: 'A'

    4 B: 'B'


Terminals, with rules where they appear

$end (0) 0
'A' (65) 3
'B' (66) 4
error (256)


Nonterminals, with rules where they appear

$accept (5)
    on left: 0
S (6)
    on left: 1, on right: 0
T (7)
    on left: 2, on right: 1
A (8)
    on left: 3, on right: 2
B (9)
    on left: 4, on right: 2


state 0

    0 $accept: . S $end
    1 S: . T
    2 T: . A B
    3 A: . 'A'

    'A'  shift, and go to state 1

    S  go to state 2
    T  go to state 3
    A  go to state 4


state 1

    3 A: 'A' .

    $default  reduce using rule 3 (A)


state 2

    0 $accept: S . $end

    $end  shift, and go to state 5


state 3

    1 S: T .

    $default  reduce using rule 1 (S)


state 4

    2 T: A . B
    4 B: . 'B'

    'B'  shift, and go to state 6

    B  go to state 7


state 5

    0 $accept: S $end .

    $default  accept


state 6

    4 B: 'B' .

    $default  reduce using rule 4 (B)


state 7

    2 T: A B .

    $default  reduce using rule 2 (T)
