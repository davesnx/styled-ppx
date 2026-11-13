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
  [@css ".css-17viirv{color:red;}"];
  [@css ".css-xmvpm3.css-17viirv{color:blue;}"];
  [@css.classes
    [
      ("css-17viirv", 0, "Input.Css.marker", "input.re", 2, 24, 2, 36),
      ("css-xmvpm3", 1, "Input.wrapper", "input.re", 9, 2, 10, 0),
    ]
  ];
  [@css.bindings
    [("Input.Css.marker", "css-17viirv"), ("Input.wrapper", "css-xmvpm3")]
  ];
  module Css = {
    let marker = CSS.make("css-17viirv", []);
  };
  
  open Css;
  let _ = marker;
  
  let wrapper = CSS.make("css-xmvpm3", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
