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
      "._a_dh2far{touch-action:auto;}",
      "_a_dh2far",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dhsbrd{touch-action:none;}",
      "_a_dhsbrd",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dhsu0a{touch-action:pan-x;}",
      "_a_dhsu0a",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dhcb00{touch-action:pan-y;}",
      "_a_dhcb00",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dhee94{touch-action:pan-x pan-y;}",
      "_a_dhee94",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dh4v8x{touch-action:manipulation;}",
      "_a_dh4v8x",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dht8dp{touch-action:pan-left;}",
      "_a_dht8dp",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dhiuj3{touch-action:pan-right;}",
      "_a_dhiuj3",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dhtga0{touch-action:pan-up;}",
      "_a_dhtga0",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dhpx43{touch-action:pan-down;}",
      "_a_dhpx43",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dhn9hg{touch-action:pan-left pan-up;}",
      "_a_dhn9hg",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dhgay6{touch-action:pinch-zoom;}",
      "_a_dhgay6",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dhive7{touch-action:pan-x pinch-zoom;}",
      "_a_dhive7",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dh2qdh{touch-action:pan-y pinch-zoom;}",
      "_a_dh2qdh",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_dhbds3{touch-action:pan-x pan-y pinch-zoom;}",
      "_a_dhbds3",
      "0,1,0 own",
      "485",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (2, "", [0]),
      (3, "", [1]),
      (4, "", [2]),
      (5, "", [3]),
      (6, "", [4]),
      (7, "", [5]),
      (10, "", [6]),
      (11, "", [7]),
      (12, "", [8]),
      (13, "", [9]),
      (14, "", [10]),
      (17, "", [11]),
      (18, "", [12]),
      (19, "", [13]),
      (20, "", [14]),
    ]
  ];
  
  CSS.make("_a_dh2far", []);
  CSS.make("_a_dhsbrd", []);
  CSS.make("_a_dhsu0a", []);
  CSS.make("_a_dhcb00", []);
  CSS.make("_a_dhee94", []);
  CSS.make("_a_dh4v8x", []);
  
  CSS.make("_a_dht8dp", []);
  CSS.make("_a_dhiuj3", []);
  CSS.make("_a_dhtga0", []);
  CSS.make("_a_dhpx43", []);
  CSS.make("_a_dhn9hg", []);
  
  CSS.make("_a_dhgay6", []);
  CSS.make("_a_dhive7", []);
  CSS.make("_a_dh2qdh", []);
  CSS.make("_a_dhbds3", []);
