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
  [@css ".a-4ekvmb{color:red;}"];
  [@css ".a-yvmv14evelu.plain-string-selector{color:blue;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "id-zr2uk1", "a-4ekvmb"),
      ("Input.wrapper", "id-4f6ye3", "a-yvmv14evelu"),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker id-zr2uk1 a-4ekvmb", []);
    let notCx2 = "plain-string-selector";
  };
  
  let wrapper = CSS.make("label:wrapper id-4f6ye3 a-yvmv14evelu", []);
  
  let _ = (Css.marker, Css.notCx2, wrapper);

  $ dune build
