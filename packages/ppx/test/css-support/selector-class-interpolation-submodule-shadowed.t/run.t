Same-file submodule binding shadowing follows structure order: a later
`let marker` inside `module Css` replaces the earlier binding for subsequent
`$(Css.marker)` selector refs.

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
  [@css ".css-bjcoli-marker{color:green}"];
  [@css ".css-1qkp8g0-wrapper.css-bjcoli-marker{color:blue}"];
  [@css.bindings
    [
      ("Input.Css.marker", "css-bjcoli-marker"),
      ("Input.wrapper", "css-1qkp8g0-wrapper"),
    ]
  ];
  module Css = {
    let marker = CSS.make("css-tokvmb-marker", []);
    let _ = marker;
  
    let marker = CSS.make("css-bjcoli-marker", []);
  };
  
  let wrapper = CSS.make("css-1qkp8g0-wrapper", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
