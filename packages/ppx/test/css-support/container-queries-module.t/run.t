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
  [@css ".css-ivpce9t{container-type:normal;}"];
  [@css ".css-ivpc0r1{container-type:size;}"];
  [@css ".css-ivpcny7{container-type:inline-size;}"];
  [@css ".css-ivpce7l{container-name:none;}"];
  [@css ".css-ivpcd8j{container-name:sidebar;}"];
  [@css ".css-ivpc3wn{container-name:sidebar main;}"];
  [@css ".css-ivpcqth{container:sidebar / inline-size;}"];
  [@css ".css-ivpclvu{container:sidebar / size;}"];
  [@css ".css-ivpckoc{container:none;}"];
  [@css.classes
    [
      ("css-ivpce9t", 0, "", "input.re", 2, 8, 2, 30),
      ("css-ivpc0r1", 1, "", "input.re", 3, 8, 3, 28),
      ("css-ivpcny7", 2, "", "input.re", 4, 8, 4, 35),
      ("css-ivpce7l", 3, "", "input.re", 5, 8, 5, 28),
      ("css-ivpcd8j", 4, "", "input.re", 6, 8, 6, 31),
      ("css-ivpc3wn", 5, "", "input.re", 7, 8, 7, 36),
      ("css-ivpcqth", 6, "", "input.re", 8, 8, 8, 40),
      ("css-ivpclvu", 7, "", "input.re", 9, 8, 9, 33),
      ("css-ivpckoc", 8, "", "input.re", 10, 8, 10, 23),
    ]
  ];
  
  CSS.make("css-ivpce9t", []);
  CSS.make("css-ivpc0r1", []);
  CSS.make("css-ivpcny7", []);
  CSS.make("css-ivpce7l", []);
  CSS.make("css-ivpcd8j", []);
  CSS.make("css-ivpc3wn", []);
  CSS.make("css-ivpcqth", []);
  CSS.make("css-ivpclvu", []);
  CSS.make("css-ivpckoc", []);
