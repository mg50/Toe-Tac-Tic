USING: kernel arrays sequences locals math sets combinators ;
IN: ttt.core

SYMBOL: X
SYMBOL: O
SYMBOL: _

: <empty-board> ( size -- board ) dup _ <array> <array> ;

: marker-at ( x y board -- marker ) nth nth ;
: occupied? ( x y board -- ? ) marker-at _ eq? not ;

! Destructively changes a board cell to a marker
:: (move!) ( marker x y board -- ) marker x y board nth set-nth ;

! Returns a mutated copy of a board with a marker placed in a cell
:: (move) ( marker x y board -- board' ) [let
    board [ clone ] map :> board2
    marker x y board2 (move!)
    board2
] ;

: try-move ( marker x y board -- board? ) 3dup occupied?
    [ drop 3drop f ] [ (move) ] if ;

: rows ( board -- x ) ;
: columns ( board -- x ) flip ;
: left-diag ( board -- x ) [ swap nth  ] map-index ;
: right-diag ( board -- x ) dup length 1 - [ swap - swap nth ] curry map-index ;

! Retrieves all lines from a board, removing duplicates
: lines ( board -- x ) { [ rows ] [ columns ] [ left-diag ] [  right-diag ] }
    cleave 2array 3append members ;

: board-full? ( board -- ? ) concat [ _ = ] any? not ;

: winning-line ( marker board -- line ) length swap <array> ;

: winner? ( marker board -- ? ) dup swapd winning-line [ = ] curry swap lines swap any? ;
: winner-exists? ( board -- ? ) [ X swap winner? ] [ O swap winner? ] bi or ;
