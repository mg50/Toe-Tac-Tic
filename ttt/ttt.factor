USING: ttt.ui.console ttt.game kernel namespaces tools.test io.streams.string strings sequences io ;
IN: ttt

: start ( -- ) "test" get-global
    [
        [ "ttt" test ] with-string-writer drop
        [ :test-failures ] with-string-writer >string dup empty?
        [ "\nAll tests passed!\n" print drop ] [ print ] if
    ]
    [ <console-ui> run-game drop ] if ;

MAIN: start
