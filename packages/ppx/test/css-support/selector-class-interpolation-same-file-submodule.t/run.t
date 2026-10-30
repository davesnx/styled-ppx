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
  [@css ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)];
  [@css
    (
      "._a_qiu8x4eggk2._id_gfnxs2{color:orange;}",
      "_a_qiu8x4eggk2",
      "0,2,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_qiu8x655m9st0if._id_gfnxs2{font-weight:bold;}",
      "_a_qiu8x655m9st0if",
      "0,2,0 own",
      "221",
      262144,
      false,
    )
  ];
  [@css
    ("._a_4ecoli{color:green;}", "_a_4ecoli", "0,1,0 own", "158", 1, false)
  ];
  [@css
    (
      "._a_x5ved4ecubx._id_ing4zo{color:blue;}",
      "_a_x5ved4ecubx",
      "0,2,0 own",
      "158",
      1,
      false,
    )
  ];
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
      (2, "_id_gfnxs2", [0]),
      (4, "_id_1q350bi", [1]),
      (9, "_id_cuy74s", [2]),
      (15, "_id_ing4zo", [3]),
      (19, "_id_1uo6vb2", [4]),
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
