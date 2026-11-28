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
  [@css ".css-ivpcx3e{box-sizing:border-box;}"];
  [@css ".css-ivpctz0{box-sizing:content-box;}"];
  [@css ".css-ivpc0y4{outline-style:auto;}"];
  [@css ".css-ivpcwke{outline-style:none;}"];
  [@css ".css-ivpczy0{outline-style:dotted;}"];
  [@css ".css-ivpcxb4{outline-style:dashed;}"];
  [@css ".css-ivpc6q1{outline-style:solid;}"];
  [@css ".css-ivpcu18{outline-style:double;}"];
  [@css ".css-ivpcn3j{outline-style:groove;}"];
  [@css ".css-ivpc3oc{outline-style:ridge;}"];
  [@css ".css-ivpcwr5{outline-style:inset;}"];
  [@css ".css-ivpckwd{outline-style:outset;}"];
  [@css ".css-ivpcp9z{outline-offset:-5px;}"];
  [@css ".css-ivpc5s1{outline-offset:0;}"];
  [@css ".css-ivpcatl{outline-offset:5px;}"];
  [@css ".css-ivpcgvj{resize:none;}"];
  [@css ".css-ivpcjqk{resize:both;}"];
  [@css ".css-ivpcsj6{resize:horizontal;}"];
  [@css ".css-ivpctw2{resize:vertical;}"];
  [@css ".css-ivpcsdf{text-overflow:clip;}"];
  [@css ".css-ivpcugr{text-overflow:ellipsis;}"];
  [@css ".css-ivpcjd1{cursor:default;}"];
  [@css ".css-ivpc6mj{cursor:none;}"];
  [@css ".css-ivpcbc8{cursor:context-menu;}"];
  [@css ".css-ivpc04z{cursor:cell;}"];
  [@css ".css-ivpci1y{cursor:vertical-text;}"];
  [@css ".css-ivpcf0w{cursor:alias;}"];
  [@css ".css-ivpcf5t{cursor:copy;}"];
  [@css ".css-ivpcb1y{cursor:no-drop;}"];
  [@css ".css-ivpcbof{cursor:not-allowed;}"];
  [@css ".css-ivpcupi{cursor:-webkit-grab;cursor:grab;}"];
  [@css ".css-ivpclms{cursor:-webkit-grabbing;cursor:grabbing;}"];
  [@css ".css-ivpc9oy{cursor:ew-resize;}"];
  [@css ".css-ivpc9vs{cursor:ns-resize;}"];
  [@css ".css-ivpcvmz{cursor:nesw-resize;}"];
  [@css ".css-ivpc5zv{cursor:nwse-resize;}"];
  [@css ".css-ivpcb28{cursor:col-resize;}"];
  [@css ".css-ivpcugq{cursor:row-resize;}"];
  [@css ".css-ivpcael{cursor:all-scroll;}"];
  [@css ".css-ivpc53q{cursor:zoom-in;}"];
  [@css ".css-ivpcm9h{cursor:zoom-out;}"];
  [@css ".css-ivpcam0{caret-color:auto;}"];
  [@css ".css-ivpcrpc{caret-color:green;}"];
  [@css
    ".css-ivpcmgo{-webkit-appearance:auto;-moz-appearance:auto;-ms-appearance:auto;appearance:auto;}"
  ];
  [@css
    ".css-ivpc653{-webkit-appearance:none;-moz-appearance:none;-ms-appearance:none;appearance:none;}"
  ];
  [@css ".css-ivpcjyy{text-overflow:\"foo\";}"];
  [@css ".css-ivpcka0{text-overflow:clip clip;}"];
  [@css ".css-ivpc6mm{text-overflow:ellipsis clip;}"];
  [@css ".css-ivpc7iy{text-overflow:\"foo\" clip;}"];
  [@css ".css-ivpclkf{text-overflow:clip ellipsis;}"];
  [@css ".css-ivpcsjd{text-overflow:ellipsis ellipsis;}"];
  [@css ".css-ivpcyyq{text-overflow:\"foo\" ellipsis;}"];
  [@css ".css-ivpcty6{text-overflow:clip \"foo\";}"];
  [@css ".css-ivpcqjv{text-overflow:ellipsis \"foo\";}"];
  [@css ".css-ivpc3vq{text-overflow:\"foo\" \"foo\";}"];
  [@css
    ".css-ivpcz7y{-webkit-user-select:auto;-moz-user-select:auto;-ms-user-select:auto;user-select:auto;}"
  ];
  [@css
    ".css-ivpc99o{-webkit-user-select:text;-moz-user-select:text;-ms-user-select:text;user-select:text;}"
  ];
  [@css
    ".css-ivpcllq{-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;}"
  ];
  [@css
    ".css-ivpcyyx{-webkit-user-select:contain;-moz-user-select:contain;-ms-user-select:contain;user-select:contain;}"
  ];
  [@css
    ".css-ivpcdwh{-webkit-user-select:all;-moz-user-select:all;-ms-user-select:all;user-select:all;}"
  ];
  [@css.classes
    [
      ("css-ivpcx3e", 0, "", "input.re", 2, 8, 2, 30),
      ("css-ivpctz0", 1, "", "input.re", 3, 8, 3, 31),
      ("css-ivpc0y4", 2, "", "input.re", 4, 8, 4, 27),
      ("css-ivpcwke", 3, "", "input.re", 5, 8, 5, 27),
      ("css-ivpczy0", 4, "", "input.re", 6, 8, 6, 29),
      ("css-ivpcxb4", 5, "", "input.re", 7, 8, 7, 29),
      ("css-ivpc6q1", 6, "", "input.re", 8, 8, 8, 28),
      ("css-ivpcu18", 7, "", "input.re", 9, 8, 9, 29),
      ("css-ivpcn3j", 8, "", "input.re", 10, 8, 10, 29),
      ("css-ivpc3oc", 9, "", "input.re", 11, 8, 11, 28),
      ("css-ivpcwr5", 10, "", "input.re", 12, 8, 12, 28),
      ("css-ivpckwd", 11, "", "input.re", 13, 8, 13, 29),
      ("css-ivpcp9z", 12, "", "input.re", 14, 8, 14, 28),
      ("css-ivpc5s1", 13, "", "input.re", 15, 8, 15, 25),
      ("css-ivpcatl", 14, "", "input.re", 16, 8, 16, 27),
      ("css-ivpcgvj", 15, "", "input.re", 17, 8, 17, 20),
      ("css-ivpcjqk", 16, "", "input.re", 18, 8, 18, 20),
      ("css-ivpcsj6", 17, "", "input.re", 19, 8, 19, 26),
      ("css-ivpctw2", 18, "", "input.re", 20, 8, 20, 24),
      ("css-ivpcsdf", 19, "", "input.re", 21, 8, 21, 27),
      ("css-ivpcugr", 20, "", "input.re", 22, 8, 22, 31),
      ("css-ivpcjd1", 21, "", "input.re", 24, 8, 24, 23),
      ("css-ivpc6mj", 22, "", "input.re", 25, 8, 25, 20),
      ("css-ivpcbc8", 23, "", "input.re", 26, 8, 26, 28),
      ("css-ivpc04z", 24, "", "input.re", 27, 8, 27, 20),
      ("css-ivpci1y", 25, "", "input.re", 28, 8, 28, 29),
      ("css-ivpcf0w", 26, "", "input.re", 29, 8, 29, 21),
      ("css-ivpcf5t", 27, "", "input.re", 30, 8, 30, 20),
      ("css-ivpcb1y", 28, "", "input.re", 31, 8, 31, 23),
      ("css-ivpcbof", 29, "", "input.re", 32, 8, 32, 27),
      ("css-ivpcupi", 30, "", "input.re", 33, 8, 33, 20),
      ("css-ivpclms", 31, "", "input.re", 34, 8, 34, 24),
      ("css-ivpc9oy", 32, "", "input.re", 35, 8, 35, 25),
      ("css-ivpc9vs", 33, "", "input.re", 36, 8, 36, 25),
      ("css-ivpcvmz", 34, "", "input.re", 37, 8, 37, 27),
      ("css-ivpc5zv", 35, "", "input.re", 38, 8, 38, 27),
      ("css-ivpcb28", 36, "", "input.re", 39, 8, 39, 26),
      ("css-ivpcugq", 37, "", "input.re", 40, 8, 40, 26),
      ("css-ivpcael", 38, "", "input.re", 41, 8, 41, 26),
      ("css-ivpc53q", 39, "", "input.re", 42, 8, 42, 23),
      ("css-ivpcm9h", 40, "", "input.re", 43, 8, 43, 24),
      ("css-ivpcam0", 41, "", "input.re", 44, 8, 44, 25),
      ("css-ivpcrpc", 42, "", "input.re", 45, 8, 45, 26),
      ("css-ivpcmgo", 43, "", "input.re", 48, 8, 48, 24),
      ("css-ivpc653", 44, "", "input.re", 49, 8, 49, 24),
      ("css-ivpcjyy", 45, "", "input.re", 63, 8, 63, 28),
      ("css-ivpcka0", 46, "", "input.re", 64, 8, 64, 32),
      ("css-ivpc6mm", 47, "", "input.re", 65, 8, 65, 36),
      ("css-ivpc7iy", 48, "", "input.re", 69, 8, 69, 33),
      ("css-ivpclkf", 49, "", "input.re", 70, 8, 70, 36),
      ("css-ivpcsjd", 50, "", "input.re", 71, 8, 71, 40),
      ("css-ivpcyyq", 51, "", "input.re", 75, 8, 75, 37),
      ("css-ivpcty6", 52, "", "input.re", 94, 8, 94, 33),
      ("css-ivpcqjv", 53, "", "input.re", 95, 8, 95, 37),
      ("css-ivpc3vq", 54, "", "input.re", 99, 8, 99, 34),
      ("css-ivpcz7y", 55, "", "input.re", 100, 8, 100, 25),
      ("css-ivpc99o", 56, "", "input.re", 101, 8, 101, 25),
      ("css-ivpcllq", 57, "", "input.re", 102, 8, 102, 25),
      ("css-ivpcyyx", 58, "", "input.re", 103, 8, 103, 28),
      ("css-ivpcdwh", 59, "", "input.re", 104, 8, 104, 24),
    ]
  ];
  
  CSS.make("css-ivpcx3e", []);
  CSS.make("css-ivpctz0", []);
  CSS.make("css-ivpc0y4", []);
  CSS.make("css-ivpcwke", []);
  CSS.make("css-ivpczy0", []);
  CSS.make("css-ivpcxb4", []);
  CSS.make("css-ivpc6q1", []);
  CSS.make("css-ivpcu18", []);
  CSS.make("css-ivpcn3j", []);
  CSS.make("css-ivpc3oc", []);
  CSS.make("css-ivpcwr5", []);
  CSS.make("css-ivpckwd", []);
  CSS.make("css-ivpcp9z", []);
  CSS.make("css-ivpc5s1", []);
  CSS.make("css-ivpcatl", []);
  CSS.make("css-ivpcgvj", []);
  CSS.make("css-ivpcjqk", []);
  CSS.make("css-ivpcsj6", []);
  CSS.make("css-ivpctw2", []);
  CSS.make("css-ivpcsdf", []);
  CSS.make("css-ivpcugr", []);
  
  CSS.make("css-ivpcjd1", []);
  CSS.make("css-ivpc6mj", []);
  CSS.make("css-ivpcbc8", []);
  CSS.make("css-ivpc04z", []);
  CSS.make("css-ivpci1y", []);
  CSS.make("css-ivpcf0w", []);
  CSS.make("css-ivpcf5t", []);
  CSS.make("css-ivpcb1y", []);
  CSS.make("css-ivpcbof", []);
  CSS.make("css-ivpcupi", []);
  CSS.make("css-ivpclms", []);
  CSS.make("css-ivpc9oy", []);
  CSS.make("css-ivpc9vs", []);
  CSS.make("css-ivpcvmz", []);
  CSS.make("css-ivpc5zv", []);
  CSS.make("css-ivpcb28", []);
  CSS.make("css-ivpcugq", []);
  CSS.make("css-ivpcael", []);
  CSS.make("css-ivpc53q", []);
  CSS.make("css-ivpcm9h", []);
  CSS.make("css-ivpcam0", []);
  CSS.make("css-ivpcrpc", []);
  
  CSS.make("css-ivpcmgo", []);
  CSS.make("css-ivpc653", []);
  
  CSS.make("css-ivpcsdf", []);
  CSS.make("css-ivpcugr", []);
  
  CSS.make("css-ivpcjyy", []);
  CSS.make("css-ivpcka0", []);
  CSS.make("css-ivpc6mm", []);
  
  CSS.make("css-ivpc7iy", []);
  CSS.make("css-ivpclkf", []);
  CSS.make("css-ivpcsjd", []);
  
  CSS.make("css-ivpcyyq", []);
  
  CSS.make("css-ivpcty6", []);
  CSS.make("css-ivpcqjv", []);
  
  CSS.make("css-ivpc3vq", []);
  CSS.make("css-ivpcz7y", []);
  CSS.make("css-ivpc99o", []);
  CSS.make("css-ivpcllq", []);
  CSS.make("css-ivpcyyx", []);
  CSS.make("css-ivpcdwh", []);

  $ dune build
