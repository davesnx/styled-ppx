open Css_grammar_v2

module Optional_test = [%spec_module "<length>? | 'b'"]
module Multiple_keywords = [%spec_module "'left' | 'right' | 'top' | 'bottom' | 'center' | 'auto'"]
module Repeated_type = [%spec_module "<length>+"]
module Comma_separated = [%spec_module "<length>#"]
module Range_repeat_2_3 = [%spec_module "<length>{2,3}"]
module Range_repeat_1_4 = [%spec_module "<length>{1,4}"]
module Nested_group = [%spec_module "[ <length> | <percentage> ]+"]
module Keyword_with_hyphen = [%spec_module "'flex-start' | 'flex-end' | 'space-between' | 'space-around'"]
module Function_test = [%spec_module "<length>"]
module Integer_test = [%spec_module "<integer>+"]
module Angle_test = [%spec_module "<angle>"]
module Time_test = [%spec_module "<time>"]
module Percentage_test = [%spec_module "<percentage>"]
module Number_test = [%spec_module "<number>"]
module Tuple_length_percentage = [%spec_module "<length> <percentage>"]
module Tuple_three = [%spec_module "<length> <number> <percentage>"]
module Tuple_with_keyword = [%spec_module "<length> [ 'auto' | 'none' ]"]
module Optional_second = [%spec_module "<length> <percentage>?"]

