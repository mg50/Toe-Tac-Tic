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

: full-turn ( game -- game )
    [ [ board>> ] [ ui>> ] bi update-display ]
    [ [ board>> ] [ ui>> ] [ current-player>> ] tri get-and-make-move  ]
    [ switch-current-player ] tri ;

: play-game-to-end ( game -- game ) [ full-turn ] do-until-game-over ;

:: select-board-size ( game -- game ) "Select board size" { "3x3" "4x4" }
    game ui>> prompt-options {
        { [ dup 0 = ] [ drop 3 <empty-board> ] }
        { [ dup 1 = ] [ drop 4 <empty-board> ] }
    } cond game swap >>board ;

:: select-play-vs-ai ( game -- game ? )
    game player-X>>
    game player-O>>
    "Play against AI?" { "y" "n" } game ui>> prompt-options
    {
        { [ dup 0 = ] [ drop [ ai-strategy new >>strategy drop ] bi@ t ] }
        { [ dup 1 = ] [ drop [ human-strategy new >>strategy drop ] bi@ f ] }
    } cond game swap ;

:: select-player ( game -- game )
    game
    "Play as X?" { "y" "n" } game ui>> prompt-options
    {
        { [ dup 0 = ] [ drop player-X>> ] }
        { [ dup 1 = ] [ drop player-O>> ] }
    } cond human-strategy new >>strategy drop game ;

:: prompt-play-again ( game -- game ? )
    "Play again?" { "y" "n" } game ui>> prompt-options {
        { [ dup 0 = ] [ drop t ] }
        { [ dup 1 = ] [ drop f ] }
    } cond game swap ;

: set-current-player-to-X ( game -- game ) dup player-X>> >>current-player ;

: win-message ( game -- string ) board>> {
    { [ dup X swap winner? ] [ drop "Player X won!\n" ] }
    { [ dup O swap winner? ] [ drop "Player O won!\n" ] }
    [ drop "The game ended in a draw!\n" ]
} cond ;

: finish ( game -- game )
    dup [ board>> ] [ ui>> ] bi update-display
    dup [ win-message ] [ ui>> ] bi print-message ;

: run-game ( ui -- game ) <game>
    [ prompt-play-again ]
    [ select-board-size select-play-vs-ai [ select-player ] when
      set-current-player-to-X play-game-to-end finish ] do while ;
