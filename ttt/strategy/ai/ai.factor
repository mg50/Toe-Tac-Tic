USING: kernel ttt.strategy ttt.core combinators locals math.ranges sequences accessors math io prettyprint namespaces assocs math.parser ;
IN: ttt.strategy.ai

TUPLE: ai-strategy < strategy coords ;

CONSTANT: infinity 1
CONSTANT: -infinity -1

CONSTANT: X-cache H{ }
CONSTANT: O-cache H{ }

: cache-for-marker ( marker -- cache ) X = [ X-cache ] [ O-cache ] if ;

: marker-value ( marker -- string ) {
    { [ dup X = ] [ drop "X" ] }
    { [ dup O = ] [ drop "O" ] }
    { [ dup _ = ] [ drop " " ] }
} cond ;

: board-hash ( board -- string ) [ [ marker-value ] map "" join ] map "" join ;

: coords ( board -- seq ) length [0,b) dup cartesian-product concat ; inline
: empty-coords ( board -- seq ) dup coords [ dupd swap [ 2array@ ] dip occupied? not  ] filter swap drop ;

:: map-each-coord ( board quot -- seq )
    board coords [ 2array@ board quot call ] map ; inline

: leaf-score ( board -- n ) {
    { [ dup X swap winner? ] [ drop infinity ] }
    { [ dup O swap winner? ] [ drop -infinity ] }
    [ drop 0 ]
} cond ;

:: child-nodes ( marker board -- seq ) board [| x y b | marker x y b try-move ] map-each-coord sift ;

:: for-while ( seq condition: ( -- ? ) body: ( el -- x ) -- x ) [let
    0 :> idx!
    f [ idx seq length < condition call and ] [ drop idx seq nth
                                                idx 1 + idx!
                                                body call ] while
] ; inline

:: call-on-children-while-b>a ( board depth a b marker fn: ( board depth a b marker -- n ) -- score ) [let
    a :> a!
    b :> b!

    marker board child-nodes [ b a > ]
    [
        depth 1 - a b marker other-marker fn call
        marker X =
        [ dup a > [ a! ] [ drop ] if a ]
        [ dup b < [ b! ] [ drop ] if b ]
        if
    ] for-while
] ; inline

:: ab-pruning-score ( board depth a b marker -- n ) [let
    board leaf-score :> leaf-score
    board board-hash :> board-hash
    marker cache-for-marker :> marker-cache
    f :> score!

    {
        { [ depth 0 = leaf-score 0 = not or ] [ leaf-score ] }
        { [ board-hash marker-cache at dup score! ] [ score ] }
        [ board depth a b marker [ ab-pruning-score ] call-on-children-while-b>a
          dup score!
          dup board-hash marker-cache set-at ]
    } cond
] ;


! takes a sequence of elements and returns the element whose image under a specified function satisfies some criterion over the whole space of images
:: champion ( seq fitness-fn: ( el -- n ) selector: ( seq -- el ) -- el )
    seq fitness-fn map dup selector call swap index seq nth ; inline

M:: ai-strategy get-next-move ( marker board ui strategy -- x y ) [let
    board empty-coords :> empty-coords
    empty-coords length :> depth
    marker other-marker :> other-marker

    empty-coords [
        marker swap 2array@ board (move) :> child-board
        child-board depth 1 - -infinity infinity other-marker ab-pruning-score
    ]
    [ marker X = [ supremum ] [ infimum ] if ]
    champion 2array@
] ;
