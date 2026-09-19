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
  [@css ".css-155k9s5-wrapper.cid-zr2uk1{color:blue;}"];
  [@css ".css-bjcoli-marker{color:green;}"];
  [@css ".css-1ejq12w-wrapper.cid-11dmi54{color:purple;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "cid-zr2uk1", "css-tokvmb-marker"),
      ("Input.wrapper", "cid-4f6ye3", "css-155k9s5-wrapper"),
      ("Input.Theme.Css.marker", "cid-11dmi54", "css-bjcoli-marker"),
      ("Input.Theme.wrapper", "cid-q7k20t", "css-1ejq12w-wrapper"),
    ]
  ];
  module Css = {
    let marker = CSS.make("cid-zr2uk1 css-tokvmb-marker", []);
  };
  
  module Styles = Css;
  
  let wrapper = CSS.make("cid-4f6ye3 css-155k9s5-wrapper", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("cid-11dmi54 css-bjcoli-marker", []);
    };
  
    module Styles = Css;
  
    let wrapper = CSS.make("cid-q7k20t css-1ejq12w-wrapper", []);
  };
  
  let _ = (Css.marker, wrapper, Theme.Css.marker, Theme.wrapper);

  $ dune build
