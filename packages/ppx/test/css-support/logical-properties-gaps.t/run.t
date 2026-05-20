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
  
  CSS.marginBlockStart(`auto);
  CSS.marginBlockStart(`zero);
  CSS.marginBlockStart(`percent(10.));
  CSS.marginBlockStart(`calc(`add((`pxFloat(10.), `percent(5.)))));
  CSS.marginBlockEnd(`auto);
  CSS.marginBlockEnd(`zero);
  CSS.marginBlockEnd(`percent(10.));
  CSS.marginBlockEnd(`calc(`add((`pxFloat(10.), `percent(5.)))));
  
  CSS.marginInlineStart(`auto);
  CSS.marginInlineStart(`zero);
  CSS.marginInlineStart(`percent(10.));
  CSS.marginInlineStart(`calc(`add((`pxFloat(10.), `percent(5.)))));
  CSS.marginInlineEnd(`auto);
  CSS.marginInlineEnd(`zero);
  CSS.marginInlineEnd(`percent(10.));
  CSS.marginInlineEnd(`calc(`add((`pxFloat(10.), `percent(5.)))));
  
  CSS.paddingBlockStart(`zero);
  CSS.paddingBlockStart(`percent(10.));
  CSS.paddingBlockStart(`calc(`add((`pxFloat(10.), `percent(5.)))));
  CSS.paddingBlockEnd(`zero);
  CSS.paddingBlockEnd(`percent(10.));
  CSS.paddingBlockEnd(`calc(`add((`pxFloat(10.), `percent(5.)))));
  
  CSS.paddingInlineStart(`zero);
  CSS.paddingInlineStart(`percent(10.));
  CSS.paddingInlineStart(`calc(`add((`pxFloat(10.), `percent(5.)))));
  CSS.paddingInlineEnd(`zero);
  CSS.paddingInlineEnd(`percent(10.));
  CSS.paddingInlineEnd(`calc(`add((`pxFloat(10.), `percent(5.)))));
  
  CSS.marginBlock2(~v=`auto, ~h=`auto);
  CSS.marginBlock2(~v=`pxFloat(10.), ~h=`pxFloat(20.));
  CSS.marginBlock2(~v=`percent(10.), ~h=`percent(20.));
  CSS.marginInline2(~v=`auto, ~h=`auto);
  CSS.marginInline2(~v=`pxFloat(10.), ~h=`pxFloat(20.));
  CSS.marginInline2(~v=`percent(10.), ~h=`percent(20.));
  
  CSS.paddingBlock2(~v=`pxFloat(10.), ~h=`pxFloat(20.));
  CSS.paddingBlock2(~v=`percent(10.), ~h=`percent(20.));
  CSS.paddingInline2(~v=`pxFloat(10.), ~h=`pxFloat(20.));
  CSS.paddingInline2(~v=`percent(10.), ~h=`percent(20.));
  
  CSS.borderBlockWidth(`thin);
  CSS.borderBlockWidth(`medium);
  CSS.borderBlockWidth(`thick);
  CSS.borderBlockWidth(`pxFloat(2.));
  CSS.borderInlineWidth(`thin);
  CSS.borderInlineWidth(`medium);
  CSS.borderInlineWidth(`thick);
  CSS.borderInlineWidth(`pxFloat(2.));
  
  CSS.borderBlockStyle(`none);
  CSS.borderBlockStyle(`solid);
  CSS.borderBlockStyle(`dashed);
  CSS.borderInlineStyle(`none);
  CSS.borderInlineStyle(`solid);
  CSS.borderInlineStyle(`dashed);
