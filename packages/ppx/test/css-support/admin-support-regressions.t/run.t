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
  [@css "@property --ivpc8c6{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcqav{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcl1r{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc1dk{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpcdo3{syntax:\"*\";inherits:false;}"];
  [@css ".css-ivpcngi{border-top:1px solid var(--ivpc8c6);}"];
  [@css ".css-ivpcf04{border-bottom:1px solid var(--ivpcqav);}"];
  [@css ".css-ivpc8bn{border-left:1px solid var(--ivpcl1r);}"];
  [@css ".css-ivpcbi6{box-shadow:var(--ivpc1dk);}"];
  [@css ".css-ivpcj45{height:calc(100vh + var(--ivpcdo3));}"];
  [@css.classes
    [
      ("css-ivpcngi", 5, "Input._borderTop", "input.re", 35, 25, 35, 67),
      ("css-ivpcf04", 6, "Input._borderBottom", "input.re", 37, 4, 37, 54),
      ("css-ivpc8bn", 7, "Input._borderLeft", "input.re", 39, 26, 39, 74),
      ("css-ivpcbi6", 8, "Input._boxShadow1", "input.re", 41, 26, 41, 73),
      ("css-ivpcj45", 9, "Input._heightPlus", "input.re", 43, 26, 43, 64),
    ]
  ];
  [@css.bindings
    [
      ("Input._borderTop", "css-ivpcngi"),
      ("Input._borderBottom", "css-ivpcf04"),
      ("Input._borderLeft", "css-ivpc8bn"),
      ("Input._boxShadow1", "css-ivpcbi6"),
      ("Input._heightPlus", "css-ivpcj45"),
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
      "css-ivpcngi",
      [("--ivpc8c6", CSS.Types.Color.toString(Color.Border.line))],
    );
  let _borderBottom =
    CSS.make(
      "css-ivpcf04",
      [("--ivpcqav", CSS.Types.Color.toString(Color.Border.lineAlpha))],
    );
  let _borderLeft =
    CSS.make(
      "css-ivpc8bn",
      [("--ivpcl1r", CSS.Types.Color.toString(Color.Border.lineAlpha))],
    );
  
  let _boxShadow1 =
    CSS.make(
      "css-ivpcbi6",
      [
        (
          "--ivpc1dk",
          CSS.Types.BoxShadows.toString(BoxShadow.deprecated__elevation1),
        ),
      ],
    );
  
  let _heightPlus =
    CSS.make(
      "css-ivpcj45",
      [("--ivpcdo3", CSS.Types.Length.toString(topMenuHeight))],
    );

  $ dune build
