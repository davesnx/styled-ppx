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
  [@css ".css-tokvmb-marker{color:red;}"];
  [@css ".css-3qknr-wrapper.css-tokvmb-marker{color:orange;}"];
  [@css ".css-cb06ec-wrapper.css-tokvmb-marker{font-weight:bold;}"];
  [@css ".css-bjcoli-marker{color:green;}"];
  [@css ".css-59bkuc-wrapper.css-bjcoli-marker{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "css-tokvmb-marker"),
      ("Input.Css.wrapper", "css-3qknr-wrapper"),
      ("Input.wrapper", "css-cb06ec-wrapper"),
      ("Input.Theme.Css.marker", "css-bjcoli-marker"),
      ("Input.Theme.Components.wrapper", "css-59bkuc-wrapper"),
    ]
  ];
  module Css = {
    let marker = CSS.make_labeled("marker", "css-tokvmb-marker", []);
  
    let wrapper = CSS.make_labeled("wrapper", "css-3qknr-wrapper", []);
  };
  
  let wrapper = CSS.make_labeled("wrapper", "css-cb06ec-wrapper", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make_labeled("marker", "css-bjcoli-marker", []);
    };
  
    module Components = {
      let wrapper = CSS.make_labeled("wrapper", "css-59bkuc-wrapper", []);
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
