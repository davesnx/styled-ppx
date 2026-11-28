Custom-property names are keyed to the module, the block's interpolated
declarations with their selectors and at-rules, the interpolation path and
the resolved type. The two blocks below get distinct var names, so equal local interpolation names in
separately merged styles cannot overwrite each other.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --vdivhzj{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdiv4fw{syntax:\"*\";inherits:false;}"];
  [@css ".css-vdivf4z{background-color:var(--vdivhzj);}"];
  [@css ".css-vdivtr7:hover{background-color:var(--vdiv4fw);}"];
  [@css.classes
    [
      ("css-vdivf4z", 2, "Output.common", "output.ml", 3, 2, 4, 0),
      ("css-vdivtr7", 3, "Output.clickable", "output.ml", 7, 2, 10, 0),
    ]
  ];
  [@css.bindings [("Output.common", ""), ("Output.clickable", "")]];
  let common = backgroundColor =>
    CSS.make(
      "css-vdivf4z",
      [("--vdivhzj", CSS.Types.Color.toString(backgroundColor))],
    );
  let clickable = backgroundColor =>
    CSS.make(
      "css-vdivtr7",
      [("--vdiv4fw", CSS.Types.Color.toString(backgroundColor))],
    );
