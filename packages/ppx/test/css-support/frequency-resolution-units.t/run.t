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
  [@css "._a_6tobub{image-rendering:auto;}"];
  [@css "._a_6tm01f{image-rendering:crisp-edges;}"];
  [@css "._a_6thmlf{image-rendering:pixelated;}"];
  [@css
    "._a_39008toi3{background-image:image-set(\"cat.png\" 1x, \"cat-2x.png\" 2x);}"
  ];
  [@css
    "._a_39008sfyn{background-image:image-set(\"cat.png\" 1dppx, \"cat-2x.png\" 2dppx);}"
  ];
  [@css
    "._a_390080k4n{background-image:image-set(\"cat.png\" 96dpi, \"cat-2x.png\" 192dpi);}"
  ];
  [@css "._a_39008fchh{background-image:image-set(\"cat.png\" 37dpcm);}"];
  
  CSS.make("_a_6tobub", []);
  CSS.make("_a_6tm01f", []);
  CSS.make("_a_6thmlf", []);
  
  CSS.make("_a_39008toi3", []);
  CSS.make("_a_39008sfyn", []);
  CSS.make("_a_390080k4n", []);
  CSS.make("_a_39008fchh", []);
