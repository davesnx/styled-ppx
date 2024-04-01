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
  CssJs.unsafe({js|mixBlendMode|js}, {js|normal|js});
  CssJs.unsafe({js|mixBlendMode|js}, {js|multiply|js});
  CssJs.unsafe({js|mixBlendMode|js}, {js|screen|js});
  CssJs.unsafe({js|mixBlendMode|js}, {js|overlay|js});
  CssJs.unsafe({js|mixBlendMode|js}, {js|darken|js});
  CssJs.unsafe({js|mixBlendMode|js}, {js|lighten|js});
  CssJs.unsafe({js|mixBlendMode|js}, {js|color-dodge|js});
  CssJs.unsafe({js|mixBlendMode|js}, {js|color-burn|js});
  CssJs.unsafe({js|mixBlendMode|js}, {js|hard-light|js});
  CssJs.unsafe({js|mixBlendMode|js}, {js|soft-light|js});
  CssJs.unsafe({js|mixBlendMode|js}, {js|difference|js});
  CssJs.unsafe({js|mixBlendMode|js}, {js|exclusion|js});
  CssJs.unsafe({js|mixBlendMode|js}, {js|hue|js});
  CssJs.unsafe({js|mixBlendMode|js}, {js|saturation|js});
  CssJs.unsafe({js|mixBlendMode|js}, {js|color|js});
  CssJs.unsafe({js|mixBlendMode|js}, {js|luminosity|js});
  CssJs.unsafe({js|isolation|js}, {js|auto|js});
  CssJs.unsafe({js|isolation|js}, {js|isolate|js});
  CssJs.unsafe({js|backgroundBlendMode|js}, {js|normal|js});
  CssJs.unsafe({js|backgroundBlendMode|js}, {js|multiply|js});
  CssJs.unsafe({js|backgroundBlendMode|js}, {js|screen|js});
  CssJs.unsafe({js|backgroundBlendMode|js}, {js|overlay|js});
  CssJs.unsafe({js|backgroundBlendMode|js}, {js|darken|js});
  CssJs.unsafe({js|backgroundBlendMode|js}, {js|lighten|js});
  CssJs.unsafe({js|backgroundBlendMode|js}, {js|color-dodge|js});
  CssJs.unsafe({js|backgroundBlendMode|js}, {js|color-burn|js});
  CssJs.unsafe({js|backgroundBlendMode|js}, {js|hard-light|js});
  CssJs.unsafe({js|backgroundBlendMode|js}, {js|soft-light|js});
  CssJs.unsafe({js|backgroundBlendMode|js}, {js|difference|js});
  CssJs.unsafe({js|backgroundBlendMode|js}, {js|exclusion|js});
  CssJs.unsafe({js|backgroundBlendMode|js}, {js|hue|js});
  CssJs.unsafe({js|backgroundBlendMode|js}, {js|saturation|js});
  CssJs.unsafe({js|backgroundBlendMode|js}, {js|color|js});
  CssJs.unsafe({js|backgroundBlendMode|js}, {js|luminosity|js});
  CssJs.unsafe({js|backgroundBlendMode|js}, {js|normal, multiply|js});
