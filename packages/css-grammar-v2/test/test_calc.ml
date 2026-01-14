open Css_grammar_v2

let parse rule input =
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
  | Ok value, _ -> Ok value
  | Error errors, _ -> Error (String.concat "\n" errors)

let test_calc_simple () =
  match parse Standard.function_calc "calc(10px)" with
  | Ok _ -> ()
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_calc_addition () =
  match parse Standard.function_calc "calc(10px + 5px)" with
  | Ok (first, [ (`Add, _second) ]) ->
      let first_val, _ = first in
      (match first_val with
      | `Length (`Px 10.) -> ()
      | _ -> Alcotest.fail "Expected first value to be 10px")
  | Ok _ -> Alcotest.fail "Expected calc_sum with addition"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_calc_multiplication () =
  match parse Standard.function_calc "calc(10px * 2)" with
  | Ok (first, []) ->
      let first_val, ops = first in
      (match (first_val, ops) with
      | `Length (`Px 10.), [ `Div 2. ] ->
          Alcotest.fail "Expected multiplication not division"
      | `Length (`Px 10.), [ `Mul _ ] -> ()
      | _ -> Alcotest.fail "Unexpected calc structure")
  | Ok _ -> Alcotest.fail "Expected calc_sum"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_min_function () =
  match parse Standard.function_min "min(10px, 5%)" with
  | Ok [ _; _ ] -> ()
  | Ok _ -> Alcotest.fail "Expected two values in min()"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_max_function () =
  match parse Standard.function_max "max(10px, 20px, 30px)" with
  | Ok [ _; _; _ ] -> ()
  | Ok _ -> Alcotest.fail "Expected three values in max()"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let tests =
  ( "Calc functions",
    [
      Alcotest.test_case "calc simple" `Quick test_calc_simple;
      Alcotest.test_case "calc addition" `Quick test_calc_addition;
      Alcotest.test_case "calc multiplication" `Quick test_calc_multiplication;
      Alcotest.test_case "min function" `Quick test_min_function;
      Alcotest.test_case "max function" `Quick test_max_function;
    ] )
