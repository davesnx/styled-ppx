Safe look-alikes for the subtree-escaping guard still extract their
interpolation as a custom property (subject is `&` or a descendant of `&`).

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --color-17hzlne{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-4fgdvo{syntax:\"*\";inherits:false;}"];
  [@css ".csv-3pj70v + .csv-3pj70v{color:var(--color-17hzlne);}"];
  [@css ".x + .csv-c001uz{color:var(--color-4fgdvo);}"];
  [@css ".csv-zcel0e > * + *{color:var(--color-tqid89);}"];
  [@css ".csv-v0ydxg .child{border-color:var(--color-133cflr);}"];
  [@css ".css-1w5oqj4 + .x{color:red;}"];
  [@css.bindings
    [
      ("Output.selfSibling", "cid-vk9hpa", "csv-3pj70v"),
      ("Output.siblingBeforeAmpersand", "cid-fsi55f", "csv-c001uz"),
      ("Output.childThenSibling", "cid-1er3nso", "csv-zcel0e"),
      ("Output.descendant", "cid-1g3dzrb", "csv-v0ydxg"),
      ("Output.literalSibling", "cid-njk8sz", "css-1w5oqj4"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let selfSibling =
    CSS.make(
      "label:selfSibling cid-vk9hpa csv-3pj70v",
      [("--color-17hzlne", CSS.Types.Color.toString(color))],
    );
  let siblingBeforeAmpersand =
    CSS.make(
      "label:siblingBeforeAmpersand cid-fsi55f csv-c001uz",
      [("--color-4fgdvo", CSS.Types.Color.toString(color))],
    );
  let childThenSibling =
    CSS.make(
      "label:childThenSibling cid-1er3nso csv-zcel0e",
      [("--color-tqid89", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "label:descendant cid-1g3dzrb csv-v0ydxg",
      [("--color-133cflr", CSS.Types.Color.toString(color))],
    );
  let literalSibling =
    CSS.make("label:literalSibling cid-njk8sz css-1w5oqj4", []);
