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

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css ".css-ivpc0ay{width:calc(50% + 4px);}"];
  [@css ".css-ivpcohy{width:calc(20px - 10px);}"];
  [@css ".css-ivpctcz{width:calc(100vh - calc(2rem + 120px));}"];
  [@css ".css-ivpcwot{width:calc(100vh * 2);}"];
  [@css ".css-ivpcxuo{width:calc(2 * 120px);}"];
  [@css.classes
    [
      ("css-ivpc0ay", 0, "", "input.re", 1, 8, 1, 30),
      ("css-ivpcohy", 1, "", "input.re", 2, 8, 2, 32),
      ("css-ivpctcz", 2, "", "input.re", 3, 8, 3, 47),
      ("css-ivpcwot", 3, "", "input.re", 4, 8, 4, 30),
      ("css-ivpcxuo", 4, "", "input.re", 5, 8, 5, 30),
    ]
  ];
  CSS.make("css-ivpc0ay", []);
  CSS.make("css-ivpcohy", []);
  CSS.make("css-ivpctcz", []);
  CSS.make("css-ivpcwot", []);
  CSS.make("css-ivpcxuo", []);

  $ dune build
