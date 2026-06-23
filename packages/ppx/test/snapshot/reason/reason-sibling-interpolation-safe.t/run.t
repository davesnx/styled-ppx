Safe look-alikes for the subtree-escaping guard still extract their
interpolation as a custom property (subject is `&` or a descendant of `&`).

  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css
    ".css-3pj70v-selfSibling + .css-3pj70v-selfSibling{color:var(--color-17hzlne);}"
  ];
  [@css ".x + .css-c001uz-siblingBeforeAmpersand{color:var(--color-4fgdvo);}"];
  [@css ".css-zcel0e-childThenSibling > * + *{color:var(--color-tqid89);}"];
  [@css ".css-v0ydxg-descendant .child{border-color:var(--color-133cflr);}"];
  [@css ".css-1w5oqj4-literalSibling + .x{color:red;}"];
  [@css.bindings
    [
      ("Output.selfSibling", "css-3pj70v-selfSibling"),
      ("Output.siblingBeforeAmpersand", "css-c001uz-siblingBeforeAmpersand"),
      ("Output.childThenSibling", "css-zcel0e-childThenSibling"),
      ("Output.descendant", "css-v0ydxg-descendant"),
      ("Output.literalSibling", "css-1w5oqj4-literalSibling"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let selfSibling =
    CSS.make(
      "css-3pj70v-selfSibling",
      [("--color-17hzlne", CSS.Types.Color.toString(color))],
    );
  let siblingBeforeAmpersand =
    CSS.make(
      "css-c001uz-siblingBeforeAmpersand",
      [("--color-4fgdvo", CSS.Types.Color.toString(color))],
    );
  let childThenSibling =
    CSS.make(
      "css-zcel0e-childThenSibling",
      [("--color-tqid89", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "css-v0ydxg-descendant",
      [("--color-133cflr", CSS.Types.Color.toString(color))],
    );
  let literalSibling = CSS.make("css-1w5oqj4-literalSibling", []);
