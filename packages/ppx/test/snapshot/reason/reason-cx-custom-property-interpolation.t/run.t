Custom-property declarations in [%css] accept any string interpolation
verbatim - no Cascading.toString wrap.

  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-14o54yy-row{--color-link:var(--colorStr-t58soe);}"];
  [@css ".css-10nqctf-theme{--color-link:var(--colorStr-11d7je1);}"];
  [@css ".css-10nqctf-theme{--spacing:var(--plainStr-1cgr13y);}"];
  [@css ".css-zwwqpt-dyn{--token:var(--value-13tu4ef);}"];
  [@css.bindings
    [
      ("Output.row", "css-14o54yy-row"),
      ("Output.theme", "css-10nqctf-theme"),
      ("Output.dyn", "css-zwwqpt-dyn"),
    ]
  ];
  let colorStr = CSS.Types.Color.toString(`hex("3A57FC"));
  let plainStr = "10px";
  let row = CSS.make("css-14o54yy-row", [("--colorStr-t58soe", colorStr)]);
  let theme =
    CSS.make(
      "css-10nqctf-theme",
      [("--colorStr-11d7je1", colorStr), ("--plainStr-1cgr13y", plainStr)],
    );
  let dyn = value => CSS.make("css-zwwqpt-dyn", [("--value-13tu4ef", value)]);
