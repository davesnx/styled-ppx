Dev markers are on by default; `--env production` turns them off, same as
`--minify`. Same input as dev-mode-marker.t but with production selected, to
lock in that the marker disappears in production regardless of the default.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx -- --env production)))
  > EOF

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css.config [("env", "production")]];
  [@css "._a_5r08qs{display:flex;}"];
  [@css "._a_94zrbw{padding:12px;}"];
  [@css "._a_4ekvmb{color:red;}"];
  [@css.bindings
    [
      ("Input.layout", "_id_1jj5tmt", "_a_5r08qs _a_94zrbw"),
      ("Input.button", "_id_l55coe", "_a_4ekvmb"),
    ]
  ];
  
  let layout = CSS.make("_id_1jj5tmt _a_5r08qs _a_94zrbw", []);
  
  let button = CSS.make("_id_l55coe _a_4ekvmb", []);
  
  let _ = (layout, button);

  $ dune build
