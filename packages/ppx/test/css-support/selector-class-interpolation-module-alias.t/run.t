Same-file module aliases are expanded by selector interpolation. The resolver
knows `module Styles = Css`, so `$(Styles.marker)` resolves to the same class
chain as `$(Css.marker)` without emitting a cross-module sentinel.

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
  [@css ".css-xq0zog{color:green;}"];
  [@css ".css-14vnctx.css-xq0zog{color:purple;}"];
  [@css.classes
    [
      ("css-17viirv", 0, "Input.Css.marker", "input.re", 2, 24, 2, 36),
      ("css-xmvpm3", 1, "Input.wrapper", "input.re", 8, 2, 9, 0),
      ("css-xq0zog", 2, "Input.Theme.Css.marker", "input.re", 13, 26, 13, 40),
      ("css-14vnctx", 3, "Input.Theme.wrapper", "input.re", 19, 4, 20, 2),
    ]
  ];
  [@css.bindings
    [
      ("Input.Css.marker", "css-17viirv"),
      ("Input.wrapper", "css-xmvpm3"),
      ("Input.Theme.Css.marker", "css-xq0zog"),
      ("Input.Theme.wrapper", "css-14vnctx"),
    ]
  ];
  module Css = {
    let marker = CSS.make("css-17viirv", []);
  };
  
  module Styles = Css;
  
  let wrapper = CSS.make("css-xmvpm3", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("css-xq0zog", []);
    };
  
    module Styles = Css;
  
    let wrapper = CSS.make("css-14vnctx", []);
  };
  
  let _ = (Css.marker, wrapper, Theme.Css.marker, Theme.wrapper);

  $ dune build
