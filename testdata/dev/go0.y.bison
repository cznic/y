Grammar

    0 $accept: File $end

    1 $@1: /* empty */

    2 File: PackageDecl $@1 Imports

    3 PackageDecl: 'P' Symbol ';'

    4 Imports: 'I'

    5 Symbol: 'S'


Terminals, with rules where they appear

$end (0) 0
';' (59) 3
'I' (73) 4
'P' (80) 3
'S' (83) 5
error (256)


Nonterminals, with rules where they appear

$accept (7)
    on left: 0
File (8)
    on left: 2, on right: 0
$@1 (9)
    on left: 1, on right: 2
PackageDecl (10)
    on left: 3, on right: 2
Imports (11)
    on left: 4, on right: 2
Symbol (12)
    on left: 5, on right: 3


state 0

    0 $accept: . File $end
    2 File: . PackageDecl $@1 Imports
    3 PackageDecl: . 'P' Symbol ';'

    'P'  shift, and go to state 1

    File         go to state 2
    PackageDecl  go to state 3


state 1

    3 PackageDecl: 'P' . Symbol ';'
    5 Symbol: . 'S'

    'S'  shift, and go to state 4

    Symbol  go to state 5


state 2

    0 $accept: File . $end

    $end  shift, and go to state 6


state 3

    1 $@1: .
    2 File: PackageDecl . $@1 Imports

    $default  reduce using rule 1 ($@1)

    $@1  go to state 7


state 4

    5 Symbol: 'S' .

    $default  reduce using rule 5 (Symbol)


state 5

    3 PackageDecl: 'P' Symbol . ';'

    ';'  shift, and go to state 8


state 6

    0 $accept: File $end .

    $default  accept


state 7

    2 File: PackageDecl $@1 . Imports
    4 Imports: . 'I'

    'I'  shift, and go to state 9

    Imports  go to state 10


state 8

    3 PackageDecl: 'P' Symbol ';' .

    $default  reduce using rule 3 (PackageDecl)


state 9

    4 Imports: 'I' .

    $default  reduce using rule 4 (Imports)


state 10

    2 File: PackageDecl $@1 Imports .

    $default  reduce using rule 2 (File)
