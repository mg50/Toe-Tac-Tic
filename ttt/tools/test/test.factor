USING: kernel tools.test io.streams.string sequences fry ;
IN: ttt.tools.test

SYMBOL: OUT

: string-writer>input ( quot1 quot2 -- quot1 quot2 ) [ with-string-writer ] curry ;
: output>stack ( quot1 quot2 string -- quot1 quot2 ) [ swap with-string-reader ] 2curry ;
: output>vector ( quot1 quot2 -- quot1 quot2 ) <string-writer> OUT set '[ OUT get _ with-output-stream ] ;
: last-test-output ( -- string ) OUT get >string [ ] curry ;
