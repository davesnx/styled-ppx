Forward same-file submodule references are not resolved by the PPX. The
registry is populated as [%css] expands top-to-bottom, so users must move the
referenced submodule binding above the selector interpolation.

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
  [@css ".css-1narcho.\000Css.marker\000{color:blue;}"];
  [@css ".css-17viirv{color:red;}"];
  [@css.classes
    [
      ("css-1narcho", 0, "Input.wrapper", "input.re", 2, 2, 3, 0),
      ("css-17viirv", 1, "Input.Css.marker", "input.re", 6, 24, 6, 36),
    ]
  ];
  [@css.bindings
    [("Input.wrapper", "css-1narcho"), ("Input.Css.marker", "css-17viirv")]
  ];
  [@css.refs [("Css.marker", "input.re", 2, 6, 16)]];
  
  let _: CSS.styles = Css.marker;
  let wrapper = CSS.make("css-1narcho", []);
  
  module Css = {
    let marker = CSS.make("css-17viirv", []);
  };
  
  let _ = (wrapper, Css.marker);

  $ dune build
  File "input.re", line 2, characters 6-16:
  2 |   &.$(Css.marker) { color: blue; }
            ^^^^^^^^^^
  Error: Unbound module Css
  [1]
