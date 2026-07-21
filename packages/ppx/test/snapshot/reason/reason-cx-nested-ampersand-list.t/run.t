Regression test for `&` compounding in nested selector lists under static
extraction. See styled-ppx-extraction-nested-ampersand-bug.md.

A comma-separated `&` selector list nested two levels deep under a
multi-segment parent selector (`tbody { tr:first-child td { &:first-child,
&:last-child { ... } } }`) must compound `&` with the parent's last segment
(`td:first-child`), not join it with a descendant combinator
(`td :first-child`). The runtime (emotion) path always compounded correctly;
only the extracted stylesheet was wrong.

`Selector_nesting.pop_last_selector` now flattens nested combinator trees
before popping, so the popped segment is always the rightmost compound.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css
    ".css-1jjaqcp-table tbody tr:first-child td{border-top:1px solid gray}"]
  [@@@css
    ".css-1cdayx0-table tbody tr:first-child td:first-child{border-top:1px solid transparent}"]
  [@@@css
    ".css-8jjj10-table tbody tr:first-child td:last-child{border-top:1px solid transparent}"]
  [@@@css ".css-13m2v9f-single tbody tr:first-child td:first-child{color:red}"]
  [@@@css ".css-q04b8s-compoundParent ul li:hover::before{content:\"\"}"]
  [@@@css ".css-1xryzf5-compoundParent ul li:hover::after{content:\"\"}"]
  [@@@css.bindings
    [("Input.table", "css-1jjaqcp-table css-1cdayx0-table css-8jjj10-table");
    ("Input.single", "css-13m2v9f-single");
    ("Input.compoundParent",
      "css-q04b8s-compoundParent css-1xryzf5-compoundParent")]]
  let table =
    CSS.make "css-1jjaqcp-table css-1cdayx0-table css-8jjj10-table" []
  let single = CSS.make "css-13m2v9f-single" []
  let compoundParent =
    CSS.make "css-q04b8s-compoundParent css-1xryzf5-compoundParent" []
