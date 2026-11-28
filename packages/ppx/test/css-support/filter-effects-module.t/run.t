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
  [@css "@property --ivpcrzr{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcw5g{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcyfe{syntax:\"*\";inherits:false;}"];
  [@css ".css-ivpc4ke{-webkit-filter:none;filter:none;}"];
  [@css ".css-ivpc2nc{-webkit-filter:url(\"#id\");filter:url(\"#id\");}"];
  [@css
    ".css-ivpcjxe{-webkit-filter:url(\"image.svg#id\");filter:url(\"image.svg#id\");}"
  ];
  [@css ".css-ivpcxy3{-webkit-filter:blur(5px);filter:blur(5px);}"];
  [@css ".css-ivpcr8e{-webkit-filter:brightness(0.5);filter:brightness(0.5);}"];
  [@css ".css-ivpciol{-webkit-filter:contrast(150%);filter:contrast(150%);}"];
  [@css
    ".css-ivpc17s{-webkit-filter:drop-shadow(5px 5px 10px);filter:drop-shadow(5px 5px 10px);}"
  ];
  [@css
    ".css-ivpc9vc{-webkit-filter:drop-shadow(15px 15px 15px #123);filter:drop-shadow(15px 15px 15px #123);}"
  ];
  [@css ".css-ivpc44h{-webkit-filter:grayscale(50%);filter:grayscale(50%);}"];
  [@css
    ".css-ivpc6p5{-webkit-filter:hue-rotate(50deg);filter:hue-rotate(50deg);}"
  ];
  [@css ".css-ivpc4id{-webkit-filter:invert(50%);filter:invert(50%);}"];
  [@css ".css-ivpc9lc{-webkit-filter:opacity(50%);filter:opacity(50%);}"];
  [@css ".css-ivpcplm{-webkit-filter:sepia(50%);filter:sepia(50%);}"];
  [@css ".css-ivpcfb7{-webkit-filter:saturate(150%);filter:saturate(150%);}"];
  [@css
    ".css-ivpcqjw{-webkit-filter:grayscale(100%) sepia(100%);filter:grayscale(100%) sepia(100%);}"
  ];
  [@css
    ".css-ivpcejp{-webkit-filter:drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));filter:drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));}"
  ];
  [@css
    ".css-ivpcraq{-webkit-filter:drop-shadow(0 1px 0 var(--ivpcrzr)) drop-shadow(0 1px 0 var(--ivpcw5g)) drop-shadow(0 1px 0 var(--ivpcyfe)) drop-shadow(0 32px 48px rgba(0, 0, 0, 0.075)) drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));filter:drop-shadow(0 1px 0 var(--ivpcrzr)) drop-shadow(0 1px 0 var(--ivpcw5g)) drop-shadow(0 1px 0 var(--ivpcyfe)) drop-shadow(0 32px 48px rgba(0, 0, 0, 0.075)) drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));}"
  ];
  [@css ".css-ivpckh8{-webkit-backdrop-filter:none;backdrop-filter:none;}"];
  [@css
    ".css-ivpcxeo{-webkit-backdrop-filter:url(\"#id\");backdrop-filter:url(\"#id\");}"
  ];
  [@css
    ".css-ivpcuuj{-webkit-backdrop-filter:url(\"image.svg#id\");backdrop-filter:url(\"image.svg#id\");}"
  ];
  [@css
    ".css-ivpcp2i{-webkit-backdrop-filter:blur(5px);backdrop-filter:blur(5px);}"
  ];
  [@css
    ".css-ivpcmwq{-webkit-backdrop-filter:brightness(0.5);backdrop-filter:brightness(0.5);}"
  ];
  [@css
    ".css-ivpc06a{-webkit-backdrop-filter:contrast(150%);backdrop-filter:contrast(150%);}"
  ];
  [@css
    ".css-ivpc7t5{-webkit-backdrop-filter:drop-shadow(15px 15px 15px rgba(0, 0, 0, 1));backdrop-filter:drop-shadow(15px 15px 15px rgba(0, 0, 0, 1));}"
  ];
  [@css
    ".css-ivpcjuw{-webkit-backdrop-filter:grayscale(50%);backdrop-filter:grayscale(50%);}"
  ];
  [@css
    ".css-ivpcjjo{-webkit-backdrop-filter:hue-rotate(50deg);backdrop-filter:hue-rotate(50deg);}"
  ];
  [@css
    ".css-ivpckj9{-webkit-backdrop-filter:invert(50%);backdrop-filter:invert(50%);}"
  ];
  [@css
    ".css-ivpcli7{-webkit-backdrop-filter:opacity(50%);backdrop-filter:opacity(50%);}"
  ];
  [@css
    ".css-ivpcm1e{-webkit-backdrop-filter:sepia(50%);backdrop-filter:sepia(50%);}"
  ];
  [@css
    ".css-ivpcoyk{-webkit-backdrop-filter:saturate(150%);backdrop-filter:saturate(150%);}"
  ];
  [@css
    ".css-ivpc8mj{-webkit-backdrop-filter:grayscale(100%) sepia(100%);backdrop-filter:grayscale(100%) sepia(100%);}"
  ];
  [@css.classes
    [
      ("css-ivpc4ke", 3, "", "input.re", 4, 8, 4, 20),
      ("css-ivpc2nc", 4, "", "input.re", 5, 8, 5, 24),
      ("css-ivpcjxe", 5, "", "input.re", 6, 8, 6, 33),
      ("css-ivpcxy3", 6, "", "input.re", 7, 8, 7, 25),
      ("css-ivpcr8e", 7, "", "input.re", 8, 8, 8, 31),
      ("css-ivpciol", 8, "", "input.re", 9, 8, 9, 30),
      ("css-ivpc17s", 9, "", "input.re", 14, 8, 14, 41),
      ("css-ivpc9vc", 10, "", "input.re", 16, 8, 16, 48),
      ("css-ivpc44h", 11, "", "input.re", 17, 8, 17, 30),
      ("css-ivpc6p5", 12, "", "input.re", 18, 8, 18, 33),
      ("css-ivpc4id", 13, "", "input.re", 19, 8, 19, 27),
      ("css-ivpc9lc", 14, "", "input.re", 20, 8, 20, 28),
      ("css-ivpcplm", 15, "", "input.re", 21, 8, 21, 26),
      ("css-ivpcfb7", 16, "", "input.re", 22, 8, 22, 30),
      ("css-ivpcqjw", 17, "", "input.re", 23, 8, 23, 43),
      ("css-ivpcejp", 18, "", "input.re", 24, 8, 25, 47),
      ("css-ivpcraq", 19, "", "input.re", 27, 4, 32, 51),
      ("css-ivpckh8", 20, "", "input.re", 36, 8, 36, 29),
      ("css-ivpcxeo", 21, "", "input.re", 37, 8, 37, 33),
      ("css-ivpcuuj", 22, "", "input.re", 38, 8, 38, 42),
      ("css-ivpcp2i", 23, "", "input.re", 39, 8, 39, 34),
      ("css-ivpcmwq", 24, "", "input.re", 40, 8, 40, 40),
      ("css-ivpc06a", 25, "", "input.re", 41, 8, 41, 39),
      ("css-ivpc7t5", 26, "", "input.re", 42, 8, 42, 69),
      ("css-ivpcjuw", 27, "", "input.re", 43, 8, 43, 39),
      ("css-ivpcjjo", 28, "", "input.re", 44, 8, 44, 42),
      ("css-ivpckj9", 29, "", "input.re", 45, 8, 45, 36),
      ("css-ivpcli7", 30, "", "input.re", 46, 8, 46, 37),
      ("css-ivpcm1e", 31, "", "input.re", 47, 8, 47, 35),
      ("css-ivpcoyk", 32, "", "input.re", 48, 8, 48, 39),
      ("css-ivpc8mj", 33, "", "input.re", 49, 8, 49, 52),
    ]
  ];
  let color = CSS.hex("333");
  
  CSS.make("css-ivpc4ke", []);
  CSS.make("css-ivpc2nc", []);
  CSS.make("css-ivpcjxe", []);
  CSS.make("css-ivpcxy3", []);
  CSS.make("css-ivpcr8e", []);
  CSS.make("css-ivpciol", []);
  
  CSS.make("css-ivpc17s", []);
  
  CSS.make("css-ivpc9vc", []);
  CSS.make("css-ivpc44h", []);
  CSS.make("css-ivpc6p5", []);
  CSS.make("css-ivpc4id", []);
  CSS.make("css-ivpc9lc", []);
  CSS.make("css-ivpcplm", []);
  CSS.make("css-ivpcfb7", []);
  CSS.make("css-ivpcqjw", []);
  CSS.make("css-ivpcejp", []);
  CSS.make(
    "css-ivpcraq",
    [
      ("--ivpcrzr", CSS.Types.Color.toString(color)),
      ("--ivpcw5g", CSS.Types.Color.toString(color)),
      ("--ivpcyfe", CSS.Types.Color.toString(color)),
    ],
  );
  
  CSS.make("css-ivpckh8", []);
  CSS.make("css-ivpcxeo", []);
  CSS.make("css-ivpcuuj", []);
  CSS.make("css-ivpcp2i", []);
  CSS.make("css-ivpcmwq", []);
  CSS.make("css-ivpc06a", []);
  CSS.make("css-ivpc7t5", []);
  CSS.make("css-ivpcjuw", []);
  CSS.make("css-ivpcjjo", []);
  CSS.make("css-ivpckj9", []);
  CSS.make("css-ivpcli7", []);
  CSS.make("css-ivpcm1e", []);
  CSS.make("css-ivpcoyk", []);
  CSS.make("css-ivpc8mj", []);
