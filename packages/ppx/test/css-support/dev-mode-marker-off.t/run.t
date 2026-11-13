Without --dev, [%css] output is identical to before: no marker class
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
  [@css ".css-1992jrt{display:flex;padding:12px;}"];
  [@css ".css-1y4lziy{color:red;}"];
  [@css.classes
    [
      ("css-1992jrt", 0, "Input.layout", "input.re", 6, 22, 6, 52),
      ("css-1y4lziy", 1, "Input.button", "input.re", 8, 22, 8, 34),
    ]
  ];
  [@css.bindings
    [("Input.layout", "css-1992jrt"), ("Input.button", "css-1y4lziy")]
  ];
  
  let layout = CSS.make("css-1992jrt", []);
  
  let button = CSS.make("css-1y4lziy", []);
  
  let _ = (layout, button);

  $ dune build
