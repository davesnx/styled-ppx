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

  $ dune build

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
  CssJs.alignSelf(`auto);
  CssJs.alignSelf(`normal);
  CssJs.alignSelf(`stretch);
  CssJs.alignSelf(`baseline);
  CssJs.alignSelf(`firstBaseline);
  CssJs.alignSelf(`lastBaseline);
  CssJs.alignSelf(`center);
  CssJs.alignSelf(`start);
  CssJs.alignSelf(`end_);
  CssJs.alignSelf(`selfStart);
  CssJs.alignSelf(`selfEnd);
  CssJs.alignSelf(`unsafe(`start));
  CssJs.alignSelf(`safe(`start));
  CssJs.alignItems(`normal);
  CssJs.alignItems(`stretch);
  CssJs.alignItems(`baseline);
  CssJs.alignItems(`firstBaseline);
  CssJs.alignItems(`lastBaseline);
  CssJs.alignItems(`center);
  CssJs.alignItems(`start);
  CssJs.alignItems(`end_);
  CssJs.alignItems(`selfStart);
  CssJs.alignItems(`selfEnd);
  CssJs.alignItems(`unsafe(`start));
  CssJs.alignItems(`safe(`start));
  CssJs.alignContent(`normal);
  CssJs.alignContent(`baseline);
  CssJs.alignContent(`firstBaseline);
  CssJs.alignContent(`lastBaseline);
  CssJs.alignContent(`spaceBetween);
  CssJs.alignContent(`spaceAround);
  CssJs.alignContent(`spaceEvenly);
  CssJs.alignContent(`stretch);
  CssJs.alignContent(`center);
  CssJs.alignContent(`start);
  CssJs.alignContent(`end_);
  CssJs.alignContent(`flexStart);
  CssJs.alignContent(`flexEnd);
  CssJs.alignContent(`unsafe(`start));
  CssJs.alignContent(`safe(`start));
  CssJs.justifySelf(`auto);
  CssJs.justifySelf(`normal);
  CssJs.justifySelf(`stretch);
  CssJs.justifySelf(`baseline);
  CssJs.justifySelf(`firstBaseline);
  CssJs.justifySelf(`lastBaseline);
  CssJs.justifySelf(`center);
  CssJs.justifySelf(`start);
  CssJs.justifySelf(`end_);
  CssJs.justifySelf(`selfStart);
  CssJs.justifySelf(`selfEnd);
  CssJs.justifySelf(`unsafe(`start));
  CssJs.justifySelf(`safe(`start));
  CssJs.justifySelf(`left);
  CssJs.justifySelf(`right);
  CssJs.justifySelf(`safe(`right));
  CssJs.justifyItems(`normal);
  CssJs.justifyItems(`stretch);
  CssJs.justifyItems(`baseline);
  CssJs.justifyItems(`firstBaseline);
  CssJs.justifyItems(`lastBaseline);
  CssJs.justifyItems(`center);
  CssJs.justifyItems(`start);
  CssJs.justifyItems(`end_);
  CssJs.justifyItems(`selfStart);
  CssJs.justifyItems(`selfEnd);
  CssJs.justifyItems(`unsafe(`start));
  CssJs.justifyItems(`safe(`start));
  CssJs.justifyItems(`left);
  CssJs.justifyItems(`right);
  CssJs.justifyItems(`safe(`right));
  CssJs.justifyItems(`legacy);
  CssJs.justifyItems(`legacyLeft);
  CssJs.justifyItems(`legacyRight);
  CssJs.justifyItems(`legacyCenter);
  CssJs.justifyContent(`normal);
  CssJs.justifyContent(`spaceBetween);
  CssJs.justifyContent(`spaceAround);
  CssJs.justifyContent(`spaceEvenly);
  CssJs.justifyContent(`stretch);
  CssJs.justifyContent(`center);
  CssJs.justifyContent(`start);
  CssJs.justifyContent(`end_);
  CssJs.justifyContent(`flexStart);
  CssJs.justifyContent(`flexEnd);
  CssJs.justifyContent(`unsafe(`start));
  CssJs.justifyContent(`safe(`start));
  CssJs.justifyContent(`left);
  CssJs.justifyContent(`right);
  CssJs.justifyContent(`safe(`right));
  CssJs.unsafe({|placeContent|}, {|normal|});
  CssJs.unsafe({|placeContent|}, {|baseline|});
  CssJs.unsafe({|placeContent|}, {|first baseline|});
  CssJs.unsafe({|placeContent|}, {|last baseline|});
  CssJs.unsafe({|placeContent|}, {|space-between|});
  CssJs.unsafe({|placeContent|}, {|space-around|});
  CssJs.unsafe({|placeContent|}, {|space-evenly|});
  CssJs.unsafe({|placeContent|}, {|stretch|});
  CssJs.unsafe({|placeContent|}, {|center|});
  CssJs.unsafe({|placeContent|}, {|start|});
  CssJs.unsafe({|placeContent|}, {|end|});
  CssJs.unsafe({|placeContent|}, {|flex-start|});
  CssJs.unsafe({|placeContent|}, {|flex-end|});
  CssJs.unsafe({|placeContent|}, {|unsafe start|});
  CssJs.unsafe({|placeContent|}, {|safe start|});
  CssJs.unsafe({|placeContent|}, {|normal normal|});
  CssJs.unsafe({|placeContent|}, {|baseline normal|});
  CssJs.unsafe({|placeContent|}, {|first baseline normal|});
  CssJs.unsafe({|placeContent|}, {|space-between normal|});
  CssJs.unsafe({|placeContent|}, {|center normal|});
  CssJs.unsafe({|placeContent|}, {|unsafe start normal|});
  CssJs.unsafe({|placeContent|}, {|normal stretch|});
  CssJs.unsafe({|placeContent|}, {|baseline stretch|});
  CssJs.unsafe({|placeContent|}, {|first baseline stretch|});
  CssJs.unsafe({|placeContent|}, {|center stretch|});
  CssJs.unsafe({|placeContent|}, {|unsafe start stretch|});
  CssJs.unsafe({|placeContent|}, {|normal safe right|});
  CssJs.unsafe({|placeContent|}, {|baseline safe right|});
  CssJs.unsafe({|placeContent|}, {|first baseline safe right|});
  CssJs.unsafe({|placeContent|}, {|space-between safe right|});
  CssJs.unsafe({|placeContent|}, {|center safe right|});
  CssJs.unsafe({|placeContent|}, {|unsafe start safe right|});
  CssJs.unsafe({|placeItems|}, {|normal|});
  CssJs.unsafe({|placeItems|}, {|stretch|});
  CssJs.unsafe({|placeItems|}, {|baseline|});
  CssJs.unsafe({|placeItems|}, {|first baseline|});
  CssJs.unsafe({|placeItems|}, {|last baseline|});
  CssJs.unsafe({|placeItems|}, {|center|});
  CssJs.unsafe({|placeItems|}, {|start|});
  CssJs.unsafe({|placeItems|}, {|end|});
  CssJs.unsafe({|placeItems|}, {|self-start|});
  CssJs.unsafe({|placeItems|}, {|self-end|});
  CssJs.unsafe({|placeItems|}, {|unsafe start|});
  CssJs.unsafe({|placeItems|}, {|safe start|});
  CssJs.unsafe({|placeItems|}, {|normal normal|});
  CssJs.unsafe({|placeItems|}, {|stretch normal|});
  CssJs.unsafe({|placeItems|}, {|baseline normal|});
  CssJs.unsafe({|placeItems|}, {|first baseline normal|});
  CssJs.unsafe({|placeItems|}, {|self-start normal|});
  CssJs.unsafe({|placeItems|}, {|unsafe start normal|});
  CssJs.unsafe({|placeItems|}, {|normal stretch|});
  CssJs.unsafe({|placeItems|}, {|stretch stretch|});
  CssJs.unsafe({|placeItems|}, {|baseline stretch|});
  CssJs.unsafe({|placeItems|}, {|first baseline stretch|});
  CssJs.unsafe({|placeItems|}, {|self-start stretch|});
  CssJs.unsafe({|placeItems|}, {|unsafe start stretch|});
  CssJs.unsafe({|placeItems|}, {|normal last baseline|});
  CssJs.unsafe({|placeItems|}, {|stretch last baseline|});
  CssJs.unsafe({|placeItems|}, {|baseline last baseline|});
  CssJs.unsafe({|placeItems|}, {|first baseline last baseline|});
  CssJs.unsafe({|placeItems|}, {|self-start last baseline|});
  CssJs.unsafe({|placeItems|}, {|unsafe start last baseline|});
  CssJs.unsafe({|placeItems|}, {|normal legacy left|});
  CssJs.unsafe({|placeItems|}, {|stretch legacy left|});
  CssJs.unsafe({|placeItems|}, {|baseline legacy left|});
  CssJs.unsafe({|placeItems|}, {|first baseline legacy left|});
  CssJs.unsafe({|placeItems|}, {|self-start legacy left|});
  CssJs.unsafe({|placeItems|}, {|unsafe start legacy left|});
  CssJs.gap2(~rowGap=`zero, ~columnGap=`zero);
  CssJs.gap2(~rowGap=`zero, ~columnGap=`em(1.));
  CssJs.gap(`em(1.));
  CssJs.gap2(~rowGap=`em(1.), ~columnGap=`em(1.));
  CssJs.unsafe({|columnGap|}, {|0|});
  CssJs.unsafe({|columnGap|}, {|1em|});
  CssJs.unsafe({|columnGap|}, {|normal|});
  CssJs.unsafe({|rowGap|}, {|0|});
  CssJs.unsafe({|rowGap|}, {|1em|});
  CssJs.unsafe({|marginTrim|}, {|none|});
  CssJs.unsafe({|marginTrim|}, {|in-flow|});
  CssJs.unsafe({|marginTrim|}, {|all|});
