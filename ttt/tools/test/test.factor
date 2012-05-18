IN: ttt.tools.test


: unit-test-with-string-writer ( quot1 quot2 -- ) [ with-string-writer ] curry unit-test ;
: unit-test-with-string-reader ( quot1 quot2 string -- ) [ swap with-string-reader ] 2curry unit-test ;
