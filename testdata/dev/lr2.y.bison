State 8 conflicts: 2 shift/reduce
State 9 conflicts: 2 shift/reduce


Grammar

    0 $accept: E $end

    1 E: E '*' E
    2  | E '+' E
    3  | B

    4 B: '0'
    5  | '1'


Terminals, with rules where they appear

$end (0) 0
'*' (42) 1
'+' (43) 2
'0' (48) 4
'1' (49) 5
error (256)


Nonterminals, with rules where they appear

$accept (7)
    on left: 0
E (8)
    on left: 1 2 3, on right: 0 1 2
B (9)
    on left: 4 5, on right: 3


state 0

    0 $accept: . E $end
    1 E: . E '*' E
    2  | . E '+' E
    3  | . B
    4 B: . '0'
    5  | . '1'

    '0'  shift, and go to state 1
    '1'  shift, and go to state 2

    E  go to state 3
    B  go to state 4


state 1

    4 B: '0' .

    $default  reduce using rule 4 (B)


state 2

    5 B: '1' .

    $default  reduce using rule 5 (B)


state 3

    0 $accept: E . $end
    1 E: E . '*' E
    2  | E . '+' E

    $end  shift, and go to state 5
    '*'   shift, and go to state 6
    '+'   shift, and go to state 7


state 4

    3 E: B .

    $default  reduce using rule 3 (E)


state 5

    0 $accept: E $end .

    $default  accept


state 6

    1 E: . E '*' E
    1  | E '*' . E
    2  | . E '+' E
    3  | . B
    4 B: . '0'
    5  | . '1'

    '0'  shift, and go to state 1
    '1'  shift, and go to state 2

    E  go to state 8
    B  go to state 4


state 7

    1 E: . E '*' E
    2  | . E '+' E
    2  | E '+' . E
    3  | . B
    4 B: . '0'
    5  | . '1'

    '0'  shift, and go to state 1
    '1'  shift, and go to state 2

    E  go to state 9
    B  go to state 4


state 8

    1 E: E . '*' E
    1  | E '*' E .  [$end, '*', '+']
    2  | E . '+' E

    '*'  shift, and go to state 6
    '+'  shift, and go to state 7

    '*'       [reduce using rule 1 (E)]
    '+'       [reduce using rule 1 (E)]
    $default  reduce using rule 1 (E)


state 9

    1 E: E . '*' E
    2  | E . '+' E
    2  | E '+' E .  [$end, '*', '+']

    '*'  shift, and go to state 6
    '+'  shift, and go to state 7

    '*'       [reduce using rule 2 (E)]
    '+'       [reduce using rule 2 (E)]
    $default  reduce using rule 2 (E)
