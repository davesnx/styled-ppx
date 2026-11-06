This test ensures autoprefixing happens in the PPX extraction path.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ cat > input.re << EOF
  > [%css {|text-size-adjust: none;|}];
  > [%css {|text-decoration: line-through;|}];
  > [%css {|display: grid;|}];
  > [%css {|animation-iteration-count: infinite;|}];
  > [%css {|backdrop-filter: blur(30px);|}];
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
        "_almZTCJCS",
        [
          "._almZTCJCS{-webkit-text-size-adjust:none;-moz-text-size-adjust:none;-ms-text-size-adjust:none;text-size-adjust:none;}",
        ],
        1,
        0,
        1,
        [("value", "ZTCJCS", "val\\0lm\\0& | \\0text-size-adjust:none")],
      ),
      (
        "_akvS6d85-",
        [
          "._akvS6d85-{-webkit-text-decoration:line-through;text-decoration:line-through;}",
        ],
        1,
        0,
        4,
        [
          ("value", "S6d85-", "val\\0kv\\0& | \\0text-decoration:line-through"),
        ],
      ),
      (
        "_a9fDR52Mo",
        ["._a9fDR52Mo{display:grid;}"],
        1,
        0,
        1,
        [("value", "DR52Mo", "val\\09f\\0& | \\0display:grid")],
      ),
      (
        "_a40zCX-K1",
        [
          "._a40zCX-K1{-webkit-animation-iteration-count:infinite;animation-iteration-count:infinite;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "zCX-K1",
            "val\\040\\0& | \\0animation-iteration-count:infinite",
          ),
        ],
      ),
      (
        "_a4f4flzHe",
        [
          "._a4f4flzHe{-webkit-backdrop-filter:blur(30px);backdrop-filter:blur(30px);}",
        ],
        1,
        0,
        1,
        [("value", "4flzHe", "val\\04f\\0& | \\0backdrop-filter:blur(30px)")],
      ),
    ]
  ];
  CSS.make("_almZTCJCS", []);
  CSS.make("_akvS6d85-", []);
  CSS.make("_a9fDR52Mo", []);
  CSS.make("_a40zCX-K1", []);
  CSS.make("_a4f4flzHe", []);
