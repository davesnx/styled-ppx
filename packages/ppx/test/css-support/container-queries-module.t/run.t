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
        "_a8hJZUnuH",
        ["._a8hJZUnuH{container-type:normal;}"],
        1,
        0,
        1,
        [("value", "JZUnuH", "val\\08h\\0& | \\0container-type:normal")],
      ),
      (
        "_a8hMPATp7",
        ["._a8hMPATp7{container-type:size;}"],
        1,
        0,
        1,
        [("value", "MPATp7", "val\\08h\\0& | \\0container-type:size")],
      ),
      (
        "_a8hicGmkO",
        ["._a8hicGmkO{container-type:inline-size;}"],
        1,
        0,
        1,
        [("value", "icGmkO", "val\\08h\\0& | \\0container-type:inline-size")],
      ),
      (
        "_a8fq-qsK3",
        ["._a8fq-qsK3{container-name:none;}"],
        1,
        0,
        1,
        [("value", "q-qsK3", "val\\08f\\0& | \\0container-name:none")],
      ),
      (
        "_a8fakdzPY",
        ["._a8fakdzPY{container-name:sidebar;}"],
        1,
        0,
        1,
        [("value", "akdzPY", "val\\08f\\0& | \\0container-name:sidebar")],
      ),
      (
        "_a8f36wTOr",
        ["._a8f36wTOr{container-name:sidebar main;}"],
        1,
        0,
        1,
        [("value", "36wTOr", "val\\08f\\0& | \\0container-name:sidebar main")],
      ),
      (
        "_a8egKSaBY",
        ["._a8egKSaBY{container:sidebar / inline-size;}"],
        1,
        0,
        2,
        [
          (
            "value",
            "gKSaBY",
            "val\\08e\\0& | \\0container:sidebar / inline-size",
          ),
        ],
      ),
      (
        "_a8ehiO2rC",
        ["._a8ehiO2rC{container:sidebar / size;}"],
        1,
        0,
        2,
        [("value", "hiO2rC", "val\\08e\\0& | \\0container:sidebar / size")],
      ),
      (
        "_a8e_MwVhz",
        ["._a8e_MwVhz{container:none;}"],
        1,
        0,
        2,
        [("value", "_MwVhz", "val\\08e\\0& | \\0container:none")],
      ),
    ]
  ];
  
  CSS.make("_a8hJZUnuH", []);
  CSS.make("_a8hMPATp7", []);
  CSS.make("_a8hicGmkO", []);
  CSS.make("_a8fq-qsK3", []);
  CSS.make("_a8fakdzPY", []);
  CSS.make("_a8f36wTOr", []);
  CSS.make("_a8egKSaBY", []);
  CSS.make("_a8ehiO2rC", []);
  CSS.make("_a8e_MwVhz", []);
