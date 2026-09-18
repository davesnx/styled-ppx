A multi-declaration source binding fans out into a compound chain
(`&.cssA.cssB`) when referenced by another [%css]'s selector.

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
  [@css ".css-k008qs-composed{display:flex}"];
  [@css ".css-1p7q77g-composed{gap:1rem}"];
  [@css ".css-tva6wk-user.css-k008qs-composed.css-1p7q77g-composed{color:red}"];
  [@css.bindings
    [
      ("Input.composed", "css-k008qs-composed css-1p7q77g-composed"),
      ("Input.user", "css-tva6wk-user"),
    ]
  ];
  
  let composed = CSS.make("css-k008qs-composed css-1p7q77g-composed", []);
  
  let user = CSS.make("css-tva6wk-user", []);
  
  let _ = (composed, user);

  $ dune build
