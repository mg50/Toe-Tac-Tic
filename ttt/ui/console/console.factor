USING: kernel ttt.ui io math.parser regexp sequences ;
IN: ttt.ui.console

TUPLE: console-ui < ui ;

: <console-ui> ( -- c ) console-ui new ;

M: console-ui print-message ( message ui -- ) drop print ;

: valid-move-string? ( string -- ? ) R/ ^\d+ \d+$/ matches? ;

! Takes a string "x y" and pushes x and y onto the stack, where x and y are numbers.
: parse-move-string ( string -- x y ) R/ \d+/ all-matching-subseqs [ string>number ] map [ first ] [ second ] bi ;
