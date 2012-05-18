USING: kernel tools.test io.streams.string sequences fry ;
IN: ttt.tools.test

SYMBOL: OUT

: string>input ( quot1 quot2 -- quot1 quot2 ) [ with-string-writer ] curry ;
: output>stack ( quot1 quot2 string -- quot1 quot2 ) [ swap with-string-reader ] 2curry ;
: output>vector ( quot1 quot2 -- quot1 quot2 ) <string-writer> OUT set '[ OUT get _ with-output-stream ] ;
: last-test-output ( -- quot ) OUT get >string [ ] curry ;
: assert-last-unit-test-output ( string -- ) [ ] curry last-test-output swap unit-test ;
