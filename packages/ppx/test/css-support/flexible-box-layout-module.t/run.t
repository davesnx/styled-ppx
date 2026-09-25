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
  [@css ".a-9h001vgc7{align-content:flex-start;}"];
  [@css ".a-9h001x96o{align-content:flex-end;}"];
  [@css ".a-9h001t6ef{align-content:space-between;}"];
  [@css ".a-9h001ulzr{align-content:space-around;}"];
  [@css ".a-9i001vg9w{align-items:flex-start;}"];
  [@css ".a-9i001kcm0{align-items:flex-end;}"];
  [@css ".a-9j0017e4w{align-self:flex-start;}"];
  [@css ".a-9j001sg73{align-self:flex-end;}"];
  [@css ".a-5r08qs{display:flex;}"];
  [@css ".a-5rcmzt{display:inline-flex;}"];
  [@css ".a-603p27{-webkit-flex:none;-ms-flex:none;flex:none;}"];
  [@css ".a-60it56{-webkit-flex:5 7 10%;-ms-flex:5 7 10%;flex:5 7 10%;}"];
  [@css ".a-60fr2u{-webkit-flex:2;-ms-flex:2;flex:2;}"];
  [@css ".a-60wv0x{-webkit-flex:10em;-ms-flex:10em;flex:10em;}"];
  [@css ".a-60vgg1{-webkit-flex:30%;-ms-flex:30%;flex:30%;}"];
  [@css
    ".a-60aax7{-webkit-flex:min-content;-ms-flex:min-content;flex:min-content;}"
  ];
  [@css ".a-60thbz{-webkit-flex:1 30px;-ms-flex:1 30px;flex:1 30px;}"];
  [@css ".a-60x0uu{-webkit-flex:2 2;-ms-flex:2 2;flex:2 2;}"];
  [@css ".a-608a55{-webkit-flex:2 2 10%;-ms-flex:2 2 10%;flex:2 2 10%;}"];
  [@css
    ".in-1x4f3wz{-webkit-flex:var(--flex1-3keqbf);-ms-flex:var(--flex1-3keqbf);flex:var(--flex1-3keqbf);}"
  ];
  [@css
    ".in-19g0la7{-webkit-flex:var(--value-bdy3z7) var(--value2-1p309rg);-ms-flex:var(--value-bdy3z7) var(--value2-1p309rg);flex:var(--value-bdy3z7) var(--value2-1p309rg);}"
  ];
  [@css
    ".in-djecpy{-webkit-flex:var(--value-1g8t0wn) var(--value2-dmenma) var(--min-e3h4r0);-ms-flex:var(--value-1g8t0wn) var(--value2-dmenma) var(--min-e3h4r0);flex:var(--value-1g8t0wn) var(--value2-dmenma) var(--min-e3h4r0);}"
  ];
  [@css
    ".in-1f5dbv2{-webkit-flex:var(--value-1g7nd20_1) var(--value-fet175_2);-ms-flex:var(--value-1g7nd20_1) var(--value-fet175_2);flex:var(--value-1g7nd20_1) var(--value-fet175_2);}"
  ];
  [@css ".a-600014n70{flex-basis:auto;}"];
  [@css ".a-60001wkcj{flex-basis:content;}"];
  [@css ".a-60001cjcr{flex-basis:1px;}"];
  [@css
    ".a-61001z8uk{-webkit-flex-direction:row;-ms-flex-direction:row;flex-direction:row;}"
  ];
  [@css
    ".a-61001j89b{-webkit-flex-direction:row-reverse;-ms-flex-direction:row-reverse;flex-direction:row-reverse;}"
  ];
  [@css
    ".a-61001q59l{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}"
  ];
  [@css
    ".a-61001iomr{-webkit-flex-direction:column-reverse;-ms-flex-direction:column-reverse;flex-direction:column-reverse;}"
  ];
  [@css ".a-6180vn{flex-flow:row;}"];
  [@css ".a-61a89u{flex-flow:row-reverse;}"];
  [@css ".a-61gqdn{flex-flow:column;}"];
  [@css ".a-618tu8{flex-flow:column-reverse;}"];
  [@css ".a-61l61a{flex-flow:wrap;}"];
  [@css ".a-61yvs8{flex-flow:wrap-reverse;}"];
  [@css ".a-61hqlk{flex-flow:row wrap;}"];
  [@css ".a-61zoft{flex-flow:row-reverse nowrap;}"];
  [@css ".a-61l4v1{flex-flow:column wrap;}"];
  [@css ".a-61o660{flex-flow:column-reverse wrap-reverse;}"];
  [@css ".a-60002chni{flex-grow:0;}"];
  [@css ".a-60002v6bo{flex-grow:5;}"];
  [@css ".a-60004oltb{flex-shrink:1;}"];
  [@css ".a-600045a5q{flex-shrink:10;}"];
  [@css ".a-61002sxg9{flex-wrap:nowrap;}"];
  [@css ".a-61002p9i7{flex-wrap:wrap;}"];
  [@css ".a-610024whp{flex-wrap:wrap-reverse;}"];
  [@css ".a-9h0020841{justify-content:flex-start;}"];
  [@css ".a-9h002getn{justify-content:flex-end;}"];
  [@css ".a-9h002dmss{justify-content:space-between;}"];
  [@css ".a-9h0024oss{justify-content:space-around;}"];
  [@css ".a-8ag5zj{min-height:auto;}"];
  [@css ".a-8c682b{min-width:auto;}"];
  [@css ".a-8nvlbw{order:0;}"];
  [@css ".a-8ni80x{order:1;}"];
  module X = {
    let value = `num(1.);
    let value2 = `num(1.);
    let flex1 = `num(1.);
    let min = `px(500);
  };
  
  CSS.make("a-9h001vgc7", []);
  CSS.make("a-9h001x96o", []);
  CSS.make("a-9h001t6ef", []);
  CSS.make("a-9h001ulzr", []);
  CSS.make("a-9i001vg9w", []);
  CSS.make("a-9i001kcm0", []);
  CSS.make("a-9j0017e4w", []);
  CSS.make("a-9j001sg73", []);
  CSS.make("a-5r08qs", []);
  CSS.make("a-5rcmzt", []);
  CSS.make("a-603p27", []);
  CSS.make("a-60it56", []);
  CSS.make("a-60fr2u", []);
  CSS.make("a-60wv0x", []);
  CSS.make("a-60vgg1", []);
  CSS.make("a-60aax7", []);
  CSS.make("a-60thbz", []);
  CSS.make("a-60x0uu", []);
  CSS.make("a-608a55", []);
  CSS.make(
    "in-1x4f3wz",
    [("--flex1-3keqbf", CSS.Types.Flex.toString(X.flex1))],
  );
  CSS.make(
    "in-19g0la7",
    [
      ("--value-bdy3z7", CSS.Types.FlexGrow.toString(X.value)),
      ("--value2-1p309rg", CSS.Types.FlexShrink.toString(X.value2)),
    ],
  );
  CSS.make(
    "in-djecpy",
    [
      ("--value-1g8t0wn", CSS.Types.FlexGrow.toString(X.value)),
      ("--value2-dmenma", CSS.Types.FlexShrink.toString(X.value2)),
      ("--min-e3h4r0", CSS.Types.FlexBasis.toString(X.min)),
    ],
  );
  CSS.make(
    "in-1f5dbv2",
    [
      ("--value-1g7nd20_1", CSS.Types.FlexGrow.toString(X.value)),
      ("--value-fet175_2", CSS.Types.FlexShrink.toString(X.value)),
    ],
  );
  CSS.make("a-600014n70", []);
  CSS.make("a-60001wkcj", []);
  CSS.make("a-60001cjcr", []);
  CSS.make("a-61001z8uk", []);
  CSS.make("a-61001j89b", []);
  CSS.make("a-61001q59l", []);
  CSS.make("a-61001iomr", []);
  CSS.make("a-6180vn", []);
  CSS.make("a-61a89u", []);
  CSS.make("a-61gqdn", []);
  CSS.make("a-618tu8", []);
  CSS.make("a-61l61a", []);
  CSS.make("a-61yvs8", []);
  CSS.make("a-61hqlk", []);
  CSS.make("a-61zoft", []);
  CSS.make("a-61l4v1", []);
  CSS.make("a-61o660", []);
  CSS.make("a-60002chni", []);
  CSS.make("a-60002v6bo", []);
  CSS.make("a-60004oltb", []);
  CSS.make("a-600045a5q", []);
  CSS.make("a-61002sxg9", []);
  CSS.make("a-61002p9i7", []);
  CSS.make("a-610024whp", []);
  CSS.make("a-9h0020841", []);
  CSS.make("a-9h002getn", []);
  CSS.make("a-9h002dmss", []);
  CSS.make("a-9h0024oss", []);
  CSS.make("a-8ag5zj", []);
  CSS.make("a-8c682b", []);
  CSS.make("a-8nvlbw", []);
  CSS.make("a-8ni80x", []);
