USING: kernel ttt.ui io math.parser regexp sequences ttt.core namespaces arrays locals ;
IN: ttt.ui.console

TUPLE: console-ui < ui ;

CONSTANT: valid-move-regex R/ ^\d+ \d+\s*$/

: <console-ui> ( -- c ) console-ui new ;

M: console-ui print-message ( message ui -- ) drop print ;

: valid-move-string? ( string -- ? ) valid-move-regex matches? ;

! Takes a string "x y" and pushes x and y onto the stack, where x and y are numbers.
: parse-move-string ( string -- x y ) R/ \d+/ all-matching-subseqs [ string>number ] map [ first ] [ second ] bi ;

"X" X set
"O" O set
" " _ set

: display-marker ( marker -- string ) get ;
: display-column ( coll -- string ) [ display-marker ] map "|" join ;
: make-separator ( seq -- string ) length "-" <array> "" join "\n" prepend "\n" append ;
: display-board ( board -- string ) [ display-column ] map dup make-separator join ;
M: console-ui update-display ( board ui -- ) drop display-board "\n" append print ;

: (prompt-move) ( -- x y ) [let f :> move!
    [ move valid-move-string? ] [ readln move! ] do until
    move parse-move-string
] ;
