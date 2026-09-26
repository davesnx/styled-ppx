Safe look-alikes for the subtree-escaping guard still extract their
interpolation as a custom property (subject is `&` or a descendant of `&`).

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --color-17hzlne{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-4fgdvo{syntax:\"*\";inherits:false;}"];
  [@css ".a-5wdc34ej70v + .a-5wdc34ej70v{color:var(--color-17hzlne);}"];
  [@css ".x + .a-6ve1u4e01uz{color:var(--color-4fgdvo);}"];
  [@css ".a-xbwf14eel0e > * + *{color:var(--color-tqid89);}"];
  [@css ".a-s19nz3hef5ydxg .child{border-color:var(--color-133cflr);}"];
  [@css ".a-fxps84eoqj4 + .x{color:red;}"];
  [@css.bindings
    [
      ("Output.selfSibling", "id-vk9hpa", "a-5wdc34ej70v"),
      ("Output.siblingBeforeAmpersand", "id-fsi55f", "a-6ve1u4e01uz"),
      ("Output.childThenSibling", "id-1er3nso", "a-xbwf14eel0e"),
      ("Output.descendant", "id-1g3dzrb", "a-s19nz3hef5ydxg"),
      ("Output.literalSibling", "id-njk8sz", "a-fxps84eoqj4"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let selfSibling =
    CSS.make(
      "label:selfSibling id-vk9hpa a-5wdc34ej70v",
      [("--color-17hzlne", CSS.Types.Color.toString(color))],
    );
  let siblingBeforeAmpersand =
    CSS.make(
      "label:siblingBeforeAmpersand id-fsi55f a-6ve1u4e01uz",
      [("--color-4fgdvo", CSS.Types.Color.toString(color))],
    );
  let childThenSibling =
    CSS.make(
      "label:childThenSibling id-1er3nso a-xbwf14eel0e",
      [("--color-tqid89", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "label:descendant id-1g3dzrb a-s19nz3hef5ydxg",
      [("--color-133cflr", CSS.Types.Color.toString(color))],
    );
  let literalSibling =
    CSS.make("label:literalSibling id-njk8sz a-fxps84eoqj4", []);
