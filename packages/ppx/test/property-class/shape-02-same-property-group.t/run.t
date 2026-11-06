Shape 2: a property written twice in one context is one atom, with the declarations in block order.

  $ refmt --parse re --print ml input.re > input.ml

Development:

  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  $ refmt --parse ml --print re dev.ml
  [@css.atoms
    [
      (
        "_a9fl_QS6E",
        ["._a9fl_QS6E{display:-webkit-box;display:flex;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "l_QS6E",
            "val\\09f\\0& | \\0display:-webkit-box\\0display:flex",
          ),
        ],
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
        "_a7fkfXJhc",
        ["._a7fkfXJhc{color:red;color:blue;}"],
        1,
        0,
        1,
        [("value", "kfXJhc", "val\\07f\\0& | \\0color:red\\0color:blue")],
      ),
      (
        "_iDtzh2QAN",
        [],
        1,
        0,
        0,
        [("id", "_iDtzh2QAN", "bind\\0\\0Input\\0\\0fallback\\00")],
      ),
      (
        "_iOvPQxoE7",
        [],
        1,
        0,
        0,
        [("id", "_iOvPQxoE7", "bind\\0\\0Input\\0\\0apart\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.fallback", "_iDtzh2QAN _a9fl_QS6E", "_iDtzh2QAN"),
      ("Input.apart", "_iOvPQxoE7 _afyq2bpaF _a7fkfXJhc", "_iOvPQxoE7"),
    ]
  ];
  let fallback = CSS.make("cx-fallback _iDtzh2QAN _a9fl_QS6E", []);
  let apart = CSS.make("cx-apart _iOvPQxoE7 _afyq2bpaF _a7fkfXJhc", []);

Production:

  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_a9fl_QS6E",
        ["._a9fl_QS6E{display:-webkit-box;display:flex;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "l_QS6E",
            "val\\09f\\0& | \\0display:-webkit-box\\0display:flex",
          ),
        ],
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
        "_a7fkfXJhc",
        ["._a7fkfXJhc{color:red;color:blue;}"],
        1,
        0,
        1,
        [("value", "kfXJhc", "val\\07f\\0& | \\0color:red\\0color:blue")],
      ),
      (
        "_iDtzh2QAN",
        [],
        1,
        0,
        0,
        [("id", "_iDtzh2QAN", "bind\\0\\0Input\\0\\0fallback\\00")],
      ),
      (
        "_iOvPQxoE7",
        [],
        1,
        0,
        0,
        [("id", "_iOvPQxoE7", "bind\\0\\0Input\\0\\0apart\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.fallback", "_iDtzh2QAN _a9fl_QS6E", "_iDtzh2QAN"),
      ("Input.apart", "_iOvPQxoE7 _afyq2bpaF _a7fkfXJhc", "_iOvPQxoE7"),
    ]
  ];
  let fallback = CSS.make("_iDtzh2QAN _a9fl_QS6E", []);
  let apart = CSS.make("_iOvPQxoE7 _afyq2bpaF _a7fkfXJhc", []);
