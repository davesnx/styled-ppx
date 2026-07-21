Safe look-alikes for the subtree-escaping guard still extract their
interpolation as a custom property (subject is `&` or a descendant of `&`).

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --color-wy9lpv{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-268i9g{syntax:\"*\";inherits:false;}"];
  [@css
    ".css-1491d4z-selfSibling+.css-1491d4z-selfSibling{color:var(--color-wy9lpv)}"
  ];
  [@css ".x+.css-1xcxfhy-siblingBeforeAmpersand{color:var(--color-268i9g)}"];
  [@css ".css-f0xq1b-childThenSibling>*+*{color:var(--color-1jgfgvo)}"];
  [@css ".css-1s1l3rs-descendant .child{border-color:var(--color-v63kmg)}"];
  [@css ".css-1ljbid2-literalSibling+.x{color:red}"];
  [@css.bindings
    [
      ("Output.selfSibling", "css-1491d4z-selfSibling"),
      ("Output.siblingBeforeAmpersand", "css-1xcxfhy-siblingBeforeAmpersand"),
      ("Output.childThenSibling", "css-f0xq1b-childThenSibling"),
      ("Output.descendant", "css-1s1l3rs-descendant"),
      ("Output.literalSibling", "css-1ljbid2-literalSibling"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let selfSibling =
    CSS.make(
      "css-1491d4z-selfSibling",
      [("--color-wy9lpv", CSS.Types.Color.toString(color))],
    );
  let siblingBeforeAmpersand =
    CSS.make(
      "css-1xcxfhy-siblingBeforeAmpersand",
      [("--color-268i9g", CSS.Types.Color.toString(color))],
    );
  let childThenSibling =
    CSS.make(
      "css-f0xq1b-childThenSibling",
      [("--color-1jgfgvo", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "css-1s1l3rs-descendant",
      [("--color-v63kmg", CSS.Types.Color.toString(color))],
    );
  let literalSibling = CSS.make("css-1ljbid2-literalSibling", []);
