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
  CssJs.unsafe({|direction|}, {|ltr|});
  CssJs.unsafe({|direction|}, {|rtl|});
  CssJs.unsafe({|unicodeBidi|}, {|normal|});
  CssJs.unsafe({|unicodeBidi|}, {|embed|});
  CssJs.unsafe({|unicodeBidi|}, {|isolate|});
  CssJs.unsafe({|unicodeBidi|}, {|bidi-override|});
  CssJs.unsafe({|unicodeBidi|}, {|isolate-override|});
  CssJs.unsafe({|unicodeBidi|}, {|plaintext|});
  CssJs.unsafe({|writingMode|}, {|horizontal-tb|});
  CssJs.unsafe({|writingMode|}, {|vertical-rl|});
  CssJs.unsafe({|writingMode|}, {|vertical-lr|});
  CssJs.unsafe({|textOrientation|}, {|mixed|});
  CssJs.unsafe({|textOrientation|}, {|upright|});
  CssJs.unsafe({|textOrientation|}, {|sideways|});
  CssJs.unsafe({|textCombineUpright|}, {|none|});
  CssJs.unsafe({|textCombineUpright|}, {|all|});
  CssJs.unsafe({|writingMode|}, {|sideways-rl|});
  CssJs.unsafe({|writingMode|}, {|sideways-lr|});
  CssJs.unsafe({|textCombineUpright|}, {|digits 2|});
