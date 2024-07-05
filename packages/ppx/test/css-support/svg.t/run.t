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
  CssJs.pointerEvents(`auto);
  CssJs.pointerEvents(`visiblePainted);
  CssJs.pointerEvents(`visibleFill);
  CssJs.pointerEvents(`visibleStroke);
  CssJs.pointerEvents(`visible);
  CssJs.pointerEvents(`painted);
  CssJs.pointerEvents(`fill);
  CssJs.pointerEvents(`stroke);
  CssJs.pointerEvents(`all);
  CssJs.pointerEvents(`none);
