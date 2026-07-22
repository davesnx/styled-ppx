A dotted selector ref can resolve to an earlier string literal in a same-file
submodule instead of being emitted as a cross-module sentinel.

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
  [@css ".css-tokvmb-marker{color:red;}"];
  [@css ".css-e9zk30-wrapper.plain-string-selector{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "css-tokvmb-marker"),
      ("Input.wrapper", "css-e9zk30-wrapper"),
    ]
  ];
  module Css = {
    let marker = CSS.make_labeled("marker", "css-tokvmb-marker", []);
    let notCx2 = "plain-string-selector";
  };
  
  let wrapper = CSS.make_labeled("wrapper", "css-e9zk30-wrapper", []);
  
  let _ = (Css.marker, Css.notCx2, wrapper);

  $ dune build
