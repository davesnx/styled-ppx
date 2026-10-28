This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    (
      "._a_5y335o{fill-rule:nonzero;}",
      "_a_5y335o",
      "0,1,0 own",
      "214",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5yje6q{fill-rule:evenodd;}",
      "_a_5yje6q",
      "0,1,0 own",
      "214",
      1,
      false,
    )
  ];
  [@css
    ("._a_5x1axr{fill-opacity:0.5;}", "_a_5x1axr", "0,1,0 own", "213", 1, false)
  ];
  [@css
    ("._a_5xmbij{fill-opacity:45%;}", "_a_5xmbij", "0,1,0 own", "213", 1, false)
  ];
  [@css
    ("._a_c1fno8{stroke-width:0;}", "_a_c1fno8", "0,1,0 own", "433", 1, false)
  ];
  [@css
    ("._a_c1bqje{stroke-width:1px;}", "_a_c1bqje", "0,1,0 own", "433", 1, false)
  ];
  [@css
    ("._a_c1ssim{stroke-width:25%;}", "_a_c1ssim", "0,1,0 own", "433", 1, false)
  ];
  [@css
    (
      "._a_bx3u6b{stroke-linecap:butt;}",
      "_a_bx3u6b",
      "0,1,0 own",
      "429",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_bx96vv{stroke-linecap:round;}",
      "_a_bx96vv",
      "0,1,0 own",
      "429",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_bxdlez{stroke-linecap:square;}",
      "_a_bxdlez",
      "0,1,0 own",
      "429",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_bybou6{stroke-linejoin:miter;}",
      "_a_bybou6",
      "0,1,0 own",
      "430",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_bycl19{stroke-linejoin:bevel;}",
      "_a_bycl19",
      "0,1,0 own",
      "430",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_byzojx{stroke-linejoin:round;}",
      "_a_byzojx",
      "0,1,0 own",
      "430",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_bz77up{stroke-miterlimit:4;}",
      "_a_bz77up",
      "0,1,0 own",
      "431",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (7, "", [0]),
      (8, "", [1]),
      (62, "", [2]),
      (63, "", [3]),
      (69, "", [4]),
      (70, "", [5]),
      (71, "", [6]),
      (75, "", [7]),
      (76, "", [8]),
      (77, "", [9]),
      (80, "", [10]),
      (81, "", [11]),
      (82, "", [12]),
      (87, "", [13]),
    ]
  ];
  
  CSS.make("_a_5y335o", []);
  CSS.make("_a_5yje6q", []);
  
  CSS.make("_a_5x1axr", []);
  CSS.make("_a_5xmbij", []);
  
  CSS.make("_a_c1fno8", []);
  CSS.make("_a_c1bqje", []);
  CSS.make("_a_c1ssim", []);
  
  CSS.make("_a_bx3u6b", []);
  CSS.make("_a_bx96vv", []);
  CSS.make("_a_bxdlez", []);
  
  CSS.make("_a_bybou6", []);
  CSS.make("_a_bycl19", []);
  CSS.make("_a_byzojx", []);
  
  CSS.make("_a_bz77up", []);
