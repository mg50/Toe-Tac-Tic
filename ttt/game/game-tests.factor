USING: kernel ttt.game tools.test locals accessors vectors ttt.core  sequences math io  prettyprint ;
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

! do-until-game-over
! creates a mock game that ends in four iterations, filling an accumulator with indices on each iteration
[let 3 :> counter!
    { } :> accumulator!
    f <game> :> game
    game { { _ _ } { _ _ } } >>board drop

    [ { 3 2 1 } ]
    [ game
      [
          accumulator counter suffix accumulator!
          counter 1 - counter!
          counter 0 = [ { { X X } { _ _ } } >>board drop ] [ drop ] if
      ] do-until-game-over
      accumulator
    ]
    unit-test
]
