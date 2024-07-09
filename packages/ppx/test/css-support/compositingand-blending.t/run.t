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
  CSS.unsafe({js|mixBlendMode|js}, {js|normal|js});
  CSS.unsafe({js|mixBlendMode|js}, {js|multiply|js});
  CSS.unsafe({js|mixBlendMode|js}, {js|screen|js});
  CSS.unsafe({js|mixBlendMode|js}, {js|overlay|js});
  CSS.unsafe({js|mixBlendMode|js}, {js|darken|js});
  CSS.unsafe({js|mixBlendMode|js}, {js|lighten|js});
  CSS.unsafe({js|mixBlendMode|js}, {js|color-dodge|js});
  CSS.unsafe({js|mixBlendMode|js}, {js|color-burn|js});
  CSS.unsafe({js|mixBlendMode|js}, {js|hard-light|js});
  CSS.unsafe({js|mixBlendMode|js}, {js|soft-light|js});
  CSS.unsafe({js|mixBlendMode|js}, {js|difference|js});
  CSS.unsafe({js|mixBlendMode|js}, {js|exclusion|js});
  CSS.unsafe({js|mixBlendMode|js}, {js|hue|js});
  CSS.unsafe({js|mixBlendMode|js}, {js|saturation|js});
  CSS.unsafe({js|mixBlendMode|js}, {js|color|js});
  CSS.unsafe({js|mixBlendMode|js}, {js|luminosity|js});
  CSS.unsafe({js|isolation|js}, {js|auto|js});
  CSS.unsafe({js|isolation|js}, {js|isolate|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|normal|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|multiply|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|screen|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|overlay|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|darken|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|lighten|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|color-dodge|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|color-burn|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|hard-light|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|soft-light|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|difference|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|exclusion|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|hue|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|saturation|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|color|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|luminosity|js});
  CSS.unsafe({js|backgroundBlendMode|js}, {js|normal, multiply|js});
