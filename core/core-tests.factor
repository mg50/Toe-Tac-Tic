USING: tools.test ttt.core kernel ;
IN: ttt.core.tests

[ -1 <empty-board> ] must-fail
[ { } ] [ 0 <empty-board> ] unit-test
[ { { _ } } ] [ 1 <empty-board> ] unit-test
[ { { _ _ } { _ _ } } ] [ 2 <empty-board> ] unit-test
[ { { _ _ _ } { _ _ _ } { _ _ _ } } ] [ 3 <empty-board> ] unit-test


[ _ ] [ 1 1 2 <empty-board> marker-at ] unit-test
[ O ] [ 1 0 { { X O } } marker-at ] unit-test
[ X ] [ 1 0 { { O X } } marker-at ] unit-test
[ 3 3 { { X } { X } } marker-at ] must-fail
[ _ ] [ 1 1 { { X X X } { X _ X } { O O O } } marker-at ] unit-test

[ t ] [ 0 0 { { X O } } occupied? ] unit-test
[ f ] [ 0 0 { { _ X } } occupied? ] unit-test
[ t ] [ 1 0 { { _ X } } occupied? ] unit-test
[ 3 3 { { _ X } } occupied? ] must-fail
