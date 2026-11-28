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
  [@css ".css-ivpc56y{color:var(--primary-color);}"];
  [@css ".css-ivpcvvg{background-color:var(--bg-color);}"];
  [@css ".css-ivpc4kt{margin:var(--spacing);}"];
  [@css ".css-ivpcqot{padding:var(--padding);}"];
  [@css ".css-ivpcngq{font-size:var(--font-size);}"];
  [@css ".css-ivpcjom{width:var(--width);}"];
  [@css ".css-ivpcsir{height:var(--height);}"];
  [@css ".css-ivpc0f5{color:inherit;}"];
  [@css ".css-ivpc68n{color:initial;}"];
  [@css ".css-ivpc59f{color:unset;}"];
  [@css ".css-ivpc6cd{color:revert;}"];
  [@css ".css-ivpc0g1{color:revert-layer;}"];
  [@css ".css-ivpctil{display:inherit;}"];
  [@css ".css-ivpc0ic{display:initial;}"];
  [@css ".css-ivpcskm{display:unset;}"];
  [@css ".css-ivpc5jb{display:revert;}"];
  [@css ".css-ivpcq9v{display:revert-layer;}"];
  [@css ".css-ivpcbv8{margin:inherit;}"];
  [@css ".css-ivpc9o9{margin:initial;}"];
  [@css ".css-ivpcbcg{margin:unset;}"];
  [@css ".css-ivpc4c8{margin:revert;}"];
  [@css ".css-ivpc65c{margin:revert-layer;}"];
  [@css ".css-ivpcj7k{-webkit-flex:inherit;-ms-flex:inherit;flex:inherit;}"];
  [@css ".css-ivpc6se{-webkit-flex:initial;-ms-flex:initial;flex:initial;}"];
  [@css ".css-ivpch8z{-webkit-flex:unset;-ms-flex:unset;flex:unset;}"];
  [@css ".css-ivpcevb{-webkit-flex:revert;-ms-flex:revert;flex:revert;}"];
  [@css
    ".css-ivpc77p{-webkit-flex:revert-layer;-ms-flex:revert-layer;flex:revert-layer;}"
  ];
  [@css ".css-ivpc7dm{font-size:inherit;}"];
  [@css ".css-ivpcjse{font-size:initial;}"];
  [@css ".css-ivpchp8{font-size:unset;}"];
  [@css ".css-ivpcgbd{font-size:revert;}"];
  [@css ".css-ivpc38w{font-size:revert-layer;}"];
  [@css.classes
    [
      ("css-ivpc56y", 0, "", "input.re", 2, 8, 2, 35),
      ("css-ivpcvvg", 1, "", "input.re", 3, 8, 3, 41),
      ("css-ivpc4kt", 2, "", "input.re", 4, 8, 4, 30),
      ("css-ivpcqot", 3, "", "input.re", 5, 8, 5, 31),
      ("css-ivpcngq", 4, "", "input.re", 6, 8, 6, 35),
      ("css-ivpcjom", 5, "", "input.re", 7, 8, 7, 27),
      ("css-ivpcsir", 6, "", "input.re", 8, 8, 8, 29),
      ("css-ivpc0f5", 7, "", "input.re", 11, 8, 11, 22),
      ("css-ivpc68n", 8, "", "input.re", 12, 8, 12, 22),
      ("css-ivpc59f", 9, "", "input.re", 13, 8, 13, 20),
      ("css-ivpc6cd", 10, "", "input.re", 14, 8, 14, 21),
      ("css-ivpc0g1", 11, "", "input.re", 15, 8, 15, 27),
      ("css-ivpctil", 12, "", "input.re", 17, 8, 17, 24),
      ("css-ivpc0ic", 13, "", "input.re", 18, 8, 18, 24),
      ("css-ivpcskm", 14, "", "input.re", 19, 8, 19, 22),
      ("css-ivpc5jb", 15, "", "input.re", 20, 8, 20, 23),
      ("css-ivpcq9v", 16, "", "input.re", 21, 8, 21, 29),
      ("css-ivpcbv8", 17, "", "input.re", 23, 8, 23, 23),
      ("css-ivpc9o9", 18, "", "input.re", 24, 8, 24, 23),
      ("css-ivpcbcg", 19, "", "input.re", 25, 8, 25, 21),
      ("css-ivpc4c8", 20, "", "input.re", 26, 8, 26, 22),
      ("css-ivpc65c", 21, "", "input.re", 27, 8, 27, 28),
      ("css-ivpcj7k", 22, "", "input.re", 29, 8, 29, 21),
      ("css-ivpc6se", 23, "", "input.re", 30, 8, 30, 21),
      ("css-ivpch8z", 24, "", "input.re", 31, 8, 31, 19),
      ("css-ivpcevb", 25, "", "input.re", 32, 8, 32, 20),
      ("css-ivpc77p", 26, "", "input.re", 33, 8, 33, 26),
      ("css-ivpc7dm", 27, "", "input.re", 35, 8, 35, 26),
      ("css-ivpcjse", 28, "", "input.re", 36, 8, 36, 26),
      ("css-ivpchp8", 29, "", "input.re", 37, 8, 37, 24),
      ("css-ivpcgbd", 30, "", "input.re", 38, 8, 38, 25),
      ("css-ivpc38w", 31, "", "input.re", 39, 8, 39, 31),
    ]
  ];
  
  CSS.make("css-ivpc56y", []);
  CSS.make("css-ivpcvvg", []);
  CSS.make("css-ivpc4kt", []);
  CSS.make("css-ivpcqot", []);
  CSS.make("css-ivpcngq", []);
  CSS.make("css-ivpcjom", []);
  CSS.make("css-ivpcsir", []);
  
  CSS.make("css-ivpc0f5", []);
  CSS.make("css-ivpc68n", []);
  CSS.make("css-ivpc59f", []);
  CSS.make("css-ivpc6cd", []);
  CSS.make("css-ivpc0g1", []);
  
  CSS.make("css-ivpctil", []);
  CSS.make("css-ivpc0ic", []);
  CSS.make("css-ivpcskm", []);
  CSS.make("css-ivpc5jb", []);
  CSS.make("css-ivpcq9v", []);
  
  CSS.make("css-ivpcbv8", []);
  CSS.make("css-ivpc9o9", []);
  CSS.make("css-ivpcbcg", []);
  CSS.make("css-ivpc4c8", []);
  CSS.make("css-ivpc65c", []);
  
  CSS.make("css-ivpcj7k", []);
  CSS.make("css-ivpc6se", []);
  CSS.make("css-ivpch8z", []);
  CSS.make("css-ivpcevb", []);
  CSS.make("css-ivpc77p", []);
  
  CSS.make("css-ivpc7dm", []);
  CSS.make("css-ivpcjse", []);
  CSS.make("css-ivpchp8", []);
  CSS.make("css-ivpcgbd", []);
  CSS.make("css-ivpc38w", []);
