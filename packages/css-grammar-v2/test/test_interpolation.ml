open Css_grammar_v2

let parse_with_rule rule input =
  let tokens_with_loc = Styled_ppx_css_parser.Lexer.from_string input in
  let tokens =
    List.filter_map
      (fun (twl : Styled_ppx_css_parser.Lexer.token_with_location) ->
        match twl.txt with Ok tok -> Some tok | Error _ -> None)
      tokens_with_loc
  in
  let tokens_without_ws =
    List.filter (fun tok -> tok <> Styled_ppx_css_parser.Parser.WS) tokens
  in
  match rule tokens_without_ws with
  | Ok value, [] -> Ok value
  | Ok value, _ :: _ -> Ok value
  | Error errors, _ -> Error (String.concat "\n" errors)

let test_margin_full_interpolation () =
  match Spec.parse Properties.margin "$(x)" with
  | Ok [ `Length (`Interpolation [ "x" ]) ] ->
    let result =
      Properties.margin.extract_interpolations
        [ `Length (`Interpolation [ "x" ]) ]
    in
    Alcotest.(check (list (pair string string)))
      "full interpolation extracts with type path"
      [ "x", "Css_types.Length" ]
      result
  | Ok [ `Percentage (`Interpolation [ "x" ]) ] ->
    let result =
      Properties.margin.extract_interpolations
        [ `Percentage (`Interpolation [ "x" ]) ]
    in
    Alcotest.(check (list (pair string string)))
      "full interpolation extracts with type path"
      [ "x", "Css_types.Percentage" ]
      result
  | Ok _ -> Alcotest.fail "Expected Length or Percentage with Interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_margin_partial_interpolation () =
  match Spec.parse Properties.margin "$(x) 10px" with
  | Ok [ `Length (`Interpolation [ "x" ]); `Length (`Px _) ]
  | Ok [ `Percentage (`Interpolation [ "x" ]); `Length (`Px _) ] ->
    ()
  | Ok _ -> Alcotest.fail "Expected interpolation and length"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_line_height_interpolation () =
  match Spec.parse Properties.line_height "$(lh)" with
  | Ok (`Number (`Interpolation [ "lh" ])) ->
    let result =
      Properties.line_height.extract_interpolations
        (`Number (`Interpolation [ "lh" ]))
    in
    Alcotest.(check (list (pair string string)))
      "line-height interpolation via number"
      [ "lh", "Css_types.Number" ]
      result
  | Ok (`Length (`Interpolation [ "lh" ])) ->
    let result =
      Properties.line_height.extract_interpolations
        (`Length (`Interpolation [ "lh" ]))
    in
    Alcotest.(check (list (pair string string)))
      "line-height interpolation via length"
      [ "lh", "Css_types.Length" ]
      result
  | Ok (`Percentage (`Interpolation [ "lh" ])) ->
    let result =
      Properties.line_height.extract_interpolations
        (`Percentage (`Interpolation [ "lh" ]))
    in
    Alcotest.(check (list (pair string string)))
      "line-height interpolation via percentage"
      [ "lh", "Css_types.Percentage" ]
      result
  | Ok _ ->
    Alcotest.fail "Expected interpolation in number, length or percentage"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_no_interpolation_returns_empty () =
  match Spec.parse Properties.margin "10px 20px" with
  | Ok values ->
    let result = Properties.margin.extract_interpolations values in
    Alcotest.(check (list (pair string string)))
      "no interpolation returns empty" [] result
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_mixed_values_extracts_only_interpolations () =
  match Spec.parse Properties.margin "$(a) 10px $(b) auto" with
  | Ok values ->
    let result = Properties.margin.extract_interpolations values in
    Alcotest.(check int) "extracts 2 interpolations" 2 (List.length result);
    Alcotest.(check bool)
      "first is 'a'" true
      (List.exists (fun (name, _) -> name = "a") result);
    Alcotest.(check bool)
      "second is 'b'" true
      (List.exists (fun (name, _) -> name = "b") result)
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_calc_parses () =
  match Spec.parse Properties.margin "calc(10px + 20px)" with
  | Ok [ `Length (`Calc _) ] -> ()
  | Ok [ `Percentage (`Calc _) ] -> ()
  | Ok _ -> Alcotest.fail "Expected calc expression"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_length_interpolation_direct () =
  match parse_with_rule Standard.length "$(x)" with
  | Ok (`Interpolation [ "x" ]) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation in length"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_percentage_interpolation_direct () =
  match parse_with_rule Standard.percentage "$(pct)" with
  | Ok (`Interpolation [ "pct" ]) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation in percentage"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_number_interpolation_direct () =
  match parse_with_rule Standard.number "$(num)" with
  | Ok (`Interpolation [ "num" ]) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation in number"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let tests =
  ( "Interpolation extraction",
    [
      Alcotest.test_case "margin full interpolation" `Quick
        test_margin_full_interpolation;
      Alcotest.test_case "margin partial interpolation" `Quick
        test_margin_partial_interpolation;
      Alcotest.test_case "line-height interpolation" `Quick
        test_line_height_interpolation;
      Alcotest.test_case "no interpolation returns empty" `Quick
        test_no_interpolation_returns_empty;
      Alcotest.test_case "mixed values extracts only interpolations" `Quick
        test_mixed_values_extracts_only_interpolations;
      Alcotest.test_case "calc parses" `Quick test_calc_parses;
      Alcotest.test_case "length interpolation direct" `Quick
        test_length_interpolation_direct;
      Alcotest.test_case "percentage interpolation direct" `Quick
        test_percentage_interpolation_direct;
      Alcotest.test_case "number interpolation direct" `Quick
        test_number_interpolation_direct;
    ] )
