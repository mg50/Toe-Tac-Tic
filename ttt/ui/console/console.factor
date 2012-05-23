USING: kernel ttt.ui io math.parser regexp sequences ttt.core namespaces arrays locals sequences strings math combinators ;
IN: ttt.ui.console

TUPLE: console-ui < ui ;

CONSTANT: valid-move-regex R/ ^\d+ \d+\s*$/
CONSTANT: move-request-message "Please enter your next move: "

: <console-ui> ( -- c ) console-ui new ;

M: console-ui print-message ( message ui -- ) drop write flush ;

! Takes a string "x y" and pushes x and y onto the stack, where x and y are numbers.
: parse-move-string ( string -- x y ) R/ \d+/ all-matching-subseqs [ string>number ] map 2array@ ;

:: valid-move-string? ( string board -- ? ) string valid-move-regex matches?
    [ string parse-move-string board available? ] [ f ] if ;

: display-marker ( marker -- string ) {
    { [ dup X = ] [ drop " X " ] }
    { [ dup O = ] [ drop " O " ] }
    { [ dup _ = ] [ drop "   " ] }
} cond ;

: display-column ( coll -- string ) [ display-marker ] map "|" join ;
: make-separator ( seq -- string ) length dup 3 * + 1 - "-" <array> "" join "\n" prepend "\n" append ;
: display-board ( board -- string ) [ display-column ] map dup make-separator join ;
M: console-ui update-display ( board ui -- ) drop display-board "\n" append print ;

:: (prompt-move-until-valid) ( board ui -- x y ) f
    [ dup board valid-move-string? ]
    [ move-request-message ui print-message
      drop readln ]
    do until parse-move-string ;

M: console-ui prompt-move ( board ui -- x y ) (prompt-move-until-valid) ;

: whitespace? ( string -- ? ) R/ \s+/ matches? ;

M:: console-ui prompt-options ( msg options ui -- idx ) [let
    msg " (options: " append options "/" join append "): " append :> prompt-message
    f [ dup >boolean ] [ drop prompt-message ui print-message readln [ 1string whitespace? ] trim options index ] do until
] ;

CONSTANT: instructions "Enter the coordinates of the move you'd like to play. For instance, enter \"0 0 \" to play the top-left cell.\n\n"
M: console-ui before-game-start ( ui -- ) instructions swap print-message ;
