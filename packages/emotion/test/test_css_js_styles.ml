let assert_string left right =
  Alcotest.check Alcotest.string "should be equal" right left

let assert_not_equal_string left right =
  Alcotest.check (Alcotest.neg Alcotest.string) "should not be equal" right left

let get_string_style_rules () =
  let content = CssJs.get_string_style_rules () in
  let _ = CssJs.flush () in
  content

let one_property () =
  let className = CssJs.style [| CssJs.display `block |] in
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf ".%s { display: block; }" className)

let multiple_properties () =
  let className =
    CssJs.style [| CssJs.display `block; CssJs.fontSize (`px 10) |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { display: block; font-size: 10px; }" className)

let multiple_declarations () =
  let className1 =
    CssJs.style [| CssJs.display `block; CssJs.fontSize (`px 10) |]
  in
  let className2 =
    CssJs.style [| CssJs.display `block; CssJs.fontSize (`px 99) |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; font-size: 10px; } .%s { display: block; \
        font-size: 99px; }"
       className1 className2)

let label () =
  let className =
    CssJs.style [| CssJs.label "className"; CssJs.display `block |]
  in
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf ".%s { display: block; }" className)

let label_with_ppx () =
  let className = [%cx {| display: block; |}] in
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf ".%s { display: block; }" className)

let selector_with_ppx () =
  let className =
    [%cx {|
    color: red;

    & > * {
      color: blue;
    }
  |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { color: #FF0000; } .%s  > * { color: #0000FF; }"
       className className)

let avoid_hash_collision () =
  let className1 =
    let color = `var "alt-text--tertiary" in
    let hoverColor = `var "alt-text--primary" in
    let disabledColor = `var "alt-text--tertiary" in
    [%cx
      {|
      color: $(color);

      :disabled {
        color: $(disabledColor);
      }

      :hover {
        color: $(hoverColor);
      }
    |}]
  in
  let className2 =
    let padding = `px 16 in
    [%cx
      {|
      display: flex;

      :before,
      :after {
        content: '';
        flex: 0 0 $(padding);
      }
    |}]
  in
  let className3 =
    let padding = `px 16 in
    [%cx
      {|
      display: flex;

      :before,
      :after {
        content: '';
        flex: 0 1 $(padding);
      }
    |}]
  in
  let _css = get_string_style_rules () in
  assert_not_equal_string className1 className2;
  assert_not_equal_string className2 className3;
  assert_not_equal_string className1 className3

let float_values () =
  let className = CssJs.style [| CssJs.padding (`rem 10.) |] in
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf ".%s { padding: 10rem; }" className)

let selector_one_nesting () =
  let className =
    CssJs.style
      [|
        CssJs.color CssJs.aliceblue;
        CssJs.selector "a" [| CssJs.color CssJs.rebeccapurple |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { color: #F0F8FF; } .%s a { color: #663399; }"
       className className)

let selector_nested () =
  let className =
    CssJs.style
      [|
        CssJs.color CssJs.aliceblue;
        CssJs.selector "a"
          [|
            CssJs.display `block; CssJs.selector "div" [| CssJs.display `none |];
          |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { color: #F0F8FF; } .%s a { display: block; } .%s a div { display: \
        none; }"
       className className className)

let selector_nested_x10 () =
  let className =
    CssJs.style
      [|
        CssJs.display `flex;
        CssJs.selector "a"
          [|
            CssJs.display `block;
            CssJs.selector "div"
              [|
                CssJs.display `none;
                CssJs.selector "span"
                  [|
                    CssJs.display `none;
                    CssJs.selector "hr"
                      [|
                        CssJs.display `none;
                        CssJs.selector "code" [| CssJs.display `none |];
                      |];
                  |];
              |];
          |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: flex; } .%s a { display: block; } .%s a div { display: \
        none; } .%s a div span { display: none; } .%s a div span hr { display: \
        none; } .%s a div span hr code { display: none; }"
       className className className className className className)

