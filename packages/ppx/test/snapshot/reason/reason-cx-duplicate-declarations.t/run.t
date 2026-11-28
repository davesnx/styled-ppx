Duplicate declarations of one property in a block. A block is written as one
rule per selector or at-rule, with its declarations in source order, the way
the emotion runtime serializes a block. So the later declaration wins inside
the block (last-wins overrides), and vendor fallback pairs like
`display: -webkit-box; display: flex` keep their order.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "@property --ivpce48{syntax:\"*\";inherits:false;}"]
  [@@@css ".css-ivpcrym{color:blue;color:red;color:blue;}"]
  [@@@css ".css-ivpcggl{display:-webkit-box;display:flex;}"]
  [@@@css ".css-ivpclis{color:blue;margin:0;color:red;}"]
  [@@@css
    ".css-ivpcaix{color:blue;}@media (min-width: 600px) {.css-ivpcaix{color:green;}}.css-ivpcaix{color:red;}"]
  [@@@css ".css-ivpc9wk{margin:0;margin-top:5px;margin:10px;}"]
  [@@@css ".css-ivpc6rt:hover{color:blue;color:red;}"]
  [@@@css ".css-ivpc2vc:hover{color:red;}.css-ivpc2vc:hover{color:red;}"]
  [@@@css ".css-ivpclr0{--Foo:1px;--foo:2px;}"]
  [@@@css ".css-ivpcjsp{color:red;}"]
  [@@@css ".css-ivpcgyc{color:blue;color:red;}"]
  [@@@css ".css-ivpcqx4{margin:0;margin:var(--ivpce48);}"]
  [@@@css.classes
    [("css-ivpcrym", 1, "Input.dup", "input.ml", 7, 17, 7, 53);
    ("css-ivpcggl", 2, "Input.fallback", "input.ml", 11, 22, 11, 57);
    ("css-ivpclis", 3, "Input.interleaved", "input.ml", 15, 25, 15, 59);
    ("css-ivpcaix", 4, "Input.mediaInterleaved", "input.ml", 23, 9, 23, 76);
    ("css-ivpc9wk", 5, "Input.shorthandReset", "input.ml", 28, 28, 28, 68);
    ("css-ivpc6rt", 6, "Input.nested", "input.ml", 31, 20, 31, 56);
    ("css-ivpc2vc", 7, "Input.twice", "input.ml", 35, 19, 35, 66);
    ("css-ivpclr0", 8, "Input.custom", "input.ml", 38, 20, 38, 42);
    ("css-ivpcjsp", 9, "Input.A.x", "input.ml", 44, 17, 44, 27);
    ("css-ivpcgyc", 10, "Input.B.x", "input.ml", 48, 17, 48, 40);
    ("css-ivpcqx4", 11, "Input.vars", "input.ml", 53, 18, 53, 41)]]
  [@@@css.bindings
    [("Input.dup", "css-ivpcrym");
    ("Input.fallback", "css-ivpcggl");
    ("Input.interleaved", "css-ivpclis");
    ("Input.mediaInterleaved", "css-ivpcaix");
    ("Input.shorthandReset", "css-ivpc9wk");
    ("Input.nested", "css-ivpc6rt");
    ("Input.twice", "css-ivpc2vc");
    ("Input.custom", "css-ivpclr0");
    ("Input.A.x", "css-ivpcjsp");
    ("Input.B.x", "css-ivpcgyc");
    ("Input.vars", "css-ivpcqx4")]]
  let dup = CSS.make "css-ivpcrym" []
  let fallback = CSS.make "css-ivpcggl" []
  let interleaved = CSS.make "css-ivpclis" []
  let mediaInterleaved = CSS.make "css-ivpcaix" []
  let shorthandReset = CSS.make "css-ivpc9wk" []
  let nested = CSS.make "css-ivpc6rt" []
  let twice = CSS.make "css-ivpc2vc" []
  let custom = CSS.make "css-ivpclr0" []
  module A = struct let x = CSS.make "css-ivpcjsp" [] end
  module B = struct let x = CSS.make "css-ivpcgyc" [] end
  let c = "10px"
  let vars =
    CSS.make "css-ivpcqx4" [("--ivpce48", (CSS.Types.Margin.toString c))]
