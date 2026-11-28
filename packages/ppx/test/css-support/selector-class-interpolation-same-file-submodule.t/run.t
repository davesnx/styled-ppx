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
  [@css ".css-ivpcirv{color:red;}"];
  [@css ".css-ivpco0n.css-ivpcirv{color:orange;}"];
  [@css ".css-ivpc6bm.css-ivpcirv{font-weight:bold;}"];
  [@css ".css-ivpczog{color:green;}"];
  [@css ".css-ivpcz4n.css-ivpczog{color:blue;}"];
  [@css.classes
    [
      ("css-ivpcirv", 0, "Input.Css.marker", "input.re", 2, 24, 2, 36),
      ("css-ivpco0n", 1, "Input.Css.wrapper", "input.re", 5, 4, 6, 2),
      ("css-ivpc6bm", 2, "Input.wrapper", "input.re", 10, 2, 11, 0),
      ("css-ivpczog", 3, "Input.Theme.Css.marker", "input.re", 15, 26, 15, 40),
      (
        "css-ivpcz4n",
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
      ("Input.Css.marker", "css-ivpcirv"),
      ("Input.Css.wrapper", "css-ivpco0n"),
      ("Input.wrapper", "css-ivpc6bm"),
      ("Input.Theme.Css.marker", "css-ivpczog"),
      ("Input.Theme.Components.wrapper", "css-ivpcz4n"),
    ]
  ];
  module Css = {
    let marker = CSS.make("css-ivpcirv", []);
  
    let wrapper = CSS.make("css-ivpco0n", []);
  };
  
  let wrapper = CSS.make("css-ivpc6bm", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("css-ivpczog", []);
    };
  
    module Components = {
      let wrapper = CSS.make("css-ivpcz4n", []);
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
