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

let test_cases = [
  /* Basic declarations */
  ("color: red;", "color:red;"),
  ("color: red !important;", "color:red!important;"),
  ("padding: 10px; margin: 20px;", "padding:10px;margin:20px;"),
  /* Selectors with single declaration */
  (".button { color: blue; }", ".button{color:blue;}"),
  ("#header { display: flex; }", "#header{display:flex;}"),
  ("div { background: white; }", "div{background:white;}"),
  ("*.warning { color: orange; }", "*.warning{color:orange;}"),
  /* Descendant selectors - spaces must be preserved */
  (".parent .child { color: red; }", ".parent .child{color:red;}"),
  ("div span { color: blue; }", "div span{color:blue;}"),
  (
    ".nav li a { text-decoration: none; }",
    ".nav li a{text-decoration:none;}",
  ),
  /* Combinators - no spaces needed */
  (".parent > .child { margin: 0; }", ".parent>.child{margin:0;}"),
  ("h1 + p { margin-top: 0; }", "h1+p{margin-top:0;}"),
  ("h1 ~ p { color: gray; }", "h1~p{color:gray;}"),
  ("div > p + span { color: red; }", "div>p+span{color:red;}"),
  /* Pseudo-classes and pseudo-elements */
  ("a:hover { color: red; }", "a:hover{color:red;}"),
  ("input:focus { border-color: blue; }", "input:focus{border-color:blue;}"),
  ("p::before { content: ''; }", {|p::before{content:'';}|}),
  ("p::after { content: '→'; }", {|p::after{content:'→';}|}),
  (
    "li:nth-child(2n) { background: gray; }",
    "li:nth-child(2n){background:gray;}",
  ),
  (
    "tr:nth-child(2n+1) { background: #f0f0f0; }",
    "tr:nth-child(2n+1){background:#f0f0f0;}",
  ),
  (
    "input:focus:valid { border-color: green; }",
    "input:focus:valid{border-color:green;}",
  ),
  /* Multiple selectors */
  ("h1, h2, h3 { font-weight: bold; }", "h1,h2,h3{font-weight:bold;}"),
  (".btn, .button { padding: 10px; }", ".btn,.button{padding:10px;}"),
  /* Attribute selectors */
  (
    "input[type=\"text\"] { border: 1px solid gray; }",
    {|input[type='text']{border:1px solid gray;}|},
  ),
  (
    "a[href^=\"https\"] { color: green; }",
    {|a[href^='https']{color:green;}|},
  ),
  /* Complex values */
  ("font-family: Arial, sans-serif;", "font-family:Arial,sans-serif;"),
  ("padding: 1em 2rem 3px 4%;", "padding:1em 2rem 3px 4%;"),
  ("border: 1px solid black;", "border:1px solid black;"),
  (
    "box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);",
    "box-shadow:0 2px 4px rgba(0,0,0,0.1);",
  ),
  (
    "background: linear-gradient(to bottom, #fff, #000);",
    "background:linear-gradient(to bottom,#fff,#000);",
  ),
  ("width: calc(100% - 20px);", "width:calc(100% - 20px);"),
  (
    "background-image: url('image.png');",
    {|background-image:url('image.png');|},
  ),
  /* Media queries */
  (
    "@media (min-width: 768px) { .container { width: 750px; } }",
    "@media (min-width: 768px){.container{width:750px;}}",
  ),
  (
    "@media screen and (max-width: 600px) { body { font-size: 14px; } }",
    "@media screen and (max-width: 600px){body{font-size:14px;}}",
  ),
  (
    "@media (min-width: 768px) and (max-width: 1024px) { .box { padding: 20px; } }",
    "@media (min-width: 768px) and (max-width: 1024px){.box{padding:20px;}}",
  ),
  /* Multiple rules */
  (".a { color: red; } .b { color: blue; }", ".a{color:red;}.b{color:blue;}"),
  (
    "h1 { font-size: 2em; margin: 0; } p { line-height: 1.5; }",
    "h1{font-size:2em;margin:0;}p{line-height:1.5;}",
  ),
  /* Nested rules (within media queries) */
  (
    "@media print { .no-print { display: none; } .page-break { page-break-before: always; } }",
    "@media print{.no-print{display:none;}.page-break{page-break-before:always;}}",
  ),
  /* Nested selectors with ampersand */
  ("&:hover { color: blue; }", "&:hover{color:blue;}"),
  ("& .child { margin: 5px; }", "& .child{margin:5px;}"),
  /* Nested rules from nested test */
  ("color: blue; &:hover { color: red; }", "color:blue;&:hover{color:red;}"),
  (
    "@media (min-width: 768px) { display: flex; padding: 10px; }",
    "@media (min-width: 768px){display:flex;padding:10px;}",
  ),
  (
    "background: white; .nested { margin: 5px; }",
    "background:white;.nested{margin:5px;}",
  ),
];

let tests =
  test_cases
  |> List.mapi((_index, (input, expected)) => {
       let assertion = () => {
         let minified =
           switch (parse_and_minify(input)) {
           | Ok(result) => result
           | Error(err) =>
             failwith(
               Printf.sprintf(
                 "Failed to parse input for test '%s': %s",
                 input,
                 err,
               ),
             )
           };
         check(~__POS__, Alcotest.string, expected, minified);
       };

       test(input, assertion);
     });
