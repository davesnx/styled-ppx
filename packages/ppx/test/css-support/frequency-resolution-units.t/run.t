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
  
  CSS.imageRendering(`auto);
  CSS.imageRendering(`crispEdges);
  CSS.imageRendering(`pixelated);
  
  CSS.unsafe(
    {js|backgroundImage|js},
    {js|image-set("cat.png" 1x, "cat-2x.png" 2x)|js},
  );
  CSS.unsafe(
    {js|backgroundImage|js},
    {js|image-set("cat.png" 1dppx, "cat-2x.png" 2dppx)|js},
  );
  CSS.unsafe(
    {js|backgroundImage|js},
    {js|image-set("cat.png" 96dpi, "cat-2x.png" 192dpi)|js},
  );
  CSS.unsafe({js|backgroundImage|js}, {js|image-set("cat.png" 37dpcm)|js});
