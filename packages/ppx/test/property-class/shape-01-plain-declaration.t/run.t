Shape 1: a declaration in the plain context is one atom. The same declaration in two blocks is one class.

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
        "_a9f0DQt2Z",
        ["._a9f0DQt2Z{display:block;}"],
        1,
        0,
        1,
        [("value", "0DQt2Z", "val\\09f\\0& | \\0display:block")],
      ),
      (
        "_iHxrM1VrW",
        [],
        1,
        0,
        0,
        [("id", "_iHxrM1VrW", "bind\\0\\0Input\\0\\0plain\\00")],
      ),
      (
        "_iPEA4CIFa",
        [],
        1,
        0,
        0,
        [("id", "_iPEA4CIFa", "bind\\0\\0Input\\0\\0twice\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.plain", "_iHxrM1VrW _a7fadbhEW", "_iHxrM1VrW"),
      ("Input.twice", "_iPEA4CIFa _a7fadbhEW _a9f0DQt2Z", "_iPEA4CIFa"),
    ]
  ];
  let plain = CSS.make("cx-plain _iHxrM1VrW _a7fadbhEW", []);
  let twice = CSS.make("cx-twice _iPEA4CIFa _a7fadbhEW _a9f0DQt2Z", []);

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
        "_a9f0DQt2Z",
        ["._a9f0DQt2Z{display:block;}"],
        1,
        0,
        1,
        [("value", "0DQt2Z", "val\\09f\\0& | \\0display:block")],
      ),
      (
        "_iHxrM1VrW",
        [],
        1,
        0,
        0,
        [("id", "_iHxrM1VrW", "bind\\0\\0Input\\0\\0plain\\00")],
      ),
      (
        "_iPEA4CIFa",
        [],
        1,
        0,
        0,
        [("id", "_iPEA4CIFa", "bind\\0\\0Input\\0\\0twice\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.plain", "_iHxrM1VrW _a7fadbhEW", "_iHxrM1VrW"),
      ("Input.twice", "_iPEA4CIFa _a7fadbhEW _a9f0DQt2Z", "_iPEA4CIFa"),
    ]
  ];
  let plain = CSS.make("_iHxrM1VrW _a7fadbhEW", []);
  let twice = CSS.make("_iPEA4CIFa _a7fadbhEW _a9f0DQt2Z", []);
