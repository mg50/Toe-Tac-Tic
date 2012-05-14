USING: kernel arrays ;
IN: ttt.core

SYMBOL: X
SYMBOL: O
SYMBOL: _

: <empty-board> ( size -- board ) dup _ <array> <array> ;
