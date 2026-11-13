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
  [@css ".css-sai5km{pointer-events:auto;}"];
  [@css ".css-n2t3um{pointer-events:visiblePainted;}"];
  [@css ".css-rguq8k{pointer-events:visibleFill;}"];
  [@css ".css-trp1be{pointer-events:visibleStroke;}"];
  [@css ".css-12ky8j1{pointer-events:visible;}"];
  [@css ".css-2vnsk6{pointer-events:painted;}"];
  [@css ".css-1xksd81{pointer-events:fill;}"];
  [@css ".css-guvb42{pointer-events:stroke;}"];
  [@css ".css-1nf55is{pointer-events:all;}"];
  [@css ".css-1lfedzt{pointer-events:none;}"];
  [@css.classes
    [
      ("css-sai5km", 0, "", "input.re", 67, 8, 67, 28),
      ("css-n2t3um", 1, "", "input.re", 69, 8, 69, 38),
      ("css-rguq8k", 2, "", "input.re", 70, 8, 70, 35),
      ("css-trp1be", 3, "", "input.re", 71, 8, 71, 37),
      ("css-12ky8j1", 4, "", "input.re", 72, 8, 72, 31),
      ("css-2vnsk6", 5, "", "input.re", 73, 8, 73, 31),
      ("css-1xksd81", 6, "", "input.re", 74, 8, 74, 28),
      ("css-guvb42", 7, "", "input.re", 75, 8, 75, 30),
      ("css-1nf55is", 8, "", "input.re", 76, 8, 76, 27),
      ("css-1lfedzt", 9, "", "input.re", 77, 8, 77, 28),
    ]
  ];
  
  CSS.make("css-sai5km", []);
  
  CSS.make("css-n2t3um", []);
  CSS.make("css-rguq8k", []);
  CSS.make("css-trp1be", []);
  CSS.make("css-12ky8j1", []);
  CSS.make("css-2vnsk6", []);
  CSS.make("css-1xksd81", []);
  CSS.make("css-guvb42", []);
  CSS.make("css-1nf55is", []);
  CSS.make("css-1lfedzt", []);
