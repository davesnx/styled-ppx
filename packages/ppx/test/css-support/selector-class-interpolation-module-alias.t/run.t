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
  [@css "._a_4ekvmb{color:red;}"];
  [@css "._a_qye7h4eikep._id_zr2uk1{color:blue;}"];
  [@css "._a_4ecoli{color:green;}"];
  [@css "._a_uisk84er06r._id_11dmi54{color:purple;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "_id_zr2uk1", "_a_4ekvmb"),
      ("Input.wrapper", "_id_4f6ye3", "_a_qye7h4eikep"),
      ("Input.Theme.Css.marker", "_id_11dmi54", "_a_4ecoli"),
      ("Input.Theme.wrapper", "_id_q7k20t", "_a_uisk84er06r"),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker _id_zr2uk1 _a_4ekvmb", []);
  };
  
  module Styles = Css;
  
  let wrapper = CSS.make("label:wrapper _id_4f6ye3 _a_qye7h4eikep", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("label:marker _id_11dmi54 _a_4ecoli", []);
    };
  
    module Styles = Css;
  
    let wrapper = CSS.make("label:wrapper _id_q7k20t _a_uisk84er06r", []);
  };
  
  let _ = (Css.marker, wrapper, Theme.Css.marker, Theme.wrapper);

  $ dune build
