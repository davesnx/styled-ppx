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
  [@css ".css-ivpc1x9{color:red;}"];
  [@css ".css-ivpclqy{color:blue;}"];
  [@css ".css-ivpcppf{color:green;}"];
  [@css.classes
    [
      ("css-ivpc1x9", 0, "", "input.re", 9, 17, 9, 29),
      ("css-ivpclqy", 1, "", "input.re", 11, 9, 11, 22),
      ("css-ivpcppf", 2, "Input.named", "input.re", 14, 21, 14, 35),
    ]
  ];
  [@css.bindings [("Input.named", "css-ivpcppf")]];
  
  let _ = CSS.make("css-ivpc1x9", []);
  
  CSS.make("css-ivpclqy", []);
  
  let named = CSS.make("cx-named css-ivpcppf", []);
  
  let _ = named;

  $ dune build
