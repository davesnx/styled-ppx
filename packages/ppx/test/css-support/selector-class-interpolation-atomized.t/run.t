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
  [@css ".a-k008qs{display:flex;}"];
  [@css ".a-1p7q77g{gap:1rem;}"];
  [@css ".a-1ez0qm9.id-9un6he{color:red;}"];
  [@css.bindings
    [
      ("Input.composed", "id-9un6he", "a-k008qs a-1p7q77g"),
      ("Input.user", "id-wa05kx", "a-1ez0qm9"),
    ]
  ];
  
  let composed = CSS.make("label:composed id-9un6he a-k008qs a-1p7q77g", []);
  
  let user = CSS.make("label:user id-wa05kx a-1ez0qm9", []);
  
  let _ = (composed, user);

  $ dune build
