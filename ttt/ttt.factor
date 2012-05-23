USING: ttt.ui.console ttt.game kernel namespaces tools.test ;
IN: ttt

: start ( -- ) "test" get-global [ "ttt" test :test-failures ] [ <console-ui> run-game drop ] if ;

MAIN: start
