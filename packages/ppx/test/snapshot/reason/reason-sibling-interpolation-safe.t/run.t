Safe look-alikes for the subtree-escaping guard still extract their
interpolation as a custom property (subject is `&` or a descendant of `&`).

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --38mqd8-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1og75wj-0{syntax:\"*\";inherits:false;}"];
  [@css ".css-38mqd8 + .css-38mqd8{color:var(--38mqd8-0);}"];
  [@css ".x + .css-1og75wj{color:var(--1og75wj-0);}"];
  [@css ".css-1388yqi > * + *{color:var(--1388yqi-0);}"];
  [@css ".css-7q78lg .child{border-color:var(--7q78lg-0);}"];
  [@css ".css-fj3u6w + .x{color:red;}"];
  [@css.classes
    [
      ("css-38mqd8", 2, "Output.selfSibling", "output.ml", 3, 2, 6, 0),
      (
        "css-1og75wj",
        3,
        "Output.siblingBeforeAmpersand",
        "output.ml",
        8,
        2,
        11,
        0,
      ),
      ("css-1388yqi", 4, "Output.childThenSibling", "output.ml", 13, 2, 16, 0),
      ("css-7q78lg", 5, "Output.descendant", "output.ml", 18, 2, 21, 0),
      ("css-fj3u6w", 6, "Output.literalSibling", "output.ml", 23, 2, 26, 0),
    ]
  ];
  [@css.bindings
    [
      ("Output.selfSibling", "css-38mqd8"),
      ("Output.siblingBeforeAmpersand", "css-1og75wj"),
      ("Output.childThenSibling", "css-1388yqi"),
      ("Output.descendant", "css-7q78lg"),
      ("Output.literalSibling", "css-fj3u6w"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let selfSibling =
    CSS.make(
      "css-38mqd8",
      [("--38mqd8-0", CSS.Types.Color.toString(color))],
    );
  let siblingBeforeAmpersand =
    CSS.make(
      "css-1og75wj",
      [("--1og75wj-0", CSS.Types.Color.toString(color))],
    );
  let childThenSibling =
    CSS.make(
      "css-1388yqi",
      [("--1388yqi-0", CSS.Types.Color.toString(color))],
    );
  let descendant =
    CSS.make(
      "css-7q78lg",
      [("--7q78lg-0", CSS.Types.Color.toString(color))],
    );
  let literalSibling = CSS.make("css-fj3u6w", []);
