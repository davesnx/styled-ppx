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
  [@css ".a-59bkuc.external-marker{color:blue;}"];
  [@css.bindings [("Input.wrapper", "id-4f6ye3", "a-59bkuc")]];
  module Css = {
    let marker = "external-marker";
  };
  
  let wrapper = CSS.make("label:wrapper id-4f6ye3 a-59bkuc", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
