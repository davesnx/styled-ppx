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
  [@css ".css-1bvex6o{display:ruby;}"];
  [@css ".css-1tmboxr{display:ruby-base;}"];
  [@css ".css-11bgowr{display:ruby-text;}"];
  [@css ".css-1s1r6c9{display:ruby-base-container;}"];
  [@css ".css-zxqnv4{display:ruby-text-container;}"];
  [@css.classes
    [
      ("css-1bvex6o", 0, "", "input.re", 2, 8, 2, 21),
      ("css-1tmboxr", 1, "", "input.re", 3, 8, 3, 26),
      ("css-11bgowr", 2, "", "input.re", 4, 8, 4, 26),
      ("css-1s1r6c9", 3, "", "input.re", 5, 8, 5, 36),
      ("css-zxqnv4", 4, "", "input.re", 6, 8, 6, 36),
    ]
  ];
  
  CSS.make("css-1bvex6o", []);
  CSS.make("css-1tmboxr", []);
  CSS.make("css-11bgowr", []);
  CSS.make("css-1s1r6c9", []);
  CSS.make("css-zxqnv4", []);
