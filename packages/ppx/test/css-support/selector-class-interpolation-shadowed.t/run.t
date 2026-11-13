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
  [@css ".css-13dtv01{color:red;}"];
  [@css ".css-1ry25t6{color:blue;}"];
  [@css ".css-1fl3tsb.css-1ry25t6{font-weight:bold;}"];
  [@css.classes
    [
      ("css-13dtv01", 0, "Input.foo", "input.re", 5, 19, 5, 31),
      ("css-1ry25t6", 1, "Input.foo", "input.re", 8, 19, 8, 32),
      ("css-1fl3tsb", 2, "Input.bar", "input.re", 11, 2, 12, 0),
    ]
  ];
  [@css.bindings
    [("Input.foo", "css-1ry25t6"), ("Input.bar", "css-1fl3tsb")]
  ];
  
  let foo = CSS.make("css-13dtv01", []);
  let _ = foo;
  
  let foo = CSS.make("css-1ry25t6", []);
  
  let bar = CSS.make("css-1fl3tsb", []);
  
  let _ = (foo, bar);

  $ dune build
