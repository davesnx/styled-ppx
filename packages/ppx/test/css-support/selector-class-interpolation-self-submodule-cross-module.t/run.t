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
  [@css ".css-tokvmb{color:red;}"];
  [@css ".css-59bkuc.\000Css.marker\000{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "cid-zr2uk1", "css-tokvmb"),
      ("Input.Css.wrapper", "cid-7sdyhq", "css-59bkuc"),
    ]
  ];
  [@css.refs [("Css.marker", "input.re", 5, 8, 18)]];
  
  let _ = Css.marker;
  module Css = {
    let marker = CSS.make(~label="marker", "cid-zr2uk1 css-tokvmb", []);
  
    let wrapper = CSS.make(~label="wrapper", "cid-7sdyhq css-59bkuc", []);
  };
  
  let _ = (Css.marker, Css.wrapper);

  $ dune build
  File "input.re", line 5, characters 8-18:
  5 |     &.$(Css.marker) { color: blue; }
              ^^^^^^^^^^
  Error: Unbound module Css
  [1]
