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
    ("._a_4pgt40{contain:none;}", "_a_4pgt40", "0,1,0 own", "169", 1, false)
  ];
  [@css
    ("._a_4pyisx{contain:strict;}", "_a_4pyisx", "0,1,0 own", "169", 1, false)
  ];
  [@css
    ("._a_4p7x2x{contain:content;}", "_a_4p7x2x", "0,1,0 own", "169", 1, false)
  ];
  [@css
    ("._a_4p1cha{contain:size;}", "_a_4p1cha", "0,1,0 own", "169", 1, false)
  ];
  [@css
    ("._a_4pw7cp{contain:layout;}", "_a_4pw7cp", "0,1,0 own", "169", 1, false)
  ];
  [@css
    ("._a_4pyn5q{contain:paint;}", "_a_4pyn5q", "0,1,0 own", "169", 1, false)
  ];
  [@css
    (
      "._a_4pjwgs{contain:size layout;}",
      "_a_4pjwgs",
      "0,1,0 own",
      "169",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4p7zd4{contain:size paint;}",
      "_a_4p7zd4",
      "0,1,0 own",
      "169",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4pc7bb{contain:size layout paint;}",
      "_a_4pc7bb",
      "0,1,0 own",
      "169",
      1,
      false,
    )
  ];
  [@css ("._a_eclzv6{width:5cqw;}", "_a_eclzv6", "0,1,0 own", "516", 1, false)];
  [@css ("._a_ecsy8j{width:5cqh;}", "_a_ecsy8j", "0,1,0 own", "516", 1, false)];
  [@css ("._a_ecq9h0{width:5cqi;}", "_a_ecq9h0", "0,1,0 own", "516", 1, false)];
  [@css ("._a_eccz18{width:5cqb;}", "_a_eccz18", "0,1,0 own", "516", 1, false)];
  [@css
    ("._a_ecidqw{width:5cqmin;}", "_a_ecidqw", "0,1,0 own", "516", 1, false)
  ];
  [@css
    ("._a_ec8ucx{width:5cqmax;}", "_a_ec8ucx", "0,1,0 own", "516", 1, false)
  ];
  [@css
    (
      "._a_4v00027ccc{container-type:normal;}",
      "_a_4v00027ccc",
      "0,1,0 own",
      "175",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_4v00026sj7{container-type:size;}",
      "_a_4v00026sj7",
      "0,1,0 own",
      "175",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_4v0002zm71{container-type:inline-size;}",
      "_a_4v0002zm71",
      "0,1,0 own",
      "175",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_4v0001nlpx{container-name:none;}",
      "_a_4v0001nlpx",
      "0,1,0 own",
      "175",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4v00019f0l{container-name:x;}",
      "_a_4v00019f0l",
      "0,1,0 own",
      "175",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4v0001kmkr{container-name:x y;}",
      "_a_4v0001kmkr",
      "0,1,0 own",
      "175",
      1,
      false,
    )
  ];
  [@css
    ("._a_4v1iko{container:none;}", "_a_4v1iko", "0,1,0 own", "175", 3, false)
  ];
  [@css
    (
      "._a_4v52qy{container:x / normal;}",
      "_a_4v52qy",
      "0,1,0 own",
      "175",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_4vcq8j{container:x / size;}",
      "_a_4vcq8j",
      "0,1,0 own",
      "175",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_4va7f0{container:x / inline-size;}",
      "_a_4va7f0",
      "0,1,0 own",
      "175",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_4vppda{container:x y / size;}",
      "_a_4vppda",
      "0,1,0 own",
      "175",
      3,
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
      (22, "", [9]),
      (23, "", [10]),
      (24, "", [11]),
      (25, "", [12]),
      (26, "", [13]),
      (27, "", [14]),
      (28, "", [15]),
      (29, "", [16]),
      (30, "", [17]),
      (31, "", [18]),
      (32, "", [19]),
      (33, "", [20]),
      (34, "", [21]),
      (35, "", [22]),
      (36, "", [23]),
      (37, "", [24]),
      (38, "", [25]),
    ]
  ];
  
  CSS.make("_a_4pgt40", []);
  CSS.make("_a_4pyisx", []);
  CSS.make("_a_4p7x2x", []);
  CSS.make("_a_4p1cha", []);
  CSS.make("_a_4pw7cp", []);
  CSS.make("_a_4pyn5q", []);
  CSS.make("_a_4pjwgs", []);
  CSS.make("_a_4p7zd4", []);
  CSS.make("_a_4pc7bb", []);
  
  CSS.make("_a_eclzv6", []);
  CSS.make("_a_ecsy8j", []);
  CSS.make("_a_ecq9h0", []);
  CSS.make("_a_eccz18", []);
  CSS.make("_a_ecidqw", []);
  CSS.make("_a_ec8ucx", []);
  CSS.make("_a_4v00027ccc", []);
  CSS.make("_a_4v00026sj7", []);
  CSS.make("_a_4v0002zm71", []);
  CSS.make("_a_4v0001nlpx", []);
  CSS.make("_a_4v00019f0l", []);
  CSS.make("_a_4v0001kmkr", []);
  CSS.make("_a_4v1iko", []);
  CSS.make("_a_4v52qy", []);
  CSS.make("_a_4vcq8j", []);
  CSS.make("_a_4va7f0", []);
  CSS.make("_a_4vppda", []);
