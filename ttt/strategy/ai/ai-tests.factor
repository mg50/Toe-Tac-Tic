USING: kernel ttt.strategy.ai ttt.core tools.test locals sets sequences arrays math ttt.strategy ;
IN: ttt.strategy.ai.tests

! Asserts that the results of calling the two quotations contain the same members
: unit-test-same-members ( quot1 quot2 -- ) [ [ call ] bi@ set= ] 2curry [ t ] swap unit-test ;


! cache-for-marker
X-cache [ ] curry [ X cache-for-marker ] unit-test
O-cache [ ] curry [ O cache-for-marker ] unit-test

! marker-value
[ "X" ] [ X marker-value ] unit-test
[ "O" ] [ O marker-value ] unit-test
[ " " ] [ _ marker-value ] unit-test

! board-hash
[ "X" ] [ { { X } } board-hash ] unit-test
[ "XOXX" ] [ { { X O } { X X } } board-hash ] unit-test
[ "  OX X OO" ] [ { { _ _ O } { X _ X } { _ O O } } board-hash ] unit-test

! coords
[ { { 0 1 } { 1 0 } { 1 1 } { 0 0 } } ] [ { { } { } } coords ] unit-test-same-members
[ 9 ] [ { { } { } { } } coords length ] unit-test

! empty-coords
[ { { 0 0 } } ] [ { { _ X } { X X } } empty-coords ] unit-test
[ { { 0 0 } { 1 1 } } ] [ { { _ X } { X _ } } empty-coords ] unit-test
[ { { 0 0 } { 1 1 } } ] [ { { _ O } { O _ } } empty-coords ] unit-test
[ { } ] [ { { X X } { X X } } empty-coords ] unit-test

! with-each-coord
[let { { X O } { _ _ } } :> board
    [ { { 0 0 X } { 1 0 O } { 0 1 _ } { 1 1 _ } } ]
    [ board [ 3dup marker-at swap drop 3array ] map-each-coord ] unit-test-same-members
]

! leaf-score
[ 1 ] [ { { X X } { O _ } } leaf-score ] unit-test
[ -1 ] [ { { O O } { X _ } } leaf-score ] unit-test
[ 0 ] [ { { X _ } { _ O } } leaf-score ] unit-test
[ 1 ] [ { { X O _ } { _ X _ } { O O X } } leaf-score ] unit-test

! child-nodes
[let { { X O } { _ _ } } :> board
    [ { { { X O } { X _ } }
        { { X O } { _ X } } } ]
    [ X board child-nodes ] unit-test-same-members

    [ { { { X O } { O _ } }
        { { X O } { _ O } } } ]
    [ O board child-nodes ] unit-test-same-members
]

[let { { X X O } { O O _ } { _ _ X } } :> board
    [ { { { X X O } { O O X } { _ _ X } }
        { { X X O } { O O _ } { X _ X } }
        { { X X O } { O O _ } { _ X X } } } ]
    [ X board child-nodes ] unit-test-same-members

    [ { { { X X O } { O O O } { _ _ X } }
        { { X X O } { O O _ } { O _ X } }
        { { X X O } { O O _ } { _ O X } } } ]
    [ O board child-nodes ] unit-test-same-members
]


! for-while
[let
    0 :> a!
    [ 2 ] [ { 0 1 2 3 4 } [ a 3 < ] [ a 1 + a! ] for-while ] unit-test
]
[let
    0 :> a!
    [ "c" ] [ { "a" "b" "c" "d" "e" } [ a 3 < ] [ a 1 + a! ] for-while ] unit-test
]
[let
    0 :> a!
    [ 4 ] [ { 0 1 2 3 4 } [ a 5 < ] [ a 1 + a! ] for-while ] unit-test
]
[let
    0 :> a!
    [ 4 ] [ { 0 1 2 3 4 } [ a 10 < ] [ a 1 + a! ] for-while ] unit-test
]
[let
    0 :> a!
    [ f ] [ { 0 1 2 3 4 } [ a 0 < ] [ a 1 + a! ] for-while ] unit-test
]
[let
    0 :> a!
    [ f ] [ { } [ a 5 < ] [ a 1 + a! ] for-while ] unit-test
]

! call-on-children-while-b>a
[let
    { { O O } { X _ } } :> board
    [| board depth a b marker | a 2 / ] :> fn
    [ -1/2 ] [ board 1 -1 1 X fn call-on-children-while-b>a ] unit-test
]
[let
    { { O O } { X _ } } :> board
    [| board depth a b marker | b 2 / ] :> fn
    [ 1/2 ] [ board 1 -1 1 O fn call-on-children-while-b>a ] unit-test
]
[let
    { { O O } { _ _ } } :> board
    [| board depth a b marker | a 2 / ] :> fn
    [ -1/4 ] [ board 1 -1 1 X fn call-on-children-while-b>a ] unit-test
]
[let
    { { O O } { _ _ } } :> board
    [| board depth a b marker | b 2 / ] :> fn
    [ 1/4 ] [ board 1 -1 1 O fn call-on-children-while-b>a ] unit-test
]
[let
    { { O O } { _ _ } } :> board
    [| board depth a b marker | a 2 / ] :> fn
    [ -1/2 ] [ board 1 -1 -1/2 X fn call-on-children-while-b>a ] unit-test
]

! ab-pruning-score
[ 1 ] [ { { X X _ } { _ _ _ } { _ _ _ } } 7 -1 1 X ab-pruning-score ] unit-test
[ -1 ] [ { { O O _ } { _ _ _ } { _ _ _ } } 7 -1 1 O ab-pruning-score ] unit-test
[ 1 ] [ { { X O X } { X X X } { O X O } } 0 -1 1 X ab-pruning-score ] unit-test
[ -1 ] [ { { X O X } { X X O } { O O O } } 0 -1 1 X ab-pruning-score ] unit-test
[ 0 ] [ { { X O X } { X X O } { O X O } } 0 -1 1 X ab-pruning-score ] unit-test
[ 0 ] [ { { X O X } { X X O } { O X O } } 0 -1 1 O ab-pruning-score ] unit-test
[ 1 ] [ { { X X _ } { X O O } { _ _ _ } } 4 -1 1 O ab-pruning-score ] unit-test
[ 1 ] [ { { X O _ } { _ _ _ } { _ _ _ } } 7 -1 1 X ab-pruning-score ] unit-test

! champion
[ 3 ] [ { 1 2 3 } [ ] [ supremum ] champion ] unit-test
[ 1 ] [ { 1 2 3 } [ ] [ infimum ] champion ] unit-test
[ 3 ] [ { 1 3 2 3 1 3 } [ ] [ supremum ] champion ] unit-test
[ 1 ] [ { 1 2 3 } [ -1 * ] [ supremum ] champion ] unit-test
[ { } [ ] [ supremum ] champion ] must-fail

! get-next-move
[let
    ai-strategy new :> strat

    [ 0 0 ] [ X { { _ X } { _ _ } } f strat get-next-move ] unit-test
    [ 0 0 ] [ O { { _ O } { _ _ } } f strat get-next-move ] unit-test

    [ 2 2 ] [ X { { X O O } { O X _ } { _ _ _ } } f strat get-next-move ] unit-test
    [ 1 1 ] [ O { { X _ _ } { _ _ _ } { _ _ _ } } f strat get-next-move ] unit-test
    [ 1 0 ] [ X { { X _ _ } { O _ _ } { _ _ _ } } f strat get-next-move ] unit-test
]
