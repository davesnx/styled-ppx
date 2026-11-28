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
  [@css ".css-ivpcp6r{content:\"\\\"\";}"];
  [@css ".css-ivpc1gz{content:\"\\\\\";}"];
  [@css ".css-ivpcvj9{content:\"'\";}"];
  [@css ".css-ivpcyl5{content:\"a\\\"b\";}"];
  [@css ".css-ivpc4lc{content:\"before\\\\after\";}"];
  [@css ".css-ivpco3r{content:\"line\\A one\";}"];
  [@css ".css-ivpcx5m{content:\"—\";}"];
  [@css ".css-ivpc0a4 [data-name=\"O\\\"Brien\"]{color:red;}"];
  [@css ".css-ivpczxt{background-image:url(\"path/with\\\"quote.png\");}"];
  [@css ".css-ivpcuzh{background-image:url(\"path\\\\to\\\\file.png\");}"];
  [@css ".css-ivpcco9{content:\"\\9 \";}"];
  [@css ".css-ivpc1fb{content:\"\\7F \";}"];
  [@css.classes
    [
      ("css-ivpcp6r", 0, "", "input.re", 12, 9, 12, 24),
      ("css-ivpc1gz", 1, "", "input.re", 16, 9, 16, 24),
      ("css-ivpcvj9", 2, "", "input.re", 19, 9, 19, 23),
      ("css-ivpcyl5", 3, "", "input.re", 22, 9, 22, 26),
      ("css-ivpc4lc", 4, "", "input.re", 25, 9, 25, 35),
      ("css-ivpco3r", 5, "", "input.re", 30, 9, 30, 32),
      ("css-ivpcx5m", 6, "", "input.re", 34, 9, 34, 27),
      ("css-ivpc0a4", 7, "", "input.re", 43, 9, 43, 50),
      ("css-ivpczxt", 8, "", "input.re", 47, 9, 47, 56),
      ("css-ivpcuzh", 9, "", "input.re", 50, 9, 50, 54),
      ("css-ivpcco9", 10, "", "input.re", 55, 9, 55, 24),
      ("css-ivpc1fb", 11, "", "input.re", 59, 9, 59, 25),
    ]
  ];
  
  CSS.make("css-ivpcp6r", []);
  
  CSS.make("css-ivpc1gz", []);
  
  CSS.make("css-ivpcvj9", []);
  
  CSS.make("css-ivpcyl5", []);
  
  CSS.make("css-ivpc4lc", []);
  
  CSS.make("css-ivpco3r", []);
  
  CSS.make("css-ivpcx5m", []);
  
  CSS.make("css-ivpcvj9", []);
  
  CSS.make("css-ivpc0a4", []);
  
  CSS.make("css-ivpczxt", []);
  
  CSS.make("css-ivpcuzh", []);
  
  CSS.make("css-ivpcco9", []);
  
  CSS.make("css-ivpc1fb", []);
