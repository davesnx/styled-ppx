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
  CSS.unsafe({js|lineClamp|js}, {js|none|js});
  CSS.unsafe({js|lineClamp|js}, {js|1|js});
  CSS.unsafe({js|maxLines|js}, {js|none|js});
  CSS.unsafe({js|maxLines|js}, {js|1|js});
  CSS.overflowX(`visible);
  CSS.overflowX(`hidden);
  CSS.overflowX(`clip);
  CSS.overflowX(`scroll);
  CSS.overflowX(`auto);
  CSS.overflowY(`visible);
  CSS.overflowY(`hidden);
  CSS.overflowY(`clip);
  CSS.overflowY(`scroll);
  CSS.overflowY(`auto);
  CSS.overflowInline(`visible);
  CSS.overflowInline(`hidden);
  CSS.overflowInline(`clip);
  CSS.overflowInline(`scroll);
  CSS.overflowInline(`auto);
  CSS.overflowBlock(`visible);
  CSS.overflowBlock(`hidden);
  CSS.overflowBlock(`clip);
  CSS.overflowBlock(`scroll);
  CSS.overflowBlock(`auto);
