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
        "_agljYx8J2",
        ["._agljYx8J2{pointer-events:auto;}"],
        1,
        0,
        1,
        [("value", "jYx8J2", "val\\0gl\\0& | \\0pointer-events:auto")],
      ),
      (
        "_aglZnBGOM",
        ["._aglZnBGOM{pointer-events:visiblePainted;}"],
        1,
        0,
        1,
        [
          ("value", "ZnBGOM", "val\\0gl\\0& | \\0pointer-events:visiblePainted"),
        ],
      ),
      (
        "_agl7SbafR",
        ["._agl7SbafR{pointer-events:visibleFill;}"],
        1,
        0,
        1,
        [("value", "7SbafR", "val\\0gl\\0& | \\0pointer-events:visibleFill")],
      ),
      (
        "_agliaCAsY",
        ["._agliaCAsY{pointer-events:visibleStroke;}"],
        1,
        0,
        1,
        [
          ("value", "iaCAsY", "val\\0gl\\0& | \\0pointer-events:visibleStroke"),
        ],
      ),
      (
        "_agl2Y9PGN",
        ["._agl2Y9PGN{pointer-events:visible;}"],
        1,
        0,
        1,
        [("value", "2Y9PGN", "val\\0gl\\0& | \\0pointer-events:visible")],
      ),
      (
        "_aglqN0Aek",
        ["._aglqN0Aek{pointer-events:painted;}"],
        1,
        0,
        1,
        [("value", "qN0Aek", "val\\0gl\\0& | \\0pointer-events:painted")],
      ),
      (
        "_aglZy05ur",
        ["._aglZy05ur{pointer-events:fill;}"],
        1,
        0,
        1,
        [("value", "Zy05ur", "val\\0gl\\0& | \\0pointer-events:fill")],
      ),
      (
        "_aglM0o3Wn",
        ["._aglM0o3Wn{pointer-events:stroke;}"],
        1,
        0,
        1,
        [("value", "M0o3Wn", "val\\0gl\\0& | \\0pointer-events:stroke")],
      ),
      (
        "_agluyH9zv",
        ["._agluyH9zv{pointer-events:all;}"],
        1,
        0,
        1,
        [("value", "uyH9zv", "val\\0gl\\0& | \\0pointer-events:all")],
      ),
      (
        "_agl6mqgrC",
        ["._agl6mqgrC{pointer-events:none;}"],
        1,
        0,
        1,
        [("value", "6mqgrC", "val\\0gl\\0& | \\0pointer-events:none")],
      ),
    ]
  ];
  
  CSS.make("_agljYx8J2", []);
  
  CSS.make("_aglZnBGOM", []);
  CSS.make("_agl7SbafR", []);
  CSS.make("_agliaCAsY", []);
  CSS.make("_agl2Y9PGN", []);
  CSS.make("_aglqN0Aek", []);
  CSS.make("_aglZy05ur", []);
  CSS.make("_aglM0o3Wn", []);
  CSS.make("_agluyH9zv", []);
  CSS.make("_agl6mqgrC", []);
