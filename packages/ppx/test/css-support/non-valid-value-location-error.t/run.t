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
  >  (preprocess (pps styled-ppx.lib)))
  > EOF

  $ dune build
  File "input.re", lines 9-10, characters 17-20:
   8 | ..
   9 | ..............;
  10 |   display: blocki.
  Error: Property 'display' has an invalid value: 'blocki'
  [1]

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
  Js.log("2000");
  CssJs.style([|
    CssJs.height(`percent(100.)),
    CssJs.height(`percent(100.)),
    CssJs.height(`percent(100.)),
    CssJs.height(`percent(100.)),
    CssJs.height(`percent(100.)),
    [%ocaml.error "Property 'display' has an invalid value: 'blocki'"],
  |]);
