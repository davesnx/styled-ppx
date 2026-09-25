A selector ref can resolve to an earlier string literal binding.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune describe pp ./input.re | sed '1,/^];$/d;/^$/d'
  [@css ".a-8f05t4eqrk2.css-foo{color:red;}"];
  [@css.bindings [("Input.bad", "id-1ztayl", "a-8f05t4eqrk2")]];
  let undefined = "css-foo";
  let bad = CSS.make("label:bad id-1ztayl a-8f05t4eqrk2", []);
  let _ = (undefined, bad);

  $ dune build
