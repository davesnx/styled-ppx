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
  [@css
    (
      "._a_9h0001vgc7{align-content:flex-start;}",
      "_a_9h0001vgc7",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9h0001x96o{align-content:flex-end;}",
      "_a_9h0001x96o",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9h0001t6ef{align-content:space-between;}",
      "_a_9h0001t6ef",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9h0001ulzr{align-content:space-around;}",
      "_a_9h0001ulzr",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9i0001vg9w{align-items:flex-start;}",
      "_a_9i0001vg9w",
      "0,1,0 own",
      "342",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9i0001kcm0{align-items:flex-end;}",
      "_a_9i0001kcm0",
      "0,1,0 own",
      "342",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9j00017e4w{align-self:flex-start;}",
      "_a_9j00017e4w",
      "0,1,0 own",
      "343",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9j0001sg73{align-self:flex-end;}",
      "_a_9j0001sg73",
      "0,1,0 own",
      "343",
      1,
      false,
    )
  ];
  [@css
    ("._a_5r08qs{display:flex;}", "_a_5r08qs", "0,1,0 own", "207", 1, false)
  ];
  [@css
    (
      "._a_5rcmzt{display:inline-flex;}",
      "_a_5rcmzt",
      "0,1,0 own",
      "207",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_603p27{-webkit-flex:none;-ms-flex:none;flex:none;}",
      "_a_603p27",
      "0,1,0 own",
      "216",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_60it56{-webkit-flex:5 7 10%;-ms-flex:5 7 10%;flex:5 7 10%;}",
      "_a_60it56",
      "0,1,0 own",
      "216",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_60fr2u{-webkit-flex:2;-ms-flex:2;flex:2;}",
      "_a_60fr2u",
      "0,1,0 own",
      "216",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_60wv0x{-webkit-flex:10em;-ms-flex:10em;flex:10em;}",
      "_a_60wv0x",
      "0,1,0 own",
      "216",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_60vgg1{-webkit-flex:30%;-ms-flex:30%;flex:30%;}",
      "_a_60vgg1",
      "0,1,0 own",
      "216",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_60aax7{-webkit-flex:min-content;-ms-flex:min-content;flex:min-content;}",
      "_a_60aax7",
      "0,1,0 own",
      "216",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_60thbz{-webkit-flex:1 30px;-ms-flex:1 30px;flex:1 30px;}",
      "_a_60thbz",
      "0,1,0 own",
      "216",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_60x0uu{-webkit-flex:2 2;-ms-flex:2 2;flex:2 2;}",
      "_a_60x0uu",
      "0,1,0 own",
      "216",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_608a55{-webkit-flex:2 2 10%;-ms-flex:2 2 10%;flex:2 2 10%;}",
      "_a_608a55",
      "0,1,0 own",
      "216",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_60f3wz{-webkit-flex:var(--flex1-3keqbf);-ms-flex:var(--flex1-3keqbf);flex:var(--flex1-3keqbf);}",
      "_a_60f3wz",
      "0,1,0 own",
      "216",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_600la7{-webkit-flex:var(--value-bdy3z7) var(--value2-1p309rg);-ms-flex:var(--value-bdy3z7) var(--value2-1p309rg);flex:var(--value-bdy3z7) var(--value2-1p309rg);}",
      "_a_600la7",
      "0,1,0 own",
      "216",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_60ecpy{-webkit-flex:var(--value-1g8t0wn) var(--value2-dmenma) var(--min-e3h4r0);-ms-flex:var(--value-1g8t0wn) var(--value2-dmenma) var(--min-e3h4r0);flex:var(--value-1g8t0wn) var(--value2-dmenma) var(--min-e3h4r0);}",
      "_a_60ecpy",
      "0,1,0 own",
      "216",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_60dbv2{-webkit-flex:var(--value-1g7nd20_1) var(--value-fet175_2);-ms-flex:var(--value-1g7nd20_1) var(--value-fet175_2);flex:var(--value-1g7nd20_1) var(--value-fet175_2);}",
      "_a_60dbv2",
      "0,1,0 own",
      "216",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_6000014n70{flex-basis:auto;}",
      "_a_6000014n70",
      "0,1,0 own",
      "216",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_600001wkcj{flex-basis:content;}",
      "_a_600001wkcj",
      "0,1,0 own",
      "216",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_600001cjcr{flex-basis:1px;}",
      "_a_600001cjcr",
      "0,1,0 own",
      "216",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_610001z8uk{-webkit-flex-direction:row;-ms-flex-direction:row;flex-direction:row;}",
      "_a_610001z8uk",
      "0,1,0 own",
      "217",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_610001j89b{-webkit-flex-direction:row-reverse;-ms-flex-direction:row-reverse;flex-direction:row-reverse;}",
      "_a_610001j89b",
      "0,1,0 own",
      "217",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_610001q59l{-webkit-flex-direction:column;-ms-flex-direction:column;flex-direction:column;}",
      "_a_610001q59l",
      "0,1,0 own",
      "217",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_610001iomr{-webkit-flex-direction:column-reverse;-ms-flex-direction:column-reverse;flex-direction:column-reverse;}",
      "_a_610001iomr",
      "0,1,0 own",
      "217",
      1,
      false,
    )
  ];
  [@css
    ("._a_6180vn{flex-flow:row;}", "_a_6180vn", "0,1,0 own", "217", 3, false)
  ];
  [@css
    (
      "._a_61a89u{flex-flow:row-reverse;}",
      "_a_61a89u",
      "0,1,0 own",
      "217",
      3,
      false,
    )
  ];
  [@css
    ("._a_61gqdn{flex-flow:column;}", "_a_61gqdn", "0,1,0 own", "217", 3, false)
  ];
  [@css
    (
      "._a_618tu8{flex-flow:column-reverse;}",
      "_a_618tu8",
      "0,1,0 own",
      "217",
      3,
      false,
    )
  ];
  [@css
    ("._a_61l61a{flex-flow:wrap;}", "_a_61l61a", "0,1,0 own", "217", 3, false)
  ];
  [@css
    (
      "._a_61yvs8{flex-flow:wrap-reverse;}",
      "_a_61yvs8",
      "0,1,0 own",
      "217",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_61hqlk{flex-flow:row wrap;}",
      "_a_61hqlk",
      "0,1,0 own",
      "217",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_61zoft{flex-flow:row-reverse nowrap;}",
      "_a_61zoft",
      "0,1,0 own",
      "217",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_61l4v1{flex-flow:column wrap;}",
      "_a_61l4v1",
      "0,1,0 own",
      "217",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_61o660{flex-flow:column-reverse wrap-reverse;}",
      "_a_61o660",
      "0,1,0 own",
      "217",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_600002chni{flex-grow:0;}",
      "_a_600002chni",
      "0,1,0 own",
      "216",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_600002v6bo{flex-grow:5;}",
      "_a_600002v6bo",
      "0,1,0 own",
      "216",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_600004oltb{flex-shrink:1;}",
      "_a_600004oltb",
      "0,1,0 own",
      "216",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_6000045a5q{flex-shrink:10;}",
      "_a_6000045a5q",
      "0,1,0 own",
      "216",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_610002sxg9{flex-wrap:nowrap;}",
      "_a_610002sxg9",
      "0,1,0 own",
      "217",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_610002p9i7{flex-wrap:wrap;}",
      "_a_610002p9i7",
      "0,1,0 own",
      "217",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_6100024whp{flex-wrap:wrap-reverse;}",
      "_a_6100024whp",
      "0,1,0 own",
      "217",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h00020841{justify-content:flex-start;}",
      "_a_9h00020841",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h0002getn{justify-content:flex-end;}",
      "_a_9h0002getn",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h0002dmss{justify-content:space-between;}",
      "_a_9h0002dmss",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h00024oss{justify-content:space-around;}",
      "_a_9h00024oss",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    ("._a_8ag5zj{min-height:auto;}", "_a_8ag5zj", "0,1,0 own", "298", 1, false)
  ];
  [@css
    ("._a_8c682b{min-width:auto;}", "_a_8c682b", "0,1,0 own", "300", 1, false)
  ];
  [@css ("._a_8nvlbw{order:0;}", "_a_8nvlbw", "0,1,0 own", "311", 1, false)];
  [@css ("._a_8ni80x{order:1;}", "_a_8ni80x", "0,1,0 own", "311", 1, false)];
  [@css.blocks
    [
      (9, "", [8]),
      (10, "", [9]),
      (11, "", [10]),
      (12, "", [11]),
      (13, "", [12]),
      (14, "", [13]),
      (15, "", [14]),
      (16, "", [15]),
      (17, "", [16]),
      (18, "", [17]),
      (19, "", [18]),
      (20, "", [19]),
      (21, "", [20]),
      (22, "", [21]),
      (23, "", [22]),
      (24, "", [23]),
      (25, "", [24]),
      (26, "", [25]),
      (27, "", [26]),
      (28, "", [27]),
      (29, "", [28]),
      (30, "", [29]),
      (31, "", [30]),
      (32, "", [31]),
      (33, "", [32]),
      (34, "", [33]),
      (35, "", [34]),
      (36, "", [35]),
      (37, "", [36]),
      (38, "", [37]),
      (39, "", [38]),
      (40, "", [39]),
      (41, "", [40]),
      (42, "", [41]),
      (43, "", [42]),
      (44, "", [43]),
      (45, "", [44]),
      (46, "", [45]),
      (47, "", [46]),
      (48, "", [47]),
      (49, "", [48]),
      (50, "", [49]),
      (51, "", [50]),
      (52, "", [51]),
      (53, "", [52]),
      (54, "", [53]),
      (55, "", [54]),
      (56, "", [55]),
      (57, "", [56]),
      (58, "", [57]),
      (59, "", [58]),
      (60, "", [59]),
      (61, "", [60]),
      (62, "", [61]),
      (63, "", [62]),
    ]
  ];
  module X = {
    let value = `num(1.);
    let value2 = `num(1.);
    let flex1 = `num(1.);
    let min = `px(500);
  };
  
  CSS.make("_a_9h0001vgc7", []);
  CSS.make("_a_9h0001x96o", []);
  CSS.make("_a_9h0001t6ef", []);
  CSS.make("_a_9h0001ulzr", []);
  CSS.make("_a_9i0001vg9w", []);
  CSS.make("_a_9i0001kcm0", []);
  CSS.make("_a_9j00017e4w", []);
  CSS.make("_a_9j0001sg73", []);
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
  CSS.make("_a_6000014n70", []);
  CSS.make("_a_600001wkcj", []);
  CSS.make("_a_600001cjcr", []);
  CSS.make("_a_610001z8uk", []);
  CSS.make("_a_610001j89b", []);
  CSS.make("_a_610001q59l", []);
  CSS.make("_a_610001iomr", []);
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
  CSS.make("_a_600002chni", []);
  CSS.make("_a_600002v6bo", []);
  CSS.make("_a_600004oltb", []);
  CSS.make("_a_6000045a5q", []);
  CSS.make("_a_610002sxg9", []);
  CSS.make("_a_610002p9i7", []);
  CSS.make("_a_6100024whp", []);
  CSS.make("_a_9h00020841", []);
  CSS.make("_a_9h0002getn", []);
  CSS.make("_a_9h0002dmss", []);
  CSS.make("_a_9h00024oss", []);
  CSS.make("_a_8ag5zj", []);
  CSS.make("_a_8c682b", []);
  CSS.make("_a_8nvlbw", []);
  CSS.make("_a_8ni80x", []);
