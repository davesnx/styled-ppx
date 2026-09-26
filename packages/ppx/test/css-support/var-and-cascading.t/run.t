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
  [@css "._a_4en3kf{color:var(--primary-color);}"];
  [@css "._a_39004fuqy{background-color:var(--bg-color);}"];
  [@css "._a_7pcrrr{margin:var(--spacing);}"];
  [@css "._a_947rr7{padding:var(--padding);}"];
  [@css "._a_6500wykz8{font-size:var(--font-size);}"];
  [@css "._a_ecra93{width:var(--width);}"];
  [@css "._a_6lqm6h{height:var(--height);}"];
  [@css "._a_4ey3yl{color:inherit;}"];
  [@css "._a_4e8crh{color:initial;}"];
  [@css "._a_4eyg6i{color:unset;}"];
  [@css "._a_4ejbf2{color:revert;}"];
  [@css "._a_4e07lq{color:revert-layer;}"];
  [@css "._a_5rvscd{display:inherit;}"];
  [@css "._a_5rh118{display:initial;}"];
  [@css "._a_5rhxe5{display:unset;}"];
  [@css "._a_5rcx45{display:revert;}"];
  [@css "._a_5rojml{display:revert-layer;}"];
  [@css "._a_7pqj8z{margin:inherit;}"];
  [@css "._a_7pgxfx{margin:initial;}"];
  [@css "._a_7pzsk3{margin:unset;}"];
  [@css "._a_7p2sph{margin:revert;}"];
  [@css "._a_7pkzq5{margin:revert-layer;}"];
  [@css "._a_60nah6{-webkit-flex:inherit;-ms-flex:inherit;flex:inherit;}"];
  [@css "._a_60c6td{-webkit-flex:initial;-ms-flex:initial;flex:initial;}"];
  [@css "._a_6042ms{-webkit-flex:unset;-ms-flex:unset;flex:unset;}"];
  [@css "._a_608jui{-webkit-flex:revert;-ms-flex:revert;flex:revert;}"];
  [@css
    "._a_604fps{-webkit-flex:revert-layer;-ms-flex:revert-layer;flex:revert-layer;}"
  ];
  [@css "._a_6500we5f8{font-size:inherit;}"];
  [@css "._a_6500w53xd{font-size:initial;}"];
  [@css "._a_6500wswxq{font-size:unset;}"];
  [@css "._a_6500wntfo{font-size:revert;}"];
  [@css "._a_6500wpi5f{font-size:revert-layer;}"];
  
  CSS.make("_a_4en3kf", []);
  CSS.make("_a_39004fuqy", []);
  CSS.make("_a_7pcrrr", []);
  CSS.make("_a_947rr7", []);
  CSS.make("_a_6500wykz8", []);
  CSS.make("_a_ecra93", []);
  CSS.make("_a_6lqm6h", []);
  
  CSS.make("_a_4ey3yl", []);
  CSS.make("_a_4e8crh", []);
  CSS.make("_a_4eyg6i", []);
  CSS.make("_a_4ejbf2", []);
  CSS.make("_a_4e07lq", []);
  
  CSS.make("_a_5rvscd", []);
  CSS.make("_a_5rh118", []);
  CSS.make("_a_5rhxe5", []);
  CSS.make("_a_5rcx45", []);
  CSS.make("_a_5rojml", []);
  
  CSS.make("_a_7pqj8z", []);
  CSS.make("_a_7pgxfx", []);
  CSS.make("_a_7pzsk3", []);
  CSS.make("_a_7p2sph", []);
  CSS.make("_a_7pkzq5", []);
  
  CSS.make("_a_60nah6", []);
  CSS.make("_a_60c6td", []);
  CSS.make("_a_6042ms", []);
  CSS.make("_a_608jui", []);
  CSS.make("_a_604fps", []);
  
  CSS.make("_a_6500we5f8", []);
  CSS.make("_a_6500w53xd", []);
  CSS.make("_a_6500wswxq", []);
  CSS.make("_a_6500wntfo", []);
  CSS.make("_a_6500wpi5f", []);
