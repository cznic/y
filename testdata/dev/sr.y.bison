State 5 conflicts: 1 shift/reduce


Grammar

    0 $accept: expr $end

    1 expr: expr '-' expr
    2     | '1'


Terminals, with rules where they appear

$end (0) 0
'-' (45) 1
'1' (49) 2
error (256)


Nonterminals, with rules where they appear

$accept (5)
    on left: 0
expr (6)
    on left: 1 2, on right: 0 1


state 0

    0 $accept: . expr $end
    1 expr: . expr '-' expr
    2     | . '1'

    '1'  shift, and go to state 1

    expr  go to state 2


state 1

    2 expr: '1' .

    $default  reduce using rule 2 (expr)


state 2

    0 $accept: expr . $end
    1 expr: expr . '-' expr

    $end  shift, and go to state 3
    '-'   shift, and go to state 4


state 3

    0 $accept: expr $end .

    $default  accept


state 4

    1 expr: . expr '-' expr
    1     | expr '-' . expr
    2     | . '1'

    '1'  shift, and go to state 1

    expr  go to state 5


state 5

    1 expr: expr . '-' expr
    1     | expr '-' expr .  [$end, '-']

    '-'  shift, and go to state 4

    '-'       [reduce using rule 1 (expr)]
    $default  reduce using rule 1 (expr)
