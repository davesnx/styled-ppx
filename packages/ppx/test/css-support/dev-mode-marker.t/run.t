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
  [@css ".css-k008qs{display:flex;}"];
  [@css ".css-38zrbw{padding:12px;}"];
  [@css ".css-tokvmb{color:red;}"];
  [@css.bindings
    [
      ("Input.layout", "cid-1jj5tmt", "css-k008qs css-38zrbw"),
      ("Input.button", "cid-l55coe", "css-tokvmb"),
    ]
  ];
  
  let layout = CSS.make("label:layout cid-1jj5tmt css-k008qs css-38zrbw", []);
  
  let button = CSS.make("label:button cid-l55coe css-tokvmb", []);
  
  let _ = (layout, button);

  $ dune build
