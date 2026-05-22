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
  [@css ".css-1g6dwvy{-webkit-column-width:10em;column-width:10em;}"];
  [@css ".css-tt22l4{-webkit-column-width:auto;column-width:auto;}"];
  [@css ".css-xm7yc3{-webkit-column-count:2;column-count:2;}"];
  [@css ".css-64yhyp{-webkit-column-count:auto;column-count:auto;}"];
  [@css ".css-1x0rbi4{-webkit-columns:100px;columns:100px;}"];
  [@css ".css-1shjrzp{-webkit-columns:3;columns:3;}"];
  [@css ".css-1ussapk{-webkit-columns:10em 2;columns:10em 2;}"];
  [@css ".css-19fadp1{-webkit-columns:auto auto;columns:auto auto;}"];
  [@css ".css-1b4umhd{-webkit-columns:2 10em;columns:2 10em;}"];
  [@css ".css-yyak2{-webkit-columns:auto 10em;columns:auto 10em;}"];
  [@css ".css-1bp29w9{-webkit-columns:2 auto;columns:2 auto;}"];
  [@css ".css-6w0lyg{-webkit-column-rule-color:red;column-rule-color:red;}"];
  [@css ".css-10twiag{-webkit-column-rule-style:none;column-rule-style:none;}"];
  [@css ".css-13q2g8z{-webkit-column-rule-style:solid;column-rule-style:solid;}"];
  [@css ".css-1wyszib{-webkit-column-rule-style:dotted;column-rule-style:dotted;}"];
  [@css ".css-1ro8iyd{-webkit-column-rule-width:1px;column-rule-width:1px;}"];
  [@css ".css-6dy1fb{-webkit-column-rule:transparent;column-rule:transparent;}"];
  [@css ".css-peh5u6{-webkit-column-rule:1px solid black;column-rule:1px solid black;}"];
  [@css ".css-1i0zc18{-webkit-column-span:none;column-span:none;}"];
  [@css ".css-ooe1k2{-webkit-column-span:all;column-span:all;}"];
  [@css ".css-35ub2p{-webkit-column-fill:auto;column-fill:auto;}"];
  [@css ".css-l1o7d8{-webkit-column-fill:balance;column-fill:balance;}"];
  [@css ".css-9s58g2{-webkit-column-fill:balance-all;column-fill:balance-all;}"];
  
  CSS.make("css-1g6dwvy", []);
  CSS.make("css-tt22l4", []);
  CSS.make("css-xm7yc3", []);
  CSS.make("css-64yhyp", []);
  CSS.make("css-1x0rbi4", []);
  CSS.make("css-1shjrzp", []);
  CSS.make("css-1ussapk", []);
  
  CSS.make("css-19fadp1", []);
  CSS.make("css-1b4umhd", []);
  CSS.make("css-yyak2", []);
  CSS.make("css-1bp29w9", []);
  CSS.make("css-6w0lyg", []);
  CSS.make("css-10twiag", []);
  CSS.make("css-13q2g8z", []);
  CSS.make("css-1wyszib", []);
  CSS.make("css-1ro8iyd", []);
  CSS.make("css-6dy1fb", []);
  CSS.make("css-peh5u6", []);
  CSS.make("css-1i0zc18", []);
  CSS.make("css-ooe1k2", []);
  CSS.make("css-35ub2p", []);
  CSS.make("css-l1o7d8", []);
  CSS.make("css-9s58g2", []);
