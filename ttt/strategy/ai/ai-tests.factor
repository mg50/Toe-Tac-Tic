USING: kernel ttt.strategy.ai ttt.core tools.test locals sets sequences arrays ;
IN: ttt.strategy.ai.tests

! Asserts that the results of calling the two quotations contain the same members
: unit-test-same-members ( quot1 quot2 -- ) [ [ call ] bi@ set= ] 2curry [ t ] swap unit-test ;


! coords
[ { { 0 1 } { 1 0 } { 1 1 } { 0 0 } } ] [ { { } { } } coords ] unit-test-same-members
[ 9 ] [ { { } { } { } } coords length ] unit-test

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
