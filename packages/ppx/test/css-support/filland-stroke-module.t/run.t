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
  
  CSS.SVG.fillRule(`nonzero);
  CSS.SVG.fillRule(`evenodd);
  
  CSS.SVG.fillOpacity(`num(0.5));
  CSS.SVG.fillOpacity(`percent(45.));
  
  CSS.SVG.strokeWidth(`num(0.));
  CSS.SVG.strokeWidth(`pxFloat(1.));
  CSS.SVG.strokeWidth(`percent(25.));
  
  CSS.SVG.strokeLinecap(`butt);
  CSS.SVG.strokeLinecap(`round);
  CSS.SVG.strokeLinecap(`square);
  
  CSS.SVG.strokeLinejoin(`miter);
  CSS.SVG.strokeLinejoin(`bevel);
  CSS.SVG.strokeLinejoin(`round);
  
  CSS.SVG.strokeMiterlimit(4.);
