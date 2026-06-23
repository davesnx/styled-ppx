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
  [@css ".css-34k09d-_spaceBeforeColon{width:30px;}"];
  [@css ".css-1cx090v-_spaceBeforeColon{color:var(--tertiary-1cttnp6);}"];
  [@css
    ".css-qg0an3-_tabInnerFirst{box-shadow:inset 1px 0 0 0 transparent  !important;}"
  ];
  [@css
    ".css-96uk0n-_multiShadowImportant{box-shadow:1px 0 0 0 var(--line-p27yoa_1), inset 0 -1px 0 0 var(--line-p27yoa_2)  !important;}"
  ];
  [@css ".css-1mx0ppg-_tabTextFirst{box-shadow:inset 0 0 0 0 transparent;}"];
  [@css
    ".css-u38k1n-_tabTextFirst:hover{box-shadow:1px 0 0 0 var(--line-c1zhnk_1), inset 0 -1px 0 0 var(--line-c1zhnk_2)  !important;}"
  ];
  [@css ".css-15h1qzw-_tabText{color:var(--secondary-fn5pf1);}"];
  [@css ".css-15h1qzw-_tabText:hover{background-color:var(--box_-1n37ehb);}"];
  [@css
    ".css-15h1qzw-_tabText:hover{box-shadow:1px 0 0 0 var(--line-zrm9xj_1), inset 1px 0 0 0 var(--line-zrm9xj_2), inset 0 -1px 0 0 var(--line-zrm9xj_3) ;}"
  ];
  [@css ".css-i9gxme-_sidebar{flex-grow:1;}"];
  [@css ".css-r6z5ec-_sidebar{z-index:1;}"];
  [@css ".css-tjsoaq-_sidebar{transition:all 200ms ease 0ms;}"];
  [@css ".css-145l4ca-_sidebar.css-0-_sidebarClosed{min-width:0;}"];
  [@css ".css-1oluo0q-_sidebar.css-0-_sidebarClosed{max-width:0;}"];
  [@css ".css-2io1ml-_sidebar.css-0-_sidebarClosed{opacity:0;}"];
  [@css ".css-1k938xr-_sidebar.css-0-_sidebarClosed{overflow:hidden;}"];
  [@css ".css-1vsc0qv-_checkbox{transition:transform 0.3s  !important;}"];
  [@css
    ".css-1hwm8mm-_transitions{transition:opacity 0.2s ease-in-out, visibility 0.2s ease-in-out;}"
  ];
  [@css.bindings
    [
      (
        "Input._spaceBeforeColon",
        "css-34k09d-_spaceBeforeColon css-1cx090v-_spaceBeforeColon",
      ),
      ("Input._tabInnerFirst", "css-qg0an3-_tabInnerFirst"),
      ("Input._multiShadowImportant", "css-96uk0n-_multiShadowImportant"),
      (
        "Input._tabTextFirst",
        "css-1mx0ppg-_tabTextFirst css-u38k1n-_tabTextFirst",
      ),
      ("Input._tabText", "css-15h1qzw-_tabText"),
      ("Input._sidebarClosed", "css-0-_sidebarClosed"),
      (
        "Input._sidebar",
        "css-i9gxme-_sidebar css-r6z5ec-_sidebar css-tjsoaq-_sidebar css-145l4ca-_sidebar css-1oluo0q-_sidebar css-2io1ml-_sidebar css-1k938xr-_sidebar",
      ),
      ("Input._checkbox", "css-1vsc0qv-_checkbox"),
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
  
  let _tabInnerFirst = CSS.make("css-qg0an3-_tabInnerFirst", []);
  
  let _multiShadowImportant =
    CSS.make(
      "css-96uk0n-_multiShadowImportant",
      [
        ("--line-p27yoa_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-p27yoa_2", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabTextFirst =
    CSS.make(
      "css-1mx0ppg-_tabTextFirst css-u38k1n-_tabTextFirst",
      [
        ("--line-c1zhnk_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-c1zhnk_2", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabText =
    CSS.make(
      "css-15h1qzw-_tabText",
      [
        ("--secondary-fn5pf1", CSS.Types.Color.toString(Color.Text.secondary)),
        ("--box_-1n37ehb", CSS.Types.Color.toString(Color.Background.box_)),
        ("--line-zrm9xj_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-zrm9xj_2", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-zrm9xj_3", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _sidebarClosed = CSS.make("css-0-_sidebarClosed", []);
  
  let _sidebar =
    CSS.make(
      "css-i9gxme-_sidebar css-r6z5ec-_sidebar css-tjsoaq-_sidebar css-145l4ca-_sidebar css-1oluo0q-_sidebar css-2io1ml-_sidebar css-1k938xr-_sidebar",
      [],
    );
  
  let _checkbox = CSS.make("css-1vsc0qv-_checkbox", []);
  
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
