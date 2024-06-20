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
  CssJs.unsafe({|touchAction|}, {|auto|});
  CssJs.unsafe({|touchAction|}, {|none|});
  CssJs.unsafe({|touchAction|}, {|pan-x|});
  CssJs.unsafe({|touchAction|}, {|pan-y|});
  CssJs.unsafe({|touchAction|}, {|pan-x pan-y|});
  CssJs.unsafe({|touchAction|}, {|manipulation|});
  CssJs.unsafe({|touchAction|}, {|pan-left|});
  CssJs.unsafe({|touchAction|}, {|pan-right|});
  CssJs.unsafe({|touchAction|}, {|pan-up|});
  CssJs.unsafe({|touchAction|}, {|pan-down|});
  CssJs.unsafe({|touchAction|}, {|pan-left pan-up|});
  CssJs.unsafe({|touchAction|}, {|pinch-zoom|});
  CssJs.unsafe({|touchAction|}, {|pan-x pinch-zoom|});
  CssJs.unsafe({|touchAction|}, {|pan-y pinch-zoom|});
  CssJs.unsafe({|touchAction|}, {|pan-x pan-y pinch-zoom|});
