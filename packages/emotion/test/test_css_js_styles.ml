let assert_string left right =
  Alcotest.check Alcotest.string "should be equal" right left

let render_style_tag () =
  let content = CssJs.render_style_tag () in
  let _ = CssJs.flush () in
  content

let one_property () =
  let className = CssJs.style [| CssJs.display `block |] in
  let css = render_style_tag () in
  assert_string css (Printf.sprintf ".%s { display: block; }" className)

let multiple_properties () =
  let className =
    CssJs.style [| CssJs.display `block; CssJs.fontSize (`px 10) |]
  in
  let css = render_style_tag () in
  assert_string css
    (Printf.sprintf ".%s { display: block; font-size: 10px; }" className)

let multiple_declarations () =
  let className1 =
    CssJs.style [| CssJs.display `block; CssJs.fontSize (`px 10) |]
  in
  let className2 =
    CssJs.style [| CssJs.display `block; CssJs.fontSize (`px 99) |]
  in
  let css = render_style_tag () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; font-size: 10px; } .%s { display: block; \
        font-size: 99px; }"
       className1 className2)

let label () =
  let className =
    CssJs.style [| CssJs.label "className"; CssJs.display `block |]
  in
  let css = render_style_tag () in
  assert_string css (Printf.sprintf ".%s { display: block; }" className)

let label_with_ppx () =
  let className = [%cx {| display: block; |}] in
  let css = render_style_tag () in
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
  let css = render_style_tag () in
  assert_string css
    (Printf.sprintf ".%s { color: #FF0000; } .%s  > * { color: #0000FF; }"
       className className)

let hash_collision () =
  let className1 =
    let color, hoverColor, disabledColor = `var "alt-text--tertiary", `var "alt-text--primary", `var "alt-text--tertiary"
    in
    [%cx {|
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
    let padding =`px 16
    in
    [%cx {|
      display: flex;
  
      :before,
      :after {
        content: '';
        flex: 0 0 $(padding);
      }
    |}]
  in
  let _css = render_style_tag () in
  assert_string className1 className2

(* let className =
     [%cx
       {|
       margin-bottom: 4px;
       font-size: 28px;
       line-height: 32px;
     |}]

   let random_classname () =
     let css = Css.render_style_tag () in
     assert_string className "css-a3lzz9";
     assert_string css
       (Printf.sprintf
          ".%s { margin-bottom: 4px; font-size: 28px; line-height: 32px; }"
          className) *)

(* let label_ppx_unique () =
   let className_with_unique_label = [%cx {|
      color: red;
    |}] in
   let className = [%cx {|
      color: red;
    |}] in
   let css = render_style_tag () in
   assert_string css
     (Printf.sprintf ".%s { color: #FF0000; } .%s { color: #FF0000; }" className
        className_with_unique_label) *)

(* let interpolated_selector_with_ppx () =
   let className = [%cx {|
      color: red;
    |}] in
   let className2 = [%cx {|
      color: red;
    |}] in
   let className3 = [%cx {|
      color: red;
    |}] in
   let css = render_style_tag () in
   assert_string css
     (Printf.sprintf
        ".%s { color: #FF0000; } .%s { color: #FF0000; } .%s { \
         background-color: #000000; }"
        className className2 className3) *)

let float_values () =
  let className = CssJs.style [| CssJs.padding (`rem 10.) |] in
  let css = render_style_tag () in
  assert_string css (Printf.sprintf ".%s { padding: 10rem; }" className)

let selector_one_nesting () =
  let className =
    CssJs.style
      [|
        CssJs.color CssJs.aliceblue;
        CssJs.selector "a" [| CssJs.color CssJs.rebeccapurple |];
      |]
  in
  let css = render_style_tag () in
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
  let css = render_style_tag () in
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
  let css = render_style_tag () in
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
  let css = render_style_tag () in
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
  let css = render_style_tag () in
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
  let css = render_style_tag () in
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
  let css = render_style_tag () in
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
  let css = render_style_tag () in
  assert_string css
    (Printf.sprintf
       "@keyframes %s { 0%% { -webkit-transform: rotate(0deg); -moz-transform: \
        rotate(0deg); -ms-transform: rotate(0deg); transform: rotate(0deg); } \
        100%% { -webkit-transform: rotate(-360deg); -moz-transform: \
        rotate(-360deg); -ms-transform: rotate(-360deg); transform: \
        rotate(-360deg); } } .%s { -webkit-animation-name: %s; animation-name: \
        %s; }"
       animationName className animationName animationName)

let duplicated_styles_unique () =
  let className1 = CssJs.style [| CssJs.flexGrow 1. |] in
  let className2 = CssJs.style [| CssJs.flexGrow 1. |] in
  let css = render_style_tag () in
  assert_string className1 className2;
  assert_string css (Printf.sprintf ".%s { flex-grow: 1; }" className1)

let case title fn = Alcotest.test_case title `Quick fn

let tests =
  ( "Emotion (CssJs)",
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
      case "duplicated_styles_unique" duplicated_styles_unique;
      case "selector_with_ppx" selector_with_ppx;
      case "hash_collision" hash_collision;
      (* case "random_classname" random_classname; *)
      (* case "interpolated_selector_with_ppx" interpolated_selector_with_ppx; *)
      (* case "label_ppx_unique" label_ppx_unique; *)
    ] )
