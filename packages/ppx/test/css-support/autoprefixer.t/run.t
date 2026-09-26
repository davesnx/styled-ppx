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
    "._a_czr4kf{-webkit-text-size-adjust:none;-moz-text-size-adjust:none;-ms-text-size-adjust:none;text-size-adjust:none;}"
  ];
  [@css
    "._a_cfky3p{-webkit-text-decoration:line-through;text-decoration:line-through;}"
  ];
  [@css "._a_5rj0h8{display:grid;}"];
  [@css
    "._a_2z00w8nyb{-webkit-animation-iteration-count:infinite;animation-iteration-count:infinite;}"
  ];
  [@css
    "._a_37ib09{-webkit-backdrop-filter:blur(30px);backdrop-filter:blur(30px);}"
  ];
  CSS.make("_a_czr4kf", []);
  CSS.make("_a_cfky3p", []);
  CSS.make("_a_5rj0h8", []);
  CSS.make("_a_2z00w8nyb", []);
  CSS.make("_a_37ib09", []);
