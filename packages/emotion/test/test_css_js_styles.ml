let assert_string left right =
  Alcotest.check Alcotest.string "should be equal" right left

module CssJs = struct
  include CssJs
  let style = CssJs.style_with_hash ~hash:"HASH"
end

let style = CssJs.style

let one_property () =
  let _className = style [| CssJs.display `block |] in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css " .css-HASH { display: block; }"

let multiple_properties () =
  let _className = style [| CssJs.display `block; CssJs.fontSize (`px 10) |] in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css " .css-HASH { display: block; font-size: 10px; }"

let label () =
  let _rare_name = style [| CssJs.label "className"; CssJs.display `block |] in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css " .css-HASH-className { display: block; }"

let label_with_ppx () =
  let _rare_name = [%cx {| display: block; |}] in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css " .css-HASH { display: block; }"

let float_values () =
  let _className = style [| CssJs.padding (`rem 10.) |] in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css " .css-HASH { padding: 10rem; }"

let selector_one_nesting () =
  let _className =
    style
      [|
        CssJs.color CssJs.aliceblue;
        CssJs.selector "a" [| CssJs.color CssJs.rebeccapurple |];
      |]
  in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css
    " .css-HASH { color: #F0F8FF; } .css-HASH a { color: #663399; }"

let selector_more_than_one_nesting () =
  let _className =
    style
      [|
        CssJs.color CssJs.aliceblue;
        CssJs.selector "a"
          [| CssJs.display `block; CssJs.selector "div" [| CssJs.display `none |] |];
      |]
  in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css
    " .css-HASH { color: #F0F8FF; } .css-HASH a { display: block; } \
     .css-HASH a div { display: none; }"

let selector_with_a_lot_of_nesting () =
  let _className =
    style
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
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css
    " .css-HASH { display: flex; } .css-HASH a { display: block; } \
     .css-HASH a div { display: none; } .css-HASH a div span { display: \
     none; } .css-HASH a div span hr { display: none; } .css-HASH a div \
     span hr code { display: none; }"

let selector_ampersand () =
  let _className =
    style
      [| CssJs.fontSize (`px 42); CssJs.selector "& .div" [| CssJs.fontSize (`px 24) |] |]
  in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css
    " .css-HASH { font-size: 42px; } .css-HASH  .div { font-size: 24px; }"

let selector_ampersand_at_the_middle () =
  let _className =
    style
      [|
        CssJs.fontSize (`px 42); CssJs.selector "& div &" [| CssJs.fontSize (`px 24) |];
      |]
  in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css
    " .css-HASH { font-size: 42px; } .css-HASH  div .css-HASH { \
     font-size: 24px; }"

let media_queries () =
  let _className =
    style
      [|
        CssJs.maxWidth (`px 800);
        CssJs.media "(max-width: 768px)" [| CssJs.width (`px 300) |];
      |]
  in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css
    " .css-HASH { max-width: 800px; } @media (max-width: 768px) { \
     .css-HASH { width: 300px; } }"

(* let media_queries_nested () =
   let _className =
     style
       [ CssJs.maxWidth (`px 800)
       ; CssJs.media "(max-width: 768px)"
           [ CssJs.width (`px 300)
           ; CssJs.media "(min-width: 400px)"
               [ CssJs.width (`px 300) ]
           ]
       ]
   in
   let css = CssJs.render_style_tag () in
   assert_string css
     ".s2073633259 { max-width: 800px; } @media (max-width: 768px) { \
      .s2073633259 { width: 300px; } }"
*)
let selector_params () =
  let _className =
    style [| CssJs.maxWidth (`px 800); CssJs.firstChild [| CssJs.width (`px 300) |] |]
  in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css
    " .css-HASH { max-width: 800px; } .css-HASH:first-child { width: \
     300px; }"

let keyframe () =
  let loading = "random" in
  (* let loading =
       CssJs.keyframes
         [ (0, [ CssJs.transform (`rotate (`deg 0.)) ])
         ; (100, [ CssJs.transform (`rotate (`deg (-360.))) ])
         ]
     in *)
  let _className = style [| CssJs.animationName loading |] in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css
    " .css-HASH { -webkit-animation-name: random; animation-name: random; }"

let empty () =
  (* an empty declaration should not print anything *)
  let className = CssJs.style [||] in
  CssJs.flush ();
  assert_string className ""

let duplicated_styles_should_push_once () =
  let _className_1 = style [| CssJs.flexGrow 1. |] in
  let _className_2 = style [| CssJs.flexGrow 1. |] in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css " .css-HASH { flex-grow: 1; }"

let case title fn = Alcotest.test_case title `Quick fn

let tests =
  ( "Emotion",
    [
      case "one_property" one_property;
      case "multiple_properties" multiple_properties;
      case "float_values" float_values;
      case "selector_one_nesting" selector_one_nesting;
      case "label" label;
      case "label_with_ppx" label_with_ppx;
      case "selector_more_than_one_nesting" selector_more_than_one_nesting;
      case "selector_with_a_lot_of_nesting" selector_with_a_lot_of_nesting;
      case "media_queries" media_queries
      (* ; case "media_queries_nested" media_queries_nested *);
      case "selector_ampersand" selector_ampersand;
      case "selector_ampersand_at_the_middle" selector_ampersand_at_the_middle;
      case "selector_params" selector_params;
      case "keyframe" keyframe;
      case "empty" empty;
      case "duplicated_styles_should_push_once"
        duplicated_styles_should_push_once;
    ] )
