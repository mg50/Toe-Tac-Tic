USING: ttt.ui.console ttt.game kernel namespaces tools.test io.streams.string ;
IN: ttt

: start ( -- ) "test" get-global [ [ "ttt" test ] with-string-writer drop :test-failures ] [ <console-ui> run-game drop ] if ;

MAIN: start
