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
  [@css ".css-34k09d-_spaceBeforeColon{width:30px;}"];
  [@css ".css-1cx090v-_spaceBeforeColon{color:var(--tertiary-1cttnp6);}"];
  [@css
    ".css-t2slgw-_tabInnerFirst{box-shadow:inset 1px 0 0 0 transparent !important;}"
  ];
  [@css
    ".css-1rh80o9-_multiShadowImportant{box-shadow:1px 0 0 0 var(--line-9kmuhm_1), inset 0 -1px 0 0 var(--line-9kmuhm_2) !important;}"
  ];
  [@css ".css-1mx0ppg-_tabTextFirst{box-shadow:inset 0 0 0 0 transparent;}"];
  [@css
    ".css-1bp0v5z-_tabTextFirst:hover{box-shadow:1px 0 0 0 var(--line-1rsudnc_1), inset 0 -1px 0 0 var(--line-1rsudnc_2) !important;}"
  ];
  [@css ".css-1nzxk4v-_tabText{color:var(--secondary-16kletf);}"];
  [@css ".css-1nzxk4v-_tabText:hover{background-color:var(--box_-vdb5xj);}"];
  [@css
    ".css-1nzxk4v-_tabText:hover{box-shadow:1px 0 0 0 var(--line-e0dy15_1), inset 1px 0 0 0 var(--line-e0dy15_2), inset 0 -1px 0 0 var(--line-e0dy15_3);}"
  ];
  [@css ".css-i9gxme-_sidebar{flex-grow:1;}"];
  [@css ".css-r6z5ec-_sidebar{z-index:1;}"];
  [@css ".css-tjsoaq-_sidebar{transition:all 200ms ease 0ms;}"];
  [@css ".css-145l4ca-_sidebar.css-0-_sidebarClosed{min-width:0;}"];
  [@css ".css-1oluo0q-_sidebar.css-0-_sidebarClosed{max-width:0;}"];
  [@css ".css-2io1ml-_sidebar.css-0-_sidebarClosed{opacity:0;}"];
  [@css ".css-1k938xr-_sidebar.css-0-_sidebarClosed{overflow:hidden;}"];
  [@css ".css-keq5th-_checkbox{transition:transform 0.3s !important;}"];
  [@css
    ".css-1hwm8mm-_transitions{transition:opacity 0.2s ease-in-out, visibility 0.2s ease-in-out;}"
  ];
  [@css.bindings
    [
      (
        "Input._spaceBeforeColon",
        "css-34k09d-_spaceBeforeColon css-1cx090v-_spaceBeforeColon",
      ),
      ("Input._tabInnerFirst", "css-t2slgw-_tabInnerFirst"),
      ("Input._multiShadowImportant", "css-1rh80o9-_multiShadowImportant"),
      (
        "Input._tabTextFirst",
        "css-1mx0ppg-_tabTextFirst css-1bp0v5z-_tabTextFirst",
      ),
      ("Input._tabText", "css-1nzxk4v-_tabText"),
      ("Input._sidebarClosed", "css-0-_sidebarClosed"),
      (
        "Input._sidebar",
        "css-i9gxme-_sidebar css-r6z5ec-_sidebar css-tjsoaq-_sidebar css-145l4ca-_sidebar css-1oluo0q-_sidebar css-2io1ml-_sidebar css-1k938xr-_sidebar",
      ),
      ("Input._checkbox", "css-keq5th-_checkbox"),
      ("Input._transitions", "css-1hwm8mm-_transitions"),
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
  
  let _tabInnerFirst = CSS.make("css-t2slgw-_tabInnerFirst", []);
  
  let _multiShadowImportant =
    CSS.make(
      "css-1rh80o9-_multiShadowImportant",
      [
        ("--line-9kmuhm_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-9kmuhm_2", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabTextFirst =
    CSS.make(
      "css-1mx0ppg-_tabTextFirst css-1bp0v5z-_tabTextFirst",
      [
        ("--line-1rsudnc_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-1rsudnc_2", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabText =
    CSS.make(
      "css-1nzxk4v-_tabText",
      [
        ("--secondary-16kletf", CSS.Types.Color.toString(Color.Text.secondary)),
        ("--box_-vdb5xj", CSS.Types.Color.toString(Color.Background.box_)),
        ("--line-e0dy15_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-e0dy15_2", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-e0dy15_3", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _sidebarClosed = CSS.make("css-0-_sidebarClosed", []);
  
  let _sidebar =
    CSS.make(
      "css-i9gxme-_sidebar css-r6z5ec-_sidebar css-tjsoaq-_sidebar css-145l4ca-_sidebar css-1oluo0q-_sidebar css-2io1ml-_sidebar css-1k938xr-_sidebar",
      [],
    );
  
  let _checkbox = CSS.make("css-keq5th-_checkbox", []);
  
  let _transitions = CSS.make("css-1hwm8mm-_transitions", []);
  
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
