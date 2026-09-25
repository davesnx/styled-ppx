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
  [@css ".a-i1f1s4eqknr.id-zr2uk1{color:orange;}"];
  [@css ".a-nifi365m9s06ec.id-zr2uk1{font-weight:bold;}"];
  [@css ".a-4ecoli{color:green;}"];
  [@css ".a-nifi34ebkuc.id-11dmi54{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "id-zr2uk1", "a-4ekvmb"),
      ("Input.Css.wrapper", "id-7sdyhq", "a-i1f1s4eqknr"),
      ("Input.wrapper", "id-4f6ye3", "a-nifi365m9s06ec"),
      ("Input.Theme.Css.marker", "id-11dmi54", "a-4ecoli"),
      ("Input.Theme.Components.wrapper", "id-1mhdtfv", "a-nifi34ebkuc"),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker id-zr2uk1 a-4ekvmb", []);
  
    let wrapper = CSS.make("label:wrapper id-7sdyhq a-i1f1s4eqknr", []);
  };
  
  let wrapper = CSS.make("label:wrapper id-4f6ye3 a-nifi365m9s06ec", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("label:marker id-11dmi54 a-4ecoli", []);
    };
  
    module Components = {
      let wrapper = CSS.make("label:wrapper id-1mhdtfv a-nifi34ebkuc", []);
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
