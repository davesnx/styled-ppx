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
  [@css ".css-11tobub{image-rendering:auto}"];
  [@css ".css-1e7m01f{image-rendering:crisp-edges}"];
  [@css ".css-fjhmlf{image-rendering:pixelated}"];
  [@css
    ".css-ioubta{background-image:image-set(\"cat.png\" 1x,\"cat-2x.png\" 2x)}"
  ];
  [@css
    ".css-18e3u0e{background-image:image-set(\"cat.png\" 1dppx,\"cat-2x.png\" 2dppx)}"
  ];
  [@css
    ".css-1dv8y4j{background-image:image-set(\"cat.png\" 96dpi,\"cat-2x.png\" 192dpi)}"
  ];
  [@css ".css-ihfchh{background-image:image-set(\"cat.png\" 37dpcm)}"];
  
  CSS.make("css-11tobub", []);
  CSS.make("css-1e7m01f", []);
  CSS.make("css-fjhmlf", []);
  
  CSS.make("css-ioubta", []);
  CSS.make("css-18e3u0e", []);
  CSS.make("css-1dv8y4j", []);
  CSS.make("css-ihfchh", []);
