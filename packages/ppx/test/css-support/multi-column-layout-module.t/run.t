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
  [@css "._a_4o0004dwvy{-webkit-column-width:10em;column-width:10em;}"];
  [@css "._a_4o000422l4{-webkit-column-width:auto;column-width:auto;}"];
  [@css "._a_4o00017yc3{-webkit-column-count:2;column-count:2;}"];
  [@css "._a_4o0001yhyp{-webkit-column-count:auto;column-count:auto;}"];
  [@css "._a_4orbi4{-webkit-columns:100px;columns:100px;}"];
  [@css "._a_4ojrzp{-webkit-columns:3;columns:3;}"];
  [@css "._a_4osapk{-webkit-columns:10em 2;columns:10em 2;}"];
  [@css "._a_4oadp1{-webkit-columns:auto auto;columns:auto auto;}"];
  [@css "._a_4oumhd{-webkit-columns:2 10em;columns:2 10em;}"];
  [@css "._a_4oyak2{-webkit-columns:auto 10em;columns:auto 10em;}"];
  [@css "._a_4o29w9{-webkit-columns:2 auto;columns:2 auto;}"];
  [@css "._a_4l00010lyg{-webkit-column-rule-color:red;column-rule-color:red;}"];
  [@css
    "._a_4l0002wiag{-webkit-column-rule-style:none;column-rule-style:none;}"
  ];
  [@css
    "._a_4l00022g8z{-webkit-column-rule-style:solid;column-rule-style:solid;}"
  ];
  [@css
    "._a_4l0002szib{-webkit-column-rule-style:dotted;column-rule-style:dotted;}"
  ];
  [@css "._a_4l00048iyd{-webkit-column-rule-width:1px;column-rule-width:1px;}"];
  [@css
    "._a_4l0007y1fb{-webkit-column-rule:transparent;column-rule:transparent;}"
  ];
  [@css
    "._a_4l0007h5u6{-webkit-column-rule:1px solid black;column-rule:1px solid black;}"
  ];
  [@css "._a_4mzc18{-webkit-column-span:none;column-span:none;}"];
  [@css "._a_4me1k2{-webkit-column-span:all;column-span:all;}"];
  [@css "._a_4kub2p{-webkit-column-fill:auto;column-fill:auto;}"];
  [@css "._a_4ko7d8{-webkit-column-fill:balance;column-fill:balance;}"];
  [@css "._a_4k58g2{-webkit-column-fill:balance-all;column-fill:balance-all;}"];
  [@css.blocks
    [
      (2, "_a_4o0004dwvy"),
      (3, "_a_4o000422l4"),
      (4, "_a_4o00017yc3"),
      (5, "_a_4o0001yhyp"),
      (6, "_a_4orbi4"),
      (7, "_a_4ojrzp"),
      (8, "_a_4osapk"),
      (11, "_a_4oadp1"),
      (12, "_a_4oumhd"),
      (13, "_a_4oyak2"),
      (14, "_a_4o29w9"),
      (15, "_a_4l00010lyg"),
      (16, "_a_4l0002wiag"),
      (17, "_a_4l00022g8z"),
      (18, "_a_4l0002szib"),
      (19, "_a_4l00048iyd"),
      (20, "_a_4l0007y1fb"),
      (21, "_a_4l0007h5u6"),
      (22, "_a_4mzc18"),
      (23, "_a_4me1k2"),
      (24, "_a_4kub2p"),
      (25, "_a_4ko7d8"),
      (26, "_a_4k58g2"),
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
