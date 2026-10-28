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
  [@css "@property --tertiary-1cttnp6{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-9kmuhm_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-9kmuhm_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1rsudnc_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1rsudnc_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --secondary-hfvj8d{syntax:\"*\";inherits:false;}"];
  [@css "@property --box_-1n2q0et{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-3w1stm_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-3w1stm_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-3w1stm_3{syntax:\"*\";inherits:false;}"];
  [@css ("._a_eck09d{width:30px;}", "_a_eck09d", "0,1,0 own", "516", 1, false)];
  [@css
    (
      "._a_4e090v{color:var(--tertiary-1cttnp6);}",
      "_a_4e090v",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_oe8sa40slgw{box-shadow:inset 1px 0 0 0 transparent !important;}",
      "_a_oe8sa40slgw",
      "!0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_oe8sa4080o9{box-shadow:1px 0 0 0 var(--line-9kmuhm_1), inset 0 -1px 0 0 var(--line-9kmuhm_2) !important;}",
      "_a_oe8sa4080o9",
      "!0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_400ppg{box-shadow:inset 0 0 0 0 transparent;}",
      "_a_400ppg",
      "0,1,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_h5nao400v5z:hover{box-shadow:1px 0 0 0 var(--line-1rsudnc_1), inset 0 -1px 0 0 var(--line-1rsudnc_2) !important;}",
      "_a_h5nao400v5z",
      "!0,2,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4eyeca{color:var(--secondary-hfvj8d);}",
      "_a_4eyeca",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_qyw7u390004kqt8:hover{background-color:var(--box_-1n2q0et);}",
      "_a_qyw7u390004kqt8",
      "0,2,0 own",
      "117",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_qyw7u40rvac:hover{box-shadow:1px 0 0 0 var(--line-3w1stm_1), inset 1px 0 0 0 var(--line-3w1stm_2), inset 0 -1px 0 0 var(--line-3w1stm_3);}",
      "_a_qyw7u40rvac",
      "0,2,0 own",
      "144",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_600002gxme{flex-grow:1;}",
      "_a_600002gxme",
      "0,1,0 own",
      "216",
      2,
      false,
    )
  ];
  [@css ("._a_ekz5ec{z-index:1;}", "_a_ekz5ec", "0,1,0 own", "524", 1, false)];
  [@css
    (
      "._a_dmsoaq{transition:all 200ms ease 0ms;}",
      "_a_dmsoaq",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_47xb18cym79._id_1p5u6ax{min-width:0;}",
      "_a_47xb18cym79",
      "0,2,0 own",
      "300",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_47xb188qeme._id_1p5u6ax{max-width:0;}",
      "_a_47xb188qeme",
      "0,2,0 own",
      "296",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_47xb18mk2n6._id_1p5u6ax{opacity:0;}",
      "_a_47xb18mk2n6",
      "0,2,0 own",
      "310",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_47xb18r57eg._id_1p5u6ax{overflow:hidden;}",
      "_a_47xb18r57eg",
      "0,2,0 own",
      "315",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_oe8sadmq5th{transition:transform 0.3s !important;}",
      "_a_oe8sadmq5th",
      "!0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css
    (
      "._a_dmm8mm{transition:opacity 0.2s ease-in-out, visibility 0.2s ease-in-out;}",
      "_a_dmm8mm",
      "0,1,0 own",
      "490",
      31,
      false,
    )
  ];
  [@css.bindings
    [
      ("Input._spaceBeforeColon", "_id_1u048gq", "_a_eck09d _a_4e090v"),
      ("Input._tabInnerFirst", "_id_3dai6", "_a_oe8sa40slgw"),
      ("Input._multiShadowImportant", "_id_ygng1v", "_a_oe8sa4080o9"),
      ("Input._tabTextFirst", "_id_1a9oy2o", "_a_400ppg _a_h5nao400v5z"),
      (
        "Input._tabText",
        "_id_19zamun",
        "_a_4eyeca _a_qyw7u390004kqt8 _a_qyw7u40rvac",
      ),
      ("Input._sidebarClosed", "_id_1p5u6ax", ""),
      (
        "Input._sidebar",
        "_id_xlnwou",
        "_a_600002gxme _a_ekz5ec _a_dmsoaq _a_47xb18cym79 _a_47xb188qeme _a_47xb18mk2n6 _a_47xb18r57eg",
      ),
      ("Input._checkbox", "_id_iwstpv", "_a_oe8sadmq5th"),
      ("Input._transitions", "_id_1ckq7tk", "_a_dmm8mm"),
    ]
  ];
  [@css.blocks
    [
      (16, "_id_1u048gq", [10, 11]),
      (23, "_id_3dai6", [12]),
      (28, "_id_ygng1v", [13]),
      (34, "_id_1a9oy2o", [14, 15]),
      (47, "_id_19zamun", [16, 17, 18]),
      (61, "_id_1p5u6ax", []),
      (64, "_id_xlnwou", [19, 20, 21, 22, 23, 24, 25]),
      (79, "_id_iwstpv", [26]),
      (83, "_id_1ckq7tk", [27]),
    ]
  ];
  module Color = {
    module Border = {
      let line = `rgba((0, 0, 0, `num(0.1)));
    };
    module Text = {
      let tertiary = `hex("999999");
      let secondary = `hex("666666");
    };
    module Background = {
      let box_ = `hex("f0f0f0");
    };
  };
  
  let _spaceBeforeColon =
    CSS.make(
      "label:_spaceBeforeColon _id_1u048gq _a_eck09d _a_4e090v",
      [("--tertiary-1cttnp6", CSS.Types.Color.toString(Color.Text.tertiary))],
    );
  
  let _tabInnerFirst =
    CSS.make("label:_tabInnerFirst _id_3dai6 _a_oe8sa40slgw", []);
  
  let _multiShadowImportant =
    CSS.make(
      "label:_multiShadowImportant _id_ygng1v _a_oe8sa4080o9",
      [
        ("--line-9kmuhm_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-9kmuhm_2", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabTextFirst =
    CSS.make(
      "label:_tabTextFirst _id_1a9oy2o _a_400ppg _a_h5nao400v5z",
      [
        ("--line-1rsudnc_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-1rsudnc_2", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabText =
    CSS.make(
      "label:_tabText _id_19zamun _a_4eyeca _a_qyw7u390004kqt8 _a_qyw7u40rvac",
      [
        ("--secondary-hfvj8d", CSS.Types.Color.toString(Color.Text.secondary)),
        ("--box_-1n2q0et", CSS.Types.Color.toString(Color.Background.box_)),
        ("--line-3w1stm_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-3w1stm_2", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-3w1stm_3", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _sidebarClosed = CSS.make("label:_sidebarClosed _id_1p5u6ax", []);
  
  let _sidebar =
    CSS.make(
      "label:_sidebar _id_xlnwou _a_600002gxme _a_ekz5ec _a_dmsoaq _a_47xb18cym79 _a_47xb188qeme _a_47xb18mk2n6 _a_47xb18r57eg",
      [],
    );
  
  let _checkbox = CSS.make("label:_checkbox _id_iwstpv _a_oe8sadmq5th", []);
  
  let _transitions = CSS.make("label:_transitions _id_1ckq7tk _a_dmm8mm", []);
  
  let _shadow1: CSS.Shadow.t =
    CSS.Shadow.box(~blur=`px(100), `hex("000000"), ~inset=true);
  let _shadow2: array(CSS.Shadow.t) = [|
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`zero,
      ~blur=`px(4),
      `rgba((0, 0, 0, `num(0.1))),
    ),
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`px(6),
      ~blur=`px(15),
      `rgba((0, 0, 0, `num(0.2))),
    ),
  |];
