Shadowing follows OCaml semantics: `&.$(foo)` resolves to the second
`let foo` binding (the one visible at the reference site).

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
        "_a7fadbhEW",
        ["._a7fadbhEW{color:red;}"],
        1,
        0,
        1,
        [("value", "adbhEW", "val\\07f\\0& | \\0color:red")],
      ),
      (
        "_a7fCPHFf-",
        ["._a7fCPHFf-{color:blue;}"],
        1,
        0,
        1,
        [("value", "CPHFf-", "val\\07f\\0& | \\0color:blue")],
      ),
      (
        "_cark8WBZ20L7eVq",
        ["._cark8WBZ20L7eVq._ih7MsK5eg{font-weight:bold;}"],
        2,
        1,
        1,
        [
          ("ctx", "k8WBZ2", "ctx\\0&._ih7MsK5eg | "),
          ("value", "0L7eVq", "val\\0ar\\0&._ih7MsK5eg | \\0font-weight:bold"),
        ],
      ),
      (
        "_iBZ5mNPO7",
        [],
        1,
        0,
        0,
        [("id", "_iBZ5mNPO7", "bind\\0\\0Input\\0\\0foo\\00")],
      ),
      (
        "_ih7MsK5eg",
        [],
        1,
        0,
        0,
        [("id", "_ih7MsK5eg", "bind\\0\\0Input\\0\\0foo\\01")],
      ),
      (
        "_iBEU_scOh",
        [],
        1,
        0,
        0,
        [("id", "_iBEU_scOh", "bind\\0\\0Input\\0\\0bar\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.foo", "_ih7MsK5eg _a7fCPHFf-", "_ih7MsK5eg"),
      ("Input.bar", "_iBEU_scOh _cark8WBZ20L7eVq", "_iBEU_scOh"),
    ]
  ];
  
  let foo = CSS.make("_iBZ5mNPO7 _a7fadbhEW", []);
  let _ = foo;
  
  let foo = CSS.make("_ih7MsK5eg _a7fCPHFf-", []);
  
  let bar = CSS.make("_iBEU_scOh _cark8WBZ20L7eVq", []);
  
  let _ = (foo, bar);

  $ dune build
