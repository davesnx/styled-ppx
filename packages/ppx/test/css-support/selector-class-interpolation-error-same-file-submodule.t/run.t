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
  [@css ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)];
  [@css
    (
      "._a_yvmv14evelu.plain-string-selector{color:blue;}",
      "_a_yvmv14evelu",
      "0,2,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css.bindings
    [
      ("Input.Css.marker", "_id_gfnxs2", "_a_4ekvmb"),
      ("Input.wrapper", "_id_cuy74s", "_a_yvmv14evelu"),
    ]
  ];
  [@css.blocks [(2, "_id_gfnxs2", [0]), (6, "_id_cuy74s", [1])]];
  module Css = {
    let marker = CSS.make("label:marker _id_gfnxs2 _a_4ekvmb", []);
    let notCx2 = "plain-string-selector";
  };
  
  let wrapper = CSS.make("label:wrapper _id_cuy74s _a_yvmv14evelu", []);
  
  let _ = (Css.marker, Css.notCx2, wrapper);

  $ dune build
