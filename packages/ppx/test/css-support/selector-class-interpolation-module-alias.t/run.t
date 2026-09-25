Same-file module aliases are expanded by selector interpolation. The resolver
knows `module Styles = Css`, so `$(Styles.marker)` resolves to the same class
chain as `$(Css.marker)` without emitting a cross-module sentinel.

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
  [@css ".a-132sj4efbq8.id-zr2uk1{color:blue;}"];
  [@css ".a-4ecoli{color:green;}"];
  [@css ".a-wsszk4ewr87.id-11dmi54{color:purple;}"];
  [@css.bindings
    [
      ("Input.Css.marker", "id-zr2uk1", "a-4ekvmb"),
      ("Input.wrapper", "id-4f6ye3", "a-132sj4efbq8"),
      ("Input.Theme.Css.marker", "id-11dmi54", "a-4ecoli"),
      ("Input.Theme.wrapper", "id-q7k20t", "a-wsszk4ewr87"),
    ]
  ];
  module Css = {
    let marker = CSS.make("label:marker id-zr2uk1 a-4ekvmb", []);
  };
  
  module Styles = Css;
  
  let wrapper = CSS.make("label:wrapper id-4f6ye3 a-132sj4efbq8", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("label:marker id-11dmi54 a-4ecoli", []);
    };
  
    module Styles = Css;
  
    let wrapper = CSS.make("label:wrapper id-q7k20t a-wsszk4ewr87", []);
  };
  
  let _ = (Css.marker, wrapper, Theme.Css.marker, Theme.wrapper);

  $ dune build
