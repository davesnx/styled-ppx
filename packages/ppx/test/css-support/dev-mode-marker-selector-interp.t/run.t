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
  [@css ".css-tokvmb-foo{color:red}"];
  [@css ".css-nghj5b-bar.css-tokvmb-foo{color:blue}"];
  [@css.bindings
    [("Input.foo", "css-tokvmb-foo"), ("Input.bar", "css-nghj5b-bar")]
  ];
  
  let foo = CSS.make("cx-foo css-tokvmb-foo", []);
  
  let bar = CSS.make("cx-bar css-nghj5b-bar", []);
  
  let _ = (foo, bar);

  $ dune build
