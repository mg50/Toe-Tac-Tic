USING: kernel ttt.strategy ttt.core combinators ;
IN: ttt.strategy.ai

CONSTANT: infinity 1
CONSTANT: -infinity -1

: 2d-map-index ( seq quot -- seq ) [ ] curry map-index

: leaf-score ( board -- n ) {
    { [ dup X swap winner? ] [ drop infinity ] }
    { [ dup O swap winner? ] [ drop -infinity ] }
    [ drop 0 ]
} cond ;

:: child-boards ( board strategy -- seq ) [let
    board length :> l
]
