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
  [@css ".css-ivpcv01{color:red;}"];
  [@css ".css-ivpcutd.css-ivpcv01{color:blue;}"];
  [@css.classes
    [
      ("css-ivpcv01", 0, "Input.foo", "input.re", 8, 19, 8, 31),
      ("css-ivpcutd", 1, "Input.bar", "input.re", 11, 2, 12, 0),
    ]
  ];
  [@css.bindings
    [("Input.foo", "css-ivpcv01"), ("Input.bar", "css-ivpcutd")]
  ];
  
  let foo = CSS.make("cx-foo css-ivpcv01", []);
  
  let bar = CSS.make("cx-bar css-ivpcutd", []);
  
  let _ = (foo, bar);

  $ dune build
