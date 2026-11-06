A dotted selector ref can resolve to an earlier string literal in a same-file
submodule instead of being emitted as a cross-module sentinel.

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
        "_c7f_L2X_69MrXhR",
        ["._c7f_L2X_69MrXhR.plain-string-selector{color:blue;}"],
        2,
        1,
        1,
        [
          ("ctx", "_L2X_6", "ctx\\0&.plain-string-selector | "),
          (
            "value",
            "9MrXhR",
            "val\\07f\\0&.plain-string-selector | \\0color:blue",
          ),
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
      ("Input.wrapper", "_iLqyzJ4k2 _c7f_L2X_69MrXhR", "_iLqyzJ4k2"),
    ]
  ];
  module Css = {
    let marker = CSS.make("_ixRBiAnCL _a7fadbhEW", []);
    let notCx2 = "plain-string-selector";
  };
  
  let wrapper = CSS.make("_iLqyzJ4k2 _c7f_L2X_69MrXhR", []);
  
  let _ = (Css.marker, Css.notCx2, wrapper);

  $ dune build
