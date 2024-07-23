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

  $ dune describe pp ./input.re
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
  
  CSS.unsafe({js|colorAdjust|js}, {js|economy|js});
  CSS.unsafe({js|colorAdjust|js}, {js|exact|js});
  CSS.unsafe({js|forcedColorAdjust|js}, {js|auto|js});
  CSS.unsafe({js|forcedColorAdjust|js}, {js|none|js});
  CSS.unsafe({js|forcedColorAdjust|js}, {js|preserve-parent-color|js});
  CSS.unsafe({js|colorScheme|js}, {js|normal|js});
  CSS.unsafe({js|colorScheme|js}, {js|light|js});
  CSS.unsafe({js|colorScheme|js}, {js|dark|js});
  CSS.unsafe({js|colorScheme|js}, {js|light dark|js});
  CSS.unsafe({js|colorScheme|js}, {js|dark light|js});
  CSS.unsafe({js|colorScheme|js}, {js|only light|js});
  CSS.unsafe({js|colorScheme|js}, {js|light only|js});
  CSS.unsafe({js|colorScheme|js}, {js|light light|js});
  CSS.unsafe({js|colorScheme|js}, {js|dark dark|js});
  CSS.unsafe({js|colorScheme|js}, {js|light purple|js});
  CSS.unsafe({js|colorScheme|js}, {js|purple dark interesting|js});
  CSS.unsafe({js|colorScheme|js}, {js|none|js});
  CSS.unsafe({js|colorScheme|js}, {js|light none|js});
