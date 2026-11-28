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
  [@css ".css-ivpc5km{pointer-events:auto;}"];
  [@css ".css-ivpc3um{pointer-events:visiblePainted;}"];
  [@css ".css-ivpcq8k{pointer-events:visibleFill;}"];
  [@css ".css-ivpc1be{pointer-events:visibleStroke;}"];
  [@css ".css-ivpc8j1{pointer-events:visible;}"];
  [@css ".css-ivpcsk6{pointer-events:painted;}"];
  [@css ".css-ivpcd81{pointer-events:fill;}"];
  [@css ".css-ivpcb42{pointer-events:stroke;}"];
  [@css ".css-ivpc5is{pointer-events:all;}"];
  [@css ".css-ivpcdzt{pointer-events:none;}"];
  [@css.classes
    [
      ("css-ivpc5km", 0, "", "input.re", 67, 8, 67, 28),
      ("css-ivpc3um", 1, "", "input.re", 69, 8, 69, 38),
      ("css-ivpcq8k", 2, "", "input.re", 70, 8, 70, 35),
      ("css-ivpc1be", 3, "", "input.re", 71, 8, 71, 37),
      ("css-ivpc8j1", 4, "", "input.re", 72, 8, 72, 31),
      ("css-ivpcsk6", 5, "", "input.re", 73, 8, 73, 31),
      ("css-ivpcd81", 6, "", "input.re", 74, 8, 74, 28),
      ("css-ivpcb42", 7, "", "input.re", 75, 8, 75, 30),
      ("css-ivpc5is", 8, "", "input.re", 76, 8, 76, 27),
      ("css-ivpcdzt", 9, "", "input.re", 77, 8, 77, 28),
    ]
  ];
  
  CSS.make("css-ivpc5km", []);
  
  CSS.make("css-ivpc3um", []);
  CSS.make("css-ivpcq8k", []);
  CSS.make("css-ivpc1be", []);
  CSS.make("css-ivpc8j1", []);
  CSS.make("css-ivpcsk6", []);
  CSS.make("css-ivpcd81", []);
  CSS.make("css-ivpcb42", []);
  CSS.make("css-ivpc5is", []);
  CSS.make("css-ivpcdzt", []);
