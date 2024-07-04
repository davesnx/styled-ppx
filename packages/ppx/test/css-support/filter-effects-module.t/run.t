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
  let color = CssJs.hex("333");
  CssJs.filter([|`none|]);
  CssJs.filter([|`url({js|#id|js})|]);
  CssJs.filter([|`url({js|image.svg#id|js})|]);
  CssJs.filter([|`blur(`pxFloat(5.))|]);
  CssJs.filter([|`brightness(`num(0.5))|]);
  CssJs.filter([|`contrast(`percent(150.))|]);
  CssJs.filter([|
    `dropShadow((
      `pxFloat(15.),
      `pxFloat(15.),
      `pxFloat(15.),
      `hex({js|123|js}),
    )),
  |]);
  CssJs.filter([|`grayscale(`percent(50.))|]);
  CssJs.filter([|`hueRotate(`deg(50.))|]);
  CssJs.filter([|`invert(`percent(50.))|]);
  CssJs.filter([|`opacity(`percent(50.))|]);
  CssJs.filter([|`sepia(`percent(50.))|]);
  CssJs.filter([|`saturate(`percent(150.))|]);
  CssJs.filter([|`grayscale(`percent(100.)), `sepia(`percent(100.))|]);
  CssJs.filter([|
    `dropShadow((
      `zero,
      `pxFloat(8.),
      `pxFloat(32.),
      `rgba((0, 0, 0, `num(0.03))),
    )),
  |]);
  CssJs.filter([|
    `dropShadow((`zero, `pxFloat(1.), `zero, color)),
    `dropShadow((`zero, `pxFloat(1.), `zero, color)),
    `dropShadow((`zero, `pxFloat(1.), `zero, color)),
    `dropShadow((
      `zero,
      `pxFloat(32.),
      `pxFloat(48.),
      `rgba((0, 0, 0, `num(0.075))),
    )),
    `dropShadow((
      `zero,
      `pxFloat(8.),
      `pxFloat(32.),
      `rgba((0, 0, 0, `num(0.03))),
    )),
  |]);
  CssJs.backdropFilter([|`none|]);
  CssJs.backdropFilter([|`url({js|#id|js})|]);
  CssJs.backdropFilter([|`url({js|image.svg#id|js})|]);
  CssJs.backdropFilter([|`blur(`pxFloat(5.))|]);
  CssJs.backdropFilter([|`brightness(`num(0.5))|]);
  CssJs.backdropFilter([|`contrast(`percent(150.))|]);
  CssJs.backdropFilter([|
    `dropShadow((
      `pxFloat(15.),
      `pxFloat(15.),
      `pxFloat(15.),
      `rgba((0, 0, 0, `num(1.))),
    )),
  |]);
  CssJs.backdropFilter([|`grayscale(`percent(50.))|]);
  CssJs.backdropFilter([|`hueRotate(`deg(50.))|]);
  CssJs.backdropFilter([|`invert(`percent(50.))|]);
  CssJs.backdropFilter([|`opacity(`percent(50.))|]);
  CssJs.backdropFilter([|`sepia(`percent(50.))|]);
  CssJs.backdropFilter([|`saturate(`percent(150.))|]);
  CssJs.backdropFilter([|
    `grayscale(`percent(100.)),
    `sepia(`percent(100.)),
  |]);
