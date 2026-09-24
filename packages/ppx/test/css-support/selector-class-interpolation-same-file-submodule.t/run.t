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
  [@css ".css-tokvmb{color:red;}"];
  [@css ".css-3qknr.cid-zr2uk1{color:orange;}"];
  [@css ".css-cb06ec.cid-zr2uk1{font-weight:bold;}"];
  [@css ".css-bjcoli{color:green;}"];
  [@css ".css-59bkuc.cid-11dmi54{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "cid-zr2uk1", "css-tokvmb"),
      ("Input.Css.wrapper", "cid-7sdyhq", "css-3qknr"),
      ("Input.wrapper", "cid-4f6ye3", "css-cb06ec"),
      ("Input.Theme.Css.marker", "cid-11dmi54", "css-bjcoli"),
      ("Input.Theme.Components.wrapper", "cid-1mhdtfv", "css-59bkuc"),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker cid-zr2uk1 css-tokvmb", []);
  
    let wrapper = CSS.make("label:wrapper cid-7sdyhq css-3qknr", []);
  };
  
  let wrapper = CSS.make("label:wrapper cid-4f6ye3 css-cb06ec", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("label:marker cid-11dmi54 css-bjcoli", []);
    };
  
    module Components = {
      let wrapper = CSS.make("label:wrapper cid-1mhdtfv css-59bkuc", []);
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
