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
  [@css ".css-tokvmb-marker{color:red;}"];
  [@css ".css-59bkuc-wrapper.\000Css.marker\000{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "css-tokvmb-marker"),
      ("Input.Css.wrapper", "css-59bkuc-wrapper"),
    ]
  ];
  [@css.refs [("Css.marker", "input.re", 2, 8, 18)]];
  
  let _ = Css.marker;
  module Css = {
    let marker = CSS.make("css-tokvmb-marker", []);
  
    let wrapper = CSS.make("css-59bkuc-wrapper", []);
  };
  
  let _ = (Css.marker, Css.wrapper);

  $ dune build
  File "input.re", line 2, characters 8-18:
  2 | ........s = {
  2 |   le....................................
  Error: Unbound module Css
  [1]
