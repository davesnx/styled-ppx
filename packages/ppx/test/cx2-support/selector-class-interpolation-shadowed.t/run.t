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
  [@css ".css-tokvmb-foo{color:red;}"];
  [@css ".css-14ksm7b-foo{color:blue;}"];
  [@css ".css-191lhl1-bar.css-14ksm7b-foo{font-weight:bold;}"];
  [@css.bindings
    [("Input.foo", "css-14ksm7b-foo"), ("Input.bar", "css-191lhl1-bar")]
  ];
  
  let foo = CSS.make("css-tokvmb-foo", []);
  let _ = foo;
  
  let foo = CSS.make("css-14ksm7b-foo", []);
  
  let bar = CSS.make("css-191lhl1-bar", []);
  
  let _ = (foo, bar);

  $ dune build
