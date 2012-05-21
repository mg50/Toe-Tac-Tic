USING: accessors ;
IN: ttt.strategy

TUPLE: strategy ;

GENERIC: get-next-move ( marker board ui strategy -- x y )
