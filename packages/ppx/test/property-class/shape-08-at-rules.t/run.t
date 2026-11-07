Shape 8: conditions are part of the context. Nested conditions are a sorted set.

  $ refmt --parse re --print ml input.re > input.ml

Development:

  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  $ refmt --parse ml --print re dev.ml
  [@css.atoms
    [
      (
        "_c7f-T3I8pU4gQ5t",
        ["@media (min-width:1px){._c7f-T3I8pU4gQ5t{color:red;}}"],
        2,
        1,
        1,
        [
          ("ctx", "-T3I8p", "ctx\\0& | @media (min-width:1px) | "),
          (
            "value",
            "U4gQ5t",
            "val\\07f\\0& | @media (min-width:1px) | \\0color:red",
          ),
        ],
      ),
      (
        "_c9fIoG2OErnOhP3",
        [
          "@media (min-width:1px){@supports (display:grid){._c9fIoG2OErnOhP3{display:grid;}}}",
        ],
        2,
        2,
        1,
        [
          (
            "ctx",
            "IoG2OE",
            "ctx\\0& | @media (min-width:1px) | @supports (display:grid) | ",
          ),
          (
            "value",
            "rnOhP3",
            "val\\09f\\0& | @media (min-width:1px) | @supports (display:grid) | \\0display:grid",
          ),
        ],
      ),
      (
        "_c7fTmxdKadllJiW",
        ["@container (min-width:2px){._c7fTmxdKadllJiW:hover{color:red;}}"],
        2,
        2,
        1,
        [
          ("ctx", "TmxdKa", "ctx\\0&:hover | @container (min-width:2px) | "),
          (
            "value",
            "dllJiW",
            "val\\07f\\0&:hover | @container (min-width:2px) | \\0color:red",
          ),
        ],
      ),
      (
        "_c7fQkqc7bM1VG5Q",
        ["@media (min-width:1px){._c7fQkqc7bM1VG5Q:hover{color:red;}}"],
        2,
        2,
        1,
        [
          ("ctx", "Qkqc7b", "ctx\\0&:hover | @media (min-width:1px) | "),
          (
            "value",
            "M1VG5Q",
            "val\\07f\\0&:hover | @media (min-width:1px) | \\0color:red",
          ),
        ],
      ),
      (
        "_izkc6_vNx",
        [],
        1,
        0,
        0,
        [("id", "_izkc6_vNx", "bind\\0\\0Input\\0\\0media\\00")],
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
        "_iKEQcokpo",
        [],
        1,
        0,
        0,
        [("id", "_iKEQcokpo", "bind\\0\\0Input\\0\\0swapped\\00")],
      ),
      (
        "_i5xwEIDfv",
        [],
        1,
        0,
        0,
        [("id", "_i5xwEIDfv", "bind\\0\\0Input\\0\\0container\\00")],
      ),
      (
        "_iCnRzBOWl",
        [],
        1,
        0,
        0,
        [("id", "_iCnRzBOWl", "bind\\0\\0Input\\0\\0inHover\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.media", "_izkc6_vNx _c7f-T3I8pU4gQ5t", "_izkc6_vNx"),
      ("Input.nested", "_iQIM0ep0T _c9fIoG2OErnOhP3", "_iQIM0ep0T"),
      ("Input.swapped", "_iKEQcokpo _c9fIoG2OErnOhP3", "_iKEQcokpo"),
      ("Input.container", "_i5xwEIDfv _c7fTmxdKadllJiW", "_i5xwEIDfv"),
      ("Input.inHover", "_iCnRzBOWl _c7fQkqc7bM1VG5Q", "_iCnRzBOWl"),
    ]
  ];
  let media = CSS.make("cx-media _izkc6_vNx _c7f-T3I8pU4gQ5t", []);
  let nested = CSS.make("cx-nested _iQIM0ep0T _c9fIoG2OErnOhP3", []);
  let swapped = CSS.make("cx-swapped _iKEQcokpo _c9fIoG2OErnOhP3", []);
  let container = CSS.make("cx-container _i5xwEIDfv _c7fTmxdKadllJiW", []);
  let inHover = CSS.make("cx-inHover _iCnRzBOWl _c7fQkqc7bM1VG5Q", []);

Production:

  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_c7f-T3I8pU4gQ5t",
        ["@media (min-width:1px){._c7f-T3I8pU4gQ5t{color:red;}}"],
        2,
        1,
        1,
        [
          ("ctx", "-T3I8p", "ctx\\0& | @media (min-width:1px) | "),
          (
            "value",
            "U4gQ5t",
            "val\\07f\\0& | @media (min-width:1px) | \\0color:red",
          ),
        ],
      ),
      (
        "_c9fIoG2OErnOhP3",
        [
          "@media (min-width:1px){@supports (display:grid){._c9fIoG2OErnOhP3{display:grid;}}}",
        ],
        2,
        2,
        1,
        [
          (
            "ctx",
            "IoG2OE",
            "ctx\\0& | @media (min-width:1px) | @supports (display:grid) | ",
          ),
          (
            "value",
            "rnOhP3",
            "val\\09f\\0& | @media (min-width:1px) | @supports (display:grid) | \\0display:grid",
          ),
        ],
      ),
      (
        "_c7fTmxdKadllJiW",
        ["@container (min-width:2px){._c7fTmxdKadllJiW:hover{color:red;}}"],
        2,
        2,
        1,
        [
          ("ctx", "TmxdKa", "ctx\\0&:hover | @container (min-width:2px) | "),
          (
            "value",
            "dllJiW",
            "val\\07f\\0&:hover | @container (min-width:2px) | \\0color:red",
          ),
        ],
      ),
      (
        "_c7fQkqc7bM1VG5Q",
        ["@media (min-width:1px){._c7fQkqc7bM1VG5Q:hover{color:red;}}"],
        2,
        2,
        1,
        [
          ("ctx", "Qkqc7b", "ctx\\0&:hover | @media (min-width:1px) | "),
          (
            "value",
            "M1VG5Q",
            "val\\07f\\0&:hover | @media (min-width:1px) | \\0color:red",
          ),
        ],
      ),
      (
        "_izkc6_vNx",
        [],
        1,
        0,
        0,
        [("id", "_izkc6_vNx", "bind\\0\\0Input\\0\\0media\\00")],
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
        "_iKEQcokpo",
        [],
        1,
        0,
        0,
        [("id", "_iKEQcokpo", "bind\\0\\0Input\\0\\0swapped\\00")],
      ),
      (
        "_i5xwEIDfv",
        [],
        1,
        0,
        0,
        [("id", "_i5xwEIDfv", "bind\\0\\0Input\\0\\0container\\00")],
      ),
      (
        "_iCnRzBOWl",
        [],
        1,
        0,
        0,
        [("id", "_iCnRzBOWl", "bind\\0\\0Input\\0\\0inHover\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.media", "_izkc6_vNx _c7f-T3I8pU4gQ5t", "_izkc6_vNx"),
      ("Input.nested", "_iQIM0ep0T _c9fIoG2OErnOhP3", "_iQIM0ep0T"),
      ("Input.swapped", "_iKEQcokpo _c9fIoG2OErnOhP3", "_iKEQcokpo"),
      ("Input.container", "_i5xwEIDfv _c7fTmxdKadllJiW", "_i5xwEIDfv"),
      ("Input.inHover", "_iCnRzBOWl _c7fQkqc7bM1VG5Q", "_iCnRzBOWl"),
    ]
  ];
  let media = CSS.make("_izkc6_vNx _c7f-T3I8pU4gQ5t", []);
  let nested = CSS.make("_iQIM0ep0T _c9fIoG2OErnOhP3", []);
  let swapped = CSS.make("_iKEQcokpo _c9fIoG2OErnOhP3", []);
  let container = CSS.make("_i5xwEIDfv _c7fTmxdKadllJiW", []);
  let inHover = CSS.make("_iCnRzBOWl _c7fQkqc7bM1VG5Q", []);
