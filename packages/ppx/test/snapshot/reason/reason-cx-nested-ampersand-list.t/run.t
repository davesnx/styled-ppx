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
    ".css-pegnde tbody tr:first-child td{border-top:1px solid gray;}.css-pegnde tbody tr:first-child td:first-child{border-top:1px solid transparent;}.css-pegnde tbody tr:first-child td:last-child{border-top:1px solid transparent;}"]
  [@@@css ".css-qlgz15 tbody tr:first-child td:first-child{color:red;}"]
  [@@@css
    ".css-1277kt2 ul li:hover::before{content:\"\";}.css-1277kt2 ul li:hover::after{content:\"\";}"]
  [@@@css.classes
    [("css-pegnde", 0, "Input.table", "input.ml", 13, 2, 21, 0);
    ("css-qlgz15", 1, "Input.single", "input.ml", 27, 2, 34, 0);
    ("css-1277kt2", 2, "Input.compoundParent", "input.ml", 40, 2, 47, 0)]]
  [@@@css.bindings
    [("Input.table", "css-pegnde");
    ("Input.single", "css-qlgz15");
    ("Input.compoundParent", "css-1277kt2")]]
  let table = CSS.make "css-pegnde" []
  let single = CSS.make "css-qlgz15" []
  let compoundParent = CSS.make "css-1277kt2" []
