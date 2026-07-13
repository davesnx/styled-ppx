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
  [@css ".css-59bkuc-wrapper.\000Css.marker\000{color:blue;}"];
  [@css ".css-tokvmb-marker{color:red;}"];
  [@css.bindings
    [
      ("Input.wrapper", "css-59bkuc-wrapper"),
      ("Input.Css.marker", "css-tokvmb-marker"),
    ]
  ];
  [@css.refs [("Css.marker", "input.re", 2, 6, 16)]];
  
  let _ = Css.marker;
  let wrapper = CSS.make("css-59bkuc-wrapper", []);
  
  module Css = {
    let marker = CSS.make("css-tokvmb-marker", []);
  };
  
  let _ = (wrapper, Css.marker);

  $ dune build
  File "input.re", line 2, characters 6-16:
  2 |   &.$(Css.marker) { color: blue; }
            ^^^^^^^^^^
  Error: Unbound module Css
  [1]
