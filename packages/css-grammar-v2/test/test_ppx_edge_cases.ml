open Css_grammar_v2

type optional_test =
  [ `Length of Standard.length option
  | `B
  ]

let optional_test : optional_test Spec.t = [%spec "<length>? | 'b'"]

type multiple_keywords =
  [ `Left
  | `Right
  | `Top
  | `Bottom
  | `Center
  | `Auto
  ]

let multiple_keywords : multiple_keywords Spec.t =
  [%spec "'left' | 'right' | 'top' | 'bottom' | 'center' | 'auto'"]

type repeated_type = Standard.length list

let repeated_type : repeated_type Spec.t = [%spec "<length>+"]

type comma_separated = Standard.length list

let comma_separated : comma_separated Spec.t = [%spec "<length>#"]

type range_repeat = Standard.length list

let range_repeat_2_3 : range_repeat Spec.t = [%spec "<length>{2,3}"]
let range_repeat_1_4 : range_repeat Spec.t = [%spec "<length>{1,4}"]

type nested_group =
  [ `Length of Standard.length | `Percentage of Standard.percentage ] list

let nested_group : nested_group Spec.t = [%spec "[ <length> | <percentage> ]+"]

type keyword_with_hyphen =
  [ `Flex_start
  | `Flex_end
  | `Space_between
  | `Space_around
  ]

let keyword_with_hyphen : keyword_with_hyphen Spec.t =
  [%spec "'flex-start' | 'flex-end' | 'space-between' | 'space-around'"]

type function_test = Standard.length

let function_test : function_test Spec.t = [%spec "<length>"]

type integer_test = Standard.integer list

let integer_test : integer_test Spec.t = [%spec "<integer>+"]

type angle_test = Standard.angle

let angle_test : angle_test Spec.t = [%spec "<angle>"]

type time_test = Standard.time

let time_test : time_test Spec.t = [%spec "<time>"]

type percentage_test = Standard.percentage

let percentage_test : percentage_test Spec.t = [%spec "<percentage>"]

type number_test = Standard.number

let number_test : number_test Spec.t = [%spec "<number>"]

type tuple_length_percentage = Standard.length * Standard.percentage

let tuple_length_percentage : tuple_length_percentage Spec.t =
  [%spec "<length> <percentage>"]

type tuple_three = Standard.length * Standard.number * Standard.percentage

let tuple_three : tuple_three Spec.t = [%spec "<length> <number> <percentage>"]

type tuple_with_keyword = Standard.length * [ `Auto | `None ]

let tuple_with_keyword : tuple_with_keyword Spec.t =
  [%spec "<length> [ 'auto' | 'none' ]"]

type optional_second = Standard.length * Standard.percentage option

let optional_second : optional_second Spec.t = [%spec "<length> <percentage>?"]

