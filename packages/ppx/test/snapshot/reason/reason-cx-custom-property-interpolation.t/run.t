Custom-property declarations in [%css] accept any string interpolation
verbatim - no Cascading.toString wrap.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --colorStr-t58soe{syntax:\"*\";inherits:false;}"];
  [@css "@property --plainStr-vbhzka{syntax:\"*\";inherits:false;}"];
  [@css "@property --value-13tu4ef{syntax:\"*\";inherits:false;}"];
  [@css "._a_zy7gz1zq54yy{--color-link:var(--colorStr-t58soe);}"];
  [@css "._a_zy4gc55zkohh{--spacing:var(--plainStr-vbhzka);}"];
  [@css "._a_zyqed1fpwqpt{--token:var(--value-13tu4ef);}"];
  [@css.bindings
    [
      ("Output.row", "_id_z61k1z", "_a_zy7gz1zq54yy"),
      ("Output.theme", "_id_r5u180", "_a_zy7gz1zq54yy _a_zy4gc55zkohh"),
      ("Output.dyn", "_id_soz37v", "_a_zyqed1fpwqpt"),
    ]
  ];
  let colorStr = CSS.Types.Color.toString(`hex("3A57FC"));
  let plainStr = "10px";
  let row =
    CSS.make(
      "label:row _id_z61k1z _a_zy7gz1zq54yy",
      [("--colorStr-t58soe", colorStr)],
    );
  let theme =
    CSS.make(
      "label:theme _id_r5u180 _a_zy7gz1zq54yy _a_zy4gc55zkohh",
      [("--colorStr-t58soe", colorStr), ("--plainStr-vbhzka", plainStr)],
    );
  let dyn = value =>
    CSS.make(
      "label:dyn _id_soz37v _a_zyqed1fpwqpt",
      [("--value-13tu4ef", value)],
    );
