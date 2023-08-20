let assert_string left right =
  Alcotest.check Alcotest.string "should be equal" right left

module CssJs = struct
  include CssJs
  (* Override CssJs.style with CssJs.style_with_hash
     so we can hide the hash from this tests. *)
  let style = CssJs.style_with_hash ~hash:"HASH"
end

let one_property () =
  let cx = CssJs.style [| CssJs.display `block |] in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css (Printf.sprintf " .%s { display: block; }" cx)

let multiple_properties () =
  let _className = CssJs.style [| CssJs.display `block; CssJs.fontSize (`px 10) |] in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css " .css-HASH { display: block; font-size: 10px; }"

let label () =
  let _rare_name = CssJs.style [| CssJs.label "className"; CssJs.display `block |] in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css " .css-HASH-className { display: block; }"

let label_with_ppx () =
  let _rare_name = [%cx {| display: block; |}] in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css " .css-HASH { display: block; }"

let float_values () =
  let _className = CssJs.style [| CssJs.padding (`rem 10.) |] in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css " .css-HASH { padding: 10rem; }"

let selector_one_nesting () =
  let _className =
    CssJs.style
      [|
        CssJs.color CssJs.aliceblue;
        CssJs.selector "a" [| CssJs.color CssJs.rebeccapurple |];
      |]
  in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css
    " .css-HASH { color: #F0F8FF; } .css-HASH a { color: #663399; }"

let selector_nested () =
  let _className =
    CssJs.style
      [|
        CssJs.color CssJs.aliceblue;
        CssJs.selector "a"
          [| CssJs.display `block; CssJs.selector "div" [| CssJs.display `none |] |];
      |]
  in
  CssJs.print_rules ([|
        CssJs.color CssJs.aliceblue;
        CssJs.selector "a"
          [| CssJs.display `block; CssJs.selector "div" [| CssJs.display `none |] |];
      |]);
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css
    " .css-HASH { color: #F0F8FF; } .css-HASH a { display: block; } \
     .css-HASH a div { display: none; }"

let selector_nested_x10 () =
  let _className =
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
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css
    " .css-HASH { display: flex; } .css-HASH a { display: block; } \
     .css-HASH a div { display: none; } .css-HASH a div span { display: \
     none; } .css-HASH a div span hr { display: none; } .css-HASH a div \
     span hr code { display: none; }"

let selector_ampersand () =
  let _className =
    CssJs.style
      [| CssJs.fontSize (`px 42); CssJs.selector "& .div" [| CssJs.fontSize (`px 24) |] |]
  in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css
    " .css-HASH { font-size: 42px; } .css-HASH  .div { font-size: 24px; }"

let selector_ampersand_at_the_middle () =
  let _className =
    CssJs.style
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
    CssJs.style
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
     CssJs.style
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
    CssJs.style [| CssJs.maxWidth (`px 800); CssJs.firstChild [| CssJs.width (`px 300) |] |]
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
  let _className = CssJs.style [| CssJs.animationName loading |] in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css
    " .css-HASH { -webkit-animation-name: random; animation-name: random; }"

let duplicated_styles_unique () =
  let _className_1 = CssJs.style [| CssJs.flexGrow 1. |] in
  let _className_2 = CssJs.style [| CssJs.flexGrow 1. |] in
  let css = CssJs.render_style_tag () in
  CssJs.flush ();
  assert_string css " .css-HASH { flex-grow: 1; }"

let case title fn = Alcotest.test_case title `Quick fn

let tests =
  ( "Emotion (CssJs)",
    [
      case "one_property" one_property;
      case "multiple_properties" multiple_properties;
      case "float_values" float_values;
      case "selector_one_nesting" selector_one_nesting;
      case "label" label;
      case "label_with_ppx" label_with_ppx;
      case "selector_nested" selector_nested;
      (* case "selector_nested_x10" selector_nested_x10; *)
      case "media_queries" media_queries;
      (* case "media_queries_nested" media_queries_nested; *)
      case "selector_ampersand" selector_ampersand;
      case "selector_ampersand_at_the_middle" selector_ampersand_at_the_middle;
      case "selector_params" selector_params;
      case "keyframe" keyframe;
      case "duplicated_styles_unique" duplicated_styles_unique;
    ] )