let test_optional_length () =
  match Spec.parse optional_test "10px" with
  | Ok (`Length (Some _)) -> ()
  | Ok _ -> Alcotest.fail "Expected Length with Some value"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_optional_none () =
  match Spec.parse optional_test "b" with
  | Ok `B -> ()
  | Ok _ -> Alcotest.fail "Expected B"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_all_keywords () =
  let keywords = [ "left"; "right"; "top"; "bottom"; "center"; "auto" ] in
  List.iter
    (fun kw ->
      match Spec.parse multiple_keywords kw with
      | Ok _ -> ()
      | Error e -> Alcotest.fail ("Parse error for " ^ kw ^ ": " ^ e))
    keywords

let test_keywords_case_insensitive () =
  let variants = [ "LEFT"; "Left"; "lEfT" ] in
  List.iter
    (fun kw ->
      match Spec.parse multiple_keywords kw with
      | Ok `Left -> ()
      | Ok _ -> Alcotest.fail ("Expected Left for " ^ kw)
      | Error e -> Alcotest.fail ("Parse error for " ^ kw ^ ": " ^ e))
    variants

let test_one_or_more () =
  match Spec.parse repeated_type "10px 20px 30px" with
  | Ok values when List.length values = 3 -> ()
  | Ok values ->
    Alcotest.fail
      (Printf.sprintf "Expected 3 values, got %d" (List.length values))
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_one_or_more_single () =
  match Spec.parse repeated_type "10px" with
  | Ok [ _ ] -> ()
  | Ok _ -> Alcotest.fail "Expected 1 value"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_one_or_more_empty_fails () =
  match Spec.parse ~strict:true repeated_type "" with
  | Error _ -> ()
  | Ok _ -> Alcotest.fail "Expected error for empty input"

let test_comma_separated () =
  match Spec.parse comma_separated "10px, 20px, 30px" with
  | Ok values when List.length values = 3 -> ()
  | Ok values ->
    Alcotest.fail
      (Printf.sprintf "Expected 3 comma values, got %d" (List.length values))
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_range_2_3_min () =
  match Spec.parse range_repeat_2_3 "10px 20px" with
  | Ok values when List.length values = 2 -> ()
  | Ok _ -> Alcotest.fail "Expected 2 values"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_range_2_3_max () =
  match Spec.parse range_repeat_2_3 "10px 20px 30px" with
  | Ok values when List.length values = 3 -> ()
  | Ok _ -> Alcotest.fail "Expected 3 values"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_range_2_3_below_min_fails () =
  match Spec.parse ~strict:true range_repeat_2_3 "10px" with
  | Error _ -> ()
  | Ok _ -> Alcotest.fail "Expected error for single value"

let test_range_2_3_above_max () =
  match Spec.parse ~strict:true range_repeat_2_3 "10px 20px 30px 40px" with
  | Error _ -> ()
  | Ok _ -> Alcotest.fail "Expected error for 4 values"

let test_nested_group_mixed () =
  match Spec.parse nested_group "10px 50% 20px" with
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
      match Spec.parse keyword_with_hyphen input with
      | Ok v when v = expected -> ()
      | Ok _ -> Alcotest.fail ("Wrong variant for " ^ input)
      | Error e -> Alcotest.fail ("Parse error for " ^ input ^ ": " ^ e))
    keywords

let test_hyphenated_case_insensitive () =
  match Spec.parse keyword_with_hyphen "FLEX-START" with
  | Ok `Flex_start -> ()
  | Ok _ -> Alcotest.fail "Expected Flex_start"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_calc_in_spec () =
  match Spec.parse function_test "calc(100% - 20px)" with
  | Ok (`Calc _) -> ()
  | Ok _ -> Alcotest.fail "Expected calc"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_interpolation_in_spec () =
  match Spec.parse function_test "$(var)" with
  | Ok (`Interpolation _) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_min_in_spec () =
  match Spec.parse function_test "min(10px, 50%)" with
  | Ok (`Min _) -> ()
  | Ok _ -> Alcotest.fail "Expected min"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_max_in_spec () =
  match Spec.parse function_test "max(10px, 50%)" with
  | Ok (`Max _) -> ()
  | Ok _ -> Alcotest.fail "Expected max"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_clamp_in_spec () =
  match Spec.parse function_test "clamp(10px, 50%, 100px)" with
  | Ok (`Clamp _) -> ()
  | Ok _ -> Alcotest.fail "Expected clamp"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_extract_from_optional () =
  match Spec.parse optional_test "$(x)" with
  | Ok (`Length (Some (`Interpolation _))) ->
    let result =
      optional_test.extract_interpolations
        (`Length (Some (`Interpolation [ "x" ])))
    in
    Alcotest.(check int) "extracts 1" 1 (List.length result)
  | Ok _ -> Alcotest.fail "Expected interpolation in optional"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_extract_from_repeated () =
  let values = [ `Interpolation [ "a" ]; `Px 10.; `Interpolation [ "b" ] ] in
  let result = repeated_type.extract_interpolations values in
  Alcotest.(check int) "extracts 2" 2 (List.length result)

let test_extract_from_nested_group () =
  let values =
    [
      `Length (`Interpolation [ "x" ]);
      `Percentage (`Percentage 50.);
      `Length (`Px 10.);
    ]
  in
  let result = nested_group.extract_interpolations values in
  Alcotest.(check int) "extracts 1" 1 (List.length result)

let test_integer_parsing () =
  match Spec.parse integer_test "1 2 3" with
  | Ok values when List.length values = 3 -> ()
  | Ok _ -> Alcotest.fail "Expected 3 integers"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_integer_interpolation () =
  match Spec.parse integer_test "$(n)" with
  | Ok [ `Interpolation _ ] -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_angle_calc () =
  match Spec.parse angle_test "calc(45deg + 90deg)" with
  | Ok (`Calc _) -> ()
  | Ok _ -> Alcotest.fail "Expected calc angle"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_angle_interpolation () =
  match Spec.parse angle_test "$(rotation)" with
  | Ok (`Interpolation _) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_time_parsing () =
  match Spec.parse time_test "500ms" with
  | Ok (`Ms _) -> ()
  | Ok _ -> Alcotest.fail "Expected Ms"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_time_interpolation () =
  match Spec.parse time_test "$(duration)" with
  | Ok (`Interpolation _) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_percentage_calc () =
  match Spec.parse percentage_test "calc(50% + 25%)" with
  | Ok (`Calc _) -> ()
  | Ok _ -> Alcotest.fail "Expected calc percentage"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_number_calc () =
  match Spec.parse number_test "calc(1 + 2)" with
  | Ok (`Calc _) -> ()
  | Ok _ -> Alcotest.fail "Expected calc number"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_number_interpolation () =
  match Spec.parse number_test "$(opacity)" with
  | Ok (`Interpolation _) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_tuple_length_percentage () =
  match Spec.parse tuple_length_percentage "10px 50%" with
  | Ok (`Px 10., `Percentage 50.) -> ()
  | Ok _ -> Alcotest.fail "Expected (Px 10, Percentage 50)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_tuple_length_percentage_interpolation () =
  match Spec.parse tuple_length_percentage "$(x) 50%" with
  | Ok (`Interpolation _, `Percentage _) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation in first"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_tuple_length_percentage_both_interpolation () =
  match Spec.parse tuple_length_percentage "$(x) $(y)" with
  | Ok (`Interpolation _, `Interpolation _) -> ()
  | Ok _ -> Alcotest.fail "Expected both interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_tuple_three () =
  match Spec.parse tuple_three "10px 2 50%" with
  | Ok (`Px 10., `Number 2., `Percentage 50.) -> ()
  | Ok _ -> Alcotest.fail "Expected (10px, 2, 50%)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_tuple_with_keyword_auto () =
  match Spec.parse tuple_with_keyword "10px auto" with
  | Ok (`Px 10., `Auto) -> ()
  | Ok _ -> Alcotest.fail "Expected (10px, auto)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_tuple_with_keyword_none () =
  match Spec.parse tuple_with_keyword "10px none" with
  | Ok (`Px 10., `None) -> ()
  | Ok _ -> Alcotest.fail "Expected (10px, none)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_optional_second_present () =
  match Spec.parse optional_second "10px 50%" with
  | Ok (`Px 10., Some (`Percentage 50.)) -> ()
  | Ok _ -> Alcotest.fail "Expected (10px, Some 50%)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_optional_second_absent () =
  match Spec.parse optional_second "10px" with
  | Ok (`Px 10., None) -> ()
  | Ok (_, Some _) -> Alcotest.fail "Expected None for second"
  | Ok _ -> Alcotest.fail "Expected (10px, None)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_extract_from_tuple () =
  let result =
    tuple_length_percentage.extract_interpolations
      (`Interpolation [ "x" ], `Percentage 50.)
  in
  Alcotest.(check int) "extracts 1" 1 (List.length result);
  Alcotest.(check string)
    "type is Length" "Css_types.Length"
    (snd (List.hd result))

let test_extract_from_tuple_both () =
  let result =
    tuple_length_percentage.extract_interpolations
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
