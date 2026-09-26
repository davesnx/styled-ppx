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
  [@css "._a_4ekvmb{color:red;}"];
  [@css "._a_ye3jo4ed103.\000Css.marker\000{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "_id_zr2uk1", "_a_4ekvmb"),
      ("Input.Css.wrapper", "_id_7sdyhq", "_a_ye3jo4ed103"),
    ]
  ];
  [@css.refs [("Css.marker", "input.re", 5, 8, 18)]];
  
  let _ = Css.marker;
  module Css = {
    let marker = CSS.make("label:marker _id_zr2uk1 _a_4ekvmb", []);
  
    let wrapper = CSS.make("label:wrapper _id_7sdyhq _a_ye3jo4ed103", []);
  };
  
  let _ = (Css.marker, Css.wrapper);

  $ dune build
  File "input.re", line 5, characters 8-18:
  5 |     &.$(Css.marker) { color: blue; }
              ^^^^^^^^^^
  Error: Unbound module Css
  [1]
