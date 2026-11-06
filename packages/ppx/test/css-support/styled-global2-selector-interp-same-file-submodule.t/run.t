Same-file submodule selector interpolation resolves locally in
[%styled.global] blocks.

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
  [@css "body ._ixRBiAnCL{font-weight:bold;}"];
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
    [("Input.Css.marker", "_ixRBiAnCL _a7fadbhEW", "_ixRBiAnCL")]
  ];
  module Css = {
    let marker = CSS.make("_ixRBiAnCL _a7fadbhEW", []);
  };
  
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
  
  let _ = (Css.marker, Globals.to_string, Globals.make);

  $ dune build
