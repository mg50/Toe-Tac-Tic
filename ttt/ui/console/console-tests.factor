USING: kernel ttt.ui ttt.ui.console tools.test io.streams.string arrays ;
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
