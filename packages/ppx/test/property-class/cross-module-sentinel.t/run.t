A reference that `generate` resolves later keeps its sentinel in the rule. The
context hashes the text of the reference, and the value hash includes the
module that wrote it. The same text in one module is one atom; in two modules
it is two atoms.

  $ refmt --parse re --print ml m.re > m.ml
  $ ../../standalone.exe --env development --impl m.ml -o m.ml
  $ refmt --parse re --print ml a.re > a.ml
  $ ../../standalone.exe --env development --impl a.ml -o a.ml
  $ refmt --parse re --print ml b.re > b.ml
  $ ../../standalone.exe --env development --impl b.ml -o b.ml

  $ refmt --parse ml --print re m.ml
  [@css.atoms
    [
      (
        "_iVOT1Gbzy",
        [],
        1,
        0,
        0,
        [("id", "_iVOT1Gbzy", "bind\\0\\0M\\0\\0marker\\00")],
      ),
    ]
  ];
  [@css.bindings [("M.marker", "_iVOT1Gbzy", "_iVOT1Gbzy")]];
  let marker = CSS.make("cx-marker _iVOT1Gbzy", []);
  $ refmt --parse ml --print re a.ml
  [@css.atoms
    [
      (
        "_c7fpb5oWIkcV7-9",
        ["._c7fpb5oWIkcV7-9.\000M.marker\000{color:red;}"],
        2,
        1,
        1,
        [
          ("ctx", "pb5oWI", "ctx\\0&.$(M.marker)\\0module:A | "),
          (
            "value",
            "kcV7-9",
            "val\\07f\\0&.$(M.marker)\\0module:A | \\0color:red\\0module:A",
          ),
        ],
      ),
      (
        "_i-hBSacgS",
        [],
        1,
        0,
        0,
        [("id", "_i-hBSacgS", "bind\\0\\0A\\0\\0one\\00")],
      ),
      (
        "_iF5BwfB0U",
        [],
        1,
        0,
        0,
        [("id", "_iF5BwfB0U", "bind\\0\\0A\\0\\0two\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("A.one", "_i-hBSacgS _c7fpb5oWIkcV7-9", "_i-hBSacgS"),
      ("A.two", "_iF5BwfB0U _c7fpb5oWIkcV7-9", "_iF5BwfB0U"),
    ]
  ];
  [@css.refs
    [("M.marker", "a.ml", 1, 21, 29), ("M.marker", "a.ml", 2, 21, 29)]
  ];
  let _ = M.marker;
  let one = CSS.make("cx-one _i-hBSacgS _c7fpb5oWIkcV7-9", []);
  let two = CSS.make("cx-two _iF5BwfB0U _c7fpb5oWIkcV7-9", []);
  $ refmt --parse ml --print re b.ml
  [@css.atoms
    [
      (
        "_c7fMLd1JkAbrpgC",
        ["._c7fMLd1JkAbrpgC.\000M.marker\000{color:red;}"],
        2,
        1,
        1,
        [
          ("ctx", "MLd1Jk", "ctx\\0&.$(M.marker)\\0module:B | "),
          (
            "value",
            "AbrpgC",
            "val\\07f\\0&.$(M.marker)\\0module:B | \\0color:red\\0module:B",
          ),
        ],
      ),
      (
        "_iYCjrGRiJ",
        [],
        1,
        0,
        0,
        [("id", "_iYCjrGRiJ", "bind\\0\\0B\\0\\0one\\00")],
      ),
    ]
  ];
  [@css.bindings [("B.one", "_iYCjrGRiJ _c7fMLd1JkAbrpgC", "_iYCjrGRiJ")]];
  [@css.refs [("M.marker", "b.ml", 1, 21, 29)]];
  let _ = M.marker;
  let one = CSS.make("cx-one _iYCjrGRiJ _c7fMLd1JkAbrpgC", []);
