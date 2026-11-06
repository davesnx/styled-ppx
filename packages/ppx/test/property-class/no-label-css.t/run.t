No label is part of a class name, in development or in production. Development
adds only the `cx-` marker to `CSS.make`. The binding names `card` and `tagged`
occur in no class.

  $ refmt --parse re --print ml input.re > input.ml

Development:

  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  $ refmt --parse ml --print re dev.ml
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
        "_c7f1Tl5-wTx08Fk",
        ["._c7f1Tl5-wTx08Fk:hover{color:blue;}"],
        2,
        1,
        1,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          ("value", "Tx08Fk", "val\\07f\\0&:hover | \\0color:blue"),
        ],
      ),
      (
        "_iFPpHlqxh",
        [],
        1,
        0,
        0,
        [("id", "_iFPpHlqxh", "bind\\0\\0Input\\0\\0card\\00")],
      ),
      (
        "_iAr4sAHiz",
        [],
        1,
        0,
        0,
        [("id", "_iAr4sAHiz", "bind\\0\\0Input\\0Inner\\0tagged\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.card", "_iFPpHlqxh _a7fadbhEW _c7f1Tl5-wTx08Fk", "_iFPpHlqxh"),
      ("Input.Inner.tagged", "_iAr4sAHiz _a7fadbhEW", "_iAr4sAHiz"),
    ]
  ];
  let card = CSS.make("cx-card _iFPpHlqxh _a7fadbhEW _c7f1Tl5-wTx08Fk", []);
  module Inner = {
    let tagged = CSS.make("cx-tagged _iAr4sAHiz _a7fadbhEW", []);
  };

Production:

  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
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
        "_c7f1Tl5-wTx08Fk",
        ["._c7f1Tl5-wTx08Fk:hover{color:blue;}"],
        2,
        1,
        1,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          ("value", "Tx08Fk", "val\\07f\\0&:hover | \\0color:blue"),
        ],
      ),
      (
        "_iFPpHlqxh",
        [],
        1,
        0,
        0,
        [("id", "_iFPpHlqxh", "bind\\0\\0Input\\0\\0card\\00")],
      ),
      (
        "_iAr4sAHiz",
        [],
        1,
        0,
        0,
        [("id", "_iAr4sAHiz", "bind\\0\\0Input\\0Inner\\0tagged\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.card", "_iFPpHlqxh _a7fadbhEW _c7f1Tl5-wTx08Fk", "_iFPpHlqxh"),
      ("Input.Inner.tagged", "_iAr4sAHiz _a7fadbhEW", "_iAr4sAHiz"),
    ]
  ];
  let card = CSS.make("_iFPpHlqxh _a7fadbhEW _c7f1Tl5-wTx08Fk", []);
  module Inner = {
    let tagged = CSS.make("_iAr4sAHiz _a7fadbhEW", []);
  };
