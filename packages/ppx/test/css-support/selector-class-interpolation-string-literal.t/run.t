Earlier string literals can be used as static selector refs. They are resolved
locally but are not exported through [@@@css.bindings], because the aggregator
only indexes [%css] class handles.

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
  [@css ".css-1qkp8g0-wrapper.external-marker{color:blue}"];
  [@css.bindings [("Input.wrapper", "css-1qkp8g0-wrapper")]];
  module Css = {
    let marker = "external-marker";
  };
  
  let wrapper = CSS.make("css-1qkp8g0-wrapper", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
