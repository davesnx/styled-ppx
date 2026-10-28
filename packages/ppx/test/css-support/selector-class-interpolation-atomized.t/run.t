A multi-declaration source binding resolves to its single identity class
when referenced by another [%css]'s selector.

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
  [@css
    ("._a_5r08qs{display:flex;}", "_a_5r08qs", "0,1,0 own", "207", 1, false)
  ];
  [@css ("._a_6fq77g{gap:1rem;}", "_a_6fq77g", "0,1,0 own", "231", 3, false)];
  [@css
    (
      "._a_7kpvt4e767h._id_4w7g4z{color:red;}",
      "_a_7kpvt4e767h",
      "0,2,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css.bindings
    [
      ("Input.composed", "_id_4w7g4z", "_a_5r08qs _a_6fq77g"),
      ("Input.user", "_id_1hno2d0", "_a_7kpvt4e767h"),
    ]
  ];
  [@css.blocks [(8, "_id_4w7g4z", [0, 1]), (13, "_id_1hno2d0", [2])]];
  
  let composed = CSS.make("label:composed _id_4w7g4z _a_5r08qs _a_6fq77g", []);
  
  let user = CSS.make("label:user _id_1hno2d0 _a_7kpvt4e767h", []);
  
  let _ = (composed, user);

  $ dune build
