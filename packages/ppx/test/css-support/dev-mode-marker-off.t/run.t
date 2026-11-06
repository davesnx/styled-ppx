Without --dev, [%css] output is identical to before: no marker class
prepended to the className. Same input as dev-mode-marker.t but with
the flag omitted, locking in that the marker is purely opt-in.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

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
        "_a9fMU0SCS",
        ["._a9fMU0SCS{display:flex;}"],
        1,
        0,
        1,
        [("value", "MU0SCS", "val\\09f\\0& | \\0display:flex")],
      ),
      (
        "_afyDerD9l",
        ["._afyDerD9l{padding:12px;}"],
        1,
        0,
        4,
        [("value", "DerD9l", "val\\0fy\\0& | \\0padding:12px")],
      ),
      (
        "_a7fadbhEW",
        ["._a7fadbhEW{color:red;}"],
        1,
        0,
        1,
        [("value", "adbhEW", "val\\07f\\0& | \\0color:red")],
      ),
      (
        "_iQ7dl8ohV",
        [],
        1,
        0,
        0,
        [("id", "_iQ7dl8ohV", "bind\\0\\0Input\\0\\0layout\\00")],
      ),
      (
        "_iPt09eXEw",
        [],
        1,
        0,
        0,
        [("id", "_iPt09eXEw", "bind\\0\\0Input\\0\\0button\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.layout", "_iQ7dl8ohV _a9fMU0SCS _afyDerD9l", "_iQ7dl8ohV"),
      ("Input.button", "_iPt09eXEw _a7fadbhEW", "_iPt09eXEw"),
    ]
  ];
  
  let layout = CSS.make("_iQ7dl8ohV _a9fMU0SCS _afyDerD9l", []);
  
  let button = CSS.make("_iPt09eXEw _a7fadbhEW", []);
  
  let _ = (layout, button);

  $ dune build
