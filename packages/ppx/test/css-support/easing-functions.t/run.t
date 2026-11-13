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
  [@css ".css-628pkp{transition-timing-function:steps(2, jump-start);}"];
  [@css ".css-18kj0eg{transition-timing-function:steps(2, jump-end);}"];
  [@css ".css-ael648{transition-timing-function:steps(1, jump-both);}"];
  [@css ".css-1pccj9w{transition-timing-function:steps(2, jump-none);}"];
  [@css.classes
    [
      ("css-628pkp", 0, "", "input.re", 2, 8, 2, 56),
      ("css-18kj0eg", 1, "", "input.re", 3, 8, 3, 54),
      ("css-ael648", 2, "", "input.re", 4, 8, 4, 55),
      ("css-1pccj9w", 3, "", "input.re", 5, 8, 5, 55),
    ]
  ];
  
  CSS.make("css-628pkp", []);
  CSS.make("css-18kj0eg", []);
  CSS.make("css-ael648", []);
  CSS.make("css-1pccj9w", []);
