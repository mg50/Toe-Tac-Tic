USING: kernel ttt.game tools.test locals accessors vectors ttt.core  sequences math ttt.strategy.mock ttt.player ttt.ui.console ttt.tools.test io prettyprint classes ttt.strategy.human ttt.strategy.ai ;
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


! play-game-to-end
[let
    game new :> game

    X { { 1 1 } { 0 0 } { 2 2 } } <mock-strategy> <player> :> px
    O { { 0 1 } { 2 1 } } <mock-strategy> <player> :> po

    game { { _ _ _ } { _ _ _ } { _ _ _ } } >>board
    <console-ui> >>ui
    px >>player-X
    px >>current-player
    po >>player-O drop

    [ { { X _ _ } { O X O } { _ _ X } } ] [ game play-game-to-end board>> ] output>store unit-test
]

! select-board-size
[ 3 ] [ game new <console-ui> >>ui select-board-size board>> length ] "3x3" string>input output>store unit-test
"Select board size (options: 3x3/4x4): " assert-last-unit-test-output

[ 4 ] [ game new <console-ui> >>ui select-board-size board>> length ] "4x4" string>input output>store unit-test

[ 4 ] [ game new <console-ui> >>ui select-board-size board>> length ] "invalid\n4x4" string>input output>store unit-test


! select-play-vs-ai
[let
    <console-ui> <game> :> game

    [ t ai-strategy ] [ game select-play-vs-ai swap player-X>> strategy>> class-of ] "y" string>input output>store unit-test
    [ ai-strategy ] [ game player-O>> strategy>> class-of ] unit-test
    "Play against AI? (options: y/n): " assert-last-unit-test-output
]

[let
    <console-ui> <game> :> game

    [ f human-strategy ] [ game select-play-vs-ai swap player-X>> strategy>> class-of ] "n" string>input output>store unit-test
    [ human-strategy ] [ game player-X>> strategy>> class-of ] unit-test
    "Play against AI? (options: y/n): " assert-last-unit-test-output
]

! select-player
[let
    <console-ui> <game> :> game

    [ human-strategy ] [ game select-player player-X>> strategy>> class-of ] "y" string>input output>store unit-test
    [ f ] [ game player-O>> strategy>> ] unit-test
    "Play as X? (options: y/n): " assert-last-unit-test-output

]
[let
    <console-ui> <game> :> game

    [ human-strategy ] [ game select-player player-O>> strategy>> class-of ] "n" string>input output>store unit-test
    [ f ] [ game player-X>> strategy>> ] unit-test
]

! prompt-play-again
[let
    <console-ui> <game> :> game

    game [ t ] curry [ game prompt-play-again ] "y" string>input output>store unit-test
    "Play again? (options: y/n): " assert-last-unit-test-output

]
[let
    <console-ui> <game> :> game

    game [ f ] curry [ game prompt-play-again ] "n" string>input output>store unit-test
]

! win-message
[let
    game new :> game
    game { { _ O _ } { X X X } { _ _ _ } } >>board drop
    [ "Player X won!" ] [ game win-message ] unit-test
]
[let
    game new :> game
    game { { _ O _ } { X X X } { _ _ _ } } >>board drop
    [ "Player X won!" ] [ game win-message ] unit-test
]
[let
    game new :> game
    game { { _ X O } { _ X O } { _ _ O } } >>board drop
    [ "Player O won!" ] [ game win-message ] unit-test
]
[let
    game new :> game
    game { { _ O _ } { X _ X } { _ _ _ } } >>board drop
    [ "The game ended in a draw!" ] [ game win-message ] unit-test
]
[let
    game new :> game
    game { { O X O } { X O X } { X O X } } >>board drop
    [ "The game ended in a draw!" ] [ game win-message ] unit-test
]
