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
  CssJs.unsafe({js|touchAction|js}, {js|auto|js});
  CssJs.unsafe({js|touchAction|js}, {js|none|js});
  CssJs.unsafe({js|touchAction|js}, {js|pan-x|js});
  CssJs.unsafe({js|touchAction|js}, {js|pan-y|js});
  CssJs.unsafe({js|touchAction|js}, {js|pan-x pan-y|js});
  CssJs.unsafe({js|touchAction|js}, {js|manipulation|js});
  CssJs.unsafe({js|touchAction|js}, {js|pan-left|js});
  CssJs.unsafe({js|touchAction|js}, {js|pan-right|js});
  CssJs.unsafe({js|touchAction|js}, {js|pan-up|js});
  CssJs.unsafe({js|touchAction|js}, {js|pan-down|js});
  CssJs.unsafe({js|touchAction|js}, {js|pan-left pan-up|js});
  CssJs.unsafe({js|touchAction|js}, {js|pinch-zoom|js});
  CssJs.unsafe({js|touchAction|js}, {js|pan-x pinch-zoom|js});
  CssJs.unsafe({js|touchAction|js}, {js|pan-y pinch-zoom|js});
  CssJs.unsafe({js|touchAction|js}, {js|pan-x pan-y pinch-zoom|js});
