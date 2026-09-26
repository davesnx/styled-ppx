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
  [@css "._a_5r08qs{display:flex;}"];
  [@css "._a_6fq77g{gap:1rem;}"];
  [@css "._a_a8tv84efvbl._id_9un6he{color:red;}"];
  [@css.bindings
    [
      ("Input.composed", "_id_9un6he", "_a_5r08qs _a_6fq77g"),
      ("Input.user", "_id_wa05kx", "_a_a8tv84efvbl"),
    ]
  ];
  
  let composed = CSS.make("label:composed _id_9un6he _a_5r08qs _a_6fq77g", []);
  
  let user = CSS.make("label:user _id_wa05kx _a_a8tv84efvbl", []);
  
  let _ = (composed, user);

  $ dune build
