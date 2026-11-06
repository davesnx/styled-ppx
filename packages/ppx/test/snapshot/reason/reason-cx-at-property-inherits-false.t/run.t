Plan 4: @property{syntax:"*";inherits:false} is emitted for &-local interpolation
vars (top-level / &:hover / @media) and withheld for descendant-read vars.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --color-1raopcx{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-zlktsz{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-lb2a0s{syntax:\"*\";inherits:false;}"];
  [@css "@property --str-rhaclj{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-1ltynhr{syntax:\"*\";inherits:false;}"];
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
        "_c7fjG-6dWipEbbG",
        [
          "@media (max-width: 768px) {._c7fjG-6dWipEbbG{color:var(--color-lb2a0s);}}",
        ],
        2,
        1,
        1,
        [
          ("ctx", "jG-6dW", "ctx\\0& | @media(max-width:768px) | "),
          (
            "value",
            "ipEbbG",
            "val\\07f\\0& | @media(max-width:768px) | \\0color:$(color)",
          ),
        ],
      ),
      (
        "_c7fsFnj_7u_QGgb",
        ["._c7fsFnj_7u_QGgb .child{color:var(--color-hx661j);}"],
        0,
        1,
        1,
        [
          ("ctx", "sFnj_7", "ctx\\0& .child | "),
          ("value", "u_QGgb", "val\\07f\\0& .child | \\0color:$(color)"),
        ],
      ),
      (
        "_xd_H_Nx000000HyMkKn",
        ["._xd_H_Nx000000HyMkKn{--brand:var(--str-rhaclj);}"],
        1,
        0,
        1,
        [
          ("name", "d_H_Nx", "name\\0--brand"),
          ("value", "HyMkKn", "val\\0--brand\\0& | \\0--brand:$(str)"),
        ],
      ),
      (
        "_c7fDXixWYhRvvsW",
        ["._c7fDXixWYhRvvsW::placeholder{color:var(--color-1c8yon3);}"],
        2,
        1,
        1,
        [
          ("ctx", "DXixWY", "ctx\\0&::placeholder | "),
          ("value", "hRvvsW", "val\\07f\\0&::placeholder | \\0color:$(color)"),
        ],
      ),
      (
        "_c7f33tZ8CiL_rBc",
        ["._c7f33tZ8CiL_rBc:before{color:var(--color-1pupb4k);}"],
        2,
        1,
        1,
        [
          ("ctx", "33tZ8C", "ctx\\0&:before | "),
          ("value", "iL_rBc", "val\\07f\\0&:before | \\0color:$(color)"),
        ],
      ),
      (
        "_c7fE-cX-HuMImMd",
        ["._c7fE-cX-HuMImMd::before{color:var(--color-5te31o);}"],
        2,
        1,
        1,
        [
          ("ctx", "E-cX-H", "ctx\\0&::before | "),
          ("value", "uMImMd", "val\\07f\\0&::before | \\0color:$(color)"),
        ],
      ),
      (
        "_c7fPVtQGX7-H0ZP",
        [
          "._c7fPVtQGX7-H0ZP:focus-visible:not(:disabled){color:var(--color-1ltynhr);}",
        ],
        2,
        1,
        1,
        [
          ("ctx", "PVtQGX", "ctx\\0&:focus-visible:not(:disabled) | "),
          (
            "value",
            "7-H0ZP",
            "val\\07f\\0&:focus-visible:not(:disabled) | \\0color:$(color)",
          ),
        ],
      ),
      (
        "_iU79GCYAj",
        [],
        1,
        0,
        0,
        [("id", "_iU79GCYAj", "bind\\0\\0Output\\0\\0topLevel\\00")],
      ),
      (
        "_iYq2a33uD",
        [],
        1,
        0,
        0,
        [("id", "_iYq2a33uD", "bind\\0\\0Output\\0\\0hover\\00")],
      ),
      (
        "_i2N5XvSeL",
        [],
        1,
        0,
        0,
        [("id", "_i2N5XvSeL", "bind\\0\\0Output\\0\\0media\\00")],
      ),
      (
        "_iIjlCg7wy",
        [],
        1,
        0,
        0,
        [("id", "_iIjlCg7wy", "bind\\0\\0Output\\0\\0descendant\\00")],
      ),
      (
        "_i--7b0PhA",
        [],
        1,
        0,
        0,
        [("id", "_i--7b0PhA", "bind\\0\\0Output\\0\\0bundleSpan\\00")],
      ),
      (
        "_i5SFodIU_",
        [],
        1,
        0,
        0,
        [("id", "_i5SFodIU_", "bind\\0\\0Output\\0\\0customFeeder\\00")],
      ),
      (
        "_i99sdMKbM",
        [],
        1,
        0,
        0,
        [("id", "_i99sdMKbM", "bind\\0\\0Output\\0\\0pseudoElement\\00")],
      ),
      (
        "_ick9Uc70c",
        [],
        1,
        0,
        0,
        [
          ("id", "_ick9Uc70c", "bind\\0\\0Output\\0\\0legacyPseudoElement\\00"),
        ],
      ),
      (
        "_il-dZZ8wU",
        [],
        1,
        0,
        0,
        [("id", "_il-dZZ8wU", "bind\\0\\0Output\\0\\0mixedPseudo\\00")],
      ),
      (
        "_igTwNjb97",
        [],
        1,
        0,
        0,
        [("id", "_igTwNjb97", "bind\\0\\0Output\\0\\0pseudoClassOnly\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Output.topLevel", "_iU79GCYAj _a7fQE1m9v", "_iU79GCYAj"),
      ("Output.hover", "_iYq2a33uD _c7f1Tl5-wm8KWM7", "_iYq2a33uD"),
      ("Output.media", "_i2N5XvSeL _c7fjG-6dWipEbbG", "_i2N5XvSeL"),
      ("Output.descendant", "_iIjlCg7wy _c7fsFnj_7u_QGgb", "_iIjlCg7wy"),
      (
        "Output.bundleSpan",
        "_i--7b0PhA _a7fQE1m9v _c7fsFnj_7u_QGgb",
        "_i--7b0PhA",
      ),
      ("Output.customFeeder", "_i5SFodIU_ _xd_H_Nx000000HyMkKn", "_i5SFodIU_"),
      ("Output.pseudoElement", "_i99sdMKbM _c7fDXixWYhRvvsW", "_i99sdMKbM"),
      (
        "Output.legacyPseudoElement",
        "_ick9Uc70c _c7f33tZ8CiL_rBc",
        "_ick9Uc70c",
      ),
      (
        "Output.mixedPseudo",
        "_il-dZZ8wU _a7fQE1m9v _c7fE-cX-HuMImMd",
        "_il-dZZ8wU",
      ),
      ("Output.pseudoClassOnly", "_igTwNjb97 _c7fPVtQGX7-H0ZP", "_igTwNjb97"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let str = "literal";
  let topLevel =
    CSS.make(
      "_iU79GCYAj _a7fQE1m9v",
      [("--color-1raopcx", CSS.Types.Color.toString(color))],
    );
  let hover =
    CSS.make(
      "_iYq2a33uD _c7f1Tl5-wm8KWM7",
      [("--color-zlktsz", CSS.Types.Color.toString(color))],
    );
  let media =
    CSS.make(
      "_i2N5XvSeL _c7fjG-6dWipEbbG",
      [("--color-lb2a0s", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "_iIjlCg7wy _c7fsFnj_7u_QGgb",
      [("--color-hx661j", CSS.Types.Color.toString(color))],
    );
  let bundleSpan =
    CSS.make(
      "_i--7b0PhA _a7fQE1m9v _c7fsFnj_7u_QGgb",
      [
        ("--color-1raopcx", CSS.Types.Color.toString(color)),
        ("--color-hx661j", CSS.Types.Color.toString(color)),
      ],
    );
  let customFeeder =
    CSS.make("_i5SFodIU_ _xd_H_Nx000000HyMkKn", [("--str-rhaclj", str)]);
  let pseudoElement =
    CSS.make(
      "_i99sdMKbM _c7fDXixWYhRvvsW",
      [("--color-1c8yon3", CSS.Types.Color.toString(color))],
    );
  let legacyPseudoElement =
    CSS.make(
      "_ick9Uc70c _c7f33tZ8CiL_rBc",
      [("--color-1pupb4k", CSS.Types.Color.toString(color))],
    );
  let mixedPseudo =
    CSS.make(
      "_il-dZZ8wU _a7fQE1m9v _c7fE-cX-HuMImMd",
      [
        ("--color-1raopcx", CSS.Types.Color.toString(color)),
        ("--color-5te31o", CSS.Types.Color.toString(color)),
      ],
    );
  let pseudoClassOnly =
    CSS.make(
      "_igTwNjb97 _c7fPVtQGX7-H0ZP",
      [("--color-1ltynhr", CSS.Types.Color.toString(color))],
    );
