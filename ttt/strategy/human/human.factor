USING: kernel ttt.strategy locals ttt.ui ;
IN: ttt.strategy.human

TUPLE: human-strategy < strategy ;

M:: human-strategy get-next-move ( marker board ui strategy -- x y )
    board ui prompt-move ;
