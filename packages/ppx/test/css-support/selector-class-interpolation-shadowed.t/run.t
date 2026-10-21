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

`refmt` picks CRLF line ends when the first newline byte of its input (here
the binary AST) follows a `\r` byte, which can happen by chance in the
marshalled AST; `tr` keeps the output stable:

  $ dune describe pp ./input.re | tr -d '\r' | sed '1,/^];$/d'
  [@css "._a_4ekvmb{color:red;}"];
  [@css "._a_4esm7b{color:blue;}"];
  [@css "._a_tb8ov655m9solf9._id_1mvyff1{font-weight:bold;}"];
  [@css.bindings
    [
      ("Input.foo", "_id_1mvyff1", "_a_4esm7b"),
      ("Input.bar", "_id_1eelq62", "_a_tb8ov655m9solf9"),
    ]
  ];
  [@css.blocks
    [
      (5, "_id_zec317 _a_4ekvmb"),
      (8, "_id_1mvyff1 _a_4esm7b"),
      (10, "_id_1eelq62 _a_tb8ov655m9solf9"),
    ]
  ];
  
  let foo = CSS.make("label:foo _id_zec317 _a_4ekvmb", []);
  let _ = foo;
  
  let foo = CSS.make("label:foo _id_1mvyff1 _a_4esm7b", []);
  
  let bar = CSS.make("label:bar _id_1eelq62 _a_tb8ov655m9solf9", []);
  
  let _ = (foo, bar);

  $ dune build
