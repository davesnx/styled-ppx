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
    ".css-1mdio9p { column-width: 10em; }\n.css-1iro2cm { column-width: auto; }\n.css-td0nhi { column-count: 2; }\n.css-1lwy10s { column-count: auto; }\n.css-ckh82g { columns: 100px; }\n.css-tyqbkz { columns: 3; }\n.css-1xnm3h2 { columns: 10em 2; }\n.css-14rzl9g { columns: auto auto; }\n.css-1qvbsb6 { columns: 2 10em; }\n.css-1c83i2c { columns: auto 10em; }\n.css-1emdsyc { columns: 2 auto; }\n.css-wbai18 { column-rule-color: red; }\n.css-975sto { column-rule-style: none; }\n.css-1y3tnxz { column-rule-style: solid; }\n.css-g0xyfi { column-rule-style: dotted; }\n.css-x5rhsq { column-rule-width: 1px; }\n.css-1ieagg { column-rule: transparent; }\n.css-1wtwyqm { column-rule: 1px solid black; }\n.css-1krquxd { column-span: none; }\n.css-1i5vq9j { column-span: all; }\n.css-9ucb41 { column-fill: auto; }\n.css-3cankd { column-fill: balance; }\n.css-xhvzyg { column-fill: balance-all; }\n"
  ];
  CSS.make("css-1mdio9p", []);
  CSS.make("css-1iro2cm", []);
  CSS.make("css-td0nhi", []);
  CSS.make("css-1lwy10s", []);
  CSS.make("css-ckh82g", []);
  CSS.make("css-tyqbkz", []);
  CSS.make("css-1xnm3h2", []);
  
  CSS.make("css-14rzl9g", []);
  CSS.make("css-1qvbsb6", []);
  CSS.make("css-1c83i2c", []);
  CSS.make("css-1emdsyc", []);
  CSS.make("css-wbai18", []);
  CSS.make("css-975sto", []);
  CSS.make("css-1y3tnxz", []);
  CSS.make("css-g0xyfi", []);
  CSS.make("css-x5rhsq", []);
  CSS.make("css-1ieagg", []);
  CSS.make("css-1wtwyqm", []);
  CSS.make("css-1krquxd", []);
  CSS.make("css-1i5vq9j", []);
  CSS.make("css-9ucb41", []);
  CSS.make("css-3cankd", []);
  CSS.make("css-xhvzyg", []);
