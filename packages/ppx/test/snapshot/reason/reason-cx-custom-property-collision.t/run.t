Custom-property names are scoped to the owning [%css] expression and runtime
type, so equal local interpolation names in separately merged styles cannot
overwrite each other.

  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-160vrad-common{background-color:var(--var-ov3le6);}"];
  [@css ".css-10a6meq-clickable:hover{background-color:var(--var-7yjmr3);}"];
  [@css.bindings
    [
      ("Output.common", "css-160vrad-common"),
      ("Output.clickable", "css-10a6meq-clickable"),
    ]
  ];
  let common = backgroundColor =>
    CSS.make(
      "css-160vrad-common",
      [("--var-ov3le6", CSS.Types.Color.toString(backgroundColor))],
    );
  let clickable = backgroundColor =>
    CSS.make(
      "css-10a6meq-clickable",
      [("--var-7yjmr3", CSS.Types.Color.toString(backgroundColor))],
    );
