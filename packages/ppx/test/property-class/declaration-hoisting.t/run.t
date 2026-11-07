A block's own declarations come before its nested rules, whatever their source order, as in stylis (@emotion/css cx).
`& {}` shares the plain context: red and blue come first, then green, so green wins.
The base `padding-top` is one atom and the @media one a second atom, which the sheet puts after it.

  $ refmt --parse re --print ml input.re > input.ml
  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_a7fLqrP6y",
        ["._a7fLqrP6y{color:red;color:blue;color:green;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "LqrP6y",
            "val\\07f\\0& | \\0color:red\\0color:blue\\0color:green",
          ),
        ],
      ),
      (
        "_ag8pXy8fW",
        ["._ag8pXy8fW{padding-top:2px;}"],
        1,
        0,
        1,
        [("value", "pXy8fW", "val\\0g8\\0& | \\0padding-top:2px")],
      ),
      (
        "_cg8CmnvJdQVfzbf",
        ["@media (min-width:1000px){._cg8CmnvJdQVfzbf{padding-top:1px;}}"],
        2,
        1,
        1,
        [
          ("ctx", "CmnvJd", "ctx\\0& | @media (min-width:1000px) | "),
          (
            "value",
            "QVfzbf",
            "val\\0g8\\0& | @media (min-width:1000px) | \\0padding-top:1px",
          ),
        ],
      ),
      (
        "_iQIM0ep0T",
        [],
        1,
        0,
        0,
        [("id", "_iQIM0ep0T", "bind\\0\\0Input\\0\\0nested\\00")],
      ),
      (
        "_izkc6_vNx",
        [],
        1,
        0,
        0,
        [("id", "_izkc6_vNx", "bind\\0\\0Input\\0\\0media\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.nested", "_iQIM0ep0T _a7fLqrP6y", "_iQIM0ep0T"),
      ("Input.media", "_izkc6_vNx _ag8pXy8fW _cg8CmnvJdQVfzbf", "_izkc6_vNx"),
    ]
  ];
  let nested = CSS.make("_iQIM0ep0T _a7fLqrP6y", []);
  let media = CSS.make("_izkc6_vNx _ag8pXy8fW _cg8CmnvJdQVfzbf", []);
