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
  [@css "._a_8s8tj4em6j7._id_zec317{color:blue;}"];
  [@css.bindings
    [
      ("Input.foo", "_id_zec317", "_a_4ekvmb"),
      ("Input.bar", "_id_1eelq62", "_a_8s8tj4em6j7"),
    ]
  ];
  
  let foo = CSS.make("label:foo _id_zec317 _a_4ekvmb", []);
  
  let bar = CSS.make("label:bar _id_1eelq62 _a_8s8tj4em6j7", []);
  
  let _ = (foo, bar);

  $ dune build
