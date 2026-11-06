This test ensures the ppx generates the correct output for CSS var() and cascading keywords
If this test fails, the var() and cascading support is broken

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
        "_a7fzO1Bb4",
        ["._a7fzO1Bb4{color:var(--primary-color);}"],
        1,
        0,
        1,
        [("value", "zO1Bb4", "val\\07f\\0& | \\0color:var(--primary-color)")],
      ),
      (
        "_a4l4bekiY",
        ["._a4l4bekiY{background-color:var(--bg-color);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "4bekiY",
            "val\\04l\\0& | \\0background-color:var(--bg-color)",
          ),
        ],
      ),
      (
        "_actgeIecN",
        ["._actgeIecN{margin:var(--spacing);}"],
        1,
        0,
        4,
        [("value", "geIecN", "val\\0ct\\0& | \\0margin:var(--spacing)")],
      ),
      (
        "_afyA82EpH",
        ["._afyA82EpH{padding:var(--padding);}"],
        1,
        0,
        4,
        [("value", "A82EpH", "val\\0fy\\0& | \\0padding:var(--padding)")],
      ),
      (
        "_aa8aXolUk",
        ["._aa8aXolUk{font-size:var(--font-size);}"],
        1,
        0,
        1,
        [("value", "aXolUk", "val\\0a8\\0& | \\0font-size:var(--font-size)")],
      ),
      (
        "_an8RDohya",
        ["._an8RDohya{width:var(--width);}"],
        1,
        0,
        1,
        [("value", "RDohya", "val\\0n8\\0& | \\0width:var(--width)")],
      ),
      (
        "_abdKiKKCE",
        ["._abdKiKKCE{height:var(--height);}"],
        1,
        0,
        1,
        [("value", "KiKKCE", "val\\0bd\\0& | \\0height:var(--height)")],
      ),
      (
        "_a7f5UFNY0",
        ["._a7f5UFNY0{color:inherit;}"],
        1,
        0,
        1,
        [("value", "5UFNY0", "val\\07f\\0& | \\0color:inherit")],
      ),
      (
        "_a7faCm-XM",
        ["._a7faCm-XM{color:initial;}"],
        1,
        0,
        1,
        [("value", "aCm-XM", "val\\07f\\0& | \\0color:initial")],
      ),
      (
        "_a7f1uACxj",
        ["._a7f1uACxj{color:unset;}"],
        1,
        0,
        1,
        [("value", "1uACxj", "val\\07f\\0& | \\0color:unset")],
      ),
      (
        "_a7f04Jt5g",
        ["._a7f04Jt5g{color:revert;}"],
        1,
        0,
        1,
        [("value", "04Jt5g", "val\\07f\\0& | \\0color:revert")],
      ),
      (
        "_a7fyzFDjE",
        ["._a7fyzFDjE{color:revert-layer;}"],
        1,
        0,
        1,
        [("value", "yzFDjE", "val\\07f\\0& | \\0color:revert-layer")],
      ),
      (
        "_a9f7dMj5f",
        ["._a9f7dMj5f{display:inherit;}"],
        1,
        0,
        1,
        [("value", "7dMj5f", "val\\09f\\0& | \\0display:inherit")],
      ),
      (
        "_a9fm08NVP",
        ["._a9fm08NVP{display:initial;}"],
        1,
        0,
        1,
        [("value", "m08NVP", "val\\09f\\0& | \\0display:initial")],
      ),
      (
        "_a9f1nv_eW",
        ["._a9f1nv_eW{display:unset;}"],
        1,
        0,
        1,
        [("value", "1nv_eW", "val\\09f\\0& | \\0display:unset")],
      ),
      (
        "_a9faixRkO",
        ["._a9faixRkO{display:revert;}"],
        1,
        0,
        1,
        [("value", "aixRkO", "val\\09f\\0& | \\0display:revert")],
      ),
      (
        "_a9fkUwvxl",
        ["._a9fkUwvxl{display:revert-layer;}"],
        1,
        0,
        1,
        [("value", "kUwvxl", "val\\09f\\0& | \\0display:revert-layer")],
      ),
      (
        "_actYXD8Mo",
        ["._actYXD8Mo{margin:inherit;}"],
        1,
        0,
        4,
        [("value", "YXD8Mo", "val\\0ct\\0& | \\0margin:inherit")],
      ),
      (
        "_actnBbid3",
        ["._actnBbid3{margin:initial;}"],
        1,
        0,
        4,
        [("value", "nBbid3", "val\\0ct\\0& | \\0margin:initial")],
      ),
      (
        "_actafbJU8",
        ["._actafbJU8{margin:unset;}"],
        1,
        0,
        4,
        [("value", "afbJU8", "val\\0ct\\0& | \\0margin:unset")],
      ),
      (
        "_actz4vMAH",
        ["._actz4vMAH{margin:revert;}"],
        1,
        0,
        4,
        [("value", "z4vMAH", "val\\0ct\\0& | \\0margin:revert")],
      ),
      (
        "_act0ZxVJM",
        ["._act0ZxVJM{margin:revert-layer;}"],
        1,
        0,
        4,
        [("value", "0ZxVJM", "val\\0ct\\0& | \\0margin:revert-layer")],
      ),
      (
        "_a9pOiDcNn",
        ["._a9pOiDcNn{-webkit-flex:inherit;-ms-flex:inherit;flex:inherit;}"],
        1,
        0,
        3,
        [("value", "OiDcNn", "val\\09p\\0& | \\0flex:inherit")],
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
        "_a9pqY2JuO",
        ["._a9pqY2JuO{-webkit-flex:unset;-ms-flex:unset;flex:unset;}"],
        1,
        0,
        3,
        [("value", "qY2JuO", "val\\09p\\0& | \\0flex:unset")],
      ),
      (
        "_a9pJrFhxT",
        ["._a9pJrFhxT{-webkit-flex:revert;-ms-flex:revert;flex:revert;}"],
        1,
        0,
        3,
        [("value", "JrFhxT", "val\\09p\\0& | \\0flex:revert")],
      ),
      (
        "_a9paJPe0O",
        [
          "._a9paJPe0O{-webkit-flex:revert-layer;-ms-flex:revert-layer;flex:revert-layer;}",
        ],
        1,
        0,
        3,
        [("value", "aJPe0O", "val\\09p\\0& | \\0flex:revert-layer")],
      ),
      (
        "_aa8NBULfQ",
        ["._aa8NBULfQ{font-size:inherit;}"],
        1,
        0,
        1,
        [("value", "NBULfQ", "val\\0a8\\0& | \\0font-size:inherit")],
      ),
      (
        "_aa8DISVd-",
        ["._aa8DISVd-{font-size:initial;}"],
        1,
        0,
        1,
        [("value", "DISVd-", "val\\0a8\\0& | \\0font-size:initial")],
      ),
      (
        "_aa8aWjXow",
        ["._aa8aWjXow{font-size:unset;}"],
        1,
        0,
        1,
        [("value", "aWjXow", "val\\0a8\\0& | \\0font-size:unset")],
      ),
      (
        "_aa8FBZ7N_",
        ["._aa8FBZ7N_{font-size:revert;}"],
        1,
        0,
        1,
        [("value", "FBZ7N_", "val\\0a8\\0& | \\0font-size:revert")],
      ),
      (
        "_aa8OU4kYC",
        ["._aa8OU4kYC{font-size:revert-layer;}"],
        1,
        0,
        1,
        [("value", "OU4kYC", "val\\0a8\\0& | \\0font-size:revert-layer")],
      ),
    ]
  ];
  
  CSS.make("_a7fzO1Bb4", []);
  CSS.make("_a4l4bekiY", []);
  CSS.make("_actgeIecN", []);
  CSS.make("_afyA82EpH", []);
  CSS.make("_aa8aXolUk", []);
  CSS.make("_an8RDohya", []);
  CSS.make("_abdKiKKCE", []);
  
  CSS.make("_a7f5UFNY0", []);
  CSS.make("_a7faCm-XM", []);
  CSS.make("_a7f1uACxj", []);
  CSS.make("_a7f04Jt5g", []);
  CSS.make("_a7fyzFDjE", []);
  
  CSS.make("_a9f7dMj5f", []);
  CSS.make("_a9fm08NVP", []);
  CSS.make("_a9f1nv_eW", []);
  CSS.make("_a9faixRkO", []);
  CSS.make("_a9fkUwvxl", []);
  
  CSS.make("_actYXD8Mo", []);
  CSS.make("_actnBbid3", []);
  CSS.make("_actafbJU8", []);
  CSS.make("_actz4vMAH", []);
  CSS.make("_act0ZxVJM", []);
  
  CSS.make("_a9pOiDcNn", []);
  CSS.make("_a9p_d4rOA", []);
  CSS.make("_a9pqY2JuO", []);
  CSS.make("_a9pJrFhxT", []);
  CSS.make("_a9paJPe0O", []);
  
  CSS.make("_aa8NBULfQ", []);
  CSS.make("_aa8DISVd-", []);
  CSS.make("_aa8aWjXow", []);
  CSS.make("_aa8FBZ7N_", []);
  CSS.make("_aa8OU4kYC", []);
