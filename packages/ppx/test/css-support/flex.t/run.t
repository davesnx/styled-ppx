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
        "_a9pfNC1F7",
        ["._a9pfNC1F7{-webkit-flex:auto;-ms-flex:auto;flex:auto;}"],
        1,
        0,
        3,
        [("value", "fNC1F7", "val\\09p\\0& | \\0flex:auto")],
      ),
      (
        "_a9p_d4rOA",
        ["._a9p_d4rOA{-webkit-flex:initial;-ms-flex:initial;flex:initial;}"],
        1,
        0,
        3,
        [("value", "_d4rOA", "val\\09p\\0& | \\0flex:initial")],
      ),
      (
        "_a9pp8sQyy",
        ["._a9pp8sQyy{-webkit-flex:none;-ms-flex:none;flex:none;}"],
        1,
        0,
        3,
        [("value", "p8sQyy", "val\\09p\\0& | \\0flex:none")],
      ),
      (
        "_a9pG_MAfB",
        ["._a9pG_MAfB{-webkit-flex:2;-ms-flex:2;flex:2;}"],
        1,
        0,
        3,
        [("value", "G_MAfB", "val\\09p\\0& | \\0flex:2")],
      ),
      (
        "_a9pOWqbr3",
        ["._a9pOWqbr3{-webkit-flex:10em;-ms-flex:10em;flex:10em;}"],
        1,
        0,
        3,
        [("value", "OWqbr3", "val\\09p\\0& | \\0flex:10em")],
      ),
      (
        "_a9paZ3zof",
        ["._a9paZ3zof{-webkit-flex:30%;-ms-flex:30%;flex:30%;}"],
        1,
        0,
        3,
        [("value", "aZ3zof", "val\\09p\\0& | \\0flex:30%")],
      ),
      (
        "_a9polWM0f",
        [
          "._a9polWM0f{-webkit-flex:min-content;-ms-flex:min-content;flex:min-content;}",
        ],
        1,
        0,
        3,
        [("value", "olWM0f", "val\\09p\\0& | \\0flex:min-content")],
      ),
      (
        "_a9pIk7v_L",
        ["._a9pIk7v_L{-webkit-flex:1 30px;-ms-flex:1 30px;flex:1 30px;}"],
        1,
        0,
        3,
        [("value", "Ik7v_L", "val\\09p\\0& | \\0flex:1 30px")],
      ),
      (
        "_a9pfksF8K",
        ["._a9pfksF8K{-webkit-flex:2 2;-ms-flex:2 2;flex:2 2;}"],
        1,
        0,
        3,
        [("value", "fksF8K", "val\\09p\\0& | \\0flex:2 2")],
      ),
      (
        "_a9pEffCjo",
        ["._a9pEffCjo{-webkit-flex:2 2 10%;-ms-flex:2 2 10%;flex:2 2 10%;}"],
        1,
        0,
        3,
        [("value", "EffCjo", "val\\09p\\0& | \\0flex:2 2 10%")],
      ),
      (
        "_a9pbUXdEC",
        ["._a9pbUXdEC{-webkit-flex:2 2 10em;-ms-flex:2 2 10em;flex:2 2 10em;}"],
        1,
        0,
        3,
        [("value", "bUXdEC", "val\\09p\\0& | \\0flex:2 2 10em")],
      ),
      (
        "_a9p9-9BZv",
        [
          "._a9p9-9BZv{-webkit-flex:2 2 min-content;-ms-flex:2 2 min-content;flex:2 2 min-content;}",
        ],
        1,
        0,
        3,
        [("value", "9-9BZv", "val\\09p\\0& | \\0flex:2 2 min-content")],
      ),
    ]
  ];
  
  CSS.make("_a9pfNC1F7", []);
  CSS.make("_a9p_d4rOA", []);
  CSS.make("_a9pp8sQyy", []);
  
  CSS.make("_a9pG_MAfB", []);
  
  CSS.make("_a9pOWqbr3", []);
  CSS.make("_a9paZ3zof", []);
  CSS.make("_a9polWM0f", []);
  
  CSS.make("_a9pIk7v_L", []);
  
  CSS.make("_a9pfksF8K", []);
  
  CSS.make("_a9pEffCjo", []);
  CSS.make("_a9pbUXdEC", []);
  CSS.make("_a9p9-9BZv", []);
