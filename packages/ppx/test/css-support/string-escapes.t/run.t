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
  [@css ".a-4wu917{content:\"\\\"\";}"];
  [@css ".a-4w1y2p{content:\"\\\\\";}"];
  [@css ".a-4w6l48{content:\"'\";}"];
  [@css ".a-4wucdh{content:\"a\\\"b\";}"];
  [@css ".a-4wugqq{content:\"before\\\\after\";}"];
  [@css ".a-4wew8m{content:\"line\\A one\";}"];
  [@css ".a-4w5ir8{content:\"—\";}"];
  [@css ".a-g49s14ek38d [data-name=\"O\\\"Brien\"]{color:red;}"];
  [@css ".a-3900808vt{background-image:url(\"path/with\\\"quote.png\");}"];
  [@css ".a-39008wlhr{background-image:url(\"path\\\\to\\\\file.png\");}"];
  [@css ".a-4wqqv9{content:\"\\9 \";}"];
  [@css ".a-4wy7g7{content:\"\\7F \";}"];
  
  CSS.make("a-4wu917", []);
  
  CSS.make("a-4w1y2p", []);
  
  CSS.make("a-4w6l48", []);
  
  CSS.make("a-4wucdh", []);
  
  CSS.make("a-4wugqq", []);
  
  CSS.make("a-4wew8m", []);
  
  CSS.make("a-4w5ir8", []);
  
  CSS.make("a-4w6l48", []);
  
  CSS.make("a-g49s14ek38d", []);
  
  CSS.make("a-3900808vt", []);
  
  CSS.make("a-39008wlhr", []);
  
  CSS.make("a-4wqqv9", []);
  
  CSS.make("a-4wy7g7", []);
