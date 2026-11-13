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
  [@css ".css-2juiz3{image-rendering:auto;}"];
  [@css ".css-vm4kgw{image-rendering:crisp-edges;}"];
  [@css ".css-9d9cum{image-rendering:pixelated;}"];
  [@css
    ".css-rtazb9{background-image:image-set(\"cat.png\" 1x, \"cat-2x.png\" 2x);}"
  ];
  [@css
    ".css-1bzbtvg{background-image:image-set(\"cat.png\" 1dppx, \"cat-2x.png\" 2dppx);}"
  ];
  [@css
    ".css-qkavnh{background-image:image-set(\"cat.png\" 96dpi, \"cat-2x.png\" 192dpi);}"
  ];
  [@css ".css-1ozmytl{background-image:image-set(\"cat.png\" 37dpcm);}"];
  [@css.classes
    [
      ("css-2juiz3", 0, "", "input.re", 5, 8, 5, 29),
      ("css-vm4kgw", 1, "", "input.re", 6, 8, 6, 36),
      ("css-9d9cum", 2, "", "input.re", 7, 8, 7, 34),
      ("css-rtazb9", 3, "", "input.re", 10, 8, 10, 66),
      ("css-1bzbtvg", 4, "", "input.re", 11, 8, 11, 72),
      ("css-qkavnh", 5, "", "input.re", 12, 8, 12, 73),
      ("css-1ozmytl", 6, "", "input.re", 13, 8, 13, 53),
    ]
  ];
  
  CSS.make("css-2juiz3", []);
  CSS.make("css-vm4kgw", []);
  CSS.make("css-9d9cum", []);
  
  CSS.make("css-rtazb9", []);
  CSS.make("css-1bzbtvg", []);
  CSS.make("css-qkavnh", []);
  CSS.make("css-1ozmytl", []);
