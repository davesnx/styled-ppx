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
  [@css ".css-1waj24l{display:run-in;}"];
  [@css ".css-1vgo78o{display:flow;}"];
  [@css ".css-3bag40{display:flow-root;}"];
  [@css.classes
    [
      ("css-1waj24l", 0, "", "input.re", 2, 8, 2, 23),
      ("css-1vgo78o", 1, "", "input.re", 3, 8, 3, 21),
      ("css-3bag40", 2, "", "input.re", 4, 8, 4, 26),
    ]
  ];
  
  CSS.make("css-1waj24l", []);
  CSS.make("css-1vgo78o", []);
  CSS.make("css-3bag40", []);
