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
  CSS.unsafe({js|columnCount|js}, {js|2|js});
  CSS.unsafe({js|columnCount|js}, {js|auto|js});
  CSS.unsafe({js|columns|js}, {js|100px|js});
  CSS.unsafe({js|columns|js}, {js|3|js});
  CSS.unsafe({js|columns|js}, {js|10em 2|js});
  
  CSS.unsafe({js|columns|js}, {js|auto auto|js});
  CSS.unsafe({js|columns|js}, {js|2 10em|js});
  CSS.unsafe({js|columns|js}, {js|auto 10em|js});
  CSS.unsafe({js|columns|js}, {js|2 auto|js});
  CSS.unsafe({js|columnRuleColor|js}, {js|red|js});
  CSS.unsafe({js|columnRuleStyle|js}, {js|none|js});
  CSS.unsafe({js|columnRuleStyle|js}, {js|solid|js});
  CSS.unsafe({js|columnRuleStyle|js}, {js|dotted|js});
  CSS.unsafe({js|columnRuleWidth|js}, {js|1px|js});
  CSS.unsafe({js|columnRule|js}, {js|transparent|js});
  CSS.unsafe({js|columnRule|js}, {js|1px solid black|js});
  CSS.unsafe({js|columnSpan|js}, {js|none|js});
  CSS.unsafe({js|columnSpan|js}, {js|all|js});
  CSS.unsafe({js|columnFill|js}, {js|auto|js});
  CSS.unsafe({js|columnFill|js}, {js|balance|js});
  CSS.unsafe({js|columnFill|js}, {js|balance-all|js});
