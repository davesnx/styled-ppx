open Css_grammar

let parse rule input =
  match Styled_ppx_css_parser.Lexer.tokenize input with
  | Error e -> Error e
  | Ok tokens_with_loc ->
    let tokens = List.map (fun (tok, _, _) -> tok) tokens_with_loc in
    let tokens_without_ws =
      List.filter (fun tok -> tok <> Styled_ppx_css_parser.Tokens.WS) tokens
    in
    match rule tokens_without_ws with
    | Ok value, _ -> Ok value
    | Error errors, _ -> Error (String.concat "\n" errors)

let test_length_px () =
  match parse Standard.length "10px" with
  | Ok (`Px 10.) -> ()
  | Ok _ -> Alcotest.fail "Expected `Px 10."
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_length_rem () =
  match parse Standard.length "2rem" with
  | Ok (`Rem 2.) -> ()
  | Ok _ -> Alcotest.fail "Expected `Rem 2."
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_length_zero () =
  match parse Standard.length "0" with
  | Ok `Zero -> ()
  | Ok _ -> Alcotest.fail "Expected `Zero"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_length_calc () =
  match parse Standard.length "calc(10px + 5%)" with
  | Ok (`Calc _) -> ()
  | Ok _ -> Alcotest.fail "Expected `Calc"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_length_interpolation () =
  match parse Standard.length "$(myLength)" with
  | Ok (`Interpolation [ "myLength" ]) -> ()
  | Ok _ -> Alcotest.fail "Expected `Interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_angle_deg () =
  match parse Standard.angle "45deg" with
  | Ok (`Deg 45.) -> ()
  | Ok _ -> Alcotest.fail "Expected `Deg 45."
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_percentage () =
  match parse Standard.percentage "50%" with
  | Ok (`Percentage 50.) -> ()
  | Ok _ -> Alcotest.fail "Expected `Percentage 50."
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_css_wide_keywords_initial () =
  match parse Standard.css_wide_keywords "initial" with
  | Ok `Initial -> ()
  | Ok _ -> Alcotest.fail "Expected `Initial"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_css_wide_keywords_inherit () =
  match parse Standard.css_wide_keywords "inherit" with
  | Ok `Inherit -> ()
  | Ok _ -> Alcotest.fail "Expected `Inherit"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let tests =
  ( "Standard types",
    [
      Alcotest.test_case "length px" `Quick test_length_px;
      Alcotest.test_case "length rem" `Quick test_length_rem;
      Alcotest.test_case "length zero" `Quick test_length_zero;
      Alcotest.test_case "length calc" `Quick test_length_calc;
      Alcotest.test_case "length interpolation" `Quick test_length_interpolation;
      Alcotest.test_case "angle deg" `Quick test_angle_deg;
      Alcotest.test_case "percentage" `Quick test_percentage;
      Alcotest.test_case "css-wide-keywords initial" `Quick
        test_css_wide_keywords_initial;
      Alcotest.test_case "css-wide-keywords inherit" `Quick
        test_css_wide_keywords_inherit;
    ] )
