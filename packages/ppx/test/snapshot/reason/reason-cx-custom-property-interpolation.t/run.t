Custom-property declarations in [%css] accept any string interpolation
verbatim - no Cascading.toString wrap.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --colorStr-t58soe{syntax:\"*\";inherits:false;}"];
  [@css "@property --colorStr-11d7je1{syntax:\"*\";inherits:false;}"];
  [@css "@property --plainStr-1cgr13y{syntax:\"*\";inherits:false;}"];
  [@css "@property --value-13tu4ef{syntax:\"*\";inherits:false;}"];
  [@css ".css-14o54yy{--color-link:var(--colorStr-t58soe);}"];
  [@css ".css-10nqctf{--color-link:var(--colorStr-11d7je1);}"];
  [@css ".css-10nqctf{--spacing:var(--plainStr-1cgr13y);}"];
  [@css ".css-zwwqpt{--token:var(--value-13tu4ef);}"];
  [@css.bindings
    [
      ("Output.row", "cid-z61k1z", "css-14o54yy"),
      ("Output.theme", "cid-r5u180", "css-10nqctf"),
      ("Output.dyn", "cid-soz37v", "css-zwwqpt"),
    ]
  ];
  let colorStr = CSS.Types.Color.toString(`hex("3A57FC"));
  let plainStr = "10px";
  let row =
    CSS.make(
      "cx-row cid-z61k1z css-14o54yy",
      [("--colorStr-t58soe", colorStr)],
    );
  let theme =
    CSS.make(
      "cx-theme cid-r5u180 css-10nqctf",
      [("--colorStr-11d7je1", colorStr), ("--plainStr-1cgr13y", plainStr)],
    );
  let dyn = value =>
    CSS.make("cx-dyn cid-soz37v css-zwwqpt", [("--value-13tu4ef", value)]);
