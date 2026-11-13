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
  [@css ".css-lfe0ay{width:calc(50% + 4px);}"];
  [@css ".css-gx4ohy{width:calc(20px - 10px);}"];
  [@css ".css-lsttcz{width:calc(100vh - calc(2rem + 120px));}"];
  [@css ".css-10bvwot{width:calc(100vh * 2);}"];
  [@css ".css-1m2qxuo{width:calc(2 * 120px);}"];
  [@css.classes
    [
      ("css-lfe0ay", 0, "", "input.re", 1, 8, 1, 30),
      ("css-gx4ohy", 1, "", "input.re", 2, 8, 2, 32),
      ("css-lsttcz", 2, "", "input.re", 3, 8, 3, 47),
      ("css-10bvwot", 3, "", "input.re", 4, 8, 4, 30),
      ("css-1m2qxuo", 4, "", "input.re", 5, 8, 5, 30),
    ]
  ];
  CSS.make("css-lfe0ay", []);
  CSS.make("css-gx4ohy", []);
  CSS.make("css-lsttcz", []);
  CSS.make("css-10bvwot", []);
  CSS.make("css-1m2qxuo", []);

  $ dune build
