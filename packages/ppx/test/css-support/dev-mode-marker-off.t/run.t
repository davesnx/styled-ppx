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
  [@css ".a-k008qs{display:flex;}"];
  [@css ".a-38zrbw{padding:12px;}"];
  [@css ".a-tokvmb{color:red;}"];
  [@css.bindings
    [
      ("Input.layout", "id-1jj5tmt", "a-k008qs a-38zrbw"),
      ("Input.button", "id-l55coe", "a-tokvmb"),
    ]
  ];
  
  let layout = CSS.make("id-1jj5tmt a-k008qs a-38zrbw", []);
  
  let button = CSS.make("id-l55coe a-tokvmb", []);
  
  let _ = (layout, button);

  $ dune build
