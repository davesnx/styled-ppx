This test ensures the ppx generates the correct output against styled-ppx.emotion_native
If this test fail means that the module is not in sync with the ppx

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native)
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
  module X = {
    let value = 1.;
    let flex1 = `num(1.);
    let min = `px(500);
  };
  CssJs.alignContent(`flexStart);
  CssJs.alignContent(`flexEnd);
  CssJs.alignContent(`spaceBetween);
  CssJs.alignContent(`spaceAround);
  CssJs.alignItems(`flexStart);
  CssJs.alignItems(`flexEnd);
  CssJs.alignSelf(`flexStart);
  CssJs.alignSelf(`flexEnd);
  CssJs.display(`flex);
  CssJs.display(`inlineFlex);
  CssJs.flex1(`none);
  CssJs.flex(5., 7., `percent(10.));
  CssJs.flex1(`num(2.));
  CssJs.flexBasis(`em(10.));
  CssJs.flexBasis(`percent(30.));
  CssJs.flexBasis(`minContent);
  CssJs.flex2(~basis=`pxFloat(30.), 1.);
  CssJs.flex2(~shrink=2., 2.);
  CssJs.flex(2., 2., `percent(10.));
  CssJs.flex1(X.flex1);
  CssJs.flex2(~shrink=X.value, X.value);
  CssJs.flex(X.value, X.value, X.min);
  CssJs.flexBasis(`auto);
  CssJs.flexBasis(`content);
  CssJs.flexBasis(`pxFloat(1.));
  CssJs.flexDirection(`row);
  CssJs.flexDirection(`rowReverse);
  CssJs.flexDirection(`column);
  CssJs.flexDirection(`columnReverse);
  CssJs.flexDirection(`row);
  CssJs.flexDirection(`rowReverse);
  CssJs.flexDirection(`column);
  CssJs.flexDirection(`columnReverse);
  CssJs.flexWrap(`wrap);
  CssJs.flexWrap(`wrapReverse);
  CssJs.flexGrow(0.);
  CssJs.flexGrow(5.);
  CssJs.flexShrink(1.);
  CssJs.flexShrink(10.);
  CssJs.flexWrap(`nowrap);
  CssJs.flexWrap(`wrap);
  CssJs.flexWrap(`wrapReverse);
  CssJs.justifyContent(`flexStart);
  CssJs.justifyContent(`flexEnd);
  CssJs.justifyContent(`spaceBetween);
  CssJs.justifyContent(`spaceAround);
  CssJs.unsafe({js|minHeight|js}, {js|auto|js});
  CssJs.unsafe({js|minWidth|js}, {js|auto|js});
  CssJs.order(0);
  CssJs.order(1);
