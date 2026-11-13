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
  [@css ".css-17viirv{color:red;}"];
  [@css ".css-xmvpm3.css-17viirv{color:blue;}"];
  [@css.classes
    [
      ("css-17viirv", 0, "Input.Css.marker", "input.re", 2, 24, 2, 36),
      ("css-xmvpm3", 1, "Input.wrapper", "input.re", 8, 2, 9, 0),
    ]
  ];
  [@css.bindings
    [("Input.Css.marker", "css-17viirv"), ("Input.wrapper", "css-xmvpm3")]
  ];
  module Css = {
    let marker = CSS.make("css-17viirv", []);
  };
  
  include Css;
  
  let wrapper = CSS.make("css-xmvpm3", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
