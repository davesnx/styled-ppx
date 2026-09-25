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
  [@css ".a-1g6dwvy{-webkit-column-width:10em;column-width:10em;}"];
  [@css ".a-tt22l4{-webkit-column-width:auto;column-width:auto;}"];
  [@css ".a-xm7yc3{-webkit-column-count:2;column-count:2;}"];
  [@css ".a-64yhyp{-webkit-column-count:auto;column-count:auto;}"];
  [@css ".a-1x0rbi4{-webkit-columns:100px;columns:100px;}"];
  [@css ".a-1shjrzp{-webkit-columns:3;columns:3;}"];
  [@css ".a-1ussapk{-webkit-columns:10em 2;columns:10em 2;}"];
  [@css ".a-19fadp1{-webkit-columns:auto auto;columns:auto auto;}"];
  [@css ".a-1b4umhd{-webkit-columns:2 10em;columns:2 10em;}"];
  [@css ".a-yyak2{-webkit-columns:auto 10em;columns:auto 10em;}"];
  [@css ".a-1bp29w9{-webkit-columns:2 auto;columns:2 auto;}"];
  [@css ".a-6w0lyg{-webkit-column-rule-color:red;column-rule-color:red;}"];
  [@css ".a-10twiag{-webkit-column-rule-style:none;column-rule-style:none;}"];
  [@css ".a-13q2g8z{-webkit-column-rule-style:solid;column-rule-style:solid;}"];
  [@css
    ".a-1wyszib{-webkit-column-rule-style:dotted;column-rule-style:dotted;}"
  ];
  [@css ".a-1ro8iyd{-webkit-column-rule-width:1px;column-rule-width:1px;}"];
  [@css ".a-6dy1fb{-webkit-column-rule:transparent;column-rule:transparent;}"];
  [@css
    ".a-peh5u6{-webkit-column-rule:1px solid black;column-rule:1px solid black;}"
  ];
  [@css ".a-1i0zc18{-webkit-column-span:none;column-span:none;}"];
  [@css ".a-ooe1k2{-webkit-column-span:all;column-span:all;}"];
  [@css ".a-35ub2p{-webkit-column-fill:auto;column-fill:auto;}"];
  [@css ".a-l1o7d8{-webkit-column-fill:balance;column-fill:balance;}"];
  [@css ".a-9s58g2{-webkit-column-fill:balance-all;column-fill:balance-all;}"];
  
  CSS.make("a-1g6dwvy", []);
  CSS.make("a-tt22l4", []);
  CSS.make("a-xm7yc3", []);
  CSS.make("a-64yhyp", []);
  CSS.make("a-1x0rbi4", []);
  CSS.make("a-1shjrzp", []);
  CSS.make("a-1ussapk", []);
  
  CSS.make("a-19fadp1", []);
  CSS.make("a-1b4umhd", []);
  CSS.make("a-yyak2", []);
  CSS.make("a-1bp29w9", []);
  CSS.make("a-6w0lyg", []);
  CSS.make("a-10twiag", []);
  CSS.make("a-13q2g8z", []);
  CSS.make("a-1wyszib", []);
  CSS.make("a-1ro8iyd", []);
  CSS.make("a-6dy1fb", []);
  CSS.make("a-peh5u6", []);
  CSS.make("a-1i0zc18", []);
  CSS.make("a-ooe1k2", []);
  CSS.make("a-35ub2p", []);
  CSS.make("a-l1o7d8", []);
  CSS.make("a-9s58g2", []);
