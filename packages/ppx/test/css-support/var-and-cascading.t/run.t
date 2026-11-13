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
  [@css ".css-rch56y{color:var(--primary-color);}"];
  [@css ".css-qdbvvg{background-color:var(--bg-color);}"];
  [@css ".css-5hi4kt{margin:var(--spacing);}"];
  [@css ".css-10a5qot{padding:var(--padding);}"];
  [@css ".css-1ek5ngq{font-size:var(--font-size);}"];
  [@css ".css-1lb4jom{width:var(--width);}"];
  [@css ".css-976sir{height:var(--height);}"];
  [@css ".css-1a660f5{color:inherit;}"];
  [@css ".css-1n0568n{color:initial;}"];
  [@css ".css-e6u59f{color:unset;}"];
  [@css ".css-g456cd{color:revert;}"];
  [@css ".css-1s8y0g1{color:revert-layer;}"];
  [@css ".css-m9jtil{display:inherit;}"];
  [@css ".css-1x5i0ic{display:initial;}"];
  [@css ".css-w3oskm{display:unset;}"];
  [@css ".css-1egf5jb{display:revert;}"];
  [@css ".css-1q0cq9v{display:revert-layer;}"];
  [@css ".css-1chtbv8{margin:inherit;}"];
  [@css ".css-9f39o9{margin:initial;}"];
  [@css ".css-zi8bcg{margin:unset;}"];
  [@css ".css-bmv4c8{margin:revert;}"];
  [@css ".css-q0r65c{margin:revert-layer;}"];
  [@css ".css-11oqj7k{-webkit-flex:inherit;-ms-flex:inherit;flex:inherit;}"];
  [@css ".css-1zk6se{-webkit-flex:initial;-ms-flex:initial;flex:initial;}"];
  [@css ".css-tuuh8z{-webkit-flex:unset;-ms-flex:unset;flex:unset;}"];
  [@css ".css-1q2aevb{-webkit-flex:revert;-ms-flex:revert;flex:revert;}"];
  [@css
    ".css-w3x77p{-webkit-flex:revert-layer;-ms-flex:revert-layer;flex:revert-layer;}"
  ];
  [@css ".css-1q3z7dm{font-size:inherit;}"];
  [@css ".css-1x7hjse{font-size:initial;}"];
  [@css ".css-vsihp8{font-size:unset;}"];
  [@css ".css-1l8ngbd{font-size:revert;}"];
  [@css ".css-kky38w{font-size:revert-layer;}"];
  [@css.classes
    [
      ("css-rch56y", 0, "", "input.re", 2, 8, 2, 35),
      ("css-qdbvvg", 1, "", "input.re", 3, 8, 3, 41),
      ("css-5hi4kt", 2, "", "input.re", 4, 8, 4, 30),
      ("css-10a5qot", 3, "", "input.re", 5, 8, 5, 31),
      ("css-1ek5ngq", 4, "", "input.re", 6, 8, 6, 35),
      ("css-1lb4jom", 5, "", "input.re", 7, 8, 7, 27),
      ("css-976sir", 6, "", "input.re", 8, 8, 8, 29),
      ("css-1a660f5", 7, "", "input.re", 11, 8, 11, 22),
      ("css-1n0568n", 8, "", "input.re", 12, 8, 12, 22),
      ("css-e6u59f", 9, "", "input.re", 13, 8, 13, 20),
      ("css-g456cd", 10, "", "input.re", 14, 8, 14, 21),
      ("css-1s8y0g1", 11, "", "input.re", 15, 8, 15, 27),
      ("css-m9jtil", 12, "", "input.re", 17, 8, 17, 24),
      ("css-1x5i0ic", 13, "", "input.re", 18, 8, 18, 24),
      ("css-w3oskm", 14, "", "input.re", 19, 8, 19, 22),
      ("css-1egf5jb", 15, "", "input.re", 20, 8, 20, 23),
      ("css-1q0cq9v", 16, "", "input.re", 21, 8, 21, 29),
      ("css-1chtbv8", 17, "", "input.re", 23, 8, 23, 23),
      ("css-9f39o9", 18, "", "input.re", 24, 8, 24, 23),
      ("css-zi8bcg", 19, "", "input.re", 25, 8, 25, 21),
      ("css-bmv4c8", 20, "", "input.re", 26, 8, 26, 22),
      ("css-q0r65c", 21, "", "input.re", 27, 8, 27, 28),
      ("css-11oqj7k", 22, "", "input.re", 29, 8, 29, 21),
      ("css-1zk6se", 23, "", "input.re", 30, 8, 30, 21),
      ("css-tuuh8z", 24, "", "input.re", 31, 8, 31, 19),
      ("css-1q2aevb", 25, "", "input.re", 32, 8, 32, 20),
      ("css-w3x77p", 26, "", "input.re", 33, 8, 33, 26),
      ("css-1q3z7dm", 27, "", "input.re", 35, 8, 35, 26),
      ("css-1x7hjse", 28, "", "input.re", 36, 8, 36, 26),
      ("css-vsihp8", 29, "", "input.re", 37, 8, 37, 24),
      ("css-1l8ngbd", 30, "", "input.re", 38, 8, 38, 25),
      ("css-kky38w", 31, "", "input.re", 39, 8, 39, 31),
    ]
  ];
  
  CSS.make("css-rch56y", []);
  CSS.make("css-qdbvvg", []);
  CSS.make("css-5hi4kt", []);
  CSS.make("css-10a5qot", []);
  CSS.make("css-1ek5ngq", []);
  CSS.make("css-1lb4jom", []);
  CSS.make("css-976sir", []);
  
  CSS.make("css-1a660f5", []);
  CSS.make("css-1n0568n", []);
  CSS.make("css-e6u59f", []);
  CSS.make("css-g456cd", []);
  CSS.make("css-1s8y0g1", []);
  
  CSS.make("css-m9jtil", []);
  CSS.make("css-1x5i0ic", []);
  CSS.make("css-w3oskm", []);
  CSS.make("css-1egf5jb", []);
  CSS.make("css-1q0cq9v", []);
  
  CSS.make("css-1chtbv8", []);
  CSS.make("css-9f39o9", []);
  CSS.make("css-zi8bcg", []);
  CSS.make("css-bmv4c8", []);
  CSS.make("css-q0r65c", []);
  
  CSS.make("css-11oqj7k", []);
  CSS.make("css-1zk6se", []);
  CSS.make("css-tuuh8z", []);
  CSS.make("css-1q2aevb", []);
  CSS.make("css-w3x77p", []);
  
  CSS.make("css-1q3z7dm", []);
  CSS.make("css-1x7hjse", []);
  CSS.make("css-vsihp8", []);
  CSS.make("css-1l8ngbd", []);
  CSS.make("css-kky38w", []);
