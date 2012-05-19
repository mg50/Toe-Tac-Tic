USING: ttt.player vectors ttt.core ;
IN: ttt.player.mock

TUPLE: mock-player marker moves ;

: <mock-player> ( marker moves -- player ) >vector reverse player new >>moves >>marker ;

M:: mock-player get-and-make-move ( board ui player -- ) player marker>> player moves>> pop 2array@ board (move!) ;
