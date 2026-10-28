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
  [@css "._a_4ekvmb{color:red;}"];
  [@css "._a_4ecoli{color:green;}"];
  [@css "._a_s54rq4eumiz._id_szwry8{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "_id_szwry8", "_a_4ecoli"),
      ("Input.wrapper", "_id_cuy74s", "_a_s54rq4eumiz"),
    ]
  ];
  [@css.blocks
    [
      (2, "_id_gfnxs2 _a_4ekvmb"),
      (5, "_id_szwry8 _a_4ecoli"),
      (8, "_id_cuy74s _a_s54rq4eumiz"),
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
