USING: kernel ttt.strategy.ai ttt.core tools.test ;
IN: ttt.strategy.ai.tests


[ 1 ] [ { { X X } { O _ } } leaf-score ] unit-test
[ -1 ] [ { { O O } { X _ } } leaf-score ] unit-test
[ 0 ] [ { { X _ } { _ O } } leaf-score ] unit-test
[ 1 ] [ { { X O _ } { _ X _ } { O O X } } leaf-score ] unit-test
