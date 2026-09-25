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
  [@css ".a-k008qs{display:flex;}"];
  [@css ".a-38zrbw{padding:12px;}"];
  [@css ".a-tokvmb{color:red;}"];
  [@css.bindings
    [
      ("Input.layout", "id-1jj5tmt", "a-k008qs a-38zrbw"),
      ("Input.button", "id-l55coe", "a-tokvmb"),
    ]
  ];
  
  let layout = CSS.make("label:layout id-1jj5tmt a-k008qs a-38zrbw", []);
  
  let button = CSS.make("label:button id-l55coe a-tokvmb", []);
  
  let _ = (layout, button);

  $ dune build
