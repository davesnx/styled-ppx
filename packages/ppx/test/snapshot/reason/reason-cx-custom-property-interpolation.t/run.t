Custom-property declarations in [%css] accept any string interpolation
verbatim - no Cascading.toString wrap.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --colorStr-t58soe{syntax:\"*\";inherits:false;}"];
  [@css "@property --colorStr-11d7je1{syntax:\"*\";inherits:false;}"];
  [@css "@property --plainStr-1cgr13y{syntax:\"*\";inherits:false;}"];
  [@css "@property --value-13tu4ef{syntax:\"*\";inherits:false;}"];
  [@css ".in-14o54yy{--color-link:var(--colorStr-t58soe);}"];
  [@css ".in-10nqctf{--color-link:var(--colorStr-11d7je1);}"];
  [@css ".in-10nqctf{--spacing:var(--plainStr-1cgr13y);}"];
  [@css ".in-zwwqpt{--token:var(--value-13tu4ef);}"];
  [@css.bindings
    [
      ("Output.row", "id-z61k1z", "in-14o54yy"),
      ("Output.theme", "id-r5u180", "in-10nqctf"),
      ("Output.dyn", "id-soz37v", "in-zwwqpt"),
    ]
  ];
  let colorStr = CSS.Types.Color.toString(`hex("3A57FC"));
  let plainStr = "10px";
  let row =
    CSS.make(
      "label:row id-z61k1z in-14o54yy",
      [("--colorStr-t58soe", colorStr)],
    );
  let theme =
    CSS.make(
      "label:theme id-r5u180 in-10nqctf",
      [("--colorStr-11d7je1", colorStr), ("--plainStr-1cgr13y", plainStr)],
    );
  let dyn = value =>
    CSS.make("label:dyn id-soz37v in-zwwqpt", [("--value-13tu4ef", value)]);
