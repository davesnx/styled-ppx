Anonymous bindings (`let _ = ...`) and statement-position [%css] (no
enclosing let) get no marker even with --dev. The `_` filter inside
`Dev_mode.marker` matches `Local_selector_environment.register`'s anonymous-binding
behavior; this keeps the two debug affordances symmetric.

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
  [@css "._a_4ekvmb{color:red;}"];
  [@css "._a_4esm7b{color:blue;}"];
  [@css "._a_4ecoli{color:green;}"];
  [@css.bindings [("Input.named", "_id_1hum9uj", "_a_4ecoli")]];
  
  let _ = CSS.make("_a_4ekvmb", []);
  
  CSS.make("_a_4esm7b", []);
  
  let named = CSS.make("label:named _id_1hum9uj _a_4ecoli", []);
  
  let _ = named;

  $ dune build
