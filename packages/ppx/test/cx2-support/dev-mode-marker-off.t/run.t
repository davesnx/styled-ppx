Without --dev, [%cx2] output is identical to before: no marker class
prepended to the className. Same input as dev-mode-marker.t but with
the flag omitted, locking in that the marker is purely opt-in.

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
  [@css ".css-k008qs-layout{display:flex;}"];
  [@css ".css-38zrbw-layout{padding:12px;}"];
  [@css ".css-tokvmb-button{color:red;}"];
  [@css.bindings
    [
      ("Input.layout", "css-k008qs-layout css-38zrbw-layout"),
      ("Input.button", "css-tokvmb-button"),
    ]
  ];
  
  let layout = CSS.make("css-k008qs-layout css-38zrbw-layout", []);
  
  let button = CSS.make("css-tokvmb-button", []);
  
  let _ = (layout, button);

  $ dune build
