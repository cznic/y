Grammar

    0 $accept: start $end

    1 start: idList ids ids2

    2 idList: /* empty */
    3       | NUM 'X'

    4 ids: 'A' NUM NUM

    5 ids2: NUM NUM


Terminals, with rules where they appear

$end (0) 0
'A' (65) 4
'X' (88) 3
error (256)
NUM (258) 3 4 5


Nonterminals, with rules where they appear

$accept (6)
    on left: 0
start (7)
    on left: 1, on right: 0
idList (8)
    on left: 2 3, on right: 1
ids (9)
    on left: 4, on right: 1
ids2 (10)
    on left: 5, on right: 1


state 0

    0 $accept: . start $end
    1 start: . idList ids ids2
    2 idList: .  ['A']
    3       | . NUM 'X'

    NUM  shift, and go to state 1

    $default  reduce using rule 2 (idList)

    start   go to state 2
    idList  go to state 3


state 1

    3 idList: NUM . 'X'

    'X'  shift, and go to state 4


state 2

    0 $accept: start . $end

    $end  shift, and go to state 5


state 3

    1 start: idList . ids ids2
    4 ids: . 'A' NUM NUM

    'A'  shift, and go to state 6

    ids  go to state 7


state 4

    3 idList: NUM 'X' .

    $default  reduce using rule 3 (idList)


state 5

    0 $accept: start $end .

    $default  accept


state 6

    4 ids: 'A' . NUM NUM

    NUM  shift, and go to state 8


state 7

    1 start: idList ids . ids2
    5 ids2: . NUM NUM

    NUM  shift, and go to state 9

    ids2  go to state 10


state 8

    4 ids: 'A' NUM . NUM

    NUM  shift, and go to state 11


state 9

    5 ids2: NUM . NUM

    NUM  shift, and go to state 12


state 10

    1 start: idList ids ids2 .

    $default  reduce using rule 1 (start)


state 11

    4 ids: 'A' NUM NUM .

    $default  reduce using rule 4 (ids)


state 12

    5 ids2: NUM NUM .

    $default  reduce using rule 5 (ids2)
