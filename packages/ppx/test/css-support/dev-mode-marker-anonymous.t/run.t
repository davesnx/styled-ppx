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
  [@css ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)];
  [@css ("._a_4esm7b{color:blue;}", "_a_4esm7b", "0,1,0 own", "158", 1, false)];
  [@css
    ("._a_4ecoli{color:green;}", "_a_4ecoli", "0,1,0 own", "158", 1, false)
  ];
  [@css.bindings [("Input.named", "_id_xfr56q", "_a_4ecoli")]];
  [@css.blocks [(9, "", [0]), (11, "", [1]), (14, "_id_xfr56q", [2])]];
  
  let _ = CSS.make("_a_4ekvmb", []);
  
  CSS.make("_a_4esm7b", []);
  
  let named = CSS.make("label:named _id_xfr56q _a_4ecoli", []);
  
  let _ = named;

  $ dune build
