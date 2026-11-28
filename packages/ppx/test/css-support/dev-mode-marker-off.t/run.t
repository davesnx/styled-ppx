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
  [@css ".css-ivpcjrt{display:flex;padding:12px;}"];
  [@css ".css-ivpcziy{color:red;}"];
  [@css.classes
    [
      ("css-ivpcjrt", 0, "Input.layout", "input.re", 6, 22, 6, 52),
      ("css-ivpcziy", 1, "Input.button", "input.re", 8, 22, 8, 34),
    ]
  ];
  [@css.bindings
    [("Input.layout", "css-ivpcjrt"), ("Input.button", "css-ivpcziy")]
  ];
  
  let layout = CSS.make("css-ivpcjrt", []);
  
  let button = CSS.make("css-ivpcziy", []);
  
  let _ = (layout, button);

  $ dune build
