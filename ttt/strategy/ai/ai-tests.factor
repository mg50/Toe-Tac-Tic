USING: kernel ttt.strategy.ai ttt.core tools.test locals sets sequences ;
IN: ttt.strategy.ai.tests

:: unit-test-same-members ( quot1 quot2 -- ) [ t ] [ quot1 quot2 [ call members ] bi@ set= ] unit-test ;

[ { { 0 1 } { 1 0 } { 1 1 } { 0 0 } } ] [ { { } { } } coords ] unit-test-same-members
[ 9 ] [ { { } { } { } } coords length ] unit-test

[ 1 ] [ { { X X } { O _ } } leaf-score ] unit-test
[ -1 ] [ { { O O } { X _ } } leaf-score ] unit-test
[ 0 ] [ { { X _ } { _ O } } leaf-score ] unit-test
[ 1 ] [ { { X O _ } { _ X _ } { O O X } } leaf-score ] unit-test
