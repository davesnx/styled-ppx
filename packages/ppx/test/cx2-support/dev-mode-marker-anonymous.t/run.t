Anonymous bindings (`let _ = ...`) and statement-position [%cx2] (no
enclosing let) get no marker even with --dev. The `_` filter inside
`Dev_mode.marker` matches `Class_registry.register`'s anonymous-binding
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
  [@css ".css-tokvmb{color:red;}"];
  [@css ".css-14ksm7b{color:blue;}"];
  [@css ".css-bjcoli-named{color:green;}"];
  
  let _ = CSS.make("css-tokvmb", []);
  
  CSS.make("css-14ksm7b", []);
  
  let named = CSS.make("cx-named css-bjcoli-named", []);
  
  let _ = named;

  $ dune build
