Same-file submodule selector interpolation resolves locally instead of being
emitted as a cross-module sentinel.

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
  [@css ".css-1d10kse-wrapper.css-tokvmb-marker{color:orange}"];
  [@css ".css-r94a22-wrapper.css-tokvmb-marker{font-weight:bold}"];
  [@css ".css-bjcoli-marker{color:green}"];
  [@css ".css-1qkp8g0-wrapper.css-bjcoli-marker{color:blue}"];
  [@css.bindings
    [
      ("Input.Css.marker", "css-tokvmb-marker"),
      ("Input.Css.wrapper", "css-1d10kse-wrapper"),
      ("Input.wrapper", "css-r94a22-wrapper"),
      ("Input.Theme.Css.marker", "css-bjcoli-marker"),
      ("Input.Theme.Components.wrapper", "css-1qkp8g0-wrapper"),
    ]
  ];
  module Css = {
    let marker = CSS.make("css-tokvmb-marker", []);
  
    let wrapper = CSS.make("css-1d10kse-wrapper", []);
  };
  
  let wrapper = CSS.make("css-r94a22-wrapper", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("css-bjcoli-marker", []);
    };
  
    module Components = {
      let wrapper = CSS.make("css-1qkp8g0-wrapper", []);
    };
  };
  
  let _ = (
    Css.marker,
    Css.wrapper,
    wrapper,
    Theme.Css.marker,
    Theme.Components.wrapper,
  );

  $ dune build
