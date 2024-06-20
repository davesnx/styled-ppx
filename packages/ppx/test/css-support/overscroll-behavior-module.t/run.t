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
  CssJs.unsafe({|overscrollBehavior|}, {|contain|});
  CssJs.unsafe({|overscrollBehavior|}, {|none|});
  CssJs.unsafe({|overscrollBehavior|}, {|auto|});
  CssJs.unsafe({|overscrollBehavior|}, {|contain contain|});
  CssJs.unsafe({|overscrollBehavior|}, {|none contain|});
  CssJs.unsafe({|overscrollBehavior|}, {|auto contain|});
  CssJs.unsafe({|overscrollBehavior|}, {|contain none|});
  CssJs.unsafe({|overscrollBehavior|}, {|none none|});
  CssJs.unsafe({|overscrollBehavior|}, {|auto none|});
  CssJs.unsafe({|overscrollBehavior|}, {|contain auto|});
  CssJs.unsafe({|overscrollBehavior|}, {|none auto|});
  CssJs.unsafe({|overscrollBehavior|}, {|auto auto|});
  CssJs.unsafe({|overscrollBehaviorX|}, {|contain|});
  CssJs.unsafe({|overscrollBehaviorX|}, {|none|});
  CssJs.unsafe({|overscrollBehaviorX|}, {|auto|});
  CssJs.unsafe({|overscrollBehaviorY|}, {|contain|});
  CssJs.unsafe({|overscrollBehaviorY|}, {|none|});
  CssJs.unsafe({|overscrollBehaviorY|}, {|auto|});
  CssJs.unsafe({|overscrollBehaviorInline|}, {|contain|});
  CssJs.unsafe({|overscrollBehaviorInline|}, {|none|});
  CssJs.unsafe({|overscrollBehaviorInline|}, {|auto|});
  CssJs.unsafe({|overscrollBehaviorBlock|}, {|contain|});
  CssJs.unsafe({|overscrollBehaviorBlock|}, {|none|});
  CssJs.unsafe({|overscrollBehaviorBlock|}, {|auto|});
