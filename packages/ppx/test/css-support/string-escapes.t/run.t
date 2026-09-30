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
  [@css "._a_4wu917{content:\"\\\"\";}"];
  [@css "._a_4w1y2p{content:\"\\\\\";}"];
  [@css "._a_4w6l48{content:\"'\";}"];
  [@css "._a_4wucdh{content:\"a\\\"b\";}"];
  [@css "._a_4wugqq{content:\"before\\\\after\";}"];
  [@css "._a_4wew8m{content:\"line\\A one\";}"];
  [@css "._a_4w5ir8{content:\"—\";}"];
  [@css "._a_g49s14ek38d [data-name=\"O\\\"Brien\"]{color:red;}"];
  [@css "._a_3900808vt{background-image:url(\"path/with\\\"quote.png\");}"];
  [@css "._a_39008wlhr{background-image:url(\"path\\\\to\\\\file.png\");}"];
  [@css "._a_4wqqv9{content:\"\\9 \";}"];
  [@css "._a_4wy7g7{content:\"\\7F \";}"];
  
  CSS.make("_a_4wu917", []);
  
  CSS.make("_a_4w1y2p", []);
  
  CSS.make("_a_4w6l48", []);
  
  CSS.make("_a_4wucdh", []);
  
  CSS.make("_a_4wugqq", []);
  
  CSS.make("_a_4wew8m", []);
  
  CSS.make("_a_4w5ir8", []);
  
  CSS.make("_a_4w6l48", []);
  
  CSS.make("_a_g49s14ek38d", []);
  
  CSS.make("_a_3900808vt", []);
  
  CSS.make("_a_39008wlhr", []);
  
  CSS.make("_a_4wqqv9", []);
  
  CSS.make("_a_4wy7g7", []);
