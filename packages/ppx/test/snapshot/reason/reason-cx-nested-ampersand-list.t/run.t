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
  [@@@css ".a-1meebco tbody tr:first-child td{border-top:1px solid gray;}"]
  [@@@css
    ".a-1rhtv1h tbody tr:first-child td:first-child{border-top:1px solid transparent;}"]
  [@@@css
    ".a-r3cuwt tbody tr:first-child td:last-child{border-top:1px solid transparent;}"]
  [@@@css ".a-x5n7y2 tbody tr:first-child td:first-child{color:red;}"]
  [@@@css ".a-1wfoysu ul li:hover::before{content:\"\";}"]
  [@@@css ".a-1ikqg0 ul li:hover::after{content:\"\";}"]
  [@@@css.bindings
    [("Input.table", "id-1me4lmu", "a-1meebco a-1rhtv1h a-r3cuwt");
    ("Input.single", "id-1e50cws", "a-x5n7y2");
    ("Input.compoundParent", "id-16qcgjr", "a-1wfoysu a-1ikqg0")]]
  let table = CSS.make "label:table id-1me4lmu a-1meebco a-1rhtv1h a-r3cuwt" []
  let single = CSS.make "label:single id-1e50cws a-x5n7y2" []
  let compoundParent =
    CSS.make "label:compoundParent id-16qcgjr a-1wfoysu a-1ikqg0" []
