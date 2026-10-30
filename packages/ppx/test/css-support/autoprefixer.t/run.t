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
    (
      "._a_czr4kf{-webkit-text-size-adjust:none;-moz-text-size-adjust:none;text-size-adjust:none;}",
      "_a_czr4kf",
      "0,1,0 own",
      "467",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_cfky3p{-webkit-text-decoration:line-through;text-decoration:line-through;}",
      "_a_cfky3p",
      "0,1,0 own",
      "447",
      15,
      false,
    )
  ];
  [@css
    ("._a_5rj0h8{display:grid;}", "_a_5rj0h8", "0,1,0 own", "207", 1, false)
  ];
  [@css
    (
      "._a_2z000w8nyb{-webkit-animation-iteration-count:infinite;animation-iteration-count:infinite;}",
      "_a_2z000w8nyb",
      "0,1,0 own",
      "107",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_37ib09{-webkit-backdrop-filter:blur(30px);backdrop-filter:blur(30px);}",
      "_a_37ib09",
      "0,1,0 own",
      "115",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (1, "", [0]),
      (2, "", [1]),
      (3, "", [2]),
      (4, "", [3]),
      (5, "", [4]),
    ]
  ];
  CSS.make("_a_czr4kf", []);
  CSS.make("_a_cfky3p", []);
  CSS.make("_a_5rj0h8", []);
  CSS.make("_a_2z000w8nyb", []);
  CSS.make("_a_37ib09", []);
