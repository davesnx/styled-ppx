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
  
  CSS.breakBefore(`auto);
  CSS.breakBefore(`avoid);
  CSS.breakBefore(`avoidPage);
  CSS.breakBefore(`page);
  CSS.breakBefore(`left);
  CSS.breakBefore(`right);
  CSS.breakBefore(`recto);
  CSS.breakBefore(`verso);
  CSS.breakBefore(`avoidColumn);
  CSS.breakBefore(`column);
  CSS.breakBefore(`avoidRegion);
  CSS.breakBefore(`region);
  CSS.breakAfter(`auto);
  CSS.breakAfter(`avoid);
  CSS.breakAfter(`avoidPage);
  CSS.breakAfter(`page);
  CSS.breakAfter(`left);
  CSS.breakAfter(`right);
  CSS.breakAfter(`recto);
  CSS.breakAfter(`verso);
  CSS.breakAfter(`avoidColumn);
  CSS.breakAfter(`column);
  CSS.breakAfter(`avoidRegion);
  CSS.breakAfter(`region);
  CSS.breakInside(`auto);
  CSS.breakInside(`avoid);
  CSS.breakInside(`avoidPage);
  CSS.breakInside(`avoidColumn);
  CSS.breakInside(`avoidRegion);
  CSS.boxDecorationBreak(`slice);
  CSS.boxDecorationBreak(`clone);
  CSS.orphans(1);
  CSS.orphans(2);
  
  CSS.widows(1);
  CSS.widows(2);
