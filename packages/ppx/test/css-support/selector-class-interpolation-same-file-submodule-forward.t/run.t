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
  [@css
    (
      "._a_ye3jo4ed103.\000Css.marker\000{color:blue;}",
      "_a_ye3jo4ed103",
      "0,2,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)];
  [@css.bindings
    [
      ("Input.wrapper", "_id_cuy74s", "_a_ye3jo4ed103"),
      ("Input.Css.marker", "_id_gfnxs2", "_a_4ekvmb"),
    ]
  ];
  [@css.blocks [(1, "_id_cuy74s", [0]), (6, "_id_gfnxs2", [1])]];
  [@css.refs [("Css.marker", "input.re", 2, 6, 16)]];
  
  let _ = Css.marker;
  let wrapper = CSS.make("label:wrapper _id_cuy74s _a_ye3jo4ed103", []);
  
  module Css = {
    let marker = CSS.make("label:marker _id_gfnxs2 _a_4ekvmb", []);
  };
  
  let _ = (wrapper, Css.marker);

  $ dune build
  File "input.re", line 2, characters 6-16:
  2 |   &.$(Css.marker) { color: blue; }
            ^^^^^^^^^^
  Error: Unbound module Css
  [1]
