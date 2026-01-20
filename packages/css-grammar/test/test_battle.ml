open Css_grammar

let parse_with_rule ?(strict = false) rule input =
  match Styled_ppx_css_parser.Lexer.tokenize input with
  | Error e -> Error e
  | Ok tokens_with_loc ->
    let tokens = List.map (fun (tok, _, _) -> tok) tokens_with_loc in
    let tokens_without_ws =
      List.filter (fun tok -> tok <> Styled_ppx_css_parser.Tokens.WS) tokens
    in
    match rule tokens_without_ws with
    | Ok value, [] -> Ok value
    | Ok value, remaining ->
        if strict then
          Error
            (Printf.sprintf "Unconsumed tokens: %d remaining"
               (List.length remaining))
        else Ok value
    | Error errors, _ -> Error (String.concat "\n" errors)

let test_zero_length () =
  match parse_with_rule Standard.length "0" with
  | Ok `Zero -> ()
  | Ok _ -> Alcotest.fail "Expected Zero"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_negative_length () =
  match parse_with_rule Standard.length "-10px" with
  | Ok (`Px n) when n < 0. -> ()
  | Ok _ -> Alcotest.fail "Expected negative Px"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_float_length () =
  match parse_with_rule Standard.length "1.5rem" with
  | Ok (`Rem n) when n = 1.5 -> ()
  | Ok _ -> Alcotest.fail "Expected Rem 1.5"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_scientific_notation () =
  match parse_with_rule Standard.number "1e10" with
  | Ok (`Number n) when n = 1e10 -> ()
  | Ok _ -> Alcotest.fail "Expected Number 1e10"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_percentage_zero () =
  match parse_with_rule Standard.percentage "0%" with
  | Ok (`Percentage n) when n = 0. -> ()
  | Ok _ -> Alcotest.fail "Expected Percentage 0"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_percentage_hundred () =
  match parse_with_rule Standard.percentage "100%" with
  | Ok (`Percentage n) when n = 100. -> ()
  | Ok _ -> Alcotest.fail "Expected Percentage 100"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_nested_calc () =
  match parse_with_rule Standard.length "calc((10px + 20px) * 2)" with
  | Ok (`Calc _) -> ()
  | Ok _ -> Alcotest.fail "Expected nested calc"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_calc_division () =
  match parse_with_rule Standard.length "calc(100% / 3)" with
  | Ok (`Calc _) -> ()
  | Ok _ -> Alcotest.fail "Expected calc with division"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_calc_complex () =
  match parse_with_rule Standard.length "calc(100vh - 50px + 10%)" with
  | Ok (`Calc _) -> ()
  | Ok _ -> Alcotest.fail "Expected complex calc"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_min_multiple_args () =
  match parse_with_rule Standard.length "min(10px, 20px, 30px)" with
  | Ok (`Min args) when List.length args = 3 -> ()
  | Ok (`Min args) ->
      Alcotest.fail (Printf.sprintf "Expected 3 args, got %d" (List.length args))
  | Ok _ -> Alcotest.fail "Expected min with 3 arguments"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_max_single_arg () =
  match parse_with_rule Standard.length "max(10px)" with
  | Ok (`Max [ _ ]) -> ()
  | Ok _ -> Alcotest.fail "Expected max with 1 argument"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_clamp () =
  match parse_with_rule Standard.length "clamp(10px, 50%, 100px)" with
  | Ok (`Clamp _) -> ()
  | Ok _ -> Alcotest.fail "Expected clamp"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_angle_deg () =
  match parse_with_rule Standard.angle "45deg" with
  | Ok (`Deg n) when n = 45. -> ()
  | Ok _ -> Alcotest.fail "Expected Deg 45"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_angle_rad () =
  match parse_with_rule Standard.angle "3.14159rad" with
  | Ok (`Rad _) -> ()
  | Ok _ -> Alcotest.fail "Expected Rad"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_angle_turn () =
  match parse_with_rule Standard.angle "0.5turn" with
  | Ok (`Turn n) when n = 0.5 -> ()
  | Ok _ -> Alcotest.fail "Expected Turn 0.5"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_time_seconds () =
  match parse_with_rule Standard.time "2s" with
  | Ok (`S n) when n = 2. -> ()
  | Ok _ -> Alcotest.fail "Expected S 2"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_time_milliseconds () =
  match parse_with_rule Standard.time "300ms" with
  | Ok (`Ms n) when n = 300. -> ()
  | Ok _ -> Alcotest.fail "Expected Ms 300"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_frequency_hz () =
  match parse_with_rule Standard.frequency "440hz" with
  | Ok (`Hz n) when n = 440. -> ()
  | Ok _ -> Alcotest.fail "Expected Hz 440"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_frequency_khz () =
  match parse_with_rule Standard.frequency "1.5khz" with
  | Ok (`KHz n) when n = 1.5 -> ()
  | Ok _ -> Alcotest.fail "Expected KHz 1.5"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_resolution_dpi () =
  match parse_with_rule Standard.resolution "96dpi" with
  | Ok (`Dpi n) when n = 96. -> ()
  | Ok _ -> Alcotest.fail "Expected Dpi 96"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_resolution_dppx () =
  match parse_with_rule Standard.resolution "2x" with
  | Ok (`Dppx n) when n = 2. -> ()
  | Ok _ -> Alcotest.fail "Expected Dppx 2"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_flex_fr () =
  match parse_with_rule Standard.flex_value "1fr" with
  | Ok (`Fr n) when n = 1. -> ()
  | Ok _ -> Alcotest.fail "Expected Fr 1"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_integer () =
  match parse_with_rule Standard.integer "42" with
  | Ok (`Integer n) when n = 42 -> ()
  | Ok _ -> Alcotest.fail "Expected Integer 42"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_integer_negative () =
  match parse_with_rule Standard.integer "-10" with
  | Ok (`Integer n) when n = -10 -> ()
  | Ok _ -> Alcotest.fail "Expected Integer -10"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_css_wide_initial () =
  match parse_with_rule Standard.css_wide_keywords "initial" with
  | Ok `Initial -> ()
  | Ok _ -> Alcotest.fail "Expected Initial"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_css_wide_inherit () =
  match parse_with_rule Standard.css_wide_keywords "inherit" with
  | Ok `Inherit -> ()
  | Ok _ -> Alcotest.fail "Expected Inherit"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_css_wide_unset () =
  match parse_with_rule Standard.css_wide_keywords "unset" with
  | Ok `Unset -> ()
  | Ok _ -> Alcotest.fail "Expected Unset"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_css_wide_revert () =
  match parse_with_rule Standard.css_wide_keywords "revert" with
  | Ok `Revert -> ()
  | Ok _ -> Alcotest.fail "Expected Revert"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_css_wide_revert_layer () =
  match parse_with_rule Standard.css_wide_keywords "revert-layer" with
  | Ok `RevertLayer -> ()
  | Ok _ -> Alcotest.fail "Expected RevertLayer"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_hex_color_3 () =
  match parse_with_rule Standard.hex_color "#fff" with
  | Ok "fff" -> ()
  | Ok s -> Alcotest.fail ("Expected fff, got " ^ s)
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_hex_color_6 () =
  match parse_with_rule Standard.hex_color "#ffffff" with
  | Ok "ffffff" -> ()
  | Ok s -> Alcotest.fail ("Expected ffffff, got " ^ s)
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_hex_color_8 () =
  match parse_with_rule Standard.hex_color "#ffffffff" with
  | Ok "ffffffff" -> ()
  | Ok s -> Alcotest.fail ("Expected ffffffff, got " ^ s)
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_length_percentage_length () =
  match parse_with_rule Standard.length_percentage "10px" with
  | Ok (`Length _) -> ()
  | Ok _ -> Alcotest.fail "Expected Length"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_length_percentage_percentage () =
  match parse_with_rule Standard.length_percentage "50%" with
  | Ok (`Percentage _) -> ()
  | Ok _ -> Alcotest.fail "Expected Percentage"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_interpolation_simple () =
  match parse_with_rule Standard.interpolation "$(x)" with
  | Ok [ "x" ] -> ()
  | Ok parts ->
      Alcotest.fail
        ("Expected [x], got [" ^ String.concat ", " parts ^ "]")
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_interpolation_dotted () =
  match parse_with_rule Standard.interpolation "$(foo.bar.baz)" with
  | Ok [ "foo"; "bar"; "baz" ] -> ()
  | Ok parts ->
      Alcotest.fail
        ("Expected [foo,bar,baz], got [" ^ String.concat ", " parts ^ "]")
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_margin_all_values () =
  match Properties.Margin.parse "10px 20% 30px auto" with
  | Ok values when List.length values = 4 -> ()
  | Ok values ->
      Alcotest.fail
        (Printf.sprintf "Expected 4 values, got %d" (List.length values))
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_margin_single_calc () =
  match Properties.Margin.parse "calc(100% - 20px)" with
  | Ok [ `Length (`Calc _) ] -> ()
  | Ok [ `Percentage (`Calc _) ] -> ()
  | Ok _ -> Alcotest.fail "Expected calc in margin"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_margin_mixed_with_calc () =
  match Properties.Margin.parse "10px calc(50% - 10px) 20px" with
  | Ok values when List.length values = 3 -> ()
  | Ok _ -> Alcotest.fail "Expected 3 values with calc"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_position_sticky () =
  match Properties.Position.parse "sticky" with
  | Ok `Sticky -> ()
  | Ok _ -> Alcotest.fail "Expected Sticky"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_line_height_unitless () =
  match Properties.Line_height.parse "1.5" with
  | Ok (`Number (`Number n)) when n = 1.5 -> ()
  | Ok _ -> Alcotest.fail "Expected unitless number"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_line_height_with_unit () =
  match Properties.Line_height.parse "24px" with
  | Ok (`Length (`Px n)) when n = 24. -> ()
  | Ok _ -> Alcotest.fail "Expected 24px"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_color_hex_uppercase () =
  match Properties.Color.parse "#FFFFFF" with
  | Ok (`Hex_color "FFFFFF") -> ()
  | Ok (`Hex_color s) -> Alcotest.fail ("Expected FFFFFF, got " ^ s)
  | Ok _ -> Alcotest.fail "Expected hex color"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_color_transparent () =
  match Properties.Color.parse "transparent" with
  | Ok `Transparent -> ()
  | Ok _ -> Alcotest.fail "Expected Transparent"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_color_currentcolor_case () =
  match Properties.Color.parse "currentcolor" with
  | Ok `CurrentColor -> ()
  | Ok _ -> Alcotest.fail "Expected CurrentColor"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_error_invalid_unit () =
  match parse_with_rule Standard.length "10xyz" with
  | Error _ -> ()
  | Ok _ -> Alcotest.fail "Expected error for invalid unit"

let test_error_missing_value () =
  match Properties.Margin.parse "" with
  | Error _ -> ()
  | Ok _ -> Alcotest.fail "Expected error for empty value"

let test_error_too_many_values () =
  match Properties.Margin.parse "1px 2px 3px 4px 5px" with
  | Ok [ _; _; _; _ ] -> ()
  | Ok _ -> Alcotest.fail "Should only parse 4 values"
  | Error _ -> ()

let test_error_invalid_keyword () =
  match Properties.Position.parse "floating" with
  | Error _ -> ()
  | Ok _ -> Alcotest.fail "Expected error for invalid keyword"

let test_whitespace_handling () =
  match Properties.Margin.parse "   10px   20px   " with
  | Ok values when List.length values = 2 -> ()
  | Ok _ -> Alcotest.fail "Expected 2 values"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_calc_with_whitespace () =
  match parse_with_rule Standard.length "calc( 10px + 20px )" with
  | Ok (`Calc _) -> ()
  | Ok _ -> Alcotest.fail "Expected calc"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_calc_inside_interpolation () =
  match parse_with_rule Standard.length "calc($(x) + 10px)" with
  | Ok (`Calc _) -> ()
  | Ok _ -> Alcotest.fail "Expected calc with interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_all_length_units () =
  let units =
    [
      ("cap", `Cap);
      ("ch", `Ch);
      ("em", `Em);
      ("ex", `Ex);
      ("ic", `Ic);
      ("lh", `Lh);
      ("rem", `Rem);
      ("vh", `Vh);
      ("vw", `Vw);
      ("vmax", `Vmax);
      ("vmin", `Vmin);
      ("px", `Px);
      ("cm", `Cm);
      ("mm", `Mm);
      ("in", `In);
      ("pc", `Pc);
      ("pt", `Pt);
    ]
  in
  List.iter
    (fun (unit, _) ->
      match parse_with_rule Standard.length ("10" ^ unit) with
      | Ok _ -> ()
      | Error e ->
          Alcotest.fail ("Parse error for " ^ unit ^ ": " ^ e))
    units

