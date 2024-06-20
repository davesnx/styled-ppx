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
  CssJs.width(`maxContent);
  CssJs.width(`minContent);
  CssJs.unsafe({|width|}, {|fit-content(10%)|});
  CssJs.minWidth(`maxContent);
  CssJs.minWidth(`minContent);
  CssJs.unsafe({|minWidth|}, {|fit-content(10%)|});
  CssJs.maxWidth(`maxContent);
  CssJs.maxWidth(`minContent);
  CssJs.unsafe({|maxWidth|}, {|fit-content(10%)|});
  CssJs.height(`maxContent);
  CssJs.height(`minContent);
  CssJs.unsafe({|height|}, {|fit-content(10%)|});
  CssJs.minHeight(`maxContent);
  CssJs.minHeight(`minContent);
  CssJs.unsafe({|minHeight|}, {|fit-content(10%)|});
  CssJs.maxHeight(`maxContent);
  CssJs.maxHeight(`minContent);
  CssJs.unsafe({|maxHeight|}, {|fit-content(10%)|});
  CssJs.unsafe({|aspectRatio|}, {|auto|});
  CssJs.unsafe({|aspectRatio|}, {|2|});
  CssJs.unsafe({|aspectRatio|}, {|16 / 9|});
  CssJs.unsafe({|width|}, {|fit-content|});
  CssJs.unsafe({|minWidth|}, {|fit-content|});
  CssJs.unsafe({|maxWidth|}, {|fit-content|});
  CssJs.unsafe({|height|}, {|fit-content|});
  CssJs.unsafe({|minHeight|}, {|fit-content|});
  CssJs.unsafe({|maxHeight|}, {|fit-content|});
