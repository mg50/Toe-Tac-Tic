USING: kernel ttt.strategy ttt.core combinators locals math.ranges sequences accessors ;
IN: ttt.strategy.ai

TUPLE: ai-strategy < strategy coords ;

CONSTANT: infinity 1
CONSTANT: -infinity -1

: coords ( board -- seq ) length [0,b) dup cartesian-product concat ; inline

:: map-each-coord ( board quot -- seq )
    board coords [ 2array@ board quot call ] map ; inline

: leaf-score ( board -- n ) {
    { [ dup X swap winner? ] [ drop infinity ] }
    { [ dup O swap winner? ] [ drop -infinity ] }
    [ drop 0 ]
} cond ;

! : child-nodes ( board -- seq ) [ ] map-each-coord sift ;
:: child-nodes ( marker board -- seq ) board [| x y b | marker x y b try-move ] map-each-coord sift ;
