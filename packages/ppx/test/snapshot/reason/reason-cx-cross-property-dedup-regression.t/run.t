REGRESSION TEST — [%css] does not deduplicate one binding across different
CSS runtime types. See input.re for the full rationale.

  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-1xhaeiy-layout{margin-left:var(--var-opnhxg);}"];
  [@css ".css-6oe920-layout{padding-left:var(--var-a4xxke);}"];
  [@css.bindings [("Output.layout", "css-1xhaeiy-layout css-6oe920-layout")]];
  let lengthVar = CSS.px(10);
  let layout =
    CSS.make(
      "css-1xhaeiy-layout css-6oe920-layout",
      [
        ("--var-opnhxg", CSS.Types.Margin.toString(lengthVar)),
        ("--var-a4xxke", CSS.Types.Length.toString(lengthVar)),
      ],
    );
