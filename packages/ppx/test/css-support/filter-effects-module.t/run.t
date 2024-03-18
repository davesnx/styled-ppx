This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat >dune-project <<EOF
  > (lang dune 3.10)
  > EOF

  $ cat >dune <<EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native styled-ppx.css_native)
  >  (preprocess (pps styled-ppx.lib)))
  > EOF

  $ dune build

  $ dune_describe_pp _build/default/input.re.pp.ml | refmt --parse ml --print re
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
  CssJs.filter([|`none|]);
  CssJs.filter([|`url({js|#id|js})|]);
  CssJs.filter([|`url({js|image.svg#id|js})|]);
  CssJs.filter([|`blur(`pxFloat(5.))|]);
  CssJs.filter([|`brightness(`num(0.5))|]);
  CssJs.filter([|`contrast(`percent(150.))|]);
  CssJs.filter([|`grayscale(`percent(50.))|]);
  CssJs.filter([|`hueRotate(`deg(50.))|]);
  CssJs.filter([|`invert(`percent(50.))|]);
  CssJs.filter([|`opacity(`percent(50.))|]);
  CssJs.filter([|`sepia(`percent(50.))|]);
  CssJs.filter([|`saturate(`percent(150.))|]);
  CssJs.filter([|`grayscale(`percent(100.)), `sepia(`percent(100.))|]);
  CssJs.backdropFilter([|`none|]);
  CssJs.backdropFilter([|`url({js|#id|js})|]);
  CssJs.backdropFilter([|`url({js|image.svg#id|js})|]);
  CssJs.backdropFilter([|`blur(`pxFloat(5.))|]);
  CssJs.backdropFilter([|`brightness(`num(0.5))|]);
  CssJs.backdropFilter([|`contrast(`percent(150.))|]);
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
