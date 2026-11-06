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
        "_an8VIV8gq",
        ["._an8VIV8gq{width:5rem;}"],
        1,
        0,
        1,
        [("value", "VIV8gq", "val\\0n8\\0& | \\0width:5rem")],
      ),
      (
        "_an8SzntbW",
        ["._an8SzntbW{width:5ch;}"],
        1,
        0,
        1,
        [("value", "SzntbW", "val\\0n8\\0& | \\0width:5ch")],
      ),
      (
        "_an8hM_yGW",
        ["._an8hM_yGW{width:5vw;}"],
        1,
        0,
        1,
        [("value", "hM_yGW", "val\\0n8\\0& | \\0width:5vw")],
      ),
      (
        "_an8WqtW52",
        ["._an8WqtW52{width:5vh;}"],
        1,
        0,
        1,
        [("value", "WqtW52", "val\\0n8\\0& | \\0width:5vh")],
      ),
      (
        "_an8qLa3AJ",
        ["._an8qLa3AJ{width:5vmin;}"],
        1,
        0,
        1,
        [("value", "qLa3AJ", "val\\0n8\\0& | \\0width:5vmin")],
      ),
      (
        "_an83P5juU",
        ["._an83P5juU{width:5vmax;}"],
        1,
        0,
        1,
        [("value", "3P5juU", "val\\0n8\\0& | \\0width:5vmax")],
      ),
      (
        "_an8LM6EH2",
        ["._an8LM6EH2{width:calc(1px + 2px);}"],
        1,
        0,
        1,
        [("value", "LM6EH2", "val\\0n8\\0& | \\0width:calc(1px + 2px)")],
      ),
      (
        "_an8GAQzPT",
        ["._an8GAQzPT{width:calc(5px * 2);}"],
        1,
        0,
        1,
        [("value", "GAQzPT", "val\\0n8\\0& | \\0width:calc(5px * 2)")],
      ),
      (
        "_an8ghu_St",
        ["._an8ghu_St{width:calc(5px - 10px);}"],
        1,
        0,
        1,
        [("value", "ghu_St", "val\\0n8\\0& | \\0width:calc(5px - 10px)")],
      ),
      (
        "_an8_PmfoV",
        ["._an8_PmfoV{width:calc(1vw - 1px);}"],
        1,
        0,
        1,
        [("value", "_PmfoV", "val\\0n8\\0& | \\0width:calc(1vw - 1px)")],
      ),
      (
        "_an8N6FnHa",
        ["._an8N6FnHa{width:100%;}"],
        1,
        0,
        1,
        [("value", "N6FnHa", "val\\0n8\\0& | \\0width:100%")],
      ),
      (
        "_afyKtM959",
        ["._afyKtM959{padding:5rem;}"],
        1,
        0,
        4,
        [("value", "KtM959", "val\\0fy\\0& | \\0padding:5rem")],
      ),
      (
        "_afy-wGVKH",
        ["._afy-wGVKH{padding:5ch;}"],
        1,
        0,
        4,
        [("value", "-wGVKH", "val\\0fy\\0& | \\0padding:5ch")],
      ),
      (
        "_afyGOvG6X",
        ["._afyGOvG6X{padding:5vw;}"],
        1,
        0,
        4,
        [("value", "GOvG6X", "val\\0fy\\0& | \\0padding:5vw")],
      ),
      (
        "_afyk0C9nc",
        ["._afyk0C9nc{padding:5vh;}"],
        1,
        0,
        4,
        [("value", "k0C9nc", "val\\0fy\\0& | \\0padding:5vh")],
      ),
      (
        "_afyrB19xV",
        ["._afyrB19xV{padding:5vmin;}"],
        1,
        0,
        4,
        [("value", "rB19xV", "val\\0fy\\0& | \\0padding:5vmin")],
      ),
      (
        "_afyZxGHTK",
        ["._afyZxGHTK{padding:5vmax;}"],
        1,
        0,
        4,
        [("value", "ZxGHTK", "val\\0fy\\0& | \\0padding:5vmax")],
      ),
    ]
  ];
  
  CSS.make("_an8VIV8gq", []);
  CSS.make("_an8SzntbW", []);
  CSS.make("_an8hM_yGW", []);
  CSS.make("_an8WqtW52", []);
  CSS.make("_an8qLa3AJ", []);
  CSS.make("_an83P5juU", []);
  CSS.make("_an8LM6EH2", []);
  CSS.make("_an8GAQzPT", []);
  CSS.make("_an8GAQzPT", []);
  CSS.make("_an8ghu_St", []);
  CSS.make("_an8_PmfoV", []);
  CSS.make("_an8N6FnHa", []);
  CSS.make("_afyKtM959", []);
  CSS.make("_afy-wGVKH", []);
  CSS.make("_afyGOvG6X", []);
  CSS.make("_afyk0C9nc", []);
  CSS.make("_afyrB19xV", []);
  CSS.make("_afyZxGHTK", []);

