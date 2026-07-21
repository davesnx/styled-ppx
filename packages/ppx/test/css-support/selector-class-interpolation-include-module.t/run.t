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
  [@css ".css-tokvmb-marker{color:red}"];
  [@css ".css-d0tg92-wrapper.css-tokvmb-marker{color:blue}"];
  [@css.bindings
    [
      ("Input.Css.marker", "css-tokvmb-marker"),
      ("Input.wrapper", "css-d0tg92-wrapper"),
    ]
  ];
  module Css = {
    let marker = CSS.make("css-tokvmb-marker", []);
  };
  
  include Css;
  
  let wrapper = CSS.make("css-d0tg92-wrapper", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
