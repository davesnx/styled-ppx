`& + &` and `& ~ &` print every `&` as the atom class and the id of the block
that wrote the rule. Two blocks with the same sibling rule get two atoms that
share one context key, so a merge lets the later block's atom replace the earlier one.
`& + *` has no second `&` and keeps the plain atom.

  $ refmt --parse re --print ml input.re > input.ml

Development:

  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  $ refmt --parse ml --print re dev.ml
  [@css.atoms
    [
      (
        "_cd390BSi47XOq8W",
        [
          "._cd390BSi47XOq8W._i9_V1bLSA + ._cd390BSi47XOq8W._i9_V1bLSA{margin-top:3px;}",
        ],
        0,
        1,
        1,
        [
          ("ctx", "90BSi4", "ctx\\0& + & | "),
          (
            "value",
            "7XOq8W",
            "val\\0d3\\0& + & | \\0margin-top:3px\\0owner:_i9_V1bLSA",
          ),
        ],
      ),
      (
        "_cd390BSi4b2LfUp",
        [
          "._cd390BSi4b2LfUp._iw1tCIvHl + ._cd390BSi4b2LfUp._iw1tCIvHl{margin-top:3px;}",
        ],
        0,
        1,
        1,
        [
          ("ctx", "90BSi4", "ctx\\0& + & | "),
          (
            "value",
            "b2LfUp",
            "val\\0d3\\0& + & | \\0margin-top:3px\\0owner:_iw1tCIvHl",
          ),
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
        "_cd3QkT4DYNtEIKr",
        [
          "._cd3QkT4DYNtEIKr._i6JffwMph ~ ._cd3QkT4DYNtEIKr._i6JffwMph{margin-top:4px;}",
        ],
        0,
        1,
        1,
        [
          ("ctx", "QkT4DY", "ctx\\0& ~ & | "),
          (
            "value",
            "NtEIKr",
            "val\\0d3\\0& ~ & | \\0margin-top:4px\\0owner:_i6JffwMph",
          ),
        ],
      ),
      (
        "_cd3cDlkYuAPm1dD",
        ["._cd3cDlkYuAPm1dD + *{margin-top:3px;}"],
        0,
        1,
        1,
        [
          ("ctx", "cDlkYu", "ctx\\0& + * | "),
          ("value", "APm1dD", "val\\0d3\\0& + * | \\0margin-top:3px"),
        ],
      ),
      (
        "_i9_V1bLSA",
        [],
        1,
        0,
        0,
        [("id", "_i9_V1bLSA", "bind\\0\\0Input\\0\\0first\\00")],
      ),
      (
        "_iw1tCIvHl",
        [],
        1,
        0,
        0,
        [("id", "_iw1tCIvHl", "bind\\0\\0Input\\0\\0second\\00")],
      ),
      (
        "_i6JffwMph",
        [],
        1,
        0,
        0,
        [("id", "_i6JffwMph", "bind\\0\\0Input\\0\\0general\\00")],
      ),
      (
        "_iHxrM1VrW",
        [],
        1,
        0,
        0,
        [("id", "_iHxrM1VrW", "bind\\0\\0Input\\0\\0plain\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.first", "_i9_V1bLSA _cd390BSi47XOq8W", "_i9_V1bLSA"),
      ("Input.second", "_iw1tCIvHl _cd390BSi4b2LfUp", "_iw1tCIvHl"),
      ("Input.general", "_i6JffwMph _a7fadbhEW _cd3QkT4DYNtEIKr", "_i6JffwMph"),
      ("Input.plain", "_iHxrM1VrW _cd3cDlkYuAPm1dD", "_iHxrM1VrW"),
    ]
  ];
  let first = CSS.make("cx-first _i9_V1bLSA _cd390BSi47XOq8W", []);
  let second = CSS.make("cx-second _iw1tCIvHl _cd390BSi4b2LfUp", []);
  let general =
    CSS.make("cx-general _i6JffwMph _a7fadbhEW _cd3QkT4DYNtEIKr", []);
  let plain = CSS.make("cx-plain _iHxrM1VrW _cd3cDlkYuAPm1dD", []);

Production:

  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_cd390BSi47XOq8W",
        [
          "._cd390BSi47XOq8W._i9_V1bLSA + ._cd390BSi47XOq8W._i9_V1bLSA{margin-top:3px;}",
        ],
        0,
        1,
        1,
        [
          ("ctx", "90BSi4", "ctx\\0& + & | "),
          (
            "value",
            "7XOq8W",
            "val\\0d3\\0& + & | \\0margin-top:3px\\0owner:_i9_V1bLSA",
          ),
        ],
      ),
      (
        "_cd390BSi4b2LfUp",
        [
          "._cd390BSi4b2LfUp._iw1tCIvHl + ._cd390BSi4b2LfUp._iw1tCIvHl{margin-top:3px;}",
        ],
        0,
        1,
        1,
        [
          ("ctx", "90BSi4", "ctx\\0& + & | "),
          (
            "value",
            "b2LfUp",
            "val\\0d3\\0& + & | \\0margin-top:3px\\0owner:_iw1tCIvHl",
          ),
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
        "_cd3QkT4DYNtEIKr",
        [
          "._cd3QkT4DYNtEIKr._i6JffwMph ~ ._cd3QkT4DYNtEIKr._i6JffwMph{margin-top:4px;}",
        ],
        0,
        1,
        1,
        [
          ("ctx", "QkT4DY", "ctx\\0& ~ & | "),
          (
            "value",
            "NtEIKr",
            "val\\0d3\\0& ~ & | \\0margin-top:4px\\0owner:_i6JffwMph",
          ),
        ],
      ),
      (
        "_cd3cDlkYuAPm1dD",
        ["._cd3cDlkYuAPm1dD + *{margin-top:3px;}"],
        0,
        1,
        1,
        [
          ("ctx", "cDlkYu", "ctx\\0& + * | "),
          ("value", "APm1dD", "val\\0d3\\0& + * | \\0margin-top:3px"),
        ],
      ),
      (
        "_i9_V1bLSA",
        [],
        1,
        0,
        0,
        [("id", "_i9_V1bLSA", "bind\\0\\0Input\\0\\0first\\00")],
      ),
      (
        "_iw1tCIvHl",
        [],
        1,
        0,
        0,
        [("id", "_iw1tCIvHl", "bind\\0\\0Input\\0\\0second\\00")],
      ),
      (
        "_i6JffwMph",
        [],
        1,
        0,
        0,
        [("id", "_i6JffwMph", "bind\\0\\0Input\\0\\0general\\00")],
      ),
      (
        "_iHxrM1VrW",
        [],
        1,
        0,
        0,
        [("id", "_iHxrM1VrW", "bind\\0\\0Input\\0\\0plain\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.first", "_i9_V1bLSA _cd390BSi47XOq8W", "_i9_V1bLSA"),
      ("Input.second", "_iw1tCIvHl _cd390BSi4b2LfUp", "_iw1tCIvHl"),
      ("Input.general", "_i6JffwMph _a7fadbhEW _cd3QkT4DYNtEIKr", "_i6JffwMph"),
      ("Input.plain", "_iHxrM1VrW _cd3cDlkYuAPm1dD", "_iHxrM1VrW"),
    ]
  ];
  let first = CSS.make("_i9_V1bLSA _cd390BSi47XOq8W", []);
  let second = CSS.make("_iw1tCIvHl _cd390BSi4b2LfUp", []);
  let general = CSS.make("_i6JffwMph _a7fadbhEW _cd3QkT4DYNtEIKr", []);
  let plain = CSS.make("_iHxrM1VrW _cd3cDlkYuAPm1dD", []);
