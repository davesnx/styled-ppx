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
  
  CSS.unsafe({js|captionSide|js}, {js|inline-start|js});
  CSS.unsafe({js|captionSide|js}, {js|inline-end|js});
  CSS.unsafe({js|float|js}, {js|inline-start|js});
  CSS.unsafe({js|float|js}, {js|inline-end|js});
  CSS.clear(`inlineStart);
  CSS.clear(`inlineEnd);
  CSS.resize(`block);
  CSS.resize(`inline);
  CSS.blockSize(`pxFloat(100.));
  CSS.inlineSize(`pxFloat(100.));
  CSS.minBlockSize(`pxFloat(100.));
  CSS.minInlineSize(`pxFloat(100.));
  CSS.maxBlockSize(`pxFloat(100.));
  CSS.maxInlineSize(`pxFloat(100.));
  CSS.marginBlock(`pxFloat(10.));
  CSS.marginBlock2(~v=`pxFloat(10.), ~h=`pxFloat(10.));
  CSS.marginBlockStart(`pxFloat(10.));
  CSS.marginBlockEnd(`pxFloat(10.));
  CSS.marginInline(`pxFloat(10.));
  CSS.marginInline2(~v=`pxFloat(10.), ~h=`pxFloat(10.));
  CSS.marginInlineStart(`pxFloat(10.));
  CSS.marginInlineEnd(`pxFloat(10.));
  CSS.inset(`pxFloat(10.));
  CSS.inset2(~v=`pxFloat(10.), ~h=`pxFloat(10.));
  CSS.inset3(~top=`pxFloat(10.), ~h=`pxFloat(10.), ~bottom=`pxFloat(10.));
  CSS.inset4(
    ~top=`pxFloat(10.),
    ~right=`pxFloat(10.),
    ~bottom=`pxFloat(10.),
    ~left=`pxFloat(10.),
  );
  CSS.insetBlock(`pxFloat(10.));
  CSS.insetBlock2(~v=`pxFloat(10.), ~h=`pxFloat(10.));
  CSS.insetBlockStart(`pxFloat(10.));
  CSS.insetBlockEnd(`pxFloat(10.));
  CSS.insetInline(`pxFloat(10.));
  CSS.insetInline2(~v=`pxFloat(10.), ~h=`pxFloat(10.));
  CSS.insetInlineStart(`pxFloat(10.));
  CSS.insetInlineEnd(`pxFloat(10.));
  CSS.paddingBlock(`pxFloat(10.));
  CSS.paddingBlock2(~v=`pxFloat(10.), ~h=`pxFloat(10.));
  CSS.paddingBlockStart(`pxFloat(10.));
  CSS.paddingBlockEnd(`pxFloat(10.));
  CSS.paddingInline(`pxFloat(10.));
  CSS.paddingInline2(~v=`pxFloat(10.), ~h=`pxFloat(10.));
  CSS.paddingInlineStart(`pxFloat(10.));
  CSS.paddingInlineEnd(`pxFloat(10.));
  CSS.unsafe({js|borderBlock|js}, {js|1px|js});
  CSS.unsafe({js|borderBlock|js}, {js|2px dotted|js});
  CSS.borderBlock(`medium, `dashed, CSS.green);
  CSS.unsafe({js|borderBlockStart|js}, {js|1px|js});
  CSS.unsafe({js|borderBlockStart|js}, {js|2px dotted|js});
  CSS.borderBlockStart(`medium, `dashed, CSS.green);
  CSS.borderBlockStartWidth(`thin);
  CSS.borderBlockStartStyle(`dotted);
  CSS.borderBlockStartColor(CSS.navy);
  CSS.unsafe({js|borderBlockEnd|js}, {js|1px|js});
  CSS.unsafe({js|borderBlockEnd|js}, {js|2px dotted|js});
  CSS.borderBlockEnd(`medium, `dashed, CSS.green);
  CSS.borderBlockEndWidth(`thin);
  CSS.borderBlockEndStyle(`dotted);
  CSS.borderBlockEndColor(CSS.navy);
  
  CSS.borderBlockColor2(CSS.navy, CSS.blue);
  CSS.unsafe({js|borderInline|js}, {js|1px|js});
  CSS.unsafe({js|borderInline|js}, {js|2px dotted|js});
  CSS.borderInline(`medium, `dashed, CSS.green);
  CSS.unsafe({js|borderInlineStart|js}, {js|1px|js});
  CSS.unsafe({js|borderInlineStart|js}, {js|2px dotted|js});
  CSS.borderInlineStart(`medium, `dashed, CSS.green);
  CSS.borderInlineStartWidth(`thin);
  CSS.borderInlineStartStyle(`dotted);
  CSS.borderInlineStartColor(CSS.navy);
  CSS.unsafe({js|borderInlineEnd|js}, {js|1px|js});
  CSS.unsafe({js|borderInlineEnd|js}, {js|2px dotted|js});
  CSS.borderInlineEnd(`medium, `dashed, CSS.green);
  CSS.borderInlineEndWidth(`thin);
  CSS.borderInlineEndStyle(`dotted);
  CSS.borderInlineEndColor(CSS.navy);
  
  CSS.borderInlineColor2(CSS.navy, CSS.blue);
  CSS.unsafe({js|borderStartStartRadius|js}, {js|0|js});
  CSS.unsafe({js|borderStartStartRadius|js}, {js|50%|js});
  CSS.unsafe({js|borderStartStartRadius|js}, {js|250px 100px|js});
  CSS.unsafe({js|borderStartEndRadius|js}, {js|0|js});
  CSS.unsafe({js|borderStartEndRadius|js}, {js|50%|js});
  CSS.unsafe({js|borderStartEndRadius|js}, {js|250px 100px|js});
  CSS.unsafe({js|borderEndStartRadius|js}, {js|0|js});
  CSS.unsafe({js|borderEndStartRadius|js}, {js|50%|js});
  CSS.unsafe({js|borderEndStartRadius|js}, {js|250px 100px|js});
  CSS.unsafe({js|borderEndEndRadius|js}, {js|0|js});
  CSS.unsafe({js|borderEndEndRadius|js}, {js|50%|js});
  CSS.unsafe({js|borderEndEndRadius|js}, {js|250px 100px|js});
