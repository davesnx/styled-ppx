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
  [@css ".css-s4tp6r{content:\"\\\"\";}"];
  [@css ".css-1slm1gz{content:\"\\\\\";}"];
  [@css ".css-1haxvj9{content:\"'\";}"];
  [@css ".css-12lwyl5{content:\"a\\\"b\";}"];
  [@css ".css-13l24lc{content:\"before\\\\after\";}"];
  [@css ".css-ne9o3r{content:\"line\\A one\";}"];
  [@css ".css-oxjx5m{content:\"—\";}"];
  [@css ".css-15bs0a4 [data-name=\"O\\\"Brien\"]{color:red;}"];
  [@css ".css-v6jzxt{background-image:url(\"path/with\\\"quote.png\");}"];
  [@css ".css-1kqxuzh{background-image:url(\"path\\\\to\\\\file.png\");}"];
  [@css ".css-7qgco9{content:\"\\9 \";}"];
  [@css ".css-jte1fb{content:\"\\7F \";}"];
  [@css.classes
    [
      ("css-s4tp6r", 0, "", "input.re", 12, 9, 12, 24),
      ("css-1slm1gz", 1, "", "input.re", 16, 9, 16, 24),
      ("css-1haxvj9", 2, "", "input.re", 19, 9, 19, 23),
      ("css-12lwyl5", 3, "", "input.re", 22, 9, 22, 26),
      ("css-13l24lc", 4, "", "input.re", 25, 9, 25, 35),
      ("css-ne9o3r", 5, "", "input.re", 30, 9, 30, 32),
      ("css-oxjx5m", 6, "", "input.re", 34, 9, 34, 27),
      ("css-15bs0a4", 7, "", "input.re", 43, 9, 43, 50),
      ("css-v6jzxt", 8, "", "input.re", 47, 9, 47, 56),
      ("css-1kqxuzh", 9, "", "input.re", 50, 9, 50, 54),
      ("css-7qgco9", 10, "", "input.re", 55, 9, 55, 24),
      ("css-jte1fb", 11, "", "input.re", 59, 9, 59, 25),
    ]
  ];
  
  CSS.make("css-s4tp6r", []);
  
  CSS.make("css-1slm1gz", []);
  
  CSS.make("css-1haxvj9", []);
  
  CSS.make("css-12lwyl5", []);
  
  CSS.make("css-13l24lc", []);
  
  CSS.make("css-ne9o3r", []);
  
  CSS.make("css-oxjx5m", []);
  
  CSS.make("css-1haxvj9", []);
  
  CSS.make("css-15bs0a4", []);
  
  CSS.make("css-v6jzxt", []);
  
  CSS.make("css-1kqxuzh", []);
  
  CSS.make("css-7qgco9", []);
  
  CSS.make("css-jte1fb", []);
