Custom-property declarations in [%cx2] accept any string interpolation
verbatim - no Cascading.toString wrap.

  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-14o54yy-row{--color-link:var(--var-vhdpd8);}"];
  [@css ".css-14o54yy-theme{--color-link:var(--var-vhdpd8);}"];
  [@css ".css-1l1kohh-theme{--spacing:var(--var-1irw9qf);}"];
  [@css ".css-zwwqpt-dyn{--token:var(--var-7wrrwo);}"];
  [@css.bindings
    [
      ("Output.row", "css-14o54yy-row"),
      ("Output.theme", "css-14o54yy-theme css-1l1kohh-theme"),
      ("Output.dyn", "css-zwwqpt-dyn"),
    ]
  ];
  let colorStr = CSS.Types.Color.toString(`hex("3A57FC"));
  let plainStr = "10px";
  let row = CSS.make("css-14o54yy-row", [("--var-vhdpd8", colorStr)]);
  let theme =
    CSS.make(
      "css-14o54yy-theme css-1l1kohh-theme",
      [("--var-vhdpd8", colorStr), ("--var-1irw9qf", plainStr)],
    );
  let dyn = value => CSS.make("css-zwwqpt-dyn", [("--var-7wrrwo", value)]);
