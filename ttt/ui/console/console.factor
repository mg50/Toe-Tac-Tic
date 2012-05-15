USING: kernel ttt.ui io ;
IN: ttt.ui.console

TUPLE: console-ui < ui ;

: <console-ui> ( -- c ) console-ui new ;

M: console-ui print-message ( message ui -- ) drop print ;
