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
  [@css "._a_eck09d{width:30px;}"];
  [@css "._a_4e090v{color:var(--tertiary-1cttnp6);}"];
  [@css "._a_oe8sa40slgw{box-shadow:inset 1px 0 0 0 transparent !important;}"];
  [@css
    "._a_oe8sa4080o9{box-shadow:1px 0 0 0 var(--line-9kmuhm_1), inset 0 -1px 0 0 var(--line-9kmuhm_2) !important;}"
  ];
  [@css "._a_400ppg{box-shadow:inset 0 0 0 0 transparent;}"];
  [@css
    "._a_h5nao400v5z:hover{box-shadow:1px 0 0 0 var(--line-1rsudnc_1), inset 0 -1px 0 0 var(--line-1rsudnc_2) !important;}"
  ];
  [@css "._a_4eyeca{color:var(--secondary-hfvj8d);}"];
  [@css "._a_qyw7u39004kqt8:hover{background-color:var(--box_-1n2q0et);}"];
  [@css
    "._a_qyw7u40rvac:hover{box-shadow:1px 0 0 0 var(--line-3w1stm_1), inset 1px 0 0 0 var(--line-3w1stm_2), inset 0 -1px 0 0 var(--line-3w1stm_3);}"
  ];
  [@css "._a_60002gxme{flex-grow:1;}"];
  [@css "._a_ekz5ec{z-index:1;}"];
  [@css "._a_dmsoaq{transition:all 200ms ease 0ms;}"];
  [@css "._a_y4vkx8cytek._id_1wtohw8{min-width:0;}"];
  [@css "._a_y4vkx88twos._id_1wtohw8{max-width:0;}"];
  [@css "._a_y4vkx8mm5d1._id_1wtohw8{opacity:0;}"];
  [@css "._a_y4vkx8r3w86._id_1wtohw8{overflow:hidden;}"];
  [@css "._a_oe8sadmq5th{transition:transform 0.3s !important;}"];
  [@css
    "._a_dmm8mm{transition:opacity 0.2s ease-in-out, visibility 0.2s ease-in-out;}"
  ];
  [@css.bindings
    [
      ("Input._spaceBeforeColon", "_id_pwoumt", "_a_eck09d _a_4e090v"),
      ("Input._tabInnerFirst", "_id_110u1xw", "_a_oe8sa40slgw"),
      ("Input._multiShadowImportant", "_id_c7rk0r", "_a_oe8sa4080o9"),
      ("Input._tabTextFirst", "_id_19955vg", "_a_400ppg _a_h5nao400v5z"),
      (
        "Input._tabText",
        "_id_e443o3",
        "_a_4eyeca _a_qyw7u39004kqt8 _a_qyw7u40rvac",
      ),
      ("Input._sidebarClosed", "_id_1wtohw8", ""),
      (
        "Input._sidebar",
        "_id_jjvyqu",
        "_a_60002gxme _a_ekz5ec _a_dmsoaq _a_y4vkx8cytek _a_y4vkx88twos _a_y4vkx8mm5d1 _a_y4vkx8r3w86",
      ),
      ("Input._checkbox", "_id_1sltg0l", "_a_oe8sadmq5th"),
      ("Input._transitions", "_id_1jxvvla", "_a_dmm8mm"),
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
      "label:_spaceBeforeColon _id_pwoumt _a_eck09d _a_4e090v",
      [("--tertiary-1cttnp6", CSS.Types.Color.toString(Color.Text.tertiary))],
    );
  
  let _tabInnerFirst =
    CSS.make("label:_tabInnerFirst _id_110u1xw _a_oe8sa40slgw", []);
  
  let _multiShadowImportant =
    CSS.make(
      "label:_multiShadowImportant _id_c7rk0r _a_oe8sa4080o9",
      [
        ("--line-9kmuhm_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-9kmuhm_2", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabTextFirst =
    CSS.make(
      "label:_tabTextFirst _id_19955vg _a_400ppg _a_h5nao400v5z",
      [
        ("--line-1rsudnc_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-1rsudnc_2", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabText =
    CSS.make(
      "label:_tabText _id_e443o3 _a_4eyeca _a_qyw7u39004kqt8 _a_qyw7u40rvac",
      [
        ("--secondary-hfvj8d", CSS.Types.Color.toString(Color.Text.secondary)),
        ("--box_-1n2q0et", CSS.Types.Color.toString(Color.Background.box_)),
        ("--line-3w1stm_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-3w1stm_2", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-3w1stm_3", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _sidebarClosed = CSS.make("label:_sidebarClosed _id_1wtohw8", []);
  
  let _sidebar =
    CSS.make(
      "label:_sidebar _id_jjvyqu _a_60002gxme _a_ekz5ec _a_dmsoaq _a_y4vkx8cytek _a_y4vkx88twos _a_y4vkx8mm5d1 _a_y4vkx8r3w86",
      [],
    );
  
  let _checkbox = CSS.make("label:_checkbox _id_1sltg0l _a_oe8sadmq5th", []);
  
  let _transitions = CSS.make("label:_transitions _id_1jxvvla _a_dmm8mm", []);
  
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
