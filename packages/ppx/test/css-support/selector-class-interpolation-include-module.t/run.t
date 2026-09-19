Same-file includes participate in selector interpolation. After `include Css`,
bare `$(marker)` resolves to the included `Css.marker` binding.

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
  [@css ".css-ik1kdg-wrapper.cid-zr2uk1{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "cid-zr2uk1", "css-tokvmb-marker"),
      ("Input.wrapper", "cid-4f6ye3", "css-ik1kdg-wrapper"),
    ]
  ];
  module Css = {
    let marker = CSS.make("cid-zr2uk1 css-tokvmb-marker", []);
  };
  
  include Css;
  
  let wrapper = CSS.make("cid-4f6ye3 css-ik1kdg-wrapper", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
