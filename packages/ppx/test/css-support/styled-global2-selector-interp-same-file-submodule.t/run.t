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
  [@css "body .css-tokvmb-marker{font-weight:bold;}"];
  [@css ".css-tokvmb-marker{color:red;}"];
  [@css.bindings [("Input.Css.marker", "css-tokvmb-marker")]];
  module Css = {
    let marker = CSS.make("css-tokvmb-marker", []);
  };
  
  module Globals = {
    let to_string = () => "";
    let to_buffer = buf => Buffer.add_string(buf, to_string());
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => ();
    let make = _props => CSS.global_style_tag(to_string());
  };
  
  let _ = (Css.marker, Globals.to_string, Globals.to_buffer, Globals.make);

  $ dune build
