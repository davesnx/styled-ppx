let assert_string left right =
  Alcotest.check Alcotest.string "should be equal" right left

let one_property () =
  let className = Css.style [ Css.display `block ] in
  let css = Css.render_style_tag () in
  assert_string css (Printf.sprintf ".%s { display: block; }" className)

let multiple_properties () =
  let className = Css.style [ Css.display `block; Css.fontSize (`px 10) ] in
  let css = Css.render_style_tag () in
  assert_string css
    (Printf.sprintf ".%s { display: block; font-size: 10px; }" className)

let multiple_declarations () =
  let className1 = Css.style [ Css.display `block; Css.fontSize (`px 10) ] in
  let className2 = Css.style [ Css.display `block; Css.fontSize (`px 99) ] in
  let css = Css.render_style_tag () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; font-size: 10px; } .%s { display: block; \
        font-size: 99px; }"
       className1 className2)

let label () =
  let className = Css.style [ Css.label "className"; Css.display `block ] in
  let css = Css.render_style_tag () in
  assert_string css (Printf.sprintf ".%s { display: block; }" className)

(* let interpolated_selector_with_ppx () =
   let className2 = Css.style [ Css.label "className2"; Css.color Css.red ] in
   let className3 = Css.style [ Css.backgroundColor Css.black ] in
   let css = Css.render_style_tag () in
   assert_string css
     (Printf.sprintf ".%s { color: #FF0000; } .%s { background-color: #000000; }"
        className2 className3) *)

let float_values () =
  let className = Css.style [ Css.padding (`rem 10.) ] in
  let css = Css.render_style_tag () in
  assert_string css (Printf.sprintf ".%s { padding: 10rem; }" className)

let selector_one_nesting () =
  let className =
    Css.style
      [
        Css.color Css.aliceblue;
        Css.selector "a" [ Css.color Css.rebeccapurple ];
      ]
  in
  let css = Css.render_style_tag () in
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
  let css = Css.render_style_tag () in
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
  let css = Css.render_style_tag () in
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
  let css = Css.render_style_tag () in
  assert_string css
    (Printf.sprintf ".%s { font-size: 42px; } .%s  .div { font-size: 24px; }"
       className className)

let selector_ampersand_at_the_middle () =
  let className =
    Css.style
      [
        Css.fontSize (`px 42); Css.selector "& div &" [ Css.fontSize (`px 24) ];
      ]
  in
  let css = Css.render_style_tag () in
  assert_string css
    (Printf.sprintf ".%s { font-size: 42px; } .%s  div .%s { font-size: 24px; }"
       className className className)

let media_queries () =
  let className =
    Css.style
      [
        Css.maxWidth (`px 800);
        Css.media "(max-width: 768px)" [ Css.width (`px 300) ];
      ]
  in
  let css = Css.render_style_tag () in
  assert_string css
    (Printf.sprintf
       ".%s { max-width: 800px; } @media (max-width: 768px) { .%s { width: \
        300px; } }"
       className className)

let selector_params () =
  let className =
    Css.style [ Css.maxWidth (`px 800); Css.firstChild [ Css.width (`px 300) ] ]
  in
  let css = Css.render_style_tag () in
  assert_string css
    (Printf.sprintf
       ".%s { max-width: 800px; } .%s:first-child { width: 300px; }" className
       className)

let keyframe () =
  let loading = "random" in
  (* let loading =
       Css.keyframes
         [ (0, [ Css.transform (`rotate (`deg 0.)) ])
         ; (100, [ Css.transform (`rotate (`deg (-360.))) ])
         ]
     in *)
  let className = Css.style [ Css.animationName loading ] in
  let css = Css.render_style_tag () in
  assert_string css
    (Printf.sprintf
       ".%s { -webkit-animation-name: random; animation-name: random; }"
       className)

let duplicated_styles_unique () =
  let className1 = Css.style [ Css.flexGrow 1. ] in
  let className2 = Css.style [ Css.flexGrow 1. ] in
  let css = Css.render_style_tag () in
  assert_string className1 className2;
  assert_string css (Printf.sprintf ".%s { flex-grow: 1; }" className1)

let case title fn = Alcotest.test_case title `Quick fn

let tests =
  ( "Emotion (Css)",
    [
      case "one_property" one_property;
      case "multiple_properties" multiple_properties;
      case "multiple_declarations" multiple_declarations;
      case "float_values" float_values;
      case "selector_one_nesting" selector_one_nesting;
      case "label" label;
      (* case "label_with_ppx" label_with_ppx; *)
      case "selector_nested" selector_nested;
      case "selector_nested_x10" selector_nested_x10;
      case "media_queries" media_queries;
      case "selector_ampersand" selector_ampersand;
      case "selector_ampersand_at_the_middle" selector_ampersand_at_the_middle;
      case "selector_params" selector_params;
      case "keyframe" keyframe;
      case "duplicated_styles_unique" duplicated_styles_unique;
      (* case "selector_with_ppx" selector_with_ppx; *)
      (* case "interpolated_selector_with_ppx" interpolated_selector_with_ppx; *)
    ] )
