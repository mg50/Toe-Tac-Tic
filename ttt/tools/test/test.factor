USING: kernel tools.test io.streams.string sequences fry namespaces io strings ;
IN: ttt.tools.test

SYMBOL: OUT

: output>stack ( quot1 quot2 -- quot1 quot2 ) [ with-string-writer ] curry ;
: string>input ( quot1 quot2 string -- quot1 quot2 ) [ swap with-string-reader ] 2curry ;
: output>store ( quot1 quot2 -- quot1 quot2 ) <string-writer> OUT set '[ OUT get _ with-output-stream ] ;
: last-test-output ( -- quot ) OUT get >string [ ] curry ;
: assert-last-unit-test-output ( string -- ) [ ] curry last-test-output swap unit-test ;
