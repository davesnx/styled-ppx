let get_string_style_rules () =
  let content = CssJs.get_stylesheet () in
  let _ = CssJs.flush () in
  content

let one_property =
  test "one_property" @@ fun () ->
  let classname = CssJs.style [| CssJs.display `block |] in
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf ".%s { display: block; }" classname)

let multiple_properties =
  test "multiple_properties" @@ fun () ->
  let classname =
    CssJs.style [| CssJs.display `block; CssJs.fontSize (`px 10) |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { display: block; font-size: 10px; }" classname)

let multiple_declarations =
  test "multiple_declarations" @@ fun () ->
  let classname1 =
    CssJs.style [| CssJs.display `block; CssJs.fontSize (`px 10) |]
  in
  let classname2 =
    CssJs.style [| CssJs.display `block; CssJs.fontSize (`px 99) |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; font-size: 10px; } .%s { display: block; \
        font-size: 99px; }"
       classname1 classname2)

let label =
  test "label" @@ fun () ->
  let classname =
    CssJs.style [| CssJs.label "classname"; CssJs.display `block |]
  in
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf ".%s { display: block; }" classname)

let selector_with_ppx =
  test "selector_with_ppx" @@ fun () ->
  let classname =
    [%cx {|
    color: red;

    & > * {
      color: blue;
    }
  |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { color: #FF0000; } .%s > * { color: #0000FF; }"
       classname classname)

let avoid_hash_collision =
  test "avoid_hash_collision" @@ fun () ->
  let classname1 =
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
  let classname2 =
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
  let classname3 =
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
  assert_not_equal_string classname1 classname2;
  assert_not_equal_string classname2 classname3;
  assert_not_equal_string classname1 classname3

let float_values =
  test "float_values" @@ fun () ->
  let classname = CssJs.style [| CssJs.padding (`rem 10.) |] in
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf ".%s { padding: 10rem; }" classname)

let selector_one_nesting =
  test "selector_one_nesting" @@ fun () ->
  let classname =
    CssJs.style
      [|
        CssJs.color CssJs.aliceblue;
        CssJs.selector "a" [| CssJs.color CssJs.rebeccapurple |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { color: #F0F8FF; } .%s a { color: #663399; }"
       classname classname)

let selector_nested =
  test "selector_nested" @@ fun () ->
  let classname =
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
       classname classname classname)

let selector_nested_x10 =
  test "selector_nested_x10" @@ fun () ->
  let classname =
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
       classname classname classname classname classname classname)

let selector_ampersand =
  test "selector_ampersand" @@ fun () ->
  let classname =
    CssJs.style
      [|
        CssJs.fontSize (`px 42);
        CssJs.selector "& .div" [| CssJs.fontSize (`px 24) |];
      |]
  in
  CssJs.print_rules
    [|
      CssJs.fontSize (`px 42);
      CssJs.selector "& .div" [| CssJs.fontSize (`px 24) |];
    |];
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { font-size: 42px; } .%s .div { font-size: 24px; }"
       classname classname)

let selector_ampersand_at_the_middle =
  test "selector_ampersand_at_the_middle" @@ fun () ->
  let classname =
    CssJs.style
      [|
        CssJs.fontSize (`px 42);
        CssJs.selector "& div &" [| CssJs.fontSize (`px 24) |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { font-size: 42px; } .%s div .%s { font-size: 24px; }"
       classname classname classname)

let media_queries =
  test "media_queries" @@ fun () ->
  let classname =
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
        300px; }  }"
       classname classname)

let selector_params =
  test "selector_params" @@ fun () ->
  let classname =
    CssJs.style
      [|
        CssJs.maxWidth (`px 800); CssJs.firstChild [| CssJs.width (`px 300) |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { max-width: 800px; } .%s:first-child { width: 300px; }" classname
       classname)

let keyframe =
  test "keyframe" @@ fun () ->
  let animationName =
    CssJs.keyframes
      [|
        0, [| CssJs.transform (`rotate (`deg 0.)) |];
        100, [| CssJs.transform (`rotate (`deg (-360.))) |];
      |]
  in
  let classname = CssJs.style [| CssJs.animationName animationName |] in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       "@keyframes %s { 0%% { -webkit-transform: rotate(0deg); -moz-transform: \
        rotate(0deg); -ms-transform: rotate(0deg); transform: rotate(0deg); } \
        100%% { -webkit-transform: rotate(-360deg); -moz-transform: \
        rotate(-360deg); -ms-transform: rotate(-360deg); transform: \
        rotate(-360deg); } } .%s { -webkit-animation-name: %s; animation-name: \
        %s; }"
       animationName classname animationName animationName)

let global =
  test "global" @@ fun () ->
  CssJs.global [| CssJs.selector "html" [| CssJs.lineHeight (`abs 1.15) |] |];
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf "html{line-height:1.15;}")

let duplicated_styles_unique =
  test "duplicated_styles_unique" @@ fun () ->
  let classname1 = CssJs.style [| CssJs.flexGrow 1. |] in
  let classname2 = CssJs.style [| CssJs.flexGrow 1. |] in
  let css = get_string_style_rules () in
  assert_string classname1 classname2;
  assert_string css (Printf.sprintf ".%s { flex-grow: 1; }" classname1)

let hover_selector =
  test "hover_selector" @@ fun () ->
  let rules =
    [|
      CssJs.color (`rgb (255, 255, 255));
      CssJs.selector ":hover"
        [| CssJs.color (`rgba (255, 255, 255, `num 0.7)) |];
      CssJs.selector "&:hover"
        [| CssJs.color (`rgba (255, 255, 255, `num 0.7)) |];
      CssJs.selector " :hover"
        [| CssJs.color (`rgba (255, 255, 255, `num 0.7)) |];
    |]
  in
  let classname = CssJs.style rules in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { color: rgb(255, 255, 255); } .%s :hover { color: rgba(255, 255, \
        255, 0.7); } .%s:hover { color: rgba(255, 255, 255, 0.7); } .%s  \
        :hover { color: rgba(255, 255, 255, 0.7); }"
       classname classname classname classname)

let pseudo =
  test "pseudo" @@ fun () ->
  let classname =
    [%cx
      {|
          padding: 0;

          &::before,
          &::after {
            content: "";
            transform: translateX(-50%);
          }
        |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { padding: 0; } .%s::before, .%s::after { content: \"\"; \
        -webkit-transform: translateX(-50%%); -moz-transform: \
        translateX(-50%%); -ms-transform: translateX(-50%%); transform: \
        translateX(-50%%); }"
       classname classname classname)

let nested_selectors =
  test "nested_selectors" @@ fun () ->
  let button_active = [%cx "background-color: red;"] in
  let classname = [%cx {|
     &.$(button_active) { top: 50px; }
   |}] in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { background-color: #FF0000; } .%s {  } .%s.%s { top: 50px; }"
       button_active classname classname button_active)

let nested_selectors_2 =
  test "nested_selectors_2" @@ fun () ->
  let button_active = [%cx "background-color: red;"] in
  let classname = [%cx {|
     &.$(button_active) & { top: 50px; }
   |}] in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { background-color: #FF0000; } .%s {  } .%s.%s .%s { top: 50px; }"
       button_active classname classname button_active classname)

let multiple_selectors =
  test "multiple_selectors" @@ fun () ->
  let classname =
    [%cx
      {|
      background-color: red;

      &::before,
      &::after {
        top: 50px;
      }
  |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { background-color: #FF0000; } .%s::before, .%s::after { top: \
        50px; }"
       classname classname classname)

let multiple_nested_pseudo_selectors =
  test "multiple_nested_pseudo_selectors" @@ fun () ->
  let classname =
    [%cx
      {|
      background-color: red;
      &:hover {
        &::after {
          top: 50px;
        }
      }
  |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { background-color: #FF0000; } .%s:hover {  } .%s:hover::after { \
        top: 50px; }"
       classname classname classname)

let nested_pseudo_with_interp =
  test "nested_pseudo_with_interp" @@ fun () ->
  let button_active = [%cx "background-color: green;"] in
  let rules =
    [|
      CssJs.cursor `pointer;
      CssJs.selector
        ({js|&.|js} ^ button_active ^ {js|::before|js})
        [| CssJs.top (`pxFloat 50.) |];
    |]
  in
  let classname = CssJs.style rules in
  CssJs.print_rules rules;
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { background-color: #008000; } .%s { cursor: pointer; } \
        .%s.%s::before { top: 50px; }"
       button_active classname classname button_active)

let style_tag =
  test "style_tag" @@ fun () ->
  CssJs.global [| CssJs.selector "html" [| CssJs.lineHeight (`abs 1.15) |] |];
  let animationName =
    CssJs.keyframes
      [|
        0, [| CssJs.transform (`rotate (`deg 0.)) |];
        100, [| CssJs.transform (`rotate (`deg (-360.))) |];
      |]
  in
  let animationNameHash =
    String.sub animationName 10 (String.length animationName - 10)
  in
  let classname = CssJs.style [| CssJs.display `block |] in
  let classname_hash = String.sub classname 4 (String.length classname - 4) in
  let css = CssJs.style_tag () |> ReactDOM.renderToString in
  let _ = CssJs.flush () in
  (* This is the hash of the global styles, since we don't capture it with global, we inline it for the test *)
  let global_hash = "18zdck7" in
  assert_string css
    (Printf.sprintf
       "<style data-reactroot=\"\" data-emotion=\"css %s %s %s\" \
        data-s>html{line-height:1.15;} @keyframes %s { 0%% { \
        -webkit-transform: rotate(0deg); -moz-transform: rotate(0deg); \
        -ms-transform: rotate(0deg); transform: rotate(0deg); } 100%% { \
        -webkit-transform: rotate(-360deg); -moz-transform: rotate(-360deg); \
        -ms-transform: rotate(-360deg); transform: rotate(-360deg); } } .%s { \
        display: block; }</style>"
       global_hash animationNameHash classname_hash animationName classname)

let ampersand_selector_with_classname =
  test "ampersand_selector_with_classname" @@ fun () ->
  let nested_classname = CssJs.style [||] in
  let rules =
    [|
      CssJs.display `block;
      CssJs.selector ("&" ^ nested_classname)
        [| CssJs.media "(min-width: 768px)" [| CssJs.height `auto |] |];
    |]
  in
  let classname = CssJs.style rules in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; } @media (min-width: 768px) { .%s {  } .%s { \
        height: auto; } }"
       classname classname classname)

let selector_with_classname =
  test "selector_with_classname" @@ fun () ->
  let nested_classname = CssJs.style [||] in
  let rules =
    [|
      CssJs.display `block;
      CssJs.selector
        (".lola " ^ nested_classname)
        [| CssJs.media "(min-width: 768px)" [| CssJs.height `auto |] |];
    |]
  in
  let classname = CssJs.style rules in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; } @media (min-width: 768px) { .%s {  } .%s \
        .lola  { height: auto; } }"
       classname classname classname)

let media_queries_with_selectors =
  test "media_queries_with_selectors" @@ fun () ->
  let rules =
    [|
      CssJs.display `block;
      CssJs.media "(min-width: 768px)"
        [|
          CssJs.height `auto;
          CssJs.selector ".lola" [| CssJs.color `transparent |];
        |];
    |]
  in
  let classname = CssJs.style rules in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; } @media (min-width: 768px) { .%s { height: \
        auto; } .%s .lola { color: transparent; } }"
       classname classname classname)

let media_queries_nested =
  test "media_queries_nested" @@ fun () ->
  let classname =
    CssJs.style
      [|
        CssJs.maxWidth (`px 800);
        CssJs.media "(min-width: 300px)"
          [| CssJs.media "(max-width: 768px)" [| CssJs.display `flex |] |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { max-width: 800px; } @media (max-width: 768px) and (min-width: \
        300px) { .%s { display: flex; }  }"
       classname classname)

let media_queries_nested_2 =
  test "media_queries_nested_2" @@ fun () ->
  let classname =
    CssJs.style
      [|
        CssJs.maxWidth (`px 800);
        CssJs.media "(min-width: 300px)"
          [|
            CssJs.position `fixed;
            CssJs.media "(max-width: 768px)" [| CssJs.display `flex |];
          |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { max-width: 800px; } @media (min-width: 300px) { .%s { position: \
        fixed; }  } @media (max-width: 768px) and (min-width: 300px) { .%s { \
        display: flex; }  }"
       classname classname classname)

let tests =
  ( "CssJs",
    [
      one_property;
      multiple_properties;
      multiple_declarations;
      float_values;
      selector_one_nesting;
      label;
      selector_nested;
      selector_nested_x10;
      selector_ampersand;
      selector_ampersand_at_the_middle;
      selector_params;
      keyframe;
      global;
      duplicated_styles_unique;
      selector_with_ppx;
      avoid_hash_collision;
      hover_selector;
      style_tag;
      pseudo;
      multiple_selectors;
      nested_selectors;
      nested_selectors_2;
      nested_pseudo_with_interp;
      media_queries;
      ampersand_selector_with_classname;
      selector_with_classname;
      media_queries_with_selectors;
      media_queries_nested;
      media_queries_nested_2;
    ] )
