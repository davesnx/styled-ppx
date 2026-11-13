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
  [@css "@property --1f7daho-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1tjdhi0-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --x57zxu-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1g80dd9-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1ho8aii-0{syntax:\"*\";inherits:false;}"];
  [@css ".css-1f7daho{border-top:1px solid var(--1f7daho-0);}"];
  [@css ".css-1tjdhi0{border-bottom:1px solid var(--1tjdhi0-0);}"];
  [@css ".css-x57zxu{border-left:1px solid var(--x57zxu-0);}"];
  [@css ".css-1g80dd9{box-shadow:var(--1g80dd9-0);}"];
  [@css ".css-1ho8aii{height:calc(100vh + var(--1ho8aii-0));}"];
  [@css.classes
    [
      ("css-1f7daho", 5, "Input._borderTop", "input.re", 35, 25, 35, 67),
      ("css-1tjdhi0", 6, "Input._borderBottom", "input.re", 37, 4, 37, 54),
      ("css-x57zxu", 7, "Input._borderLeft", "input.re", 39, 26, 39, 74),
      ("css-1g80dd9", 8, "Input._boxShadow1", "input.re", 41, 26, 41, 73),
      ("css-1ho8aii", 9, "Input._heightPlus", "input.re", 43, 26, 43, 64),
    ]
  ];
  [@css.bindings
    [
      ("Input._borderTop", "css-1f7daho"),
      ("Input._borderBottom", "css-1tjdhi0"),
      ("Input._borderLeft", "css-x57zxu"),
      ("Input._boxShadow1", "css-1g80dd9"),
      ("Input._heightPlus", "css-1ho8aii"),
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
      "css-1f7daho",
      [("--1f7daho-0", CSS.Types.Color.toString(Color.Border.line))],
    );
  let _borderBottom =
    CSS.make(
      "css-1tjdhi0",
      [("--1tjdhi0-0", CSS.Types.Color.toString(Color.Border.lineAlpha))],
    );
  let _borderLeft =
    CSS.make(
      "css-x57zxu",
      [("--x57zxu-0", CSS.Types.Color.toString(Color.Border.lineAlpha))],
    );
  
  let _boxShadow1 =
    CSS.make(
      "css-1g80dd9",
      [
        (
          "--1g80dd9-0",
          CSS.Types.BoxShadows.toString(BoxShadow.deprecated__elevation1),
        ),
      ],
    );
  
  let _heightPlus =
    CSS.make(
      "css-1ho8aii",
      [("--1ho8aii-0", CSS.Types.Length.toString(topMenuHeight))],
    );

  $ dune build
