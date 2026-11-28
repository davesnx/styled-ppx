Custom-property declarations in [%css] accept any string interpolation
verbatim - no Cascading.toString wrap.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --vdivtdd{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdiv54z{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdiv670{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivffp{syntax:\"*\";inherits:false;}"];
  [@css ".css-vdiv0jt{--color-link:var(--vdivtdd);}"];
  [@css ".css-vdivfxx{--color-link:var(--vdiv54z);--spacing:var(--vdiv670);}"];
  [@css ".css-vdiv7aj{--token:var(--vdivffp);}"];
  [@css.classes
    [
      ("css-vdiv0jt", 4, "Output.row", "output.ml", 4, 2, 5, 0),
      ("css-vdivfxx", 5, "Output.theme", "output.ml", 8, 2, 10, 0),
      ("css-vdiv7aj", 6, "Output.dyn", "output.ml", 12, 2, 13, 0),
    ]
  ];
  [@css.bindings
    [
      ("Output.row", "css-vdiv0jt"),
      ("Output.theme", "css-vdivfxx"),
      ("Output.dyn", ""),
    ]
  ];
  let colorStr = CSS.Types.Color.toString(`hex("3A57FC"));
  let plainStr = "10px";
  let row = CSS.make("css-vdiv0jt", [("--vdivtdd", colorStr)]);
  let theme =
    CSS.make(
      "css-vdivfxx",
      [("--vdiv54z", colorStr), ("--vdiv670", plainStr)],
    );
  let dyn = value => CSS.make("css-vdiv7aj", [("--vdivffp", value)]);
