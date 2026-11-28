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
  [@css ".css-ivpcv01{color:red;}"];
  [@css ".css-ivpc5t6{color:blue;}"];
  [@css ".css-ivpc1fg.css-ivpc5t6{font-weight:bold;}"];
  [@css.classes
    [
      ("css-ivpcv01", 0, "Input.foo", "input.re", 5, 19, 5, 31),
      ("css-ivpc5t6", 1, "Input.foo", "input.re", 8, 19, 8, 32),
      ("css-ivpc1fg", 2, "Input.bar", "input.re", 11, 2, 12, 0),
    ]
  ];
  [@css.bindings
    [("Input.foo", "css-ivpc5t6"), ("Input.bar", "css-ivpc1fg")]
  ];
  
  let foo = CSS.make("css-ivpcv01", []);
  let _ = foo;
  
  let foo = CSS.make("css-ivpc5t6", []);
  
  let bar = CSS.make("css-ivpc1fg", []);
  
  let _ = (foo, bar);

  $ dune build
