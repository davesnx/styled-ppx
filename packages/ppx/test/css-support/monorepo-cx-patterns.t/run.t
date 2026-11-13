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
  [@css "@property --bp7234-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --pe0mgz-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --pe0mgz-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --1l8t7ng-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1l8t7ng-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --hq5btn-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --hq5btn-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --hq5btn-2{syntax:\"*\";inherits:false;}"];
  [@css "@property --hq5btn-3{syntax:\"*\";inherits:false;}"];
  [@css "@property --hq5btn-4{syntax:\"*\";inherits:false;}"];
  [@css ".css-bp7234{width:30px;color:var(--bp7234-0);}"];
  [@css ".css-mmm3yg{box-shadow:inset 1px 0 0 0 transparent !important;}"];
  [@css
    ".css-pe0mgz{box-shadow:1px 0 0 0 var(--pe0mgz-0), inset 0 -1px 0 0 var(--pe0mgz-1) !important;}"
  ];
  [@css
    ".css-1l8t7ng{box-shadow:inset 0 0 0 0 transparent;}.css-1l8t7ng:hover{box-shadow:1px 0 0 0 var(--1l8t7ng-0), inset 0 -1px 0 0 var(--1l8t7ng-1) !important;}"
  ];
  [@css
    ".css-hq5btn{color:var(--hq5btn-0);}.css-hq5btn:hover{background-color:var(--hq5btn-1);box-shadow:1px 0 0 0 var(--hq5btn-2), inset 1px 0 0 0 var(--hq5btn-3), inset 0 -1px 0 0 var(--hq5btn-4);}"
  ];
  [@css
    ".css-1gnrrrr{flex-grow:1;z-index:1;transition:all 200ms ease 0ms;}.css-1gnrrrr.css-1q3icse{min-width:0;max-width:0;opacity:0;overflow:hidden;}"
  ];
  [@css ".css-1cf959i{transition:transform 0.3s !important;}"];
  [@css
    ".css-lq61rf{transition:opacity 0.2s ease-in-out, visibility 0.2s ease-in-out;}"
  ];
  [@css.classes
    [
      ("css-bp7234", 10, "Input._spaceBeforeColon", "input.re", 17, 2, 19, 0),
      ("css-mmm3yg", 11, "Input._tabInnerFirst", "input.re", 24, 2, 25, 0),
      (
        "css-pe0mgz",
        12,
        "Input._multiShadowImportant",
        "input.re",
        29,
        2,
        30,
        0,
      ),
      ("css-1l8t7ng", 13, "Input._tabTextFirst", "input.re", 35, 2, 42, 0),
      ("css-hq5btn", 14, "Input._tabText", "input.re", 48, 2, 57, 0),
      ("css-1gnrrrr", 15, "Input._sidebar", "input.re", 65, 2, 75, 0),
      ("css-1cf959i", 16, "Input._checkbox", "input.re", 79, 24, 79, 62),
      ("css-lq61rf", 17, "Input._transitions", "input.re", 84, 2, 85, 0),
    ]
  ];
  [@css.bindings
    [
      ("Input._spaceBeforeColon", "css-bp7234"),
      ("Input._tabInnerFirst", "css-mmm3yg"),
      ("Input._multiShadowImportant", "css-pe0mgz"),
      ("Input._tabTextFirst", "css-1l8t7ng"),
      ("Input._tabText", "css-hq5btn"),
      ("Input._sidebarClosed", "css-1q3icse"),
      ("Input._sidebar", "css-1gnrrrr"),
      ("Input._checkbox", "css-1cf959i"),
      ("Input._transitions", "css-lq61rf"),
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
      "css-bp7234",
      [("--bp7234-0", CSS.Types.Color.toString(Color.Text.tertiary))],
    );
  
  let _tabInnerFirst = CSS.make("css-mmm3yg", []);
  
  let _multiShadowImportant =
    CSS.make(
      "css-pe0mgz",
      [
        ("--pe0mgz-0", CSS.Types.Color.toString(Color.Border.line)),
        ("--pe0mgz-1", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabTextFirst =
    CSS.make(
      "css-1l8t7ng",
      [
        ("--1l8t7ng-0", CSS.Types.Color.toString(Color.Border.line)),
        ("--1l8t7ng-1", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabText =
    CSS.make(
      "css-hq5btn",
      [
        ("--hq5btn-0", CSS.Types.Color.toString(Color.Text.secondary)),
        ("--hq5btn-1", CSS.Types.Color.toString(Color.Background.box_)),
        ("--hq5btn-2", CSS.Types.Color.toString(Color.Border.line)),
        ("--hq5btn-3", CSS.Types.Color.toString(Color.Border.line)),
        ("--hq5btn-4", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _sidebarClosed = CSS.make("css-1q3icse", []);
  
  let _sidebar = CSS.make("css-1gnrrrr", []);
  
  let _checkbox = CSS.make("css-1cf959i", []);
  
  let _transitions = CSS.make("css-lq61rf", []);
  
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
