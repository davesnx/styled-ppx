Same-file submodule selector interpolation resolves locally instead of being
emitted as a cross-module sentinel.

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
  [@css ".css-4z026w.css-17viirv{color:orange;}"];
  [@css ".css-dkrqj9.css-17viirv{font-weight:bold;}"];
  [@css ".css-xq0zog{color:green;}"];
  [@css ".css-pmdyxz.css-xq0zog{color:blue;}"];
  [@css.classes
    [
      ("css-17viirv", 0, "Input.Css.marker", "input.re", 2, 24, 2, 36),
      ("css-4z026w", 1, "Input.Css.wrapper", "input.re", 5, 4, 6, 2),
      ("css-dkrqj9", 2, "Input.wrapper", "input.re", 10, 2, 11, 0),
      ("css-xq0zog", 3, "Input.Theme.Css.marker", "input.re", 15, 26, 15, 40),
      (
        "css-pmdyxz",
        4,
        "Input.Theme.Components.wrapper",
        "input.re",
        20,
        6,
        21,
        4,
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.Css.marker", "css-17viirv"),
      ("Input.Css.wrapper", "css-4z026w"),
      ("Input.wrapper", "css-dkrqj9"),
      ("Input.Theme.Css.marker", "css-xq0zog"),
      ("Input.Theme.Components.wrapper", "css-pmdyxz"),
    ]
  ];
  module Css = {
    let marker = CSS.make("css-17viirv", []);
  
    let wrapper = CSS.make("css-4z026w", []);
  };
  
  let wrapper = CSS.make("css-dkrqj9", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("css-xq0zog", []);
    };
  
    module Components = {
      let wrapper = CSS.make("css-pmdyxz", []);
    };
  };
  
  let _ = (
    Css.marker,
    Css.wrapper,
    wrapper,
    Theme.Css.marker,
    Theme.Components.wrapper,
  );

  $ dune build
