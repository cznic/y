Grammar

    0 $accept: E $end

    1 E: '1' E
    2  | '1'


Terminals, with rules where they appear

$end (0) 0
'1' (49) 1 2
error (256)


Nonterminals, with rules where they appear

$accept (4)
    on left: 0
E (5)
    on left: 1 2, on right: 0 1


state 0

    0 $accept: . E $end
    1 E: . '1' E
    2  | . '1'

    '1'  shift, and go to state 1

    E  go to state 2


state 1

    1 E: . '1' E
    1  | '1' . E
    2  | . '1'
    2  | '1' .  [$end]

    '1'  shift, and go to state 1

    $default  reduce using rule 2 (E)

    E  go to state 3


state 2

    0 $accept: E . $end

    $end  shift, and go to state 4


state 3

    1 E: '1' E .

    $default  reduce using rule 1 (E)


state 4

    0 $accept: E $end .

    $default  accept
