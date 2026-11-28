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
  [@css "@property --ivpceve{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc3pw{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpchkf{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc1yc{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcbgi{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcqsn{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcgn9{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcfql{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcx4u{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcvu4{syntax:\"*\";inherits:false;}"];
  [@css ".css-ivpctav{width:30px;color:var(--ivpceve);}"];
  [@css ".css-ivpc3yg{box-shadow:inset 1px 0 0 0 transparent !important;}"];
  [@css
    ".css-ivpc5k4{box-shadow:1px 0 0 0 var(--ivpc3pw), inset 0 -1px 0 0 var(--ivpchkf) !important;}"
  ];
  [@css
    ".css-ivpclc4{box-shadow:inset 0 0 0 0 transparent;}.css-ivpclc4:hover{box-shadow:1px 0 0 0 var(--ivpc1yc), inset 0 -1px 0 0 var(--ivpcbgi) !important;}"
  ];
  [@css
    ".css-ivpcf9k{color:var(--ivpcqsn);}.css-ivpcf9k:hover{background-color:var(--ivpcgn9);box-shadow:1px 0 0 0 var(--ivpcfql), inset 1px 0 0 0 var(--ivpcx4u), inset 0 -1px 0 0 var(--ivpcvu4);}"
  ];
  [@css
    ".css-ivpcm6e{flex-grow:1;z-index:1;transition:all 200ms ease 0ms;}.css-ivpcm6e.css-ivpccse{min-width:0;max-width:0;opacity:0;overflow:hidden;}"
  ];
  [@css ".css-ivpc59i{transition:transform 0.3s !important;}"];
  [@css
    ".css-ivpc1rf{transition:opacity 0.2s ease-in-out, visibility 0.2s ease-in-out;}"
  ];
  [@css.classes
    [
      ("css-ivpctav", 10, "Input._spaceBeforeColon", "input.re", 17, 2, 19, 0),
      ("css-ivpc3yg", 11, "Input._tabInnerFirst", "input.re", 24, 2, 25, 0),
      (
        "css-ivpc5k4",
        12,
        "Input._multiShadowImportant",
        "input.re",
        29,
        2,
        30,
        0,
      ),
      ("css-ivpclc4", 13, "Input._tabTextFirst", "input.re", 35, 2, 42, 0),
      ("css-ivpcf9k", 14, "Input._tabText", "input.re", 48, 2, 57, 0),
      ("css-ivpccse", (-1), "Input._sidebarClosed", "input.re", 61, 28, 61, 28),
      ("css-ivpcm6e", 15, "Input._sidebar", "input.re", 65, 2, 75, 0),
      ("css-ivpc59i", 16, "Input._checkbox", "input.re", 79, 24, 79, 62),
      ("css-ivpc1rf", 17, "Input._transitions", "input.re", 84, 2, 85, 0),
    ]
  ];
  [@css.bindings
    [
      ("Input._spaceBeforeColon", "css-ivpctav"),
      ("Input._tabInnerFirst", "css-ivpc3yg"),
      ("Input._multiShadowImportant", "css-ivpc5k4"),
      ("Input._tabTextFirst", "css-ivpclc4"),
      ("Input._tabText", "css-ivpcf9k"),
      ("Input._sidebarClosed", "css-ivpccse"),
      ("Input._sidebar", "css-ivpcm6e"),
      ("Input._checkbox", "css-ivpc59i"),
      ("Input._transitions", "css-ivpc1rf"),
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
      "css-ivpctav",
      [("--ivpceve", CSS.Types.Color.toString(Color.Text.tertiary))],
    );
  
  let _tabInnerFirst = CSS.make("css-ivpc3yg", []);
  
  let _multiShadowImportant =
    CSS.make(
      "css-ivpc5k4",
      [
        ("--ivpc3pw", CSS.Types.Color.toString(Color.Border.line)),
        ("--ivpchkf", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabTextFirst =
    CSS.make(
      "css-ivpclc4",
      [
        ("--ivpc1yc", CSS.Types.Color.toString(Color.Border.line)),
        ("--ivpcbgi", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabText =
    CSS.make(
      "css-ivpcf9k",
      [
        ("--ivpcqsn", CSS.Types.Color.toString(Color.Text.secondary)),
        ("--ivpcgn9", CSS.Types.Color.toString(Color.Background.box_)),
        ("--ivpcfql", CSS.Types.Color.toString(Color.Border.line)),
        ("--ivpcx4u", CSS.Types.Color.toString(Color.Border.line)),
        ("--ivpcvu4", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _sidebarClosed = CSS.make("css-ivpccse", []);
  
  let _sidebar = CSS.make("css-ivpcm6e", []);
  
  let _checkbox = CSS.make("css-ivpc59i", []);
  
  let _transitions = CSS.make("css-ivpc1rf", []);
  
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
