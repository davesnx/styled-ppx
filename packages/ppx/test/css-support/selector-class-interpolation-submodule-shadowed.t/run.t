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
  [@css "._a_daz5z4ei0c4._id_1l23vtp{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "_id_1l23vtp", "_a_4ecoli"),
      ("Input.wrapper", "_id_4f6ye3", "_a_daz5z4ei0c4"),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker _id_zr2uk1 _a_4ekvmb", []);
    let _ = marker;
  
    let marker = CSS.make("label:marker _id_1l23vtp _a_4ecoli", []);
  };
  
  let wrapper = CSS.make("label:wrapper _id_4f6ye3 _a_daz5z4ei0c4", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
