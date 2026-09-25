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
  [@css ".a-4ekvmb{color:red;}"];
  [@css ".a-132sj4et2ta.id-zr2uk1{color:orange;}"];
  [@css ".a-132sj65m9sktfg.id-zr2uk1{font-weight:bold;}"];
  [@css ".a-4ecoli{color:green;}"];
  [@css ".a-wsszk4e9d9a.id-11dmi54{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "id-zr2uk1", "a-4ekvmb"),
      ("Input.Css.wrapper", "id-7sdyhq", "a-132sj4et2ta"),
      ("Input.wrapper", "id-4f6ye3", "a-132sj65m9sktfg"),
      ("Input.Theme.Css.marker", "id-11dmi54", "a-4ecoli"),
      ("Input.Theme.Components.wrapper", "id-1mhdtfv", "a-wsszk4e9d9a"),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker id-zr2uk1 a-4ekvmb", []);
  
    let wrapper = CSS.make("label:wrapper id-7sdyhq a-132sj4et2ta", []);
  };
  
  let wrapper = CSS.make("label:wrapper id-4f6ye3 a-132sj65m9sktfg", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("label:marker id-11dmi54 a-4ecoli", []);
    };
  
    module Components = {
      let wrapper = CSS.make("label:wrapper id-1mhdtfv a-wsszk4e9d9a", []);
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
