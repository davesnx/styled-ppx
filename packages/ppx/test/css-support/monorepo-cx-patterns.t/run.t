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
  [@css "@property --tertiary-1majxx5{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-dykbaq_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-dykbaq_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-7x73z6_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-7x73z6_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --secondary-fa8x6a{syntax:\"*\";inherits:false;}"];
  [@css "@property --box_-jos18o{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1jaikh2_1{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1jaikh2_2{syntax:\"*\";inherits:false;}"];
  [@css "@property --line-1jaikh2_3{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_an8_tatej",
        ["._an8_tatej{width:30px;}"],
        1,
        0,
        1,
        [("value", "_tatej", "val\\0n8\\0& | \\0width:30px")],
      ),
      (
        "_a7f_f5z2_",
        ["._a7f_f5z2_{color:var(--tertiary-1majxx5);}"],
        1,
        0,
        1,
        [
          ("value", "_f5z2_", "val\\07f\\0& | \\0color:$(Color.Text.tertiary)"),
        ],
      ),
      (
        "_c70-ypkeDD-tUh9",
        [
          "._c70-ypkeDD-tUh9{box-shadow:inset 1px 0 0 0 transparent !important;}",
        ],
        1,
        0,
        1,
        [
          ("ctx", "-ypkeD", "ctx\\0& | !important"),
          (
            "value",
            "D-tUh9",
            "val\\070\\0& | !important\\0box-shadow:inset 1px 0 0 0 transparent !important",
          ),
        ],
      ),
      (
        "_c70-ypkeDyJ8YYx",
        [
          "._c70-ypkeDyJ8YYx{box-shadow:1px 0 0 0 var(--line-dykbaq_1), inset 0 -1px 0 0 var(--line-dykbaq_2) !important;}",
        ],
        1,
        0,
        1,
        [
          ("ctx", "-ypkeD", "ctx\\0& | !important"),
          (
            "value",
            "yJ8YYx",
            "val\\070\\0& | !important\\0box-shadow:1px 0 0 0 $(Color.Border.line), inset 0 -1px 0 0 $(Color.Border.line) !important",
          ),
        ],
      ),
      (
        "_a70bnobmv",
        ["._a70bnobmv{box-shadow:inset 0 0 0 0 transparent;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "bnobmv",
            "val\\070\\0& | \\0box-shadow:inset 0 0 0 0 transparent",
          ),
        ],
      ),
      (
        "_c70X2BCe5bwR1OG",
        [
          "._c70X2BCe5bwR1OG:hover{box-shadow:1px 0 0 0 var(--line-7x73z6_1), inset 0 -1px 0 0 var(--line-7x73z6_2) !important;}",
        ],
        2,
        1,
        1,
        [
          ("ctx", "X2BCe5", "ctx\\0&:hover | !important"),
          (
            "value",
            "bwR1OG",
            "val\\070\\0&:hover | !important\\0box-shadow:1px 0 0 0 $(Color.Border.line), inset 0 -1px 0 0 $(Color.Border.line) !important",
          ),
        ],
      ),
      (
        "_a7fzW--Oi",
        ["._a7fzW--Oi{color:var(--secondary-fa8x6a);}"],
        1,
        0,
        1,
        [
          ("value", "zW--Oi", "val\\07f\\0& | \\0color:$(Color.Text.secondary)"),
        ],
      ),
      (
        "_c4l1Tl5-w0uUAhL",
        ["._c4l1Tl5-w0uUAhL:hover{background-color:var(--box_-jos18o);}"],
        2,
        1,
        1,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          (
            "value",
            "0uUAhL",
            "val\\04l\\0&:hover | \\0background-color:$(Color.Background.box_)",
          ),
        ],
      ),
      (
        "_c701Tl5-wgWgY7B",
        [
          "._c701Tl5-wgWgY7B:hover{box-shadow:1px 0 0 0 var(--line-1jaikh2_1), inset 1px 0 0 0 var(--line-1jaikh2_2), inset 0 -1px 0 0 var(--line-1jaikh2_3);}",
        ],
        2,
        1,
        1,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          (
            "value",
            "gWgY7B",
            "val\\070\\0&:hover | \\0box-shadow:1px 0 0 0 $(Color.Border.line), inset 1px 0 0 0 $(Color.Border.line), inset 0 -1px 0 0 $(Color.Border.line)",
          ),
        ],
      ),
      (
        "_a9totrfbB",
        ["._a9totrfbB{flex-grow:1;}"],
        1,
        0,
        1,
        [("value", "otrfbB", "val\\09t\\0& | \\0flex-grow:1")],
      ),
      (
        "_angg2mdjV",
        ["._angg2mdjV{z-index:1;}"],
        1,
        0,
        1,
        [("value", "g2mdjV", "val\\0ng\\0& | \\0z-index:1")],
      ),
      (
        "_amad6u9qq",
        ["._amad6u9qq{transition:all 200ms ease 0ms;}"],
        1,
        0,
        5,
        [
          ("value", "d6u9qq", "val\\0ma\\0& | \\0transition:all 200ms ease 0ms"),
        ],
      ),
      (
        "_cesC9rGz9xf2QcV",
        ["._cesC9rGz9xf2QcV._iJ6eddiUT{min-width:0;}"],
        2,
        1,
        1,
        [
          ("ctx", "C9rGz9", "ctx\\0&._iJ6eddiUT | "),
          ("value", "xf2QcV", "val\\0es\\0&._iJ6eddiUT | \\0min-width:0"),
        ],
      ),
      (
        "_cdzC9rGz9qdRvTH",
        ["._cdzC9rGz9qdRvTH._iJ6eddiUT{max-width:0;}"],
        2,
        1,
        1,
        [
          ("ctx", "C9rGz9", "ctx\\0&._iJ6eddiUT | "),
          ("value", "qdRvTH", "val\\0dz\\0&._iJ6eddiUT | \\0max-width:0"),
        ],
      ),
      (
        "_cf9C9rGz9i2OVBU",
        ["._cf9C9rGz9i2OVBU._iJ6eddiUT{opacity:0;}"],
        2,
        1,
        1,
        [
          ("ctx", "C9rGz9", "ctx\\0&._iJ6eddiUT | "),
          ("value", "i2OVBU", "val\\0f9\\0&._iJ6eddiUT | \\0opacity:0"),
        ],
      ),
      (
        "_cfhC9rGz9nXashl",
        ["._cfhC9rGz9nXashl._iJ6eddiUT{overflow:hidden;}"],
        2,
        1,
        2,
        [
          ("ctx", "C9rGz9", "ctx\\0&._iJ6eddiUT | "),
          ("value", "nXashl", "val\\0fh\\0&._iJ6eddiUT | \\0overflow:hidden"),
        ],
      ),
      (
        "_cma-ypkeDhtGUDm",
        ["._cma-ypkeDhtGUDm{transition:transform 0.3s !important;}"],
        1,
        0,
        5,
        [
          ("ctx", "-ypkeD", "ctx\\0& | !important"),
          (
            "value",
            "htGUDm",
            "val\\0ma\\0& | !important\\0transition:transform 0.3s !important",
          ),
        ],
      ),
      (
        "_amapvYp_U",
        [
          "._amapvYp_U{transition:opacity 0.2s ease-in-out, visibility 0.2s ease-in-out;}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "pvYp_U",
            "val\\0ma\\0& | \\0transition:opacity 0.2s ease-in-out, visibility 0.2s ease-in-out",
          ),
        ],
      ),
      (
        "_iNNY45wXi",
        [],
        1,
        0,
        0,
        [("id", "_iNNY45wXi", "bind\\0\\0Input\\0\\0_spaceBeforeColon\\00")],
      ),
      (
        "_iK3rA6qHe",
        [],
        1,
        0,
        0,
        [("id", "_iK3rA6qHe", "bind\\0\\0Input\\0\\0_tabInnerFirst\\00")],
      ),
      (
        "_i3KhmWInj",
        [],
        1,
        0,
        0,
        [
          ("id", "_i3KhmWInj", "bind\\0\\0Input\\0\\0_multiShadowImportant\\00"),
        ],
      ),
      (
        "_iZYJd3jW_",
        [],
        1,
        0,
        0,
        [("id", "_iZYJd3jW_", "bind\\0\\0Input\\0\\0_tabTextFirst\\00")],
      ),
      (
        "_ic-FkZwkz",
        [],
        1,
        0,
        0,
        [("id", "_ic-FkZwkz", "bind\\0\\0Input\\0\\0_tabText\\00")],
      ),
      (
        "_iJ6eddiUT",
        [],
        1,
        0,
        0,
        [("id", "_iJ6eddiUT", "bind\\0\\0Input\\0\\0_sidebarClosed\\00")],
      ),
      (
        "_i4FfztWAA",
        [],
        1,
        0,
        0,
        [("id", "_i4FfztWAA", "bind\\0\\0Input\\0\\0_sidebar\\00")],
      ),
      (
        "_idYsjQrTo",
        [],
        1,
        0,
        0,
        [("id", "_idYsjQrTo", "bind\\0\\0Input\\0\\0_checkbox\\00")],
      ),
      (
        "_iKeaGexVg",
        [],
        1,
        0,
        0,
        [("id", "_iKeaGexVg", "bind\\0\\0Input\\0\\0_transitions\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      (
        "Input._spaceBeforeColon",
        "_iNNY45wXi _an8_tatej _a7f_f5z2_",
        "_iNNY45wXi",
      ),
      ("Input._tabInnerFirst", "_iK3rA6qHe _c70-ypkeDD-tUh9", "_iK3rA6qHe"),
      (
        "Input._multiShadowImportant",
        "_i3KhmWInj _c70-ypkeDyJ8YYx",
        "_i3KhmWInj",
      ),
      (
        "Input._tabTextFirst",
        "_iZYJd3jW_ _a70bnobmv _c70X2BCe5bwR1OG",
        "_iZYJd3jW_",
      ),
      (
        "Input._tabText",
        "_ic-FkZwkz _a7fzW--Oi _c4l1Tl5-w0uUAhL _c701Tl5-wgWgY7B",
        "_ic-FkZwkz",
      ),
      ("Input._sidebarClosed", "_iJ6eddiUT", "_iJ6eddiUT"),
      (
        "Input._sidebar",
        "_i4FfztWAA _a9totrfbB _angg2mdjV _amad6u9qq _cesC9rGz9xf2QcV _cdzC9rGz9qdRvTH _cf9C9rGz9i2OVBU _cfhC9rGz9nXashl",
        "_i4FfztWAA",
      ),
      ("Input._checkbox", "_idYsjQrTo _cma-ypkeDhtGUDm", "_idYsjQrTo"),
      ("Input._transitions", "_iKeaGexVg _amapvYp_U", "_iKeaGexVg"),
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
      "_iNNY45wXi _an8_tatej _a7f_f5z2_",
      [("--tertiary-1majxx5", CSS.Types.Color.toString(Color.Text.tertiary))],
    );
  
  let _tabInnerFirst = CSS.make("_iK3rA6qHe _c70-ypkeDD-tUh9", []);
  
  let _multiShadowImportant =
    CSS.make(
      "_i3KhmWInj _c70-ypkeDyJ8YYx",
      [
        ("--line-dykbaq_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-dykbaq_2", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabTextFirst =
    CSS.make(
      "_iZYJd3jW_ _a70bnobmv _c70X2BCe5bwR1OG",
      [
        ("--line-7x73z6_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-7x73z6_2", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _tabText =
    CSS.make(
      "_ic-FkZwkz _a7fzW--Oi _c4l1Tl5-w0uUAhL _c701Tl5-wgWgY7B",
      [
        ("--secondary-fa8x6a", CSS.Types.Color.toString(Color.Text.secondary)),
        ("--box_-jos18o", CSS.Types.Color.toString(Color.Background.box_)),
        ("--line-1jaikh2_1", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-1jaikh2_2", CSS.Types.Color.toString(Color.Border.line)),
        ("--line-1jaikh2_3", CSS.Types.Color.toString(Color.Border.line)),
      ],
    );
  
  let _sidebarClosed = CSS.make("_iJ6eddiUT", []);
  
  let _sidebar =
    CSS.make(
      "_i4FfztWAA _a9totrfbB _angg2mdjV _amad6u9qq _cesC9rGz9xf2QcV _cdzC9rGz9qdRvTH _cf9C9rGz9i2OVBU _cfhC9rGz9nXashl",
      [],
    );
  
  let _checkbox = CSS.make("_idYsjQrTo _cma-ypkeDhtGUDm", []);
  
  let _transitions = CSS.make("_iKeaGexVg _amapvYp_U", []);
  
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
