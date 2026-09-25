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
  [@css ".a-tokvmb{color:red;}"];
  [@css ".a-11o9qin.id-zec317{color:blue;}"];
  [@css.bindings
    [
      ("Input.foo", "id-zec317", "a-tokvmb"),
      ("Input.bar", "id-1eelq62", "a-11o9qin"),
    ]
  ];
  
  let foo = CSS.make("label:foo id-zec317 a-tokvmb", []);
  
  let bar = CSS.make("label:bar id-1eelq62 a-11o9qin", []);
  
  let _ = (foo, bar);

  $ dune build
