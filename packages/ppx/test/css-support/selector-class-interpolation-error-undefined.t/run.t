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

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css ".css-1utzlq3.css-foo{color:red;}"];
  [@css.classes [("css-1utzlq3", 0, "Input.bad", "input.re", 6, 2, 7, 0)]];
  [@css.bindings [("Input.bad", "css-1utzlq3")]];
  
  let undefined = "css-foo";
  
  let bad = CSS.make("css-1utzlq3", []);
  
  let _ = (undefined, bad);

  $ dune build
