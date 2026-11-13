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
    ".css-b0au5g{-webkit-text-size-adjust:none;-moz-text-size-adjust:none;-ms-text-size-adjust:none;text-size-adjust:none;}"
  ];
  [@css
    ".css-1rr2i21{-webkit-text-decoration:line-through;text-decoration:line-through;}"
  ];
  [@css ".css-19upnxc{display:grid;}"];
  [@css
    ".css-12bmrx5{-webkit-animation-iteration-count:infinite;animation-iteration-count:infinite;}"
  ];
  [@css
    ".css-1bhoji9{-webkit-backdrop-filter:blur(30px);backdrop-filter:blur(30px);}"
  ];
  [@css.classes
    [
      ("css-b0au5g", 0, "", "input.re", 1, 8, 1, 31),
      ("css-1rr2i21", 1, "", "input.re", 2, 8, 2, 38),
      ("css-19upnxc", 2, "", "input.re", 3, 8, 3, 22),
      ("css-12bmrx5", 3, "", "input.re", 4, 8, 4, 44),
      ("css-1bhoji9", 4, "", "input.re", 5, 8, 5, 36),
    ]
  ];
  CSS.make("css-b0au5g", []);
  CSS.make("css-1rr2i21", []);
  CSS.make("css-19upnxc", []);
  CSS.make("css-12bmrx5", []);
  CSS.make("css-1bhoji9", []);
