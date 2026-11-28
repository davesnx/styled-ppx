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
  [@css ".css-ivpcirv{color:red;}"];
  [@css ".css-ivpc9iy.css-ivpcirv{color:blue;}"];
  [@css.classes
    [
      ("css-ivpcirv", 0, "Input.Css.marker", "input.re", 2, 24, 2, 36),
      ("css-ivpc9iy", 1, "Input.wrapper", "input.re", 9, 2, 10, 0),
    ]
  ];
  [@css.bindings
    [("Input.Css.marker", "css-ivpcirv"), ("Input.wrapper", "css-ivpc9iy")]
  ];
  module Css = {
    let marker = CSS.make("css-ivpcirv", []);
  };
  
  open Css;
  let _ = marker;
  
  let wrapper = CSS.make("css-ivpc9iy", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
