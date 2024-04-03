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
  CssJs.unsafe({js|placeContent|js}, {js|normal|js});
  CssJs.unsafe({js|placeContent|js}, {js|baseline|js});
  CssJs.unsafe({js|placeContent|js}, {js|first baseline|js});
  CssJs.unsafe({js|placeContent|js}, {js|last baseline|js});
  CssJs.unsafe({js|placeContent|js}, {js|space-between|js});
  CssJs.unsafe({js|placeContent|js}, {js|space-around|js});
  CssJs.unsafe({js|placeContent|js}, {js|space-evenly|js});
  CssJs.unsafe({js|placeContent|js}, {js|stretch|js});
  CssJs.unsafe({js|placeContent|js}, {js|center|js});
  CssJs.unsafe({js|placeContent|js}, {js|start|js});
  CssJs.unsafe({js|placeContent|js}, {js|end|js});
  CssJs.unsafe({js|placeContent|js}, {js|flex-start|js});
  CssJs.unsafe({js|placeContent|js}, {js|flex-end|js});
  CssJs.unsafe({js|placeContent|js}, {js|unsafe start|js});
  CssJs.unsafe({js|placeContent|js}, {js|safe start|js});
  CssJs.unsafe({js|placeContent|js}, {js|normal normal|js});
  CssJs.unsafe({js|placeContent|js}, {js|baseline normal|js});
  CssJs.unsafe({js|placeContent|js}, {js|first baseline normal|js});
  CssJs.unsafe({js|placeContent|js}, {js|space-between normal|js});
  CssJs.unsafe({js|placeContent|js}, {js|center normal|js});
  CssJs.unsafe({js|placeContent|js}, {js|unsafe start normal|js});
  CssJs.unsafe({js|placeContent|js}, {js|normal stretch|js});
  CssJs.unsafe({js|placeContent|js}, {js|baseline stretch|js});
  CssJs.unsafe({js|placeContent|js}, {js|first baseline stretch|js});
  CssJs.unsafe({js|placeContent|js}, {js|center stretch|js});
  CssJs.unsafe({js|placeContent|js}, {js|unsafe start stretch|js});
  CssJs.unsafe({js|placeContent|js}, {js|normal safe right|js});
  CssJs.unsafe({js|placeContent|js}, {js|baseline safe right|js});
  CssJs.unsafe({js|placeContent|js}, {js|first baseline safe right|js});
  CssJs.unsafe({js|placeContent|js}, {js|space-between safe right|js});
  CssJs.unsafe({js|placeContent|js}, {js|center safe right|js});
  CssJs.unsafe({js|placeContent|js}, {js|unsafe start safe right|js});
  CssJs.unsafe({js|placeItems|js}, {js|normal|js});
  CssJs.unsafe({js|placeItems|js}, {js|stretch|js});
  CssJs.unsafe({js|placeItems|js}, {js|baseline|js});
  CssJs.unsafe({js|placeItems|js}, {js|first baseline|js});
  CssJs.unsafe({js|placeItems|js}, {js|last baseline|js});
  CssJs.unsafe({js|placeItems|js}, {js|center|js});
  CssJs.unsafe({js|placeItems|js}, {js|start|js});
  CssJs.unsafe({js|placeItems|js}, {js|end|js});
  CssJs.unsafe({js|placeItems|js}, {js|self-start|js});
  CssJs.unsafe({js|placeItems|js}, {js|self-end|js});
  CssJs.unsafe({js|placeItems|js}, {js|unsafe start|js});
  CssJs.unsafe({js|placeItems|js}, {js|safe start|js});
  CssJs.unsafe({js|placeItems|js}, {js|normal normal|js});
  CssJs.unsafe({js|placeItems|js}, {js|stretch normal|js});
  CssJs.unsafe({js|placeItems|js}, {js|baseline normal|js});
  CssJs.unsafe({js|placeItems|js}, {js|first baseline normal|js});
  CssJs.unsafe({js|placeItems|js}, {js|self-start normal|js});
  CssJs.unsafe({js|placeItems|js}, {js|unsafe start normal|js});
  CssJs.unsafe({js|placeItems|js}, {js|normal stretch|js});
  CssJs.unsafe({js|placeItems|js}, {js|stretch stretch|js});
  CssJs.unsafe({js|placeItems|js}, {js|baseline stretch|js});
  CssJs.unsafe({js|placeItems|js}, {js|first baseline stretch|js});
  CssJs.unsafe({js|placeItems|js}, {js|self-start stretch|js});
  CssJs.unsafe({js|placeItems|js}, {js|unsafe start stretch|js});
  CssJs.unsafe({js|placeItems|js}, {js|normal last baseline|js});
  CssJs.unsafe({js|placeItems|js}, {js|stretch last baseline|js});
  CssJs.unsafe({js|placeItems|js}, {js|baseline last baseline|js});
  CssJs.unsafe({js|placeItems|js}, {js|first baseline last baseline|js});
  CssJs.unsafe({js|placeItems|js}, {js|self-start last baseline|js});
  CssJs.unsafe({js|placeItems|js}, {js|unsafe start last baseline|js});
  CssJs.unsafe({js|placeItems|js}, {js|normal legacy left|js});
  CssJs.unsafe({js|placeItems|js}, {js|stretch legacy left|js});
  CssJs.unsafe({js|placeItems|js}, {js|baseline legacy left|js});
  CssJs.unsafe({js|placeItems|js}, {js|first baseline legacy left|js});
  CssJs.unsafe({js|placeItems|js}, {js|self-start legacy left|js});
  CssJs.unsafe({js|placeItems|js}, {js|unsafe start legacy left|js});
  CssJs.gap2(~rowGap=`zero, ~columnGap=`zero);
  CssJs.gap2(~rowGap=`zero, ~columnGap=`em(1.));
  CssJs.gap(`em(1.));
  CssJs.gap2(~rowGap=`em(1.), ~columnGap=`em(1.));
  CssJs.unsafe({js|columnGap|js}, {js|0|js});
  CssJs.unsafe({js|columnGap|js}, {js|1em|js});
  CssJs.unsafe({js|columnGap|js}, {js|normal|js});
  CssJs.unsafe({js|rowGap|js}, {js|0|js});
  CssJs.unsafe({js|rowGap|js}, {js|1em|js});
  CssJs.unsafe({js|marginTrim|js}, {js|none|js});
  CssJs.unsafe({js|marginTrim|js}, {js|in-flow|js});
  CssJs.unsafe({js|marginTrim|js}, {js|all|js});
