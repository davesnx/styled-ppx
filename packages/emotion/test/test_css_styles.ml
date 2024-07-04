let get_string_style_rules () =
  let content = Css.get_stylesheet () in
  let _ = Css.flush () in
  content

let one_property =
  test "one_property" @@ fun () ->
  let classname = Css.style [ Css.display `block ] in
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf ".%s { display: block; }" classname)

let multiple_properties =
  test "multiple_properties" @@ fun () ->
  let classname = Css.style [ Css.display `block; Css.fontSize (`px 10) ] in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { display: block; font-size: 10px; }" classname)

let multiple_declarations =
  test "multiple_declarations" @@ fun () ->
  let classname1 = Css.style [ Css.display `block; Css.fontSize (`px 10) ] in
  let classname2 = Css.style [ Css.display `block; Css.fontSize (`px 99) ] in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; font-size: 10px; } .%s { display: block; \
        font-size: 99px; }"
       classname1 classname2)

let label =
  test "label" @@ fun () ->
  let classname = Css.style [ Css.label "classname"; Css.display `block ] in
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf ".%s { display: block; }" classname)

let float_values =
  test "float_values" @@ fun () ->
  let classname = Css.style [ Css.padding (`rem 10.) ] in
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf ".%s { padding: 10rem; }" classname)

let selector_one_nesting =
  test "selector_one_nesting" @@ fun () ->
  let classname =
    Css.style
      [
        Css.color Css.aliceblue;
        Css.selector "a" [ Css.color Css.rebeccapurple ];
      ]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { color: #F0F8FF; } .%s a { color: #663399; }"
       classname classname)

let selector_nested =
  test "selector_nested" @@ fun () ->
  let classname =
    Css.style
      [
        Css.color Css.aliceblue;
        Css.selector "a"
          [ Css.display `block; Css.selector "div" [ Css.display `none ] ];
      ]
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
    Css.style
      [
        Css.display `flex;
        Css.selector "a"
          [
            Css.display `block;
            Css.selector "div"
              [
                Css.display `none;
                Css.selector "span"
                  [
                    Css.display `none;
                    Css.selector "hr"
                      [
                        Css.display `none;
                        Css.selector "code" [ Css.display `none ];
                      ];
                  ];
              ];
          ];
      ]
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
    Css.style
      [ Css.fontSize (`px 42); Css.selector "& .div" [ Css.fontSize (`px 24) ] ]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { font-size: 42px; } .%s .div { font-size: 24px; }"
       classname classname)

let selector_ampersand_at_the_middle =
  test "selector_ampersand_at_the_middle" @@ fun () ->
  let classname =
    Css.style
      [
        Css.fontSize (`px 42); Css.selector "& div &" [ Css.fontSize (`px 24) ];
      ]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { font-size: 42px; } .%s div .%s { font-size: 24px; }"
       classname classname classname)

let media_queries =
  test "media_queries" @@ fun () ->
  let classname =
    Css.style
      [
        Css.maxWidth (`px 800);
        Css.media "(max-width: 768px)" [ Css.width (`px 300) ];
      ]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { max-width: 800px; } @media (max-width: 768px) { .%s { width: \
        300px; }  }"
       classname classname)

let media_queries_nested =
  test "media_queries_nested" @@ fun () ->
  let classname =
    Css.style
      [
        Css.maxWidth (`px 800);
        Css.media "(min-width: 300px)"
          [ Css.media "(max-width: 768px)" [ Css.display `flex ] ];
      ]
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
    Css.style
      [
        Css.maxWidth (`px 800);
        Css.media "(min-width: 300px)"
          [
            Css.position `fixed;
            Css.media "(max-width: 768px)" [ Css.display `flex ];
          ];
      ]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { max-width: 800px; } @media (min-width: 300px) { .%s { position: \
        fixed; }  } @media (max-width: 768px) and (min-width: 300px) { .%s { \
        display: flex; }  }"
       classname classname classname)

let selector_params =
  test "selector_params" @@ fun () ->
  let classname =
    Css.style [ Css.maxWidth (`px 800); Css.firstChild [ Css.width (`px 300) ] ]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { max-width: 800px; } .%s:first-child { width: 300px; }" classname
       classname)

let keyframe =
  test "keyframe" @@ fun () ->
  let animation_name =
    Css.keyframes
      [
        0, [ Css.transform (`rotate (`deg 0.)) ];
        100, [ Css.transform (`rotate (`deg (-360.))) ];
      ]
  in
  let classname = Css.style [ Css.animationName animation_name ] in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       "@keyframes %s { 0%% { -webkit-transform: rotate(0deg); -moz-transform: \
        rotate(0deg); -ms-transform: rotate(0deg); transform: rotate(0deg); } \
        100%% { -webkit-transform: rotate(-360deg); -moz-transform: \
        rotate(-360deg); -ms-transform: rotate(-360deg); transform: \
        rotate(-360deg); } } .%s { -webkit-animation-name: %s; animation-name: \
        %s; }"
       animation_name classname animation_name animation_name)

let global =
  test "global" @@ fun () ->
  Css.global [ Css.selector "html" [ Css.lineHeight (`abs 1.15) ] ];
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf "html{line-height:1.15;}")

let duplicated_styles_unique =
  test "duplicated_styles_unique" @@ fun () ->
  let classname1 = Css.style [ Css.flexGrow 1. ] in
  let classname2 = Css.style [ Css.flexGrow 1. ] in
  let css = get_string_style_rules () in
  assert_string classname1 classname2;
  assert_string css (Printf.sprintf ".%s { flex-grow: 1; }" classname1)

let hover_selector =
  test "hover_selector" @@ fun () ->
  let classname =
    Css.style
      [
        Css.color (`rgb (255, 255, 255));
        Css.selector "&:hover" [ Css.color (`rgba (255, 255, 255, `num 0.7)) ];
        Css.selector ":hover" [ Css.color (`rgba (255, 255, 255, `num 0.7)) ];
      ]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { color: rgb(255, 255, 255); } .%s:hover { color: rgba(255, 255, \
        255, 0.7); } .%s:hover { color: rgba(255, 255, 255, 0.7); }"
       classname classname classname)

let ampersand_selector_with_classname =
  test "ampersand_selector_with_classname" @@ fun () ->
  let nested_classname = Css.style [] in
  let rules =
    [
      Css.display `block;
      Css.selector ("&." ^ nested_classname)
        [ Css.media "(min-width: 768px)" [ Css.height `auto ] ];
    ]
  in
  let classname = Css.style rules in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; } @media (min-width: 768px) { .%s {  } .%s.%s { \
        height: auto; } }"
       classname classname classname nested_classname)

