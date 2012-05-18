USING: kernel ttt.game tools.test locals accessors ;
IN: ttt.game.tests

! other-player
[let f <game> :> game
    game 1 >>current-player
    1 >>player-X
    2 >>player-O drop

    [ 2 ] [ game other-player ] unit-test
]
[let f <game> :> game
    game 2 >>current-player
    1 >>player-X
    2 >>player-O drop

    [ 1 ] [ game other-player ] unit-test
]

! switch-current-player
[let f <game> :> game
    game 1 >>current-player
    1 >>player-X
    2 >>player-O drop

    [ 2 ] [ game switch-current-player current-player>> ] unit-test
]
[let f <game> :> game
    game 2 >>current-player
    1 >>player-X
    2 >>player-O drop

    [ 1 ] [ game switch-current-player current-player>> ] unit-test
]