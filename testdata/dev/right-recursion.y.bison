Grammar

    0 $accept: S $end

    1 S: /* empty */
    2  | 'a' S


Terminals, with rules where they appear

$end (0) 0
'a' (97) 2
error (256)


Nonterminals, with rules where they appear

$accept (4)
    on left: 0
S (5)
    on left: 1 2, on right: 0 2


state 0

    0 $accept: . S $end
    1 S: .  [$end]
    2  | . 'a' S

    'a'  shift, and go to state 1

    $default  reduce using rule 1 (S)

    S  go to state 2


state 1

    1 S: .  [$end]
    2  | . 'a' S
    2  | 'a' . S

    'a'  shift, and go to state 1

    $default  reduce using rule 1 (S)

    S  go to state 3


state 2

    0 $accept: S . $end

    $end  shift, and go to state 4


state 3

    2 S: 'a' S .

    $default  reduce using rule 2 (S)


state 4

    0 $accept: S $end .

    $default  accept
