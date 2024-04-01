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
  CssJs.unsafe({js|direction|js}, {js|ltr|js});
  CssJs.unsafe({js|direction|js}, {js|rtl|js});
  CssJs.unsafe({js|unicodeBidi|js}, {js|normal|js});
  CssJs.unsafe({js|unicodeBidi|js}, {js|embed|js});
  CssJs.unsafe({js|unicodeBidi|js}, {js|isolate|js});
  CssJs.unsafe({js|unicodeBidi|js}, {js|bidi-override|js});
  CssJs.unsafe({js|unicodeBidi|js}, {js|isolate-override|js});
  CssJs.unsafe({js|unicodeBidi|js}, {js|plaintext|js});
  CssJs.unsafe({js|writingMode|js}, {js|horizontal-tb|js});
  CssJs.unsafe({js|writingMode|js}, {js|vertical-rl|js});
  CssJs.unsafe({js|writingMode|js}, {js|vertical-lr|js});
  CssJs.unsafe({js|textOrientation|js}, {js|mixed|js});
  CssJs.unsafe({js|textOrientation|js}, {js|upright|js});
  CssJs.unsafe({js|textOrientation|js}, {js|sideways|js});
  CssJs.unsafe({js|textCombineUpright|js}, {js|none|js});
  CssJs.unsafe({js|textCombineUpright|js}, {js|all|js});
  CssJs.unsafe({js|writingMode|js}, {js|sideways-rl|js});
  CssJs.unsafe({js|writingMode|js}, {js|sideways-lr|js});
  CssJs.unsafe({js|textCombineUpright|js}, {js|digits 2|js});
