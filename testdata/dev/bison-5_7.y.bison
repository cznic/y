State 1 conflicts: 1 reduce/reduce


Grammar

    0 $accept: def $end

    1 def: param_spec return_spec ','

    2 param_spec: type
    3           | name_list ':' type

    4 return_spec: type
    5            | name ':' type

    6 type: id

    7 name: id

    8 name_list: name
    9          | name ',' name_list


Terminals, with rules where they appear

$end (0) 0
',' (44) 1 9
':' (58) 3 5
error (256)
id (258) 6 7


Nonterminals, with rules where they appear

$accept (6)
    on left: 0
def (7)
    on left: 1, on right: 0
param_spec (8)
    on left: 2 3, on right: 1
return_spec (9)
    on left: 4 5, on right: 1
type (10)
    on left: 6, on right: 2 3 4 5
name (11)
    on left: 7, on right: 5 8 9
name_list (12)
    on left: 8 9, on right: 3 9


state 0

    0 $accept: . def $end
    1 def: . param_spec return_spec ','
    2 param_spec: . type
    3           | . name_list ':' type
    6 type: . id
    7 name: . id
    8 name_list: . name
    9          | . name ',' name_list

    id  shift, and go to state 1

    def         go to state 2
    param_spec  go to state 3
    type        go to state 4
    name        go to state 5
    name_list   go to state 6


state 1

    6 type: id .  [id, ',']
    7 name: id .  [',', ':']

    ','       reduce using rule 6 (type)
    ','       [reduce using rule 7 (name)]
    ':'       reduce using rule 7 (name)
    $default  reduce using rule 6 (type)


state 2

    0 $accept: def . $end

    $end  shift, and go to state 7


state 3

    1 def: param_spec . return_spec ','
    4 return_spec: . type
    5            | . name ':' type
    6 type: . id
    7 name: . id

    id  shift, and go to state 1

    return_spec  go to state 8
    type         go to state 9
    name         go to state 10


state 4

    2 param_spec: type .

    $default  reduce using rule 2 (param_spec)


state 5

    8 name_list: name .  [':']
    9          | name . ',' name_list

    ','  shift, and go to state 11

    $default  reduce using rule 8 (name_list)


state 6

    3 param_spec: name_list . ':' type

    ':'  shift, and go to state 12


state 7

    0 $accept: def $end .

    $default  accept


state 8

    1 def: param_spec return_spec . ','

    ','  shift, and go to state 13


state 9

    4 return_spec: type .

    $default  reduce using rule 4 (return_spec)


state 10

    5 return_spec: name . ':' type

    ':'  shift, and go to state 14


state 11

    7 name: . id
    8 name_list: . name
    9          | . name ',' name_list
    9          | name ',' . name_list

    id  shift, and go to state 15

    name       go to state 5
    name_list  go to state 16


state 12

    3 param_spec: name_list ':' . type
    6 type: . id

    id  shift, and go to state 17

    type  go to state 18


state 13

    1 def: param_spec return_spec ',' .

    $default  reduce using rule 1 (def)


state 14

    5 return_spec: name ':' . type
    6 type: . id

    id  shift, and go to state 17

    type  go to state 19


state 15

    7 name: id .

    $default  reduce using rule 7 (name)


state 16

    9 name_list: name ',' name_list .

    $default  reduce using rule 9 (name_list)


state 17

    6 type: id .

    $default  reduce using rule 6 (type)


state 18

    3 param_spec: name_list ':' type .

    $default  reduce using rule 3 (param_spec)


state 19

    5 return_spec: name ':' type .

    $default  reduce using rule 5 (return_spec)
