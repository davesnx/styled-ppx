Custom-property names are keyed to atom declaration content (selector context +
property + resolved type), not to the owning [%css] expression. Two atoms
collide or share the same generated var only when their declaration content is
identical; the two atoms below differ in selector context (top-level vs :hover),
so they get distinct var names and equal local interpolation names in separately
merged styles cannot overwrite each other.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --backgroundColor-z3f4ba{syntax:\"*\";inherits:false;}"];
  [@css "@property --backgroundColor-1iwsayc{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_a4lsOeNzD",
        ["._a4lsOeNzD{background-color:var(--backgroundColor-z3f4ba);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "sOeNzD",
            "val\\04l\\0& | \\0background-color:$(backgroundColor)",
          ),
        ],
      ),
      (
        "_c4l1Tl5-wOl_MVX",
        [
          "._c4l1Tl5-wOl_MVX:hover{background-color:var(--backgroundColor-1iwsayc);}",
        ],
        2,
        1,
        1,
        [
          ("ctx", "1Tl5-w", "ctx\\0&:hover | "),
          (
            "value",
            "Ol_MVX",
            "val\\04l\\0&:hover | \\0background-color:$(backgroundColor)",
          ),
        ],
      ),
      (
        "_iyPgGBH2V",
        [],
        1,
        0,
        0,
        [("id", "_iyPgGBH2V", "bind\\0\\0Output\\0\\0common\\00")],
      ),
      (
        "_iMDXdfI31",
        [],
        1,
        0,
        0,
        [("id", "_iMDXdfI31", "bind\\0\\0Output\\0\\0clickable\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Output.common", "_iyPgGBH2V _a4lsOeNzD", "_iyPgGBH2V"),
      ("Output.clickable", "_iMDXdfI31 _c4l1Tl5-wOl_MVX", "_iMDXdfI31"),
    ]
  ];
  let common = backgroundColor =>
    CSS.make(
      "_iyPgGBH2V _a4lsOeNzD",
      [
        ("--backgroundColor-z3f4ba", CSS.Types.Color.toString(backgroundColor)),
      ],
    );
  let clickable = backgroundColor =>
    CSS.make(
      "_iMDXdfI31 _c4l1Tl5-wOl_MVX",
      [
        (
          "--backgroundColor-1iwsayc",
          CSS.Types.Color.toString(backgroundColor),
        ),
      ],
    );
