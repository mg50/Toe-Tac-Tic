USING: kernel ttt.game tools.test locals accessors vectors ttt.core  sequences math ttt.strategy.mock ttt.player ttt.ui.console ttt.tools.test io prettyprint ;
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

    game [ { 3 2 1 } ] curry
    [ game
      [
          accumulator counter suffix accumulator!
          counter 1 - counter!
          counter 0 = [ { { X X } { _ _ } } >>board ] [ ] if
      ] do-until-game-over
      accumulator
    ] unit-test
]

! full-turn
[let
    game new :> game

    X { { 0 0 } } <mock-strategy> <player> :> px
    O { { 1 1 } } <mock-strategy> <player> :> po

    game { { _ _ } { _ _ } } >>board
    <console-ui> >>ui
    px >>current-player
    px >>player-X
    po >>player-O drop

    [ { { X _ } { _ _ } } ] [ game full-turn board>> ] output>store unit-test

    [ O ] [ game current-player>> marker>> ] unit-test
]


! full-turn
[let
    game new :> game

    X { { 1 1 } } <mock-strategy> <player> :> px
    O { { 0 1 } } <mock-strategy> <player> :> po

    game { { X _ } { _ _ } } >>board
    <console-ui> >>ui
    px >>player-X
    po >>player-O
    po >>current-player drop

    [ { { X _ } { O X } } ] [ game full-turn full-turn board>> ] output>store unit-test

    [ O ] [ game current-player>> marker>> ] unit-test
]
