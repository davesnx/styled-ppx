When the PPX is invoked with --dev, every named [%css] binding gets a
leading `cx-<name>` marker class. The marker is a plain string token
prepended to the className list inside CSS.make; it is not emitted as
a CSS rule.

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
  
  let layout = CSS.make("cx-layout css-ivpcjrt", []);
  
  let button = CSS.make("cx-button css-ivpcziy", []);
  
  let _ = (layout, button);

  $ dune build