let test_extract_multiple_interpolations () =
  let values =
    [ `Length (`Interpolation [ "x" ]); `Length (`Px 10.);
      `Length (`Interpolation [ "y" ]); `Auto ]
  in
  let result = Properties.Margin.extract_interpolations values in
  Alcotest.(check int) "should extract 2" 2 (List.length result);
  Alcotest.(check bool)
    "contains x" true
    (List.exists (fun (name, _) -> name = "x") result);
  Alcotest.(check bool)
    "contains y" true
    (List.exists (fun (name, _) -> name = "y") result)

let test_extract_nested_interpolation () =
  let values = [ `Percentage (`Interpolation [ "pct" ]) ] in
  let result = Properties.Margin.extract_interpolations values in
  Alcotest.(check int) "should extract 1" 1 (List.length result)

let tests =
  ( "Battle tests",
    [
      Alcotest.test_case "zero length" `Quick test_zero_length;
      Alcotest.test_case "negative length" `Quick test_negative_length;
      Alcotest.test_case "float length" `Quick test_float_length;
      Alcotest.test_case "scientific notation" `Quick test_scientific_notation;
      Alcotest.test_case "percentage zero" `Quick test_percentage_zero;
      Alcotest.test_case "percentage hundred" `Quick test_percentage_hundred;
      Alcotest.test_case "nested calc" `Quick test_nested_calc;
      Alcotest.test_case "calc division" `Quick test_calc_division;
      Alcotest.test_case "calc complex" `Quick test_calc_complex;
      Alcotest.test_case "min multiple args" `Quick test_min_multiple_args;
      Alcotest.test_case "max single arg" `Quick test_max_single_arg;
      Alcotest.test_case "clamp" `Quick test_clamp;
      Alcotest.test_case "angle deg" `Quick test_angle_deg;
      Alcotest.test_case "angle rad" `Quick test_angle_rad;
      Alcotest.test_case "angle turn" `Quick test_angle_turn;
      Alcotest.test_case "time seconds" `Quick test_time_seconds;
      Alcotest.test_case "time milliseconds" `Quick test_time_milliseconds;
      Alcotest.test_case "frequency hz" `Quick test_frequency_hz;
      Alcotest.test_case "frequency khz" `Quick test_frequency_khz;
      Alcotest.test_case "resolution dpi" `Quick test_resolution_dpi;
      Alcotest.test_case "resolution dppx" `Quick test_resolution_dppx;
      Alcotest.test_case "flex fr" `Quick test_flex_fr;
      Alcotest.test_case "integer" `Quick test_integer;
      Alcotest.test_case "integer negative" `Quick test_integer_negative;
      Alcotest.test_case "css wide initial" `Quick test_css_wide_initial;
      Alcotest.test_case "css wide inherit" `Quick test_css_wide_inherit;
      Alcotest.test_case "css wide unset" `Quick test_css_wide_unset;
      Alcotest.test_case "css wide revert" `Quick test_css_wide_revert;
      Alcotest.test_case "css wide revert-layer" `Quick
        test_css_wide_revert_layer;
      Alcotest.test_case "hex color 3" `Quick test_hex_color_3;
      Alcotest.test_case "hex color 6" `Quick test_hex_color_6;
      Alcotest.test_case "hex color 8" `Quick test_hex_color_8;
      Alcotest.test_case "length-percentage length" `Quick
        test_length_percentage_length;
      Alcotest.test_case "length-percentage percentage" `Quick
        test_length_percentage_percentage;
      Alcotest.test_case "interpolation simple" `Quick test_interpolation_simple;
      Alcotest.test_case "interpolation dotted" `Quick test_interpolation_dotted;
      Alcotest.test_case "margin all values" `Quick test_margin_all_values;
      Alcotest.test_case "margin single calc" `Quick test_margin_single_calc;
      Alcotest.test_case "margin mixed with calc" `Quick
        test_margin_mixed_with_calc;
      Alcotest.test_case "position sticky" `Quick test_position_sticky;
      Alcotest.test_case "line-height unitless" `Quick test_line_height_unitless;
      Alcotest.test_case "line-height with unit" `Quick
        test_line_height_with_unit;
      Alcotest.test_case "color hex uppercase" `Quick test_color_hex_uppercase;
      Alcotest.test_case "color transparent" `Quick test_color_transparent;
      Alcotest.test_case "color currentcolor case" `Quick
        test_color_currentcolor_case;
      Alcotest.test_case "error invalid unit" `Quick test_error_invalid_unit;
      Alcotest.test_case "error missing value" `Quick test_error_missing_value;
      Alcotest.test_case "error too many values" `Quick
        test_error_too_many_values;
      Alcotest.test_case "error invalid keyword" `Quick
        test_error_invalid_keyword;
      Alcotest.test_case "whitespace handling" `Quick test_whitespace_handling;
      Alcotest.test_case "calc with whitespace" `Quick test_calc_with_whitespace;
      Alcotest.test_case "calc inside interpolation" `Quick
        test_calc_inside_interpolation;
      Alcotest.test_case "all length units" `Quick test_all_length_units;
      Alcotest.test_case "extract multiple interpolations" `Quick
        test_extract_multiple_interpolations;
      Alcotest.test_case "extract nested interpolation" `Quick
        test_extract_nested_interpolation;
    ] )
