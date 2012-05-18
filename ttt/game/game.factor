USING: kernel accessors locals accessors combinators ;
IN: ttt.game

TUPLE: game player-X player-O current-player board ui ;

: <game> ( -- g ) game new ;


: other-player ( game -- player ) {
    [ current-player>> ] [ player-O>> ]
    [ player-X>> ] [ player-O>> ]
} cleave [ = ] 2dip [ [ ] curry ] bi@ if ;
