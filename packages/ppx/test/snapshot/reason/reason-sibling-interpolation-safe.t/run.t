Safe look-alikes for the subtree-escaping guard still extract their
interpolation as a custom property (subject is `&` or a descendant of `&`).

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --color-17hzlne{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-4fgdvo{syntax:\"*\";inherits:false;}"];
  [@css "._a_5wdc34ej70v + ._a_5wdc34ej70v{color:var(--color-17hzlne);}"];
  [@css ".x + ._a_6ve1u4e01uz{color:var(--color-4fgdvo);}"];
  [@css "._a_xbwf14eel0e > * + *{color:var(--color-tqid89);}"];
  [@css "._a_s19nz3h0ef5ydxg .child{border-color:var(--color-133cflr);}"];
  [@css "._a_fxps84eoqj4 + .x{color:red;}"];
  [@css.bindings
    [
      ("Output.selfSibling", "_id_1ke2p97", "_a_5wdc34ej70v"),
      ("Output.siblingBeforeAmpersand", "_id_15gdsde", "_a_6ve1u4e01uz"),
      ("Output.childThenSibling", "_id_u6wxmw", "_a_xbwf14eel0e"),
      ("Output.descendant", "_id_1rit82z", "_a_s19nz3h0ef5ydxg"),
      ("Output.literalSibling", "_id_pag48b", "_a_fxps84eoqj4"),
    ]
  ];
  [@css.blocks
    [
      (2, "_id_1ke2p97 _a_5wdc34ej70v"),
      (7, "_id_15gdsde _a_6ve1u4e01uz"),
      (12, "_id_u6wxmw _a_xbwf14eel0e"),
      (17, "_id_1rit82z _a_s19nz3h0ef5ydxg"),
      (22, "_id_pag48b _a_fxps84eoqj4"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let selfSibling =
    CSS.make(
      "label:selfSibling _id_1ke2p97 _a_5wdc34ej70v",
      [("--color-17hzlne", CSS.Types.Color.toString(color))],
    );
  let siblingBeforeAmpersand =
    CSS.make(
      "label:siblingBeforeAmpersand _id_15gdsde _a_6ve1u4e01uz",
      [("--color-4fgdvo", CSS.Types.Color.toString(color))],
    );
  let childThenSibling =
    CSS.make(
      "label:childThenSibling _id_u6wxmw _a_xbwf14eel0e",
      [("--color-tqid89", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "label:descendant _id_1rit82z _a_s19nz3h0ef5ydxg",
      [("--color-133cflr", CSS.Types.Color.toString(color))],
    );
  let literalSibling =
    CSS.make("label:literalSibling _id_pag48b _a_fxps84eoqj4", []);
