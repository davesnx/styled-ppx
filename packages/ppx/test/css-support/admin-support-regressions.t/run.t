This test captures the admin-support cx2 regressions from the monorepo: border-side shorthands with interpolated colors, box-shadow array interpolation, and length interpolation inside calc().
  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "@property --line-17j5in5{syntax:\"*\";inherits:false;}"];
  [@css "@property --lineAlpha-1tmd8aq{syntax:\"*\";inherits:false;}"];
  [@css "@property --lineAlpha-k1tpqj{syntax:\"*\";inherits:false;}"];
  [@css
    "@property --deprecated__elevation1-1jpikyl{syntax:\"*\";inherits:false;}"
  ];
  [@css "@property --topMenuHeight-10ob2p1{syntax:\"*\";inherits:false;}"];
  [@css "._a_3hghs9vd4{border-top:1px solid var(--line-17j5in5);}"];
  [@css "._a_3h007kb5g{border-bottom:1px solid var(--lineAlpha-1tmd8aq);}"];
  [@css "._a_3h1ds4w3j{border-left:1px solid var(--lineAlpha-k1tpqj);}"];
  [@css "._a_400dz6{box-shadow:var(--deprecated__elevation1-1jpikyl);}"];
  [@css "._a_6lttxg{height:calc(100vh + var(--topMenuHeight-10ob2p1));}"];
  [@css.bindings
    [
      ("Input._borderTop", "_id_k0smpx", "_a_3hghs9vd4"),
      ("Input._borderBottom", "_id_4yz5wd", "_a_3h007kb5g"),
      ("Input._borderLeft", "_id_1w7n6a9", "_a_3h1ds4w3j"),
      ("Input._boxShadow1", "_id_114a8u4", "_a_400dz6"),
      ("Input._heightPlus", "_id_11xytn2", "_a_6lttxg"),
    ]
  ];
  module Alias = {
    module Shadow = {
      type t = CSS.Shadow.t;
    };
  };
  
  module Color = {
    module Border = {
      let line = `rgba((0, 0, 0, `num(0.1)));
      let lineAlpha = `rgba((0, 0, 0, `num(0.05)));
    };
  };
  
  module BoxShadow = {
    let deprecated__elevation1: array(Alias.Shadow.t) = [|
      CSS.Shadow.box(
        ~x=`zero,
        ~y=`zero,
        ~blur=`zero,
        ~spread=`px(1),
        `rgba((0, 0, 0, `num(0.03))),
      ),
      CSS.Shadow.box(
        ~x=`zero,
        ~y=`px(1),
        ~blur=`zero,
        ~spread=`zero,
        `rgba((0, 0, 0, `num(0.06))),
      ),
    |];
  };
  
  let topMenuHeight = `px(56);
  
  let _borderTop =
    CSS.make(
      "label:_borderTop _id_k0smpx _a_3hghs9vd4",
      [("--line-17j5in5", CSS.Types.Color.toString(Color.Border.line))],
    );
  let _borderBottom =
    CSS.make(
      "label:_borderBottom _id_4yz5wd _a_3h007kb5g",
      [
        (
          "--lineAlpha-1tmd8aq",
          CSS.Types.Color.toString(Color.Border.lineAlpha),
        ),
      ],
    );
  let _borderLeft =
    CSS.make(
      "label:_borderLeft _id_1w7n6a9 _a_3h1ds4w3j",
      [
        (
          "--lineAlpha-k1tpqj",
          CSS.Types.Color.toString(Color.Border.lineAlpha),
        ),
      ],
    );
  
  let _boxShadow1 =
    CSS.make(
      "label:_boxShadow1 _id_114a8u4 _a_400dz6",
      [
        (
          "--deprecated__elevation1-1jpikyl",
          CSS.Types.BoxShadows.toString(BoxShadow.deprecated__elevation1),
        ),
      ],
    );
  
  let _heightPlus =
    CSS.make(
      "label:_heightPlus _id_11xytn2 _a_6lttxg",
      [("--topMenuHeight-10ob2p1", CSS.Types.Length.toString(topMenuHeight))],
    );

  $ dune build
