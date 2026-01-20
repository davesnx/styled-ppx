open Css_grammar

module Length_percentage_simple = [%spec_module "<length> | <percentage>"]

module Css_wide_keywords_gen =
  [%spec_module "'initial' | 'inherit' | 'unset' | 'revert' | 'revert-layer'"]

let test_length_percentage_length () =
  match Length_percentage_simple.parse "10px" with
  | Ok (`Length (`Px 10.)) -> ()
  | Ok _ -> Alcotest.fail "Expected Length(Px 10)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_length_percentage_percentage () =
  match Length_percentage_simple.parse "50%" with
  | Ok (`Percentage (`Percentage 50.)) -> ()
  | Ok _ -> Alcotest.fail "Expected Percentage(Percentage 50)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_length_percentage_calc () =
  match Length_percentage_simple.parse "calc(10px + 5%)" with
  | Ok (`Length (`Calc _)) -> ()
  | Ok (`Percentage (`Calc _)) -> ()
  | Ok _ -> Alcotest.fail "Expected calc in Length or Percentage"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_length_percentage_interpolation () =
  match Length_percentage_simple.parse "$(x)" with
  | Ok (`Length (`Interpolation _)) -> ()
  | Ok (`Percentage (`Interpolation _)) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation in Length or Percentage"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_css_wide_initial () =
  match Css_wide_keywords_gen.parse "initial" with
  | Ok `Initial -> ()
  | Ok _ -> Alcotest.fail "Expected Initial"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_css_wide_inherit () =
  match Css_wide_keywords_gen.parse "inherit" with
  | Ok `Inherit -> ()
  | Ok _ -> Alcotest.fail "Expected Inherit"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_css_wide_unset () =
  match Css_wide_keywords_gen.parse "unset" with
  | Ok `Unset -> ()
  | Ok _ -> Alcotest.fail "Expected Unset"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_css_wide_revert () =
  match Css_wide_keywords_gen.parse "revert" with
  | Ok `Revert -> ()
  | Ok _ -> Alcotest.fail "Expected Revert"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_css_wide_revert_layer () =
  match Css_wide_keywords_gen.parse "revert-layer" with
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
