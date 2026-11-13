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
  [@css ".css-e6u59f{color:unset;}"];
  [@css ".css-1vlqsxn{font-weight:unset;}"];
  [@css ".css-z14mle{background-image:unset;}"];
  [@css ".css-1yprzdi{width:unset;}"];
  [@css.classes
    [
      ("css-e6u59f", 0, "", "input.re", 2, 8, 2, 21),
      ("css-1vlqsxn", 1, "", "input.re", 3, 8, 3, 27),
      ("css-z14mle", 2, "", "input.re", 4, 8, 4, 32),
      ("css-1yprzdi", 3, "", "input.re", 5, 8, 5, 21),
    ]
  ];
  
  CSS.make("css-e6u59f", []);
  CSS.make("css-1vlqsxn", []);
  CSS.make("css-z14mle", []);
  CSS.make("css-1yprzdi", []);
