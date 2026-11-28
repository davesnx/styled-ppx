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
  [@css "@property --ivpch8g{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcs9a{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc9vd{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcpsn{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcp9w{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpct50{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcfj6{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcsbd{syntax:\"*\";inherits:false;}"];
  [@css ".css-ivpceuw{align-content:flex-start;}"];
  [@css ".css-ivpc42q{align-content:flex-end;}"];
  [@css ".css-ivpc29o{align-content:space-between;}"];
  [@css ".css-ivpcl5v{align-content:space-around;}"];
  [@css ".css-ivpcxpi{align-items:flex-start;}"];
  [@css ".css-ivpcvcs{align-items:flex-end;}"];
  [@css ".css-ivpcpsi{align-self:flex-start;}"];
  [@css ".css-ivpc1wn{align-self:flex-end;}"];
  [@css ".css-ivpcu5d{display:flex;}"];
  [@css ".css-ivpckv0{display:inline-flex;}"];
  [@css ".css-ivpc3lc{-webkit-flex:none;-ms-flex:none;flex:none;}"];
  [@css ".css-ivpcc4q{-webkit-flex:5 7 10%;-ms-flex:5 7 10%;flex:5 7 10%;}"];
  [@css ".css-ivpcv5s{-webkit-flex:2;-ms-flex:2;flex:2;}"];
  [@css ".css-ivpc50t{-webkit-flex:10em;-ms-flex:10em;flex:10em;}"];
  [@css ".css-ivpcoij{-webkit-flex:30%;-ms-flex:30%;flex:30%;}"];
  [@css
    ".css-ivpcurq{-webkit-flex:min-content;-ms-flex:min-content;flex:min-content;}"
  ];
  [@css ".css-ivpcgvu{-webkit-flex:1 30px;-ms-flex:1 30px;flex:1 30px;}"];
  [@css ".css-ivpch0q{-webkit-flex:2 2;-ms-flex:2 2;flex:2 2;}"];
  [@css ".css-ivpc0is{-webkit-flex:2 2 10%;-ms-flex:2 2 10%;flex:2 2 10%;}"];
  [@css
    ".css-ivpclmd{-webkit-flex:var(--ivpch8g);-ms-flex:var(--ivpch8g);flex:var(--ivpch8g);}"
  ];
  [@css
    ".css-ivpcwwu{-webkit-flex:var(--ivpcs9a) var(--ivpc9vd);-ms-flex:var(--ivpcs9a) var(--ivpc9vd);flex:var(--ivpcs9a) var(--ivpc9vd);}"
  ];
  [@css
    ".css-ivpcu8t{-webkit-flex:var(--ivpcpsn) var(--ivpcp9w) var(--ivpct50);-ms-flex:var(--ivpcpsn) var(--ivpcp9w) var(--ivpct50);flex:var(--ivpcpsn) var(--ivpcp9w) var(--ivpct50);}"
  ];
  [@css
    ".css-ivpcc4j{-webkit-flex:var(--ivpcfj6) var(--ivpcsbd);-ms-flex:var(--ivpcfj6) var(--ivpcsbd);flex:var(--ivpcfj6) var(--ivpcsbd);}"
  ];
  [@css ".css-ivpcct3{flex-basis:auto;}"];
  [@css ".css-ivpc65z{flex-basis:content;}"];
  [@css ".css-ivpcp8n{flex-basis:1px;}"];
  [@css
    ".css-ivpc4hz{-webkit-flex-direction:row;-ms-flex-direction:row;flex-direction:row;}"
  ];
  [@css
    ".css-ivpcepo{-webkit-flex-direction:row-reverse;-ms-flex-direction:row-reverse;flex-direction:row-reverse;}"
  ];
  [@css
    ".css-ivpchjl{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}"
  ];
  [@css
    ".css-ivpcilq{-webkit-flex-direction:column-reverse;-ms-flex-direction:column-reverse;flex-direction:column-reverse;}"
  ];
  [@css ".css-ivpcmbc{flex-flow:row;}"];
  [@css ".css-ivpcse5{flex-flow:row-reverse;}"];
  [@css ".css-ivpcsr8{flex-flow:column;}"];
  [@css ".css-ivpcm6e{flex-flow:column-reverse;}"];
  [@css ".css-ivpcs4v{flex-flow:wrap;}"];
  [@css ".css-ivpc5y4{flex-flow:wrap-reverse;}"];
  [@css ".css-ivpc4uj{flex-flow:row wrap;}"];
  [@css ".css-ivpcolk{flex-flow:row-reverse nowrap;}"];
  [@css ".css-ivpc8qt{flex-flow:column wrap;}"];
  [@css ".css-ivpcprg{flex-flow:column-reverse wrap-reverse;}"];
  [@css ".css-ivpch6w{flex-grow:0;}"];
  [@css ".css-ivpcs4f{flex-grow:5;}"];
  [@css ".css-ivpcsrq{flex-shrink:1;}"];
  [@css ".css-ivpcd6j{flex-shrink:10;}"];
  [@css ".css-ivpcps5{flex-wrap:nowrap;}"];
  [@css ".css-ivpc0hp{flex-wrap:wrap;}"];
  [@css ".css-ivpchvt{flex-wrap:wrap-reverse;}"];
  [@css ".css-ivpcn10{justify-content:flex-start;}"];
  [@css ".css-ivpc2i8{justify-content:flex-end;}"];
  [@css ".css-ivpc3rv{justify-content:space-between;}"];
  [@css ".css-ivpc3p0{justify-content:space-around;}"];
  [@css ".css-ivpcvoc{min-height:auto;}"];
  [@css ".css-ivpc6um{min-width:auto;}"];
  [@css ".css-ivpc151{order:0;}"];
  [@css ".css-ivpcnre{order:1;}"];
  [@css.classes
    [
      ("css-ivpceuw", 8, "", "input.re", 9, 8, 9, 33),
      ("css-ivpc42q", 9, "", "input.re", 10, 8, 10, 31),
      ("css-ivpc29o", 10, "", "input.re", 11, 8, 11, 36),
      ("css-ivpcl5v", 11, "", "input.re", 12, 8, 12, 35),
      ("css-ivpcxpi", 12, "", "input.re", 13, 8, 13, 31),
      ("css-ivpcvcs", 13, "", "input.re", 14, 8, 14, 29),
      ("css-ivpcpsi", 14, "", "input.re", 15, 8, 15, 30),
      ("css-ivpc1wn", 15, "", "input.re", 16, 8, 16, 28),
      ("css-ivpcu5d", 16, "", "input.re", 17, 8, 17, 21),
      ("css-ivpckv0", 17, "", "input.re", 18, 8, 18, 28),
      ("css-ivpc3lc", 18, "", "input.re", 19, 8, 19, 18),
      ("css-ivpcc4q", 19, "", "input.re", 20, 8, 20, 21),
      ("css-ivpcv5s", 20, "", "input.re", 21, 8, 21, 16),
      ("css-ivpc50t", 21, "", "input.re", 22, 8, 22, 19),
      ("css-ivpcoij", 22, "", "input.re", 23, 8, 23, 18),
      ("css-ivpcurq", 23, "", "input.re", 24, 8, 24, 26),
      ("css-ivpcgvu", 24, "", "input.re", 25, 8, 25, 21),
      ("css-ivpch0q", 25, "", "input.re", 26, 8, 26, 18),
      ("css-ivpc0is", 26, "", "input.re", 27, 8, 27, 22),
      ("css-ivpclmd", 27, "", "input.re", 28, 8, 28, 25),
      ("css-ivpcwwu", 28, "", "input.re", 29, 8, 29, 37),
      ("css-ivpcu8t", 29, "", "input.re", 30, 8, 30, 46),
      ("css-ivpcc4j", 30, "", "input.re", 31, 8, 31, 36),
      ("css-ivpcct3", 31, "", "input.re", 32, 8, 32, 24),
      ("css-ivpc65z", 32, "", "input.re", 33, 8, 33, 27),
      ("css-ivpcp8n", 33, "", "input.re", 34, 8, 34, 23),
      ("css-ivpc4hz", 34, "", "input.re", 35, 8, 35, 27),
      ("css-ivpcepo", 35, "", "input.re", 36, 8, 36, 35),
      ("css-ivpchjl", 36, "", "input.re", 37, 8, 37, 30),
      ("css-ivpcilq", 37, "", "input.re", 38, 8, 38, 38),
      ("css-ivpcmbc", 38, "", "input.re", 39, 8, 39, 22),
      ("css-ivpcse5", 39, "", "input.re", 40, 8, 40, 30),
      ("css-ivpcsr8", 40, "", "input.re", 41, 8, 41, 25),
      ("css-ivpcm6e", 41, "", "input.re", 42, 8, 42, 33),
      ("css-ivpcs4v", 42, "", "input.re", 43, 8, 43, 23),
      ("css-ivpc5y4", 43, "", "input.re", 44, 8, 44, 31),
      ("css-ivpc4uj", 44, "", "input.re", 45, 8, 45, 27),
      ("css-ivpcolk", 45, "", "input.re", 46, 8, 46, 37),
      ("css-ivpc8qt", 46, "", "input.re", 47, 8, 47, 30),
      ("css-ivpcprg", 47, "", "input.re", 48, 8, 48, 46),
      ("css-ivpch6w", 48, "", "input.re", 49, 8, 49, 20),
      ("css-ivpcs4f", 49, "", "input.re", 50, 8, 50, 20),
      ("css-ivpcsrq", 50, "", "input.re", 51, 8, 51, 22),
      ("css-ivpcd6j", 51, "", "input.re", 52, 8, 52, 23),
      ("css-ivpcps5", 52, "", "input.re", 53, 8, 53, 25),
      ("css-ivpc0hp", 53, "", "input.re", 54, 8, 54, 23),
      ("css-ivpchvt", 54, "", "input.re", 55, 8, 55, 31),
      ("css-ivpcn10", 55, "", "input.re", 56, 8, 56, 35),
      ("css-ivpc2i8", 56, "", "input.re", 57, 8, 57, 33),
      ("css-ivpc3rv", 57, "", "input.re", 58, 8, 58, 38),
      ("css-ivpc3p0", 58, "", "input.re", 59, 8, 59, 37),
      ("css-ivpcvoc", 59, "", "input.re", 60, 8, 60, 24),
      ("css-ivpc6um", 60, "", "input.re", 61, 8, 61, 23),
      ("css-ivpc151", 61, "", "input.re", 62, 8, 62, 16),
      ("css-ivpcnre", 62, "", "input.re", 63, 8, 63, 16),
    ]
  ];
  module X = {
    let value = `num(1.);
    let value2 = `num(1.);
    let flex1 = `num(1.);
    let min = `px(500);
  };
  
  CSS.make("css-ivpceuw", []);
  CSS.make("css-ivpc42q", []);
  CSS.make("css-ivpc29o", []);
  CSS.make("css-ivpcl5v", []);
  CSS.make("css-ivpcxpi", []);
  CSS.make("css-ivpcvcs", []);
  CSS.make("css-ivpcpsi", []);
  CSS.make("css-ivpc1wn", []);
  CSS.make("css-ivpcu5d", []);
  CSS.make("css-ivpckv0", []);
  CSS.make("css-ivpc3lc", []);
  CSS.make("css-ivpcc4q", []);
  CSS.make("css-ivpcv5s", []);
  CSS.make("css-ivpc50t", []);
  CSS.make("css-ivpcoij", []);
  CSS.make("css-ivpcurq", []);
  CSS.make("css-ivpcgvu", []);
  CSS.make("css-ivpch0q", []);
  CSS.make("css-ivpc0is", []);
  CSS.make("css-ivpclmd", [("--ivpch8g", CSS.Types.Flex.toString(X.flex1))]);
  CSS.make(
    "css-ivpcwwu",
    [
      ("--ivpcs9a", CSS.Types.FlexGrow.toString(X.value)),
      ("--ivpc9vd", CSS.Types.FlexShrink.toString(X.value2)),
    ],
  );
  CSS.make(
    "css-ivpcu8t",
    [
      ("--ivpcpsn", CSS.Types.FlexGrow.toString(X.value)),
      ("--ivpcp9w", CSS.Types.FlexShrink.toString(X.value2)),
      ("--ivpct50", CSS.Types.FlexBasis.toString(X.min)),
    ],
  );
  CSS.make(
    "css-ivpcc4j",
    [
      ("--ivpcfj6", CSS.Types.FlexGrow.toString(X.value)),
      ("--ivpcsbd", CSS.Types.FlexShrink.toString(X.value)),
    ],
  );
  CSS.make("css-ivpcct3", []);
  CSS.make("css-ivpc65z", []);
  CSS.make("css-ivpcp8n", []);
  CSS.make("css-ivpc4hz", []);
  CSS.make("css-ivpcepo", []);
  CSS.make("css-ivpchjl", []);
  CSS.make("css-ivpcilq", []);
  CSS.make("css-ivpcmbc", []);
  CSS.make("css-ivpcse5", []);
  CSS.make("css-ivpcsr8", []);
  CSS.make("css-ivpcm6e", []);
  CSS.make("css-ivpcs4v", []);
  CSS.make("css-ivpc5y4", []);
  CSS.make("css-ivpc4uj", []);
  CSS.make("css-ivpcolk", []);
  CSS.make("css-ivpc8qt", []);
  CSS.make("css-ivpcprg", []);
  CSS.make("css-ivpch6w", []);
  CSS.make("css-ivpcs4f", []);
  CSS.make("css-ivpcsrq", []);
  CSS.make("css-ivpcd6j", []);
  CSS.make("css-ivpcps5", []);
  CSS.make("css-ivpc0hp", []);
  CSS.make("css-ivpchvt", []);
  CSS.make("css-ivpcn10", []);
  CSS.make("css-ivpc2i8", []);
  CSS.make("css-ivpc3rv", []);
  CSS.make("css-ivpc3p0", []);
  CSS.make("css-ivpcvoc", []);
  CSS.make("css-ivpc6um", []);
  CSS.make("css-ivpc151", []);
  CSS.make("css-ivpcnre", []);
