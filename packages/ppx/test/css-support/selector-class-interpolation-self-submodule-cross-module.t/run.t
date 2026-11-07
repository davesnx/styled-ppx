Inside `module Css`, `$(Css.marker)` is not a self-reference. The bare
`$(marker)` form is the local self-module reference; `$(Css.marker)` is treated
as an external path unless another enclosing `Css` module exists.

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
        "_ixRBiAnCL",
        [],
        1,
        0,
        0,
        [("id", "_ixRBiAnCL", "bind\\0\\0Input\\0Css\\0marker\\00")],
      ),
      (
        "_i2tmrgooJ",
        [],
        1,
        0,
        0,
        [("id", "_i2tmrgooJ", "bind\\0\\0Input\\0Css\\0wrapper\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.Css.marker", "_ixRBiAnCL _a7fadbhEW", "_ixRBiAnCL"),
      ("Input.Css.wrapper", "_i2tmrgooJ _c7fnrNh_plAq-7K", "_i2tmrgooJ"),
    ]
  ];
  [@css.refs [("Css.marker", "input.re", 5, 8, 18)]];
  
  let _ = Css.marker;
  module Css = {
    let marker = CSS.make("_ixRBiAnCL _a7fadbhEW", []);
  
    let wrapper = CSS.make("_i2tmrgooJ _c7fnrNh_plAq-7K", []);
  };
  
  let _ = (Css.marker, Css.wrapper);

  $ dune build
  File "input.re", line 5, characters 8-18:
  5 |     &.$(Css.marker) { color: blue; }
              ^^^^^^^^^^
  Error: Unbound module Css
  [1]
