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
  [@css ".css-ivpcirv{color:red;}"];
  [@css ".css-ivpckmd{color:green;}"];
  [@css ".css-ivpcs2j.css-ivpckmd{color:blue;}"];
  [@css.classes
    [
      ("css-ivpcirv", 0, "Input.Css.marker", "input.re", 2, 24, 2, 36),
      ("css-ivpckmd", 1, "Input.Css.marker", "input.re", 5, 24, 5, 38),
      ("css-ivpcs2j", 2, "Input.wrapper", "input.re", 9, 2, 10, 0),
    ]
  ];
  [@css.bindings
    [("Input.Css.marker", "css-ivpckmd"), ("Input.wrapper", "css-ivpcs2j")]
  ];
  module Css = {
    let marker = CSS.make("css-ivpcirv", []);
    let _ = marker;
  
    let marker = CSS.make("css-ivpckmd", []);
  };
  
  let wrapper = CSS.make("css-ivpcs2j", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
