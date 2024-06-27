let assert_string left right =
  Alcotest.check Alcotest.string "should be equal" right left

let get_string_style_rules () =
  let content = Css.get_string_style_rules () in
  let _ = Css.flush () in
  content

let one_property () =
  let className = Css.style [ Css.display `block ] in
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf ".%s { display: block; }" className)

let multiple_properties () =
  let className = Css.style [ Css.display `block; Css.fontSize (`px 10) ] in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { display: block; font-size: 10px; }" className)

let multiple_declarations () =
  let className1 = Css.style [ Css.display `block; Css.fontSize (`px 10) ] in
  let className2 = Css.style [ Css.display `block; Css.fontSize (`px 99) ] in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; font-size: 10px; } .%s { display: block; \
        font-size: 99px; }"
       className1 className2)

let label () =
  let className = Css.style [ Css.label "className"; Css.display `block ] in
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf ".%s { display: block; }" className)

let float_values () =
  let className = Css.style [ Css.padding (`rem 10.) ] in
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf ".%s { padding: 10rem; }" className)

let selector_one_nesting () =
  let className =
    Css.style
      [
        Css.color Css.aliceblue;
        Css.selector "a" [ Css.color Css.rebeccapurple ];
      ]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { color: #F0F8FF; } .%s a { color: #663399; }"
       className className)

let selector_nested () =
  let className =
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
       className className className)

let selector_nested_x10 () =
  let className =
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
       className className className className className className)

let selector_ampersand () =
  let className =
    Css.style
      [ Css.fontSize (`px 42); Css.selector "& .div" [ Css.fontSize (`px 24) ] ]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { font-size: 42px; } .%s .div { font-size: 24px; }"
       className className)

let selector_ampersand_at_the_middle () =
  let className =
    Css.style
      [
        Css.fontSize (`px 42); Css.selector "& div &" [ Css.fontSize (`px 24) ];
      ]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { font-size: 42px; } .%s div .%s { font-size: 24px; }"
       className className className)

let media_queries () =
  let className =
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
       className className)

let media_queries_nested () =
  let className =
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
       className className)

let media_queries_nested_2 () =
  let className =
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
       className className className)

let media_queries_nested_3 () =
  let className =
    Css.style
      [
        Css.maxWidth (`px 800);
        Css.media "(min-width: 300px)"
          [
            Css.media "(max-width: 768px)"
              [ Css.media "(max-width: 768px)" [ Css.display `flex ] ];
          ];
      ]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { max-width: 800px; } @media (min-width: 300px) { .%s { position: \
        fixed; }  } @media (max-width: 768px) and (min-width: 300px) { .%s { \
        display: flex; }  }"
       className className className)

let selector_params () =
  let className =
    Css.style [ Css.maxWidth (`px 800); Css.firstChild [ Css.width (`px 300) ] ]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { max-width: 800px; } .%s:first-child { width: 300px; }" className
       className)

let keyframe () =
  let animationName =
    Css.keyframes
      [
        0, [ Css.transform (`rotate (`deg 0.)) ];
        100, [ Css.transform (`rotate (`deg (-360.))) ];
      ]
  in
  let className = Css.style [ Css.animationName animationName ] in
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
  Css.global [ Css.selector "html" [ Css.lineHeight (`abs 1.15) ] ];
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf "html{line-height:1.15;}")

let duplicated_styles_unique () =
  let className1 = Css.style [ Css.flexGrow 1. ] in
  let className2 = Css.style [ Css.flexGrow 1. ] in
  let css = get_string_style_rules () in
  assert_string className1 className2;
  assert_string css (Printf.sprintf ".%s { flex-grow: 1; }" className1)

let hover_selector () =
  let className =
    Css.style
      [
        Css.color (`rgb (255, 255, 255));
        Css.selector "&:hover" [ Css.color (`rgba (255, 255, 255, `num 0.7)) ];
      ]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { color: rgb(255, 255, 255); } .%s:hover { color: rgba(255, 255, \
        255, 0.7); }"
       className className)

let ampersand_selector_with_classname () =
  let nested_classname = Css.style [] in
  let rules =
    [
      Css.display `block;
      Css.selector ("&" ^ nested_classname)
        [ Css.media "(min-width: 768px)" [ Css.height `auto ] ];
    ]
  in
  let className = Css.style rules in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; } @media (min-width: 768px) { .%s {  } .%s { \
        height: auto; } }"
       className className className)

let selector_with_classname () =
  let nested_classname = Css.style [] in
  let rules =
    [
      Css.display `block;
      Css.selector
        (".lola " ^ nested_classname)
        [ Css.media "(min-width: 768px)" [ Css.height `auto ] ];
    ]
  in
  let className = Css.style rules in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; } @media (min-width: 768px) { .%s {  } .%s \
        .lola  { height: auto; } }"
       className className className)

let media_queries_with_selectors () =
  let rules =
    [
      Css.display `block;
      Css.media "(min-width: 768px)"
        [ Css.height `auto; Css.selector ".lola" [ Css.color `transparent ] ];
    ]
  in
  let className = Css.style rules in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; } @media (min-width: 768px) { .%s { height: \
        auto; } .%s .lola { color: transparent; } }"
       className className className)

let style_tag () =
  Css.global [ Css.selector "html" [ Css.lineHeight (`abs 1.15) ] ];
  let animationName =
    Css.keyframes
      [
        0, [ Css.transform (`rotate (`deg 0.)) ];
        100, [ Css.transform (`rotate (`deg (-360.))) ];
      ]
  in
  let animationNameHash =
    String.sub animationName 10 (String.length animationName - 10)
  in
  let className = Css.style [ Css.display `block ] in
  let classNameHash = String.sub className 4 (String.length className - 4) in
  let css = Css.style_tag () |> ReactDOM.renderToString in
  let _ = Css.flush () in
  (* This is the hash of the global styles, since we don't capture it with global, we inline it for the test *)
  let globalHash = "18zdck7" in
  assert_string css
    (Printf.sprintf
       "<style data-reactroot=\"\" data-emotion=\"css %s %s %s\" \
        data-s>html{line-height:1.15;} @keyframes %s { 0%% { \
        -webkit-transform: rotate(0deg); -moz-transform: rotate(0deg); \
        -ms-transform: rotate(0deg); transform: rotate(0deg); } 100%% { \
        -webkit-transform: rotate(-360deg); -moz-transform: rotate(-360deg); \
        -ms-transform: rotate(-360deg); transform: rotate(-360deg); } } .%s { \
        display: block; }</style>"
       globalHash animationNameHash classNameHash animationName className)

let tests =
  ( "Css",
    [
      test "one_property" one_property;
      test "multiple_properties" multiple_properties;
      test "multiple_declarations" multiple_declarations;
      test "float_values" float_values;
      test "selector_one_nesting" selector_one_nesting;
      test "label" label;
      test "selector_nested" selector_nested;
      test "selector_nested_x10" selector_nested_x10;
      test "selector_ampersand" selector_ampersand;
      test "selector_ampersand_at_the_middle" selector_ampersand_at_the_middle;
      test "selector_params" selector_params;
      test "keyframe" keyframe;
      test "global" global;
      test "duplicated_styles_unique" duplicated_styles_unique;
      test "hover_selector" hover_selector;
      test "style_tag" style_tag;
      test "media_queries" media_queries;
      test "ampersand_selector_with_classname" ampersand_selector_with_classname;
      test "selector_with_classname" selector_with_classname;
      test "media_queries_with_selectors" media_queries_with_selectors;
      test "media_queries_nested" media_queries_nested;
      test "media_queries_nested_2" media_queries_nested_2;
    ] )
