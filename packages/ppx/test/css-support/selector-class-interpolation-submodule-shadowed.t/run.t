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
  [@css ".css-tokvmb-marker{color:red;}"];
  [@css ".css-bjcoli-marker{color:green;}"];
  [@css ".css-59bkuc-wrapper.cid-1l23vtp{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "cid-1l23vtp", "css-bjcoli-marker"),
      ("Input.wrapper", "cid-4f6ye3", "css-59bkuc-wrapper"),
    ]
  ];
  module Css = {
    let marker = CSS.make("cid-zr2uk1 css-tokvmb-marker", []);
    let _ = marker;
  
    let marker = CSS.make("cid-1l23vtp css-bjcoli-marker", []);
  };
  
  let wrapper = CSS.make("cid-4f6ye3 css-59bkuc-wrapper", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
