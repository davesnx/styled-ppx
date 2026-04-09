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
  
  CSS.columnWidth(`em(10.));
  CSS.columnWidth(`auto);
  CSS.columnCount(`count(2));
  CSS.columnCount(`auto);
  CSS.unsafe({js|columns|js}, {js|100px|js});
  CSS.unsafe({js|columns|js}, {js|3|js});
  CSS.unsafe({js|columns|js}, {js|10em 2|js});
  
  CSS.unsafe({js|columns|js}, {js|auto auto|js});
  CSS.unsafe({js|columns|js}, {js|2 10em|js});
  CSS.unsafe({js|columns|js}, {js|auto 10em|js});
  CSS.unsafe({js|columns|js}, {js|2 auto|js});
  CSS.columnRuleColor(CSS.red);
  CSS.columnRuleStyle(`none);
  CSS.columnRuleStyle(`solid);
  CSS.columnRuleStyle(`dotted);
  CSS.columnRuleWidth(`pxFloat(1.));
  CSS.unsafe({js|columnRule|js}, {js|transparent|js});
  CSS.unsafe({js|columnRule|js}, {js|1px solid black|js});
  CSS.columnSpan(`none);
  CSS.columnSpan(`all);
  CSS.columnFill(`auto);
  CSS.columnFill(`balance);
  CSS.columnFill(`balanceAll);
