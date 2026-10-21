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
  [@css "._a_cb08j4eamhw.external-marker{color:blue;}"];
  [@css.bindings [("Input.wrapper", "_id_4f6ye3", "_a_cb08j4eamhw")]];
  module Css = {
    let marker = "external-marker";
  };
  
  let wrapper = CSS.make("label:wrapper _id_4f6ye3 _a_cb08j4eamhw", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
