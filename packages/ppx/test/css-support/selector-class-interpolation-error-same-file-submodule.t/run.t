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
  [@css ".css-ivpcirv{color:red;}"];
  [@css ".css-ivpcxpd.plain-string-selector{color:blue;}"];
  [@css.classes
    [
      ("css-ivpcirv", 0, "Input.Css.marker", "input.re", 2, 24, 2, 36),
      ("css-ivpcxpd", 1, "Input.wrapper", "input.re", 7, 2, 8, 0),
    ]
  ];
  [@css.bindings
    [("Input.Css.marker", "css-ivpcirv"), ("Input.wrapper", "css-ivpcxpd")]
  ];
  module Css = {
    let marker = CSS.make("css-ivpcirv", []);
    let notCx2 = "plain-string-selector";
  };
  
  let wrapper = CSS.make("css-ivpcxpd", []);
  
  let _ = (Css.marker, Css.notCx2, wrapper);

  $ dune build
