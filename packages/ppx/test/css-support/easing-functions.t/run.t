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
  [@css ".css-ivpcpkp{transition-timing-function:steps(2, jump-start);}"];
  [@css ".css-ivpc0eg{transition-timing-function:steps(2, jump-end);}"];
  [@css ".css-ivpc648{transition-timing-function:steps(1, jump-both);}"];
  [@css ".css-ivpcj9w{transition-timing-function:steps(2, jump-none);}"];
  [@css.classes
    [
      ("css-ivpcpkp", 0, "", "input.re", 2, 8, 2, 56),
      ("css-ivpc0eg", 1, "", "input.re", 3, 8, 3, 54),
      ("css-ivpc648", 2, "", "input.re", 4, 8, 4, 55),
      ("css-ivpcj9w", 3, "", "input.re", 5, 8, 5, 55),
    ]
  ];
  
  CSS.make("css-ivpcpkp", []);
  CSS.make("css-ivpc0eg", []);
  CSS.make("css-ivpc648", []);
  CSS.make("css-ivpcj9w", []);
