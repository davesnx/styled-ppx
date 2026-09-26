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
  [@css "@property --flex1-3keqbf{syntax:\"*\";inherits:false;}"];
  [@css "@property --value-bdy3z7{syntax:\"*\";inherits:false;}"];
  [@css "@property --value2-1p309rg{syntax:\"*\";inherits:false;}"];
  [@css "@property --value-1g8t0wn{syntax:\"*\";inherits:false;}"];
  [@css "@property --value2-dmenma{syntax:\"*\";inherits:false;}"];
  [@css "@property --min-e3h4r0{syntax:\"*\";inherits:false;}"];
  [@css "@property --value-1g7nd20_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --value-fet175_2{syntax:\"*\";inherits:false;}"];
  [@css "._a_9h001vgc7{align-content:flex-start;}"];
  [@css "._a_9h001x96o{align-content:flex-end;}"];
  [@css "._a_9h001t6ef{align-content:space-between;}"];
  [@css "._a_9h001ulzr{align-content:space-around;}"];
  [@css "._a_9i001vg9w{align-items:flex-start;}"];
  [@css "._a_9i001kcm0{align-items:flex-end;}"];
  [@css "._a_9j0017e4w{align-self:flex-start;}"];
  [@css "._a_9j001sg73{align-self:flex-end;}"];
  [@css "._a_5r08qs{display:flex;}"];
  [@css "._a_5rcmzt{display:inline-flex;}"];
  [@css "._a_603p27{-webkit-flex:none;-ms-flex:none;flex:none;}"];
  [@css "._a_60it56{-webkit-flex:5 7 10%;-ms-flex:5 7 10%;flex:5 7 10%;}"];
  [@css "._a_60fr2u{-webkit-flex:2;-ms-flex:2;flex:2;}"];
  [@css "._a_60wv0x{-webkit-flex:10em;-ms-flex:10em;flex:10em;}"];
  [@css "._a_60vgg1{-webkit-flex:30%;-ms-flex:30%;flex:30%;}"];
  [@css
    "._a_60aax7{-webkit-flex:min-content;-ms-flex:min-content;flex:min-content;}"
  ];
  [@css "._a_60thbz{-webkit-flex:1 30px;-ms-flex:1 30px;flex:1 30px;}"];
  [@css "._a_60x0uu{-webkit-flex:2 2;-ms-flex:2 2;flex:2 2;}"];
  [@css "._a_608a55{-webkit-flex:2 2 10%;-ms-flex:2 2 10%;flex:2 2 10%;}"];
  [@css
    "._a_60f3wz{-webkit-flex:var(--flex1-3keqbf);-ms-flex:var(--flex1-3keqbf);flex:var(--flex1-3keqbf);}"
  ];
  [@css
    "._a_600la7{-webkit-flex:var(--value-bdy3z7) var(--value2-1p309rg);-ms-flex:var(--value-bdy3z7) var(--value2-1p309rg);flex:var(--value-bdy3z7) var(--value2-1p309rg);}"
  ];
  [@css
    "._a_60ecpy{-webkit-flex:var(--value-1g8t0wn) var(--value2-dmenma) var(--min-e3h4r0);-ms-flex:var(--value-1g8t0wn) var(--value2-dmenma) var(--min-e3h4r0);flex:var(--value-1g8t0wn) var(--value2-dmenma) var(--min-e3h4r0);}"
  ];
  [@css
    "._a_60dbv2{-webkit-flex:var(--value-1g7nd20_1) var(--value-fet175_2);-ms-flex:var(--value-1g7nd20_1) var(--value-fet175_2);flex:var(--value-1g7nd20_1) var(--value-fet175_2);}"
  ];
  [@css "._a_600014n70{flex-basis:auto;}"];
  [@css "._a_60001wkcj{flex-basis:content;}"];
  [@css "._a_60001cjcr{flex-basis:1px;}"];
  [@css
    "._a_61001z8uk{-webkit-flex-direction:row;-ms-flex-direction:row;flex-direction:row;}"
  ];
  [@css
    "._a_61001j89b{-webkit-flex-direction:row-reverse;-ms-flex-direction:row-reverse;flex-direction:row-reverse;}"
  ];
  [@css
    "._a_61001q59l{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}"
  ];
  [@css
    "._a_61001iomr{-webkit-flex-direction:column-reverse;-ms-flex-direction:column-reverse;flex-direction:column-reverse;}"
  ];
  [@css "._a_6180vn{flex-flow:row;}"];
  [@css "._a_61a89u{flex-flow:row-reverse;}"];
  [@css "._a_61gqdn{flex-flow:column;}"];
  [@css "._a_618tu8{flex-flow:column-reverse;}"];
  [@css "._a_61l61a{flex-flow:wrap;}"];
  [@css "._a_61yvs8{flex-flow:wrap-reverse;}"];
  [@css "._a_61hqlk{flex-flow:row wrap;}"];
  [@css "._a_61zoft{flex-flow:row-reverse nowrap;}"];
  [@css "._a_61l4v1{flex-flow:column wrap;}"];
  [@css "._a_61o660{flex-flow:column-reverse wrap-reverse;}"];
  [@css "._a_60002chni{flex-grow:0;}"];
  [@css "._a_60002v6bo{flex-grow:5;}"];
  [@css "._a_60004oltb{flex-shrink:1;}"];
  [@css "._a_600045a5q{flex-shrink:10;}"];
  [@css "._a_61002sxg9{flex-wrap:nowrap;}"];
  [@css "._a_61002p9i7{flex-wrap:wrap;}"];
  [@css "._a_610024whp{flex-wrap:wrap-reverse;}"];
  [@css "._a_9h0020841{justify-content:flex-start;}"];
  [@css "._a_9h002getn{justify-content:flex-end;}"];
  [@css "._a_9h002dmss{justify-content:space-between;}"];
  [@css "._a_9h0024oss{justify-content:space-around;}"];
  [@css "._a_8ag5zj{min-height:auto;}"];
  [@css "._a_8c682b{min-width:auto;}"];
  [@css "._a_8nvlbw{order:0;}"];
  [@css "._a_8ni80x{order:1;}"];
  module X = {
    let value = `num(1.);
    let value2 = `num(1.);
    let flex1 = `num(1.);
    let min = `px(500);
  };
  
  CSS.make("_a_9h001vgc7", []);
  CSS.make("_a_9h001x96o", []);
  CSS.make("_a_9h001t6ef", []);
  CSS.make("_a_9h001ulzr", []);
  CSS.make("_a_9i001vg9w", []);
  CSS.make("_a_9i001kcm0", []);
  CSS.make("_a_9j0017e4w", []);
  CSS.make("_a_9j001sg73", []);
  CSS.make("_a_5r08qs", []);
  CSS.make("_a_5rcmzt", []);
  CSS.make("_a_603p27", []);
  CSS.make("_a_60it56", []);
  CSS.make("_a_60fr2u", []);
  CSS.make("_a_60wv0x", []);
  CSS.make("_a_60vgg1", []);
  CSS.make("_a_60aax7", []);
  CSS.make("_a_60thbz", []);
  CSS.make("_a_60x0uu", []);
  CSS.make("_a_608a55", []);
  CSS.make(
    "_a_60f3wz",
    [("--flex1-3keqbf", CSS.Types.Flex.toString(X.flex1))],
  );
  CSS.make(
    "_a_600la7",
    [
      ("--value-bdy3z7", CSS.Types.FlexGrow.toString(X.value)),
      ("--value2-1p309rg", CSS.Types.FlexShrink.toString(X.value2)),
    ],
  );
  CSS.make(
    "_a_60ecpy",
    [
      ("--value-1g8t0wn", CSS.Types.FlexGrow.toString(X.value)),
      ("--value2-dmenma", CSS.Types.FlexShrink.toString(X.value2)),
      ("--min-e3h4r0", CSS.Types.FlexBasis.toString(X.min)),
    ],
  );
  CSS.make(
    "_a_60dbv2",
    [
      ("--value-1g7nd20_1", CSS.Types.FlexGrow.toString(X.value)),
      ("--value-fet175_2", CSS.Types.FlexShrink.toString(X.value)),
    ],
  );
  CSS.make("_a_600014n70", []);
  CSS.make("_a_60001wkcj", []);
  CSS.make("_a_60001cjcr", []);
  CSS.make("_a_61001z8uk", []);
  CSS.make("_a_61001j89b", []);
  CSS.make("_a_61001q59l", []);
  CSS.make("_a_61001iomr", []);
  CSS.make("_a_6180vn", []);
  CSS.make("_a_61a89u", []);
  CSS.make("_a_61gqdn", []);
  CSS.make("_a_618tu8", []);
  CSS.make("_a_61l61a", []);
  CSS.make("_a_61yvs8", []);
  CSS.make("_a_61hqlk", []);
  CSS.make("_a_61zoft", []);
  CSS.make("_a_61l4v1", []);
  CSS.make("_a_61o660", []);
  CSS.make("_a_60002chni", []);
  CSS.make("_a_60002v6bo", []);
  CSS.make("_a_60004oltb", []);
  CSS.make("_a_600045a5q", []);
  CSS.make("_a_61002sxg9", []);
  CSS.make("_a_61002p9i7", []);
  CSS.make("_a_610024whp", []);
  CSS.make("_a_9h0020841", []);
  CSS.make("_a_9h002getn", []);
  CSS.make("_a_9h002dmss", []);
  CSS.make("_a_9h0024oss", []);
  CSS.make("_a_8ag5zj", []);
  CSS.make("_a_8c682b", []);
  CSS.make("_a_8nvlbw", []);
  CSS.make("_a_8ni80x", []);
