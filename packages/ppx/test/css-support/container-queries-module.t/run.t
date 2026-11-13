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
  [@css ".css-sque9t{container-type:normal;}"];
  [@css ".css-17sx0r1{container-type:size;}"];
  [@css ".css-14hqny7{container-type:inline-size;}"];
  [@css ".css-12bke7l{container-name:none;}"];
  [@css ".css-598d8j{container-name:sidebar;}"];
  [@css ".css-167m3wn{container-name:sidebar main;}"];
  [@css ".css-1s1cqth{container:sidebar / inline-size;}"];
  [@css ".css-71ylvu{container:sidebar / size;}"];
  [@css ".css-hqkkoc{container:none;}"];
  [@css.classes
    [
      ("css-sque9t", 0, "", "input.re", 2, 8, 2, 30),
      ("css-17sx0r1", 1, "", "input.re", 3, 8, 3, 28),
      ("css-14hqny7", 2, "", "input.re", 4, 8, 4, 35),
      ("css-12bke7l", 3, "", "input.re", 5, 8, 5, 28),
      ("css-598d8j", 4, "", "input.re", 6, 8, 6, 31),
      ("css-167m3wn", 5, "", "input.re", 7, 8, 7, 36),
      ("css-1s1cqth", 6, "", "input.re", 8, 8, 8, 40),
      ("css-71ylvu", 7, "", "input.re", 9, 8, 9, 33),
      ("css-hqkkoc", 8, "", "input.re", 10, 8, 10, 23),
    ]
  ];
  
  CSS.make("css-sque9t", []);
  CSS.make("css-17sx0r1", []);
  CSS.make("css-14hqny7", []);
  CSS.make("css-12bke7l", []);
  CSS.make("css-598d8j", []);
  CSS.make("css-167m3wn", []);
  CSS.make("css-1s1cqth", []);
  CSS.make("css-71ylvu", []);
  CSS.make("css-hqkkoc", []);
