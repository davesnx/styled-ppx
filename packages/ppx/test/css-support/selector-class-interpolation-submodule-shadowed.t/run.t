Same-file submodule binding shadowing follows structure order: a later
`let marker` inside `module Css` replaces the earlier binding for subsequent
`$(Css.marker)` selector refs.

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
    ("._a_4ecoli{color:green;}", "_a_4ecoli", "0,1,0 own", "158", 1, false)
  ];
  [@css
    (
      "._a_s54rq4eumiz._id_szwry8{color:blue;}",
      "_a_s54rq4eumiz",
      "0,2,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css.bindings
    [
      ("Input.Css.marker", "_id_szwry8", "_a_4ecoli"),
      ("Input.wrapper", "_id_cuy74s", "_a_s54rq4eumiz"),
    ]
  ];
  [@css.blocks
    [
      (2, "_id_gfnxs2", [0]),
      (5, "_id_szwry8", [1]),
      (8, "_id_cuy74s", [2]),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker _id_gfnxs2 _a_4ekvmb", []);
    let _ = marker;
  
    let marker = CSS.make("label:marker _id_szwry8 _a_4ecoli", []);
  };
  
  let wrapper = CSS.make("label:wrapper _id_cuy74s _a_s54rq4eumiz", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
