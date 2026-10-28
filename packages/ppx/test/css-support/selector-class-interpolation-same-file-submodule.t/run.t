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
  [@css "._a_qiu8x4eggk2._id_gfnxs2{color:orange;}"];
  [@css "._a_qiu8x655m9st0if._id_gfnxs2{font-weight:bold;}"];
  [@css "._a_4ecoli{color:green;}"];
  [@css "._a_x5ved4ecubx._id_ing4zo{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "_id_gfnxs2", "_a_4ekvmb"),
      ("Input.Css.wrapper", "_id_1q350bi", "_a_qiu8x4eggk2"),
      ("Input.wrapper", "_id_cuy74s", "_a_qiu8x655m9st0if"),
      ("Input.Theme.Css.marker", "_id_ing4zo", "_a_4ecoli"),
      ("Input.Theme.Components.wrapper", "_id_1uo6vb2", "_a_x5ved4ecubx"),
    ]
  ];
  [@css.blocks
    [
      (2, "_id_gfnxs2 _a_4ekvmb"),
      (4, "_id_1q350bi _a_qiu8x4eggk2"),
      (9, "_id_cuy74s _a_qiu8x655m9st0if"),
      (15, "_id_ing4zo _a_4ecoli"),
      (19, "_id_1uo6vb2 _a_x5ved4ecubx"),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker _id_gfnxs2 _a_4ekvmb", []);
  
    let wrapper = CSS.make("label:wrapper _id_1q350bi _a_qiu8x4eggk2", []);
  };
  
  let wrapper = CSS.make("label:wrapper _id_cuy74s _a_qiu8x655m9st0if", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("label:marker _id_ing4zo _a_4ecoli", []);
    };
  
    module Components = {
      let wrapper = CSS.make("label:wrapper _id_1uo6vb2 _a_x5ved4ecubx", []);
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
