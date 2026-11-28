Interpolations in a block: the block has one var per (source path, runtime
type), shared by its base, :hover and @media rules. Two blocks of one module
share a var when their interpolated declarations, with their selectors and
at-rules, are the same (the last two blocks), as on main.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --vdiv3ty{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdiv1p6{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivni8{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivid8{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivxz4{syntax:\"*\";inherits:false;}"];
  [@css
    ".css-vdivf2y{color:var(--vdiv3ty);}.css-vdivf2y:hover{color:var(--vdiv3ty);}@media (max-width: 768px) {.css-vdivf2y{color:var(--vdiv3ty);}}"
  ];
  [@css
    ".css-vdiv05j{display:flex;color:var(--vdiv1p6);}.css-vdiv05j:hover{color:var(--vdiv1p6);}"
  ];
  [@css
    ".css-vdivlev{width:var(--vdivni8);}.css-vdivlev:hover{height:var(--vdivid8);}"
  ];
  [@css ".css-vdivsdn{color:red;}.css-vdivsdn:hover{color:var(--vdivxz4);}"];
  [@css ".css-vdivfyz{display:flex;}.css-vdivfyz:hover{color:var(--vdivxz4);}"];
  [@css.classes
    [
      ("css-vdivf2y", 5, "Output.multiVariant", "output.ml", 6, 2, 13, 0),
      ("css-vdiv05j", 6, "Output.mixed", "output.ml", 17, 2, 22, 0),
      ("css-vdivlev", 7, "Output.twoTypes", "output.ml", 25, 2, 29, 0),
      ("css-vdivsdn", 8, "", "output.ml", 31, 2, 35, 0),
      ("css-vdivfyz", 9, "", "output.ml", 37, 2, 41, 0),
    ]
  ];
  [@css.bindings
    [
      ("Output.multiVariant", "css-vdivf2y"),
      ("Output.mixed", "css-vdiv05j"),
      ("Output.twoTypes", "css-vdivlev"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let width = CSS.px(10);
  let multiVariant =
    CSS.make(
      "css-vdivf2y",
      [("--vdiv3ty", CSS.Types.Color.toString(color))],
    );
  let mixed =
    CSS.make(
      "css-vdiv05j",
      [("--vdiv1p6", CSS.Types.Color.toString(color))],
    );
  let twoTypes =
    CSS.make(
      "css-vdivlev",
      [
        ("--vdivni8", CSS.Types.Width.toString(width)),
        ("--vdivid8", CSS.Types.Height.toString(width)),
      ],
    );
  let _ =
    CSS.make(
      "css-vdivsdn",
      [("--vdivxz4", CSS.Types.Color.toString(color))],
    );
  let _ =
    CSS.make(
      "css-vdivfyz",
      [("--vdivxz4", CSS.Types.Color.toString(color))],
    );
