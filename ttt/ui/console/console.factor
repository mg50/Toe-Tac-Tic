USING: kernel ttt.ui io math.parser regexp sequences ttt.core namespaces arrays locals sequences strings math combinators ;
IN: ttt.ui.console

TUPLE: console-ui < ui ;

CONSTANT: valid-move-regex R/ ^\d+ \d+\s*$/
CONSTANT: move-request-message "Please enter your next move:"

: <console-ui> ( -- c ) console-ui new ;

M: console-ui print-message ( message ui -- ) drop print flush ;

: valid-move-string? ( string -- ? ) valid-move-regex matches? ;

! Takes a string "x y" and pushes x and y onto the stack, where x and y are numbers.
: parse-move-string ( string -- x y ) R/ \d+/ all-matching-subseqs [ string>number ] map 2array@ ;

: display-marker ( marker -- string ) {
    { [ dup X = ] [ drop "X" ] }
    { [ dup O = ] [ drop "O" ] }
    { [ dup _ = ] [ drop " " ] }
} cond ;

: display-column ( coll -- string ) [ display-marker ] map "|" join ;
: make-separator ( seq -- string ) length 2 * 1 - "-" <array> "" join "\n" prepend "\n" append ;
: display-board ( board -- string ) [ display-column ] map dup make-separator join ;
M: console-ui update-display ( board ui -- ) drop display-board "\n" append print ;

: (prompt-move-until-valid) ( -- x y ) f
    [ dup valid-move-string? ] [ drop readln ]
    do until parse-move-string ;

:: (prompt-move-until-available) ( board -- x y ) f f
    [ 2dup board available? ]
    [ 2drop (prompt-move-until-valid) ] do until ;

M: console-ui prompt-move ( board ui -- x y )
    move-request-message swap print-message (prompt-move-until-available) ;

: whitespace? ( string -- ? ) R/ \s+/ matches? ;

M:: console-ui prompt-options ( msg options ui -- idx )
    msg ui print-message
    f [ dup >boolean ] [ drop readln [ 1string whitespace? ] trim options index ] do until ;
