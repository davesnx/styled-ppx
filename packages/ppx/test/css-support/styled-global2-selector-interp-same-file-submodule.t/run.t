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
  [@css "body .id-zr2uk1{font-weight:bold;}"];
  [@css ".a-tokvmb{color:red;}"];
  [@css.bindings [("Input.Css.marker", "id-zr2uk1", "a-tokvmb")]];
  module Css = {
    let marker = CSS.make("label:marker id-zr2uk1 a-tokvmb", []);
  };
  
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
  
  let _ = (Css.marker, Globals.to_string, Globals.make);

  $ dune build
