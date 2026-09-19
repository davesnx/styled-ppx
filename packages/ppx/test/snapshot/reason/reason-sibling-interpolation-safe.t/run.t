Safe look-alikes for the subtree-escaping guard still extract their
interpolation as a custom property (subject is `&` or a descendant of `&`).

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --color-17hzlne{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-4fgdvo{syntax:\"*\";inherits:false;}"];
  [@css
    ".css-3pj70v-selfSibling + .css-3pj70v-selfSibling{color:var(--color-17hzlne);}"
  ];
  [@css ".x + .css-c001uz-siblingBeforeAmpersand{color:var(--color-4fgdvo);}"];
  [@css ".css-zcel0e-childThenSibling > * + *{color:var(--color-tqid89);}"];
  [@css ".css-v0ydxg-descendant .child{border-color:var(--color-133cflr);}"];
  [@css ".css-1w5oqj4-literalSibling + .x{color:red;}"];
  [@css.bindings
    [
      ("Output.selfSibling", "cid-vk9hpa", "css-3pj70v-selfSibling"),
      (
        "Output.siblingBeforeAmpersand",
        "cid-fsi55f",
        "css-c001uz-siblingBeforeAmpersand",
      ),
      ("Output.childThenSibling", "cid-1er3nso", "css-zcel0e-childThenSibling"),
      ("Output.descendant", "cid-1g3dzrb", "css-v0ydxg-descendant"),
      ("Output.literalSibling", "cid-njk8sz", "css-1w5oqj4-literalSibling"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let selfSibling =
    CSS.make(
      "cid-vk9hpa css-3pj70v-selfSibling",
      [("--color-17hzlne", CSS.Types.Color.toString(color))],
    );
  let siblingBeforeAmpersand =
    CSS.make(
      "cid-fsi55f css-c001uz-siblingBeforeAmpersand",
      [("--color-4fgdvo", CSS.Types.Color.toString(color))],
    );
  let childThenSibling =
    CSS.make(
      "cid-1er3nso css-zcel0e-childThenSibling",
      [("--color-tqid89", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "cid-1g3dzrb css-v0ydxg-descendant",
      [("--color-133cflr", CSS.Types.Color.toString(color))],
    );
  let literalSibling = CSS.make("cid-njk8sz css-1w5oqj4-literalSibling", []);
