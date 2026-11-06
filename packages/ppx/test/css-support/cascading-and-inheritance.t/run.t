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
        "_a7f1uACxj",
        ["._a7f1uACxj{color:unset;}"],
        1,
        0,
        1,
        [("value", "1uACxj", "val\\07f\\0& | \\0color:unset")],
      ),
      (
        "_aarAJVKRb",
        ["._aarAJVKRb{font-weight:unset;}"],
        1,
        0,
        1,
        [("value", "AJVKRb", "val\\0ar\\0& | \\0font-weight:unset")],
      ),
      (
        "_a4mK43YTa",
        ["._a4mK43YTa{background-image:unset;}"],
        1,
        0,
        1,
        [("value", "K43YTa", "val\\04m\\0& | \\0background-image:unset")],
      ),
      (
        "_an8bLfdcd",
        ["._an8bLfdcd{width:unset;}"],
        1,
        0,
        1,
        [("value", "bLfdcd", "val\\0n8\\0& | \\0width:unset")],
      ),
    ]
  ];
  
  CSS.make("_a7f1uACxj", []);
  CSS.make("_aarAJVKRb", []);
  CSS.make("_a4mK43YTa", []);
  CSS.make("_an8bLfdcd", []);
