Shape 10: importance is part of the context. An important and a normal declaration never join.

  $ refmt --parse re --print ml input.re > input.ml

Development:

  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  $ refmt --parse ml --print re dev.ml
  [@css.atoms
    [
      (
        "_c7f-ypkeDyLr_7N",
        ["._c7f-ypkeDyLr_7N{color:red !important;}"],
        1,
        0,
        1,
        [
          ("ctx", "-ypkeD", "ctx\\0& | !important"),
          (
            "value",
            "yLr_7N",
            "val\\07f\\0& | !important\\0color:red !important",
          ),
        ],
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
        "_c7fX2BCe5mVq2t_",
        ["._c7fX2BCe5mVq2t_:hover{color:red !important;}"],
        2,
        1,
        1,
        [
          ("ctx", "X2BCe5", "ctx\\0&:hover | !important"),
          (
            "value",
            "mVq2t_",
            "val\\07f\\0&:hover | !important\\0color:red !important",
          ),
        ],
      ),
      (
        "_iEd18Oggr",
        [],
        1,
        0,
        0,
        [("id", "_iEd18Oggr", "bind\\0\\0Input\\0\\0important\\00")],
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
        "_i-gYBYMwr",
        [],
        1,
        0,
        0,
        [("id", "_i-gYBYMwr", "bind\\0\\0Input\\0\\0hover\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.important", "_iEd18Oggr _c7f-ypkeDyLr_7N", "_iEd18Oggr"),
      ("Input.both", "_iIxGXPL5_ _c7f-ypkeDyLr_7N _a7fCPHFf-", "_iIxGXPL5_"),
      ("Input.hover", "_i-gYBYMwr _c7fX2BCe5mVq2t_", "_i-gYBYMwr"),
    ]
  ];
  let important = CSS.make("cx-important _iEd18Oggr _c7f-ypkeDyLr_7N", []);
  let both = CSS.make("cx-both _iIxGXPL5_ _c7f-ypkeDyLr_7N _a7fCPHFf-", []);
  let hover = CSS.make("cx-hover _i-gYBYMwr _c7fX2BCe5mVq2t_", []);

Production:

  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_c7f-ypkeDyLr_7N",
        ["._c7f-ypkeDyLr_7N{color:red !important;}"],
        1,
        0,
        1,
        [
          ("ctx", "-ypkeD", "ctx\\0& | !important"),
          (
            "value",
            "yLr_7N",
            "val\\07f\\0& | !important\\0color:red !important",
          ),
        ],
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
        "_c7fX2BCe5mVq2t_",
        ["._c7fX2BCe5mVq2t_:hover{color:red !important;}"],
        2,
        1,
        1,
        [
          ("ctx", "X2BCe5", "ctx\\0&:hover | !important"),
          (
            "value",
            "mVq2t_",
            "val\\07f\\0&:hover | !important\\0color:red !important",
          ),
        ],
      ),
      (
        "_iEd18Oggr",
        [],
        1,
        0,
        0,
        [("id", "_iEd18Oggr", "bind\\0\\0Input\\0\\0important\\00")],
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
        "_i-gYBYMwr",
        [],
        1,
        0,
        0,
        [("id", "_i-gYBYMwr", "bind\\0\\0Input\\0\\0hover\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.important", "_iEd18Oggr _c7f-ypkeDyLr_7N", "_iEd18Oggr"),
      ("Input.both", "_iIxGXPL5_ _c7f-ypkeDyLr_7N _a7fCPHFf-", "_iIxGXPL5_"),
      ("Input.hover", "_i-gYBYMwr _c7fX2BCe5mVq2t_", "_i-gYBYMwr"),
    ]
  ];
  let important = CSS.make("_iEd18Oggr _c7f-ypkeDyLr_7N", []);
  let both = CSS.make("_iIxGXPL5_ _c7f-ypkeDyLr_7N _a7fCPHFf-", []);
  let hover = CSS.make("_i-gYBYMwr _c7fX2BCe5mVq2t_", []);
