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
  [@css ".css-tokvmb{color:red;}"];
  [@css ".css-bjcoli{color:green;}"];
  [@css ".css-59bkuc.cid-1l23vtp{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "cid-1l23vtp", "css-bjcoli"),
      ("Input.wrapper", "cid-4f6ye3", "css-59bkuc"),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker cid-zr2uk1 css-tokvmb", []);
    let _ = marker;
  
    let marker = CSS.make("label:marker cid-1l23vtp css-bjcoli", []);
  };
  
  let wrapper = CSS.make("label:wrapper cid-4f6ye3 css-59bkuc", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
