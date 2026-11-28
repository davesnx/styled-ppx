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
  [@css ".css-ivpciz3{image-rendering:auto;}"];
  [@css ".css-ivpckgw{image-rendering:crisp-edges;}"];
  [@css ".css-ivpccum{image-rendering:pixelated;}"];
  [@css
    ".css-ivpczb9{background-image:image-set(\"cat.png\" 1x, \"cat-2x.png\" 2x);}"
  ];
  [@css
    ".css-ivpctvg{background-image:image-set(\"cat.png\" 1dppx, \"cat-2x.png\" 2dppx);}"
  ];
  [@css
    ".css-ivpcvnh{background-image:image-set(\"cat.png\" 96dpi, \"cat-2x.png\" 192dpi);}"
  ];
  [@css ".css-ivpcytl{background-image:image-set(\"cat.png\" 37dpcm);}"];
  [@css.classes
    [
      ("css-ivpciz3", 0, "", "input.re", 5, 8, 5, 29),
      ("css-ivpckgw", 1, "", "input.re", 6, 8, 6, 36),
      ("css-ivpccum", 2, "", "input.re", 7, 8, 7, 34),
      ("css-ivpczb9", 3, "", "input.re", 10, 8, 10, 66),
      ("css-ivpctvg", 4, "", "input.re", 11, 8, 11, 72),
      ("css-ivpcvnh", 5, "", "input.re", 12, 8, 12, 73),
      ("css-ivpcytl", 6, "", "input.re", 13, 8, 13, 53),
    ]
  ];
  
  CSS.make("css-ivpciz3", []);
  CSS.make("css-ivpckgw", []);
  CSS.make("css-ivpccum", []);
  
  CSS.make("css-ivpczb9", []);
  CSS.make("css-ivpctvg", []);
  CSS.make("css-ivpcvnh", []);
  CSS.make("css-ivpcytl", []);
