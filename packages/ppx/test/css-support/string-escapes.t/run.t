String escape round-trip tests. Verifies that characters requiring
backslash escaping inside CSS <string-token>s are correctly re-encoded
when the AST is rendered back to a CSS string. See
documents/string-escape-bug.md for context.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css ".css-64u917{content:\"\\\"\";}"];
  [@css ".css-14y1y2p{content:\"\\\\\";}"];
  [@css ".css-1f06l48{content:\"'\";}"];
  [@css ".css-eyucdh{content:\"a\\\"b\";}"];
  [@css ".css-1svugqq{content:\"before\\\\after\";}"];
  [@css ".css-6dew8m{content:\"line\\A one\";}"];
  [@css ".css-1xb5ir8{content:\"—\";}"];
  [@css ".css-1blk38d [data-name=\"O\\\"Brien\"]{color:red;}"];
  [@css ".css-dv08vt{background-image:url(\"path/with\\\"quote.png\");}"];
  [@css ".css-ynwlhr{background-image:url(\"path\\\\to\\\\file.png\");}"];
  [@css ".css-aaqqv9{content:\"\\9 \";}"];
  [@css ".css-1n1y7g7{content:\"\\7F \";}"];
  
  CSS.make("css-64u917", []);
  
  CSS.make("css-14y1y2p", []);
  
  CSS.make("css-1f06l48", []);
  
  CSS.make("css-eyucdh", []);
  
  CSS.make("css-1svugqq", []);
  
  CSS.make("css-6dew8m", []);
  
  CSS.make("css-1xb5ir8", []);
  
  CSS.make("css-1f06l48", []);
  
  CSS.make("css-1blk38d", []);
  
  CSS.make("css-dv08vt", []);
  
  CSS.make("css-ynwlhr", []);
  
  CSS.make("css-aaqqv9", []);
  
  CSS.make("css-1n1y7g7", []);
