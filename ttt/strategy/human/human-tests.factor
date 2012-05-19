USING: kernel ttt.strategy ttt.strategy.human ttt.core tools.test ttt.tools.test ttt.ui.console locals sequences ;
IN: ttt.strategy.human-tests

! get-next-move
[let
    X :> marker
    { { _ _ } { _ _ } } :> board1
    { { _ _ } { _ X } } :> board2
    <console-ui> :> ui
    human-strategy new :> strat

    [ 1 1 ] [ marker board1 ui strat get-next-move ] "1 1" string>input output>store unit-test

    [ 1 0 ] [ marker board2 ui strat get-next-move ] "1 1\n1 0" string>input output>store unit-test
]
