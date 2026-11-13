Duplicate declarations of one property in a block. A block is written as one
rule per selector or at-rule, with its declarations in source order, the way
the emotion runtime serializes a block. So the later declaration wins inside
the block (last-wins overrides), and vendor fallback pairs like
`display: -webkit-box; display: flex` keep their order.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "@property --1crn56w-0{syntax:\"*\";inherits:false;}"]
  [@@@css ".css-fa6rym{color:blue;color:red;color:blue;}"]
  [@@@css ".css-qv5ggl{display:-webkit-box;display:flex;}"]
  [@@@css ".css-5jblis{color:blue;margin:0;color:red;}"]
  [@@@css
    ".css-bx3aix{color:blue;}@media (min-width: 600px) {.css-bx3aix{color:green;}}.css-bx3aix{color:red;}"]
  [@@@css ".css-11jz9wk{margin:0;margin-top:5px;margin:10px;}"]
  [@@@css ".css-1nsx6rt:hover{color:blue;color:red;}"]
  [@@@css ".css-2lh2vc:hover{color:red;}.css-2lh2vc:hover{color:red;}"]
  [@@@css ".css-1jd6lr0{--Foo:1px;--foo:2px;}"]
  [@@@css ".css-wb1jsp{color:red;}"]
  [@@@css ".css-10nngyc{color:blue;color:red;}"]
  [@@@css ".css-1crn56w{margin:0;margin:var(--1crn56w-0);}"]
  [@@@css.classes
    [("css-fa6rym", 1, "Input.dup", "input.ml", 7, 17, 7, 53);
    ("css-qv5ggl", 2, "Input.fallback", "input.ml", 11, 22, 11, 57);
    ("css-5jblis", 3, "Input.interleaved", "input.ml", 15, 25, 15, 59);
    ("css-bx3aix", 4, "Input.mediaInterleaved", "input.ml", 23, 9, 23, 76);
    ("css-11jz9wk", 5, "Input.shorthandReset", "input.ml", 28, 28, 28, 68);
    ("css-1nsx6rt", 6, "Input.nested", "input.ml", 31, 20, 31, 56);
    ("css-2lh2vc", 7, "Input.twice", "input.ml", 35, 19, 35, 66);
    ("css-1jd6lr0", 8, "Input.custom", "input.ml", 38, 20, 38, 42);
    ("css-wb1jsp", 9, "Input.A.x", "input.ml", 44, 17, 44, 27);
    ("css-10nngyc", 10, "Input.B.x", "input.ml", 48, 17, 48, 40);
    ("css-1crn56w", 11, "Input.vars", "input.ml", 53, 18, 53, 41)]]
  [@@@css.bindings
    [("Input.dup", "css-fa6rym");
    ("Input.fallback", "css-qv5ggl");
    ("Input.interleaved", "css-5jblis");
    ("Input.mediaInterleaved", "css-bx3aix");
    ("Input.shorthandReset", "css-11jz9wk");
    ("Input.nested", "css-1nsx6rt");
    ("Input.twice", "css-2lh2vc");
    ("Input.custom", "css-1jd6lr0");
    ("Input.A.x", "css-wb1jsp");
    ("Input.B.x", "css-10nngyc");
    ("Input.vars", "css-1crn56w")]]
  let dup = CSS.make "css-fa6rym" []
  let fallback = CSS.make "css-qv5ggl" []
  let interleaved = CSS.make "css-5jblis" []
  let mediaInterleaved = CSS.make "css-bx3aix" []
  let shorthandReset = CSS.make "css-11jz9wk" []
  let nested = CSS.make "css-1nsx6rt" []
  let twice = CSS.make "css-2lh2vc" []
  let custom = CSS.make "css-1jd6lr0" []
  module A = struct let x = CSS.make "css-wb1jsp" [] end
  module B = struct let x = CSS.make "css-10nngyc" [] end
  let c = "10px"
  let vars =
    CSS.make "css-1crn56w" [("--1crn56w-0", (CSS.Types.Margin.toString c))]
