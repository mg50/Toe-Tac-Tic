USING: kernel ttt.ui ttt.ui.console tools.test io.streams.string ;
IN: ttt.ui.console.tests

[ 1 ] [ 1 ] unit-test

! print-message
[ "Hello\n" ] [ [ "Hello" <console-ui> print-message ] with-string-writer ] unit-test
[ "Goodbye\n" ] [ [ "Goodbye" <console-ui> print-message ] with-string-writer ] unit-test
