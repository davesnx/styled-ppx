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
  [@css ".css-ivpcx6o{display:ruby;}"];
  [@css ".css-ivpcoxr{display:ruby-base;}"];
  [@css ".css-ivpcowr{display:ruby-text;}"];
  [@css ".css-ivpc6c9{display:ruby-base-container;}"];
  [@css ".css-ivpcnv4{display:ruby-text-container;}"];
  [@css.classes
    [
      ("css-ivpcx6o", 0, "", "input.re", 2, 8, 2, 21),
      ("css-ivpcoxr", 1, "", "input.re", 3, 8, 3, 26),
      ("css-ivpcowr", 2, "", "input.re", 4, 8, 4, 26),
      ("css-ivpc6c9", 3, "", "input.re", 5, 8, 5, 36),
      ("css-ivpcnv4", 4, "", "input.re", 6, 8, 6, 36),
    ]
  ];
  
  CSS.make("css-ivpcx6o", []);
  CSS.make("css-ivpcoxr", []);
  CSS.make("css-ivpcowr", []);
  CSS.make("css-ivpc6c9", []);
  CSS.make("css-ivpcnv4", []);
