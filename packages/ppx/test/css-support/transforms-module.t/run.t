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
  >  (preprocess (pps styled-ppx.lib)))
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
  CssJs.unsafe({js|transform|js}, {js|perspective(600px)|js});
  CssJs.transformOrigin(`pxFloat(10.));
  CssJs.transformOrigin(`top);
  CssJs.transformOrigin2(`top, `left);
  CssJs.transformOrigin2(`percent(50.), `percent(100.));
  CssJs.transformOrigin2(`percent(0.), `left);
  CssJs.unsafe({js|transformOrigin|js}, {js|left 50% 0|js});
  CssJs.transformBox(`borderBox);
  CssJs.transformBox(`fillBox);
  CssJs.transformBox(`viewBox);
  CssJs.transformBox(`contentBox);
  CssJs.transformBox(`strokeBox);
  CssJs.unsafe({js|translate|js}, {js|none|js});
  CssJs.unsafe({js|translate|js}, {js|50%|js});
  CssJs.unsafe({js|translate|js}, {js|50% 50%|js});
  CssJs.unsafe({js|translate|js}, {js|50% 50% 10px|js});
  CssJs.unsafe({js|scale|js}, {js|none|js});
  CssJs.unsafe({js|scale|js}, {js|2|js});
  CssJs.unsafe({js|scale|js}, {js|2 2|js});
  CssJs.unsafe({js|scale|js}, {js|2 2 2|js});
  CssJs.unsafe({js|rotate|js}, {js|none|js});
  CssJs.unsafe({js|rotate|js}, {js|45deg|js});
  CssJs.unsafe({js|rotate|js}, {js|x 45deg|js});
  CssJs.unsafe({js|rotate|js}, {js|y 45deg|js});
  CssJs.unsafe({js|rotate|js}, {js|z 45deg|js});
  CssJs.unsafe({js|rotate|js}, {js|-1 0 2 45deg|js});
  CssJs.unsafe({js|rotate|js}, {js|45deg x|js});
  CssJs.unsafe({js|rotate|js}, {js|45deg y|js});
  CssJs.unsafe({js|rotate|js}, {js|45deg z|js});
  CssJs.unsafe({js|rotate|js}, {js|45deg -1 0 2|js});
  CssJs.transformStyle(`flat);
  CssJs.transformStyle(`preserve3d);
  CssJs.unsafe({js|perspective|js}, {js|none|js});
  CssJs.unsafe({js|perspective|js}, {js|600px|js});
  CssJs.perspectiveOrigin2(`pxFloat(10.), `center);
  CssJs.perspectiveOrigin2(`center, `top);
  CssJs.perspectiveOrigin2(`left, `top);
  CssJs.unsafe({js|perspectiveOrigin|js}, {js|50% 100%|js});
  CssJs.unsafe({js|perspectiveOrigin|js}, {js|left 0%|js});
  CssJs.backfaceVisibility(`visible);
  CssJs.backfaceVisibility(`hidden);
