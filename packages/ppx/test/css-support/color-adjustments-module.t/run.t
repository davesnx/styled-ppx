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
  CssJs.unsafe({|colorAdjust|}, {|economy|});
  CssJs.unsafe({|colorAdjust|}, {|exact|});
  CssJs.unsafe({|forcedColorAdjust|}, {|auto|});
  CssJs.unsafe({|forcedColorAdjust|}, {|none|});
  CssJs.unsafe({|forcedColorAdjust|}, {|preserve-parent-color|});
  CssJs.unsafe({|colorScheme|}, {|normal|});
  CssJs.unsafe({|colorScheme|}, {|light|});
  CssJs.unsafe({|colorScheme|}, {|dark|});
  CssJs.unsafe({|colorScheme|}, {|light dark|});
  CssJs.unsafe({|colorScheme|}, {|dark light|});
  CssJs.unsafe({|colorScheme|}, {|only light|});
  CssJs.unsafe({|colorScheme|}, {|light only|});
  CssJs.unsafe({|colorScheme|}, {|light light|});
  CssJs.unsafe({|colorScheme|}, {|dark dark|});
  CssJs.unsafe({|colorScheme|}, {|light purple|});
  CssJs.unsafe({|colorScheme|}, {|purple dark interesting|});
  CssJs.unsafe({|colorScheme|}, {|none|});
  CssJs.unsafe({|colorScheme|}, {|light none|});