let test_optional_length () =
  match Optional_test.parse "10px" with
  | Ok (`Length (Some _)) -> ()
  | Ok _ -> Alcotest.fail "Expected Length with Some value"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_optional_none () =
  match Optional_test.parse "b" with
  | Ok `B -> ()
  | Ok _ -> Alcotest.fail "Expected B"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_all_keywords () =
  let keywords = [ "left"; "right"; "top"; "bottom"; "center"; "auto" ] in
  List.iter
    (fun kw ->
      match Multiple_keywords.parse kw with
      | Ok _ -> ()
      | Error e -> Alcotest.fail ("Parse error for " ^ kw ^ ": " ^ e))
    keywords

let test_keywords_case_insensitive () =
  let variants = [ "LEFT"; "Left"; "lEfT" ] in
  List.iter
    (fun kw ->
      match Multiple_keywords.parse kw with
      | Ok `Left -> ()
      | Ok _ -> Alcotest.fail ("Expected Left for " ^ kw)
      | Error e -> Alcotest.fail ("Parse error for " ^ kw ^ ": " ^ e))
    variants

let test_one_or_more () =
  match Repeated_type.parse "10px 20px 30px" with
  | Ok values when List.length values = 3 -> ()
  | Ok values ->
    Alcotest.fail
      (Printf.sprintf "Expected 3 values, got %d" (List.length values))
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_one_or_more_single () =
  match Repeated_type.parse "10px" with
  | Ok [ _ ] -> ()
  | Ok _ -> Alcotest.fail "Expected 1 value"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_one_or_more_empty_fails () =
  match Repeated_type.parse "" with
  | Error _ -> ()
  | Ok _ -> Alcotest.fail "Expected error for empty input"

let test_comma_separated () =
  match Comma_separated.parse "10px, 20px, 30px" with
  | Ok values when List.length values = 3 -> ()
  | Ok values ->
    Alcotest.fail
      (Printf.sprintf "Expected 3 comma values, got %d" (List.length values))
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_range_2_3_min () =
  match Range_repeat_2_3.parse "10px 20px" with
  | Ok values when List.length values = 2 -> ()
  | Ok _ -> Alcotest.fail "Expected 2 values"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_range_2_3_max () =
  match Range_repeat_2_3.parse "10px 20px 30px" with
  | Ok values when List.length values = 3 -> ()
  | Ok _ -> Alcotest.fail "Expected 3 values"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_range_2_3_below_min_fails () =
  match Range_repeat_2_3.parse "10px" with
  | Error _ -> ()
  | Ok _ -> Alcotest.fail "Expected error for single value"

let test_range_2_3_above_max () =
  match Range_repeat_2_3.parse "10px 20px 30px 40px" with
  | Ok [ _; _; _ ] -> ()
  | Ok _ -> Alcotest.fail "Should parse only 3 values"
  | Error _ -> ()

let test_nested_group_mixed () =
  match Nested_group.parse "10px 50% 20px" with
  | Ok values when List.length values = 3 -> ()
  | Ok _ -> Alcotest.fail "Expected 3 mixed values"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_hyphenated_keywords () =
  let keywords =
    [
      "flex-start", `Flex_start;
      "flex-end", `Flex_end;
      "space-between", `Space_between;
      "space-around", `Space_around;
    ]
  in
  List.iter
    (fun (input, expected) ->
      match Keyword_with_hyphen.parse input with
      | Ok v when v = expected -> ()
      | Ok _ -> Alcotest.fail ("Wrong variant for " ^ input)
      | Error e -> Alcotest.fail ("Parse error for " ^ input ^ ": " ^ e))
    keywords

let test_hyphenated_case_insensitive () =
  match Keyword_with_hyphen.parse "FLEX-START" with
  | Ok `Flex_start -> ()
  | Ok _ -> Alcotest.fail "Expected Flex_start"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_calc_in_spec () =
  match Function_test.parse "calc(100% - 20px)" with
  | Ok (`Calc _) -> ()
  | Ok _ -> Alcotest.fail "Expected calc"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_interpolation_in_spec () =
  match Function_test.parse "$(var)" with
  | Ok (`Interpolation _) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_min_in_spec () =
  match Function_test.parse "min(10px, 50%)" with
  | Ok (`Min _) -> ()
  | Ok _ -> Alcotest.fail "Expected min"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_max_in_spec () =
  match Function_test.parse "max(10px, 50%)" with
  | Ok (`Max _) -> ()
  | Ok _ -> Alcotest.fail "Expected max"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_clamp_in_spec () =
  match Function_test.parse "clamp(10px, 50%, 100px)" with
  | Ok (`Clamp _) -> ()
  | Ok _ -> Alcotest.fail "Expected clamp"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_extract_from_optional () =
  match Optional_test.parse "$(x)" with
  | Ok (`Length (Some (`Interpolation _))) ->
    let result =
      Optional_test.extract_interpolations
        (`Length (Some (`Interpolation [ "x" ])))
    in
    Alcotest.(check int) "extracts 1" 1 (List.length result)
  | Ok _ -> Alcotest.fail "Expected interpolation in optional"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_extract_from_repeated () =
  let values = [ `Interpolation [ "a" ]; `Px 10.; `Interpolation [ "b" ] ] in
  let result = Repeated_type.extract_interpolations values in
  Alcotest.(check int) "extracts 2" 2 (List.length result)

let test_extract_from_nested_group () =
  let values =
    [
      `Length (`Interpolation [ "x" ]);
      `Percentage (`Percentage 50.);
      `Length (`Px 10.);
    ]
  in
  let result = Nested_group.extract_interpolations values in
  Alcotest.(check int) "extracts 1" 1 (List.length result)

let test_integer_parsing () =
  match Integer_test.parse "1 2 3" with
  | Ok values when List.length values = 3 -> ()
  | Ok _ -> Alcotest.fail "Expected 3 integers"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_integer_interpolation () =
  match Integer_test.parse "$(n)" with
  | Ok [ `Interpolation _ ] -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_angle_calc () =
  match Angle_test.parse "calc(45deg + 90deg)" with
  | Ok (`Calc _) -> ()
  | Ok _ -> Alcotest.fail "Expected calc angle"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_angle_interpolation () =
  match Angle_test.parse "$(rotation)" with
  | Ok (`Interpolation _) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_time_parsing () =
  match Time_test.parse "500ms" with
  | Ok (`Ms _) -> ()
  | Ok _ -> Alcotest.fail "Expected Ms"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_time_interpolation () =
  match Time_test.parse "$(duration)" with
  | Ok (`Interpolation _) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_percentage_calc () =
  match Percentage_test.parse "calc(50% + 25%)" with
  | Ok (`Calc _) -> ()
  | Ok _ -> Alcotest.fail "Expected calc percentage"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_number_calc () =
  match Number_test.parse "calc(1 + 2)" with
  | Ok (`Calc _) -> ()
  | Ok _ -> Alcotest.fail "Expected calc number"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_number_interpolation () =
  match Number_test.parse "$(opacity)" with
  | Ok (`Interpolation _) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_tuple_length_percentage () =
  match Tuple_length_percentage.parse "10px 50%" with
  | Ok (`Px 10., `Percentage 50.) -> ()
  | Ok _ -> Alcotest.fail "Expected (Px 10, Percentage 50)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_tuple_length_percentage_interpolation () =
  match Tuple_length_percentage.parse "$(x) 50%" with
  | Ok (`Interpolation _, `Percentage _) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation in first"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_tuple_length_percentage_both_interpolation () =
  match Tuple_length_percentage.parse "$(x) $(y)" with
  | Ok (`Interpolation _, `Interpolation _) -> ()
  | Ok _ -> Alcotest.fail "Expected both interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_tuple_three () =
  match Tuple_three.parse "10px 2 50%" with
  | Ok (`Px 10., `Number 2., `Percentage 50.) -> ()
  | Ok _ -> Alcotest.fail "Expected (10px, 2, 50%)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_tuple_with_keyword_auto () =
  match Tuple_with_keyword.parse "10px auto" with
  | Ok (`Px 10., `Auto) -> ()
  | Ok _ -> Alcotest.fail "Expected (10px, auto)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_tuple_with_keyword_none () =
  match Tuple_with_keyword.parse "10px none" with
  | Ok (`Px 10., `None) -> ()
  | Ok _ -> Alcotest.fail "Expected (10px, none)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_optional_second_present () =
  match Optional_second.parse "10px 50%" with
  | Ok (`Px 10., Some (`Percentage 50.)) -> ()
  | Ok _ -> Alcotest.fail "Expected (10px, Some 50%)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_optional_second_absent () =
  match Optional_second.parse "10px" with
  | Ok (`Px 10., None) -> ()
  | Ok (_, Some _) -> Alcotest.fail "Expected None for second"
  | Ok _ -> Alcotest.fail "Expected (10px, None)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_extract_from_tuple () =
  let result =
    Tuple_length_percentage.extract_interpolations
      (`Interpolation [ "x" ], `Percentage 50.)
  in
  Alcotest.(check int) "extracts 1" 1 (List.length result);
  Alcotest.(check string)
    "type is Length" "Css_types.Length"
    (snd (List.hd result))

let test_extract_from_tuple_both () =
  let result =
    Tuple_length_percentage.extract_interpolations
      (`Interpolation [ "x" ], `Interpolation [ "y" ])
  in
  Alcotest.(check int) "extracts 2" 2 (List.length result)

let tests =
  ( "PPX edge cases",
    [
      Alcotest.test_case "optional length" `Quick test_optional_length;
      Alcotest.test_case "optional none" `Quick test_optional_none;
      Alcotest.test_case "all keywords" `Quick test_all_keywords;
      Alcotest.test_case "keywords case insensitive" `Quick
        test_keywords_case_insensitive;
      Alcotest.test_case "one or more" `Quick test_one_or_more;
      Alcotest.test_case "one or more single" `Quick test_one_or_more_single;
      Alcotest.test_case "one or more empty fails" `Quick
        test_one_or_more_empty_fails;
      Alcotest.test_case "comma separated" `Quick test_comma_separated;
      Alcotest.test_case "range 2-3 min" `Quick test_range_2_3_min;
      Alcotest.test_case "range 2-3 max" `Quick test_range_2_3_max;
      Alcotest.test_case "range 2-3 below min fails" `Quick
        test_range_2_3_below_min_fails;
      Alcotest.test_case "range 2-3 above max" `Quick test_range_2_3_above_max;
      Alcotest.test_case "nested group mixed" `Quick test_nested_group_mixed;
      Alcotest.test_case "hyphenated keywords" `Quick test_hyphenated_keywords;
      Alcotest.test_case "hyphenated case insensitive" `Quick
        test_hyphenated_case_insensitive;
      Alcotest.test_case "calc in spec" `Quick test_calc_in_spec;
      Alcotest.test_case "interpolation in spec" `Quick
        test_interpolation_in_spec;
      Alcotest.test_case "min in spec" `Quick test_min_in_spec;
      Alcotest.test_case "max in spec" `Quick test_max_in_spec;
      Alcotest.test_case "clamp in spec" `Quick test_clamp_in_spec;
      Alcotest.test_case "extract from optional" `Quick
        test_extract_from_optional;
      Alcotest.test_case "extract from repeated" `Quick
        test_extract_from_repeated;
      Alcotest.test_case "extract from nested group" `Quick
        test_extract_from_nested_group;
      Alcotest.test_case "integer parsing" `Quick test_integer_parsing;
      Alcotest.test_case "integer interpolation" `Quick
        test_integer_interpolation;
      Alcotest.test_case "angle calc" `Quick test_angle_calc;
      Alcotest.test_case "angle interpolation" `Quick test_angle_interpolation;
      Alcotest.test_case "time parsing" `Quick test_time_parsing;
      Alcotest.test_case "time interpolation" `Quick test_time_interpolation;
      Alcotest.test_case "percentage calc" `Quick test_percentage_calc;
      Alcotest.test_case "number calc" `Quick test_number_calc;
      Alcotest.test_case "number interpolation" `Quick test_number_interpolation;
      Alcotest.test_case "tuple length percentage" `Quick
        test_tuple_length_percentage;
      Alcotest.test_case "tuple length percentage interpolation" `Quick
        test_tuple_length_percentage_interpolation;
      Alcotest.test_case "tuple length percentage both interpolation" `Quick
        test_tuple_length_percentage_both_interpolation;
      Alcotest.test_case "tuple three" `Quick test_tuple_three;
      Alcotest.test_case "tuple with keyword auto" `Quick
        test_tuple_with_keyword_auto;
      Alcotest.test_case "tuple with keyword none" `Quick
        test_tuple_with_keyword_none;
      Alcotest.test_case "optional second present" `Quick
        test_optional_second_present;
      Alcotest.test_case "optional second absent" `Quick
        test_optional_second_absent;
      Alcotest.test_case "extract from tuple" `Quick test_extract_from_tuple;
      Alcotest.test_case "extract from tuple both" `Quick
        test_extract_from_tuple_both;
    ] )
