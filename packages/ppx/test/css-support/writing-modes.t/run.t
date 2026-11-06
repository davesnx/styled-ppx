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
        "_a9e-40DaP",
        ["._a9e-40DaP{direction:ltr;}"],
        1,
        0,
        1,
        [("value", "-40DaP", "val\\09e\\0& | \\0direction:ltr")],
      ),
      (
        "_a9eDYuH_P",
        ["._a9eDYuH_P{direction:rtl;}"],
        1,
        0,
        1,
        [("value", "DYuH_P", "val\\09e\\0& | \\0direction:rtl")],
      ),
      (
        "_amjrzlD-P",
        ["._amjrzlD-P{unicode-bidi:normal;}"],
        1,
        0,
        1,
        [("value", "rzlD-P", "val\\0mj\\0& | \\0unicode-bidi:normal")],
      ),
      (
        "_amjNIZduy",
        ["._amjNIZduy{unicode-bidi:embed;}"],
        1,
        0,
        1,
        [("value", "NIZduy", "val\\0mj\\0& | \\0unicode-bidi:embed")],
      ),
      (
        "_amjAQ1Qfm",
        ["._amjAQ1Qfm{unicode-bidi:isolate;}"],
        1,
        0,
        1,
        [("value", "AQ1Qfm", "val\\0mj\\0& | \\0unicode-bidi:isolate")],
      ),
      (
        "_amjZsRG6T",
        ["._amjZsRG6T{unicode-bidi:bidi-override;}"],
        1,
        0,
        1,
        [("value", "ZsRG6T", "val\\0mj\\0& | \\0unicode-bidi:bidi-override")],
      ),
      (
        "_amjhG1Hbr",
        ["._amjhG1Hbr{unicode-bidi:isolate-override;}"],
        1,
        0,
        1,
        [
          ("value", "hG1Hbr", "val\\0mj\\0& | \\0unicode-bidi:isolate-override"),
        ],
      ),
      (
        "_amj-uzcRA",
        ["._amj-uzcRA{unicode-bidi:plaintext;}"],
        1,
        0,
        1,
        [("value", "-uzcRA", "val\\0mj\\0& | \\0unicode-bidi:plaintext")],
      ),
      (
        "_and4Grt9s",
        [
          "._and4Grt9s{-webkit-writing-mode:horizontal-tb;-ms-writing-mode:horizontal-tb;writing-mode:horizontal-tb;}",
        ],
        1,
        0,
        1,
        [("value", "4Grt9s", "val\\0nd\\0& | \\0writing-mode:horizontal-tb")],
      ),
      (
        "_and21K_zn",
        [
          "._and21K_zn{-webkit-writing-mode:vertical-rl;-ms-writing-mode:vertical-rl;writing-mode:vertical-rl;}",
        ],
        1,
        0,
        1,
        [("value", "21K_zn", "val\\0nd\\0& | \\0writing-mode:vertical-rl")],
      ),
      (
        "_and51GHu6",
        [
          "._and51GHu6{-webkit-writing-mode:vertical-lr;-ms-writing-mode:vertical-lr;writing-mode:vertical-lr;}",
        ],
        1,
        0,
        1,
        [("value", "51GHu6", "val\\0nd\\0& | \\0writing-mode:vertical-lr")],
      ),
      (
        "_aliw8SJs7",
        ["._aliw8SJs7{text-orientation:mixed;}"],
        1,
        0,
        1,
        [("value", "w8SJs7", "val\\0li\\0& | \\0text-orientation:mixed")],
      ),
      (
        "_aliOt070E",
        ["._aliOt070E{text-orientation:upright;}"],
        1,
        0,
        1,
        [("value", "Ot070E", "val\\0li\\0& | \\0text-orientation:upright")],
      ),
      (
        "_ali2JjWFK",
        ["._ali2JjWFK{text-orientation:sideways;}"],
        1,
        0,
        1,
        [("value", "2JjWFK", "val\\0li\\0& | \\0text-orientation:sideways")],
      ),
      (
        "_akujZ5QJj",
        ["._akujZ5QJj{text-combine-upright:none;}"],
        1,
        0,
        1,
        [("value", "jZ5QJj", "val\\0ku\\0& | \\0text-combine-upright:none")],
      ),
      (
        "_akub0vQ0R",
        ["._akub0vQ0R{text-combine-upright:all;}"],
        1,
        0,
        1,
        [("value", "b0vQ0R", "val\\0ku\\0& | \\0text-combine-upright:all")],
      ),
      (
        "_andD9ge1a",
        [
          "._andD9ge1a{-webkit-writing-mode:sideways-rl;-ms-writing-mode:sideways-rl;writing-mode:sideways-rl;}",
        ],
        1,
        0,
        1,
        [("value", "D9ge1a", "val\\0nd\\0& | \\0writing-mode:sideways-rl")],
      ),
      (
        "_andKGV7xD",
        [
          "._andKGV7xD{-webkit-writing-mode:sideways-lr;-ms-writing-mode:sideways-lr;writing-mode:sideways-lr;}",
        ],
        1,
        0,
        1,
        [("value", "KGV7xD", "val\\0nd\\0& | \\0writing-mode:sideways-lr")],
      ),
      (
        "_akuY7rcut",
        ["._akuY7rcut{text-combine-upright:digits 2;}"],
        1,
        0,
        1,
        [
          ("value", "Y7rcut", "val\\0ku\\0& | \\0text-combine-upright:digits 2"),
        ],
      ),
    ]
  ];
  
  CSS.make("_a9e-40DaP", []);
  CSS.make("_a9eDYuH_P", []);
  CSS.make("_amjrzlD-P", []);
  CSS.make("_amjNIZduy", []);
  CSS.make("_amjAQ1Qfm", []);
  CSS.make("_amjZsRG6T", []);
  CSS.make("_amjhG1Hbr", []);
  CSS.make("_amj-uzcRA", []);
  CSS.make("_and4Grt9s", []);
  CSS.make("_and21K_zn", []);
  CSS.make("_and51GHu6", []);
  CSS.make("_aliw8SJs7", []);
  CSS.make("_aliOt070E", []);
  CSS.make("_ali2JjWFK", []);
  CSS.make("_akujZ5QJj", []);
  CSS.make("_akub0vQ0R", []);
  
  CSS.make("_andD9ge1a", []);
  CSS.make("_andKGV7xD", []);
  CSS.make("_akuY7rcut", []);
