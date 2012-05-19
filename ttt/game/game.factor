USING: kernel accessors locals accessors combinators ttt.core ttt.player ;
IN: ttt.game

TUPLE: game player-X player-O current-player board ui ;

: <game> ( ui -- g ) game new swap >>ui ;


: other-player ( game -- player ) {
    [ current-player>> ] [ player-O>> ]
    [ player-X>> ] [ player-O>> ]
} cleave [ = ] 2dip [ [ ] curry ] bi@ if ;

: switch-current-player ( game -- game ) dup other-player >>current-player ;

:: do-until-game-over ( game quot: ( ... g -- ... ) -- )
    [ game board>> game-over? ] [ game quot call ] do until ; inline

: full-turn ( game -- ) [
    [ board>> ] [ ui>> ] [ current-player>> ]
    tri get-and-make-move
] [ switch-current-player drop ] bi ;

: play-game-to-end ( game -- ) [ full-turn ] do-until-game-over ;
