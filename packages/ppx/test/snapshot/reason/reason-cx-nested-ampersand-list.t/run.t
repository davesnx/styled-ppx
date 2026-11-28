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
    ".css-ivpcnde tbody tr:first-child td{border-top:1px solid gray;}.css-ivpcnde tbody tr:first-child td:first-child{border-top:1px solid transparent;}.css-ivpcnde tbody tr:first-child td:last-child{border-top:1px solid transparent;}"]
  [@@@css ".css-ivpcz15 tbody tr:first-child td:first-child{color:red;}"]
  [@@@css
    ".css-ivpckt2 ul li:hover::before{content:\"\";}.css-ivpckt2 ul li:hover::after{content:\"\";}"]
  [@@@css.classes
    [("css-ivpcnde", 0, "Input.table", "input.ml", 13, 2, 21, 0);
    ("css-ivpcz15", 1, "Input.single", "input.ml", 27, 2, 34, 0);
    ("css-ivpckt2", 2, "Input.compoundParent", "input.ml", 40, 2, 47, 0)]]
  [@@@css.bindings
    [("Input.table", "css-ivpcnde");
    ("Input.single", "css-ivpcz15");
    ("Input.compoundParent", "css-ivpckt2")]]
  let table = CSS.make "css-ivpcnde" []
  let single = CSS.make "css-ivpcz15" []
  let compoundParent = CSS.make "css-ivpckt2" []