let selector_ampersand () =
  let className =
    CssJs.style
      [|
        CssJs.fontSize (`px 42);
        CssJs.selector "& .div" [| CssJs.fontSize (`px 24) |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { font-size: 42px; } .%s  .div { font-size: 24px; }"
       className className)

let selector_ampersand_at_the_middle () =
  let className =
    CssJs.style
      [|
        CssJs.fontSize (`px 42);
        CssJs.selector "& div &" [| CssJs.fontSize (`px 24) |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { font-size: 42px; } .%s  div .%s { font-size: 24px; }"
       className className className)

let media_queries () =
  let className =
    CssJs.style
      [|
        CssJs.maxWidth (`px 800);
        CssJs.media "(max-width: 768px)" [| CssJs.width (`px 300) |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { max-width: 800px; } @media (max-width: 768px) { .%s { width: \
        300px; } }"
       className className)

let selector_params () =
  let className =
    CssJs.style
      [|
        CssJs.maxWidth (`px 800); CssJs.firstChild [| CssJs.width (`px 300) |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { max-width: 800px; } .%s:first-child { width: 300px; }" className
       className)

let keyframe () =
  let animationName =
    CssJs.keyframes
      [|
        0, [| CssJs.transform (`rotate (`deg 0.)) |];
        100, [| CssJs.transform (`rotate (`deg (-360.))) |];
      |]
  in
  let className = CssJs.style [| CssJs.animationName animationName |] in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       "@keyframes %s { 0%% { -webkit-transform: rotate(0deg); -moz-transform: \
        rotate(0deg); -ms-transform: rotate(0deg); transform: rotate(0deg); } \
        100%% { -webkit-transform: rotate(-360deg); -moz-transform: \
        rotate(-360deg); -ms-transform: rotate(-360deg); transform: \
        rotate(-360deg); } } .%s { -webkit-animation-name: %s; animation-name: \
        %s; }"
       animationName className animationName animationName)

let global () =
  let _ =
    CssJs.global [| CssJs.selector "html" [| CssJs.lineHeight (`abs 1.15) |] |]
  in
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf "html{line-height:1.15;}")

let duplicated_styles_unique () =
  let className1 = CssJs.style [| CssJs.flexGrow 1. |] in
  let className2 = CssJs.style [| CssJs.flexGrow 1. |] in
  let css = get_string_style_rules () in
  assert_string className1 className2;
  assert_string css (Printf.sprintf ".%s { flex-grow: 1; }" className1)

let hover_selector () =
  let className =
    CssJs.style
      [|
        CssJs.color (`rgb (255, 255, 255));
        CssJs.selector ":hover"
          [| CssJs.color (`rgba (255, 255, 255, `num 0.7)) |];
        CssJs.selector "&:hover"
          [| CssJs.color (`rgba (255, 255, 255, `num 0.7)) |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { color: rgb(255, 255, 255); } .%s:hover { color: rgba(255, 255, \
        255, 0.7); } .%s:hover { color: rgba(255, 255, 255, 0.7); }"
       className className className)

let case title fn = Alcotest.test_case title `Quick fn

let tests =
  ( "CssJs",
    [
      case "one_property" one_property;
      case "multiple_properties" multiple_properties;
      case "multiple_declarations" multiple_declarations;
      case "float_values" float_values;
      case "selector_one_nesting" selector_one_nesting;
      case "label" label;
      case "label_with_ppx" label_with_ppx;
      case "selector_nested" selector_nested;
      case "selector_nested_x10" selector_nested_x10;
      case "media_queries" media_queries;
      case "selector_ampersand" selector_ampersand;
      case "selector_ampersand_at_the_middle" selector_ampersand_at_the_middle;
      case "selector_params" selector_params;
      case "keyframe" keyframe;
      case "global" global;
      case "duplicated_styles_unique" duplicated_styles_unique;
      case "selector_with_ppx" selector_with_ppx;
      case "avoid_hash_collision" avoid_hash_collision;
      case "hover_selector" hover_selector;
    ] )
