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
  [@css ".css-1qtvj54{-webkit-column-width:10em;column-width:10em;}"];
  [@css ".css-1qb1fge{-webkit-column-width:auto;column-width:auto;}"];
  [@css ".css-1ct4pwz{-webkit-column-count:2;column-count:2;}"];
  [@css ".css-17h3o9a{-webkit-column-count:auto;column-count:auto;}"];
  [@css ".css-ozm9p1{-webkit-columns:100px;columns:100px;}"];
  [@css ".css-3xxnbn{-webkit-columns:3;columns:3;}"];
  [@css ".css-o7j1i{-webkit-columns:10em 2;columns:10em 2;}"];
  [@css ".css-1vav32n{-webkit-columns:auto auto;columns:auto auto;}"];
  [@css ".css-18xt8z8{-webkit-columns:2 10em;columns:2 10em;}"];
  [@css ".css-f5spp{-webkit-columns:auto 10em;columns:auto 10em;}"];
  [@css ".css-11nbzhq{-webkit-columns:2 auto;columns:2 auto;}"];
  [@css ".css-1zqxqc{-webkit-column-rule-color:red;column-rule-color:red;}"];
  [@css ".css-182r780{-webkit-column-rule-style:none;column-rule-style:none;}"];
  [@css ".css-yijpaa{-webkit-column-rule-style:solid;column-rule-style:solid;}"];
  [@css
    ".css-ob1cdq{-webkit-column-rule-style:dotted;column-rule-style:dotted;}"
  ];
  [@css ".css-1fm7wi2{-webkit-column-rule-width:1px;column-rule-width:1px;}"];
  [@css
    ".css-15b7w2f{-webkit-column-rule:transparent;column-rule:transparent;}"
  ];
  [@css
    ".css-1awncy4{-webkit-column-rule:1px solid black;column-rule:1px solid black;}"
  ];
  [@css ".css-xm0ouy{-webkit-column-span:none;column-span:none;}"];
  [@css ".css-17wylg8{-webkit-column-span:all;column-span:all;}"];
  [@css ".css-1kg2khi{-webkit-column-fill:auto;column-fill:auto;}"];
  [@css ".css-45ase4{-webkit-column-fill:balance;column-fill:balance;}"];
  [@css
    ".css-11icg8o{-webkit-column-fill:balance-all;column-fill:balance-all;}"
  ];
  [@css.classes
    [
      ("css-1qtvj54", 0, "", "input.re", 2, 8, 2, 26),
      ("css-1qb1fge", 1, "", "input.re", 3, 8, 3, 26),
      ("css-1ct4pwz", 2, "", "input.re", 4, 8, 4, 23),
      ("css-17h3o9a", 3, "", "input.re", 5, 8, 5, 26),
      ("css-ozm9p1", 4, "", "input.re", 6, 8, 6, 22),
      ("css-3xxnbn", 5, "", "input.re", 7, 8, 7, 18),
      ("css-o7j1i", 6, "", "input.re", 8, 8, 8, 23),
      ("css-1vav32n", 7, "", "input.re", 11, 8, 11, 26),
      ("css-18xt8z8", 8, "", "input.re", 12, 8, 12, 23),
      ("css-f5spp", 9, "", "input.re", 13, 8, 13, 26),
      ("css-11nbzhq", 10, "", "input.re", 14, 8, 14, 23),
      ("css-1zqxqc", 11, "", "input.re", 15, 8, 15, 30),
      ("css-182r780", 12, "", "input.re", 16, 8, 16, 31),
      ("css-yijpaa", 13, "", "input.re", 17, 8, 17, 32),
      ("css-ob1cdq", 14, "", "input.re", 18, 8, 18, 33),
      ("css-1fm7wi2", 15, "", "input.re", 19, 8, 19, 30),
      ("css-15b7w2f", 16, "", "input.re", 20, 8, 20, 32),
      ("css-1awncy4", 17, "", "input.re", 21, 8, 21, 36),
      ("css-xm0ouy", 18, "", "input.re", 22, 8, 22, 25),
      ("css-17wylg8", 19, "", "input.re", 23, 8, 23, 24),
      ("css-1kg2khi", 20, "", "input.re", 24, 8, 24, 25),
      ("css-45ase4", 21, "", "input.re", 25, 8, 25, 28),
      ("css-11icg8o", 22, "", "input.re", 26, 8, 26, 32),
    ]
  ];
  
  CSS.make("css-1qtvj54", []);
  CSS.make("css-1qb1fge", []);
  CSS.make("css-1ct4pwz", []);
  CSS.make("css-17h3o9a", []);
  CSS.make("css-ozm9p1", []);
  CSS.make("css-3xxnbn", []);
  CSS.make("css-o7j1i", []);
  
  CSS.make("css-1vav32n", []);
  CSS.make("css-18xt8z8", []);
  CSS.make("css-f5spp", []);
  CSS.make("css-11nbzhq", []);
  CSS.make("css-1zqxqc", []);
  CSS.make("css-182r780", []);
  CSS.make("css-yijpaa", []);
  CSS.make("css-ob1cdq", []);
  CSS.make("css-1fm7wi2", []);
  CSS.make("css-15b7w2f", []);
  CSS.make("css-1awncy4", []);
  CSS.make("css-xm0ouy", []);
  CSS.make("css-17wylg8", []);
  CSS.make("css-1kg2khi", []);
  CSS.make("css-45ase4", []);
  CSS.make("css-11icg8o", []);
