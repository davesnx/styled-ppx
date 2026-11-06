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
        "_a9fqImtTK",
        ["._a9fqImtTK{display:ruby;}"],
        1,
        0,
        1,
        [("value", "qImtTK", "val\\09f\\0& | \\0display:ruby")],
      ),
      (
        "_a9fLxPZv0",
        ["._a9fLxPZv0{display:ruby-base;}"],
        1,
        0,
        1,
        [("value", "LxPZv0", "val\\09f\\0& | \\0display:ruby-base")],
      ),
      (
        "_a9fqq2v3c",
        ["._a9fqq2v3c{display:ruby-text;}"],
        1,
        0,
        1,
        [("value", "qq2v3c", "val\\09f\\0& | \\0display:ruby-text")],
      ),
      (
        "_a9frEu2Xx",
        ["._a9frEu2Xx{display:ruby-base-container;}"],
        1,
        0,
        1,
        [("value", "rEu2Xx", "val\\09f\\0& | \\0display:ruby-base-container")],
      ),
      (
        "_a9fSm0AXB",
        ["._a9fSm0AXB{display:ruby-text-container;}"],
        1,
        0,
        1,
        [("value", "Sm0AXB", "val\\09f\\0& | \\0display:ruby-text-container")],
      ),
    ]
  ];
  
  CSS.make("_a9fqImtTK", []);
  CSS.make("_a9fLxPZv0", []);
  CSS.make("_a9fqq2v3c", []);
  CSS.make("_a9frEu2Xx", []);
  CSS.make("_a9fSm0AXB", []);
