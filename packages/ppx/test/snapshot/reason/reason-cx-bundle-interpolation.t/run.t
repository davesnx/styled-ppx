Each interpolating declaration is its own atom with its own var, across base /
:hover / @media variants.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --color-1raopcx{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-ycftl9{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-zlktsz{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-s4afn7{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-1poadf9{syntax:\"*\";inherits:false;}"];
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
        "_bAC7f1Tl5-w7fjG-6dW27L7Rx",
        [
          "._bAC7f1Tl5-w7fjG-6dW27L7Rx:hover{color:var(--color-ycftl9);}",
          "@media (max-width: 768px) {._bAC7f1Tl5-w7fjG-6dW27L7Rx{color:var(--color-ycftl9);}}",
        ],
        2,
        1,
        2,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          ("ctx", "jG-6dW", "ctx\\0& | @media(max-width:768px) | "),
          (
            "value",
            "27L7Rx",
            "bval\\0&:hover | \\07f\\0color:$(color)\\0& | @media(max-width:768px) | \\07f\\0color:$(color)",
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
        "_an8FHTy9P",
        ["._an8FHTy9P{width:var(--width-s4afn7);}"],
        1,
        0,
        1,
        [("value", "FHTy9P", "val\\0n8\\0& | \\0width:$(width)")],
      ),
      (
        "_cbd1Tl5-wDx39OI",
        ["._cbd1Tl5-wDx39OI:hover{height:var(--width-1poadf9);}"],
        2,
        1,
        1,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          ("value", "Dx39OI", "val\\0bd\\0&:hover | \\0height:$(width)"),
        ],
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
        "_igtOx8BPu",
        [],
        1,
        0,
        0,
        [("id", "_igtOx8BPu", "bind\\0\\0Output\\0\\0multiVariant\\00")],
      ),
      (
        "_iPy6mSKfI",
        [],
        1,
        0,
        0,
        [("id", "_iPy6mSKfI", "bind\\0\\0Output\\0\\0mixed\\00")],
      ),
      (
        "_iNt-gUZds",
        [],
        1,
        0,
        0,
        [("id", "_iNt-gUZds", "bind\\0\\0Output\\0\\0twoTypes\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      (
        "Output.multiVariant",
        "_igtOx8BPu _a7fQE1m9v _bAC7f1Tl5-w7fjG-6dW27L7Rx",
        "_igtOx8BPu",
      ),
      (
        "Output.mixed",
        "_iPy6mSKfI _a9fMU0SCS _a7fQE1m9v _c7f1Tl5-wm8KWM7",
        "_iPy6mSKfI",
      ),
      (
        "Output.twoTypes",
        "_iNt-gUZds _an8FHTy9P _cbd1Tl5-wDx39OI",
        "_iNt-gUZds",
      ),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let width = CSS.px(10);
  let multiVariant =
    CSS.make(
      "_igtOx8BPu _a7fQE1m9v _bAC7f1Tl5-w7fjG-6dW27L7Rx",
      [
        ("--color-1raopcx", CSS.Types.Color.toString(color)),
        ("--color-ycftl9", CSS.Types.Color.toString(color)),
      ],
    );
  let mixed =
    CSS.make(
      "_iPy6mSKfI _a9fMU0SCS _a7fQE1m9v _c7f1Tl5-wm8KWM7",
      [
        ("--color-1raopcx", CSS.Types.Color.toString(color)),
        ("--color-zlktsz", CSS.Types.Color.toString(color)),
      ],
    );
  let twoTypes =
    CSS.make(
      "_iNt-gUZds _an8FHTy9P _cbd1Tl5-wDx39OI",
      [
        ("--width-s4afn7", CSS.Types.Width.toString(width)),
        ("--width-1poadf9", CSS.Types.Height.toString(width)),
      ],
    );
  let _ =
    CSS.make(
      "_a7fadbhEW _c7f1Tl5-wm8KWM7",
      [("--color-zlktsz", CSS.Types.Color.toString(color))],
    );
  let _ =
    CSS.make(
      "_a9fMU0SCS _c7f1Tl5-wm8KWM7",
      [("--color-zlktsz", CSS.Types.Color.toString(color))],
    );
