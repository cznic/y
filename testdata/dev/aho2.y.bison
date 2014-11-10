Grammar

    0 $accept: S $end

    1 S: L '=' R
    2  | R

    3 L: '*' R
    4  | id

    5 R: L


Terminals, with rules where they appear

$end (0) 0
'*' (42) 3
'=' (61) 1
error (256)
id (258) 4


Nonterminals, with rules where they appear

$accept (6)
    on left: 0
S (7)
    on left: 1 2, on right: 0
L (8)
    on left: 3 4, on right: 1 5
R (9)
    on left: 5, on right: 1 2 3


state 0

    0 $accept: . S $end
    1 S: . L '=' R
    2  | . R
    3 L: . '*' R
    4  | . id
    5 R: . L

    id   shift, and go to state 1
    '*'  shift, and go to state 2

    S  go to state 3
    L  go to state 4
    R  go to state 5


state 1

    4 L: id .

    $default  reduce using rule 4 (L)


state 2

    3 L: . '*' R
    3  | '*' . R
    4  | . id
    5 R: . L

    id   shift, and go to state 1
    '*'  shift, and go to state 2

    L  go to state 6
    R  go to state 7


state 3

    0 $accept: S . $end

    $end  shift, and go to state 8


state 4

    1 S: L . '=' R
    5 R: L .  [$end]

    '='  shift, and go to state 9

    $default  reduce using rule 5 (R)


state 5

    2 S: R .

    $default  reduce using rule 2 (S)


state 6

    5 R: L .

    $default  reduce using rule 5 (R)


state 7

    3 L: '*' R .

    $default  reduce using rule 3 (L)


state 8

    0 $accept: S $end .

    $default  accept


state 9

    1 S: L '=' . R
    3 L: . '*' R
    4  | . id
    5 R: . L

    id   shift, and go to state 1
    '*'  shift, and go to state 2

    L  go to state 6
    R  go to state 10


state 10

    1 S: L '=' R .

    $default  reduce using rule 1 (S)
