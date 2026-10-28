The marker has zero effect on selector interpolation. Atom hashes,
extracted CSS, and resolved selectors are byte-identical between
--dev and no-flag runs. Only the first argument to CSS.make differs.

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
  [@css "._a_4ekvmb{color:red;}"];
  [@css "._a_y2fu14etqme._id_eealdg{color:blue;}"];
  [@css.bindings
    [
      ("Input.foo", "_id_eealdg", "_a_4ekvmb"),
      ("Input.bar", "_id_1wtvg3d", "_a_y2fu14etqme"),
    ]
  ];
  [@css.blocks
    [(8, "_id_eealdg _a_4ekvmb"), (10, "_id_1wtvg3d _a_y2fu14etqme")]
  ];
  
  let foo = CSS.make("label:foo _id_eealdg _a_4ekvmb", []);
  
  let bar = CSS.make("label:bar _id_1wtvg3d _a_y2fu14etqme", []);
  
  let _ = (foo, bar);

  $ dune build
