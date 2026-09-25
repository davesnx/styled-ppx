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
  [@css ".a-tokvmb{color:red;}"];
  [@css ".a-ik1kdg.id-zr2uk1{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "id-zr2uk1", "a-tokvmb"),
      ("Input.wrapper", "id-4f6ye3", "a-ik1kdg"),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker id-zr2uk1 a-tokvmb", []);
  };
  
  open Css;
  let _ = marker;
  
  let wrapper = CSS.make("label:wrapper id-4f6ye3 a-ik1kdg", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
