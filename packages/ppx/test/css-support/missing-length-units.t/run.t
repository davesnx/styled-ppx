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
  [@css ("._a_ecuveb{width:1cap;}", "_a_ecuveb", "0,1,0 own", "516", 1, false)];
  [@css
    ("._a_ec6gk5{width:2.5cap;}", "_a_ec6gk5", "0,1,0 own", "516", 1, false)
  ];
  [@css ("._a_ecf708{width:1ic;}", "_a_ecf708", "0,1,0 own", "516", 1, false)];
  [@css
    ("._a_ecf374{width:3.5ic;}", "_a_ecf374", "0,1,0 own", "516", 1, false)
  ];
  [@css ("._a_ecwc7t{width:1lh;}", "_a_ecwc7t", "0,1,0 own", "516", 1, false)];
  [@css ("._a_ecqnkz{width:2lh;}", "_a_ecqnkz", "0,1,0 own", "516", 1, false)];
  [@css
    ("._a_ec4gax{width:1rcap;}", "_a_ec4gax", "0,1,0 own", "516", 1, false)
  ];
  [@css ("._a_ecnmih{width:1rch;}", "_a_ecnmih", "0,1,0 own", "516", 1, false)];
  [@css ("._a_ecy0pg{width:1rex;}", "_a_ecy0pg", "0,1,0 own", "516", 1, false)];
  [@css ("._a_ecmfob{width:1ric;}", "_a_ecmfob", "0,1,0 own", "516", 1, false)];
  [@css ("._a_ecnp92{width:1rlh;}", "_a_ecnp92", "0,1,0 own", "516", 1, false)];
  [@css ("._a_ecrh49{width:50vb;}", "_a_ecrh49", "0,1,0 own", "516", 1, false)];
  [@css ("._a_ecijca{width:50vi;}", "_a_ecijca", "0,1,0 own", "516", 1, false)];
  [@css ("._a_ec0vtm{width:40Q;}", "_a_ec0vtm", "0,1,0 own", "516", 1, false)];
  [@css
    ("._a_6l8f82{height:10lh;}", "_a_6l8f82", "0,1,0 own", "237", 1, false)
  ];
  [@css
    ("._a_7pigma{margin:2cap;}", "_a_7pigma", "0,1,0 own", "277", 15, false)
  ];
  [@css
    ("._a_94h56p{padding:5ic;}", "_a_94h56p", "0,1,0 own", "328", 15, false)
  ];
  [@css
    (
      "._a_65000wsmpm{font-size:1.5lh;}",
      "_a_65000wsmpm",
      "0,1,0 own",
      "221",
      32,
      false,
    )
  ];
  [@css
    (
      "._a_65b8jk3fhm{line-height:2rlh;}",
      "_a_65b8jk3fhm",
      "0,1,0 own",
      "221",
      524288,
      false,
    )
  ];
  [@css.blocks
    [
      (4, "", [0]),
      (5, "", [1]),
      (8, "", [2]),
      (9, "", [3]),
      (12, "", [4]),
      (13, "", [5]),
      (16, "", [6]),
      (19, "", [7]),
      (22, "", [8]),
      (25, "", [9]),
      (28, "", [10]),
      (31, "", [11]),
      (34, "", [12]),
      (37, "", [13]),
      (40, "", [14]),
      (41, "", [15]),
      (42, "", [16]),
      (43, "", [17]),
      (44, "", [18]),
    ]
  ];
  
  CSS.make("_a_ecuveb", []);
  CSS.make("_a_ec6gk5", []);
  
  CSS.make("_a_ecf708", []);
  CSS.make("_a_ecf374", []);
  
  CSS.make("_a_ecwc7t", []);
  CSS.make("_a_ecqnkz", []);
  
  CSS.make("_a_ec4gax", []);
  
  CSS.make("_a_ecnmih", []);
  
  CSS.make("_a_ecy0pg", []);
  
  CSS.make("_a_ecmfob", []);
  
  CSS.make("_a_ecnp92", []);
  
  CSS.make("_a_ecrh49", []);
  
  CSS.make("_a_ecijca", []);
  
  CSS.make("_a_ec0vtm", []);
  
  CSS.make("_a_6l8f82", []);
  CSS.make("_a_7pigma", []);
  CSS.make("_a_94h56p", []);
  CSS.make("_a_65000wsmpm", []);
  CSS.make("_a_65b8jk3fhm", []);
