USING: accessors ;
IN: ttt.strategy

TUPLE: strategy marker ;

GENERIC: get-next-move ( board ui strategy -- )
