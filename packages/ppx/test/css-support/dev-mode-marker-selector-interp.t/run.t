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
  [@css ".css-13dtv01{color:red;}"];
  [@css ".css-123fdlm.css-13dtv01{color:blue;}"];
  [@css.classes
    [
      ("css-13dtv01", 0, "Input.foo", "input.re", 8, 19, 8, 31),
      ("css-123fdlm", 1, "Input.bar", "input.re", 11, 2, 12, 0),
    ]
  ];
  [@css.bindings
    [("Input.foo", "css-13dtv01"), ("Input.bar", "css-123fdlm")]
  ];
  
  let foo = CSS.make("cx-foo css-13dtv01", []);
  
  let bar = CSS.make("cx-bar css-123fdlm", []);
  
  let _ = (foo, bar);

  $ dune build
