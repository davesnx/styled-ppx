Shape 4: a nested selector is one atom with its own context. Trailing pseudo-classes in either order share a context.

  $ refmt --parse re --print ml input.re > input.ml

Development:

  $ ../../standalone.exe --env development --impl input.ml -o dev.ml
  $ refmt --parse ml --print re dev.ml
  [@css.atoms
    [
      (
        "_c7f1Tl5-wvpMs6j",
        ["._c7f1Tl5-wvpMs6j:hover{color:red;}"],
        2,
        1,
        1,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          ("value", "vpMs6j", "val\\07f\\0&:hover | \\0color:red"),
        ],
      ),
      (
        "_c8ikfHr5ByYzYTg",
        ["._c8ikfHr5ByYzYTg::after{content:\"x\";}"],
        2,
        1,
        1,
        [
          ("ctx", "kfHr5B", "ctx\\0&::after | "),
          ("value", "yYzYTg", "val\\08i\\0&::after | \\0content:\"x\""),
        ],
      ),
      (
        "_c7f-QfSkE1JM33Y",
        ["._c7f-QfSkE1JM33Y:hover:focus{color:red;}"],
        2,
        1,
        1,
        [
          ("ctx", "-QfSkE", "ctx\\0&:focus:hover | "),
          ("value", "1JM33Y", "val\\07f\\0&:focus:hover | \\0color:red"),
        ],
      ),
      (
        "_i-gYBYMwr",
        [],
        1,
        0,
        0,
        [("id", "_i-gYBYMwr", "bind\\0\\0Input\\0\\0hover\\00")],
      ),
      (
        "_iVeDmRf6y",
        [],
        1,
        0,
        0,
        [("id", "_iVeDmRf6y", "bind\\0\\0Input\\0\\0after\\00")],
      ),
      (
        "_id9vBJW1G",
        [],
        1,
        0,
        0,
        [("id", "_id9vBJW1G", "bind\\0\\0Input\\0\\0hoverFocus\\00")],
      ),
      (
        "_iDe1Sh2EU",
        [],
        1,
        0,
        0,
        [("id", "_iDe1Sh2EU", "bind\\0\\0Input\\0\\0focusHover\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.hover", "_i-gYBYMwr _c7f1Tl5-wvpMs6j", "_i-gYBYMwr"),
      ("Input.after", "_iVeDmRf6y _c8ikfHr5ByYzYTg", "_iVeDmRf6y"),
      ("Input.hoverFocus", "_id9vBJW1G _c7f-QfSkE1JM33Y", "_id9vBJW1G"),
      ("Input.focusHover", "_iDe1Sh2EU _c7f-QfSkE1JM33Y", "_iDe1Sh2EU"),
    ]
  ];
  let hover = CSS.make("cx-hover _i-gYBYMwr _c7f1Tl5-wvpMs6j", []);
  let after = CSS.make("cx-after _iVeDmRf6y _c8ikfHr5ByYzYTg", []);
  let hoverFocus = CSS.make("cx-hoverFocus _id9vBJW1G _c7f-QfSkE1JM33Y", []);
  let focusHover = CSS.make("cx-focusHover _iDe1Sh2EU _c7f-QfSkE1JM33Y", []);

Production:

  $ ../../standalone.exe --env production --impl input.ml -o prod.ml
  $ refmt --parse ml --print re prod.ml
  [@css.config [("env", "production")]];
  [@css.atoms
    [
      (
        "_c7f1Tl5-wvpMs6j",
        ["._c7f1Tl5-wvpMs6j:hover{color:red;}"],
        2,
        1,
        1,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          ("value", "vpMs6j", "val\\07f\\0&:hover | \\0color:red"),
        ],
      ),
      (
        "_c8ikfHr5ByYzYTg",
        ["._c8ikfHr5ByYzYTg::after{content:\"x\";}"],
        2,
        1,
        1,
        [
          ("ctx", "kfHr5B", "ctx\\0&::after | "),
          ("value", "yYzYTg", "val\\08i\\0&::after | \\0content:\"x\""),
        ],
      ),
      (
        "_c7f-QfSkE1JM33Y",
        ["._c7f-QfSkE1JM33Y:hover:focus{color:red;}"],
        2,
        1,
        1,
        [
          ("ctx", "-QfSkE", "ctx\\0&:focus:hover | "),
          ("value", "1JM33Y", "val\\07f\\0&:focus:hover | \\0color:red"),
        ],
      ),
      (
        "_i-gYBYMwr",
        [],
        1,
        0,
        0,
        [("id", "_i-gYBYMwr", "bind\\0\\0Input\\0\\0hover\\00")],
      ),
      (
        "_iVeDmRf6y",
        [],
        1,
        0,
        0,
        [("id", "_iVeDmRf6y", "bind\\0\\0Input\\0\\0after\\00")],
      ),
      (
        "_id9vBJW1G",
        [],
        1,
        0,
        0,
        [("id", "_id9vBJW1G", "bind\\0\\0Input\\0\\0hoverFocus\\00")],
      ),
      (
        "_iDe1Sh2EU",
        [],
        1,
        0,
        0,
        [("id", "_iDe1Sh2EU", "bind\\0\\0Input\\0\\0focusHover\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.hover", "_i-gYBYMwr _c7f1Tl5-wvpMs6j", "_i-gYBYMwr"),
      ("Input.after", "_iVeDmRf6y _c8ikfHr5ByYzYTg", "_iVeDmRf6y"),
      ("Input.hoverFocus", "_id9vBJW1G _c7f-QfSkE1JM33Y", "_id9vBJW1G"),
      ("Input.focusHover", "_iDe1Sh2EU _c7f-QfSkE1JM33Y", "_iDe1Sh2EU"),
    ]
  ];
  let hover = CSS.make("_i-gYBYMwr _c7f1Tl5-wvpMs6j", []);
  let after = CSS.make("_iVeDmRf6y _c8ikfHr5ByYzYTg", []);
  let hoverFocus = CSS.make("_id9vBJW1G _c7f-QfSkE1JM33Y", []);
  let focusHover = CSS.make("_iDe1Sh2EU _c7f-QfSkE1JM33Y", []);
