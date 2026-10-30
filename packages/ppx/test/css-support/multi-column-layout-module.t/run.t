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
      "._a_4o0004dwvy{-webkit-column-width:10em;column-width:10em;}",
      "_a_4o0004dwvy",
      "0,1,0 own",
      "168",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_4o000422l4{-webkit-column-width:auto;column-width:auto;}",
      "_a_4o000422l4",
      "0,1,0 own",
      "168",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_4o00017yc3{-webkit-column-count:2;column-count:2;}",
      "_a_4o00017yc3",
      "0,1,0 own",
      "168",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4o0001yhyp{-webkit-column-count:auto;column-count:auto;}",
      "_a_4o0001yhyp",
      "0,1,0 own",
      "168",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4orbi4{-webkit-columns:100px;columns:100px;}",
      "_a_4orbi4",
      "0,1,0 own",
      "168",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_4ojrzp{-webkit-columns:3;columns:3;}",
      "_a_4ojrzp",
      "0,1,0 own",
      "168",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_4osapk{-webkit-columns:10em 2;columns:10em 2;}",
      "_a_4osapk",
      "0,1,0 own",
      "168",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_4oadp1{-webkit-columns:auto auto;columns:auto auto;}",
      "_a_4oadp1",
      "0,1,0 own",
      "168",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_4oumhd{-webkit-columns:2 10em;columns:2 10em;}",
      "_a_4oumhd",
      "0,1,0 own",
      "168",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_4oyak2{-webkit-columns:auto 10em;columns:auto 10em;}",
      "_a_4oyak2",
      "0,1,0 own",
      "168",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_4o29w9{-webkit-columns:2 auto;columns:2 auto;}",
      "_a_4o29w9",
      "0,1,0 own",
      "168",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_4l00010lyg{-webkit-column-rule-color:red;column-rule-color:red;}",
      "_a_4l00010lyg",
      "0,1,0 own",
      "165",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4l0002wiag{-webkit-column-rule-style:none;column-rule-style:none;}",
      "_a_4l0002wiag",
      "0,1,0 own",
      "165",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_4l00022g8z{-webkit-column-rule-style:solid;column-rule-style:solid;}",
      "_a_4l00022g8z",
      "0,1,0 own",
      "165",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_4l0002szib{-webkit-column-rule-style:dotted;column-rule-style:dotted;}",
      "_a_4l0002szib",
      "0,1,0 own",
      "165",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_4l00048iyd{-webkit-column-rule-width:1px;column-rule-width:1px;}",
      "_a_4l00048iyd",
      "0,1,0 own",
      "165",
      4,
      false,
    )
  ];
  [@css
    (
      "._a_4l0007y1fb{-webkit-column-rule:transparent;column-rule:transparent;}",
      "_a_4l0007y1fb",
      "0,1,0 own",
      "165",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_4l0007h5u6{-webkit-column-rule:1px solid black;column-rule:1px solid black;}",
      "_a_4l0007h5u6",
      "0,1,0 own",
      "165",
      7,
      false,
    )
  ];
  [@css
    (
      "._a_4mzc18{-webkit-column-span:none;column-span:none;}",
      "_a_4mzc18",
      "0,1,0 own",
      "166",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4me1k2{-webkit-column-span:all;column-span:all;}",
      "_a_4me1k2",
      "0,1,0 own",
      "166",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4kub2p{-webkit-column-fill:auto;column-fill:auto;}",
      "_a_4kub2p",
      "0,1,0 own",
      "164",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4ko7d8{-webkit-column-fill:balance;column-fill:balance;}",
      "_a_4ko7d8",
      "0,1,0 own",
      "164",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4k58g2{-webkit-column-fill:balance-all;column-fill:balance-all;}",
      "_a_4k58g2",
      "0,1,0 own",
      "164",
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
      (11, "", [7]),
      (12, "", [8]),
      (13, "", [9]),
      (14, "", [10]),
      (15, "", [11]),
      (16, "", [12]),
      (17, "", [13]),
      (18, "", [14]),
      (19, "", [15]),
      (20, "", [16]),
      (21, "", [17]),
      (22, "", [18]),
      (23, "", [19]),
      (24, "", [20]),
      (25, "", [21]),
      (26, "", [22]),
    ]
  ];
  
  CSS.make("_a_4o0004dwvy", []);
  CSS.make("_a_4o000422l4", []);
  CSS.make("_a_4o00017yc3", []);
  CSS.make("_a_4o0001yhyp", []);
  CSS.make("_a_4orbi4", []);
  CSS.make("_a_4ojrzp", []);
  CSS.make("_a_4osapk", []);
  
  CSS.make("_a_4oadp1", []);
  CSS.make("_a_4oumhd", []);
  CSS.make("_a_4oyak2", []);
  CSS.make("_a_4o29w9", []);
  CSS.make("_a_4l00010lyg", []);
  CSS.make("_a_4l0002wiag", []);
  CSS.make("_a_4l00022g8z", []);
  CSS.make("_a_4l0002szib", []);
  CSS.make("_a_4l00048iyd", []);
  CSS.make("_a_4l0007y1fb", []);
  CSS.make("_a_4l0007h5u6", []);
  CSS.make("_a_4mzc18", []);
  CSS.make("_a_4me1k2", []);
  CSS.make("_a_4kub2p", []);
  CSS.make("_a_4ko7d8", []);
  CSS.make("_a_4k58g2", []);
