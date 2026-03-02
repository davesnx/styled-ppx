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
  [@css
    ".css-12m0k8p{pointer-events:auto;}\n.css-1k273s1{pointer-events:visiblePainted;}\n.css-1z0le2q{pointer-events:visibleFill;}\n.css-1e64ebn{pointer-events:visibleStroke;}\n.css-1ttsh4e{pointer-events:visible;}\n.css-nw29yp{pointer-events:painted;}\n.css-1olh5dc{pointer-events:fill;}\n.css-k8ii8d{pointer-events:stroke;}\n.css-uw7k7s{pointer-events:all;}\n.css-1ixbp0l{pointer-events:none;}\n"
  ];
  
  CSS.make("css-12m0k8p", []);
  
  CSS.make("css-1k273s1", []);
  CSS.make("css-1z0le2q", []);
  CSS.make("css-1e64ebn", []);
  CSS.make("css-1ttsh4e", []);
  CSS.make("css-nw29yp", []);
  CSS.make("css-1olh5dc", []);
  CSS.make("css-k8ii8d", []);
  CSS.make("css-uw7k7s", []);
  CSS.make("css-1ixbp0l", []);
