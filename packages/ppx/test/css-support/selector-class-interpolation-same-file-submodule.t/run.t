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
  [@css "._a_4ekvmb{color:red;}"];
  [@css "._a_qye7h4e56b5._id_zr2uk1{color:orange;}"];
  [@css "._a_qye7h65m9ssyz4._id_zr2uk1{font-weight:bold;}"];
  [@css "._a_4ecoli{color:green;}"];
  [@css "._a_uisk84e7jnm._id_11dmi54{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "_id_zr2uk1", "_a_4ekvmb"),
      ("Input.Css.wrapper", "_id_7sdyhq", "_a_qye7h4e56b5"),
      ("Input.wrapper", "_id_4f6ye3", "_a_qye7h65m9ssyz4"),
      ("Input.Theme.Css.marker", "_id_11dmi54", "_a_4ecoli"),
      ("Input.Theme.Components.wrapper", "_id_1mhdtfv", "_a_uisk84e7jnm"),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker _id_zr2uk1 _a_4ekvmb", []);
  
    let wrapper = CSS.make("label:wrapper _id_7sdyhq _a_qye7h4e56b5", []);
  };
  
  let wrapper = CSS.make("label:wrapper _id_4f6ye3 _a_qye7h65m9ssyz4", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("label:marker _id_11dmi54 _a_4ecoli", []);
    };
  
    module Components = {
      let wrapper = CSS.make("label:wrapper _id_1mhdtfv _a_uisk84e7jnm", []);
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
