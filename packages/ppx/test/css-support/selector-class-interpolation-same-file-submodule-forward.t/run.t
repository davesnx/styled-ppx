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
  [@css ".a-nifi34ebkuc.\000Css.marker\000{color:blue;}"];
  [@css ".a-4ekvmb{color:red;}"];
  [@css.bindings
    [
      ("Input.wrapper", "id-4f6ye3", "a-nifi34ebkuc"),
      ("Input.Css.marker", "id-zr2uk1", "a-4ekvmb"),
    ]
  ];
  [@css.refs [("Css.marker", "input.re", 2, 6, 16)]];
  
  let _ = Css.marker;
  let wrapper = CSS.make("label:wrapper id-4f6ye3 a-nifi34ebkuc", []);
  
  module Css = {
    let marker = CSS.make("label:marker id-zr2uk1 a-4ekvmb", []);
  };
  
  let _ = (wrapper, Css.marker);

  $ dune build
  File "input.re", line 2, characters 6-16:
  2 |   &.$(Css.marker) { color: blue; }
            ^^^^^^^^^^
  Error: Unbound module Css
  [1]
