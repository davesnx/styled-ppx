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
  [@css ".a-tokvmb{color:red;}"];
  [@css ".a-bjcoli{color:green;}"];
  [@css ".a-59bkuc.id-1l23vtp{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "id-1l23vtp", "a-bjcoli"),
      ("Input.wrapper", "id-4f6ye3", "a-59bkuc"),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker id-zr2uk1 a-tokvmb", []);
    let _ = marker;
  
    let marker = CSS.make("label:marker id-1l23vtp a-bjcoli", []);
  };
  
  let wrapper = CSS.make("label:wrapper id-4f6ye3 a-59bkuc", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
