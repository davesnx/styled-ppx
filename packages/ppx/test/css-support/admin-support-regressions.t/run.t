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
  [@css "@property --line-1qlpppm{syntax:\"*\";inherits:false;}"];
  [@css "@property --lineAlpha-1y708ml{syntax:\"*\";inherits:false;}"];
  [@css "@property --lineAlpha-yk86tr{syntax:\"*\";inherits:false;}"];
  [@css
    "@property --deprecated__elevation1-1lyc2hk{syntax:\"*\";inherits:false;}"
  ];
  [@css "@property --topMenuHeight-1qy9hr6{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_a6jD48_sq",
        ["._a6jD48_sq{border-top:1px solid var(--line-1qlpppm);}"],
        1,
        0,
        3,
        [
          (
            "value",
            "D48_sq",
            "val\\06j\\0& | \\0border-top:1px solid $(Color.Border.line)",
          ),
        ],
      ),
      (
        "_a5dK5LIIS",
        ["._a5dK5LIIS{border-bottom:1px solid var(--lineAlpha-1y708ml);}"],
        1,
        0,
        3,
        [
          (
            "value",
            "K5LIIS",
            "val\\05d\\0& | \\0border-bottom:1px solid $(Color.Border.lineAlpha)",
          ),
        ],
      ),
      (
        "_a65kp2IfR",
        ["._a65kp2IfR{border-left:1px solid var(--lineAlpha-yk86tr);}"],
        1,
        0,
        3,
        [
          (
            "value",
            "kp2IfR",
            "val\\065\\0& | \\0border-left:1px solid $(Color.Border.lineAlpha)",
          ),
        ],
      ),
      (
        "_a70l75YLe",
        ["._a70l75YLe{box-shadow:var(--deprecated__elevation1-1lyc2hk);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "l75YLe",
            "val\\070\\0& | \\0box-shadow:$(BoxShadow.deprecated__elevation1)",
          ),
        ],
      ),
      (
        "_abd_StP42",
        ["._abd_StP42{height:calc(100vh + var(--topMenuHeight-1qy9hr6));}"],
        1,
        0,
        1,
        [
          (
            "value",
            "_StP42",
            "val\\0bd\\0& | \\0height:calc(100vh + $(topMenuHeight))",
          ),
        ],
      ),
      (
        "_iVC9HsSwN",
        [],
        1,
        0,
        0,
        [("id", "_iVC9HsSwN", "bind\\0\\0Input\\0\\0_borderTop\\00")],
      ),
      (
        "_im8QFEHB5",
        [],
        1,
        0,
        0,
        [("id", "_im8QFEHB5", "bind\\0\\0Input\\0\\0_borderBottom\\00")],
      ),
      (
        "_iRghquudW",
        [],
        1,
        0,
        0,
        [("id", "_iRghquudW", "bind\\0\\0Input\\0\\0_borderLeft\\00")],
      ),
      (
        "_i5I3Nbycz",
        [],
        1,
        0,
        0,
        [("id", "_i5I3Nbycz", "bind\\0\\0Input\\0\\0_boxShadow1\\00")],
      ),
      (
        "_i6t4LGJeS",
        [],
        1,
        0,
        0,
        [("id", "_i6t4LGJeS", "bind\\0\\0Input\\0\\0_heightPlus\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input._borderTop", "_iVC9HsSwN _a6jD48_sq", "_iVC9HsSwN"),
      ("Input._borderBottom", "_im8QFEHB5 _a5dK5LIIS", "_im8QFEHB5"),
      ("Input._borderLeft", "_iRghquudW _a65kp2IfR", "_iRghquudW"),
      ("Input._boxShadow1", "_i5I3Nbycz _a70l75YLe", "_i5I3Nbycz"),
      ("Input._heightPlus", "_i6t4LGJeS _abd_StP42", "_i6t4LGJeS"),
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
      "_iVC9HsSwN _a6jD48_sq",
      [("--line-1qlpppm", CSS.Types.Color.toString(Color.Border.line))],
    );
  let _borderBottom =
    CSS.make(
      "_im8QFEHB5 _a5dK5LIIS",
      [
        (
          "--lineAlpha-1y708ml",
          CSS.Types.Color.toString(Color.Border.lineAlpha),
        ),
      ],
    );
  let _borderLeft =
    CSS.make(
      "_iRghquudW _a65kp2IfR",
      [
        (
          "--lineAlpha-yk86tr",
          CSS.Types.Color.toString(Color.Border.lineAlpha),
        ),
      ],
    );
  
  let _boxShadow1 =
    CSS.make(
      "_i5I3Nbycz _a70l75YLe",
      [
        (
          "--deprecated__elevation1-1lyc2hk",
          CSS.Types.BoxShadows.toString(BoxShadow.deprecated__elevation1),
        ),
      ],
    );
  
  let _heightPlus =
    CSS.make(
      "_i6t4LGJeS _abd_StP42",
      [("--topMenuHeight-1qy9hr6", CSS.Types.Length.toString(topMenuHeight))],
    );

  $ dune build
