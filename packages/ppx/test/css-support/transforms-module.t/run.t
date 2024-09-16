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


  $ dune describe pp ./input.re | sed '1,/^];$/d'
  
  CSS.transform(`none);
  CSS.transform(CSS.translate(`pxFloat(5.), `zero));
  CSS.transform(CSS.translate(`pxFloat(5.), `pxFloat(10.)));
  CSS.transform(CSS.translateY(`pxFloat(5.)));
  CSS.transform(CSS.translateX(`pxFloat(5.)));
  CSS.transform(CSS.translateY(`percent(5.)));
  CSS.transform(CSS.translateX(`percent(5.)));
  CSS.transform(CSS.scale(2., 2.));
  CSS.transform(CSS.scale(2., -1.));
  CSS.transform(CSS.scaleX(2.));
  CSS.transform(CSS.scaleY(2.5));
  CSS.transform(CSS.rotate(`deg(45.)));
  CSS.transform(CSS.skew(`deg(45.), `deg(0.)));
  CSS.transform(CSS.skew(`deg(45.), `deg(15.)));
  CSS.transform(CSS.skewX(`deg(45.)));
  CSS.transform(CSS.skewY(`deg(45.)));
  
  CSS.transforms([|
    CSS.translate(`pxFloat(50.), `pxFloat(-24.)),
    CSS.skew(`deg(0.), `deg(22.5)),
  |]);
  CSS.transform(CSS.translate3d(`zero, `zero, `pxFloat(5.)));
  CSS.transform(CSS.translateZ(`pxFloat(5.)));
  CSS.transform(CSS.scale3d(1., 0., -1.));
  CSS.transform(CSS.scaleZ(1.5));
  CSS.transform(CSS.rotate3d(1., 1., 1., `deg(45.)));
  CSS.transform(CSS.rotateX(`deg(-45.)));
  CSS.transform(CSS.rotateY(`deg(-45.)));
  CSS.transform(CSS.rotateZ(`deg(-45.)));
  
  CSS.transforms([|
    CSS.translate3d(`pxFloat(50.), `pxFloat(-24.), `pxFloat(5.)),
    CSS.rotate3d(1., 2., 3., `deg(180.)),
    CSS.scale3d(-1., 0., 0.5),
  |]);
  CSS.unsafe({js|transform|js}, {js|perspective(600px)|js});
  CSS.transformOrigin(`pxFloat(10.));
  CSS.transformOrigin(`top);
  CSS.transformOrigin(`hv((`left, `top)));
  CSS.transformOrigin(`hv((`percent(50.), `percent(100.))));
  CSS.transformOrigin(`hv((`left, `percent(0.))));
  CSS.transformOrigin(`hvOffset((`left, `percent(50.), `zero)));
  CSS.transformBox(`borderBox);
  CSS.transformBox(`fillBox);
  CSS.transformBox(`viewBox);
  CSS.transformBox(`contentBox);
  CSS.transformBox(`strokeBox);
  
  CSS.translateProperty(`none);
  CSS.translateProperty(`percent(50.));
  CSS.translateProperty2(`percent(50.), `percent(50.));
  CSS.translateProperty3(`percent(50.), `percent(50.), `pxFloat(10.));
  CSS.translateProperty(`none);
  CSS.scaleProperty(`num(2.));
  CSS.scaleProperty2(`num(2.), `num(2.));
  CSS.scaleProperty3(`num(2.), `num(2.), `num(2.));
  CSS.rotateProperty(`none);
  CSS.rotateProperty(`rotate(`deg(45.)));
  CSS.rotateProperty(`rotateX(`deg(45.)));
  CSS.rotateProperty(`rotateY(`deg(45.)));
  CSS.rotateProperty(`rotateZ(`deg(45.)));
  CSS.rotateProperty(`rotate3d(((-1.), 0., 2., `deg(45.))));
  CSS.rotateProperty(`rotateX(`deg(45.)));
  CSS.rotateProperty(`rotateY(`deg(45.)));
  CSS.rotateProperty(`rotateZ(`deg(45.)));
  CSS.rotateProperty(`rotate3d(((-1.), 0., 2., `deg(45.))));
  CSS.transformStyle(`flat);
  CSS.transformStyle(`preserve3d);
  CSS.perspectiveProperty(`none);
  CSS.perspectiveProperty(`pxFloat(600.));
  CSS.perspectiveOrigin(`pxFloat(10.));
  CSS.perspectiveOrigin(`top);
  CSS.perspectiveOrigin(`hv((`left, `top)));
  CSS.perspectiveOrigin(`hv((`percent(50.), `percent(100.))));
  CSS.perspectiveOrigin(`hv((`left, `percent(0.))));
  CSS.backfaceVisibility(`visible);
  CSS.backfaceVisibility(`hidden);
