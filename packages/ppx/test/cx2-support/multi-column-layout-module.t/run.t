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
    ".css-1g6dwvy{column-width:10em;}\n.css-tt22l4{column-width:auto;}\n.css-xm7yc3{column-count:2;}\n.css-64yhyp{column-count:auto;}\n.css-1x0rbi4{columns:100px;}\n.css-1shjrzp{columns:3;}\n.css-1ussapk{columns:10em 2;}\n.css-19fadp1{columns:auto auto;}\n.css-1b4umhd{columns:2 10em;}\n.css-yyak2{columns:auto 10em;}\n.css-1bp29w9{columns:2 auto;}\n.css-6w0lyg{column-rule-color:red;}\n.css-10twiag{column-rule-style:none;}\n.css-13q2g8z{column-rule-style:solid;}\n.css-1wyszib{column-rule-style:dotted;}\n.css-1ro8iyd{column-rule-width:1px;}\n.css-6dy1fb{column-rule:transparent;}\n.css-peh5u6{column-rule:1px solid black;}\n.css-1i0zc18{column-span:none;}\n.css-ooe1k2{column-span:all;}\n.css-35ub2p{column-fill:auto;}\n.css-l1o7d8{column-fill:balance;}\n.css-9s58g2{column-fill:balance-all;}\n"
  ];
  
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
