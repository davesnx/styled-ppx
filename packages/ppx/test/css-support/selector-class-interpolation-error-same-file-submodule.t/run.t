A dotted selector ref can resolve to an earlier string literal in a same-file
submodule instead of being emitted as a cross-module sentinel.

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
  [@css ".css-1d4qxpd.plain-string-selector{color:blue;}"];
  [@css.classes
    [
      ("css-17viirv", 0, "Input.Css.marker", "input.re", 2, 24, 2, 36),
      ("css-1d4qxpd", 1, "Input.wrapper", "input.re", 7, 2, 8, 0),
    ]
  ];
  [@css.bindings
    [("Input.Css.marker", "css-17viirv"), ("Input.wrapper", "css-1d4qxpd")]
  ];
  module Css = {
    let marker = CSS.make("css-17viirv", []);
    let notCx2 = "plain-string-selector";
  };
  
  let wrapper = CSS.make("css-1d4qxpd", []);
  
  let _ = (Css.marker, Css.notCx2, wrapper);

  $ dune build
