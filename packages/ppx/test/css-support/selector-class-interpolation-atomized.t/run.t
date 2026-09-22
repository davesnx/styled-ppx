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
  [@css ".css-k008qs{display:flex;}"];
  [@css ".css-1p7q77g{gap:1rem;}"];
  [@css ".css-1ez0qm9.cid-9un6he{color:red;}"];
  [@css.bindings
    [
      ("Input.composed", "cid-9un6he", "css-k008qs css-1p7q77g"),
      ("Input.user", "cid-wa05kx", "css-1ez0qm9"),
    ]
  ];
  
  let composed =
    CSS.make(~label="composed", "cid-9un6he css-k008qs css-1p7q77g", []);
  
  let user = CSS.make(~label="user", "cid-wa05kx css-1ez0qm9", []);
  
  let _ = (composed, user);

  $ dune build
