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
  [@css ".css-oug560{scrollbar-color:auto;}"];
  [@css ".css-1j2x7p6{scrollbar-color:red blue;}"];
  [@css ".css-1js3d7s{scrollbar-width:auto;}"];
  [@css ".css-d39q5c{scrollbar-width:thin;}"];
  [@css ".css-17pjyio{scrollbar-width:none;}"];
  [@css.classes
    [
      ("css-oug560", 0, "", "input.re", 2, 8, 2, 29),
      ("css-1j2x7p6", 1, "", "input.re", 3, 8, 3, 33),
      ("css-1js3d7s", 2, "", "input.re", 4, 8, 4, 29),
      ("css-d39q5c", 3, "", "input.re", 5, 8, 5, 29),
      ("css-17pjyio", 4, "", "input.re", 6, 8, 6, 29),
    ]
  ];
  
  CSS.make("css-oug560", []);
  CSS.make("css-1j2x7p6", []);
  CSS.make("css-1js3d7s", []);
  CSS.make("css-d39q5c", []);
  CSS.make("css-17pjyio", []);
