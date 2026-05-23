REGRESSION TEST — pins KNOWN-BROKEN cross-property dedup in
[%css]. See input.re for the full rationale. A future fix MUST
update this snapshot intentionally.

  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-1xhaeiy-layout{margin-left:var(--var-yq31wd);}"];
  [@css ".css-6oe920-layout{padding-left:var(--var-yq31wd);}"];
  [@css.bindings [("Output.layout", "css-1xhaeiy-layout css-6oe920-layout")]];
  let lengthVar = CSS.px(10);
  let layout =
    CSS.make(
      "css-1xhaeiy-layout css-6oe920-layout",
      [("--var-yq31wd", CSS.Types.Margin.toString(lengthVar))],
    );
