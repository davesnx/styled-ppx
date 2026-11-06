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
  [@@@css.atoms
    [("_bAD6jdUfqk36jIAE14z6j1sFxb9wdHwLt",
       ["._bAD6jdUfqk36jIAE14z6j1sFxb9wdHwLt tbody tr:first-child td{border-top:1px solid gray;}";
       "._bAD6jdUfqk36jIAE14z6j1sFxb9wdHwLt tbody tr:first-child td:first-child{border-top:1px solid transparent;}";
       "._bAD6jdUfqk36jIAE14z6j1sFxb9wdHwLt tbody tr:first-child td:last-child{border-top:1px solid transparent;}"],
       0, 1, 9,
       [("ctx", "dUfqk3", "ctx\\0& tbody tr:first-child td | ");
       ("ctx", "IAE14z", "ctx\\0& tbody tr:first-child td:first-child | ");
       ("ctx", "1sFxb9", "ctx\\0& tbody tr:first-child td:last-child | ");
       ("value", "wdHwLt",
         "bval\\0& tbody tr:first-child td | \\06j\\0border-top:1px solid gray\\0& tbody tr:first-child td:first-child | \\06j\\0border-top:1px solid transparent\\0& tbody tr:first-child td:last-child | \\06j\\0border-top:1px solid transparent")]);
    ("_c7fIAE14zNUw77S",
      ["._c7fIAE14zNUw77S tbody tr:first-child td:first-child{color:red;}"], 0,
      1, 1,
      [("ctx", "IAE14z", "ctx\\0& tbody tr:first-child td:first-child | ");
      ("value", "NUw77S",
        "val\\07f\\0& tbody tr:first-child td:first-child | \\0color:red")]);
    ("_bAC8ir_p-pL8ioBKrTa-X2q0I",
      ["._bAC8ir_p-pL8ioBKrTa-X2q0I ul li:hover::before{content:\"\";}";
      "._bAC8ir_p-pL8ioBKrTa-X2q0I ul li:hover::after{content:\"\";}"], 0, 1,
      2,
      [("ctx", "r_p-pL", "ctx\\0& ul li:hover::before | ");
      ("ctx", "oBKrTa", "ctx\\0& ul li:hover::after | ");
      ("value", "-X2q0I",
        "bval\\0& ul li:hover::before | \\08i\\0content:\"\"\\0& ul li:hover::after | \\08i\\0content:\"\"")]);
    ("_ivuIbUPtS", [], 1, 0, 0,
      [("id", "_ivuIbUPtS", "bind\\0\\0Input\\0\\0table\\00")]);
    ("_ie9RbboSj", [], 1, 0, 0,
      [("id", "_ie9RbboSj", "bind\\0\\0Input\\0\\0single\\00")]);
    ("_iUzMf_IlU", [], 1, 0, 0,
      [("id", "_iUzMf_IlU", "bind\\0\\0Input\\0\\0compoundParent\\00")])]]
  [@@@css.bindings
    [("Input.table", "_ivuIbUPtS _bAD6jdUfqk36jIAE14z6j1sFxb9wdHwLt",
       "_ivuIbUPtS");
    ("Input.single", "_ie9RbboSj _c7fIAE14zNUw77S", "_ie9RbboSj");
    ("Input.compoundParent", "_iUzMf_IlU _bAC8ir_p-pL8ioBKrTa-X2q0I",
      "_iUzMf_IlU")]]
  let table = CSS.make "_ivuIbUPtS _bAD6jdUfqk36jIAE14z6j1sFxb9wdHwLt" []
  let single = CSS.make "_ie9RbboSj _c7fIAE14zNUw77S" []
  let compoundParent = CSS.make "_iUzMf_IlU _bAC8ir_p-pL8ioBKrTa-X2q0I" []
