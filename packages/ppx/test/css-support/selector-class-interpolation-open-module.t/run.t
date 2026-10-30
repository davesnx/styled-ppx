Same-file open statements participate in selector interpolation. After
`open Css`, bare `$(marker)` resolves to the earlier `Css.marker` binding.

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
      "._a_qiu8x4e3zf2._id_gfnxs2{color:blue;}",
      "_a_qiu8x4e3zf2",
      "0,2,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css.bindings
    [
      ("Input.Css.marker", "_id_gfnxs2", "_a_4ekvmb"),
      ("Input.wrapper", "_id_cuy74s", "_a_qiu8x4e3zf2"),
    ]
  ];
  [@css.blocks [(2, "_id_gfnxs2", [0]), (8, "_id_cuy74s", [1])]];
  module Css = {
    let marker = CSS.make("label:marker _id_gfnxs2 _a_4ekvmb", []);
  };
  
  open Css;
  let _ = marker;
  
  let wrapper = CSS.make("label:wrapper _id_cuy74s _a_qiu8x4e3zf2", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
