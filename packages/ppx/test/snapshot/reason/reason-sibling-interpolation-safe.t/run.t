Safe look-alikes for the subtree-escaping guard still extract their
interpolation as a custom property (subject is `&` or a descendant of `&`).

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --color-1kscdr{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-1sq79ge{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_c7f90BSi4GDd8Ba",
        [
          "._c7f90BSi4GDd8Ba._i9ny0-MqX + ._c7f90BSi4GDd8Ba._i9ny0-MqX{color:var(--color-1kscdr);}",
        ],
        0,
        1,
        1,
        [
          ("ctx", "90BSi4", "ctx\\0& + & | "),
          (
            "value",
            "GDd8Ba",
            "val\\07f\\0& + & | \\0color:$(color)\\0owner:_i9ny0-MqX",
          ),
        ],
      ),
      (
        "_c7fc0Atcp5w7SCV",
        [".x + ._c7fc0Atcp5w7SCV{color:var(--color-1sq79ge);}"],
        2,
        1,
        1,
        [
          ("ctx", "c0Atcp", "ctx\\0.x + & | "),
          ("value", "5w7SCV", "val\\07f\\0.x + & | \\0color:$(color)"),
        ],
      ),
      (
        "_c7fgaOpD4_wBZlV",
        ["._c7fgaOpD4_wBZlV > * + *{color:var(--color-4n1qif);}"],
        0,
        1,
        1,
        [
          ("ctx", "gaOpD4", "ctx\\0& > * + * | "),
          ("value", "_wBZlV", "val\\07f\\0& > * + * | \\0color:$(color)"),
        ],
      ),
      (
        "_c5ksFnj_7XXaSqU",
        ["._c5ksFnj_7XXaSqU .child{border-color:var(--color-17mpju5);}"],
        0,
        1,
        4,
        [
          ("ctx", "sFnj_7", "ctx\\0& .child | "),
          ("value", "XXaSqU", "val\\05k\\0& .child | \\0border-color:$(color)"),
        ],
      ),
      (
        "_c7f3Us9-0JI-o84",
        ["._c7f3Us9-0JI-o84 + .x{color:red;}"],
        0,
        1,
        1,
        [
          ("ctx", "3Us9-0", "ctx\\0& + .x | "),
          ("value", "JI-o84", "val\\07f\\0& + .x | \\0color:red"),
        ],
      ),
      (
        "_i9ny0-MqX",
        [],
        1,
        0,
        0,
        [("id", "_i9ny0-MqX", "bind\\0\\0Output\\0\\0selfSibling\\00")],
      ),
      (
        "_iUkkgy1aO",
        [],
        1,
        0,
        0,
        [
          (
            "id",
            "_iUkkgy1aO",
            "bind\\0\\0Output\\0\\0siblingBeforeAmpersand\\00",
          ),
        ],
      ),
      (
        "_iZ4GdsIN_",
        [],
        1,
        0,
        0,
        [("id", "_iZ4GdsIN_", "bind\\0\\0Output\\0\\0childThenSibling\\00")],
      ),
      (
        "_iIjlCg7wy",
        [],
        1,
        0,
        0,
        [("id", "_iIjlCg7wy", "bind\\0\\0Output\\0\\0descendant\\00")],
      ),
      (
        "_izyKagm15",
        [],
        1,
        0,
        0,
        [("id", "_izyKagm15", "bind\\0\\0Output\\0\\0literalSibling\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Output.selfSibling", "_i9ny0-MqX _c7f90BSi4GDd8Ba", "_i9ny0-MqX"),
      (
        "Output.siblingBeforeAmpersand",
        "_iUkkgy1aO _c7fc0Atcp5w7SCV",
        "_iUkkgy1aO",
      ),
      ("Output.childThenSibling", "_iZ4GdsIN_ _c7fgaOpD4_wBZlV", "_iZ4GdsIN_"),
      ("Output.descendant", "_iIjlCg7wy _c5ksFnj_7XXaSqU", "_iIjlCg7wy"),
      ("Output.literalSibling", "_izyKagm15 _c7f3Us9-0JI-o84", "_izyKagm15"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let selfSibling =
    CSS.make(
      "_i9ny0-MqX _c7f90BSi4GDd8Ba",
      [("--color-1kscdr", CSS.Types.Color.toString(color))],
    );
  let siblingBeforeAmpersand =
    CSS.make(
      "_iUkkgy1aO _c7fc0Atcp5w7SCV",
      [("--color-1sq79ge", CSS.Types.Color.toString(color))],
    );
  let childThenSibling =
    CSS.make(
      "_iZ4GdsIN_ _c7fgaOpD4_wBZlV",
      [("--color-4n1qif", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "_iIjlCg7wy _c5ksFnj_7XXaSqU",
      [("--color-17mpju5", CSS.Types.Color.toString(color))],
    );
  let literalSibling = CSS.make("_izyKagm15 _c7f3Us9-0JI-o84", []);
