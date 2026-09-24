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
  [@css ".css-k008qs{display:flex;}"];
  [@css ".css-38zrbw{padding:12px;}"];
  [@css ".css-tokvmb{color:red;}"];
  [@css.bindings
    [
      ("Input.layout", "cid-1jj5tmt", "css-k008qs css-38zrbw"),
      ("Input.button", "cid-l55coe", "css-tokvmb"),
    ]
  ];
  
  let layout = CSS.make("cid-1jj5tmt css-k008qs css-38zrbw", []);
  
  let button = CSS.make("cid-l55coe css-tokvmb", []);
  
  let _ = (layout, button);

  $ dune build
