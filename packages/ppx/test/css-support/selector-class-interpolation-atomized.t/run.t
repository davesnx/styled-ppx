A multi-declaration source binding resolves to its binding id when referenced
by another [%css]'s selector.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune describe pp ./input.re | sed '1,/^];$/d'
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
        "_aaumHZXLp",
        ["._aaumHZXLp{gap:1rem;}"],
        1,
        0,
        2,
        [("value", "mHZXLp", "val\\0au\\0& | \\0gap:1rem")],
      ),
      (
        "_c7frTv2_xqTOfbE",
        ["._c7frTv2_xqTOfbE._iRpr2c5lh{color:red;}"],
        2,
        1,
        1,
        [
          ("ctx", "rTv2_x", "ctx\\0&._iRpr2c5lh | "),
          ("value", "qTOfbE", "val\\07f\\0&._iRpr2c5lh | \\0color:red"),
        ],
      ),
      (
        "_iRpr2c5lh",
        [],
        1,
        0,
        0,
        [("id", "_iRpr2c5lh", "bind\\0\\0Input\\0\\0composed\\00")],
      ),
      (
        "_ifEzboNTs",
        [],
        1,
        0,
        0,
        [("id", "_ifEzboNTs", "bind\\0\\0Input\\0\\0user\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.composed", "_iRpr2c5lh _a9fMU0SCS _aaumHZXLp", "_iRpr2c5lh"),
      ("Input.user", "_ifEzboNTs _c7frTv2_xqTOfbE", "_ifEzboNTs"),
    ]
  ];
  
  let composed = CSS.make("_iRpr2c5lh _a9fMU0SCS _aaumHZXLp", []);
  
  let user = CSS.make("_ifEzboNTs _c7frTv2_xqTOfbE", []);
  
  let _ = (composed, user);

  $ dune build
