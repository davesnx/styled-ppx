This test ensures the ppx generates the correct output for CSS var() and cascading keywords
If this test fails, the var() and cascading support is broken

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
  [@css ".a-zwn3kf{color:var(--primary-color);}"];
  [@css ".a-1hvfuqy{background-color:var(--bg-color);}"];
  [@css ".a-x8crrr{margin:var(--spacing);}"];
  [@css ".a-k07rr7{padding:var(--padding);}"];
  [@css ".a-1icykz8{font-size:var(--font-size);}"];
  [@css ".a-1lora93{width:var(--width);}"];
  [@css ".a-gmqm6h{height:var(--height);}"];
  [@css ".a-q2y3yl{color:inherit;}"];
  [@css ".a-1ed8crh{color:initial;}"];
  [@css ".a-1v7yg6i{color:unset;}"];
  [@css ".a-ppjbf2{color:revert;}"];
  [@css ".a-t807lq{color:revert-layer;}"];
  [@css ".a-1c6vscd{display:inherit;}"];
  [@css ".a-1msh118{display:initial;}"];
  [@css ".a-qxhxe5{display:unset;}"];
  [@css ".a-q6cx45{display:revert;}"];
  [@css ".a-eojml{display:revert-layer;}"];
  [@css ".a-vqj8z{margin:inherit;}"];
  [@css ".a-13bgxfx{margin:initial;}"];
  [@css ".a-1fyzsk3{margin:unset;}"];
  [@css ".a-1k42sph{margin:revert;}"];
  [@css ".a-ypkzq5{margin:revert-layer;}"];
  [@css ".a-y9nah6{-webkit-flex:inherit;-ms-flex:inherit;flex:inherit;}"];
  [@css ".a-1ujc6td{-webkit-flex:initial;-ms-flex:initial;flex:initial;}"];
  [@css ".a-1e042ms{-webkit-flex:unset;-ms-flex:unset;flex:unset;}"];
  [@css ".a-1bh8jui{-webkit-flex:revert;-ms-flex:revert;flex:revert;}"];
  [@css
    ".a-g54fps{-webkit-flex:revert-layer;-ms-flex:revert-layer;flex:revert-layer;}"
  ];
  [@css ".a-67e5f8{font-size:inherit;}"];
  [@css ".a-ur53xd{font-size:initial;}"];
  [@css ".a-rjswxq{font-size:unset;}"];
  [@css ".a-8zntfo{font-size:revert;}"];
  [@css ".a-1kcpi5f{font-size:revert-layer;}"];
  
  CSS.make("a-zwn3kf", []);
  CSS.make("a-1hvfuqy", []);
  CSS.make("a-x8crrr", []);
  CSS.make("a-k07rr7", []);
  CSS.make("a-1icykz8", []);
  CSS.make("a-1lora93", []);
  CSS.make("a-gmqm6h", []);
  
  CSS.make("a-q2y3yl", []);
  CSS.make("a-1ed8crh", []);
  CSS.make("a-1v7yg6i", []);
  CSS.make("a-ppjbf2", []);
  CSS.make("a-t807lq", []);
  
  CSS.make("a-1c6vscd", []);
  CSS.make("a-1msh118", []);
  CSS.make("a-qxhxe5", []);
  CSS.make("a-q6cx45", []);
  CSS.make("a-eojml", []);
  
  CSS.make("a-vqj8z", []);
  CSS.make("a-13bgxfx", []);
  CSS.make("a-1fyzsk3", []);
  CSS.make("a-1k42sph", []);
  CSS.make("a-ypkzq5", []);
  
  CSS.make("a-y9nah6", []);
  CSS.make("a-1ujc6td", []);
  CSS.make("a-1e042ms", []);
  CSS.make("a-1bh8jui", []);
  CSS.make("a-g54fps", []);
  
  CSS.make("a-67e5f8", []);
  CSS.make("a-ur53xd", []);
  CSS.make("a-rjswxq", []);
  CSS.make("a-8zntfo", []);
  CSS.make("a-1kcpi5f", []);
