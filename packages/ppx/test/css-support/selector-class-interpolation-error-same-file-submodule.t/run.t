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
  [@css ".css-tokvmb{color:red;}"];
  [@css ".css-e9zk30.plain-string-selector{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "cid-zr2uk1", "css-tokvmb"),
      ("Input.wrapper", "cid-4f6ye3", "css-e9zk30"),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker cid-zr2uk1 css-tokvmb", []);
    let notCx2 = "plain-string-selector";
  };
  
  let wrapper = CSS.make("label:wrapper cid-4f6ye3 css-e9zk30", []);
  
  let _ = (Css.marker, Css.notCx2, wrapper);

  $ dune build
