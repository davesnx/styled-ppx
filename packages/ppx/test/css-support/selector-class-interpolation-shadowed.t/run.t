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
  [@css ".a-tokvmb{color:red;}"];
  [@css ".a-14ksm7b{color:blue;}"];
  [@css ".a-191lhl1.id-1mvyff1{font-weight:bold;}"];
  [@css.bindings
    [
      ("Input.foo", "id-1mvyff1", "a-14ksm7b"),
      ("Input.bar", "id-1eelq62", "a-191lhl1"),
    ]
  ];
  
  let foo = CSS.make("label:foo id-zec317 a-tokvmb", []);
  let _ = foo;
  
  let foo = CSS.make("label:foo id-1mvyff1 a-14ksm7b", []);
  
  let bar = CSS.make("label:bar id-1eelq62 a-191lhl1", []);
  
  let _ = (foo, bar);

  $ dune build
