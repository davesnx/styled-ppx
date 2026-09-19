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
  [@css ".css-tokvmb{color:red;}"];
  [@css ".css-11o9qin.cid-zec317{color:blue;}"];
  [@css.bindings
    [
      ("Input.foo", "cid-zec317", "css-tokvmb"),
      ("Input.bar", "cid-1eelq62", "css-11o9qin"),
    ]
  ];
  
  let foo = CSS.make("cx-foo cid-zec317 css-tokvmb", []);
  
  let bar = CSS.make("cx-bar cid-1eelq62 css-11o9qin", []);
  
  let _ = (foo, bar);

  $ dune build
