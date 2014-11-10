Terminals unused in grammar

   id


Grammar

    0 $accept: S $end

    1 S: C C

    2 C: 'c' C
    3  | 'd'


Terminals, with rules where they appear

$end (0) 0
'c' (99) 2
'd' (100) 3
error (256)
id (258)


Nonterminals, with rules where they appear

$accept (6)
    on left: 0
S (7)
    on left: 1, on right: 0
C (8)
    on left: 2 3, on right: 1 2


state 0

    0 $accept: . S $end
    1 S: . C C
    2 C: . 'c' C
    3  | . 'd'

    'c'  shift, and go to state 1
    'd'  shift, and go to state 2

    S  go to state 3
    C  go to state 4


state 1

    2 C: . 'c' C
    2  | 'c' . C
    3  | . 'd'

    'c'  shift, and go to state 1
    'd'  shift, and go to state 2

    C  go to state 5


state 2

    3 C: 'd' .

    $default  reduce using rule 3 (C)


state 3

    0 $accept: S . $end

    $end  shift, and go to state 6


state 4

    1 S: C . C
    2 C: . 'c' C
    3  | . 'd'

    'c'  shift, and go to state 1
    'd'  shift, and go to state 2

    C  go to state 7


state 5

    2 C: 'c' C .

    $default  reduce using rule 2 (C)


state 6

    0 $accept: S $end .

    $default  accept


state 7

    1 S: C C .

    $default  reduce using rule 1 (S)
