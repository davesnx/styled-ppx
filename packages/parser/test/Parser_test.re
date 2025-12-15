open Alcotest;

let parse_stylesheet = input => {
  let pos = Lexing.dummy_pos;
  let loc =
    Styled_ppx_css_parser.Parser_location.to_ppxlib_location(pos, pos);
  switch (Styled_ppx_css_parser.Driver.parse_stylesheet(~loc, input)) {
  | Ok(ast) => Ok(ast)
  | Error((loc, msg)) =>
    open Styled_ppx_css_parser.Ast;
    let pos = loc.loc_start;
    let curr_pos = pos.pos_cnum;
    let lnum = pos.pos_lnum + 1;
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

let parse_declaration_list = input => {
  let pos = Lexing.dummy_pos;
  let loc =
    Styled_ppx_css_parser.Parser_location.to_ppxlib_location(pos, pos);
  switch (Styled_ppx_css_parser.Driver.parse_declaration_list(~loc, input)) {
  | Ok(ast) => Ok(ast)
  | Error((loc, msg)) =>
    open Styled_ppx_css_parser.Ast;
    let pos = loc.loc_start;
    let curr_pos = pos.pos_cnum;
    let lnum = pos.pos_lnum + 1;
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

let parse_keyframes = input => {
  let pos = Lexing.dummy_pos;
  let loc =
    Styled_ppx_css_parser.Parser_location.to_ppxlib_location(pos, pos);
  switch (Styled_ppx_css_parser.Driver.parse_keyframes(~loc, input)) {
  | Ok(ast) => Ok(ast)
  | Error((loc, msg)) =>
    open Styled_ppx_css_parser.Ast;
    let pos = loc.loc_start;
    let curr_pos = pos.pos_cnum;
    let lnum = pos.pos_lnum + 1;
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

/* Helper to check that parsing succeeds */
let should_parse = (name, input) => {
  test_case(name, `Quick, () => {
    switch (parse_stylesheet(input)) {
    | Ok(_) => ()
    | Error(err) => fail(err)
    }
  });
};

let should_parse_declaration = (name, input) => {
  test_case(name, `Quick, () => {
    switch (parse_declaration_list(input)) {
    | Ok(_) => ()
    | Error(err) => fail(err)
    }
  });
};

let should_parse_keyframes = (name, input) => {
  test_case(name, `Quick, () => {
    switch (parse_keyframes(input)) {
    | Ok(_) => ()
    | Error(err) => fail(err)
    }
  });
};

/* ============================================
   ERROR TESTS - Invalid CSS should fail
   ============================================ */

let error_tests_data =
  [
    ("{}", "Parse error while reading token '{' on line 0 at position 0"),
    (
      {|div
        { color: red; _ }
      |},
      "Parse error while reading token '}' on line 2 at position 23",
    ),
    (
      "@media $",
      "Parse error while reading token '' on line 1 at position 7",
    ),
  ]
  |> List.mapi((_index, (input, output)) => {
       let assertion = () =>
         check(
           string,
           "should error" ++ input,
           output,
           parse_stylesheet(input) |> Result.get_error,
         );

       test_case(input, `Quick, assertion);
     });

/* ============================================
   SELECTOR TESTS - Various selector types
   ============================================ */

let selector_tests = [
  /* Type selectors */
  should_parse("type selector", "div { color: red; }"),
  should_parse("multiple type selectors", "div { } span { } p { }"),
  /* Class selectors */
  should_parse("class selector", ".foo { color: red; }"),
  should_parse("multiple classes", ".foo.bar.baz { color: red; }"),
  /* ID selectors */
  should_parse("id selector", "#main { color: red; }"),
  should_parse("id with class", "#main.active { color: red; }"),
  /* Universal selector */
  should_parse("universal selector", "* { margin: 0; }"),
  should_parse("universal with class", "*.highlight { color: red; }"),
  /* Attribute selectors */
  should_parse("attribute exists", "[disabled] { opacity: 0.5; }"),
  should_parse("attribute equals", {|[type="text"] { border: 1px; }|}),
  should_parse("attribute contains", {|[class*="btn"] { padding: 10px; }|}),
  should_parse(
    "attribute starts with",
    {|[href^="https"] { color: green; }|},
  ),
  should_parse("attribute ends with", {|[src$=".png"] { border: none; }|}),
  should_parse("attribute pipe", {|[lang|="en"] { font-family: serif; }|}),
  should_parse(
    "attribute tilde",
    {|[class~="active"] { font-weight: bold; }|},
  ),
  /* Compound selectors */
  should_parse("compound selector", "div.foo#bar[data-x] { color: red; }"),
  should_parse(
    "tag with multiple attributes",
    {|input[type="text"][required] { border: red; }|},
  ),
];

/* ============================================
   COMBINATOR TESTS - Selector relationships
   ============================================ */

let combinator_tests = [
  /* Descendant combinator (space) */
  should_parse("descendant combinator", "div span { color: red; }"),
  should_parse("deep descendant", "html body div p span { color: red; }"),
  /* Child combinator (>) */
  should_parse("child combinator", "ul > li { list-style: none; }"),
  should_parse("child with space", "ul > li { list-style: none; }"),
  should_parse("multiple child", "div > p > span { color: red; }"),
  /* Adjacent sibling (+) */
  should_parse("adjacent sibling", "h1 + p { margin-top: 0; }"),
  should_parse("adjacent with space", "h1 + p { margin-top: 0; }"),
  /* General sibling (~) */
  should_parse("general sibling", "h1 ~ p { color: gray; }"),
  should_parse("general sibling with space", "h1 ~ p { color: gray; }"),
  /* Mixed combinators */
  should_parse(
    "mixed combinators",
    "div > ul li + li ~ span { color: red; }",
  ),
  should_parse(
    "complex mixed",
    "article > header h1 + p ~ aside > div { color: red; }",
  ),
];

/* ============================================
   PSEUDO TESTS - Pseudo-classes and elements
   ============================================ */

let pseudo_tests = [
  /* Pseudo-classes */
  should_parse("hover", "a:hover { color: red; }"),
  should_parse("focus", "input:focus { outline: blue; }"),
  should_parse("active", "button:active { transform: scale(0.98); }"),
  should_parse("visited", "a:visited { color: purple; }"),
  should_parse("first-child", "li:first-child { font-weight: bold; }"),
  should_parse("last-child", "li:last-child { border: none; }"),
  should_parse("nth-child even", "tr:nth-child(even) { background: gray; }"),
  should_parse("nth-child odd", "tr:nth-child(odd) { background: white; }"),
  should_parse("nth-child number", "li:nth-child(3) { color: red; }"),
  should_parse("nth-child An+B", "li:nth-child(2n+1) { color: red; }"),
  should_parse(
    "nth-child An+B with spaces",
    "li:nth-child(2n + 1) { color: red; }",
  ),
  should_parse("nth-child negative", "li:nth-child(-n+3) { color: red; }"),
  should_parse("nth-of-type", "p:nth-of-type(2) { color: red; }"),
  should_parse("not selector", "p:not(.intro) { color: gray; }"),
  should_parse(
    "not with attribute",
    {|input:not([disabled]) { border: green; }|},
  ),
  should_parse("has selector", "article:has(> img) { border: 1px; }"),
  should_parse("is selector", ":is(h1, h2, h3) { color: red; }"),
  should_parse(
    "where selector",
    ":where(article, section) p { color: gray; }",
  ),
  /* Pseudo-elements */
  should_parse("before", "p::before { content: '*'; }"),
  should_parse("after", "p::after { content: '.'; }"),
  should_parse("first-line", "p::first-line { font-weight: bold; }"),
  should_parse("first-letter", "p::first-letter { font-size: 2em; }"),
  should_parse("selection", "::selection { background: yellow; }"),
  should_parse("placeholder", "input::placeholder { color: gray; }"),
  /* Combined pseudo */
  should_parse(
    "pseudo-class then element",
    "a:hover::after { content: '>'; }",
  ),
  should_parse(
    "multiple pseudo-classes",
    "input:focus:valid { border: green; }",
  ),
];

/* ============================================
   SELECTOR LIST TESTS - Comma-separated
   ============================================ */

let selector_list_tests = [
  should_parse("two selectors", "h1, h2 { color: red; }"),
  should_parse("three selectors", "h1, h2, h3 { margin: 0; }"),
  should_parse("mixed selectors", "div, .class, #id { color: red; }"),
  should_parse("complex list", "div > p, ul li, .foo.bar { color: red; }"),
  should_parse(
    "multiline selector list",
    {|
    h1,
    h2,
    h3 {
      color: red;
    }
  |},
  ),
];

/* ============================================
   NESTING TESTS - CSS Nesting
   ============================================ */

let nesting_tests = [
  /* Basic nesting */
  should_parse("basic nesting", ".foo { .bar { color: red; } }"),
  should_parse(
    "nesting with declaration",
    ".foo { color: blue; .bar { color: red; } }",
  ),
  /* Ampersand nesting */
  should_parse("ampersand prefix", ".foo { &:hover { color: red; } }"),
  should_parse("ampersand suffix", ".foo { .bar & { color: red; } }"),
  should_parse("ampersand middle", ".foo { .bar & .baz { color: red; } }"),
  should_parse("ampersand with class", ".foo { &.active { color: red; } }"),
  should_parse("ampersand with id", ".foo { &#main { color: red; } }"),
  should_parse("ampersand descendant", ".foo { & .bar { color: red; } }"),
  should_parse("multiple ampersand", ".foo { & & & { color: red; } }"),
  /* Deep nesting */
  should_parse(
    "deep nesting",
    {|
    .a {
      .b {
        .c {
          .d {
            color: red;
          }
        }
      }
    }
  |},
  ),
  /* Nesting with pseudo */
  should_parse("nesting pseudo-class", ".foo { :hover { color: red; } }"),
  should_parse(
    "nesting pseudo-element",
    ".foo { ::before { content: ''; } }",
  ),
  /* Nesting with combinators - Note: relative selectors starting with
     combinators like ".foo { > .bar {} }" are not currently supported.
     Use ampersand syntax instead: ".foo { & > .bar {} }" */
  should_parse(
    "nesting child with ampersand",
    ".foo { & > .bar { color: red; } }",
  ),
  should_parse(
    "nesting sibling with ampersand",
    ".foo { & + .bar { color: red; } }",
  ),
  should_parse(
    "nesting general sibling with ampersand",
    ".foo { & ~ .bar { color: red; } }",
  ),
];

/* ============================================
   AT-RULE TESTS - @media, @keyframes, etc.
   ============================================ */

let at_rule_tests = [
  /* @media */
  should_parse("media simple", "@media screen { .foo { color: red; } }"),
  should_parse(
    "media with feature",
    "@media (min-width: 768px) { .foo { color: red; } }",
  ),
  should_parse(
    "media and",
    "@media screen and (min-width: 768px) { .foo { color: red; } }",
  ),
  should_parse(
    "media multiple features",
    "@media (min-width: 768px) and (max-width: 1024px) { .foo { color: red; } }",
  ),
  should_parse(
    "media nested",
    {|
    .foo {
      @media (min-width: 768px) {
        color: red;
      }
    }
  |},
  ),
  should_parse(
    "media deeply nested",
    {|
    @media screen {
      @media (min-width: 300px) {
        .foo { color: red; }
      }
    }
  |},
  ),
  /* @keyframes - parsed via separate entry point, tested in keyframes_tests */
  /* @charset, @import (statement at-rules) */
  should_parse("charset", {|@charset "UTF-8";|}),
  should_parse("import", {|@import "styles.css";|}),
  should_parse("import url", {|@import url("styles.css");|}),
  /* @supports */
  should_parse(
    "supports",
    "@supports (display: grid) { .foo { display: grid; } }",
  ),
  /* @font-face */
  should_parse(
    "font-face",
    {|
    @font-face {
      font-family: "MyFont";
      src: url("font.woff2");
    }
  |},
  ),
  /* @page */
  should_parse("page", "@page { margin: 1cm; }"),
];

/* ============================================
   DECLARATION TESTS - Properties and values
   ============================================ */

let declaration_tests = [
  /* Basic declarations */
  should_parse_declaration("simple declaration", "color: red;"),
  should_parse_declaration(
    "multiple declarations",
    "color: red; background: blue;",
  ),
  should_parse_declaration(
    "declaration without trailing semicolon",
    "color: red",
  ),
  /* Values with whitespace */
  should_parse_declaration(
    "multi-word value",
    "font-family: Arial, sans-serif;",
  ),
  should_parse_declaration("function value", "background: rgb(255, 0, 0);"),
  should_parse_declaration("calc value", "width: calc(100% - 20px);"),
  should_parse_declaration(
    "complex calc",
    "width: calc(100vw - (2 * 20px));",
  ),
  /* CSS variables */
  should_parse_declaration("css variable definition", "--my-color: red;"),
  should_parse_declaration("css variable usage", "color: var(--my-color);"),
  should_parse_declaration(
    "css variable with fallback",
    "color: var(--my-color, blue);",
  ),
  should_parse_declaration(
    "css variable nested fallback",
    "color: var(--a, var(--b, red));",
  ),
  /* Important */
  should_parse_declaration("important", "color: red !important;"),
  should_parse_declaration("important with space", "color: red !important ;"),
  /* Special values */
  should_parse_declaration("url value", "background: url('image.png');"),
  should_parse_declaration("url unquoted", "background: url(image.png);"),
  should_parse_declaration(
    "gradient",
    "background: linear-gradient(to right, red, blue);",
  ),
  should_parse_declaration(
    "multiple backgrounds",
    "background: url('a.png'), url('b.png');",
  ),
  /* Numeric values */
  should_parse_declaration("px value", "width: 100px;"),
  should_parse_declaration("em value", "font-size: 1.5em;"),
  should_parse_declaration("rem value", "margin: 2rem;"),
  should_parse_declaration("percentage", "width: 50%;"),
  should_parse_declaration("viewport units", "height: 100vh;"),
  should_parse_declaration("zero without unit", "margin: 0;"),
  should_parse_declaration("negative value", "margin: -10px;"),
  should_parse_declaration("decimal", "opacity: 0.5;"),
  /* Shorthand properties */
  should_parse_declaration(
    "margin shorthand",
    "margin: 10px 20px 30px 40px;",
  ),
  should_parse_declaration("border shorthand", "border: 1px solid black;"),
  should_parse_declaration(
    "font shorthand",
    "font: bold 16px/1.5 Arial, sans-serif;",
  ),
  should_parse_declaration(
    "background shorthand",
    "background: #fff url('bg.png') no-repeat center center;",
  ),
];

/* ============================================
   WHITESPACE EDGE CASES - Critical for refactors
   ============================================ */

let whitespace_tests = [
  /* Whitespace in selectors (meaningful - descendant combinator) */
  should_parse("space is descendant", "div p { color: red; }"),
  should_parse("multiple spaces", "div    p { color: red; }"),
  should_parse("newline descendant", "div\np { color: red; }"),
  should_parse("tab descendant", "div\tp { color: red; }"),
  /* Whitespace around combinators */
  should_parse("no space around >", "div>p { color: red; }"),
  should_parse("space around >", "div > p { color: red; }"),
  should_parse("space before > only", "div >p { color: red; }"),
  should_parse("space after > only", "div> p { color: red; }"),
  should_parse("no space around +", "h1+p { color: red; }"),
  should_parse("space around +", "h1 + p { color: red; }"),
  should_parse("no space around ~", "h1~p { color: red; }"),
  should_parse("space around ~", "h1 ~ p { color: red; }"),
  /* Whitespace in declarations (cosmetic) */
  should_parse_declaration("no space around colon", "color:red;"),
  should_parse_declaration("space after colon", "color: red;"),
  should_parse_declaration("space before colon", "color :red;"),
  should_parse_declaration("space around colon", "color : red ;"),
  should_parse_declaration("multiline value", "font:\n  16px\n  Arial;"),
  /* Whitespace in at-rules */
  should_parse("media no space after @media", "@media(min-width:0){ .a{} }"),
  should_parse("media space after @media", "@media (min-width: 0) { .a {} }"),
  should_parse(
    "media multiline",
    {|
    @media
      screen
      and
      (min-width: 768px) {
        .foo { color: red; }
      }
  |},
  ),
  /* Whitespace in nth expressions */
  should_parse("nth no spaces", "li:nth-child(2n+1) { color: red; }"),
  should_parse("nth with spaces", "li:nth-child(2n + 1) { color: red; }"),
  should_parse("nth space before +", "li:nth-child(2n +1) { color: red; }"),
  should_parse("nth space after +", "li:nth-child(2n+ 1) { color: red; }"),
  /* Edge cases */
  should_parse("empty rule", ".foo { }"),
  should_parse("only whitespace in rule", ".foo {   }"),
  should_parse("leading whitespace", "  .foo { color: red; }"),
  should_parse("trailing whitespace", ".foo { color: red; }  "),
  should_parse(
    "lots of whitespace",
    {|


    .foo    {

      color   :    red   ;

    }


  |},
  ),
];

/* ============================================
   COMPLEX REAL-WORLD TESTS
   ============================================ */

let complex_tests = [
  should_parse(
    "bootstrap-like selector",
    {|
    div#main.container[data-role="content"]:not(:empty):nth-child(2n+1) > ul li:nth-of-type(odd):first-child a[target="_blank"]:hover {
      color: red;
    }
  |},
  ),
  should_parse(
    "real component",
    {|
    .card {
      display: flex;
      flex-direction: column;
      padding: 16px;

      &:hover {
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      }

      .card-header {
        font-size: 1.25rem;
        font-weight: bold;
      }

      .card-body {
        flex: 1;
      }

      @media (min-width: 768px) {
        flex-direction: row;

        .card-header {
          width: 200px;
        }
      }
    }
  |},
  ),
  should_parse(
    "animation property",
    {|
    .animated {
      animation: fadeIn 0.3s ease-in-out;
      animation-name: slide;
      animation-duration: 1s;
      animation-timing-function: ease-in-out;
      animation-delay: 0.5s;
      animation-iteration-count: infinite;
      animation-direction: alternate;
      animation-fill-mode: forwards;
    }
  |},
  ),
  should_parse(
    "css variables theme",
    {|
    :root {
      --primary-color: #007bff;
      --secondary-color: #6c757d;
      --spacing-unit: 8px;
    }

    .button {
      background: var(--primary-color);
      padding: var(--spacing-unit) calc(var(--spacing-unit) * 2);

      &.secondary {
        background: var(--secondary-color);
      }
    }
  |},
  ),
  should_parse(
    "grid layout",
    {|
    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 16px;

      @media (min-width: 1200px) {
        grid-template-columns: repeat(4, 1fr);
      }
    }
  |},
  ),
];

/* ============================================
   KEYFRAMES TESTS - Separate entry point
   ============================================ */

let keyframes_tests = [
  should_parse_keyframes("from-to", "from { left: 0; } to { left: 100px; }"),
  should_parse_keyframes(
    "percentages",
    "0% { opacity: 0; } 100% { opacity: 1; }",
  ),
  should_parse_keyframes(
    "multiple stops",
    "0% { top: 0; } 50% { top: 100px; } 100% { top: 0; }",
  ),
  should_parse_keyframes(
    "comma percentages",
    "0%, 100% { opacity: 1; } 50% { opacity: 0; }",
  ),
  should_parse_keyframes(
    "mixed from and percent",
    "from { opacity: 0; } 50% { opacity: 0.5; } to { opacity: 1; }",
  ),
  should_parse_keyframes(
    "multiple properties",
    "from { left: 0; top: 0; } to { left: 100px; top: 50px; }",
  ),
];

/* ============================================
   COMBINE ALL TESTS
   ============================================ */

let tests =
  error_tests_data
  @ selector_tests
  @ combinator_tests
  @ pseudo_tests
  @ selector_list_tests
  @ nesting_tests
  @ at_rule_tests
  @ declaration_tests
  @ whitespace_tests
  @ complex_tests
  @ keyframes_tests;
