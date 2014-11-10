Grammar

    0 $accept: start $end

    1 start: start expr
    2      | /* empty */

    3 expr: NR
    4     | expr '+' expr


Terminals, with rules where they appear

$end (0) 0
'+' (43) 4
error (256)
NR (258) 3


Nonterminals, with rules where they appear

$accept (5)
    on left: 0
start (6)
    on left: 1 2, on right: 0 1
expr (7)
    on left: 3 4, on right: 1 4


state 0

    0 $accept: . start $end
    1 start: . start expr
    2      | .

    $default  reduce using rule 2 (start)

    start  go to state 1


state 1

    0 $accept: start . $end
    1 start: start . expr
    3 expr: . NR
    4     | . expr '+' expr

    $end  shift, and go to state 2
    NR    shift, and go to state 3

    expr  go to state 4


state 2

    0 $accept: start $end .

    $default  accept


state 3

    3 expr: NR .

    $default  reduce using rule 3 (expr)


state 4

    1 start: start expr .  [$end, NR]
    4 expr: expr . '+' expr

    '+'  shift, and go to state 5

    $default  reduce using rule 1 (start)


state 5

    3 expr: . NR
    4     | . expr '+' expr
    4     | expr '+' . expr

    NR  shift, and go to state 3

    expr  go to state 6


state 6

    4 expr: expr . '+' expr
    4     | expr '+' expr .  [$end, NR, '+']

    $default  reduce using rule 4 (expr)

    Conflict between rule 4 and token '+' resolved as reduce (%left '+').
