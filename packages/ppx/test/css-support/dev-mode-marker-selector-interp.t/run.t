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
  [@css ".a-4ekvmb{color:red;}"];
  [@css ".a-qyxka4e2bjp.id-zec317{color:blue;}"];
  [@css.bindings
    [
      ("Input.foo", "id-zec317", "a-4ekvmb"),
      ("Input.bar", "id-1eelq62", "a-qyxka4e2bjp"),
    ]
  ];
  
  let foo = CSS.make("label:foo id-zec317 a-4ekvmb", []);
  
  let bar = CSS.make("label:bar id-1eelq62 a-qyxka4e2bjp", []);
  
  let _ = (foo, bar);

  $ dune build
