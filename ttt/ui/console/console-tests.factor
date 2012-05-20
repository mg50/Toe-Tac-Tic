USING: kernel ttt.ui ttt.ui.console tools.test io.streams.string arrays ttt.core locals ttt.tools.test ;
IN: ttt.ui.console.tests


! print-message
[ "Hello" ] [ "Hello" <console-ui> print-message ] output>stack unit-test
[ "Goodbye" ] [ "Goodbye" <console-ui> print-message ] output>stack unit-test

! valid-move-stringt?
[ t ] [ "123 432" valid-move-string? ] unit-test
[ f ] [ "123 321 123" valid-move-string? ] unit-test
[ f ] [ "123" valid-move-string? ] unit-test
[ f ] [ "1 one" valid-move-string? ] unit-test

! parse-move-string
[ { 1 2 } ] [ "1 2" parse-move-string 2array ] unit-test
[ { 3 4 } ] [ "3 4" parse-move-string 2array ] unit-test

! display-marker
[ "X" ] [ X display-marker ] unit-test
[ "O" ] [ O display-marker ] unit-test
[ " " ] [ _ display-marker ] unit-test

! display-column
[ "X|X|X" ] [ { X X X } display-column ] unit-test
[ "O| |X" ] [ { O _ X } display-column ] unit-test

! make-separator
[ "\n-----\n" ] [ { 1 2 3 } make-separator ] unit-test
[ "\n-------\n" ] [ { { } { } { } { } } make-separator ] unit-test

! display-board
[ "X|O\n---\n |O" ] [ { { X O } { _ O } } display-board ] unit-test
[ "X|X|X\n-----\nO| | \n-----\nO|O|O" ] [ { { X X X } { O _ _ } { O O O } } display-board ] unit-test

! update-display method
[let <console-ui> :> ui
    [ "X|O\n---\n |O\n\n" ] [ { { X O } { _ O } } ui update-display ] output>stack unit-test
    [ "X|X|X\n-----\nO| | \n-----\nO|O|O\n\n" ] [ { { X X X } { O _ _ } { O O O } } ui update-display ] output>stack unit-test
]

! (prompt-move-until-valid)
[ 1 2 ] [ (prompt-move-until-valid) ] "1 2" string>input unit-test
[ 1 2 ] [ (prompt-move-until-valid) ] "1 2    \n\n" string>input unit-test
[ 3 5 ] [ (prompt-move-until-valid) ] "3 5" string>input unit-test
[ 1 2 ] [ (prompt-move-until-valid) ] "test\n1 2" string>input unit-test
[ 5 2 ] [ (prompt-move-until-valid) ] "5\n5 2" string>input unit-test

! (prompt-move-until-available)
[ 0 0 ] [ { { _ } } (prompt-move-until-available) ] "0 0" string>input unit-test
[ 0 0 ] [ { { _ } } (prompt-move-until-available) ] "1 2\n0 0" string>input unit-test
[ 1 0 ] [ { { O _ } { _ _ } } (prompt-move-until-available) ] "1 0" string>input unit-test
[ 1 0 ] [ { { X _ } { _ _ } } (prompt-move-until-available) ] "0 0\n1 0" string>input unit-test
[ 1 0 ] [ { { X _ } { _ _ } } (prompt-move-until-available) ] "33 11\n1 0" string>input unit-test

! whitespace?
[ t ] [ "  " whitespace? ] unit-test
[ t ] [ "\n" whitespace? ] unit-test
[ t ] [ "    \n " whitespace? ] unit-test
[ f ] [ "a" whitespace? ] unit-test
[ f ] [ " a" whitespace? ] unit-test

! prompt-options
[ 0 ] [ "Test message" { "a" "b" "c" } <console-ui> prompt-options ] "a\n" string>input output>store unit-test
"Test message (options: a/b/c): " assert-last-unit-test-output

[ 1 ] [ "Test message" { "a" "b" "c" } <console-ui> prompt-options ] "b\n" string>input output>store unit-test
[ 2 ] [ "Test message" { "a" "b" "c" } <console-ui> prompt-options ] "c\n" string>input output>store unit-test

[ 0 ] [ "Test message" { "a" "b" "c" } <console-ui> prompt-options ] "blah\na\n" string>input output>store unit-test
[ 2 ] [ "Test message" { "a" "b" "c" } <console-ui> prompt-options ] "blah\nc\n" string>input output>store unit-test
