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
  [@css ".css-zwn3kf{color:var(--primary-color);}"];
  [@css ".css-1hvfuqy{background-color:var(--bg-color);}"];
  [@css ".css-x8crrr{margin:var(--spacing);}"];
  [@css ".css-k07rr7{padding:var(--padding);}"];
  [@css ".css-1icykz8{font-size:var(--font-size);}"];
  [@css ".css-1lora93{width:var(--width);}"];
  [@css ".css-gmqm6h{height:var(--height);}"];
  [@css ".css-q2y3yl{color:inherit;}"];
  [@css ".css-1ed8crh{color:initial;}"];
  [@css ".css-1v7yg6i{color:unset;}"];
  [@css ".css-ppjbf2{color:revert;}"];
  [@css ".css-t807lq{color:revert-layer;}"];
  [@css ".css-1c6vscd{display:inherit;}"];
  [@css ".css-1msh118{display:initial;}"];
  [@css ".css-qxhxe5{display:unset;}"];
  [@css ".css-q6cx45{display:revert;}"];
  [@css ".css-eojml{display:revert-layer;}"];
  [@css ".css-vqj8z{margin:inherit;}"];
  [@css ".css-13bgxfx{margin:initial;}"];
  [@css ".css-1fyzsk3{margin:unset;}"];
  [@css ".css-1k42sph{margin:revert;}"];
  [@css ".css-ypkzq5{margin:revert-layer;}"];
  [@css ".css-y9nah6{flex:inherit;}"];
  [@css ".css-1ujc6td{flex:initial;}"];
  [@css ".css-1e042ms{flex:unset;}"];
  [@css ".css-1bh8jui{flex:revert;}"];
  [@css ".css-g54fps{flex:revert-layer;}"];
  [@css ".css-67e5f8{font-size:inherit;}"];
  [@css ".css-ur53xd{font-size:initial;}"];
  [@css ".css-rjswxq{font-size:unset;}"];
  [@css ".css-8zntfo{font-size:revert;}"];
  [@css ".css-1kcpi5f{font-size:revert-layer;}"];
  
  CSS.make("css-zwn3kf", []);
  CSS.make("css-1hvfuqy", []);
  CSS.make("css-x8crrr", []);
  CSS.make("css-k07rr7", []);
  CSS.make("css-1icykz8", []);
  CSS.make("css-1lora93", []);
  CSS.make("css-gmqm6h", []);
  
  CSS.make("css-q2y3yl", []);
  CSS.make("css-1ed8crh", []);
  CSS.make("css-1v7yg6i", []);
  CSS.make("css-ppjbf2", []);
  CSS.make("css-t807lq", []);
  
  CSS.make("css-1c6vscd", []);
  CSS.make("css-1msh118", []);
  CSS.make("css-qxhxe5", []);
  CSS.make("css-q6cx45", []);
  CSS.make("css-eojml", []);
  
  CSS.make("css-vqj8z", []);
  CSS.make("css-13bgxfx", []);
  CSS.make("css-1fyzsk3", []);
  CSS.make("css-1k42sph", []);
  CSS.make("css-ypkzq5", []);
  
  CSS.make("css-y9nah6", []);
  CSS.make("css-1ujc6td", []);
  CSS.make("css-1e042ms", []);
  CSS.make("css-1bh8jui", []);
  CSS.make("css-g54fps", []);
  
  CSS.make("css-67e5f8", []);
  CSS.make("css-ur53xd", []);
  CSS.make("css-rjswxq", []);
  CSS.make("css-8zntfo", []);
  CSS.make("css-1kcpi5f", []);

