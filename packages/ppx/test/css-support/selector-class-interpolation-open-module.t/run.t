Same-file open statements participate in selector interpolation. After
`open Css`, bare `$(marker)` resolves to the earlier `Css.marker` binding.

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
    ]
  ];
  [@css.bindings
    [
      ("Input.Css.marker", "_ixRBiAnCL _a7fadbhEW", "_ixRBiAnCL"),
      ("Input.wrapper", "_iLqyzJ4k2 _c7fU9l6zcJkHyO9", "_iLqyzJ4k2"),
    ]
  ];
  module Css = {
    let marker = CSS.make("_ixRBiAnCL _a7fadbhEW", []);
  };
  
  open Css;
  let _ = marker;
  
  let wrapper = CSS.make("_iLqyzJ4k2 _c7fU9l6zcJkHyO9", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
