USING: kernel ttt.tools.test tools.test io namespaces strings ;
IN: ttt.tools.test-tests

! output>stack
[ "hello\n" ] [ [ "hello" print ] output>stack call ] unit-test
[ "bye\n" ] [ [ "bye" print ] output>stack call ] unit-test

! string>input
[ "hello" ] [ [ readln ] "hello" string>input call ] unit-test
[ "bye" ] [ [ readln ] "bye" string>input call ] unit-test

! output>store, last-test-output
[ "1\n" ] [ [ "1" print ] output>store call OUT get >string ] unit-test
[ [ "1\n" ] ] [ last-test-output ] unit-test

[ "2\n" ] [ [ "2" print ] output>store call OUT get >string ] unit-test
[ [ "2\n" ] ] [ last-test-output ] unit-test
