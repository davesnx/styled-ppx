Same-file module aliases are expanded by selector interpolation. The resolver
knows `module Styles = Css`, so `$(Styles.marker)` resolves to the same class
chain as `$(Css.marker)` without emitting a cross-module sentinel.

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
  [@css ".css-155k9s5-wrapper.css-tokvmb-marker{color:blue;}"];
  [@css ".css-bjcoli-marker{color:green;}"];
  [@css ".css-1ejq12w-wrapper.css-bjcoli-marker{color:purple;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "css-tokvmb-marker"),
      ("Input.wrapper", "css-155k9s5-wrapper"),
      ("Input.Theme.Css.marker", "css-bjcoli-marker"),
      ("Input.Theme.wrapper", "css-1ejq12w-wrapper"),
    ]
  ];
  module Css = {
    let marker = CSS.make("css-tokvmb-marker", []);
  };
  
  module Styles = Css;
  
  let wrapper = CSS.make("css-155k9s5-wrapper", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("css-bjcoli-marker", []);
    };
  
    module Styles = Css;
  
    let wrapper = CSS.make("css-1ejq12w-wrapper", []);
  };
  
  let _ = (Css.marker, wrapper, Theme.Css.marker, Theme.wrapper);

  $ dune build
