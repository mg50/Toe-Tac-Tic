USING: kernel ttt.strategy vector sequences ttt.core ;
IN: ttt.strategy.mock

TUPLE: mock-strategy moves ;

: <mock-strategy> ( moves -- strat ) reverse >vector mock-strategy new swap >>moves

M: mock-strategy get-next-move ( board ui strategy -- x y ) 2nip moves>> pop 2array@ ;
