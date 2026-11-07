Shape 9: an interpolating declaration is an atom of its own. Each atom owns its custom property: the same value in two contexts is two variables.

  $ refmt --parse re --print ml input.re > input.ml

Development:

  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  $ refmt --parse ml --print re dev.ml
  [@css "@property --color-1raopcx{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-1n2ktc0{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-qvekgg{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_a7fQE1m9v",
        ["._a7fQE1m9v{color:var(--color-1raopcx);}"],
        1,
        0,
        1,
        [("value", "QE1m9v", "val\\07f\\0& | \\0color:$(color)")],
      ),
      (
        "_afyQPFuDn",
        ["._afyQPFuDn{padding:var(--width-1n2ktc0);}"],
        1,
        0,
        4,
        [("value", "QPFuDn", "val\\0fy\\0& | \\0padding:$(width)")],
      ),
      (
        "_bAC7f1Tl5-w7fHwfC2rjsxQ9O",
        [
          "._bAC7f1Tl5-w7fHwfC2rjsxQ9O:hover{color:var(--color-qvekgg);}",
          "@media (max-width:768px){._bAC7f1Tl5-w7fHwfC2rjsxQ9O{color:var(--color-qvekgg);}}",
        ],
        2,
        1,
        2,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          ("ctx", "HwfC2r", "ctx\\0& | @media (max-width:768px) | "),
          (
            "value",
            "jsxQ9O",
            "bval\\0&:hover | \\07f\\0color:$(color)\\0& | @media (max-width:768px) | \\07f\\0color:$(color)",
          ),
        ],
      ),
      (
        "_a9fMU0SCS",
        ["._a9fMU0SCS{display:flex;}"],
        1,
        0,
        1,
        [("value", "MU0SCS", "val\\09f\\0& | \\0display:flex")],
      ),
      (
        "_iIxGXPL5_",
        [],
        1,
        0,
        0,
        [("id", "_iIxGXPL5_", "bind\\0\\0Input\\0\\0both\\00")],
      ),
      (
        "_ig3UcJKch",
        [],
        1,
        0,
        0,
        [("id", "_ig3UcJKch", "bind\\0\\0Input\\0\\0mixed\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      (
        "Input.both",
        "_iIxGXPL5_ _a7fQE1m9v _afyQPFuDn _bAC7f1Tl5-w7fHwfC2rjsxQ9O",
        "_iIxGXPL5_",
      ),
      ("Input.mixed", "_ig3UcJKch _a9fMU0SCS _a7fQE1m9v", "_ig3UcJKch"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let width = CSS.px(10);
  let both =
    CSS.make(
      "cx-both _iIxGXPL5_ _a7fQE1m9v _afyQPFuDn _bAC7f1Tl5-w7fHwfC2rjsxQ9O",
      [
        ("--color-1raopcx", CSS.Types.Color.toString(color)),
        ("--width-1n2ktc0", CSS.Types.Padding.toString(width)),
        ("--color-qvekgg", CSS.Types.Color.toString(color)),
      ],
    );
  let mixed =
    CSS.make(
      "cx-mixed _ig3UcJKch _a9fMU0SCS _a7fQE1m9v",
      [("--color-1raopcx", CSS.Types.Color.toString(color))],
    );

Production:

  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css "@property --color-1raopcx{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-1n2ktc0{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-qvekgg{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_a7fQE1m9v",
        ["._a7fQE1m9v{color:var(--color-1raopcx);}"],
        1,
        0,
        1,
        [("value", "QE1m9v", "val\\07f\\0& | \\0color:$(color)")],
      ),
      (
        "_afyQPFuDn",
        ["._afyQPFuDn{padding:var(--width-1n2ktc0);}"],
        1,
        0,
        4,
        [("value", "QPFuDn", "val\\0fy\\0& | \\0padding:$(width)")],
      ),
      (
        "_bAC7f1Tl5-w7fHwfC2rjsxQ9O",
        [
          "._bAC7f1Tl5-w7fHwfC2rjsxQ9O:hover{color:var(--color-qvekgg);}",
          "@media (max-width:768px){._bAC7f1Tl5-w7fHwfC2rjsxQ9O{color:var(--color-qvekgg);}}",
        ],
        2,
        1,
        2,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          ("ctx", "HwfC2r", "ctx\\0& | @media (max-width:768px) | "),
          (
            "value",
            "jsxQ9O",
            "bval\\0&:hover | \\07f\\0color:$(color)\\0& | @media (max-width:768px) | \\07f\\0color:$(color)",
          ),
        ],
      ),
      (
        "_a9fMU0SCS",
        ["._a9fMU0SCS{display:flex;}"],
        1,
        0,
        1,
        [("value", "MU0SCS", "val\\09f\\0& | \\0display:flex")],
      ),
      (
        "_iIxGXPL5_",
        [],
        1,
        0,
        0,
        [("id", "_iIxGXPL5_", "bind\\0\\0Input\\0\\0both\\00")],
      ),
      (
        "_ig3UcJKch",
        [],
        1,
        0,
        0,
        [("id", "_ig3UcJKch", "bind\\0\\0Input\\0\\0mixed\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      (
        "Input.both",
        "_iIxGXPL5_ _a7fQE1m9v _afyQPFuDn _bAC7f1Tl5-w7fHwfC2rjsxQ9O",
        "_iIxGXPL5_",
      ),
      ("Input.mixed", "_ig3UcJKch _a9fMU0SCS _a7fQE1m9v", "_ig3UcJKch"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let width = CSS.px(10);
  let both =
    CSS.make(
      "_iIxGXPL5_ _a7fQE1m9v _afyQPFuDn _bAC7f1Tl5-w7fHwfC2rjsxQ9O",
      [
        ("--color-1raopcx", CSS.Types.Color.toString(color)),
        ("--width-1n2ktc0", CSS.Types.Padding.toString(width)),
        ("--color-qvekgg", CSS.Types.Color.toString(color)),
      ],
    );
  let mixed =
    CSS.make(
      "_ig3UcJKch _a9fMU0SCS _a7fQE1m9v",
      [("--color-1raopcx", CSS.Types.Color.toString(color))],
    );
