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
  [@css ".css-3qknr-wrapper.cid-zr2uk1{color:orange;}"];
  [@css ".css-cb06ec-wrapper.cid-zr2uk1{font-weight:bold;}"];
  [@css ".css-bjcoli-marker{color:green;}"];
  [@css ".css-59bkuc-wrapper.cid-11dmi54{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "cid-zr2uk1", "css-tokvmb-marker"),
      ("Input.Css.wrapper", "cid-7sdyhq", "css-3qknr-wrapper"),
      ("Input.wrapper", "cid-4f6ye3", "css-cb06ec-wrapper"),
      ("Input.Theme.Css.marker", "cid-11dmi54", "css-bjcoli-marker"),
      ("Input.Theme.Components.wrapper", "cid-1mhdtfv", "css-59bkuc-wrapper"),
    ]
  ];
  module Css = {
    let marker = CSS.make("cid-zr2uk1 css-tokvmb-marker", []);
  
    let wrapper = CSS.make("cid-7sdyhq css-3qknr-wrapper", []);
  };
  
  let wrapper = CSS.make("cid-4f6ye3 css-cb06ec-wrapper", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("cid-11dmi54 css-bjcoli-marker", []);
    };
  
    module Components = {
      let wrapper = CSS.make("cid-1mhdtfv css-59bkuc-wrapper", []);
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
