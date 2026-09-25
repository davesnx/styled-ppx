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
  [@css ".a-6tobub{image-rendering:auto;}"];
  [@css ".a-6tm01f{image-rendering:crisp-edges;}"];
  [@css ".a-6thmlf{image-rendering:pixelated;}"];
  [@css
    ".a-39008toi3{background-image:image-set(\"cat.png\" 1x, \"cat-2x.png\" 2x);}"
  ];
  [@css
    ".a-39008sfyn{background-image:image-set(\"cat.png\" 1dppx, \"cat-2x.png\" 2dppx);}"
  ];
  [@css
    ".a-390080k4n{background-image:image-set(\"cat.png\" 96dpi, \"cat-2x.png\" 192dpi);}"
  ];
  [@css ".a-39008fchh{background-image:image-set(\"cat.png\" 37dpcm);}"];
  
  CSS.make("a-6tobub", []);
  CSS.make("a-6tm01f", []);
  CSS.make("a-6thmlf", []);
  
  CSS.make("a-39008toi3", []);
  CSS.make("a-39008sfyn", []);
  CSS.make("a-390080k4n", []);
  CSS.make("a-39008fchh", []);
