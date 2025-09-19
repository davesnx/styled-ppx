open Styled_ppx_css_parser

let loc = Ppxlib.Location.none
let with_loc x = x, loc

let parse input =
  match Styled_ppx_css_parser.Driver.parse_declaration_list input with
  | Ok rule_list -> rule_list
  | Error (_loc_start, _loc_end, error) -> Alcotest.fail error

let render input =
  let loc = Ppxlib.Location.none in
  Styled_ppx_css_parser.Render.rule_list (input, loc)

let check ~pos expected actual =
  Alcotest.check ~pos Alcotest.string "" actual expected

let split_by_kind () =
  let rules = parse "color: red; .test {} margin: 0; @media {}" in
  let declarations, selectors = Transform.split_by_kind (fst rules) in
  Alcotest.check ~pos:__POS__ Alcotest.int "Should have 2 declarations" 2
    (List.length declarations);
  Alcotest.check ~pos:__POS__ Alcotest.int "Should have 2 non-declarations" 2
    (List.length selectors)

let selector () =
  let input = "margin: 10px; a { display: block; div { display: none; } }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"parent" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "margin: 10px; .parent a { display: block; } .parent a div { display: \
     none; }"

let selector_with_ampersand () =
  let input =
    {|
    margin: 10px;
    & > a {
      margin: 11px;
      & > div {
        margin: 12px;
      }
    }
  |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"hash" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "margin: 10px; .hash > a { margin: 11px; } .hash > a > div { margin: 12px; \
     }"

let ampersand_space_ampersand () =
  let input =
    {|
    margin: 10px;
    & & > a {
      margin: 11px;
    }
  |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"hash" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "margin: 10px; .hash.hash > a { margin: 11px; }"

let ampersand_ampersand () =
  let input =
    {|
    margin: 10px;
    && > a {
      margin: 11px;
    }
  |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"hash" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "margin: 10px; .hash.hash > a { margin: 11px; }"

let selector_with_class () =
  let input = "margin: 10px; .test { display: block; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"hash" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "margin: 10px; .hash .test { display: block; }"

let mediaqueries () =
  let input = "margin: 10px; @media (min-width: 768px) { display: block; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"hash" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "margin: 10px; @media (min-width: 768px)  { .hash { display: block; } }"

let mediaqueries_and_selectors () =
  let input =
    "margin: 10px; @media (min-width: 768px) { display: block; .test { \
     display: block; } }"
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"hash" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "margin: 10px; @media (min-width: 768px)  { .hash { display: block; } \
     .hash .test { display: block; } }"

let nested_mediaqueries_and_selectors () =
  let input =
    "margin: 10px; @media (min-width: 768px) { display: block; .test { \
     display: block; } } @media (min-width: 768px) { display: block; .test { \
     display: block; } }"
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"hash" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "margin: 10px; @media (min-width: 768px)  { .hash { display: block; } \
     .hash .test { display: block; } } @media (min-width: 768px)  { .hash { \
     display: block; } .hash .test { display: block; } }"

let ampersand_with_classname () =
  let input = "margin: 10px; & { display: block; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"my-class" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "margin: 10px; .my-class { display: block; }"

let nested_ampersand_with_classname () =
  let input =
    "margin: 10px; & div { display: block; & span { color: red; } }"
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"my-class" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "margin: 10px; .my-class div { display: block; } .my-class div span { \
     color: red; }"

let ampersand_with_hover_and_classname () =
  let input = "&:hover { background: blue; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"btn" rule_list in
  check ~pos:__POS__ (render list_of_rules) ".btn:hover { background: blue; }"

let ampersand_with_child_selector_and_classname () =
  let input = "& > a { color: green; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"nav" rule_list in
  check ~pos:__POS__ (render list_of_rules) ".nav > a { color: green; }"

let multiple_nested_ampersands_with_classname () =
  let input =
    {|
    & {
      margin: 10px;
      &:hover {
        background: blue;
      }
      & > div {
        padding: 5px;
        & span {
          color: red;
        }
      }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"container" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".container { margin: 10px; } .container:hover { background: blue; } \
     .container > div { padding: 5px; } .container > div span { color: red; }"

let media_query_with_ampersand_and_classname () =
  let input =
    {|
    @media (min-width: 768px) {
      & {
        display: flex;
      }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"responsive" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "@media (min-width: 768px)  { .responsive { display: flex; } }"

(* === CSS Combinators === *)

let ampersand_with_adjacent_sibling () =
  let input = "& + div { margin-top: 20px; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"element" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".element + div { margin-top: 20px; }"

let ampersand_with_general_sibling () =
  let input = "& ~ span { color: gray; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"section" rule_list in
  check ~pos:__POS__ (render list_of_rules) ".section ~ span { color: gray; }"

let ampersand_with_descendant_selector () =
  let input = "& div { padding: 10px; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"wrapper" rule_list in
  check ~pos:__POS__ (render list_of_rules) ".wrapper div { padding: 10px; }"

let nested_combinators () =
  let input =
    {|
    & > div {
      color: blue;
      & + span {
        margin-left: 5px;
        & ~ p {
          opacity: 0.8;
        }
      }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"box" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".box > div { color: blue; } .box > div + span { margin-left: 5px; } .box \
     > div + span ~ p { opacity: 0.8; }"

(* === Pseudo-elements === *)

let ampersand_with_pseudo_elements () =
  let input =
    {|
    &::before { content: "lol"; }
    &::after { content: "lel"; }
    &::first-line { text-transform: uppercase; }
    &::first-letter { font-size: 2em; }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"text" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    {|.text::before { content: "lol"; } .text::after { content: "lel"; } .text::first-line { text-transform: uppercase; } .text::first-letter { font-size: 2em; }|}

let nested_pseudo_elements () =
  let input =
    {|
    & div {
      &::before {
        content: "lol";
        position: absolute;
      }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"item" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".item div::before { content: \"lol\"; position: absolute; }"

(* === Attribute selectors === *)

let ampersand_with_attribute_selectors () =
  let input =
    {|
    &[disabled] { opacity: 0.5; }
    &[type="text"] { border: 1px solid gray; }
    &[href^="https"] { color: green; }
    &[class*="active"] { font-weight: bold; }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"input" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".input[disabled] { opacity: 0.5; } .input[type=\"text\"] { border: 1px \
     solid gray; } .input[href^=\"https\"] { color: green; } \
     .input[class*=\"active\"] { font-weight: bold; }"

let nested_attribute_selectors () =
  let input =
    {|
    & form {
      & input[required] {
        border-color: red;
      }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"container" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".container form input[required] { border-color: red; }"

(* === Complex pseudo-classes === *)

let ampersand_with_not_pseudo_class () =
  let input = "&:not(:last-child) { margin-bottom: 10px; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"list-item" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".list-item:not(:last-child) { margin-bottom: 10px; }"

let ampersand_with_is_pseudo_class () =
  let input = "&:is(h1, h2, h3) { color: navy; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"heading" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".heading:is(h1,h2,h3) { color: navy; }"

let ampersand_with_where_pseudo_class () =
  let input = "&:where(.primary, .secondary) { padding: 15px; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"button" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".button:where(.primary,.secondary) { padding: 15px; }"

let ampersand_with_nth_child () =
  let input =
    {|
    &:nth-child(odd) { background: lightgray; }
    &:nth-child(2n+1) { font-weight: bold; }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"row" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".row:nth-child(odd) { background: lightgray; } .row:nth-child(2n+1) { \
     font-weight: bold; }"

(* === Multiple pseudo-classes === *)

let multiple_pseudo_classes () =
  let input =
    {|
    &:hover:focus { outline: 2px solid blue; }
    &:active:enabled { transform: scale(0.98); }
    &:first-child:last-child { margin: 0 auto; }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"interactive" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".interactive:hover:focus { outline: 2px solid blue; } \
     .interactive:active:enabled { transform: scale(0.98); } \
     .interactive:first-child:last-child { margin: 0 auto; }"

let pseudo_classes_with_pseudo_elements () =
  let input = "&:hover::before { opacity: 1; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"icon" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".icon:hover::before { opacity: 1; }"

(* === ID and Universal selectors === *)

let id_selector () =
  let input = "#header { height: 60px; } #footer { margin-top: 20px; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"page" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".page #header { height: 60px; } .page #footer { margin-top: 20px; }"

let universal_selector () =
  let input = "* { box-sizing: border-box; } & * { margin: 0; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"reset" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".reset * { box-sizing: border-box; } .reset * { margin: 0; }"

(* === Multiple selectors === *)

let multiple_selectors_in_rule () =
  let input = "h1, h2, h3 { font-family: serif; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"article" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".article h1 { font-family: serif; } .article h2 { font-family: serif; } \
     .article h3 { font-family: serif; }"

let multiple_selectors_with_ampersand () =
  let input = "&:hover, &:focus { background: yellow; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"link" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".link:hover { background: yellow; } .link:focus { background: yellow; }"

(* === @supports rules === *)

let supports_rule () =
  let input =
    {|
    @supports (display: grid) {
      display: grid;
      & > div {
        grid-column: span 2;
      }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"layout" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "@supports (display: grid)  { .layout { display: grid; } .layout > div { \
     grid-column: span 2; } }"

let nested_supports_and_media () =
  let input =
    {|
    @supports (display: flex) {
      @media (min-width: 1024px) {
        display: flex;
        & > * {
          flex: 1;
        }
      }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"flexible" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "@supports (display: flex)  { .flexible { @media (min-width: 1024px)  { \
     .flexible { display: flex; } .flexible > * { flex: 1; } } } }"

(* === Complex nested scenarios === *)

let deeply_nested_structure () =
  let input =
    {|
    padding: 20px;
    & > header {
      background: gray;
      & nav {
        display: flex;
        & ul {
          list-style: none;
          & li {
            display: inline;
            &:not(:last-child) {
              margin-right: 10px;
            }
            & a {
              color: white;
              &:hover {
                text-decoration: underline;
              }
            }
          }
        }
      }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"app" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "padding: 20px; .app > header { background: gray; } .app > header nav { \
     display: flex; } .app > header nav ul { list-style: none; } .app > header \
     nav ul li { display: inline; } .app > header nav ul li:not(:last-child) { \
     margin-right: 10px; } .app > header nav ul li a { color: white; } .app > \
     header nav ul li a:hover { text-decoration: underline; }"

let media_query_with_nested_selectors_and_pseudo () =
  let input =
    {|
    color: black;
    @media (prefers-color-scheme: dark) {
      color: white;
      background: black;
      & a {
        color: lightblue;
        &:visited {
          color: purple;
        }
        &::after {
          content: "yoo";
        }
      }
    }
    & footer {
      @media (max-width: 768px) {
        padding: 10px;
        & .copyright {
          font-size: 12px;
        }
      }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"theme" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "color: black; @media (prefers-color-scheme: dark)  { .theme { color: \
     white; background: black; } .theme a { color: lightblue; } .theme \
     a:visited { color: purple; } .theme a::after { content: \"yoo\"; } } \
     @media (max-width: 768px)  { .theme footer { padding: 10px; } .theme \
     footer .copyright { font-size: 12px; } }"

let mixed_combinators_and_pseudo () =
  let input =
    {|
    & > .card {
      border: 1px solid;
      &:hover {
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        & + .card {
          transform: translateX(5px);
        }
      }
      & ~ .info {
        display: none;
        &:target {
          display: block;
        }
      }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"grid" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".grid > .card { border: 1px solid; } .grid > .card:hover { box-shadow: 0 \
     4px 8px rgba(0,0,0,0.1); } .grid > .card:hover + .card { transform: \
     translateX(5px); } .grid > .card ~ .info { display: none; } .grid > .card \
     ~ .info:target { display: block; }"

(* === Additional modern CSS features === *)

(* let container_queries () =
  let input =
    {|
    container-type: inline-size;
    @container (min-width: 400px) {
      display: flex;
      & .item {
        flex: 1;
      }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules =
    Transform.run ~className:"responsive-container" rule_list
  in
  check ~pos:__POS__ (render list_of_rules)
    "container-type: inline-size; @container (min-width: 400px)  { \
     .responsive-container { display: flex; } .responsive-container .item { \
     flex: 1; } }" *)

let keyframes_with_nesting () =
  let input =
    {|
    animation: slide 2s ease-in-out;
    @keyframes slide {
      from { transform: translateX(0); }
      to { transform: translateX(100px); }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"animated" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "animation: slide 2s ease-in-out; @keyframes slide { from { transform: \
     translateX(0); } to { transform: translateX(100px); } }"

let font_face_rule () =
  let input =
    {|
    @font-face {
      font-family: "Custom Font";
      src: url("/fonts/custom.woff2") format("woff2");
    }
    font-family: "Custom Font", sans-serif;
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"custom-text" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "font-family: \"Custom Font\", sans-serif; @font-face  { font-family: \
     \"Custom Font\"; src: url(\"/fonts/custom.woff2\") format(\"woff2\"); }"

let keyframes_with_percentages () =
  let input =
    {|
    animation: fade 1s;
    @keyframes fade {
      0% { opacity: 0; }
      50% { opacity: 0.5; }
      100% { opacity: 1; }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"fade-element" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "animation: fade 1s; @keyframes fade { 0% { opacity: 0; } 50% { opacity: \
     0.5; } 100% { opacity: 1; } }"

let empty_selectors () =
  let input = "& { }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"empty" rule_list in
  check ~pos:__POS__ (render list_of_rules) ""

let multiple_ampersands_same_selector () =
  (* Using & twice to increase specificity *)
  let input = "&.double { font-weight: bold; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"double" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".double.double { font-weight: bold; }"

let nested_without_ampersand () =
  let input =
    {|
    color: blue;
    div {
      padding: 10px;
      span {
        font-size: 14px;
      }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"parent" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "color: blue; .parent div { padding: 10px; } .parent div span { font-size: \
     14px; }"

let pseudo_class_functions_complex () =
  let input =
    {|
    &:nth-of-type(3n+1) { grid-column: 1; }
    &:nth-last-child(2) { margin-bottom: 0; }
    &:nth-last-of-type(odd) { background: #f0f0f0; }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"grid-item" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".grid-item:nth-of-type(3n+1) { grid-column: 1; } \
     .grid-item:nth-last-child(2) { margin-bottom: 0; } \
     .grid-item:nth-last-of-type(odd) { background: #f0f0f0; }"

let has_pseudo_class () =
  let input = "&:has(> img) { display: flex; align-items: center; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"card" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".card:has(> img) { display: flex; align-items: center; }"

(* Parser doesn't support :lang() and :dir() pseudo-classes yet *)
(* let lang_and_dir_pseudo_classes () =
  let input =
    {|
    &:lang(en) { quotes: "\201C" "\201D"; }
    &:dir(rtl) { text-align: right; }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"i18n" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".i18n:lang(en) { quotes: \"\\201C\" \"\\201D\"; } .i18n:dir(rtl) { \
     text-align: right; }" *)

let focus_within_and_focus_visible () =
  let input =
    {|
    &:focus-within { border-color: blue; }
    &:focus-visible { outline: 2px solid orange; }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"form" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".form:focus-within { border-color: blue; } .form:focus-visible { outline: \
     2px solid orange; }"

let nested_at_rules_priority () =
  let input =
    {|
    color: red;
    @media (min-width: 768px) {
      color: green;
      @supports (display: grid) {
        display: grid;
        @media (min-width: 1024px) {
          grid-template-columns: repeat(3, 1fr);
        }
      }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"complex" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "color: red; @media (min-width: 768px)  { .complex { color: green; \
     @supports (display: grid)  { .complex { display: grid; @media (min-width: \
     1024px)  { .complex { grid-template-columns: repeat(3, 1fr); } } } } } }"

(* Parser doesn't support &-suffix notation yet *)
(* let ampersand_suffix_selector () =
  (* Testing suffix-style selector with ampersand *)
  let input = "&-suffix { border: 1px solid; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"prefix" rule_list in
  check ~pos:__POS__ (render list_of_rules)
    ".prefix-suffix { border: 1px solid; }" *)

let tests : tests =
  [
    (* Original tests *)
    test "split_by_kind" split_by_kind;
    test "selector" selector;
    test "selector_with_ampersand" selector_with_ampersand;
    test "selector_with_class" selector_with_class;
    test "mediaqueries" mediaqueries;
    test "mediaqueries_and_selectors" mediaqueries_and_selectors;
    test "nested_mediaqueries_and_selectors" nested_mediaqueries_and_selectors;
    test "ampersand_with_classname" ampersand_with_classname;
    test "nested_ampersand_with_classname" nested_ampersand_with_classname;
    test "ampersand_with_hover_and_classname" ampersand_with_hover_and_classname;
    test "ampersand_with_child_selector_and_classname"
      ampersand_with_child_selector_and_classname;
    test "multiple_nested_ampersands_with_classname"
      multiple_nested_ampersands_with_classname;
    test "media_query_with_ampersand_and_classname"
      media_query_with_ampersand_and_classname;
    (* Combinators *)
    test "ampersand_with_adjacent_sibling" ampersand_with_adjacent_sibling;
    test "ampersand_with_general_sibling" ampersand_with_general_sibling;
    test "ampersand_with_descendant_selector" ampersand_with_descendant_selector;
    test "nested_combinators" nested_combinators;
    (* Pseudo-elements *)
    test "ampersand_with_pseudo_elements" ampersand_with_pseudo_elements;
    test "nested_pseudo_elements" nested_pseudo_elements;
    (* Attribute selectors *)
    test "ampersand_with_attribute_selectors" ampersand_with_attribute_selectors;
    test "nested_attribute_selectors" nested_attribute_selectors;
    (* Complex pseudo-classes *)
    test "ampersand_with_not_pseudo_class" ampersand_with_not_pseudo_class;
    test "ampersand_with_is_pseudo_class" ampersand_with_is_pseudo_class;
    test "ampersand_with_where_pseudo_class" ampersand_with_where_pseudo_class;
    test "ampersand_with_nth_child" ampersand_with_nth_child;
    (* Multiple pseudo-classes *)
    test "multiple_pseudo_classes" multiple_pseudo_classes;
    test "pseudo_classes_with_pseudo_elements"
      pseudo_classes_with_pseudo_elements;
    (* ID and Universal selectors *)
    test "id_selector" id_selector;
    test "universal_selector" universal_selector;
    (* Multiple selectors *)
    test "multiple_selectors_in_rule" multiple_selectors_in_rule;
    test "multiple_selectors_with_ampersand" multiple_selectors_with_ampersand;
    (* @supports rules *)
    test "supports_rule" supports_rule;
    test "nested_supports_and_media" nested_supports_and_media;
    (* Complex nested scenarios *)
    test "deeply_nested_structure" deeply_nested_structure;
    test "media_query_with_nested_selectors_and_pseudo"
      media_query_with_nested_selectors_and_pseudo;
    test "mixed_combinators_and_pseudo" mixed_combinators_and_pseudo;
    (* Additional modern CSS features *)
    (* test "container_queries" container_queries; *)
    test "keyframes_with_nesting" keyframes_with_nesting;
    test "keyframes_with_percentages" keyframes_with_percentages;
    test "font_face_rule" font_face_rule;
    test "empty_selectors" empty_selectors;
    test "multiple_ampersands_same_selector" multiple_ampersands_same_selector;
    test "nested_without_ampersand" nested_without_ampersand;
    test "pseudo_class_functions_complex" pseudo_class_functions_complex;
    test "has_pseudo_class" has_pseudo_class;
    (* test "lang_and_dir_pseudo_classes" lang_and_dir_pseudo_classes; -- Parser doesn't support :lang() and :dir() yet *)
    test "focus_within_and_focus_visible" focus_within_and_focus_visible;
    test "nested_at_rules_priority" nested_at_rules_priority;
    (* test "ampersand_suffix_selector" ampersand_suffix_selector; -- Parser doesn't support &-suffix notation yet *)
    test "ampersand_space_ampersand" ampersand_space_ampersand;
    test "ampersand_ampersand" ampersand_ampersand;
  ]
