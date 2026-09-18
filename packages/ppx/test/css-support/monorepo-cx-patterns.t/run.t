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
  [@css "@property --line-k71me3_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-k71me3_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-10vn3j5_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-10vn3j5_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --secondary-o4hg5w{syntax:\"*\";inherits:false;}"];
  [@css "@property --box_-9z75f2{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-bf7785_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-bf7785_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-bf7785_3{syntax:\"*\";inherits:false;}"];
  [@css ".css-34k09d-_spaceBeforeColon{width:30px}"];
  [@css ".css-1cx090v-_spaceBeforeColon{color:var(--tertiary-1cttnp6)}"];
  [@css
    ".css-1imssjd-_tabInnerFirst{box-shadow:inset 1px 0 0 0 transparent!important}"
  ];
  [@css
    ".css-cyxgg6-_multiShadowImportant{box-shadow:1px 0 0 0 var(--line-k71me3_1),inset 0 -1px 0 0 var(--line-k71me3_2)!important}"
  ];
  [@css ".css-1mx0ppg-_tabTextFirst{box-shadow:inset 0 0 0 0 transparent}"];
  [@css
    ".css-1u8ytlu-_tabTextFirst:hover{box-shadow:1px 0 0 0 var(--line-10vn3j5_1),inset 0 -1px 0 0 var(--line-10vn3j5_2)!important}"
  ];
  [@css ".css-vgzemp-_tabText{color:var(--secondary-o4hg5w)}"];
  [@css ".css-vgzemp-_tabText:hover{background-color:var(--box_-9z75f2)}"];
  [@css
    ".css-vgzemp-_tabText:hover{box-shadow:1px 0 0 0 var(--line-bf7785_1),inset 1px 0 0 0 var(--line-bf7785_2),inset 0 -1px 0 0 var(--line-bf7785_3)}"
  ];
  [@css ".css-i9gxme-_sidebar{flex-grow:1}"];
  [@css ".css-r6z5ec-_sidebar{z-index:1}"];
  [@css ".css-tjsoaq-_sidebar{transition:all 200ms ease 0ms}"];
  [@css ".css-yuyqnp-_sidebar.css-0-_sidebarClosed{min-width:0}"];
  [@css ".css-1xgmh5v-_sidebar.css-0-_sidebarClosed{max-width:0}"];
  [@css ".css-1qk9jar-_sidebar.css-0-_sidebarClosed{opacity:0}"];
  [@css ".css-14jsytz-_sidebar.css-0-_sidebarClosed{overflow:hidden}"];
  [@css ".css-7e6ar4-_checkbox{transition:transform 0.3s!important}"];
  [@css
    ".css-23e693-_transitions{transition:opacity 0.2s ease-in-out,visibility 0.2s ease-in-out}"
  ];
  [@css.bindings
    [
      (
        "Input._spaceBeforeColon",
        "css-34k09d-_spaceBeforeColon css-1cx090v-_spaceBeforeColon",
      ),
      ("Input._tabInnerFirst", "css-1imssjd-_tabInnerFirst"),
      ("Input._multiShadowImportant", "css-cyxgg6-_multiShadowImportant"),
      (
        "Input._tabTextFirst",
        "css-1mx0ppg-_tabTextFirst css-1u8ytlu-_tabTextFirst",
      ),
      ("Input._tabText", "css-vgzemp-_tabText"),
      ("Input._sidebarClosed", "css-0-_sidebarClosed"),
      (
        "Input._sidebar",
        "css-i9gxme-_sidebar css-r6z5ec-_sidebar css-tjsoaq-_sidebar css-yuyqnp-_sidebar css-1xgmh5v-_sidebar css-1qk9jar-_sidebar css-14jsytz-_sidebar",
      ),
      ("Input._checkbox", "css-7e6ar4-_checkbox"),
      ("Input._transitions", "css-23e693-_transitions"),
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
      "css-34k09d-_spaceBeforeColon css-1cx090v-_spaceBeforeColon",
      [("--tertiary-1cttnp6", CSS.Types.Color.toString(Color.Text.tertiary))],
    );
  
  let _tabInnerFirst = CSS.make("css-1imssjd-_tabInnerFirst", []);
  
  let _multiShadowImportant =
    CSS.make(
      "css-cyxgg6-_multiShadowImportant",
      [
        ("--line-k71me3_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-k71me3_2", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabTextFirst =
    CSS.make(
      "css-1mx0ppg-_tabTextFirst css-1u8ytlu-_tabTextFirst",
      [
        ("--line-10vn3j5_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-10vn3j5_2", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabText =
    CSS.make(
      "css-vgzemp-_tabText",
      [
        ("--secondary-o4hg5w", CSS.Types.Color.toString(Color.Text.secondary)),
        ("--box_-9z75f2", CSS.Types.Color.toString(Color.Background.box_)),
        ("--line-bf7785_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-bf7785_2", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-bf7785_3", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _sidebarClosed = CSS.make("css-0-_sidebarClosed", []);
  
  let _sidebar =
    CSS.make(
      "css-i9gxme-_sidebar css-r6z5ec-_sidebar css-tjsoaq-_sidebar css-yuyqnp-_sidebar css-1xgmh5v-_sidebar css-1qk9jar-_sidebar css-14jsytz-_sidebar",
      [],
    );
  
  let _checkbox = CSS.make("css-7e6ar4-_checkbox", []);
  
  let _transitions = CSS.make("css-23e693-_transitions", []);
  
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
