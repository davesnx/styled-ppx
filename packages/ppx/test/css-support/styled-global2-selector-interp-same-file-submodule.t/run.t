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
  [@css "body .css-17viirv{font-weight:bold;}"];
  [@css ".css-17viirv{color:red;}"];
  [@css.classes
    [("css-17viirv", 1, "Input.Css.marker", "input.re", 2, 24, 2, 36)]
  ];
  [@css.bindings [("Input.Css.marker", "css-17viirv")]];
  module Css = {
    let marker = CSS.make("css-17viirv", []);
  };
  
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
  
  let _ = (Css.marker, Globals.to_string, Globals.make);

  $ dune build
