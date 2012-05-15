USING: tools.test ttt.core kernel locals sequences sets ;
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

! lines
[let { { X O } { _ O } } :> board
    [ t ] [ board lines { { X O } { _ O } { X _ } { O O } { O _ } } set= ] unit-test
]

[let { { X O _ } { _ O X } { _ _ _ } } :> board
    [ t ] [ board lines {
        { X O _ } { _ O X } { _ _ _ }
        { X _ _ } { O O _ } { _ X _ }
        { X O _ } { _ O _ }
    }
    set= ] unit-test
]


! board-full?
[ t ] [ { { X X } { O O } } board-full? ] unit-test
[ f ] [ { { X X } { _ O } } board-full? ] unit-test
[ t ] [ { { X O X } { O O O } { X X X } } board-full? ] unit-test
[ f ] [ { { X O X } { _ O O } { X _ X } } board-full? ] unit-test

! winning-line
[ t ] [ X { { X O } { O X } } winning-line { X X } sequence= ] unit-test
[ t ] [ O { { _ _ _ } { _ O _ } { _ O O } } winning-line { O O O } sequence= ] unit-test

! winner?
[ t ] [ X { { X X } { O O } } winner? ] unit-test
[ t ] [ O { { X X } { O O } } winner? ] unit-test
[ f ] [ O { { X X } { _ O } } winner? ] unit-test
[let { { X O _ } { O X _ } { O _ X } } :> board
    [ t ] [ X board winner? ] unit-test
    [ f ] [ O board winner? ] unit-test
]

! winner-exists?
[ f ] [ { { _ _ } { _ _ } } winner-exists? ] unit-test
[ t ] [ { { X X } { O O } } winner-exists? ] unit-test
[ t ] [ { { X O _ } { O X _ } { O _ X } } winner-exists? ] unit-test
[ f ] [ { { X O _ } { O X _ } { O _ _ } } winner-exists? ] unit-test

! draw?
[ f ] [ { { _ _ } { _ _ } } draw? ] unit-test
[ f ] [ { { X _ } { O _ } } draw? ] unit-test
[ f ] [ { { X X } { O _ } } draw? ] unit-test
[ f ] [ { { X O } { O _ } } draw? ] unit-test
[ f ] [ { { X X X } { _ _ _ } { _ _ _ } } draw? ] unit-test
[ t ] [ { { O X O } { X X O } { O O X } } draw? ] unit-test
