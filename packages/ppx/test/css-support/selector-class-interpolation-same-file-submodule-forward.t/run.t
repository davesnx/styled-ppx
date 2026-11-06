Forward same-file submodule references are not resolved by the PPX. The
registry is populated as [%css] expands top-to-bottom, so users must move the
referenced submodule binding above the selector interpolation.

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
        "_c7fnrNh_plAq-7K",
        ["._c7fnrNh_plAq-7K.\000Css.marker\000{color:blue;}"],
        2,
        1,
        1,
        [
          ("ctx", "nrNh_p", "ctx\\0&.$(Css.marker)\\0module:Input | "),
          (
            "value",
            "lAq-7K",
            "val\\07f\\0&.$(Css.marker)\\0module:Input | \\0color:blue\\0module:Input",
          ),
        ],
      ),
      (
        "_a7fadbhEW",
        ["._a7fadbhEW{color:red;}"],
        1,
        0,
        1,
        [("value", "adbhEW", "val\\07f\\0& | \\0color:red")],
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
        "_ixRBiAnCL",
        [],
        1,
        0,
        0,
        [("id", "_ixRBiAnCL", "bind\\0\\0Input\\0Css\\0marker\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.wrapper", "_iLqyzJ4k2 _c7fnrNh_plAq-7K", "_iLqyzJ4k2"),
      ("Input.Css.marker", "_ixRBiAnCL _a7fadbhEW", "_ixRBiAnCL"),
    ]
  ];
  [@css.refs [("Css.marker", "input.re", 2, 6, 16)]];
  
  let _ = Css.marker;
  let wrapper = CSS.make("_iLqyzJ4k2 _c7fnrNh_plAq-7K", []);
  
  module Css = {
    let marker = CSS.make("_ixRBiAnCL _a7fadbhEW", []);
  };
  
  let _ = (wrapper, Css.marker);

  $ dune build
  File "input.re", line 2, characters 6-16:
  2 |   &.$(Css.marker) { color: blue; }
            ^^^^^^^^^^
  Error: Unbound module Css
  [1]
