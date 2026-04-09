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
  [@css ".css-1g6dwvy{column-width:10em;}"];
  [@css ".css-tt22l4{column-width:auto;}"];
  [@css ".css-xm7yc3{column-count:2;}"];
  [@css ".css-64yhyp{column-count:auto;}"];
  [@css ".css-1x0rbi4{columns:100px;}"];
  [@css ".css-1shjrzp{columns:3;}"];
  [@css ".css-1ussapk{columns:10em 2;}"];
  [@css ".css-19fadp1{columns:auto auto;}"];
  [@css ".css-1b4umhd{columns:2 10em;}"];
  [@css ".css-yyak2{columns:auto 10em;}"];
  [@css ".css-1bp29w9{columns:2 auto;}"];
  [@css ".css-6w0lyg{column-rule-color:red;}"];
  [@css ".css-10twiag{column-rule-style:none;}"];
  [@css ".css-13q2g8z{column-rule-style:solid;}"];
  [@css ".css-1wyszib{column-rule-style:dotted;}"];
  [@css ".css-1ro8iyd{column-rule-width:1px;}"];
  [@css ".css-6dy1fb{column-rule:transparent;}"];
  [@css ".css-peh5u6{column-rule:1px solid black;}"];
  [@css ".css-1i0zc18{column-span:none;}"];
  [@css ".css-ooe1k2{column-span:all;}"];
  [@css ".css-35ub2p{column-fill:auto;}"];
  [@css ".css-l1o7d8{column-fill:balance;}"];
  [@css ".css-9s58g2{column-fill:balance-all;}"];
  
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
