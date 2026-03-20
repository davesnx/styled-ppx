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
  
  CSS.unsafe({js|marginBlockStart|js}, {js|auto|js});
  CSS.unsafe({js|marginBlockStart|js}, {js|0|js});
  CSS.unsafe({js|marginBlockStart|js}, {js|10%|js});
  CSS.unsafe({js|marginBlockStart|js}, {js|calc(10px + 5%)|js});
  CSS.unsafe({js|marginBlockEnd|js}, {js|auto|js});
  CSS.unsafe({js|marginBlockEnd|js}, {js|0|js});
  CSS.unsafe({js|marginBlockEnd|js}, {js|10%|js});
  CSS.unsafe({js|marginBlockEnd|js}, {js|calc(10px + 5%)|js});
  
  CSS.unsafe({js|marginInlineStart|js}, {js|auto|js});
  CSS.unsafe({js|marginInlineStart|js}, {js|0|js});
  CSS.unsafe({js|marginInlineStart|js}, {js|10%|js});
  CSS.unsafe({js|marginInlineStart|js}, {js|calc(10px + 5%)|js});
  CSS.unsafe({js|marginInlineEnd|js}, {js|auto|js});
  CSS.unsafe({js|marginInlineEnd|js}, {js|0|js});
  CSS.unsafe({js|marginInlineEnd|js}, {js|10%|js});
  CSS.unsafe({js|marginInlineEnd|js}, {js|calc(10px + 5%)|js});
  
  CSS.unsafe({js|paddingBlockStart|js}, {js|0|js});
  CSS.unsafe({js|paddingBlockStart|js}, {js|10%|js});
  CSS.unsafe({js|paddingBlockStart|js}, {js|calc(10px + 5%)|js});
  CSS.unsafe({js|paddingBlockEnd|js}, {js|0|js});
  CSS.unsafe({js|paddingBlockEnd|js}, {js|10%|js});
  CSS.unsafe({js|paddingBlockEnd|js}, {js|calc(10px + 5%)|js});
  
  CSS.unsafe({js|paddingInlineStart|js}, {js|0|js});
  CSS.unsafe({js|paddingInlineStart|js}, {js|10%|js});
  CSS.unsafe({js|paddingInlineStart|js}, {js|calc(10px + 5%)|js});
  CSS.unsafe({js|paddingInlineEnd|js}, {js|0|js});
  CSS.unsafe({js|paddingInlineEnd|js}, {js|10%|js});
  CSS.unsafe({js|paddingInlineEnd|js}, {js|calc(10px + 5%)|js});
  
  CSS.unsafe({js|marginBlock|js}, {js|auto auto|js});
  CSS.unsafe({js|marginBlock|js}, {js|10px 20px|js});
  CSS.unsafe({js|marginBlock|js}, {js|10% 20%|js});
  CSS.unsafe({js|marginInline|js}, {js|auto auto|js});
  CSS.unsafe({js|marginInline|js}, {js|10px 20px|js});
  CSS.unsafe({js|marginInline|js}, {js|10% 20%|js});
  
  CSS.unsafe({js|paddingBlock|js}, {js|10px 20px|js});
  CSS.unsafe({js|paddingBlock|js}, {js|10% 20%|js});
  CSS.unsafe({js|paddingInline|js}, {js|10px 20px|js});
  CSS.unsafe({js|paddingInline|js}, {js|10% 20%|js});
  
  CSS.unsafe({js|borderBlockWidth|js}, {js|thin|js});
  CSS.unsafe({js|borderBlockWidth|js}, {js|medium|js});
  CSS.unsafe({js|borderBlockWidth|js}, {js|thick|js});
  CSS.unsafe({js|borderBlockWidth|js}, {js|2px|js});
  CSS.unsafe({js|borderInlineWidth|js}, {js|thin|js});
  CSS.unsafe({js|borderInlineWidth|js}, {js|medium|js});
  CSS.unsafe({js|borderInlineWidth|js}, {js|thick|js});
  CSS.unsafe({js|borderInlineWidth|js}, {js|2px|js});
  
  CSS.unsafe({js|borderBlockStyle|js}, {js|none|js});
  CSS.unsafe({js|borderBlockStyle|js}, {js|solid|js});
  CSS.unsafe({js|borderBlockStyle|js}, {js|dashed|js});
  CSS.unsafe({js|borderInlineStyle|js}, {js|none|js});
  CSS.unsafe({js|borderInlineStyle|js}, {js|solid|js});
  CSS.unsafe({js|borderInlineStyle|js}, {js|dashed|js});
