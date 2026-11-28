This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

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
  [@css ".css-ivpcj54{-webkit-column-width:10em;column-width:10em;}"];
  [@css ".css-ivpcfge{-webkit-column-width:auto;column-width:auto;}"];
  [@css ".css-ivpcpwz{-webkit-column-count:2;column-count:2;}"];
  [@css ".css-ivpco9a{-webkit-column-count:auto;column-count:auto;}"];
  [@css ".css-ivpc9p1{-webkit-columns:100px;columns:100px;}"];
  [@css ".css-ivpcnbn{-webkit-columns:3;columns:3;}"];
  [@css ".css-ivpcj1i{-webkit-columns:10em 2;columns:10em 2;}"];
  [@css ".css-ivpc32n{-webkit-columns:auto auto;columns:auto auto;}"];
  [@css ".css-ivpc8z8{-webkit-columns:2 10em;columns:2 10em;}"];
  [@css ".css-ivpcspp{-webkit-columns:auto 10em;columns:auto 10em;}"];
  [@css ".css-ivpczhq{-webkit-columns:2 auto;columns:2 auto;}"];
  [@css ".css-ivpcxqc{-webkit-column-rule-color:red;column-rule-color:red;}"];
  [@css ".css-ivpc780{-webkit-column-rule-style:none;column-rule-style:none;}"];
  [@css
    ".css-ivpcpaa{-webkit-column-rule-style:solid;column-rule-style:solid;}"
  ];
  [@css
    ".css-ivpccdq{-webkit-column-rule-style:dotted;column-rule-style:dotted;}"
  ];
  [@css ".css-ivpcwi2{-webkit-column-rule-width:1px;column-rule-width:1px;}"];
  [@css
    ".css-ivpcw2f{-webkit-column-rule:transparent;column-rule:transparent;}"
  ];
  [@css
    ".css-ivpccy4{-webkit-column-rule:1px solid black;column-rule:1px solid black;}"
  ];
  [@css ".css-ivpcouy{-webkit-column-span:none;column-span:none;}"];
  [@css ".css-ivpclg8{-webkit-column-span:all;column-span:all;}"];
  [@css ".css-ivpckhi{-webkit-column-fill:auto;column-fill:auto;}"];
  [@css ".css-ivpcse4{-webkit-column-fill:balance;column-fill:balance;}"];
  [@css
    ".css-ivpcg8o{-webkit-column-fill:balance-all;column-fill:balance-all;}"
  ];
  [@css.classes
    [
      ("css-ivpcj54", 0, "", "input.re", 2, 8, 2, 26),
      ("css-ivpcfge", 1, "", "input.re", 3, 8, 3, 26),
      ("css-ivpcpwz", 2, "", "input.re", 4, 8, 4, 23),
      ("css-ivpco9a", 3, "", "input.re", 5, 8, 5, 26),
      ("css-ivpc9p1", 4, "", "input.re", 6, 8, 6, 22),
      ("css-ivpcnbn", 5, "", "input.re", 7, 8, 7, 18),
      ("css-ivpcj1i", 6, "", "input.re", 8, 8, 8, 23),
      ("css-ivpc32n", 7, "", "input.re", 11, 8, 11, 26),
      ("css-ivpc8z8", 8, "", "input.re", 12, 8, 12, 23),
      ("css-ivpcspp", 9, "", "input.re", 13, 8, 13, 26),
      ("css-ivpczhq", 10, "", "input.re", 14, 8, 14, 23),
      ("css-ivpcxqc", 11, "", "input.re", 15, 8, 15, 30),
      ("css-ivpc780", 12, "", "input.re", 16, 8, 16, 31),
      ("css-ivpcpaa", 13, "", "input.re", 17, 8, 17, 32),
      ("css-ivpccdq", 14, "", "input.re", 18, 8, 18, 33),
      ("css-ivpcwi2", 15, "", "input.re", 19, 8, 19, 30),
      ("css-ivpcw2f", 16, "", "input.re", 20, 8, 20, 32),
      ("css-ivpccy4", 17, "", "input.re", 21, 8, 21, 36),
      ("css-ivpcouy", 18, "", "input.re", 22, 8, 22, 25),
      ("css-ivpclg8", 19, "", "input.re", 23, 8, 23, 24),
      ("css-ivpckhi", 20, "", "input.re", 24, 8, 24, 25),
      ("css-ivpcse4", 21, "", "input.re", 25, 8, 25, 28),
      ("css-ivpcg8o", 22, "", "input.re", 26, 8, 26, 32),
    ]
  ];
  
  CSS.make("css-ivpcj54", []);
  CSS.make("css-ivpcfge", []);
  CSS.make("css-ivpcpwz", []);
  CSS.make("css-ivpco9a", []);
  CSS.make("css-ivpc9p1", []);
  CSS.make("css-ivpcnbn", []);
  CSS.make("css-ivpcj1i", []);
  
  CSS.make("css-ivpc32n", []);
  CSS.make("css-ivpc8z8", []);
  CSS.make("css-ivpcspp", []);
  CSS.make("css-ivpczhq", []);
  CSS.make("css-ivpcxqc", []);
  CSS.make("css-ivpc780", []);
  CSS.make("css-ivpcpaa", []);
  CSS.make("css-ivpccdq", []);
  CSS.make("css-ivpcwi2", []);
  CSS.make("css-ivpcw2f", []);
  CSS.make("css-ivpccy4", []);
  CSS.make("css-ivpcouy", []);
  CSS.make("css-ivpclg8", []);
  CSS.make("css-ivpckhi", []);
  CSS.make("css-ivpcse4", []);
  CSS.make("css-ivpcg8o", []);
