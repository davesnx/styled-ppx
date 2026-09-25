Same-file includes participate in selector interpolation. After `include Css`,
bare `$(marker)` resolves to the included `Css.marker` binding.

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
  [@css ".a-4ekvmb{color:red;}"];
  [@css ".a-i1f1s4e1kdg.id-zr2uk1{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "id-zr2uk1", "a-4ekvmb"),
      ("Input.wrapper", "id-4f6ye3", "a-i1f1s4e1kdg"),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker id-zr2uk1 a-4ekvmb", []);
  };
  
  include Css;
  
  let wrapper = CSS.make("label:wrapper id-4f6ye3 a-i1f1s4e1kdg", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
