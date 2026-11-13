Interpolations in a block: the block has one var per (source path, runtime
type), shared by its base, :hover and @media rules. Two blocks never share a
var, even when their content is the same.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --1v9ec18-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1u0hfy5-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --ebxfmk-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --ebxfmk-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --tjkd77-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --iwfz8l-0{syntax:\"*\";inherits:false;}"];
  [@css
    ".css-1v9ec18{color:var(--1v9ec18-0);}.css-1v9ec18:hover{color:var(--1v9ec18-0);}@media (max-width: 768px) {.css-1v9ec18{color:var(--1v9ec18-0);}}"
  ];
  [@css
    ".css-1u0hfy5{display:flex;color:var(--1u0hfy5-0);}.css-1u0hfy5:hover{color:var(--1u0hfy5-0);}"
  ];
  [@css
    ".css-ebxfmk{width:var(--ebxfmk-0);}.css-ebxfmk:hover{height:var(--ebxfmk-1);}"
  ];
  [@css ".css-tjkd77{color:red;}.css-tjkd77:hover{color:var(--tjkd77-0);}"];
  [@css ".css-iwfz8l{display:flex;}.css-iwfz8l:hover{color:var(--iwfz8l-0);}"];
  [@css.classes
    [
      ("css-1v9ec18", 6, "Output.multiVariant", "output.ml", 6, 2, 13, 0),
      ("css-1u0hfy5", 7, "Output.mixed", "output.ml", 17, 2, 22, 0),
      ("css-ebxfmk", 8, "Output.twoTypes", "output.ml", 25, 2, 29, 0),
      ("css-tjkd77", 9, "", "output.ml", 31, 2, 35, 0),
      ("css-iwfz8l", 10, "", "output.ml", 37, 2, 41, 0),
    ]
  ];
  [@css.bindings
    [
      ("Output.multiVariant", "css-1v9ec18"),
      ("Output.mixed", "css-1u0hfy5"),
      ("Output.twoTypes", "css-ebxfmk"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let width = CSS.px(10);
  let multiVariant =
    CSS.make(
      "css-1v9ec18",
      [("--1v9ec18-0", CSS.Types.Color.toString(color))],
    );
  let mixed =
    CSS.make(
      "css-1u0hfy5",
      [("--1u0hfy5-0", CSS.Types.Color.toString(color))],
    );
  let twoTypes =
    CSS.make(
      "css-ebxfmk",
      [
        ("--ebxfmk-0", CSS.Types.Width.toString(width)),
        ("--ebxfmk-1", CSS.Types.Height.toString(width)),
      ],
    );
  let _ =
    CSS.make(
      "css-tjkd77",
      [("--tjkd77-0", CSS.Types.Color.toString(color))],
    );
  let _ =
    CSS.make(
      "css-iwfz8l",
      [("--iwfz8l-0", CSS.Types.Color.toString(color))],
    );
