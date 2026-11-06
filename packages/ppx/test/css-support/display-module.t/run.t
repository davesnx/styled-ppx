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
        "_a9fXTSzld",
        ["._a9fXTSzld{display:run-in;}"],
        1,
        0,
        1,
        [("value", "XTSzld", "val\\09f\\0& | \\0display:run-in")],
      ),
      (
        "_a9fDK0rS_",
        ["._a9fDK0rS_{display:flow;}"],
        1,
        0,
        1,
        [("value", "DK0rS_", "val\\09f\\0& | \\0display:flow")],
      ),
      (
        "_a9fN33yZ8",
        ["._a9fN33yZ8{display:flow-root;}"],
        1,
        0,
        1,
        [("value", "N33yZ8", "val\\09f\\0& | \\0display:flow-root")],
      ),
    ]
  ];
  
  CSS.make("_a9fXTSzld", []);
  CSS.make("_a9fDK0rS_", []);
  CSS.make("_a9fN33yZ8", []);
