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
  [@css ".css-bx4kbr{vertical-align:baseline;}"];
  [@css ".css-1vwhbg6{vertical-align:sub;}"];
  [@css ".css-47ipms{vertical-align:super;}"];
  [@css ".css-1bcumew{vertical-align:top;}"];
  [@css ".css-133ao3i{vertical-align:text-top;}"];
  [@css ".css-znigft{vertical-align:middle;}"];
  [@css ".css-z4uyl9{vertical-align:bottom;}"];
  [@css ".css-1kjyqq0{vertical-align:text-bottom;}"];
  [@css.classes
    [
      ("css-bx4kbr", 0, "", "input.re", 1, 8, 1, 32),
      ("css-1vwhbg6", 1, "", "input.re", 2, 8, 2, 27),
      ("css-47ipms", 2, "", "input.re", 3, 8, 3, 29),
      ("css-1bcumew", 3, "", "input.re", 4, 8, 4, 27),
      ("css-133ao3i", 4, "", "input.re", 5, 8, 5, 32),
      ("css-znigft", 5, "", "input.re", 6, 8, 6, 30),
      ("css-z4uyl9", 6, "", "input.re", 7, 8, 7, 30),
      ("css-1kjyqq0", 7, "", "input.re", 8, 8, 8, 35),
    ]
  ];
  CSS.make("css-bx4kbr", []);
  CSS.make("css-1vwhbg6", []);
  CSS.make("css-47ipms", []);
  CSS.make("css-1bcumew", []);
  CSS.make("css-133ao3i", []);
  CSS.make("css-znigft", []);
  CSS.make("css-z4uyl9", []);
  CSS.make("css-1kjyqq0", []);
