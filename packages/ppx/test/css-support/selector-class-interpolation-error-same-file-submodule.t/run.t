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
  [@css ".css-tokvmb-marker{color:red}"];
  [@css ".css-14aft6z-wrapper.plain-string-selector{color:blue}"];
  [@css.bindings
    [
      ("Input.Css.marker", "css-tokvmb-marker"),
      ("Input.wrapper", "css-14aft6z-wrapper"),
    ]
  ];
  module Css = {
    let marker = CSS.make("css-tokvmb-marker", []);
    let notCx2 = "plain-string-selector";
  };
  
  let wrapper = CSS.make("css-14aft6z-wrapper", []);
  
  let _ = (Css.marker, Css.notCx2, wrapper);

  $ dune build
