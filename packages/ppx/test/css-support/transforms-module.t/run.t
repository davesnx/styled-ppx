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
  CSS.transformOrigin2(`top, `left);
  CSS.transformOrigin2(`percent(50.), `percent(100.));
  CSS.transformOrigin2(`percent(0.), `left);
  CSS.unsafe({js|transformOrigin|js}, {js|left 50% 0|js});
  CSS.transformBox(`borderBox);
  CSS.transformBox(`fillBox);
  CSS.transformBox(`viewBox);
  CSS.transformBox(`contentBox);
  CSS.transformBox(`strokeBox);
  
  CSS.unsafe({js|translate|js}, {js|none|js});
  CSS.unsafe({js|translate|js}, {js|50%|js});
  CSS.unsafe({js|translate|js}, {js|50% 50%|js});
  CSS.unsafe({js|translate|js}, {js|50% 50% 10px|js});
  CSS.unsafe({js|scale|js}, {js|none|js});
  CSS.unsafe({js|scale|js}, {js|2|js});
  CSS.unsafe({js|scale|js}, {js|2 2|js});
  CSS.unsafe({js|scale|js}, {js|2 2 2|js});
  CSS.unsafe({js|rotate|js}, {js|none|js});
  CSS.unsafe({js|rotate|js}, {js|45deg|js});
  CSS.unsafe({js|rotate|js}, {js|x 45deg|js});
  CSS.unsafe({js|rotate|js}, {js|y 45deg|js});
  CSS.unsafe({js|rotate|js}, {js|z 45deg|js});
  CSS.unsafe({js|rotate|js}, {js|-1 0 2 45deg|js});
  CSS.unsafe({js|rotate|js}, {js|45deg x|js});
  CSS.unsafe({js|rotate|js}, {js|45deg y|js});
  CSS.unsafe({js|rotate|js}, {js|45deg z|js});
  CSS.unsafe({js|rotate|js}, {js|45deg -1 0 2|js});
  CSS.transformStyle(`flat);
  CSS.transformStyle(`preserve3d);
  CSS.unsafe({js|perspective|js}, {js|none|js});
  CSS.unsafe({js|perspective|js}, {js|600px|js});
  CSS.perspectiveOrigin2(`pxFloat(10.), `center);
  CSS.perspectiveOrigin2(`center, `top);
  CSS.perspectiveOrigin2(`left, `top);
  CSS.unsafe({js|perspectiveOrigin|js}, {js|50% 100%|js});
  CSS.unsafe({js|perspectiveOrigin|js}, {js|left 0%|js});
  CSS.backfaceVisibility(`visible);
  CSS.backfaceVisibility(`hidden);
