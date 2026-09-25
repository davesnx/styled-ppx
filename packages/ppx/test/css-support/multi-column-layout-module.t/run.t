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
  [@css ".a-4o004dwvy{-webkit-column-width:10em;column-width:10em;}"];
  [@css ".a-4o00422l4{-webkit-column-width:auto;column-width:auto;}"];
  [@css ".a-4o0017yc3{-webkit-column-count:2;column-count:2;}"];
  [@css ".a-4o001yhyp{-webkit-column-count:auto;column-count:auto;}"];
  [@css ".a-4orbi4{-webkit-columns:100px;columns:100px;}"];
  [@css ".a-4ojrzp{-webkit-columns:3;columns:3;}"];
  [@css ".a-4osapk{-webkit-columns:10em 2;columns:10em 2;}"];
  [@css ".a-4oadp1{-webkit-columns:auto auto;columns:auto auto;}"];
  [@css ".a-4oumhd{-webkit-columns:2 10em;columns:2 10em;}"];
  [@css ".a-4oyak2{-webkit-columns:auto 10em;columns:auto 10em;}"];
  [@css ".a-4o29w9{-webkit-columns:2 auto;columns:2 auto;}"];
  [@css ".a-4l0010lyg{-webkit-column-rule-color:red;column-rule-color:red;}"];
  [@css ".a-4l002wiag{-webkit-column-rule-style:none;column-rule-style:none;}"];
  [@css
    ".a-4l0022g8z{-webkit-column-rule-style:solid;column-rule-style:solid;}"
  ];
  [@css
    ".a-4l002szib{-webkit-column-rule-style:dotted;column-rule-style:dotted;}"
  ];
  [@css ".a-4l0048iyd{-webkit-column-rule-width:1px;column-rule-width:1px;}"];
  [@css ".a-4ly1fb{-webkit-column-rule:transparent;column-rule:transparent;}"];
  [@css
    ".a-4lh5u6{-webkit-column-rule:1px solid black;column-rule:1px solid black;}"
  ];
  [@css ".a-4mzc18{-webkit-column-span:none;column-span:none;}"];
  [@css ".a-4me1k2{-webkit-column-span:all;column-span:all;}"];
  [@css ".a-4kub2p{-webkit-column-fill:auto;column-fill:auto;}"];
  [@css ".a-4ko7d8{-webkit-column-fill:balance;column-fill:balance;}"];
  [@css ".a-4k58g2{-webkit-column-fill:balance-all;column-fill:balance-all;}"];
  
  CSS.make("a-4o004dwvy", []);
  CSS.make("a-4o00422l4", []);
  CSS.make("a-4o0017yc3", []);
  CSS.make("a-4o001yhyp", []);
  CSS.make("a-4orbi4", []);
  CSS.make("a-4ojrzp", []);
  CSS.make("a-4osapk", []);
  
  CSS.make("a-4oadp1", []);
  CSS.make("a-4oumhd", []);
  CSS.make("a-4oyak2", []);
  CSS.make("a-4o29w9", []);
  CSS.make("a-4l0010lyg", []);
  CSS.make("a-4l002wiag", []);
  CSS.make("a-4l0022g8z", []);
  CSS.make("a-4l002szib", []);
  CSS.make("a-4l0048iyd", []);
  CSS.make("a-4ly1fb", []);
  CSS.make("a-4lh5u6", []);
  CSS.make("a-4mzc18", []);
  CSS.make("a-4me1k2", []);
  CSS.make("a-4kub2p", []);
  CSS.make("a-4ko7d8", []);
  CSS.make("a-4k58g2", []);
