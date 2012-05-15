USING: tools.test ttt.core kernel locals sequences ;
IN: ttt.core.tests

[ -1 <empty-board> ] must-fail
[ { } ] [ 0 <empty-board> ] unit-test
[ { { _ } } ] [ 1 <empty-board> ] unit-test
[ { { _ _ } { _ _ } } ] [ 2 <empty-board> ] unit-test
[ { { _ _ _ } { _ _ _ } { _ _ _ } } ] [ 3 <empty-board> ] unit-test


[ _ ] [ 1 1 2 <empty-board> marker-at ] unit-test
[ O ] [ 1 0 { { X O } } marker-at ] unit-test
[ X ] [ 1 0 { { O X } } marker-at ] unit-test
[ 3 3 { { X } { X } } marker-at ] must-fail
[ _ ] [ 1 1 { { X X X } { X _ X } { O O O } } marker-at ] unit-test

[ t ] [ 0 0 { { X O } } occupied? ] unit-test
[ f ] [ 0 0 { { _ X } } occupied? ] unit-test
[ t ] [ 1 0 { { _ X } } occupied? ] unit-test
[ 3 3 { { _ X } } occupied? ] must-fail


! (move!) tests
[ O ] [ [let { { X } } :> board
    O 0 0 board (move!)
    0 0 board marker-at
] ] unit-test

[let { { O _ } { _ O } } :> board
    [ t ] [ X 1 0 board (move!)
            O 0 1 board (move!)
            board { { O X } { O O } } sequence=
    ] unit-test
]


! (move) tests
[let { { X } } :> board
    _ 0 0 board (move) :> board'

    [ X ] [ 0 0 board marker-at ] unit-test
    [ _ ] [ 0 0 board' marker-at ] unit-test
]

! try-move tests
[let { { X } { _ } } :> board
    O 0 1 board try-move :> board'
    O 0 0 board try-move :> board''

    [ _ ] [ 0 1 board marker-at ] unit-test
    [ O ] [ 0 1 board' marker-at ] unit-test
    [ f ] [ board'' ] unit-test
]

[let { { X X } { O O } } :> board
    [ t ] [ board rows board eq? ] unit-test
]

[let { { X X } { O X } } :> board
    [ t ] [ board columns { { X O } { X X } } sequence= ] unit-test
]

! left-diag
[let { { X X X } { _ _ _ } { O O O } } :> board
    [ t ] [ board left-diag { X _ O } sequence= ] unit-test
]

[let { { X _ O } { _ O X } { O X _ } } :> board
    [ t ] [ board left-diag { X O _ } sequence= ] unit-test
]

! right-diag
[let { { X X X } { _ _ _ } { O O O } } :> board
    [ t ] [ board right-diag { X _ O } sequence= ] unit-test
]

[let { { X _ O } { _ O X } { O X _ } } :> board
    [ t ] [ board right-diag { O O O } sequence= ] unit-test
]
