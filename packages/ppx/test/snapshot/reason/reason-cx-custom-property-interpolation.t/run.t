Custom-property declarations in [%css] accept any string interpolation
verbatim - no Cascading.toString wrap.

  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-14o54yy-row{--color-link:var(--var-t58soe);}"];
  [@css ".css-14o54yy-theme{--color-link:var(--var-t58soe);}"];
  [@css ".css-1l1kohh-theme{--spacing:var(--var-vbhzka);}"];
  [@css ".css-zwwqpt-dyn{--token:var(--var-13tu4ef);}"];
  [@css.bindings
    [
      ("Output.row", "css-14o54yy-row"),
      ("Output.theme", "css-14o54yy-theme css-1l1kohh-theme"),
      ("Output.dyn", "css-zwwqpt-dyn"),
    ]
  ];
  let colorStr = CSS.Types.Color.toString(`hex("3A57FC"));
  let plainStr = "10px";
  let row = CSS.make("css-14o54yy-row", [("--var-t58soe", colorStr)]);
  let theme =
    CSS.make(
      "css-14o54yy-theme css-1l1kohh-theme",
      [("--var-t58soe", colorStr), ("--var-vbhzka", plainStr)],
    );
  let dyn = value => CSS.make("css-zwwqpt-dyn", [("--var-13tu4ef", value)]);
