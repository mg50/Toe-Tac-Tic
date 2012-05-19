USING: kernel ttt.player tools.test ttt.core ttt.strategy.mock ttt.ui.console locals ttt.tools.test ;
IN: ttt.player.tests

! get-and-make-move
[let
    X :> marker
    { { 0 0 } } <mock-strategy> :> strat
    { { _ _  } { _ _ } } :> board
    <console-ui> :> ui

    marker strat <player> :> player

    [ X ] [ board ui player get-and-make-move
            0 0 board marker-at ] output>store unit-test
]


[let
    O :> marker
    { { 1 1 } } <mock-strategy> :> strat
    { { _ _ _  } { _ O _ } { _ _ _ } } :> board
    <console-ui> :> ui

    marker strat <player> :> player

    [ O ] [ board ui player get-and-make-move
            1 1 board marker-at ] output>store unit-test
]
