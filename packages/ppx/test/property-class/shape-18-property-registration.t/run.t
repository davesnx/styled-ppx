Shape 18: @property registers a var read only on the element itself. A var read by a descendant rule is not registered.

  $ refmt --parse re --print ml input.re > input.ml

Development:

  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  $ refmt --parse ml --print re dev.ml
  [@css "@property --color-1raopcx{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-zlktsz{syntax:\"*\";inherits:false;}"];
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
        "_c7f1Tl5-wm8KWM7",
        ["._c7f1Tl5-wm8KWM7:hover{color:var(--color-zlktsz);}"],
        2,
        1,
        1,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          ("value", "m8KWM7", "val\\07f\\0&:hover | \\0color:$(color)"),
        ],
      ),
      (
        "_c7fkDsyxk4DXryg",
        ["._c7fkDsyxk4DXryg > *{color:var(--color-1y2dnx1);}"],
        0,
        1,
        1,
        [
          ("ctx", "kDsyxk", "ctx\\0& > * | "),
          ("value", "4DXryg", "val\\07f\\0& > * | \\0color:$(color)"),
        ],
      ),
      (
        "_c7fkfHr5BSRqTck",
        ["._c7fkfHr5BSRqTck::after{color:var(--color-1j4jbp9);}"],
        2,
        1,
        1,
        [
          ("ctx", "kfHr5B", "ctx\\0&::after | "),
          ("value", "SRqTck", "val\\07f\\0&::after | \\0color:$(color)"),
        ],
      ),
      (
        "_i1gfy-1GC",
        [],
        1,
        0,
        0,
        [("id", "_i1gfy-1GC", "bind\\0\\0Input\\0\\0own\\00")],
      ),
      (
        "_iNJ9tTqYC",
        [],
        1,
        0,
        0,
        [("id", "_iNJ9tTqYC", "bind\\0\\0Input\\0\\0down\\00")],
      ),
      (
        "_iVeDmRf6y",
        [],
        1,
        0,
        0,
        [("id", "_iVeDmRf6y", "bind\\0\\0Input\\0\\0after\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.own", "_i1gfy-1GC _a7fQE1m9v _c7f1Tl5-wm8KWM7", "_i1gfy-1GC"),
      ("Input.down", "_iNJ9tTqYC _c7fkDsyxk4DXryg", "_iNJ9tTqYC"),
      ("Input.after", "_iVeDmRf6y _c7fkfHr5BSRqTck", "_iVeDmRf6y"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let own =
    CSS.make(
      "cx-own _i1gfy-1GC _a7fQE1m9v _c7f1Tl5-wm8KWM7",
      [
        ("--color-1raopcx", CSS.Types.Color.toString(color)),
        ("--color-zlktsz", CSS.Types.Color.toString(color)),
      ],
    );
  let down =
    CSS.make(
      "cx-down _iNJ9tTqYC _c7fkDsyxk4DXryg",
      [("--color-1y2dnx1", CSS.Types.Color.toString(color))],
    );
  let after =
    CSS.make(
      "cx-after _iVeDmRf6y _c7fkfHr5BSRqTck",
      [("--color-1j4jbp9", CSS.Types.Color.toString(color))],
    );

Production:

  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css "@property --color-1raopcx{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-zlktsz{syntax:\"*\";inherits:false;}"];
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
        "_c7f1Tl5-wm8KWM7",
        ["._c7f1Tl5-wm8KWM7:hover{color:var(--color-zlktsz);}"],
        2,
        1,
        1,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          ("value", "m8KWM7", "val\\07f\\0&:hover | \\0color:$(color)"),
        ],
      ),
      (
        "_c7fkDsyxk4DXryg",
        ["._c7fkDsyxk4DXryg > *{color:var(--color-1y2dnx1);}"],
        0,
        1,
        1,
        [
          ("ctx", "kDsyxk", "ctx\\0& > * | "),
          ("value", "4DXryg", "val\\07f\\0& > * | \\0color:$(color)"),
        ],
      ),
      (
        "_c7fkfHr5BSRqTck",
        ["._c7fkfHr5BSRqTck::after{color:var(--color-1j4jbp9);}"],
        2,
        1,
        1,
        [
          ("ctx", "kfHr5B", "ctx\\0&::after | "),
          ("value", "SRqTck", "val\\07f\\0&::after | \\0color:$(color)"),
        ],
      ),
      (
        "_i1gfy-1GC",
        [],
        1,
        0,
        0,
        [("id", "_i1gfy-1GC", "bind\\0\\0Input\\0\\0own\\00")],
      ),
      (
        "_iNJ9tTqYC",
        [],
        1,
        0,
        0,
        [("id", "_iNJ9tTqYC", "bind\\0\\0Input\\0\\0down\\00")],
      ),
      (
        "_iVeDmRf6y",
        [],
        1,
        0,
        0,
        [("id", "_iVeDmRf6y", "bind\\0\\0Input\\0\\0after\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.own", "_i1gfy-1GC _a7fQE1m9v _c7f1Tl5-wm8KWM7", "_i1gfy-1GC"),
      ("Input.down", "_iNJ9tTqYC _c7fkDsyxk4DXryg", "_iNJ9tTqYC"),
      ("Input.after", "_iVeDmRf6y _c7fkfHr5BSRqTck", "_iVeDmRf6y"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let own =
    CSS.make(
      "_i1gfy-1GC _a7fQE1m9v _c7f1Tl5-wm8KWM7",
      [
        ("--color-1raopcx", CSS.Types.Color.toString(color)),
        ("--color-zlktsz", CSS.Types.Color.toString(color)),
      ],
    );
  let down =
    CSS.make(
      "_iNJ9tTqYC _c7fkDsyxk4DXryg",
      [("--color-1y2dnx1", CSS.Types.Color.toString(color))],
    );
  let after =
    CSS.make(
      "_iVeDmRf6y _c7fkfHr5BSRqTck",
      [("--color-1j4jbp9", CSS.Types.Color.toString(color))],
    );