let selector_with_classname =
  test "selector_with_classname" @@ fun () ->
  let nested_classname = Css.style [] in
  let rules =
    [
      Css.display `block;
      Css.selector
        (".lola ." ^ nested_classname)
        [ Css.media "(min-width: 768px)" [ Css.height `auto ] ];
    ]
  in
  let classname = Css.style rules in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; } @media (min-width: 768px) { .%s {  } .%s .lola \
        .%s { height: auto; } }"
       classname classname classname nested_classname)

let media_queries_with_selectors =
  test "media_queries_with_selectors" @@ fun () ->
  let rules =
    [
      Css.display `block;
      Css.media "(min-width: 768px)"
        [ Css.height `auto; Css.selector ".lola" [ Css.color `transparent ] ];
    ]
  in
  let classname = Css.style rules in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; } @media (min-width: 768px) { .%s { height: \
        auto; } .%s .lola { color: transparent; } }"
       classname classname classname)

let style_tag =
  test "style_tag" @@ fun () ->
  Css.global [ Css.selector "html" [ Css.lineHeight (`abs 1.15) ] ];
  let animation_name =
    Css.keyframes
      [
        0, [ Css.transform (`rotate (`deg 0.)) ];
        100, [ Css.transform (`rotate (`deg (-360.))) ];
      ]
  in
  let animation_name_hash =
    String.sub animation_name 10 (String.length animation_name - 10)
  in
  let classname = Css.style [ Css.display `block ] in
  let classname_hash = String.sub classname 4 (String.length classname - 4) in
  let css = Css.style_tag () |> ReactDOM.renderToString in
  let _ = Css.flush () in
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
       global_hash animation_name_hash classname_hash animation_name classname)

let tests =
  ( "Css",
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
      hover_selector;
      style_tag;
      media_queries;
      ampersand_selector_with_classname;
      selector_with_classname;
      media_queries_with_selectors;
      media_queries_nested;
      media_queries_nested_2;
    ] )
