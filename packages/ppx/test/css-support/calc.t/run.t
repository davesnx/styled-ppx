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
        "_an8DCSMSV",
        ["._an8DCSMSV{width:calc(50% + 4px);}"],
        1,
        0,
        1,
        [("value", "DCSMSV", "val\\0n8\\0& | \\0width:calc(50% + 4px)")],
      ),
      (
        "_an8S7W97K",
        ["._an8S7W97K{width:calc(20px - 10px);}"],
        1,
        0,
        1,
        [("value", "S7W97K", "val\\0n8\\0& | \\0width:calc(20px - 10px)")],
      ),
      (
        "_an8se1Q7V",
        ["._an8se1Q7V{width:calc(100vh - calc(2rem + 120px));}"],
        1,
        0,
        1,
        [
          (
            "value",
            "se1Q7V",
            "val\\0n8\\0& | \\0width:calc(100vh - calc(2rem + 120px))",
          ),
        ],
      ),
      (
        "_an8G7zUUK",
        ["._an8G7zUUK{width:calc(100vh * 2);}"],
        1,
        0,
        1,
        [("value", "G7zUUK", "val\\0n8\\0& | \\0width:calc(100vh * 2)")],
      ),
      (
        "_an8eayX0a",
        ["._an8eayX0a{width:calc(2 * 120px);}"],
        1,
        0,
        1,
        [("value", "eayX0a", "val\\0n8\\0& | \\0width:calc(2 * 120px)")],
      ),
    ]
  ];
  CSS.make("_an8DCSMSV", []);
  CSS.make("_an8S7W97K", []);
  CSS.make("_an8se1Q7V", []);
  CSS.make("_an8G7zUUK", []);
  CSS.make("_an8eayX0a", []);

  $ dune build
