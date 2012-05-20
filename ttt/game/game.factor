USING: kernel accessors locals accessors combinators ttt.core ttt.player prettyprint io ttt.ui ttt.strategy.ai ttt.strategy.human ;
IN: ttt.game

TUPLE: game player-X player-O current-player board ui ;

: <game> ( ui -- g ) game new swap >>ui X f <player> >>player-X O f <player> >>player-O ;


: other-player ( game -- player ) {
    [ current-player>> ] [ player-O>> ]
    [ player-X>> ] [ player-O>> ]
} cleave [ = ] 2dip [ [ ] curry ] bi@ if ;

: switch-current-player ( game -- game ) dup other-player >>current-player ;

: do-until-game-over ( game quot: ( ..g -- ..g ) -- game )
    [ dup board>> game-over? ] swap do until ; inline

: full-turn ( game -- game ) [
    [ board>> ] [ ui>> ] [ current-player>> ]
    tri get-and-make-move
] [ switch-current-player ] bi ;

: play-game-to-end ( game -- game ) [ full-turn ] do-until-game-over ;

:: select-board-size ( game -- game ) "Select board size:" { "3x3" "4x4" }
    game ui>> prompt-options {
        { [ dup 0 = ] [ drop 3 <empty-board> ] }
        { [ dup 1 = ] [ drop 4 <empty-board> ] }
    } cond game swap >>board ;

:: select-play-vs-ai ( game -- game ? ) [let
    game ui>> :> ui

    game player-X>>
    game player-O>>
    "Play against AI?" { "y" "n" } ui prompt-options
    {
        { [ dup 0 = ] [ drop [ ai-strategy new >>strategy drop ] bi@ t ] }
        { [ dup 1 = ] [ drop [ human-strategy new >>strategy drop ] bi@ f ] }
    } cond game swap
] ;

:: select-player ( game -- game ) [let
    game
    "Play as X?" { "y" "n" } game ui>> prompt-options
    {
        { [ dup 0 = ] [ drop player-X>> ] }
        { [ dup 1 = ] [ drop player-O>> ] }
    } cond human-strategy new >>strategy drop game
] ;
