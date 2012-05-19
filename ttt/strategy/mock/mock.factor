USING: kernel ttt.strategy vectors sequences ttt.core accessors ;
IN: ttt.strategy.mock

TUPLE: mock-strategy moves ;

: <mock-strategy> ( moves -- strat ) reverse >vector mock-strategy new swap >>moves ;

M: mock-strategy get-next-move ( marker board ui strategy -- x y ) nip 2nip moves>> pop 2array@ ;
