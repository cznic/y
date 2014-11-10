Grammar

    0 $accept: rhyme $end

    1 rhyme: sound place

    2 sound: DING DONG

    3 place: DELL


Terminals, with rules where they appear

$end (0) 0
error (256)
DING (258) 2
DONG (259) 2
DELL (260) 3


Nonterminals, with rules where they appear

$accept (6)
    on left: 0
rhyme (7)
    on left: 1, on right: 0
sound (8)
    on left: 2, on right: 1
place (9)
    on left: 3, on right: 1


state 0

    0 $accept: . rhyme $end
    1 rhyme: . sound place
    2 sound: . DING DONG

    DING  shift, and go to state 1

    rhyme  go to state 2
    sound  go to state 3


state 1

    2 sound: DING . DONG

    DONG  shift, and go to state 4


state 2

    0 $accept: rhyme . $end

    $end  shift, and go to state 5


state 3

    1 rhyme: sound . place
    3 place: . DELL

    DELL  shift, and go to state 6

    place  go to state 7


state 4

    2 sound: DING DONG .

    $default  reduce using rule 2 (sound)


state 5

    0 $accept: rhyme $end .

    $default  accept


state 6

    3 place: DELL .

    $default  reduce using rule 3 (place)


state 7

    1 rhyme: sound place .

    $default  reduce using rule 1 (rhyme)
