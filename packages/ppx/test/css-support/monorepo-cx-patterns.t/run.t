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
  [@css "@property --secondary-16kletf{syntax:\"*\";inherits:false;}"];
  [@css "@property --box_-vdb5xj{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-e0dy15_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-e0dy15_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-e0dy15_3{syntax:\"*\";inherits:false;}"];
  [@css ".a-eck09d{width:30px;}"];
  [@css ".a-4e090v{color:var(--tertiary-1cttnp6);}"];
  [@css ".a-oe8sa40slgw{box-shadow:inset 1px 0 0 0 transparent !important;}"];
  [@css
    ".a-oe8sa4080o9{box-shadow:1px 0 0 0 var(--line-9kmuhm_1), inset 0 -1px 0 0 var(--line-9kmuhm_2) !important;}"
  ];
  [@css ".a-400ppg{box-shadow:inset 0 0 0 0 transparent;}"];
  [@css
    ".a-h5nao400v5z:hover{box-shadow:1px 0 0 0 var(--line-1rsudnc_1), inset 0 -1px 0 0 var(--line-1rsudnc_2) !important;}"
  ];
  [@css ".in-1nzxk4v{color:var(--secondary-16kletf);}"];
  [@css ".in-1nzxk4v:hover{background-color:var(--box_-vdb5xj);}"];
  [@css
    ".in-1nzxk4v:hover{box-shadow:1px 0 0 0 var(--line-e0dy15_1), inset 1px 0 0 0 var(--line-e0dy15_2), inset 0 -1px 0 0 var(--line-e0dy15_3);}"
  ];
  [@css ".a-60002gxme{flex-grow:1;}"];
  [@css ".a-ekz5ec{z-index:1;}"];
  [@css ".a-dmsoaq{transition:all 200ms ease 0ms;}"];
  [@css ".a-qpfuu8c5z1r.id-1wtohw8{min-width:0;}"];
  [@css ".a-qpfuu88sfs8.id-1wtohw8{max-width:0;}"];
  [@css ".a-qpfuu8mluc1.id-1wtohw8{opacity:0;}"];
  [@css ".a-qpfuu8r2pa5.id-1wtohw8{overflow:hidden;}"];
  [@css ".a-oe8sadmq5th{transition:transform 0.3s !important;}"];
  [@css
    ".a-dmm8mm{transition:opacity 0.2s ease-in-out, visibility 0.2s ease-in-out;}"
  ];
  [@css.bindings
    [
      ("Input._spaceBeforeColon", "id-pwoumt", "a-eck09d a-4e090v"),
      ("Input._tabInnerFirst", "id-110u1xw", "a-oe8sa40slgw"),
      ("Input._multiShadowImportant", "id-c7rk0r", "a-oe8sa4080o9"),
      ("Input._tabTextFirst", "id-19955vg", "a-400ppg a-h5nao400v5z"),
      ("Input._tabText", "id-e443o3", "in-1nzxk4v"),
      ("Input._sidebarClosed", "id-1wtohw8", ""),
      (
        "Input._sidebar",
        "id-jjvyqu",
        "a-60002gxme a-ekz5ec a-dmsoaq a-qpfuu8c5z1r a-qpfuu88sfs8 a-qpfuu8mluc1 a-qpfuu8r2pa5",
      ),
      ("Input._checkbox", "id-1sltg0l", "a-oe8sadmq5th"),
      ("Input._transitions", "id-1jxvvla", "a-dmm8mm"),
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
      "label:_spaceBeforeColon id-pwoumt a-eck09d a-4e090v",
      [("--tertiary-1cttnp6", CSS.Types.Color.toString(Color.Text.tertiary))],
    );
  
  let _tabInnerFirst =
    CSS.make("label:_tabInnerFirst id-110u1xw a-oe8sa40slgw", []);
  
  let _multiShadowImportant =
    CSS.make(
      "label:_multiShadowImportant id-c7rk0r a-oe8sa4080o9",
      [
        ("--line-9kmuhm_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-9kmuhm_2", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabTextFirst =
    CSS.make(
      "label:_tabTextFirst id-19955vg a-400ppg a-h5nao400v5z",
      [
        ("--line-1rsudnc_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-1rsudnc_2", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabText =
    CSS.make(
      "label:_tabText id-e443o3 in-1nzxk4v",
      [
        ("--secondary-16kletf", CSS.Types.Color.toString(Color.Text.secondary)),
        ("--box_-vdb5xj", CSS.Types.Color.toString(Color.Background.box_)),
        ("--line-e0dy15_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-e0dy15_2", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-e0dy15_3", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _sidebarClosed = CSS.make("label:_sidebarClosed id-1wtohw8", []);
  
  let _sidebar =
    CSS.make(
      "label:_sidebar id-jjvyqu a-60002gxme a-ekz5ec a-dmsoaq a-qpfuu8c5z1r a-qpfuu88sfs8 a-qpfuu8mluc1 a-qpfuu8r2pa5",
      [],
    );
  
  let _checkbox = CSS.make("label:_checkbox id-1sltg0l a-oe8sadmq5th", []);
  
  let _transitions = CSS.make("label:_transitions id-1jxvvla a-dmm8mm", []);
  
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
