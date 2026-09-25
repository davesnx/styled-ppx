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
  [@css ".a-5r08qs{display:flex;}"];
  [@css ".a-6fq77g{gap:1rem;}"];
  [@css ".a-6z5xr4e0qm9.id-9un6he{color:red;}"];
  [@css.bindings
    [
      ("Input.composed", "id-9un6he", "a-5r08qs a-6fq77g"),
      ("Input.user", "id-wa05kx", "a-6z5xr4e0qm9"),
    ]
  ];
  
  let composed = CSS.make("label:composed id-9un6he a-5r08qs a-6fq77g", []);
  
  let user = CSS.make("label:user id-wa05kx a-6z5xr4e0qm9", []);
  
  let _ = (composed, user);

  $ dune build
