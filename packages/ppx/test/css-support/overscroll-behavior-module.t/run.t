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
      "._a_8zho3a{overscroll-behavior:contain;}",
      "_a_8zho3a",
      "0,1,0 own",
      "323",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8z7j1d{overscroll-behavior:none;}",
      "_a_8z7j1d",
      "0,1,0 own",
      "323",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8zukkc{overscroll-behavior:auto;}",
      "_a_8zukkc",
      "0,1,0 own",
      "323",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8zxxxe{overscroll-behavior:contain contain;}",
      "_a_8zxxxe",
      "0,1,0 own",
      "323",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8zypmu{overscroll-behavior:none contain;}",
      "_a_8zypmu",
      "0,1,0 own",
      "323",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8zmwul{overscroll-behavior:auto contain;}",
      "_a_8zmwul",
      "0,1,0 own",
      "323",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8zbl4h{overscroll-behavior:contain none;}",
      "_a_8zbl4h",
      "0,1,0 own",
      "323",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8zanq6{overscroll-behavior:none none;}",
      "_a_8zanq6",
      "0,1,0 own",
      "323",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8zyhlg{overscroll-behavior:auto none;}",
      "_a_8zyhlg",
      "0,1,0 own",
      "323",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8z9kl3{overscroll-behavior:contain auto;}",
      "_a_8z9kl3",
      "0,1,0 own",
      "323",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8zifvx{overscroll-behavior:none auto;}",
      "_a_8zifvx",
      "0,1,0 own",
      "323",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8zmixw{overscroll-behavior:auto auto;}",
      "_a_8zmixw",
      "0,1,0 own",
      "323",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_92zttn{overscroll-behavior-x:contain;}",
      "_a_92zttn",
      "0,1,0 own",
      "326",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_92zrzr{overscroll-behavior-x:none;}",
      "_a_92zrzr",
      "0,1,0 own",
      "326",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_92jltw{overscroll-behavior-x:auto;}",
      "_a_92jltw",
      "0,1,0 own",
      "326",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_93sund{overscroll-behavior-y:contain;}",
      "_a_93sund",
      "0,1,0 own",
      "327",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_93t8de{overscroll-behavior-y:none;}",
      "_a_93t8de",
      "0,1,0 own",
      "327",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_93yb72{overscroll-behavior-y:auto;}",
      "_a_93yb72",
      "0,1,0 own",
      "327",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_91sm2h{overscroll-behavior-inline:contain;}",
      "_a_91sm2h",
      "0,1,0 own",
      "325",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_91iqqo{overscroll-behavior-inline:none;}",
      "_a_91iqqo",
      "0,1,0 own",
      "325",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_91kyxi{overscroll-behavior-inline:auto;}",
      "_a_91kyxi",
      "0,1,0 own",
      "325",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_90qfuu{overscroll-behavior-block:contain;}",
      "_a_90qfuu",
      "0,1,0 own",
      "324",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_90iw13{overscroll-behavior-block:none;}",
      "_a_90iw13",
      "0,1,0 own",
      "324",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_90unay{overscroll-behavior-block:auto;}",
      "_a_90unay",
      "0,1,0 own",
      "324",
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
    ]
  ];
  
  CSS.make("_a_8zho3a", []);
  CSS.make("_a_8z7j1d", []);
  CSS.make("_a_8zukkc", []);
  CSS.make("_a_8zxxxe", []);
  CSS.make("_a_8zypmu", []);
  CSS.make("_a_8zmwul", []);
  CSS.make("_a_8zbl4h", []);
  CSS.make("_a_8zanq6", []);
  CSS.make("_a_8zyhlg", []);
  CSS.make("_a_8z9kl3", []);
  CSS.make("_a_8zifvx", []);
  CSS.make("_a_8zmixw", []);
  CSS.make("_a_92zttn", []);
  CSS.make("_a_92zrzr", []);
  CSS.make("_a_92jltw", []);
  CSS.make("_a_93sund", []);
  CSS.make("_a_93t8de", []);
  CSS.make("_a_93yb72", []);
  CSS.make("_a_91sm2h", []);
  CSS.make("_a_91iqqo", []);
  CSS.make("_a_91kyxi", []);
  CSS.make("_a_90qfuu", []);
  CSS.make("_a_90iw13", []);
  CSS.make("_a_90unay", []);
