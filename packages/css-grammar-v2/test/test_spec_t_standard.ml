open Css_grammar_v2

type length_percentage_simple = [%spec_t "<length> | <percentage>"]

let length_percentage_simple : length_percentage_simple Spec.t =
  [%spec "<length> | <percentage>"]

type css_wide_keywords_gen =
  [%spec_t "'initial' | 'inherit' | 'unset' | 'revert' | 'revert-layer'"]

let css_wide_keywords_gen : css_wide_keywords_gen Spec.t =
  [%spec "'initial' | 'inherit' | 'unset' | 'revert' | 'revert-layer'"]

let test_length_percentage_length () =
  match Spec.parse length_percentage_simple "10px" with
  | Ok (`Length (`Px 10.)) -> ()
  | Ok _ -> Alcotest.fail "Expected Length(Px 10)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_length_percentage_percentage () =
  match Spec.parse length_percentage_simple "50%" with
  | Ok (`Percentage (`Percentage 50.)) -> ()
  | Ok _ -> Alcotest.fail "Expected Percentage(Percentage 50)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_length_percentage_calc () =
  match Spec.parse length_percentage_simple "calc(10px + 5%)" with
  | Ok (`Length (`Calc _)) -> ()
  | Ok (`Percentage (`Calc _)) -> ()
  | Ok _ -> Alcotest.fail "Expected calc in Length or Percentage"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_length_percentage_interpolation () =
  match Spec.parse length_percentage_simple "$(x)" with
  | Ok (`Length (`Interpolation _)) -> ()
  | Ok (`Percentage (`Interpolation _)) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation in Length or Percentage"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_css_wide_initial () =
  match Spec.parse css_wide_keywords_gen "initial" with
  | Ok `Initial -> ()
  | Ok _ -> Alcotest.fail "Expected Initial"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_css_wide_inherit () =
  match Spec.parse css_wide_keywords_gen "inherit" with
  | Ok `Inherit -> ()
  | Ok _ -> Alcotest.fail "Expected Inherit"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_css_wide_unset () =
  match Spec.parse css_wide_keywords_gen "unset" with
  | Ok `Unset -> ()
  | Ok _ -> Alcotest.fail "Expected Unset"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_css_wide_revert () =
  match Spec.parse css_wide_keywords_gen "revert" with
  | Ok `Revert -> ()
  | Ok _ -> Alcotest.fail "Expected Revert"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_css_wide_revert_layer () =
  match Spec.parse css_wide_keywords_gen "revert-layer" with
  | Ok `Revert_layer -> ()
  | Ok _ -> Alcotest.fail "Expected Revert_layer"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let tests =
  ( "spec_t for Standard types",
    [
      Alcotest.test_case "length_percentage length" `Quick
        test_length_percentage_length;
      Alcotest.test_case "length_percentage percentage" `Quick
        test_length_percentage_percentage;
      Alcotest.test_case "length_percentage calc" `Quick
        test_length_percentage_calc;
      Alcotest.test_case "length_percentage interpolation" `Quick
        test_length_percentage_interpolation;
      Alcotest.test_case "css_wide initial" `Quick test_css_wide_initial;
      Alcotest.test_case "css_wide inherit" `Quick test_css_wide_inherit;
      Alcotest.test_case "css_wide unset" `Quick test_css_wide_unset;
      Alcotest.test_case "css_wide revert" `Quick test_css_wide_revert;
      Alcotest.test_case "css_wide revert-layer" `Quick test_css_wide_revert_layer;
    ] )
