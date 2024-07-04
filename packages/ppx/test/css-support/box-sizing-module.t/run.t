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
  CssJs.width(`maxContent);
  CssJs.width(`minContent);
  CssJs.unsafe({js|width|js}, {js|fit-content(10%)|js});
  CssJs.minWidth(`maxContent);
  CssJs.minWidth(`minContent);
  CssJs.unsafe({js|minWidth|js}, {js|fit-content(10%)|js});
  CssJs.maxWidth(`maxContent);
  CssJs.maxWidth(`minContent);
  CssJs.unsafe({js|maxWidth|js}, {js|fit-content(10%)|js});
  CssJs.height(`maxContent);
  CssJs.height(`minContent);
  CssJs.unsafe({js|height|js}, {js|fit-content(10%)|js});
  CssJs.minHeight(`maxContent);
  CssJs.minHeight(`minContent);
  CssJs.unsafe({js|minHeight|js}, {js|fit-content(10%)|js});
  CssJs.maxHeight(`maxContent);
  CssJs.maxHeight(`minContent);
  CssJs.unsafe({js|maxHeight|js}, {js|fit-content(10%)|js});
  CssJs.aspectRatio(`auto);
  CssJs.aspectRatio(`num(2.));
  CssJs.aspectRatio(`ratio((16, 9)));
  CssJs.unsafe({js|width|js}, {js|fit-content|js});
  CssJs.unsafe({js|minWidth|js}, {js|fit-content|js});
  CssJs.unsafe({js|maxWidth|js}, {js|fit-content|js});
  CssJs.unsafe({js|height|js}, {js|fit-content|js});
  CssJs.unsafe({js|minHeight|js}, {js|fit-content|js});
  CssJs.unsafe({js|maxHeight|js}, {js|fit-content|js});
