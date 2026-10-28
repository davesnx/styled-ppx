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
  [@css "._a_qiu8x4e3zf2._id_gfnxs2{color:blue;}"];
  [@css "._a_4ecoli{color:green;}"];
  [@css "._a_x5ved4egfaw._id_ing4zo{color:purple;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "_id_gfnxs2", "_a_4ekvmb"),
      ("Input.wrapper", "_id_cuy74s", "_a_qiu8x4e3zf2"),
      ("Input.Theme.Css.marker", "_id_ing4zo", "_a_4ecoli"),
      ("Input.Theme.wrapper", "_id_1d9er5b", "_a_x5ved4egfaw"),
    ]
  ];
  [@css.blocks
    [
      (2, "_id_gfnxs2 _a_4ekvmb"),
      (7, "_id_cuy74s _a_qiu8x4e3zf2"),
      (13, "_id_ing4zo _a_4ecoli"),
      (18, "_id_1d9er5b _a_x5ved4egfaw"),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker _id_gfnxs2 _a_4ekvmb", []);
  };
  
  module Styles = Css;
  
  let wrapper = CSS.make("label:wrapper _id_cuy74s _a_qiu8x4e3zf2", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("label:marker _id_ing4zo _a_4ecoli", []);
    };
  
    module Styles = Css;
  
    let wrapper = CSS.make("label:wrapper _id_1d9er5b _a_x5ved4egfaw", []);
  };
  
  let _ = (Css.marker, wrapper, Theme.Css.marker, Theme.wrapper);

  $ dune build
