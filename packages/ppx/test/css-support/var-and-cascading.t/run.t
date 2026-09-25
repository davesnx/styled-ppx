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
  [@css ".a-4en3kf{color:var(--primary-color);}"];
  [@css ".a-39004fuqy{background-color:var(--bg-color);}"];
  [@css ".a-7pcrrr{margin:var(--spacing);}"];
  [@css ".a-947rr7{padding:var(--padding);}"];
  [@css ".a-6500wykz8{font-size:var(--font-size);}"];
  [@css ".a-ecra93{width:var(--width);}"];
  [@css ".a-6lqm6h{height:var(--height);}"];
  [@css ".a-4ey3yl{color:inherit;}"];
  [@css ".a-4e8crh{color:initial;}"];
  [@css ".a-4eyg6i{color:unset;}"];
  [@css ".a-4ejbf2{color:revert;}"];
  [@css ".a-4e07lq{color:revert-layer;}"];
  [@css ".a-5rvscd{display:inherit;}"];
  [@css ".a-5rh118{display:initial;}"];
  [@css ".a-5rhxe5{display:unset;}"];
  [@css ".a-5rcx45{display:revert;}"];
  [@css ".a-5rojml{display:revert-layer;}"];
  [@css ".a-7pqj8z{margin:inherit;}"];
  [@css ".a-7pgxfx{margin:initial;}"];
  [@css ".a-7pzsk3{margin:unset;}"];
  [@css ".a-7p2sph{margin:revert;}"];
  [@css ".a-7pkzq5{margin:revert-layer;}"];
  [@css ".a-60nah6{-webkit-flex:inherit;-ms-flex:inherit;flex:inherit;}"];
  [@css ".a-60c6td{-webkit-flex:initial;-ms-flex:initial;flex:initial;}"];
  [@css ".a-6042ms{-webkit-flex:unset;-ms-flex:unset;flex:unset;}"];
  [@css ".a-608jui{-webkit-flex:revert;-ms-flex:revert;flex:revert;}"];
  [@css
    ".a-604fps{-webkit-flex:revert-layer;-ms-flex:revert-layer;flex:revert-layer;}"
  ];
  [@css ".a-6500we5f8{font-size:inherit;}"];
  [@css ".a-6500w53xd{font-size:initial;}"];
  [@css ".a-6500wswxq{font-size:unset;}"];
  [@css ".a-6500wntfo{font-size:revert;}"];
  [@css ".a-6500wpi5f{font-size:revert-layer;}"];
  
  CSS.make("a-4en3kf", []);
  CSS.make("a-39004fuqy", []);
  CSS.make("a-7pcrrr", []);
  CSS.make("a-947rr7", []);
  CSS.make("a-6500wykz8", []);
  CSS.make("a-ecra93", []);
  CSS.make("a-6lqm6h", []);
  
  CSS.make("a-4ey3yl", []);
  CSS.make("a-4e8crh", []);
  CSS.make("a-4eyg6i", []);
  CSS.make("a-4ejbf2", []);
  CSS.make("a-4e07lq", []);
  
  CSS.make("a-5rvscd", []);
  CSS.make("a-5rh118", []);
  CSS.make("a-5rhxe5", []);
  CSS.make("a-5rcx45", []);
  CSS.make("a-5rojml", []);
  
  CSS.make("a-7pqj8z", []);
  CSS.make("a-7pgxfx", []);
  CSS.make("a-7pzsk3", []);
  CSS.make("a-7p2sph", []);
  CSS.make("a-7pkzq5", []);
  
  CSS.make("a-60nah6", []);
  CSS.make("a-60c6td", []);
  CSS.make("a-6042ms", []);
  CSS.make("a-608jui", []);
  CSS.make("a-604fps", []);
  
  CSS.make("a-6500we5f8", []);
  CSS.make("a-6500w53xd", []);
  CSS.make("a-6500wswxq", []);
  CSS.make("a-6500wntfo", []);
  CSS.make("a-6500wpi5f", []);
