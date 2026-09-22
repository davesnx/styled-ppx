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
  [@css ".css-tokvmb{color:red;}"];
  [@css ".css-14ksm7b{color:blue;}"];
  [@css ".css-191lhl1.cid-1mvyff1{font-weight:bold;}"];
  [@css.bindings
    [
      ("Input.foo", "cid-1mvyff1", "css-14ksm7b"),
      ("Input.bar", "cid-1eelq62", "css-191lhl1"),
    ]
  ];
  
  let foo = CSS.make(~label="foo", "cid-zec317 css-tokvmb", []);
  let _ = foo;
  
  let foo = CSS.make(~label="foo", "cid-1mvyff1 css-14ksm7b", []);
  
  let bar = CSS.make(~label="bar", "cid-1eelq62 css-191lhl1", []);
  
  let _ = (foo, bar);

  $ dune build
