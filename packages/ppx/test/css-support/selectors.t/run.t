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

  $ dune describe pp ./input.re
  [@ocaml.ppx.context
    {
      tool_name: "ppx_driver",
      include_dirs: [],
      hidden_include_dirs: [],
      load_path: ([], []),
      open_modules: [],
      for_package: None,
      debug: false,
      use_threads: false,
      use_vmthreads: false,
      recursive_types: false,
      principal: false,
      no_alias_deps: false,
      unboxed_types: false,
      unsafe_string: false,
      cookies: [],
    }
  ];
  [@css.atoms
    [
      (
        "_aml-wc9hs",
        [
          "._aml-wc9hs{-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;}",
        ],
        1,
        0,
        1,
        [("value", "-wc9hs", "val\\0ml\\0& | \\0user-select:none")],
      ),
      (
        "_bACkdE1296Tkd_fJZxm31p8J8",
        [
          "._bACkdE1296Tkd_fJZxm31p8J8 .recharts-cartesian-grid-horizontal line:nth-last-child(1){stroke-opacity:0;}",
          "._bACkdE1296Tkd_fJZxm31p8J8 .recharts-cartesian-grid-horizontal line:nth-last-child(2){stroke-opacity:0;}",
        ],
        0,
        1,
        2,
        [
          (
            "ctx",
            "E1296T",
            "ctx\\0& .recharts-cartesian-grid-horizontal line:nth-last-child(1) | ",
          ),
          (
            "ctx",
            "_fJZxm",
            "ctx\\0& .recharts-cartesian-grid-horizontal line:nth-last-child(2) | ",
          ),
          (
            "value",
            "31p8J8",
            "bval\\0& .recharts-cartesian-grid-horizontal line:nth-last-child(1) | \\0kd\\0stroke-opacity:0\\0& .recharts-cartesian-grid-horizontal line:nth-last-child(2) | \\0kd\\0stroke-opacity:0",
          ),
        ],
      ),
      (
        "_bACf9F5voZKf91Ql9bP94KE3W",
        [
          "._bACf9F5voZKf91Ql9bP94KE3W .recharts-scatter .recharts-scatter-symbol .recharts-symbols{opacity:0.8;}",
          "._bACf9F5voZKf91Ql9bP94KE3W .recharts-scatter .recharts-scatter-symbol .recharts-symbols:hover{opacity:1;}",
        ],
        0,
        1,
        2,
        [
          (
            "ctx",
            "F5voZK",
            "ctx\\0& .recharts-scatter .recharts-scatter-symbol .recharts-symbols | ",
          ),
          (
            "ctx",
            "1Ql9bP",
            "ctx\\0& .recharts-scatter .recharts-scatter-symbol .recharts-symbols:hover | ",
          ),
          (
            "value",
            "94KE3W",
            "bval\\0& .recharts-scatter .recharts-scatter-symbol .recharts-symbols | \\0f9\\0opacity:0.8\\0& .recharts-scatter .recharts-scatter-symbol .recharts-symbols:hover | \\0f9\\0opacity:1",
          ),
        ],
      ),
      (
        "_iLLZ4hOiX",
        [],
        1,
        0,
        0,
        [("id", "_iLLZ4hOiX", "bind\\0\\0Input\\0\\0_chart\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      (
        "Input._chart",
        "_iLLZ4hOiX _aml-wc9hs _bACkdE1296Tkd_fJZxm31p8J8 _bACf9F5voZKf91Ql9bP94KE3W",
        "_iLLZ4hOiX",
      ),
    ]
  ];
  
  let _chart =
    CSS.make(
      "_iLLZ4hOiX _aml-wc9hs _bACkdE1296Tkd_fJZxm31p8J8 _bACf9F5voZKf91Ql9bP94KE3W",
      [],
    );
