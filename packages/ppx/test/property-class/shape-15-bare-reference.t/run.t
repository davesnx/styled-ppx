Shape 15: a bare $(binding) in type position selects the binding id.

  $ refmt --parse re --print ml input.re > input.ml

Development:

  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  $ refmt --parse ml --print re dev.ml
  [@css.atoms
    [
      (
        "_a7fBq58Im",
        ["._a7fBq58Im{color:green;}"],
        1,
        0,
        1,
        [("value", "Bq58Im", "val\\07f\\0& | \\0color:green")],
      ),
      (
        "_c7f2LHvCpS_FX9t",
        ["._c7f2LHvCpS_FX9t:not(._iHxrM1VrW){color:black;}"],
        2,
        1,
        1,
        [
          ("ctx", "2LHvCp", "ctx\\0&:not(._iHxrM1VrW) | "),
          ("value", "S_FX9t", "val\\07f\\0&:not(._iHxrM1VrW) | \\0color:black"),
        ],
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
        "_iFPpHlqxh",
        [],
        1,
        0,
        0,
        [("id", "_iFPpHlqxh", "bind\\0\\0Input\\0\\0card\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.plain", "_iHxrM1VrW _a7fBq58Im", "_iHxrM1VrW"),
      ("Input.card", "_iFPpHlqxh _c7f2LHvCpS_FX9t", "_iFPpHlqxh"),
    ]
  ];
  let plain = CSS.make("cx-plain _iHxrM1VrW _a7fBq58Im", []);
  let card = CSS.make("cx-card _iFPpHlqxh _c7f2LHvCpS_FX9t", []);

Production:

  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_a7fBq58Im",
        ["._a7fBq58Im{color:green;}"],
        1,
        0,
        1,
        [("value", "Bq58Im", "val\\07f\\0& | \\0color:green")],
      ),
      (
        "_c7f2LHvCpS_FX9t",
        ["._c7f2LHvCpS_FX9t:not(._iHxrM1VrW){color:black;}"],
        2,
        1,
        1,
        [
          ("ctx", "2LHvCp", "ctx\\0&:not(._iHxrM1VrW) | "),
          ("value", "S_FX9t", "val\\07f\\0&:not(._iHxrM1VrW) | \\0color:black"),
        ],
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
        "_iFPpHlqxh",
        [],
        1,
        0,
        0,
        [("id", "_iFPpHlqxh", "bind\\0\\0Input\\0\\0card\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.plain", "_iHxrM1VrW _a7fBq58Im", "_iHxrM1VrW"),
      ("Input.card", "_iFPpHlqxh _c7f2LHvCpS_FX9t", "_iFPpHlqxh"),
    ]
  ];
  let plain = CSS.make("_iHxrM1VrW _a7fBq58Im", []);
  let card = CSS.make("_iFPpHlqxh _c7f2LHvCpS_FX9t", []);
