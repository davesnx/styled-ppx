Same-file module aliases are expanded by selector interpolation. The resolver
knows `module Styles = Css`, so `$(Styles.marker)` resolves to the same class
chain as `$(Css.marker)` without emitting a cross-module sentinel.

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
        "_c7fU9l6zcJkHyO9",
        ["._c7fU9l6zcJkHyO9._ixRBiAnCL{color:blue;}"],
        2,
        1,
        1,
        [
          ("ctx", "U9l6zc", "ctx\\0&._ixRBiAnCL | "),
          ("value", "JkHyO9", "val\\07f\\0&._ixRBiAnCL | \\0color:blue"),
        ],
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
        "_c7fRhRPz43JHcWh",
        ["._c7fRhRPz43JHcWh._iB2CBciJ0{color:purple;}"],
        2,
        1,
        1,
        [
          ("ctx", "RhRPz4", "ctx\\0&._iB2CBciJ0 | "),
          ("value", "3JHcWh", "val\\07f\\0&._iB2CBciJ0 | \\0color:purple"),
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
        "_iLqyzJ4k2",
        [],
        1,
        0,
        0,
        [("id", "_iLqyzJ4k2", "bind\\0\\0Input\\0\\0wrapper\\00")],
      ),
      (
        "_iB2CBciJ0",
        [],
        1,
        0,
        0,
        [("id", "_iB2CBciJ0", "bind\\0\\0Input\\0Theme.Css\\0marker\\00")],
      ),
      (
        "_iPqT6zxZk",
        [],
        1,
        0,
        0,
        [("id", "_iPqT6zxZk", "bind\\0\\0Input\\0Theme\\0wrapper\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.Css.marker", "_ixRBiAnCL _a7fadbhEW", "_ixRBiAnCL"),
      ("Input.wrapper", "_iLqyzJ4k2 _c7fU9l6zcJkHyO9", "_iLqyzJ4k2"),
      ("Input.Theme.Css.marker", "_iB2CBciJ0 _a7fBq58Im", "_iB2CBciJ0"),
      ("Input.Theme.wrapper", "_iPqT6zxZk _c7fRhRPz43JHcWh", "_iPqT6zxZk"),
    ]
  ];
  module Css = {
    let marker = CSS.make("_ixRBiAnCL _a7fadbhEW", []);
  };
  
  module Styles = Css;
  
  let wrapper = CSS.make("_iLqyzJ4k2 _c7fU9l6zcJkHyO9", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("_iB2CBciJ0 _a7fBq58Im", []);
    };
  
    module Styles = Css;
  
    let wrapper = CSS.make("_iPqT6zxZk _c7fRhRPz43JHcWh", []);
  };
  
  let _ = (Css.marker, wrapper, Theme.Css.marker, Theme.wrapper);

  $ dune build
