This test ensures autoprefixing happens in the PPX extraction path.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ cat > input.re << EOF
  > [%css {|text-size-adjust: none;|}];
  > [%css {|text-decoration: line-through;|}];
  > [%css {|display: grid;|}];
  > [%css {|animation-iteration-count: infinite;|}];
  > [%css {|backdrop-filter: blur(30px);|}];
  > EOF

  $ dune build

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ".css-6tr4kf{-webkit-text-size-adjust:none;-moz-text-size-adjust:none;-ms-text-size-adjust:none;text-size-adjust:none;}"
  ];
  [@css
    ".css-4jky3p{-webkit-text-decoration:line-through;text-decoration:line-through;}"
  ];
  [@css ".css-lgj0h8{display:grid;}"];
  [@css
    ".css-17p8nyb{-webkit-animation-iteration-count:infinite;animation-iteration-count:infinite;}"
  ];
  [@css
    ".css-11ib09{-webkit-backdrop-filter:blur(30px);backdrop-filter:blur(30px);}"
  ];
  CSS.make("css-6tr4kf", []);
  CSS.make("css-4jky3p", []);
  CSS.make("css-lgj0h8", []);
  CSS.make("css-17p8nyb", []);
  CSS.make("css-11ib09", []);
