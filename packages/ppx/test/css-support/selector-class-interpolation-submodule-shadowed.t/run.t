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
  [@css ".css-17viirv{color:red;}"];
  [@css ".css-icpkmd{color:green;}"];
  [@css ".css-18ypuov.css-icpkmd{color:blue;}"];
  [@css.classes
    [
      ("css-17viirv", 0, "Input.Css.marker", "input.re", 2, 24, 2, 36),
      ("css-icpkmd", 1, "Input.Css.marker", "input.re", 5, 24, 5, 38),
      ("css-18ypuov", 2, "Input.wrapper", "input.re", 9, 2, 10, 0),
    ]
  ];
  [@css.bindings
    [("Input.Css.marker", "css-icpkmd"), ("Input.wrapper", "css-18ypuov")]
  ];
  module Css = {
    let marker = CSS.make("css-17viirv", []);
    let _ = marker;
  
    let marker = CSS.make("css-icpkmd", []);
  };
  
  let wrapper = CSS.make("css-18ypuov", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
