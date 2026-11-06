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
        "_am5Fg8Aw_",
        ["._am5Fg8Aw_{touch-action:auto;}"],
        1,
        0,
        1,
        [("value", "Fg8Aw_", "val\\0m5\\0& | \\0touch-action:auto")],
      ),
      (
        "_am5K3jON5",
        ["._am5K3jON5{touch-action:none;}"],
        1,
        0,
        1,
        [("value", "K3jON5", "val\\0m5\\0& | \\0touch-action:none")],
      ),
      (
        "_am5pWEZtY",
        ["._am5pWEZtY{touch-action:pan-x;}"],
        1,
        0,
        1,
        [("value", "pWEZtY", "val\\0m5\\0& | \\0touch-action:pan-x")],
      ),
      (
        "_am5_-CsbI",
        ["._am5_-CsbI{touch-action:pan-y;}"],
        1,
        0,
        1,
        [("value", "_-CsbI", "val\\0m5\\0& | \\0touch-action:pan-y")],
      ),
      (
        "_am5vWL2hF",
        ["._am5vWL2hF{touch-action:pan-x pan-y;}"],
        1,
        0,
        1,
        [("value", "vWL2hF", "val\\0m5\\0& | \\0touch-action:pan-x pan-y")],
      ),
      (
        "_am5KcQaSc",
        ["._am5KcQaSc{touch-action:manipulation;}"],
        1,
        0,
        1,
        [("value", "KcQaSc", "val\\0m5\\0& | \\0touch-action:manipulation")],
      ),
      (
        "_am55B34I1",
        ["._am55B34I1{touch-action:pan-left;}"],
        1,
        0,
        1,
        [("value", "5B34I1", "val\\0m5\\0& | \\0touch-action:pan-left")],
      ),
      (
        "_am55q53mV",
        ["._am55q53mV{touch-action:pan-right;}"],
        1,
        0,
        1,
        [("value", "5q53mV", "val\\0m5\\0& | \\0touch-action:pan-right")],
      ),
      (
        "_am5nvhKGO",
        ["._am5nvhKGO{touch-action:pan-up;}"],
        1,
        0,
        1,
        [("value", "nvhKGO", "val\\0m5\\0& | \\0touch-action:pan-up")],
      ),
      (
        "_am5twU7Ja",
        ["._am5twU7Ja{touch-action:pan-down;}"],
        1,
        0,
        1,
        [("value", "twU7Ja", "val\\0m5\\0& | \\0touch-action:pan-down")],
      ),
      (
        "_am55Xj9hX",
        ["._am55Xj9hX{touch-action:pan-left pan-up;}"],
        1,
        0,
        1,
        [
          ("value", "5Xj9hX", "val\\0m5\\0& | \\0touch-action:pan-left pan-up"),
        ],
      ),
      (
        "_am58Q1oWN",
        ["._am58Q1oWN{touch-action:pinch-zoom;}"],
        1,
        0,
        1,
        [("value", "8Q1oWN", "val\\0m5\\0& | \\0touch-action:pinch-zoom")],
      ),
      (
        "_am5JJIFCl",
        ["._am5JJIFCl{touch-action:pan-x pinch-zoom;}"],
        1,
        0,
        1,
        [
          ("value", "JJIFCl", "val\\0m5\\0& | \\0touch-action:pan-x pinch-zoom"),
        ],
      ),
      (
        "_am5wKIJh5",
        ["._am5wKIJh5{touch-action:pan-y pinch-zoom;}"],
        1,
        0,
        1,
        [
          ("value", "wKIJh5", "val\\0m5\\0& | \\0touch-action:pan-y pinch-zoom"),
        ],
      ),
      (
        "_am5dGEVAD",
        ["._am5dGEVAD{touch-action:pan-x pan-y pinch-zoom;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "dGEVAD",
            "val\\0m5\\0& | \\0touch-action:pan-x pan-y pinch-zoom",
          ),
        ],
      ),
    ]
  ];
  
  CSS.make("_am5Fg8Aw_", []);
  CSS.make("_am5K3jON5", []);
  CSS.make("_am5pWEZtY", []);
  CSS.make("_am5_-CsbI", []);
  CSS.make("_am5vWL2hF", []);
  CSS.make("_am5KcQaSc", []);
  
  CSS.make("_am55B34I1", []);
  CSS.make("_am55q53mV", []);
  CSS.make("_am5nvhKGO", []);
  CSS.make("_am5twU7Ja", []);
  CSS.make("_am55Xj9hX", []);
  
  CSS.make("_am58Q1oWN", []);
  CSS.make("_am5JJIFCl", []);
  CSS.make("_am5wKIJh5", []);
  CSS.make("_am5dGEVAD", []);
