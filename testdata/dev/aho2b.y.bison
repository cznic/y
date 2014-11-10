Grammar

    0 $accept: S $end

    1 S: L '=' R

    2 L: '*' R
    3  | id

    4 R: L


Terminals, with rules where they appear

$end (0) 0
'*' (42) 2
'=' (61) 1
error (256)
id (258) 3


Nonterminals, with rules where they appear

$accept (6)
    on left: 0
S (7)
    on left: 1, on right: 0
L (8)
    on left: 2 3, on right: 1 4
R (9)
    on left: 4, on right: 1 2


state 0

    0 $accept: . S $end
    1 S: . L '=' R
    2 L: . '*' R
    3  | . id

    id   shift, and go to state 1
    '*'  shift, and go to state 2

    S  go to state 3
    L  go to state 4


state 1

    3 L: id .

    $default  reduce using rule 3 (L)


state 2

    2 L: . '*' R
    2  | '*' . R
    3  | . id
    4 R: . L

    id   shift, and go to state 1
    '*'  shift, and go to state 2

    L  go to state 5
    R  go to state 6


state 3

    0 $accept: S . $end

    $end  shift, and go to state 7


state 4

    1 S: L . '=' R

    '='  shift, and go to state 8


state 5

    4 R: L .

    $default  reduce using rule 4 (R)


state 6

    2 L: '*' R .

    $default  reduce using rule 2 (L)


state 7

    0 $accept: S $end .

    $default  accept


state 8

    1 S: L '=' . R
    2 L: . '*' R
    3  | . id
    4 R: . L

    id   shift, and go to state 1
    '*'  shift, and go to state 2

    L  go to state 5
    R  go to state 9


state 9

    1 S: L '=' R .

    $default  reduce using rule 1 (S)
