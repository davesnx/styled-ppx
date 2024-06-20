This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native styled-ppx.css_native)
  >  (preprocess (pps styled-ppx)))
  > EOF


  $ dune describe pp ./input.re.ml | refmt --parse ml --print re
  [@ocaml.ppx.context
    {
      tool_name: "ppx_driver",
      include_dirs: [],
      load_path: [],
      open_modules: [],
      for_package: None,
      debug: false,
      use_threads: false,
      use_vmthreads: false,
      recursive_types: false,
      principal: false,
      transparent_modules: false,
      unboxed_types: false,
      unsafe_string: false,
      cookies: [],
    }
  ];
  CssJs.transform(`none);
  CssJs.transform(CssJs.translate(`pxFloat(5.), `zero));
  CssJs.transform(CssJs.translate(`pxFloat(5.), `pxFloat(10.)));
  CssJs.transform(CssJs.translateY(`pxFloat(5.)));
  CssJs.transform(CssJs.translateX(`pxFloat(5.)));
  CssJs.transform(CssJs.translateY(`percent(5.)));
  CssJs.transform(CssJs.translateX(`percent(5.)));
  CssJs.transform(CssJs.scale(2., 2.));
  CssJs.transform(CssJs.scale(2., -1.));
  CssJs.transform(CssJs.scaleX(2.));
  CssJs.transform(CssJs.scaleY(2.5));
  CssJs.transform(CssJs.rotate(`deg(45.)));
  CssJs.transform(CssJs.skew(`deg(45.), `deg(0.)));
  CssJs.transform(CssJs.skew(`deg(45.), `deg(15.)));
  CssJs.transform(CssJs.skewX(`deg(45.)));
  CssJs.transform(CssJs.skewY(`deg(45.)));
  CssJs.transforms([|
    CssJs.translate(`pxFloat(50.), `pxFloat(-24.)),
    CssJs.skew(`deg(0.), `deg(22.5)),
  |]);
  CssJs.transform(CssJs.translate3d(`zero, `zero, `pxFloat(5.)));
  CssJs.transform(CssJs.translateZ(`pxFloat(5.)));
  CssJs.transform(CssJs.scale3d(1., 0., -1.));
  CssJs.transform(CssJs.scaleZ(1.5));
  CssJs.transform(CssJs.rotate3d(1., 1., 1., `deg(45.)));
  CssJs.transform(CssJs.rotateX(`deg(-45.)));
  CssJs.transform(CssJs.rotateY(`deg(-45.)));
  CssJs.transform(CssJs.rotateZ(`deg(-45.)));
  CssJs.transforms([|
    CssJs.translate3d(`pxFloat(50.), `pxFloat(-24.), `pxFloat(5.)),
    CssJs.rotate3d(1., 2., 3., `deg(180.)),
    CssJs.scale3d(-1., 0., 0.5),
  |]);
  CssJs.unsafe({|transform|}, {|perspective(600px)|});
  CssJs.transformOrigin(`pxFloat(10.));
  CssJs.transformOrigin(`top);
  CssJs.transformOrigin2(`top, `left);
  CssJs.transformOrigin2(`percent(50.), `percent(100.));
  CssJs.transformOrigin2(`percent(0.), `left);
  CssJs.unsafe({|transformOrigin|}, {|left 50% 0|});
  CssJs.transformBox(`borderBox);
  CssJs.transformBox(`fillBox);
  CssJs.transformBox(`viewBox);
  CssJs.transformBox(`contentBox);
  CssJs.transformBox(`strokeBox);
  CssJs.unsafe({|translate|}, {|none|});
  CssJs.unsafe({|translate|}, {|50%|});
  CssJs.unsafe({|translate|}, {|50% 50%|});
  CssJs.unsafe({|translate|}, {|50% 50% 10px|});
  CssJs.unsafe({|scale|}, {|none|});
  CssJs.unsafe({|scale|}, {|2|});
  CssJs.unsafe({|scale|}, {|2 2|});
  CssJs.unsafe({|scale|}, {|2 2 2|});
  CssJs.unsafe({|rotate|}, {|none|});
  CssJs.unsafe({|rotate|}, {|45deg|});
  CssJs.unsafe({|rotate|}, {|x 45deg|});
  CssJs.unsafe({|rotate|}, {|y 45deg|});
  CssJs.unsafe({|rotate|}, {|z 45deg|});
  CssJs.unsafe({|rotate|}, {|-1 0 2 45deg|});
  CssJs.unsafe({|rotate|}, {|45deg x|});
  CssJs.unsafe({|rotate|}, {|45deg y|});
  CssJs.unsafe({|rotate|}, {|45deg z|});
  CssJs.unsafe({|rotate|}, {|45deg -1 0 2|});
  CssJs.transformStyle(`flat);
  CssJs.transformStyle(`preserve3d);
  CssJs.unsafe({|perspective|}, {|none|});
  CssJs.unsafe({|perspective|}, {|600px|});
  CssJs.perspectiveOrigin2(`pxFloat(10.), `center);
  CssJs.perspectiveOrigin2(`center, `top);
  CssJs.perspectiveOrigin2(`left, `top);
  CssJs.unsafe({|perspectiveOrigin|}, {|50% 100%|});
  CssJs.unsafe({|perspectiveOrigin|}, {|left 0%|});
  CssJs.backfaceVisibility(`visible);
  CssJs.backfaceVisibility(`hidden);
