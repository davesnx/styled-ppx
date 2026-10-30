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
      "._a_8dlko4{mix-blend-mode:normal;}",
      "_a_8dlko4",
      "0,1,0 own",
      "301",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8dvjpz{mix-blend-mode:multiply;}",
      "_a_8dvjpz",
      "0,1,0 own",
      "301",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8dk0am{mix-blend-mode:screen;}",
      "_a_8dk0am",
      "0,1,0 own",
      "301",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8dzyj4{mix-blend-mode:overlay;}",
      "_a_8dzyj4",
      "0,1,0 own",
      "301",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8dt403{mix-blend-mode:darken;}",
      "_a_8dt403",
      "0,1,0 own",
      "301",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8dm2bs{mix-blend-mode:lighten;}",
      "_a_8dm2bs",
      "0,1,0 own",
      "301",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8dhaz0{mix-blend-mode:color-dodge;}",
      "_a_8dhaz0",
      "0,1,0 own",
      "301",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8dw6n1{mix-blend-mode:color-burn;}",
      "_a_8dw6n1",
      "0,1,0 own",
      "301",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8dzgq9{mix-blend-mode:hard-light;}",
      "_a_8dzgq9",
      "0,1,0 own",
      "301",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8dndlc{mix-blend-mode:soft-light;}",
      "_a_8dndlc",
      "0,1,0 own",
      "301",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8d54fr{mix-blend-mode:difference;}",
      "_a_8d54fr",
      "0,1,0 own",
      "301",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8dbobq{mix-blend-mode:exclusion;}",
      "_a_8dbobq",
      "0,1,0 own",
      "301",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8duj9e{mix-blend-mode:hue;}",
      "_a_8duj9e",
      "0,1,0 own",
      "301",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8dqzf6{mix-blend-mode:saturation;}",
      "_a_8dqzf6",
      "0,1,0 own",
      "301",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8d0k1i{mix-blend-mode:color;}",
      "_a_8d0k1i",
      "0,1,0 own",
      "301",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8dszft{mix-blend-mode:luminosity;}",
      "_a_8dszft",
      "0,1,0 own",
      "301",
      1,
      false,
    )
  ];
  [@css
    ("._a_7ajmn5{isolation:auto;}", "_a_7ajmn5", "0,1,0 own", "262", 1, false)
  ];
  [@css
    (
      "._a_7anam7{isolation:isolate;}",
      "_a_7anam7",
      "0,1,0 own",
      "262",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3a0fcc{background-blend-mode:normal;}",
      "_a_3a0fcc",
      "0,1,0 own",
      "118",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3awb0u{background-blend-mode:multiply;}",
      "_a_3awb0u",
      "0,1,0 own",
      "118",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3amqbu{background-blend-mode:screen;}",
      "_a_3amqbu",
      "0,1,0 own",
      "118",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3akb0h{background-blend-mode:overlay;}",
      "_a_3akb0h",
      "0,1,0 own",
      "118",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3aejn3{background-blend-mode:darken;}",
      "_a_3aejn3",
      "0,1,0 own",
      "118",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3agoey{background-blend-mode:lighten;}",
      "_a_3agoey",
      "0,1,0 own",
      "118",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3ayjd5{background-blend-mode:color-dodge;}",
      "_a_3ayjd5",
      "0,1,0 own",
      "118",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3a39ay{background-blend-mode:color-burn;}",
      "_a_3a39ay",
      "0,1,0 own",
      "118",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3abqd8{background-blend-mode:hard-light;}",
      "_a_3abqd8",
      "0,1,0 own",
      "118",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3ae5j0{background-blend-mode:soft-light;}",
      "_a_3ae5j0",
      "0,1,0 own",
      "118",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3a2r9t{background-blend-mode:difference;}",
      "_a_3a2r9t",
      "0,1,0 own",
      "118",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3anlb2{background-blend-mode:exclusion;}",
      "_a_3anlb2",
      "0,1,0 own",
      "118",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3ay3l6{background-blend-mode:hue;}",
      "_a_3ay3l6",
      "0,1,0 own",
      "118",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3aoyo7{background-blend-mode:saturation;}",
      "_a_3aoyo7",
      "0,1,0 own",
      "118",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3axi8v{background-blend-mode:color;}",
      "_a_3axi8v",
      "0,1,0 own",
      "118",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3a9g5x{background-blend-mode:luminosity;}",
      "_a_3a9g5x",
      "0,1,0 own",
      "118",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_3al4fq{background-blend-mode:normal, multiply;}",
      "_a_3al4fq",
      "0,1,0 own",
      "118",
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
      (8, "", [6]),
      (9, "", [7]),
      (10, "", [8]),
      (11, "", [9]),
      (12, "", [10]),
      (13, "", [11]),
      (14, "", [12]),
      (15, "", [13]),
      (16, "", [14]),
      (17, "", [15]),
      (18, "", [16]),
      (19, "", [17]),
      (20, "", [18]),
      (21, "", [19]),
      (22, "", [20]),
      (23, "", [21]),
      (24, "", [22]),
      (25, "", [23]),
      (26, "", [24]),
      (27, "", [25]),
      (28, "", [26]),
      (29, "", [27]),
      (30, "", [28]),
      (31, "", [29]),
      (32, "", [30]),
      (33, "", [31]),
      (34, "", [32]),
      (35, "", [33]),
      (36, "", [34]),
    ]
  ];
  
  CSS.make("_a_8dlko4", []);
  CSS.make("_a_8dvjpz", []);
  CSS.make("_a_8dk0am", []);
  CSS.make("_a_8dzyj4", []);
  CSS.make("_a_8dt403", []);
  CSS.make("_a_8dm2bs", []);
  CSS.make("_a_8dhaz0", []);
  CSS.make("_a_8dw6n1", []);
  CSS.make("_a_8dzgq9", []);
  CSS.make("_a_8dndlc", []);
  CSS.make("_a_8d54fr", []);
  CSS.make("_a_8dbobq", []);
  CSS.make("_a_8duj9e", []);
  CSS.make("_a_8dqzf6", []);
  CSS.make("_a_8d0k1i", []);
  CSS.make("_a_8dszft", []);
  CSS.make("_a_7ajmn5", []);
  CSS.make("_a_7anam7", []);
  CSS.make("_a_3a0fcc", []);
  CSS.make("_a_3awb0u", []);
  CSS.make("_a_3amqbu", []);
  CSS.make("_a_3akb0h", []);
  CSS.make("_a_3aejn3", []);
  CSS.make("_a_3agoey", []);
  CSS.make("_a_3ayjd5", []);
  CSS.make("_a_3a39ay", []);
  CSS.make("_a_3abqd8", []);
  CSS.make("_a_3ae5j0", []);
  CSS.make("_a_3a2r9t", []);
  CSS.make("_a_3anlb2", []);
  CSS.make("_a_3ay3l6", []);
  CSS.make("_a_3aoyo7", []);
  CSS.make("_a_3axi8v", []);
  CSS.make("_a_3a9g5x", []);
  CSS.make("_a_3al4fq", []);
