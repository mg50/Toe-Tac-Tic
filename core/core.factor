USING: kernel arrays sequences ;
IN: ttt.core

SYMBOL: X
SYMBOL: O
SYMBOL: _

: <empty-board> ( size -- board ) dup _ <array> <array> ;

: marker-at ( x y board -- marker ) ?nth ?nth ;
