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
  [@css ".a-11tobub{image-rendering:auto;}"];
  [@css ".a-1e7m01f{image-rendering:crisp-edges;}"];
  [@css ".a-fjhmlf{image-rendering:pixelated;}"];
  [@css
    ".a-25toi3{background-image:image-set(\"cat.png\" 1x, \"cat-2x.png\" 2x);}"
  ];
  [@css
    ".a-knsfyn{background-image:image-set(\"cat.png\" 1dppx, \"cat-2x.png\" 2dppx);}"
  ];
  [@css
    ".a-9l0k4n{background-image:image-set(\"cat.png\" 96dpi, \"cat-2x.png\" 192dpi);}"
  ];
  [@css ".a-ihfchh{background-image:image-set(\"cat.png\" 37dpcm);}"];
  
  CSS.make("a-11tobub", []);
  CSS.make("a-1e7m01f", []);
  CSS.make("a-fjhmlf", []);
  
  CSS.make("a-25toi3", []);
  CSS.make("a-knsfyn", []);
  CSS.make("a-9l0k4n", []);
  CSS.make("a-ihfchh", []);
