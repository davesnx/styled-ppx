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
        "_an9J7dEJb",
        ["._an9J7dEJb{will-change:scroll-position;}"],
        1,
        0,
        1,
        [("value", "J7dEJb", "val\\0n9\\0& | \\0will-change:scroll-position")],
      ),
      (
        "_an9gHJMTi",
        ["._an9gHJMTi{will-change:contents;}"],
        1,
        0,
        1,
        [("value", "gHJMTi", "val\\0n9\\0& | \\0will-change:contents")],
      ),
      (
        "_an9pRhrlb",
        ["._an9pRhrlb{will-change:transform;}"],
        1,
        0,
        1,
        [("value", "pRhrlb", "val\\0n9\\0& | \\0will-change:transform")],
      ),
      (
        "_an9ezY99o",
        ["._an9ezY99o{will-change:top, left;}"],
        1,
        0,
        1,
        [("value", "ezY99o", "val\\0n9\\0& | \\0will-change:top, left")],
      ),
    ]
  ];
  
  CSS.make("_an9J7dEJb", []);
  CSS.make("_an9gHJMTi", []);
  CSS.make("_an9pRhrlb", []);
  CSS.make("_an9ezY99o", []);
