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

  $ standalone --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css
    ".css-1meebco-table tbody tr:first-child td{border-top:1px solid gray;}"]
  [@@@css
    ".css-1rhtv1h-table tbody tr:first-child td:first-child{border-top:1px solid transparent;}"]
  [@@@css
    ".css-r3cuwt-table tbody tr:first-child td:last-child{border-top:1px solid transparent;}"]
  [@@@css ".css-x5n7y2-single tbody tr:first-child td:first-child{color:red;}"]
  [@@@css ".css-1wfoysu-compoundParent ul li:hover::before{content:\"\";}"]
  [@@@css ".css-1ikqg0-compoundParent ul li:hover::after{content:\"\";}"]
  [@@@css.bindings
    [("Input.table", "css-1meebco-table css-1rhtv1h-table css-r3cuwt-table");
    ("Input.single", "css-x5n7y2-single");
    ("Input.compoundParent",
      "css-1wfoysu-compoundParent css-1ikqg0-compoundParent")]]
  let table =
    CSS.make "css-1meebco-table css-1rhtv1h-table css-r3cuwt-table" []
  let single = CSS.make "css-x5n7y2-single" []
  let compoundParent =
    CSS.make "css-1wfoysu-compoundParent css-1ikqg0-compoundParent" []
