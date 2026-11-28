Safe look-alikes for the subtree-escaping guard still extract their
interpolation as a custom property (subject is `&` or a descendant of `&`).

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --vdivwdw{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivedv{syntax:\"*\";inherits:false;}"];
  [@css ".css-vdivzjo + .css-vdivzjo{color:var(--vdivwdw);}"];
  [@css ".x + .css-vdivlfd{color:var(--vdivedv);}"];
  [@css ".css-vdivqlq > * + *{color:var(--vdivkus);}"];
  [@css ".css-vdivq47 .child{border-color:var(--vdiv4u1);}"];
  [@css ".css-vdivu6w + .x{color:red;}"];
  [@css.classes
    [
      ("css-vdivzjo", 2, "Output.selfSibling", "output.ml", 3, 2, 6, 0),
      (
        "css-vdivlfd",
        3,
        "Output.siblingBeforeAmpersand",
        "output.ml",
        8,
        2,
        11,
        0,
      ),
      ("css-vdivqlq", 4, "Output.childThenSibling", "output.ml", 13, 2, 16, 0),
      ("css-vdivq47", 5, "Output.descendant", "output.ml", 18, 2, 21, 0),
      ("css-vdivu6w", 6, "Output.literalSibling", "output.ml", 23, 2, 26, 0),
    ]
  ];
  [@css.bindings
    [
      ("Output.selfSibling", "css-vdivzjo"),
      ("Output.siblingBeforeAmpersand", "css-vdivlfd"),
      ("Output.childThenSibling", "css-vdivqlq"),
      ("Output.descendant", "css-vdivq47"),
      ("Output.literalSibling", "css-vdivu6w"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let selfSibling =
    CSS.make(
      "css-vdivzjo",
      [("--vdivwdw", CSS.Types.Color.toString(color))],
    );
  let siblingBeforeAmpersand =
    CSS.make(
      "css-vdivlfd",
      [("--vdivedv", CSS.Types.Color.toString(color))],
    );
  let childThenSibling =
    CSS.make(
      "css-vdivqlq",
      [("--vdivkus", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "css-vdivq47",
      [("--vdiv4u1", CSS.Types.Color.toString(color))],
    );
  let literalSibling = CSS.make("css-vdivu6w", []);
