Grammar

    0 $accept: input $end

    1 input: /* empty */
    2      | input line

    3 line: '\n'
    4     | exp '\n'

    5 exp: NUM
    6    | exp '+' exp
    7    | exp '-' exp
    8    | exp '*' exp
    9    | exp '/' exp
   10    | '-' exp
   11    | exp '^' exp
   12    | '(' exp ')'


Terminals, with rules where they appear

$end (0) 0
'\n' (10) 3 4
'(' (40) 12
')' (41) 12
'*' (42) 8
'+' (43) 6
'-' (45) 7 10
'/' (47) 9
'^' (94) 11
error (256)
NUM (258) 5
NEG (259)


Nonterminals, with rules where they appear

$accept (13)
    on left: 0
input (14)
    on left: 1 2, on right: 0 2
line (15)
    on left: 3 4, on right: 2
exp (16)
    on left: 5 6 7 8 9 10 11 12, on right: 4 6 7 8 9 10 11 12


state 0

    0 $accept: . input $end
    1 input: .
    2      | . input line

    $default  reduce using rule 1 (input)

    input  go to state 1


state 1

    0 $accept: input . $end
    2 input: input . line
    3 line: . '\n'
    4     | . exp '\n'
    5 exp: . NUM
    6    | . exp '+' exp
    7    | . exp '-' exp
    8    | . exp '*' exp
    9    | . exp '/' exp
   10    | . '-' exp
   11    | . exp '^' exp
   12    | . '(' exp ')'

    $end  shift, and go to state 2
    NUM   shift, and go to state 3
    '-'   shift, and go to state 4
    '\n'  shift, and go to state 5
    '('   shift, and go to state 6

    line  go to state 7
    exp   go to state 8


state 2

    0 $accept: input $end .

    $default  accept


state 3

    5 exp: NUM .

    $default  reduce using rule 5 (exp)


state 4

    5 exp: . NUM
    6    | . exp '+' exp
    7    | . exp '-' exp
    8    | . exp '*' exp
    9    | . exp '/' exp
   10    | . '-' exp
   10    | '-' . exp
   11    | . exp '^' exp
   12    | . '(' exp ')'

    NUM  shift, and go to state 3
    '-'  shift, and go to state 4
    '('  shift, and go to state 6

    exp  go to state 9


state 5

    3 line: '\n' .

    $default  reduce using rule 3 (line)


state 6

    5 exp: . NUM
    6    | . exp '+' exp
    7    | . exp '-' exp
    8    | . exp '*' exp
    9    | . exp '/' exp
   10    | . '-' exp
   11    | . exp '^' exp
   12    | . '(' exp ')'
   12    | '(' . exp ')'

    NUM  shift, and go to state 3
    '-'  shift, and go to state 4
    '('  shift, and go to state 6

    exp  go to state 10


state 7

    2 input: input line .

    $default  reduce using rule 2 (input)


state 8

    4 line: exp . '\n'
    6 exp: exp . '+' exp
    7    | exp . '-' exp
    8    | exp . '*' exp
    9    | exp . '/' exp
   11    | exp . '^' exp

    '-'   shift, and go to state 11
    '+'   shift, and go to state 12
    '*'   shift, and go to state 13
    '/'   shift, and go to state 14
    '^'   shift, and go to state 15
    '\n'  shift, and go to state 16


state 9

    6 exp: exp . '+' exp
    7    | exp . '-' exp
    8    | exp . '*' exp
    9    | exp . '/' exp
   10    | '-' exp .  ['-', '+', '*', '/', '\n', ')']
   11    | exp . '^' exp

    '^'  shift, and go to state 15

    $default  reduce using rule 10 (exp)

    Conflict between rule 10 and token '-' resolved as reduce ('-' < NEG).
    Conflict between rule 10 and token '+' resolved as reduce ('+' < NEG).
    Conflict between rule 10 and token '*' resolved as reduce ('*' < NEG).
    Conflict between rule 10 and token '/' resolved as reduce ('/' < NEG).
    Conflict between rule 10 and token '^' resolved as shift (NEG < '^').


state 10

    6 exp: exp . '+' exp
    7    | exp . '-' exp
    8    | exp . '*' exp
    9    | exp . '/' exp
   11    | exp . '^' exp
   12    | '(' exp . ')'

    '-'  shift, and go to state 11
    '+'  shift, and go to state 12
    '*'  shift, and go to state 13
    '/'  shift, and go to state 14
    '^'  shift, and go to state 15
    ')'  shift, and go to state 17


state 11

    5 exp: . NUM
    6    | . exp '+' exp
    7    | . exp '-' exp
    7    | exp '-' . exp
    8    | . exp '*' exp
    9    | . exp '/' exp
   10    | . '-' exp
   11    | . exp '^' exp
   12    | . '(' exp ')'

    NUM  shift, and go to state 3
    '-'  shift, and go to state 4
    '('  shift, and go to state 6

    exp  go to state 18


state 12

    5 exp: . NUM
    6    | . exp '+' exp
    6    | exp '+' . exp
    7    | . exp '-' exp
    8    | . exp '*' exp
    9    | . exp '/' exp
   10    | . '-' exp
   11    | . exp '^' exp
   12    | . '(' exp ')'

    NUM  shift, and go to state 3
    '-'  shift, and go to state 4
    '('  shift, and go to state 6

    exp  go to state 19


