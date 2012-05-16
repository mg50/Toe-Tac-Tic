USING: kernel ttt.ui ttt.ui.console tools.test io.streams.string arrays ttt.core locals ;
IN: ttt.ui.console.tests

: unit-test-with-string-writer ( quot1 quot2 -- ) [ with-string-writer ] curry unit-test ;

! : unit-test-with-string-reader

! print-message
[ "Hello\n" ]  [ "Hello" <console-ui> print-message ] unit-test-with-string-writer
[ "Goodbye\n" ] [ "Goodbye" <console-ui> print-message ] unit-test-with-string-writer

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
[ "\n---\n" ] [ { 1 2 3 } make-separator ] unit-test
[ "\n----\n" ] [ { { } { } { } { } } make-separator ] unit-test

! display-board
[ "X|O\n--\n |O" ] [ { { X O } { _ O } } display-board ] unit-test
[ "X|X|X\n---\nO| | \n---\nO|O|O" ] [ { { X X X } { O _ _ } { O O O } } display-board ] unit-test

! update-display method
[let <console-ui> :> ui
    [ "X|O\n--\n |O\n\n" ] [ { { X O } { _ O } } ui update-display ] unit-test-with-string-writer
    [ "X|X|X\n---\nO| | \n---\nO|O|O\n\n" ] [ { { X X X } { O _ _ } { O O O } } ui update-display ] unit-test-with-string-writer
]
