Same-file submodule binding shadowing follows structure order: a later
`let marker` inside `module Css` replaces the earlier binding for subsequent
`$(Css.marker)` selector refs.

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
  [@css.atoms
    [
      (
        "_a7fadbhEW",
        ["._a7fadbhEW{color:red;}"],
        1,
        0,
        1,
        [("value", "adbhEW", "val\\07f\\0& | \\0color:red")],
      ),
      (
        "_a7fBq58Im",
        ["._a7fBq58Im{color:green;}"],
        1,
        0,
        1,
        [("value", "Bq58Im", "val\\07f\\0& | \\0color:green")],
      ),
      (
        "_c7fSpg0yeed9xRc",
        ["._c7fSpg0yeed9xRc._igb76fJwE{color:blue;}"],
        2,
        1,
        1,
        [
          ("ctx", "Spg0ye", "ctx\\0&._igb76fJwE | "),
          ("value", "ed9xRc", "val\\07f\\0&._igb76fJwE | \\0color:blue"),
        ],
      ),
      (
        "_ixRBiAnCL",
        [],
        1,
        0,
        0,
        [("id", "_ixRBiAnCL", "bind\\0\\0Input\\0Css\\0marker\\00")],
      ),
      (
        "_igb76fJwE",
        [],
        1,
        0,
        0,
        [("id", "_igb76fJwE", "bind\\0\\0Input\\0Css\\0marker\\01")],
      ),
      (
        "_iLqyzJ4k2",
        [],
        1,
        0,
        0,
        [("id", "_iLqyzJ4k2", "bind\\0\\0Input\\0\\0wrapper\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.Css.marker", "_igb76fJwE _a7fBq58Im", "_igb76fJwE"),
      ("Input.wrapper", "_iLqyzJ4k2 _c7fSpg0yeed9xRc", "_iLqyzJ4k2"),
    ]
  ];
  module Css = {
    let marker = CSS.make("_ixRBiAnCL _a7fadbhEW", []);
    let _ = marker;
  
    let marker = CSS.make("_igb76fJwE _a7fBq58Im", []);
  };
  
  let wrapper = CSS.make("_iLqyzJ4k2 _c7fSpg0yeed9xRc", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
