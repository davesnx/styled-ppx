open Css_grammar_v2

let test_margin_single () =
  match Spec.parse Properties.margin "10px" with
  | Ok [ `Length (`Px 10.) ] -> ()
  | Ok _ -> Alcotest.fail "Expected single length value"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_margin_four_values () =
  match Spec.parse Properties.margin "10px 20px 30px 40px" with
  | Ok [ _; _; _; _ ] -> ()
  | Ok result ->
      Alcotest.fail
        ("Expected four values, got " ^ string_of_int (List.length result))
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_margin_auto () =
  match Spec.parse Properties.margin "auto" with
  | Ok [ `Auto ] -> ()
  | Ok _ -> Alcotest.fail "Expected `Auto"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_margin_mixed () =
  match Spec.parse Properties.margin "10px auto 20%" with
  | Ok [ `Length _; `Auto; `Percentage _ ] -> ()
  | Ok _ -> Alcotest.fail "Expected length, auto, percentage"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_position_static () =
  match Spec.parse Properties.position "static" with
  | Ok `Static -> ()
  | Ok _ -> Alcotest.fail "Expected `Static"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_position_absolute () =
  match Spec.parse Properties.position "absolute" with
  | Ok `Absolute -> ()
  | Ok _ -> Alcotest.fail "Expected `Absolute"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_line_height_normal () =
  match Spec.parse Properties.line_height "normal" with
  | Ok `Normal -> ()
  | Ok _ -> Alcotest.fail "Expected `Normal"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_line_height_number () =
  match Spec.parse Properties.line_height "1.5" with
  | Ok (`Number (`Number 1.5)) -> ()
  | Ok _ -> Alcotest.fail "Expected `Number 1.5"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_color_hex () =
  match Spec.parse Properties.color "#ff0000" with
  | Ok (`Hex_color "ff0000") -> ()
  | Ok _ -> Alcotest.fail "Expected hex color"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_color_currentcolor () =
  match Spec.parse Properties.color "currentColor" with
  | Ok `CurrentColor -> ()
  | Ok _ -> Alcotest.fail "Expected `CurrentColor"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let tests =
  ( "Properties",
    [
      Alcotest.test_case "margin single" `Quick test_margin_single;
      Alcotest.test_case "margin four values" `Quick test_margin_four_values;
      Alcotest.test_case "margin auto" `Quick test_margin_auto;
      Alcotest.test_case "margin mixed" `Quick test_margin_mixed;
      Alcotest.test_case "position static" `Quick test_position_static;
      Alcotest.test_case "position absolute" `Quick test_position_absolute;
      Alcotest.test_case "line-height normal" `Quick test_line_height_normal;
      Alcotest.test_case "line-height number" `Quick test_line_height_number;
      Alcotest.test_case "color hex" `Quick test_color_hex;
      Alcotest.test_case "color currentcolor" `Quick test_color_currentcolor;
    ] )