state 13

    5 exp: . NUM
    6    | . exp '+' exp
    7    | . exp '-' exp
    8    | . exp '*' exp
    8    | exp '*' . exp
    9    | . exp '/' exp
   10    | . '-' exp
   11    | . exp '^' exp
   12    | . '(' exp ')'

    NUM  shift, and go to state 3
    '-'  shift, and go to state 4
    '('  shift, and go to state 6

    exp  go to state 20


state 14

    5 exp: . NUM
    6    | . exp '+' exp
    7    | . exp '-' exp
    8    | . exp '*' exp
    9    | . exp '/' exp
    9    | exp '/' . exp
   10    | . '-' exp
   11    | . exp '^' exp
   12    | . '(' exp ')'

    NUM  shift, and go to state 3
    '-'  shift, and go to state 4
    '('  shift, and go to state 6

    exp  go to state 21


state 15

    5 exp: . NUM
    6    | . exp '+' exp
    7    | . exp '-' exp
    8    | . exp '*' exp
    9    | . exp '/' exp
   10    | . '-' exp
   11    | . exp '^' exp
   11    | exp '^' . exp
   12    | . '(' exp ')'

    NUM  shift, and go to state 3
    '-'  shift, and go to state 4
    '('  shift, and go to state 6

    exp  go to state 22


state 16

    4 line: exp '\n' .

    $default  reduce using rule 4 (line)


state 17

   12 exp: '(' exp ')' .

    $default  reduce using rule 12 (exp)


state 18

    6 exp: exp . '+' exp
    7    | exp . '-' exp
    7    | exp '-' exp .  ['-', '+', '\n', ')']
    8    | exp . '*' exp
    9    | exp . '/' exp
   11    | exp . '^' exp

    '*'  shift, and go to state 13
    '/'  shift, and go to state 14
    '^'  shift, and go to state 15

    $default  reduce using rule 7 (exp)

    Conflict between rule 7 and token '-' resolved as reduce (%left '-').
    Conflict between rule 7 and token '+' resolved as reduce (%left '+').
    Conflict between rule 7 and token '*' resolved as shift ('-' < '*').
    Conflict between rule 7 and token '/' resolved as shift ('-' < '/').
    Conflict between rule 7 and token '^' resolved as shift ('-' < '^').


state 19

    6 exp: exp . '+' exp
    6    | exp '+' exp .  ['-', '+', '\n', ')']
    7    | exp . '-' exp
    8    | exp . '*' exp
    9    | exp . '/' exp
   11    | exp . '^' exp

    '*'  shift, and go to state 13
    '/'  shift, and go to state 14
    '^'  shift, and go to state 15

    $default  reduce using rule 6 (exp)

    Conflict between rule 6 and token '-' resolved as reduce (%left '-').
    Conflict between rule 6 and token '+' resolved as reduce (%left '+').
    Conflict between rule 6 and token '*' resolved as shift ('+' < '*').
    Conflict between rule 6 and token '/' resolved as shift ('+' < '/').
    Conflict between rule 6 and token '^' resolved as shift ('+' < '^').


state 20

    6 exp: exp . '+' exp
    7    | exp . '-' exp
    8    | exp . '*' exp
    8    | exp '*' exp .  ['-', '+', '*', '/', '\n', ')']
    9    | exp . '/' exp
   11    | exp . '^' exp

    '^'  shift, and go to state 15

    $default  reduce using rule 8 (exp)

    Conflict between rule 8 and token '-' resolved as reduce ('-' < '*').
    Conflict between rule 8 and token '+' resolved as reduce ('+' < '*').
    Conflict between rule 8 and token '*' resolved as reduce (%left '*').
    Conflict between rule 8 and token '/' resolved as reduce (%left '/').
    Conflict between rule 8 and token '^' resolved as shift ('*' < '^').


state 21

    6 exp: exp . '+' exp
    7    | exp . '-' exp
    8    | exp . '*' exp
    9    | exp . '/' exp
    9    | exp '/' exp .  ['-', '+', '*', '/', '\n', ')']
   11    | exp . '^' exp

    '^'  shift, and go to state 15

    $default  reduce using rule 9 (exp)

    Conflict between rule 9 and token '-' resolved as reduce ('-' < '/').
    Conflict between rule 9 and token '+' resolved as reduce ('+' < '/').
    Conflict between rule 9 and token '*' resolved as reduce (%left '*').
    Conflict between rule 9 and token '/' resolved as reduce (%left '/').
    Conflict between rule 9 and token '^' resolved as shift ('/' < '^').


state 22

    6 exp: exp . '+' exp
    7    | exp . '-' exp
    8    | exp . '*' exp
    9    | exp . '/' exp
   11    | exp . '^' exp
   11    | exp '^' exp .  ['-', '+', '*', '/', '\n', ')']

    '^'  shift, and go to state 15

    $default  reduce using rule 11 (exp)

    Conflict between rule 11 and token '-' resolved as reduce ('-' < '^').
    Conflict between rule 11 and token '+' resolved as reduce ('+' < '^').
    Conflict between rule 11 and token '*' resolved as reduce ('*' < '^').
    Conflict between rule 11 and token '/' resolved as reduce ('/' < '^').
    Conflict between rule 11 and token '^' resolved as shift (%right '^').
