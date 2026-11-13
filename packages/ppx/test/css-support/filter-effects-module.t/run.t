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
  [@css "@property --15sxkev-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --15sxkev-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --15sxkev-2{syntax:\"*\";inherits:false;}"];
  [@css ".css-1dp64ke{-webkit-filter:none;filter:none;}"];
  [@css ".css-u8u2nc{-webkit-filter:url(\"#id\");filter:url(\"#id\");}"];
  [@css
    ".css-qi4jxe{-webkit-filter:url(\"image.svg#id\");filter:url(\"image.svg#id\");}"
  ];
  [@css ".css-1vsvxy3{-webkit-filter:blur(5px);filter:blur(5px);}"];
  [@css ".css-1yt5r8e{-webkit-filter:brightness(0.5);filter:brightness(0.5);}"];
  [@css ".css-6qpiol{-webkit-filter:contrast(150%);filter:contrast(150%);}"];
  [@css
    ".css-1l1s17s{-webkit-filter:drop-shadow(5px 5px 10px);filter:drop-shadow(5px 5px 10px);}"
  ];
  [@css
    ".css-1ydm9vc{-webkit-filter:drop-shadow(15px 15px 15px #123);filter:drop-shadow(15px 15px 15px #123);}"
  ];
  [@css ".css-c6g44h{-webkit-filter:grayscale(50%);filter:grayscale(50%);}"];
  [@css
    ".css-a8y6p5{-webkit-filter:hue-rotate(50deg);filter:hue-rotate(50deg);}"
  ];
  [@css ".css-1j94id{-webkit-filter:invert(50%);filter:invert(50%);}"];
  [@css ".css-6lt9lc{-webkit-filter:opacity(50%);filter:opacity(50%);}"];
  [@css ".css-lbfplm{-webkit-filter:sepia(50%);filter:sepia(50%);}"];
  [@css ".css-palfb7{-webkit-filter:saturate(150%);filter:saturate(150%);}"];
  [@css
    ".css-1shpqjw{-webkit-filter:grayscale(100%) sepia(100%);filter:grayscale(100%) sepia(100%);}"
  ];
  [@css
    ".css-66uejp{-webkit-filter:drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));filter:drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));}"
  ];
  [@css
    ".css-15sxkev{-webkit-filter:drop-shadow(0 1px 0 var(--15sxkev-0)) drop-shadow(0 1px 0 var(--15sxkev-1)) drop-shadow(0 1px 0 var(--15sxkev-2)) drop-shadow(0 32px 48px rgba(0, 0, 0, 0.075)) drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));filter:drop-shadow(0 1px 0 var(--15sxkev-0)) drop-shadow(0 1px 0 var(--15sxkev-1)) drop-shadow(0 1px 0 var(--15sxkev-2)) drop-shadow(0 32px 48px rgba(0, 0, 0, 0.075)) drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));}"
  ];
  [@css ".css-1yktkh8{-webkit-backdrop-filter:none;backdrop-filter:none;}"];
  [@css
    ".css-gnlxeo{-webkit-backdrop-filter:url(\"#id\");backdrop-filter:url(\"#id\");}"
  ];
  [@css
    ".css-eb0uuj{-webkit-backdrop-filter:url(\"image.svg#id\");backdrop-filter:url(\"image.svg#id\");}"
  ];
  [@css
    ".css-tvcp2i{-webkit-backdrop-filter:blur(5px);backdrop-filter:blur(5px);}"
  ];
  [@css
    ".css-7mvmwq{-webkit-backdrop-filter:brightness(0.5);backdrop-filter:brightness(0.5);}"
  ];
  [@css
    ".css-7b306a{-webkit-backdrop-filter:contrast(150%);backdrop-filter:contrast(150%);}"
  ];
  [@css
    ".css-fr97t5{-webkit-backdrop-filter:drop-shadow(15px 15px 15px rgba(0, 0, 0, 1));backdrop-filter:drop-shadow(15px 15px 15px rgba(0, 0, 0, 1));}"
  ];
  [@css
    ".css-1nzojuw{-webkit-backdrop-filter:grayscale(50%);backdrop-filter:grayscale(50%);}"
  ];
  [@css
    ".css-tqrjjo{-webkit-backdrop-filter:hue-rotate(50deg);backdrop-filter:hue-rotate(50deg);}"
  ];
  [@css
    ".css-revkj9{-webkit-backdrop-filter:invert(50%);backdrop-filter:invert(50%);}"
  ];
  [@css
    ".css-1bylli7{-webkit-backdrop-filter:opacity(50%);backdrop-filter:opacity(50%);}"
  ];
  [@css
    ".css-1ntgm1e{-webkit-backdrop-filter:sepia(50%);backdrop-filter:sepia(50%);}"
  ];
  [@css
    ".css-wjroyk{-webkit-backdrop-filter:saturate(150%);backdrop-filter:saturate(150%);}"
  ];
  [@css
    ".css-kyu8mj{-webkit-backdrop-filter:grayscale(100%) sepia(100%);backdrop-filter:grayscale(100%) sepia(100%);}"
  ];
  [@css.classes
    [
      ("css-1dp64ke", 3, "", "input.re", 4, 8, 4, 20),
      ("css-u8u2nc", 4, "", "input.re", 5, 8, 5, 24),
      ("css-qi4jxe", 5, "", "input.re", 6, 8, 6, 33),
      ("css-1vsvxy3", 6, "", "input.re", 7, 8, 7, 25),
      ("css-1yt5r8e", 7, "", "input.re", 8, 8, 8, 31),
      ("css-6qpiol", 8, "", "input.re", 9, 8, 9, 30),
      ("css-1l1s17s", 9, "", "input.re", 14, 8, 14, 41),
      ("css-1ydm9vc", 10, "", "input.re", 16, 8, 16, 48),
      ("css-c6g44h", 11, "", "input.re", 17, 8, 17, 30),
      ("css-a8y6p5", 12, "", "input.re", 18, 8, 18, 33),
      ("css-1j94id", 13, "", "input.re", 19, 8, 19, 27),
      ("css-6lt9lc", 14, "", "input.re", 20, 8, 20, 28),
      ("css-lbfplm", 15, "", "input.re", 21, 8, 21, 26),
      ("css-palfb7", 16, "", "input.re", 22, 8, 22, 30),
      ("css-1shpqjw", 17, "", "input.re", 23, 8, 23, 43),
      ("css-66uejp", 18, "", "input.re", 24, 8, 25, 47),
      ("css-15sxkev", 19, "", "input.re", 27, 4, 32, 51),
      ("css-1yktkh8", 20, "", "input.re", 36, 8, 36, 29),
      ("css-gnlxeo", 21, "", "input.re", 37, 8, 37, 33),
      ("css-eb0uuj", 22, "", "input.re", 38, 8, 38, 42),
      ("css-tvcp2i", 23, "", "input.re", 39, 8, 39, 34),
      ("css-7mvmwq", 24, "", "input.re", 40, 8, 40, 40),
      ("css-7b306a", 25, "", "input.re", 41, 8, 41, 39),
      ("css-fr97t5", 26, "", "input.re", 42, 8, 42, 69),
      ("css-1nzojuw", 27, "", "input.re", 43, 8, 43, 39),
      ("css-tqrjjo", 28, "", "input.re", 44, 8, 44, 42),
      ("css-revkj9", 29, "", "input.re", 45, 8, 45, 36),
      ("css-1bylli7", 30, "", "input.re", 46, 8, 46, 37),
      ("css-1ntgm1e", 31, "", "input.re", 47, 8, 47, 35),
      ("css-wjroyk", 32, "", "input.re", 48, 8, 48, 39),
      ("css-kyu8mj", 33, "", "input.re", 49, 8, 49, 52),
    ]
  ];
  let color = CSS.hex("333");
  
  CSS.make("css-1dp64ke", []);
  CSS.make("css-u8u2nc", []);
  CSS.make("css-qi4jxe", []);
  CSS.make("css-1vsvxy3", []);
  CSS.make("css-1yt5r8e", []);
  CSS.make("css-6qpiol", []);
  
  CSS.make("css-1l1s17s", []);
  
  CSS.make("css-1ydm9vc", []);
  CSS.make("css-c6g44h", []);
  CSS.make("css-a8y6p5", []);
  CSS.make("css-1j94id", []);
  CSS.make("css-6lt9lc", []);
  CSS.make("css-lbfplm", []);
  CSS.make("css-palfb7", []);
  CSS.make("css-1shpqjw", []);
  CSS.make("css-66uejp", []);
  CSS.make(
    "css-15sxkev",
    [
      ("--15sxkev-0", CSS.Types.Color.toString(color)),
      ("--15sxkev-1", CSS.Types.Color.toString(color)),
      ("--15sxkev-2", CSS.Types.Color.toString(color)),
    ],
  );
  
  CSS.make("css-1yktkh8", []);
  CSS.make("css-gnlxeo", []);
  CSS.make("css-eb0uuj", []);
  CSS.make("css-tvcp2i", []);
  CSS.make("css-7mvmwq", []);
  CSS.make("css-7b306a", []);
  CSS.make("css-fr97t5", []);
  CSS.make("css-1nzojuw", []);
  CSS.make("css-tqrjjo", []);
  CSS.make("css-revkj9", []);
  CSS.make("css-1bylli7", []);
  CSS.make("css-1ntgm1e", []);
  CSS.make("css-wjroyk", []);
  CSS.make("css-kyu8mj", []);
