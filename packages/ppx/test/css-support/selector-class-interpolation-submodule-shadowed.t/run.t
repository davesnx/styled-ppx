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
  [@css ".a-4ekvmb{color:red;}"];
  [@css ".a-4ecoli{color:green;}"];
  [@css ".a-nifi34ebkuc.id-1l23vtp{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "id-1l23vtp", "a-4ecoli"),
      ("Input.wrapper", "id-4f6ye3", "a-nifi34ebkuc"),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker id-zr2uk1 a-4ekvmb", []);
    let _ = marker;
  
    let marker = CSS.make("label:marker id-1l23vtp a-4ecoli", []);
  };
  
  let wrapper = CSS.make("label:wrapper id-4f6ye3 a-nifi34ebkuc", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
