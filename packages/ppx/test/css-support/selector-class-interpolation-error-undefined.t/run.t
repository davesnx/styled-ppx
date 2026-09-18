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
  [@css ".css-1uqxgij-bad.css-foo{color:red}"];
  [@css.bindings [("Input.bad", "css-1uqxgij-bad")]];
  let undefined = "css-foo";
  let bad = CSS.make("css-1uqxgij-bad", []);
  let _ = (undefined, bad);

  $ dune build
