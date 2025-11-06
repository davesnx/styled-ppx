/* Parse and minify a CSS stylesheet (can include rules with selectors, at-rules, etc.) */
let parse_and_minify = input => {
  switch (Styled_ppx_css_parser.Driver.parse_declaration_list(input)) {
  | Ok(ast) => Ok(Styled_ppx_css_parser.Minify.rule_list(ast))
  | Error((loc_start, _loc_end, msg)) =>
    let pos = loc_start;
    let curr_pos = pos.pos_cnum;
    let lnum = pos.pos_lnum;
    let pos_bol = pos.pos_bol;
    let err =
      Printf.sprintf(
        "%s on line %i at position %i",
        msg,
        lnum,
        curr_pos - pos_bol,
      );
    Error(err);
  };
};

/* Test data: (input_css, expected_minified_css, test_description) */
let test_cases = [
  /* Basic declarations */
  ("color: red;", "color:red;", "Simple declaration"),
  ("color: red !important;", "color:red!important;", "Important declaration"),
  (
    "padding: 10px; margin: 20px;",
    "padding:10px;margin:20px;",
    "Multiple declarations",
  ),
  /* Selectors with single declaration */
  (".button { color: blue; }", ".button{color:blue;}", "Class selector"),
  ("#header { display: flex; }", "#header{display:flex;}", "ID selector"),
  ("div { background: white; }", "div{background:white;}", "Type selector"),
  (
    "*.warning { color: orange; }",
    "*.warning{color:orange;}",
    "Universal selector",
  ),
  /* Descendant selectors - spaces must be preserved */
  (
    ".parent .child { color: red; }",
    ".parent .child{color:red;}",
    "Descendant selector with classes",
  ),
  (
    "div span { color: blue; }",
    "div span{color:blue;}",
    "Descendant selector with elements",
  ),
  (
    ".nav li a { text-decoration: none; }",
    ".nav li a{text-decoration:none;}",
    "Multiple descendant selectors",
  ),
  /* Combinators - no spaces needed */
  (
    ".parent > .child { margin: 0; }",
    ".parent>.child{margin:0;}",
    "Child combinator",
  ),
  ("h1 + p { margin-top: 0; }", "h1+p{margin-top:0;}", "Adjacent sibling"),
  ("h1 ~ p { color: gray; }", "h1~p{color:gray;}", "General sibling"),
  (
    "div > p + span { color: red; }",
    "div>p+span{color:red;}",
    "Multiple combinators",
  ),
  /* Pseudo-classes and pseudo-elements */
  ("a:hover { color: red; }", "a:hover{color:red;}", "Pseudo-class"),
  (
    "input:focus { border-color: blue; }",
    "input:focus{border-color:blue;}",
    "Focus pseudo-class",
  ),
  (
    "p::before { content: ''; }",
    {|p::before{content:'';}|},
    "Pseudo-element",
  ),
  (
    "p::after { content: '→'; }",
    {|p::after{content:'→';}|},
    "Pseudo-element with content",
  ),
  (
    "li:nth-child(2n) { background: gray; }",
    "li:nth-child(2n){background:gray;}",
    "Nth-child even",
  ),
  (
    "tr:nth-child(2n+1) { background: #f0f0f0; }",
    "tr:nth-child(2n+1){background:#f0f0f0;}",
    "Nth-child formula",
  ),
  (
    "input:focus:valid { border-color: green; }",
    "input:focus:valid{border-color:green;}",
    "Multiple pseudo-classes",
  ),
  /* Multiple selectors */
  (
    "h1, h2, h3 { font-weight: bold; }",
    "h1,h2,h3{font-weight:bold;}",
    "Multiple selectors",
  ),
  (
    ".btn, .button { padding: 10px; }",
    ".btn,.button{padding:10px;}",
    "Multiple class selectors",
  ),
  /* Attribute selectors */
  (
    "input[type=\"text\"] { border: 1px solid gray; }",
    {|input[type='text']{border:1px solid gray;}|},
    "Attribute selector with quotes",
  ),
  (
    "a[href^=\"https\"] { color: green; }",
    {|a[href^='https']{color:green;}|},
    "Attribute selector with operator",
  ),
  /* Complex values */
  (
    "font-family: Arial, sans-serif;",
    "font-family:Arial,sans-serif;",
    "Comma-separated values",
  ),
  (
    "padding: 1em 2rem 3px 4%;",
    "padding:1em 2rem 3px 4%;",
    "Multiple space-separated values",
  ),
  (
    "border: 1px solid black;",
    "border:1px solid black;",
    "Shorthand with multiple tokens",
  ),
  (
    "box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);",
    "box-shadow:0 2px 4px rgba(0,0,0,0.1);",
    "Box shadow with rgba",
  ),
  (
    "background: linear-gradient(to bottom, #fff, #000);",
    "background:linear-gradient(to bottom,#fff,#000);",
    "Linear gradient",
  ),
  ("width: calc(100% - 20px);", "width:calc(100% - 20px);", "Calc function"),
  (
    "background-image: url('image.png');",
    {|background-image:url('image.png');|},
    "URL function",
  ),
  /* Media queries */
  (
    "@media (min-width: 768px) { .container { width: 750px; } }",
    "@media (min-width: 768px){.container{width:750px;}}",
    "Simple media query",
  ),
  (
    "@media screen and (max-width: 600px) { body { font-size: 14px; } }",
    "@media screen and (max-width: 600px){body{font-size:14px;}}",
    "Media query with type",
  ),
  (
    "@media (min-width: 768px) and (max-width: 1024px) { .box { padding: 20px; } }",
    "@media (min-width: 768px) and (max-width: 1024px){.box{padding:20px;}}",
    "Media query with multiple conditions",
  ),
  /* Multiple rules */
  (
    ".a { color: red; } .b { color: blue; }",
    ".a{color:red;}.b{color:blue;}",
    "Multiple rules",
  ),
  (
    "h1 { font-size: 2em; margin: 0; } p { line-height: 1.5; }",
    "h1{font-size:2em;margin:0;}p{line-height:1.5;}",
    "Multiple rules with multiple declarations",
  ),
  /* Nested rules (within media queries) */
  (
    "@media print { .no-print { display: none; } .page-break { page-break-before: always; } }",
    "@media print{.no-print{display:none;}.page-break{page-break-before:always;}}",
    "Media query with multiple nested rules",
  ),
  /* Nested selectors with ampersand */
  (
    "&:hover { color: blue; }",
    "&:hover{color:blue;}",
    "Ampersand with pseudo-class",
  ),
  (
    "& .child { margin: 5px; }",
    "& .child{margin:5px;}",
    "Ampersand with descendant",
  ),
  /* Nested rules from nested test */
  (
    "color: blue; &:hover { color: red; }",
    "color:blue;&:hover{color:red;}",
    "Nested ampersand hover",
  ),
  (
    "@media (min-width: 768px) { display: flex; padding: 10px; }",
    "@media (min-width: 768px){display:flex;padding:10px;}",
    "Media query with multiple declarations",
  ),
  (
    "background: white; .nested { margin: 5px; }",
    "background:white;.nested{margin:5px;}",
    "Nested selector with class",
  ),
];

let tests =
  test_cases
  |> List.mapi((_index, (input, expected, description)) => {
       let assertion = () => {
         let minified =
           switch (parse_and_minify(input)) {
           | Ok(result) => result
           | Error(err) =>
             failwith(
               Printf.sprintf(
                 "Failed to parse input for test '%s': %s",
                 description,
                 err,
               ),
             )
           };
         check(~__POS__, Alcotest.string, expected, minified);
       };

       test(description, assertion);
     });
