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
  [@css ".a-tokvmb{color:red;}"];
  [@css ".a-3qknr.id-zr2uk1{color:orange;}"];
  [@css ".a-cb06ec.id-zr2uk1{font-weight:bold;}"];
  [@css ".a-bjcoli{color:green;}"];
  [@css ".a-59bkuc.id-11dmi54{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "id-zr2uk1", "a-tokvmb"),
      ("Input.Css.wrapper", "id-7sdyhq", "a-3qknr"),
      ("Input.wrapper", "id-4f6ye3", "a-cb06ec"),
      ("Input.Theme.Css.marker", "id-11dmi54", "a-bjcoli"),
      ("Input.Theme.Components.wrapper", "id-1mhdtfv", "a-59bkuc"),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker id-zr2uk1 a-tokvmb", []);
  
    let wrapper = CSS.make("label:wrapper id-7sdyhq a-3qknr", []);
  };
  
  let wrapper = CSS.make("label:wrapper id-4f6ye3 a-cb06ec", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("label:marker id-11dmi54 a-bjcoli", []);
    };
  
    module Components = {
      let wrapper = CSS.make("label:wrapper id-1mhdtfv a-59bkuc", []);
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
