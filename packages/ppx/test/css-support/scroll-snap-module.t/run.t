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
  
  CSS.unsafe({js|scrollMargin|js}, {js|0px|js});
  CSS.unsafe({js|scrollMargin|js}, {js|6px 5px|js});
  CSS.unsafe({js|scrollMargin|js}, {js|10px 20px 30px|js});
  CSS.unsafe({js|scrollMargin|js}, {js|10px 20px 30px 40px|js});
  CSS.unsafe({js|scrollMargin|js}, {js|20px 3em 1in 5rem|js});
  CSS.unsafe({js|scrollMargin|js}, {js|calc(2px)|js});
  CSS.unsafe({js|scrollMargin|js}, {js|calc(3 * 25px)|js});
  CSS.unsafe({js|scrollMargin|js}, {js|calc(3 * 25px) 5px 10em calc(1vw - 5px)|js});
  CSS.unsafe({js|scrollMarginBlock|js}, {js|10px|js});
  CSS.unsafe({js|scrollMarginBlock|js}, {js|10px 10px|js});
  CSS.unsafe({js|scrollMarginBlockEnd|js}, {js|10px|js});
  CSS.unsafe({js|scrollMarginBlockStart|js}, {js|10px|js});
  CSS.unsafe({js|scrollMarginBottom|js}, {js|10px|js});
  CSS.unsafe({js|scrollMarginInline|js}, {js|10px|js});
  CSS.unsafe({js|scrollMarginInline|js}, {js|10px 10px|js});
  CSS.unsafe({js|scrollMarginInlineStart|js}, {js|10px|js});
  CSS.unsafe({js|scrollMarginInlineEnd|js}, {js|10px|js});
  CSS.unsafe({js|scrollMarginLeft|js}, {js|10px|js});
  CSS.unsafe({js|scrollMarginRight|js}, {js|10px|js});
  CSS.unsafe({js|scrollMarginTop|js}, {js|10px|js});
  CSS.unsafe({js|scrollPadding|js}, {js|auto|js});
  CSS.unsafe({js|scrollPadding|js}, {js|0px|js});
  CSS.unsafe({js|scrollPadding|js}, {js|6px 5px|js});
  CSS.unsafe({js|scrollPadding|js}, {js|10px 20px 30px|js});
  CSS.unsafe({js|scrollPadding|js}, {js|10px 20px 30px 40px|js});
  CSS.unsafe({js|scrollPadding|js}, {js|10px auto 30px auto|js});
  CSS.unsafe({js|scrollPadding|js}, {js|10%|js});
  CSS.unsafe({js|scrollPadding|js}, {js|20% 3em 1in 5rem|js});
  CSS.unsafe({js|scrollPadding|js}, {js|calc(2px)|js});
  CSS.unsafe({js|scrollPadding|js}, {js|calc(50%)|js});
  CSS.unsafe({js|scrollPadding|js}, {js|calc(3 * 25px)|js});
  CSS.unsafe({js|scrollPadding|js}, {js|calc(3 * 25px) 5px 10% calc(10% - 5px)|js});
  CSS.unsafe({js|scrollPaddingBlock|js}, {js|10px|js});
  CSS.unsafe({js|scrollPaddingBlock|js}, {js|50%|js});
  CSS.unsafe({js|scrollPaddingBlock|js}, {js|10px 50%|js});
  CSS.unsafe({js|scrollPaddingBlock|js}, {js|50% 50%|js});
  CSS.unsafe({js|scrollPaddingBlockEnd|js}, {js|10px|js});
  CSS.unsafe({js|scrollPaddingBlockEnd|js}, {js|50%|js});
  CSS.unsafe({js|scrollPaddingBlockStart|js}, {js|10px|js});
  CSS.unsafe({js|scrollPaddingBlockStart|js}, {js|50%|js});
  CSS.unsafe({js|scrollPaddingBottom|js}, {js|10px|js});
  CSS.unsafe({js|scrollPaddingBottom|js}, {js|50%|js});
  CSS.unsafe({js|scrollPaddingInline|js}, {js|10px|js});
  CSS.unsafe({js|scrollPaddingInline|js}, {js|50%|js});
  CSS.unsafe({js|scrollPaddingInline|js}, {js|10px 50%|js});
  CSS.unsafe({js|scrollPaddingInline|js}, {js|50% 50%|js});
  CSS.unsafe({js|scrollPaddingInlineEnd|js}, {js|10px|js});
  CSS.unsafe({js|scrollPaddingInlineEnd|js}, {js|50%|js});
  CSS.unsafe({js|scrollPaddingInlineStart|js}, {js|10px|js});
  CSS.unsafe({js|scrollPaddingInlineStart|js}, {js|50%|js});
  CSS.unsafe({js|scrollPaddingLeft|js}, {js|10px|js});
  CSS.unsafe({js|scrollPaddingLeft|js}, {js|50%|js});
  CSS.unsafe({js|scrollPaddingRight|js}, {js|10px|js});
  CSS.unsafe({js|scrollPaddingRight|js}, {js|50%|js});
  CSS.unsafe({js|scrollPaddingTop|js}, {js|10px|js});
  CSS.unsafe({js|scrollPaddingTop|js}, {js|50%|js});
  CSS.unsafe({js|scrollSnapAlign|js}, {js|none|js});
  CSS.unsafe({js|scrollSnapAlign|js}, {js|start|js});
  CSS.unsafe({js|scrollSnapAlign|js}, {js|end|js});
  CSS.unsafe({js|scrollSnapAlign|js}, {js|center|js});
  CSS.unsafe({js|scrollSnapAlign|js}, {js|none start|js});
  CSS.unsafe({js|scrollSnapAlign|js}, {js|end center|js});
  CSS.unsafe({js|scrollSnapAlign|js}, {js|center start|js});
  CSS.unsafe({js|scrollSnapAlign|js}, {js|end none|js});
  CSS.unsafe({js|scrollSnapAlign|js}, {js|center center|js});
  CSS.unsafe({js|scrollSnapStop|js}, {js|normal|js});
  CSS.unsafe({js|scrollSnapStop|js}, {js|always|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|none|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|x mandatory|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|y mandatory|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|block mandatory|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|inline mandatory|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|both mandatory|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|x proximity|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|y proximity|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|block proximity|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|inline proximity|js});
  CSS.unsafe({js|scrollSnapType|js}, {js|both proximity|js});
