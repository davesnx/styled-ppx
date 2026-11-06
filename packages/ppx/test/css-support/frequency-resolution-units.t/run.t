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
        "_ablemaR7h",
        ["._ablemaR7h{image-rendering:auto;}"],
        1,
        0,
        1,
        [("value", "emaR7h", "val\\0bl\\0& | \\0image-rendering:auto")],
      ),
      (
        "_ably8MMkG",
        ["._ably8MMkG{image-rendering:crisp-edges;}"],
        1,
        0,
        1,
        [("value", "y8MMkG", "val\\0bl\\0& | \\0image-rendering:crisp-edges")],
      ),
      (
        "_ablC-eDY6",
        ["._ablC-eDY6{image-rendering:pixelated;}"],
        1,
        0,
        1,
        [("value", "C-eDY6", "val\\0bl\\0& | \\0image-rendering:pixelated")],
      ),
      (
        "_a4mwHLjUw",
        [
          "._a4mwHLjUw{background-image:image-set(\"cat.png\" 1x, \"cat-2x.png\" 2x);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "wHLjUw",
            "val\\04m\\0& | \\0background-image:image-set(\"cat.png\" 1x, \"cat-2x.png\" 2x)",
          ),
        ],
      ),
      (
        "_a4mbgDFSr",
        [
          "._a4mbgDFSr{background-image:image-set(\"cat.png\" 1dppx, \"cat-2x.png\" 2dppx);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "bgDFSr",
            "val\\04m\\0& | \\0background-image:image-set(\"cat.png\" 1dppx, \"cat-2x.png\" 2dppx)",
          ),
        ],
      ),
      (
        "_a4m5vCQMN",
        [
          "._a4m5vCQMN{background-image:image-set(\"cat.png\" 96dpi, \"cat-2x.png\" 192dpi);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "5vCQMN",
            "val\\04m\\0& | \\0background-image:image-set(\"cat.png\" 96dpi, \"cat-2x.png\" 192dpi)",
          ),
        ],
      ),
      (
        "_a4mjDTHxL",
        ["._a4mjDTHxL{background-image:image-set(\"cat.png\" 37dpcm);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "jDTHxL",
            "val\\04m\\0& | \\0background-image:image-set(\"cat.png\" 37dpcm)",
          ),
        ],
      ),
    ]
  ];
  
  CSS.make("_ablemaR7h", []);
  CSS.make("_ably8MMkG", []);
  CSS.make("_ablC-eDY6", []);
  
  CSS.make("_a4mwHLjUw", []);
  CSS.make("_a4mbgDFSr", []);
  CSS.make("_a4m5vCQMN", []);
  CSS.make("_a4mjDTHxL", []);
