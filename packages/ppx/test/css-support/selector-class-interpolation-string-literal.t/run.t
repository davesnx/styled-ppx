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
  [@css ".css-k70mno.external-marker{color:blue;}"];
  [@css.classes [("css-k70mno", 0, "Input.wrapper", "input.re", 6, 2, 7, 0)]];
  [@css.bindings [("Input.wrapper", "css-k70mno")]];
  module Css = {
    let marker = "external-marker";
  };
  
  let wrapper = CSS.make("css-k70mno", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
