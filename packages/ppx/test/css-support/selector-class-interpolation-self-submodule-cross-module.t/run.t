Inside `module Css`, `$(Css.marker)` is not a self-reference. The bare
`$(marker)` form is the local self-module reference; `$(Css.marker)` is treated
as an external path unless another enclosing `Css` module exists.

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
  [@css ".css-mx7mak.\000Css.marker\000{color:blue;}"];
  [@css.classes
    [
      ("css-17viirv", 0, "Input.Css.marker", "input.re", 2, 24, 2, 36),
      ("css-mx7mak", 1, "Input.Css.wrapper", "input.re", 5, 4, 6, 2),
    ]
  ];
  [@css.bindings
    [("Input.Css.marker", "css-17viirv"), ("Input.Css.wrapper", "css-mx7mak")]
  ];
  [@css.refs [("Css.marker", "input.re", 5, 8, 18)]];
  
  let _: CSS.styles = Css.marker;
  module Css = {
    let marker = CSS.make("css-17viirv", []);
  
    let wrapper = CSS.make("css-mx7mak", []);
  };
  
  let _ = (Css.marker, Css.wrapper);

  $ dune build
  File "input.re", line 5, characters 8-18:
  5 |     &.$(Css.marker) { color: blue; }
              ^^^^^^^^^^
  Error: Unbound module Css
  [1]
