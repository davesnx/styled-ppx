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
  [@css ".a-5r08qs{display:flex;}"];
  [@css ".a-94zrbw{padding:12px;}"];
  [@css ".a-4ekvmb{color:red;}"];
  [@css.bindings
    [
      ("Input.layout", "id-1jj5tmt", "a-5r08qs a-94zrbw"),
      ("Input.button", "id-l55coe", "a-4ekvmb"),
    ]
  ];
  
  let layout = CSS.make("id-1jj5tmt a-5r08qs a-94zrbw", []);
  
  let button = CSS.make("id-l55coe a-4ekvmb", []);
  
  let _ = (layout, button);

  $ dune build
