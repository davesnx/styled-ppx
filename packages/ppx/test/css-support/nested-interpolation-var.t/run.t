Regression test: a runtime interpolation `$(x)` used inside a nested
pseudo-element selector (`&::placeholder`) must still emit the inline
`--var-...` definition (the 2nd argument of `CSS.make`), exactly like a
top-level interpolation does. If the inline list is empty `[]` for the
`::placeholder` case while the extracted `[@css ...]` payload references
`var(--var-...)`, the variable is undefined at runtime and the value falls back.

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
  [@css "@property --c-88x3i5{syntax:\"*\";inherits:false;}"];
  [@css "@property --c-ethmpb{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_a7fPvdZiG",
        ["._a7fPvdZiG{color:var(--c-88x3i5);}"],
        1,
        0,
        1,
        [("value", "PvdZiG", "val\\07f\\0& | \\0color:$(c)")],
      ),
      (
        "_c7f1Tl5-w1etZ_n",
        ["._c7f1Tl5-w1etZ_n:hover{color:var(--c-ethmpb);}"],
        2,
        1,
        1,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          ("value", "1etZ_n", "val\\07f\\0&:hover | \\0color:$(c)"),
        ],
      ),
      (
        "_c7fDXixWYKN11ya",
        ["._c7fDXixWYKN11ya::placeholder{color:var(--c-pe4j6c);}"],
        2,
        1,
        1,
        [
          ("ctx", "DXixWY", "ctx\\0&::placeholder | "),
          ("value", "KN11ya", "val\\07f\\0&::placeholder | \\0color:$(c)"),
        ],
      ),
      (
        "_iLmDm0ZqY",
        [],
        1,
        0,
        0,
        [("id", "_iLmDm0ZqY", "bind\\0\\0Input\\0\\0topLevel\\00")],
      ),
      (
        "_i-gYBYMwr",
        [],
        1,
        0,
        0,
        [("id", "_i-gYBYMwr", "bind\\0\\0Input\\0\\0hover\\00")],
      ),
      (
        "_iBy8fNT17",
        [],
        1,
        0,
        0,
        [("id", "_iBy8fNT17", "bind\\0\\0Input\\0\\0placeholder\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.topLevel", "_iLmDm0ZqY _a7fPvdZiG", "_iLmDm0ZqY"),
      ("Input.hover", "_i-gYBYMwr _c7f1Tl5-w1etZ_n", "_i-gYBYMwr"),
      ("Input.placeholder", "_iBy8fNT17 _c7fDXixWYKN11ya", "_iBy8fNT17"),
    ]
  ];
  
  let c = CSS.hex("ff0000");
  
  let topLevel =
    CSS.make(
      "_iLmDm0ZqY _a7fPvdZiG",
      [("--c-88x3i5", CSS.Types.Color.toString(c))],
    );
  
  let hover =
    CSS.make(
      "_i-gYBYMwr _c7f1Tl5-w1etZ_n",
      [("--c-ethmpb", CSS.Types.Color.toString(c))],
    );
  
  let placeholder =
    CSS.make(
      "_iBy8fNT17 _c7fDXixWYKN11ya",
      [("--c-pe4j6c", CSS.Types.Color.toString(c))],
    );
  
  let _ = (topLevel, hover, placeholder);
