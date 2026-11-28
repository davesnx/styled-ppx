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
  [@css ".css-ivpc560{scrollbar-color:auto;}"];
  [@css ".css-ivpc7p6{scrollbar-color:red blue;}"];
  [@css ".css-ivpcd7s{scrollbar-width:auto;}"];
  [@css ".css-ivpcq5c{scrollbar-width:thin;}"];
  [@css ".css-ivpcyio{scrollbar-width:none;}"];
  [@css.classes
    [
      ("css-ivpc560", 0, "", "input.re", 2, 8, 2, 29),
      ("css-ivpc7p6", 1, "", "input.re", 3, 8, 3, 33),
      ("css-ivpcd7s", 2, "", "input.re", 4, 8, 4, 29),
      ("css-ivpcq5c", 3, "", "input.re", 5, 8, 5, 29),
      ("css-ivpcyio", 4, "", "input.re", 6, 8, 6, 29),
    ]
  ];
  
  CSS.make("css-ivpc560", []);
  CSS.make("css-ivpc7p6", []);
  CSS.make("css-ivpcd7s", []);
  CSS.make("css-ivpcq5c", []);
  CSS.make("css-ivpcyio", []);
