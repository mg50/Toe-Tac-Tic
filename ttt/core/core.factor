USING: kernel arrays sequences locals math sets combinators ;
IN: ttt.core

SYMBOL: X
SYMBOL: O
SYMBOL: _

: other-marker ( marker -- marker ) X = [ O ] [ X ] if ;

! Consumes sequence and places the first and second elements onto the stack - opposite of 2array.
: 2array@ ( seq -- x y ) [ first ] [ second ] bi ;
: 3array@ ( seq -- x y z ) [ first ] [ second ] [ third ] tri ;

: <empty-board> ( size -- board ) dup _ <array> <array> [ clone ] map ;

: marker-at ( x y board -- marker ) nth nth ;
: occupied? ( x y board -- ? ) marker-at _ eq? not ;
:: in-bounds? ( x y board -- ? ) x y [ 0 >= ] bi@ and
    x y [ board length < ] bi@ and and ;

: available? ( x y board -- ? ) [ 3array ] [ ] 3bi in-bounds? [ 3array@ occupied? not ] [ drop f ] if ;

! Destructively changes a board cell to a marker
: move! ( marker x y board -- ) nth set-nth ;

! Returns a mutated copy of a board with a marker placed in a cell
: (move) ( marker x y board -- board' ) [ clone ] map dup [ move! ] dip ;

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
: draw? ( board -- ? ) [ winner-exists? not ] [ board-full? ] bi and ;
: game-over? ( board -- ? ) [ winner-exists? ] [ board-full? ] bi or ;
