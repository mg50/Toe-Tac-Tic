USING: kernel ttt.strategy ttt.core combinators ;
IN: ttt.strategy.ai

CONSTANT: infinity 1
CONSTANT: -infinity -1


: leaf-score ( board -- n ) {
    { [ dup X swap winner? ] [ drop infinity ] }
    { [ dup O swap winner? ] [ drop -infinity ] }
    [ drop 0 ]
} cond ;
