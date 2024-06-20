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
  CssJs.unsafe({|mixBlendMode|}, {|normal|});
  CssJs.unsafe({|mixBlendMode|}, {|multiply|});
  CssJs.unsafe({|mixBlendMode|}, {|screen|});
  CssJs.unsafe({|mixBlendMode|}, {|overlay|});
  CssJs.unsafe({|mixBlendMode|}, {|darken|});
  CssJs.unsafe({|mixBlendMode|}, {|lighten|});
  CssJs.unsafe({|mixBlendMode|}, {|color-dodge|});
  CssJs.unsafe({|mixBlendMode|}, {|color-burn|});
  CssJs.unsafe({|mixBlendMode|}, {|hard-light|});
  CssJs.unsafe({|mixBlendMode|}, {|soft-light|});
  CssJs.unsafe({|mixBlendMode|}, {|difference|});
  CssJs.unsafe({|mixBlendMode|}, {|exclusion|});
  CssJs.unsafe({|mixBlendMode|}, {|hue|});
  CssJs.unsafe({|mixBlendMode|}, {|saturation|});
  CssJs.unsafe({|mixBlendMode|}, {|color|});
  CssJs.unsafe({|mixBlendMode|}, {|luminosity|});
  CssJs.unsafe({|isolation|}, {|auto|});
  CssJs.unsafe({|isolation|}, {|isolate|});
  CssJs.unsafe({|backgroundBlendMode|}, {|normal|});
  CssJs.unsafe({|backgroundBlendMode|}, {|multiply|});
  CssJs.unsafe({|backgroundBlendMode|}, {|screen|});
  CssJs.unsafe({|backgroundBlendMode|}, {|overlay|});
  CssJs.unsafe({|backgroundBlendMode|}, {|darken|});
  CssJs.unsafe({|backgroundBlendMode|}, {|lighten|});
  CssJs.unsafe({|backgroundBlendMode|}, {|color-dodge|});
  CssJs.unsafe({|backgroundBlendMode|}, {|color-burn|});
  CssJs.unsafe({|backgroundBlendMode|}, {|hard-light|});
  CssJs.unsafe({|backgroundBlendMode|}, {|soft-light|});
  CssJs.unsafe({|backgroundBlendMode|}, {|difference|});
  CssJs.unsafe({|backgroundBlendMode|}, {|exclusion|});
  CssJs.unsafe({|backgroundBlendMode|}, {|hue|});
  CssJs.unsafe({|backgroundBlendMode|}, {|saturation|});
  CssJs.unsafe({|backgroundBlendMode|}, {|color|});
  CssJs.unsafe({|backgroundBlendMode|}, {|luminosity|});
  CssJs.unsafe({|backgroundBlendMode|}, {|normal, multiply|});
