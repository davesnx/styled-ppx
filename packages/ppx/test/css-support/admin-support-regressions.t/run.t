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
  [@css ".css-11h9vd4-_borderTop{border-top:1px solid var(--line-17j5in5);}"];
  [@css
    ".css-epkb5g-_borderBottom{border-bottom:1px solid var(--lineAlpha-1tmd8aq);}"
  ];
  [@css
    ".css-ob4w3j-_borderLeft{border-left:1px solid var(--lineAlpha-k1tpqj);}"
  ];
  [@css
    ".css-1070dz6-_boxShadow1{box-shadow:var(--deprecated__elevation1-1jpikyl);}"
  ];
  [@css
    ".css-1y8ttxg-_heightPlus{height:calc(100vh + var(--topMenuHeight-10ob2p1));}"
  ];
  [@css.bindings
    [
      ("Input._borderTop", "css-11h9vd4-_borderTop"),
      ("Input._borderBottom", "css-epkb5g-_borderBottom"),
      ("Input._borderLeft", "css-ob4w3j-_borderLeft"),
      ("Input._boxShadow1", "css-1070dz6-_boxShadow1"),
      ("Input._heightPlus", "css-1y8ttxg-_heightPlus"),
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
      "cid-k0smpx css-11h9vd4-_borderTop",
      [("--line-17j5in5", CSS.Types.Color.toString(Color.Border.line))],
    );
  let _borderBottom =
    CSS.make(
      "cid-4yz5wd css-epkb5g-_borderBottom",
      [
        (
          "--lineAlpha-1tmd8aq",
          CSS.Types.Color.toString(Color.Border.lineAlpha),
        ),
      ],
    );
  let _borderLeft =
    CSS.make(
      "cid-1w7n6a9 css-ob4w3j-_borderLeft",
      [
        (
          "--lineAlpha-k1tpqj",
          CSS.Types.Color.toString(Color.Border.lineAlpha),
        ),
      ],
    );
  
  let _boxShadow1 =
    CSS.make(
      "cid-114a8u4 css-1070dz6-_boxShadow1",
      [
        (
          "--deprecated__elevation1-1jpikyl",
          CSS.Types.BoxShadows.toString(BoxShadow.deprecated__elevation1),
        ),
      ],
    );
  
  let _heightPlus =
    CSS.make(
      "cid-11xytn2 css-1y8ttxg-_heightPlus",
      [("--topMenuHeight-10ob2p1", CSS.Types.Length.toString(topMenuHeight))],
    );

  $ dune build
