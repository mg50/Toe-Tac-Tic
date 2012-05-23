USING: ttt.ui.console ttt.game kernel namespaces tools.test ;
IN: ttt

: start ( -- ) "test" get-global [ "ttt" test ] [ <console-ui> run-game drop ] if ;

MAIN: start
