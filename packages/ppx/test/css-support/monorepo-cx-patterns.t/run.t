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
  [@css ".css-34k09d{width:30px;}"];
  [@css ".csv-1cx090v{color:var(--tertiary-1cttnp6);}"];
  [@css ".css-t2slgw{box-shadow:inset 1px 0 0 0 transparent !important;}"];
  [@css
    ".csv-1rh80o9{box-shadow:1px 0 0 0 var(--line-9kmuhm_1), inset 0 -1px 0 0 var(--line-9kmuhm_2) !important;}"
  ];
  [@css ".css-1mx0ppg{box-shadow:inset 0 0 0 0 transparent;}"];
  [@css
    ".csv-1bp0v5z:hover{box-shadow:1px 0 0 0 var(--line-1rsudnc_1), inset 0 -1px 0 0 var(--line-1rsudnc_2) !important;}"
  ];
  [@css ".csv-1nzxk4v{color:var(--secondary-16kletf);}"];
  [@css ".csv-1nzxk4v:hover{background-color:var(--box_-vdb5xj);}"];
  [@css
    ".csv-1nzxk4v:hover{box-shadow:1px 0 0 0 var(--line-e0dy15_1), inset 1px 0 0 0 var(--line-e0dy15_2), inset 0 -1px 0 0 var(--line-e0dy15_3);}"
  ];
  [@css ".css-i9gxme{flex-grow:1;}"];
  [@css ".css-r6z5ec{z-index:1;}"];
  [@css ".css-tjsoaq{transition:all 200ms ease 0ms;}"];
  [@css ".css-145l4ca.cid-1wtohw8{min-width:0;}"];
  [@css ".css-1oluo0q.cid-1wtohw8{max-width:0;}"];
  [@css ".css-2io1ml.cid-1wtohw8{opacity:0;}"];
  [@css ".css-1k938xr.cid-1wtohw8{overflow:hidden;}"];
  [@css ".css-keq5th{transition:transform 0.3s !important;}"];
  [@css
    ".css-1hwm8mm{transition:opacity 0.2s ease-in-out, visibility 0.2s ease-in-out;}"
  ];
  [@css.bindings
    [
      ("Input._spaceBeforeColon", "cid-pwoumt", "css-34k09d csv-1cx090v"),
      ("Input._tabInnerFirst", "cid-110u1xw", "css-t2slgw"),
      ("Input._multiShadowImportant", "cid-c7rk0r", "csv-1rh80o9"),
      ("Input._tabTextFirst", "cid-19955vg", "css-1mx0ppg csv-1bp0v5z"),
      ("Input._tabText", "cid-e443o3", "csv-1nzxk4v"),
      ("Input._sidebarClosed", "cid-1wtohw8", ""),
      (
        "Input._sidebar",
        "cid-jjvyqu",
        "css-i9gxme css-r6z5ec css-tjsoaq css-145l4ca css-1oluo0q css-2io1ml css-1k938xr",
      ),
      ("Input._checkbox", "cid-1sltg0l", "css-keq5th"),
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
      "label:_spaceBeforeColon cid-pwoumt css-34k09d csv-1cx090v",
      [("--tertiary-1cttnp6", CSS.Types.Color.toString(Color.Text.tertiary))],
    );
  
  let _tabInnerFirst =
    CSS.make("label:_tabInnerFirst cid-110u1xw css-t2slgw", []);
  
  let _multiShadowImportant =
    CSS.make(
      "label:_multiShadowImportant cid-c7rk0r csv-1rh80o9",
      [
        ("--line-9kmuhm_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-9kmuhm_2", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabTextFirst =
    CSS.make(
      "label:_tabTextFirst cid-19955vg css-1mx0ppg csv-1bp0v5z",
      [
        ("--line-1rsudnc_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-1rsudnc_2", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabText =
    CSS.make(
      "label:_tabText cid-e443o3 csv-1nzxk4v",
      [
        ("--secondary-16kletf", CSS.Types.Color.toString(Color.Text.secondary)),
        ("--box_-vdb5xj", CSS.Types.Color.toString(Color.Background.box_)),
        ("--line-e0dy15_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-e0dy15_2", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-e0dy15_3", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _sidebarClosed = CSS.make("label:_sidebarClosed cid-1wtohw8", []);
  
  let _sidebar =
    CSS.make(
      "label:_sidebar cid-jjvyqu css-i9gxme css-r6z5ec css-tjsoaq css-145l4ca css-1oluo0q css-2io1ml css-1k938xr",
      [],
    );
  
  let _checkbox = CSS.make("label:_checkbox cid-1sltg0l css-keq5th", []);
  
  let _transitions = CSS.make("label:_transitions cid-1jxvvla css-1hwm8mm", []);
  
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
