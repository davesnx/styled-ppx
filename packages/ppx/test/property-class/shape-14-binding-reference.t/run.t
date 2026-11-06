Shape 14: .$(binding) selects the binding id only, and the id is part of the context hash.

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
        "_afyq2bpaF",
        ["._afyq2bpaF{padding:1px;}"],
        1,
        0,
        4,
        [("value", "q2bpaF", "val\\0fy\\0& | \\0padding:1px")],
      ),
      (
        "_c7foH0PdOcdWJDN",
        ["._c7foH0PdOcdWJDN ._iHxrM1VrW{color:blue;}"],
        0,
        1,
        1,
        [
          ("ctx", "oH0PdO", "ctx\\0& ._iHxrM1VrW | "),
          ("value", "cdWJDN", "val\\07f\\0& ._iHxrM1VrW | \\0color:blue"),
        ],
      ),
      (
        "_bAC7fqtLAAn7f2LHvCpRgwyh5",
        [
          "._bAC7fqtLAAn7f2LHvCpRgwyh5._iHxrM1VrW{color:red;}",
          "._bAC7fqtLAAn7f2LHvCpRgwyh5:not(._iHxrM1VrW){color:black;}",
        ],
        2,
        1,
        2,
        [
          ("ctx", "qtLAAn", "ctx\\0&._iHxrM1VrW | "),
          ("ctx", "2LHvCp", "ctx\\0&:not(._iHxrM1VrW) | "),
          (
            "value",
            "Rgwyh5",
            "bval\\0&._iHxrM1VrW | \\07f\\0color:red\\0&:not(._iHxrM1VrW) | \\07f\\0color:black",
          ),
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
      ("Input.plain", "_iHxrM1VrW _a7fBq58Im _afyq2bpaF", "_iHxrM1VrW"),
      (
        "Input.card",
        "_iFPpHlqxh _c7foH0PdOcdWJDN _bAC7fqtLAAn7f2LHvCpRgwyh5",
        "_iFPpHlqxh",
      ),
    ]
  ];
  let plain = CSS.make("cx-plain _iHxrM1VrW _a7fBq58Im _afyq2bpaF", []);
  let card =
    CSS.make(
      "cx-card _iFPpHlqxh _c7foH0PdOcdWJDN _bAC7fqtLAAn7f2LHvCpRgwyh5",
      [],
    );

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
        "_afyq2bpaF",
        ["._afyq2bpaF{padding:1px;}"],
        1,
        0,
        4,
        [("value", "q2bpaF", "val\\0fy\\0& | \\0padding:1px")],
      ),
      (
        "_c7foH0PdOcdWJDN",
        ["._c7foH0PdOcdWJDN ._iHxrM1VrW{color:blue;}"],
        0,
        1,
        1,
        [
          ("ctx", "oH0PdO", "ctx\\0& ._iHxrM1VrW | "),
          ("value", "cdWJDN", "val\\07f\\0& ._iHxrM1VrW | \\0color:blue"),
        ],
      ),
      (
        "_bAC7fqtLAAn7f2LHvCpRgwyh5",
        [
          "._bAC7fqtLAAn7f2LHvCpRgwyh5._iHxrM1VrW{color:red;}",
          "._bAC7fqtLAAn7f2LHvCpRgwyh5:not(._iHxrM1VrW){color:black;}",
        ],
        2,
        1,
        2,
        [
          ("ctx", "qtLAAn", "ctx\\0&._iHxrM1VrW | "),
          ("ctx", "2LHvCp", "ctx\\0&:not(._iHxrM1VrW) | "),
          (
            "value",
            "Rgwyh5",
            "bval\\0&._iHxrM1VrW | \\07f\\0color:red\\0&:not(._iHxrM1VrW) | \\07f\\0color:black",
          ),
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
      ("Input.plain", "_iHxrM1VrW _a7fBq58Im _afyq2bpaF", "_iHxrM1VrW"),
      (
        "Input.card",
        "_iFPpHlqxh _c7foH0PdOcdWJDN _bAC7fqtLAAn7f2LHvCpRgwyh5",
        "_iFPpHlqxh",
      ),
    ]
  ];
  let plain = CSS.make("_iHxrM1VrW _a7fBq58Im _afyq2bpaF", []);
  let card =
    CSS.make("_iFPpHlqxh _c7foH0PdOcdWJDN _bAC7fqtLAAn7f2LHvCpRgwyh5", []);
