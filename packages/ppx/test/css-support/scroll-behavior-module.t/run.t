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
  [@css ".css-ivpc2jz{scroll-behavior:auto;}"];
  [@css ".css-ivpc4sk{scroll-behavior:smooth;}"];
  [@css.classes
    [
      ("css-ivpc2jz", 0, "", "input.re", 2, 8, 2, 29),
      ("css-ivpc4sk", 1, "", "input.re", 3, 8, 3, 31),
    ]
  ];
  
  CSS.make("css-ivpc2jz", []);
  CSS.make("css-ivpc4sk", []);
