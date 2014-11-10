Grammar

    0 $accept: S $end

    1 S: /* empty */
    2  | S 'z'


Terminals, with rules where they appear

$end (0) 0
'z' (122) 2
error (256)


Nonterminals, with rules where they appear

$accept (4)
    on left: 0
S (5)
    on left: 1 2, on right: 0 2


state 0

    0 $accept: . S $end
    1 S: .
    2  | . S 'z'

    $default  reduce using rule 1 (S)

    S  go to state 1


state 1

    0 $accept: S . $end
    2 S: S . 'z'

    $end  shift, and go to state 2
    'z'   shift, and go to state 3


state 2

    0 $accept: S $end .

    $default  accept


state 3

    2 S: S 'z' .

    $default  reduce using rule 2 (S)
