(* TODO: Migrate all those tests
   - https://github.com/giraud/bs-css/blob/master/bs-css/__tests__/Css_Js_test.res
   - https://github.com/giraud/bs-css/blob/master/bs-css/__tests__/Selectors_test.res
   - https://github.com/giraud/bs-css/blob/master/bs-css/__tests__/Svg_test.res
*)

let assert_string left right =
  Alcotest.check Alcotest.string "should be equal" right left

let case title fn = Alcotest.test_case title `Quick fn

let tests =
  ( "CssJs interface",
    [
      case "content" (fun () ->
        let missing = CssJs.contentRule (`text "missing") in
        let present = CssJs.contentRule (`text "\"present\"") in
        let empty = CssJs.contentRule (`text "") in
        let single = CssJs.contentRule (`text "'single'") in
        let _ = CssJs.style [| missing; present; empty; single |] in
        assert_string
          (CssJs.render_style_tag ())
          ".css-ktvasi { content: \"missing\"; content: \"present\"; content: \
           \"\"; content: 'single'; }");
    ] )
