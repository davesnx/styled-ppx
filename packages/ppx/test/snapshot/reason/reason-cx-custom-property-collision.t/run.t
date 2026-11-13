Custom-property names are keyed to the owning [%css] block (its class: module,
scope, binding, content) plus the interpolation path and resolved type. The
two blocks below get distinct var names, so equal local interpolation names in
separately merged styles cannot overwrite each other.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --14b42r2-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --zfnpzf-0{syntax:\"*\";inherits:false;}"];
  [@css ".css-14b42r2{background-color:var(--14b42r2-0);}"];
  [@css ".css-zfnpzf:hover{background-color:var(--zfnpzf-0);}"];
  [@css.classes
    [
      ("css-14b42r2", 2, "Output.common", "output.ml", 3, 2, 4, 0),
      ("css-zfnpzf", 3, "Output.clickable", "output.ml", 7, 2, 10, 0),
    ]
  ];
  [@css.bindings [("Output.common", ""), ("Output.clickable", "")]];
  let common = backgroundColor =>
    CSS.make(
      "css-14b42r2",
      [("--14b42r2-0", CSS.Types.Color.toString(backgroundColor))],
    );
  let clickable = backgroundColor =>
    CSS.make(
      "css-zfnpzf",
      [("--zfnpzf-0", CSS.Types.Color.toString(backgroundColor))],
    );
