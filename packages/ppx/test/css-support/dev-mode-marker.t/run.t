When the PPX is invoked with --dev, every named [%css] binding gets a
leading `label:<name>` marker class. The marker is a plain string token
prepended to the className list inside CSS.make; it is not emitted as
a CSS rule.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx -- --dev)))
  > EOF

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css ".a-5r08qs{display:flex;}"];
  [@css ".a-94zrbw{padding:12px;}"];
  [@css ".a-4ekvmb{color:red;}"];
  [@css.bindings
    [
      ("Input.layout", "id-1jj5tmt", "a-5r08qs a-94zrbw"),
      ("Input.button", "id-l55coe", "a-4ekvmb"),
    ]
  ];
  
  let layout = CSS.make("label:layout id-1jj5tmt a-5r08qs a-94zrbw", []);
  
  let button = CSS.make("label:button id-l55coe a-4ekvmb", []);
  
  let _ = (layout, button);

  $ dune build
