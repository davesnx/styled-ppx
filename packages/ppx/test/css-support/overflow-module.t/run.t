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
  
  CSS.unsafe({js|lineClamp|js}, {js|none|js});
  CSS.unsafe({js|lineClamp|js}, {js|1|js});
  
  CSS.unsafe({js|maxLines|js}, {js|none|js});
  CSS.unsafe({js|maxLines|js}, {js|1|js});
  CSS.overflowX(`visible);
  CSS.overflowX(`hidden);
  CSS.overflowX(`clip);
  CSS.overflowX(`scroll);
  CSS.overflowX(`auto);
  CSS.overflowY(`visible);
  CSS.overflowY(`hidden);
  CSS.overflowY(`clip);
  CSS.overflowY(`scroll);
  CSS.overflowY(`auto);
  CSS.overflowInline(`visible);
  CSS.overflowInline(`hidden);
  CSS.overflowInline(`clip);
  CSS.overflowInline(`scroll);
  CSS.overflowInline(`auto);
  CSS.overflowBlock(`visible);
  CSS.overflowBlock(`hidden);
  CSS.overflowBlock(`clip);
  CSS.overflowBlock(`scroll);
  CSS.overflowBlock(`auto);
  CSS.scrollbarGutter(`auto);
  CSS.scrollbarGutter(`stable);
  CSS.scrollbarGutter(`stableBothEdges);
  CSS.scrollbarGutter(`stableBothEdges);
  CSS.overflowClipMargin2(~clipEdgeOrigin=?Some(`contentBox), `pxFloat(0.));
  CSS.overflowClipMargin2(~clipEdgeOrigin=?Some(`paddingBox), `pxFloat(0.));
  CSS.overflowClipMargin2(~clipEdgeOrigin=?Some(`borderBox), `pxFloat(0.));
  CSS.overflowClipMargin2(~clipEdgeOrigin=?None, `pxFloat(20.));
  CSS.overflowClipMargin2(~clipEdgeOrigin=?None, `em(1.));
  CSS.overflowClipMargin2(~clipEdgeOrigin=?Some(`contentBox), `pxFloat(5.));
  CSS.overflowClipMargin2(~clipEdgeOrigin=?Some(`contentBox), `pxFloat(5.));
