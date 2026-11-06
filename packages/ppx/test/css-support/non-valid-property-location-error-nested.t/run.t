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
  File "input.re", line 5, characters 12-15:
  5 |     colorx: red;
                  ^^^
  Error: Unknown property 'colorx'. Did you mean 'color'?
  [1]

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
        "_i7h4v2-Uj",
        [],
        1,
        0,
        0,
        [("id", "_i7h4v2-Uj", "bind\\0\\0Input\\0\\0selectors\\00")],
      ),
    ]
  ];
  let selectors = [%ocaml.error
    "Unknown property 'colorx'. Did you mean 'color'?"
  ];
