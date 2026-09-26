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
  [@css "._a_4ekvmb{color:red;}"];
  [@css "._a_qye7h4eikep._id_zr2uk1{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "_id_zr2uk1", "_a_4ekvmb"),
      ("Input.wrapper", "_id_4f6ye3", "_a_qye7h4eikep"),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker _id_zr2uk1 _a_4ekvmb", []);
  };
  
  open Css;
  let _ = marker;
  
  let wrapper = CSS.make("label:wrapper _id_4f6ye3 _a_qye7h4eikep", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
