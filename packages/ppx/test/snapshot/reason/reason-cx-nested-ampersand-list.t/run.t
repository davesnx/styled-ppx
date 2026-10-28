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
    "._a_g79843h2ghsebco tbody tr:first-child td{border-top:1px solid gray;}"]
  [@@@css
    "._a_x5lvq3h2ghstv1h tbody tr:first-child td:first-child{border-top:1px solid transparent;}"]
  [@@@css
    "._a_lf3m83h2ghscuwt tbody tr:first-child td:last-child{border-top:1px solid transparent;}"]
  [@@@css "._a_x5lvq4en7y2 tbody tr:first-child td:first-child{color:red;}"]
  [@@@css "._a_pkdux4woysu ul li:hover::before{content:\"\";}"]
  [@@@css "._a_rf47n4wkqg0 ul li:hover::after{content:\"\";}"]
  [@@@css.bindings
    [("Input.table", "_id_1mv3wnm",
       "_a_g79843h2ghsebco _a_x5lvq3h2ghstv1h _a_lf3m83h2ghscuwt");
    ("Input.single", "_id_1yrphqe", "_a_x5lvq4en7y2");
    ("Input.compoundParent", "_id_4irh27", "_a_pkdux4woysu _a_rf47n4wkqg0")]]
  [@@@css.blocks
    [(12,
       "_id_1mv3wnm _a_g79843h2ghsebco _a_x5lvq3h2ghstv1h _a_lf3m83h2ghscuwt");
    (26, "_id_1yrphqe _a_x5lvq4en7y2");
    (39, "_id_4irh27 _a_pkdux4woysu _a_rf47n4wkqg0")]]
  let table =
    CSS.make
      "label:table _id_1mv3wnm _a_g79843h2ghsebco _a_x5lvq3h2ghstv1h _a_lf3m83h2ghscuwt"
      []
  let single = CSS.make "label:single _id_1yrphqe _a_x5lvq4en7y2" []
  let compoundParent =
    CSS.make "label:compoundParent _id_4irh27 _a_pkdux4woysu _a_rf47n4wkqg0" []
