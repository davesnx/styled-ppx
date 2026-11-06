Shape 8: conditions are part of the context. Nested conditions are a sorted set.

  $ refmt --parse re --print ml input.re > input.ml

Development:

  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  $ refmt --parse ml --print re dev.ml
  [@css.atoms
    [
      (
        "_c7fgUl2yyRiBe2R",
        ["@media (min-width: 1px) {._c7fgUl2yyRiBe2R{color:red;}}"],
        2,
        1,
        1,
        [
          ("ctx", "gUl2yy", "ctx\\0& | @media(min-width:1px) | "),
          (
            "value",
            "RiBe2R",
            "val\\07f\\0& | @media(min-width:1px) | \\0color:red",
          ),
        ],
      ),
      (
        "_c9fwxxZ2FUpRjpw",
        [
          "@media (min-width: 1px) {@supports (display: grid) {._c9fwxxZ2FUpRjpw{display:grid;}}}",
        ],
        2,
        2,
        1,
        [
          (
            "ctx",
            "wxxZ2F",
            "ctx\\0& | @media(min-width:1px) | @supports(display:grid) | ",
          ),
          (
            "value",
            "UpRjpw",
            "val\\09f\\0& | @media(min-width:1px) | @supports(display:grid) | \\0display:grid",
          ),
        ],
      ),
      (
        "_c7fzJxB8ia5C4Rv",
        ["@container (min-width: 2px) {._c7fzJxB8ia5C4Rv:hover{color:red;}}"],
        2,
        2,
        1,
        [
          ("ctx", "zJxB8i", "ctx\\0&:hover | @container(min-width:2px) | "),
          (
            "value",
            "a5C4Rv",
            "val\\07f\\0&:hover | @container(min-width:2px) | \\0color:red",
          ),
        ],
      ),
      (
        "_c7fMdiDWpf-GboN",
        ["@media (min-width: 1px) {._c7fMdiDWpf-GboN:hover{color:red;}}"],
        2,
        2,
        1,
        [
          ("ctx", "MdiDWp", "ctx\\0&:hover | @media(min-width:1px) | "),
          (
            "value",
            "f-GboN",
            "val\\07f\\0&:hover | @media(min-width:1px) | \\0color:red",
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
      ("Input.media", "_izkc6_vNx _c7fgUl2yyRiBe2R", "_izkc6_vNx"),
      ("Input.nested", "_iQIM0ep0T _c9fwxxZ2FUpRjpw", "_iQIM0ep0T"),
      ("Input.swapped", "_iKEQcokpo _c9fwxxZ2FUpRjpw", "_iKEQcokpo"),
      ("Input.container", "_i5xwEIDfv _c7fzJxB8ia5C4Rv", "_i5xwEIDfv"),
      ("Input.inHover", "_iCnRzBOWl _c7fMdiDWpf-GboN", "_iCnRzBOWl"),
    ]
  ];
  let media = CSS.make("cx-media _izkc6_vNx _c7fgUl2yyRiBe2R", []);
  let nested = CSS.make("cx-nested _iQIM0ep0T _c9fwxxZ2FUpRjpw", []);
  let swapped = CSS.make("cx-swapped _iKEQcokpo _c9fwxxZ2FUpRjpw", []);
  let container = CSS.make("cx-container _i5xwEIDfv _c7fzJxB8ia5C4Rv", []);
  let inHover = CSS.make("cx-inHover _iCnRzBOWl _c7fMdiDWpf-GboN", []);

Production:

  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_c7fgUl2yyRiBe2R",
        ["@media (min-width: 1px) {._c7fgUl2yyRiBe2R{color:red;}}"],
        2,
        1,
        1,
        [
          ("ctx", "gUl2yy", "ctx\\0& | @media(min-width:1px) | "),
          (
            "value",
            "RiBe2R",
            "val\\07f\\0& | @media(min-width:1px) | \\0color:red",
          ),
        ],
      ),
      (
        "_c9fwxxZ2FUpRjpw",
        [
          "@media (min-width: 1px) {@supports (display: grid) {._c9fwxxZ2FUpRjpw{display:grid;}}}",
        ],
        2,
        2,
        1,
        [
          (
            "ctx",
            "wxxZ2F",
            "ctx\\0& | @media(min-width:1px) | @supports(display:grid) | ",
          ),
          (
            "value",
            "UpRjpw",
            "val\\09f\\0& | @media(min-width:1px) | @supports(display:grid) | \\0display:grid",
          ),
        ],
      ),
      (
        "_c7fzJxB8ia5C4Rv",
        ["@container (min-width: 2px) {._c7fzJxB8ia5C4Rv:hover{color:red;}}"],
        2,
        2,
        1,
        [
          ("ctx", "zJxB8i", "ctx\\0&:hover | @container(min-width:2px) | "),
          (
            "value",
            "a5C4Rv",
            "val\\07f\\0&:hover | @container(min-width:2px) | \\0color:red",
          ),
        ],
      ),
      (
        "_c7fMdiDWpf-GboN",
        ["@media (min-width: 1px) {._c7fMdiDWpf-GboN:hover{color:red;}}"],
        2,
        2,
        1,
        [
          ("ctx", "MdiDWp", "ctx\\0&:hover | @media(min-width:1px) | "),
          (
            "value",
            "f-GboN",
            "val\\07f\\0&:hover | @media(min-width:1px) | \\0color:red",
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
      ("Input.media", "_izkc6_vNx _c7fgUl2yyRiBe2R", "_izkc6_vNx"),
      ("Input.nested", "_iQIM0ep0T _c9fwxxZ2FUpRjpw", "_iQIM0ep0T"),
      ("Input.swapped", "_iKEQcokpo _c9fwxxZ2FUpRjpw", "_iKEQcokpo"),
      ("Input.container", "_i5xwEIDfv _c7fzJxB8ia5C4Rv", "_i5xwEIDfv"),
      ("Input.inHover", "_iCnRzBOWl _c7fMdiDWpf-GboN", "_iCnRzBOWl"),
    ]
  ];
  let media = CSS.make("_izkc6_vNx _c7fgUl2yyRiBe2R", []);
  let nested = CSS.make("_iQIM0ep0T _c9fwxxZ2FUpRjpw", []);
  let swapped = CSS.make("_iKEQcokpo _c9fwxxZ2FUpRjpw", []);
  let container = CSS.make("_i5xwEIDfv _c7fzJxB8ia5C4Rv", []);
  let inHover = CSS.make("_iCnRzBOWl _c7fMdiDWpf-GboN", []);
