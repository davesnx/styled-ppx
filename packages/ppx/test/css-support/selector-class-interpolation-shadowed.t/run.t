Shadowing follows OCaml semantics: `&.$(foo)` resolves to the second
`let foo` binding (the one visible at the reference site).

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
  [@css "._a_4ekvmb{color:red;}"];
  [@css "._a_4esm7b{color:blue;}"];
  [@css "._a_tb8ov65m9solf9._id_1mvyff1{font-weight:bold;}"];
  [@css.bindings
    [
      ("Input.foo", "_id_1mvyff1", "_a_4esm7b"),
      ("Input.bar", "_id_1eelq62", "_a_tb8ov65m9solf9"),
    ]
  ];
  
  let foo = CSS.make("label:foo _id_zec317 _a_4ekvmb", []);
  let _ = foo;
  
  let foo = CSS.make("label:foo _id_1mvyff1 _a_4esm7b", []);
  
  let bar = CSS.make("label:bar _id_1eelq62 _a_tb8ov65m9solf9", []);
  
  let _ = (foo, bar);

  $ dune build
