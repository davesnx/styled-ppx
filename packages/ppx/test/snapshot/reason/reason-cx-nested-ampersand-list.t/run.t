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
    ".a-g79843hghsebco tbody tr:first-child td{border-top:1px solid gray;}"]
  [@@@css
    ".a-x5lvq3hghstv1h tbody tr:first-child td:first-child{border-top:1px solid transparent;}"]
  [@@@css
    ".a-lf3m83hghscuwt tbody tr:first-child td:last-child{border-top:1px solid transparent;}"]
  [@@@css ".a-x5lvq4en7y2 tbody tr:first-child td:first-child{color:red;}"]
  [@@@css ".a-pkdux4woysu ul li:hover::before{content:\"\";}"]
  [@@@css ".a-rf47n4wkqg0 ul li:hover::after{content:\"\";}"]
  [@@@css.bindings
    [("Input.table", "id-1me4lmu",
       "a-g79843hghsebco a-x5lvq3hghstv1h a-lf3m83hghscuwt");
    ("Input.single", "id-1e50cws", "a-x5lvq4en7y2");
    ("Input.compoundParent", "id-16qcgjr", "a-pkdux4woysu a-rf47n4wkqg0")]]
  let table =
    CSS.make
      "label:table id-1me4lmu a-g79843hghsebco a-x5lvq3hghstv1h a-lf3m83hghscuwt"
      []
  let single = CSS.make "label:single id-1e50cws a-x5lvq4en7y2" []
  let compoundParent =
    CSS.make "label:compoundParent id-16qcgjr a-pkdux4woysu a-rf47n4wkqg0" []
