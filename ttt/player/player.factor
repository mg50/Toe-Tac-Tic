USING: locals accessors ttt.strategy ttt.core kernel accessors ;
IN: ttt.player


TUPLE: player marker strategy ;

:: <player> ( marker strat -- player ) player new
    marker >>marker strat >>strategy ;

:: get-and-make-move ( board ui player -- ) [let
    player strategy>> :> strat
    player marker>> :> marker

    marker dup board ui strat get-next-move board (move!)
] ;
