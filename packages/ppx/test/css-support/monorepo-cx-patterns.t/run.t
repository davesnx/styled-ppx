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
  [@css "@property --line-p27yoa_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-p27yoa_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-c1zhnk_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-c1zhnk_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --secondary-fn5pf1{syntax:\"*\";inherits:false;}"];
  [@css "@property --box_-1n37ehb{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-zrm9xj_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-zrm9xj_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-zrm9xj_3{syntax:\"*\";inherits:false;}"];
  [@css ".css-34k09d{width:30px;}"];
  [@css ".css-1cx090v{color:var(--tertiary-1cttnp6);}"];
  [@css ".css-qg0an3{box-shadow:inset 1px 0 0 0 transparent  !important;}"];
  [@css
    ".css-96uk0n{box-shadow:1px 0 0 0 var(--line-p27yoa_1), inset 0 -1px 0 0 var(--line-p27yoa_2)  !important;}"
  ];
  [@css ".css-1mx0ppg{box-shadow:inset 0 0 0 0 transparent;}"];
  [@css
    ".css-u38k1n:hover{box-shadow:1px 0 0 0 var(--line-c1zhnk_1), inset 0 -1px 0 0 var(--line-c1zhnk_2)  !important;}"
  ];
  [@css ".css-15h1qzw{color:var(--secondary-fn5pf1);}"];
  [@css ".css-15h1qzw:hover{background-color:var(--box_-1n37ehb);}"];
  [@css
    ".css-15h1qzw:hover{box-shadow:1px 0 0 0 var(--line-zrm9xj_1), inset 1px 0 0 0 var(--line-zrm9xj_2), inset 0 -1px 0 0 var(--line-zrm9xj_3) ;}"
  ];
  [@css ".css-i9gxme{flex-grow:1;}"];
  [@css ".css-r6z5ec{z-index:1;}"];
  [@css ".css-tjsoaq{transition:all 200ms ease 0ms;}"];
  [@css ".css-145l4ca.cid-1wtohw8{min-width:0;}"];
  [@css ".css-1oluo0q.cid-1wtohw8{max-width:0;}"];
  [@css ".css-2io1ml.cid-1wtohw8{opacity:0;}"];
  [@css ".css-1k938xr.cid-1wtohw8{overflow:hidden;}"];
  [@css ".css-1vsc0qv{transition:transform 0.3s  !important;}"];
  [@css
    ".css-1hwm8mm{transition:opacity 0.2s ease-in-out, visibility 0.2s ease-in-out;}"
  ];
  [@css.bindings
    [
      ("Input._spaceBeforeColon", "cid-pwoumt", "css-34k09d css-1cx090v"),
      ("Input._tabInnerFirst", "cid-110u1xw", "css-qg0an3"),
      ("Input._multiShadowImportant", "cid-c7rk0r", "css-96uk0n"),
      ("Input._tabTextFirst", "cid-19955vg", "css-1mx0ppg css-u38k1n"),
      ("Input._tabText", "cid-e443o3", "css-15h1qzw"),
      ("Input._sidebarClosed", "cid-1wtohw8", ""),
      (
        "Input._sidebar",
        "cid-jjvyqu",
        "css-i9gxme css-r6z5ec css-tjsoaq css-145l4ca css-1oluo0q css-2io1ml css-1k938xr",
      ),
      ("Input._checkbox", "cid-1sltg0l", "css-1vsc0qv"),
      ("Input._transitions", "cid-1jxvvla", "css-1hwm8mm"),
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
      ~label="_spaceBeforeColon",
      "cid-pwoumt css-34k09d css-1cx090v",
      [("--tertiary-1cttnp6", CSS.Types.Color.toString(Color.Text.tertiary))],
    );
  
  let _tabInnerFirst =
    CSS.make(~label="_tabInnerFirst", "cid-110u1xw css-qg0an3", []);
  
  let _multiShadowImportant =
    CSS.make(
      ~label="_multiShadowImportant",
      "cid-c7rk0r css-96uk0n",
      [
        ("--line-p27yoa_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-p27yoa_2", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabTextFirst =
    CSS.make(
      ~label="_tabTextFirst",
      "cid-19955vg css-1mx0ppg css-u38k1n",
      [
        ("--line-c1zhnk_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-c1zhnk_2", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabText =
    CSS.make(
      ~label="_tabText",
      "cid-e443o3 css-15h1qzw",
      [
        ("--secondary-fn5pf1", CSS.Types.Color.toString(Color.Text.secondary)),
        ("--box_-1n37ehb", CSS.Types.Color.toString(Color.Background.box_)),
        ("--line-zrm9xj_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-zrm9xj_2", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-zrm9xj_3", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _sidebarClosed = CSS.make(~label="_sidebarClosed", "cid-1wtohw8", []);
  
  let _sidebar =
    CSS.make(
      ~label="_sidebar",
      "cid-jjvyqu css-i9gxme css-r6z5ec css-tjsoaq css-145l4ca css-1oluo0q css-2io1ml css-1k938xr",
      [],
    );
  
  let _checkbox = CSS.make(~label="_checkbox", "cid-1sltg0l css-1vsc0qv", []);
  
  let _transitions =
    CSS.make(~label="_transitions", "cid-1jxvvla css-1hwm8mm", []);
  
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
