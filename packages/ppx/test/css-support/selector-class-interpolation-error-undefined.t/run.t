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
  [@css "._a_c5f084ekx8h.css-foo{color:red;}"];
  [@css.bindings [("Input.bad", "_id_1ztayl", "_a_c5f084ekx8h")]];
  let undefined = "css-foo";
  let bad = CSS.make("label:bad _id_1ztayl _a_c5f084ekx8h", []);
  let _ = (undefined, bad);

  $ dune build
