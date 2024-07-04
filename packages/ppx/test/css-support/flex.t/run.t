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
  CssJs.flexBasis(`auto);
  CssJs.unsafe({js|flex|js}, {js|initial|js});
  CssJs.flex1(`none);
  CssJs.flex1(`num(2.));
  CssJs.flexBasis(`em(10.));
  CssJs.flexBasis(`percent(30.));
  CssJs.flexBasis(`minContent);
  CssJs.flex2(~basis=`pxFloat(30.), 1.);
  CssJs.flex2(~shrink=2., 2.);
  CssJs.flex(2., 2., `percent(10.));
  CssJs.flex(2., 2., `em(10.));
  CssJs.flex(2., 2., `minContent);
