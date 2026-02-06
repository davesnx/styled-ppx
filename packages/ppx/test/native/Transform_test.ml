module Transform = Styled_ppx_css_parser.Transform

let parse input =
  match
    Styled_ppx_css_parser.Driver.parse_declaration_list
      ~loc:Ppxlib.Location.none input
  with
  | Ok rule_list -> rule_list
  | Error (_loc, error) -> Alcotest.fail error

let render rules =
  let loc = Ppxlib.Location.none in
  Styled_ppx_css_parser.Render.rule_list (rules, loc)

let check ~pos expected actual =
  Alcotest.check ~pos Alcotest.string "" expected actual

let test name fn = Alcotest.test_case name `Quick fn

let split_by_kind () =
  let rules = parse "color: red; margin: 0; .test { display: block; }" in
  let declarations, selectors = Transform.split_by_kind (fst rules) in
  Alcotest.check ~pos:__POS__ Alcotest.int "Should have 2 declarations" 2
    (List.length declarations);
  Alcotest.check ~pos:__POS__ Alcotest.int "Should have 1 non-declaration" 1
    (List.length selectors)

let selector () =
  let input = "margin: 10px; a { display: block; div { display: none; } }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"parent" rule_list in
  check ~pos:__POS__
    ".parent{margin:10px;}.parent a{display:block;}.parent a div{display:none;}"
    (render list_of_rules)

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
  check ~pos:__POS__
    ".hash{margin:10px;}.hash > a{margin:11px;}.hash > a > div{margin:12px;}"
    (render list_of_rules)

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
  check ~pos:__POS__
    ".hash{margin:10px;}.hash .hash > a{margin:11px;}"
    (render list_of_rules)

let ampersand_ampersand () =
  let input =
    {|
    margin: 10px;
    &.extra > a {
      margin: 11px;
    }
  |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"hash" rule_list in
  check ~pos:__POS__
    ".hash{margin:10px;}.hash.extra > a{margin:11px;}"
    (render list_of_rules)

let selector_with_class () =
  let input = "margin: 10px; .test { display: block; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"hash" rule_list in
  check ~pos:__POS__
    ".hash{margin:10px;}.hash .test{display:block;}"
    (render list_of_rules)

let mediaqueries () =
  let input = "margin: 10px; @media (min-width: 768px) { display: block; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"hash" rule_list in
  check ~pos:__POS__
    ".hash{margin:10px;}@media (min-width: 768px) {.hash{display:block;}}"
    (render list_of_rules)

let mediaqueries_and_selectors () =
  let input =
    "margin: 10px; @media (min-width: 768px) { display: block; .test { \
     display: block; } }"
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"hash" rule_list in
  check ~pos:__POS__
    ".hash{margin:10px;}@media (min-width: 768px) \
     {.hash{display:block;}.hash .test{display:block;}}"
    (render list_of_rules)

let nested_mediaqueries_and_selectors () =
  let input =
    "margin: 10px; @media (min-width: 768px) { display: block; .test { \
     display: block; } } @media (min-width: 768px) { display: block; .test { \
     display: block; } }"
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"hash" rule_list in
  check ~pos:__POS__
    ".hash{margin:10px;}@media (min-width: 768px) \
     {.hash{display:block;}.hash .test{display:block;}}@media (min-width: \
     768px) {.hash{display:block;}.hash .test{display:block;}}"
    (render list_of_rules)

let ampersand_with_classname () =
  let input = "margin: 10px; & { display: block; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"my-class" rule_list in
  check ~pos:__POS__
    ".my-class{margin:10px;}.my-class{display:block;}"
    (render list_of_rules)

let nested_ampersand_with_classname () =
  let input =
    "margin: 10px; & div { display: block; & span { color: red; } }"
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"my-class" rule_list in
  check ~pos:__POS__
    ".my-class{margin:10px;}.my-class div{display:block;}.my-class div \
     span{color:red;}"
    (render list_of_rules)

let ampersand_with_hover_and_classname () =
  let input = "&:hover { background: blue; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"btn" rule_list in
  check ~pos:__POS__ ".btn:hover{background:blue;}" (render list_of_rules)

let ampersand_with_child_selector_and_classname () =
  let input = "& > a { color: green; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"nav" rule_list in
  check ~pos:__POS__ ".nav > a{color:green;}" (render list_of_rules)

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
  check ~pos:__POS__
    ".container{margin:10px;}.container:hover{background:blue;}.container > \
     div{padding:5px;}.container > div span{color:red;}"
    (render list_of_rules)

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
  check ~pos:__POS__
    "@media (min-width: 768px) {.responsive{display:flex;}}"
    (render list_of_rules)

let ampersand_with_adjacent_sibling () =
  let input = "& + div { margin-top: 20px; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"element" rule_list in
  check ~pos:__POS__ ".element + div{margin-top:20px;}"
    (render list_of_rules)

let ampersand_with_general_sibling () =
  let input = "& ~ span { color: gray; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"section" rule_list in
  check ~pos:__POS__ ".section ~ span{color:gray;}" (render list_of_rules)

let ampersand_with_descendant_selector () =
  let input = "& div { padding: 10px; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"wrapper" rule_list in
  check ~pos:__POS__ ".wrapper div{padding:10px;}" (render list_of_rules)

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
  check ~pos:__POS__
    ".box > div{color:blue;}.box > div + span{margin-left:5px;}.box > div + \
     span ~ p{opacity:0.8;}"
    (render list_of_rules)

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
  check ~pos:__POS__
    {|.text::before{content:"lol";}.text::after{content:"lel";}.text::first-line{text-transform:uppercase;}.text::first-letter{font-size:2em;}|}
    (render list_of_rules)

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
  check ~pos:__POS__
    ".item div::before{content:\"lol\";position:absolute;}"
    (render list_of_rules)

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
  check ~pos:__POS__
    ".input[disabled]{opacity:0.5;}.input[type=\"text\"]{border:1px solid \
     gray;}.input[href^=\"https\"]{color:green;}.input[class*=\"active\"]{font-weight:bold;}"
    (render list_of_rules)

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
  check ~pos:__POS__
    ".container form input[required]{border-color:red;}"
    (render list_of_rules)

let ampersand_with_not_pseudo_class () =
  let input = "&:not(:last-child) { margin-bottom: 10px; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"list-item" rule_list in
  check ~pos:__POS__
    ".list-item:not(:last-child){margin-bottom:10px;}"
    (render list_of_rules)

let ampersand_with_is_pseudo_class () =
  let input = "&:is(h1, h2, h3) { color: navy; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"heading" rule_list in
  check ~pos:__POS__
    ".heading:is(h1,h2,h3){color:navy;}"
    (render list_of_rules)

let ampersand_with_where_pseudo_class () =
  let input = "&:where(.active, .selected) { outline: 2px solid; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"item" rule_list in
  check ~pos:__POS__
    ".item:where(.active,.selected){outline:2px solid;}"
    (render list_of_rules)

let ampersand_with_nth_child () =
  let input = "&:nth-child(2n+1) { background: #eee; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"row" rule_list in
  check ~pos:__POS__
    ".row:nth-child(2n+1){background:#eee;}"
    (render list_of_rules)

let multiple_pseudo_classes () =
  let input =
    {|
    &:hover:not(:disabled) { cursor: pointer; }
    &:focus:not(:active) { box-shadow: 0 0 3px blue; }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"button" rule_list in
  check ~pos:__POS__
    ".button:hover:not(:disabled){cursor:pointer;}.button:focus:not(:active){box-shadow:0 \
     0 3px blue;}"
    (render list_of_rules)

let pseudo_classes_with_pseudo_elements () =
  let input =
    {|
    &:hover::after { content: "hovered"; }
    &:focus::before { content: "focused"; }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"tooltip" rule_list in
  check ~pos:__POS__
    ".tooltip:hover::after{content:\"hovered\";}.tooltip:focus::before{content:\"focused\";}"
    (render list_of_rules)

let id_selector () =
  let input = "&#main { font-weight: bold; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"page" rule_list in
  check ~pos:__POS__
    ".page#main{font-weight:bold;}"
    (render list_of_rules)

let universal_selector () =
  let input = "& * { box-sizing: border-box; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"reset" rule_list in
  check ~pos:__POS__
    ".reset *{box-sizing:border-box;}"
    (render list_of_rules)

let multiple_selectors_in_rule () =
  let input = "h1, h2, h3 { margin: 0; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"heading" rule_list in
  check ~pos:__POS__
    ".heading h1{margin:0;}.heading h2{margin:0;}.heading h3{margin:0;}"
    (render list_of_rules)

let multiple_selectors_with_ampersand () =
  let input = "&:hover, &:focus { color: blue; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"link" rule_list in
  check ~pos:__POS__
    ".link:hover{color:blue;}.link:focus{color:blue;}"
    (render list_of_rules)

let supports_rule () =
  let input =
    {|
    @supports (display: grid) {
      display: grid;
      & .item {
        flex: 1;
      }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"layout" rule_list in
  check ~pos:__POS__
    "@supports (display: grid) {.layout{display:grid;}.layout .item{flex:1;}}"
    (render list_of_rules)

let nested_supports_and_media () =
  let input =
    {|
    @supports (display: flex) {
      display: flex;
      @media (min-width: 768px) {
        flex-direction: row;
      }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"flex-container" rule_list in
  check ~pos:__POS__
    "@supports (display: flex) \
     {.flex-container{display:flex;}@media (min-width: 768px) \
     {.flex-container{flex-direction:row;}}}"
    (render list_of_rules)

let deeply_nested_structure () =
  let input =
    {|
    color: red;
    & > .header {
      padding: 20px;
      & h1 {
        font-size: 24px;
        &:hover {
          color: blue;
        }
      }
      & nav {
        display: flex;
        & a {
          text-decoration: none;
          &:visited {
            color: purple;
          }
        }
      }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"page" rule_list in
  check ~pos:__POS__
    ".page{color:red;}.page > .header{padding:20px;}.page > .header \
     h1{font-size:24px;}.page > .header h1:hover{color:blue;}.page > .header \
     nav{display:flex;}.page > .header nav \
     a{text-decoration:none;}.page > .header nav a:visited{color:purple;}"
    (render list_of_rules)

let media_query_with_nested_selectors_and_pseudo () =
  let input =
    {|
    display: flex;
    @media (max-width: 600px) {
      display: block;
      & .sidebar {
        display: none;
      }
      &:hover {
        background: #f0f0f0;
      }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"layout" rule_list in
  check ~pos:__POS__
    ".layout{display:flex;}@media (max-width: 600px) \
     {.layout{display:block;}.layout .sidebar{display:none;}.layout:hover{background:#f0f0f0;}}"
    (render list_of_rules)

let mixed_combinators_and_pseudo () =
  let input =
    {|
    display: grid;
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
  check ~pos:__POS__
    ".grid{display:grid;}.grid > .card{border:1px solid;}.grid > \
     .card:hover{box-shadow:0 4px 8px rgba(0,0,0,0.1);}.grid > .card:hover + \
     .card{transform:translateX(5px);}.grid > .card ~ \
     .info{display:none;}.grid > .card ~ .info:target{display:block;}"
    (render list_of_rules)

let media_with_nested_selectors () =
  let input =
    {|
    display: flex;
    @media (max-width: 480px) {
      display: block;
      & .child {
        padding: 10px;
      }
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"responsive" rule_list in
  check ~pos:__POS__
    ".responsive{display:flex;}@media (max-width: 480px) \
     {.responsive{display:block;}.responsive .child{padding:10px;}}"
    (render list_of_rules)

let supports_with_declarations () =
  let input =
    {|
    color: red;
    @supports (display: grid) {
      display: grid;
      gap: 10px;
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"grid-layout" rule_list in
  check ~pos:__POS__
    ".grid-layout{color:red;}@supports (display: grid) \
     {.grid-layout{display:grid;gap:10px;}}"
    (render list_of_rules)

let multiple_media_queries () =
  let input =
    {|
    font-size: 16px;
    @media (min-width: 768px) {
      font-size: 18px;
    }
    @media (min-width: 1024px) {
      font-size: 20px;
    }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"text" rule_list in
  check ~pos:__POS__
    ".text{font-size:16px;}@media (min-width: 768px) \
     {.text{font-size:18px;}}@media (min-width: 1024px) \
     {.text{font-size:20px;}}"
    (render list_of_rules)

let empty_selectors () =
  let input = "& { }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"empty" rule_list in
  check ~pos:__POS__ "" (render list_of_rules)

let multiple_ampersands_same_selector () =
  let input = "&.double { font-weight: bold; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"double" rule_list in
  check ~pos:__POS__
    ".double.double{font-weight:bold;}"
    (render list_of_rules)

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
  check ~pos:__POS__
    ".parent{color:blue;}.parent div{padding:10px;}.parent div \
     span{font-size:14px;}"
    (render list_of_rules)

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
  check ~pos:__POS__
    ".grid-item:nth-of-type(3n+1){grid-column:1;}.grid-item:nth-last-child(2){margin-bottom:0;}.grid-item:nth-last-of-type(odd){background:#f0f0f0;}"
    (render list_of_rules)

let has_pseudo_class () =
  let input = "&:has(> img) { display: flex; align-items: center; }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"card" rule_list in
  check ~pos:__POS__
    ".card:has(> img){display:flex;align-items:center;}"
    (render list_of_rules)

let focus_within_and_focus_visible () =
  let input =
    {|
    &:focus-within { border-color: blue; }
    &:focus-visible { outline: 2px solid orange; }
    |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run ~className:"form" rule_list in
  check ~pos:__POS__
    ".form:focus-within{border-color:blue;}.form:focus-visible{outline:2px \
     solid orange;}"
    (render list_of_rules)

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
  check ~pos:__POS__
    ".complex{color:red;}@media (min-width: 768px) \
     {.complex{color:green;}@supports (display: grid) \
     {.complex{display:grid;}@media (min-width: 1024px) \
     {.complex{grid-template-columns:repeat(3, 1fr);}}}}"
    (render list_of_rules)

let tests =
  [
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
    test "ampersand_with_adjacent_sibling" ampersand_with_adjacent_sibling;
    test "ampersand_with_general_sibling" ampersand_with_general_sibling;
    test "ampersand_with_descendant_selector" ampersand_with_descendant_selector;
    test "nested_combinators" nested_combinators;
    test "ampersand_with_pseudo_elements" ampersand_with_pseudo_elements;
    test "nested_pseudo_elements" nested_pseudo_elements;
    test "ampersand_with_attribute_selectors" ampersand_with_attribute_selectors;
    test "nested_attribute_selectors" nested_attribute_selectors;
    test "ampersand_with_not_pseudo_class" ampersand_with_not_pseudo_class;
    test "ampersand_with_is_pseudo_class" ampersand_with_is_pseudo_class;
    test "ampersand_with_where_pseudo_class" ampersand_with_where_pseudo_class;
    test "ampersand_with_nth_child" ampersand_with_nth_child;
    test "multiple_pseudo_classes" multiple_pseudo_classes;
    test "pseudo_classes_with_pseudo_elements"
      pseudo_classes_with_pseudo_elements;
    test "id_selector" id_selector;
    test "universal_selector" universal_selector;
    test "multiple_selectors_in_rule" multiple_selectors_in_rule;
    test "multiple_selectors_with_ampersand" multiple_selectors_with_ampersand;
    test "supports_rule" supports_rule;
    test "nested_supports_and_media" nested_supports_and_media;
    test "deeply_nested_structure" deeply_nested_structure;
    test "media_query_with_nested_selectors_and_pseudo"
      media_query_with_nested_selectors_and_pseudo;
    test "mixed_combinators_and_pseudo" mixed_combinators_and_pseudo;
    test "media_with_nested_selectors" media_with_nested_selectors;
    test "multiple_media_queries" multiple_media_queries;
    test "supports_with_declarations" supports_with_declarations;
    test "empty_selectors" empty_selectors;
    test "multiple_ampersands_same_selector" multiple_ampersands_same_selector;
    test "nested_without_ampersand" nested_without_ampersand;
    test "pseudo_class_functions_complex" pseudo_class_functions_complex;
    test "has_pseudo_class" has_pseudo_class;
    test "focus_within_and_focus_visible" focus_within_and_focus_visible;
    test "nested_at_rules_priority" nested_at_rules_priority;
    test "ampersand_space_ampersand" ampersand_space_ampersand;
    test "ampersand_ampersand" ampersand_ampersand;
  ]
