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
  [@css ".css-ivpcirv{color:red;}"];
  [@css ".css-ivpc9iy.css-ivpcirv{color:blue;}"];
  [@css ".css-ivpczog{color:green;}"];
  [@css ".css-ivpctqa.css-ivpczog{color:purple;}"];
  [@css.classes
    [
      ("css-ivpcirv", 0, "Input.Css.marker", "input.re", 2, 24, 2, 36),
      ("css-ivpc9iy", 1, "Input.wrapper", "input.re", 8, 2, 9, 0),
      ("css-ivpczog", 2, "Input.Theme.Css.marker", "input.re", 13, 26, 13, 40),
      ("css-ivpctqa", 3, "Input.Theme.wrapper", "input.re", 19, 4, 20, 2),
    ]
  ];
  [@css.bindings
    [
      ("Input.Css.marker", "css-ivpcirv"),
      ("Input.wrapper", "css-ivpc9iy"),
      ("Input.Theme.Css.marker", "css-ivpczog"),
      ("Input.Theme.wrapper", "css-ivpctqa"),
    ]
  ];
  module Css = {
    let marker = CSS.make("css-ivpcirv", []);
  };
  
  module Styles = Css;
  
  let wrapper = CSS.make("css-ivpc9iy", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("css-ivpczog", []);
    };
  
    module Styles = Css;
  
    let wrapper = CSS.make("css-ivpctqa", []);
  };
  
  let _ = (Css.marker, wrapper, Theme.Css.marker, Theme.wrapper);

  $ dune build
