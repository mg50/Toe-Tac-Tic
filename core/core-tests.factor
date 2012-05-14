USING: tools.test ttt.core kernel ;
IN: ttt.core.tests

[ -1 <empty-board> ] must-fail
[ { } ] [ 0 <empty-board> ] unit-test
[ { { _ } } ] [ 1 <empty-board> ] unit-test
[ { { _ _ } { _ _ } } ] [ 2 <empty-board> ] unit-test
[ { { _ _ _ } { _ _ _ } { _ _ _ } } ] [ 3 <empty-board> ] unit-test
