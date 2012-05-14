USING: kernel arrays sequences locals ;
IN: ttt.core

SYMBOL: X
SYMBOL: O
SYMBOL: _

: <empty-board> ( size -- board ) dup _ <array> <array> ;

: marker-at ( x y board -- marker ) nth nth ;
: occupied? ( x y board -- ? ) marker-at _ eq? not ;

! Destructively changes a board cell to a marker
:: (move!) ( marker x y board -- ) marker x y board nth set-nth ;
