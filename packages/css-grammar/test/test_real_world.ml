open Css_grammar

module Border_style = [%spec_module "'none' | 'hidden' | 'dotted' | 'dashed' | 'solid' | 'double' | 'groove' | 'ridge' | 'inset' | 'outset'"]
module Border_width_keyword = [%spec_module "'thin' | 'medium' | 'thick'"]
module Border_width = [%spec_module "<length> | 'thin' | 'medium' | 'thick'"]
module Overflow = [%spec_module "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto'"]
module Display_outside = [%spec_module "'block' | 'inline' | 'run-in'"]
module Display_inside = [%spec_module "'flow' | 'flow-root' | 'table' | 'flex' | 'grid' | 'ruby'"]
module Box_sizing = [%spec_module "'content-box' | 'border-box'"]
module Z_index = [%spec_module "'auto' | <integer>"]
module Flex_wrap = [%spec_module "'nowrap' | 'wrap' | 'wrap-reverse'"]
module Flex_direction = [%spec_module "'row' | 'row-reverse' | 'column' | 'column-reverse'"]
module Justify_content = [%spec_module "'flex-start' | 'flex-end' | 'center' | 'space-between' | 'space-around' | 'space-evenly'"]
module Align_items = [%spec_module "'flex-start' | 'flex-end' | 'center' | 'baseline' | 'stretch'"]
module Text_align = [%spec_module "'left' | 'right' | 'center' | 'justify' | 'start' | 'end'"]
module Font_style = [%spec_module "'normal' | 'italic' | 'oblique'"]
module Font_weight_keyword = [%spec_module "'normal' | 'bold' | 'bolder' | 'lighter'"]
module Font_weight = [%spec_module "'normal' | 'bold' | 'bolder' | 'lighter' | <number>"]
module Opacity = [%spec_module "<number>"]
module Cursor_keyword = [%spec_module "'auto' | 'default' | 'none' | 'context-menu' | 'help' | 'pointer' | 'progress' | 'wait' | 'cell' | 'crosshair' | 'text' | 'vertical-text' | 'alias' | 'copy' | 'move' | 'no-drop' | 'not-allowed' | 'grab' | 'grabbing'"]
module White_space = [%spec_module "'normal' | 'pre' | 'nowrap' | 'pre-wrap' | 'pre-line' | 'break-spaces'"]
module Text_decoration_line = [%spec_module "'none' | 'underline' | 'overline' | 'line-through' | 'blink'"]
module Visibility = [%spec_module "'visible' | 'hidden' | 'collapse'"]
module Background_position_value = [%spec_module "'left' | 'center' | 'right' | 'top' | 'bottom' | <length> | <percentage>"]
module Background_position = [%spec_module "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length> | <percentage> ] [ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length> | <percentage> ]?"]
module Border_radius_single = [%spec_module "<length-percentage>"]
module Gap = [%spec_module "<length-percentage> <length-percentage>?"]
module Font_size_line_height = [%spec_module "<length> <number>?"]
module Flex_basis = [%spec_module "'auto' | 'content' | <length> | <percentage>"]
module Flex_grow_shrink = [%spec_module "<number> <number>?"]

let test_all_border_styles () =
  let styles =
    [
      "none";
      "hidden";
      "dotted";
      "dashed";
      "solid";
      "double";
      "groove";
      "ridge";
      "inset";
      "outset";
    ]
  in
  List.iter
    (fun style ->
      match Border_style.parse style with
      | Ok _ -> ()
      | Error e -> Alcotest.fail ("Parse error for " ^ style ^ ": " ^ e))
    styles

let test_border_width_length () =
  match Border_width.parse "2px" with
  | Ok (`Length _) -> ()
  | Ok _ -> Alcotest.fail "Expected Length"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_border_width_keyword () =
  match Border_width.parse "medium" with
  | Ok `Medium -> ()
  | Ok _ -> Alcotest.fail "Expected Medium"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_border_width_interpolation () =
  match Border_width.parse "$(bw)" with
  | Ok (`Length (`Interpolation _)) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation in Length"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_z_index_auto () =
  match Z_index.parse "auto" with
  | Ok `Auto -> ()
  | Ok _ -> Alcotest.fail "Expected Auto"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_z_index_number () =
  match Z_index.parse "100" with
  | Ok (`Integer (`Integer 100)) -> ()
  | Ok _ -> Alcotest.fail "Expected Integer 100"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_z_index_negative () =
  match Z_index.parse "-1" with
  | Ok (`Integer (`Integer n)) when n = -1 -> ()
  | Ok _ -> Alcotest.fail "Expected Integer -1"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_z_index_interpolation () =
  match Z_index.parse "$(zIndex)" with
  | Ok (`Integer (`Interpolation _)) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_flex_direction_all () =
  let directions = [ "row"; "row-reverse"; "column"; "column-reverse" ] in
  List.iter
    (fun dir ->
      match Flex_direction.parse dir with
      | Ok _ -> ()
      | Error e -> Alcotest.fail ("Parse error for " ^ dir ^ ": " ^ e))
    directions

let test_justify_content_all () =
  let values =
    [
      "flex-start";
      "flex-end";
      "center";
      "space-between";
      "space-around";
      "space-evenly";
    ]
  in
  List.iter
    (fun v ->
      match Justify_content.parse v with
      | Ok _ -> ()
      | Error e -> Alcotest.fail ("Parse error for " ^ v ^ ": " ^ e))
    values

let test_font_weight_number () =
  match Font_weight.parse "700" with
  | Ok (`Number (`Number 700.)) -> ()
  | Ok _ -> Alcotest.fail "Expected Number 700"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_font_weight_keyword () =
  match Font_weight.parse "bold" with
  | Ok `Bold -> ()
  | Ok _ -> Alcotest.fail "Expected Bold"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_font_weight_interpolation () =
  match Font_weight.parse "$(fw)" with
  | Ok (`Number (`Interpolation _)) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_opacity_number () =
  match Opacity.parse "0.5" with
  | Ok (`Number n) when n = 0.5 -> ()
  | Ok _ -> Alcotest.fail "Expected Number 0.5"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_opacity_calc () =
  match Opacity.parse "calc(1 - 0.3)" with
  | Ok (`Calc _) -> ()
  | Ok _ -> Alcotest.fail "Expected Calc"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_cursor_various () =
  let cursors = [ "pointer"; "default"; "not-allowed"; "grab"; "grabbing" ] in
  List.iter
    (fun c ->
      match Cursor_keyword.parse c with
      | Ok _ -> ()
      | Error e -> Alcotest.fail ("Parse error for " ^ c ^ ": " ^ e))
    cursors

let test_white_space_all () =
  let values =
    [ "normal"; "pre"; "nowrap"; "pre-wrap"; "pre-line"; "break-spaces" ]
  in
  List.iter
    (fun v ->
      match White_space.parse v with
      | Ok _ -> ()
      | Error e -> Alcotest.fail ("Parse error for " ^ v ^ ": " ^ e))
    values

let test_case_insensitive_variations () =
  let test input parse =
    match parse input with
    | Ok _ -> ()
    | Error e -> Alcotest.fail ("Parse error for " ^ input ^ ": " ^ e)
  in
  test "SOLID" Border_style.parse;
  test "Solid" Border_style.parse;
  test "sOLiD" Border_style.parse;
  test "ROW-REVERSE" Flex_direction.parse;
  test "SPACE-BETWEEN" Justify_content.parse;
  test "NOT-ALLOWED" Cursor_keyword.parse;
  test "PRE-WRAP" White_space.parse

let test_extract_z_index () =
  let result =
    Z_index.extract_interpolations (`Integer (`Interpolation [ "zIdx" ]))
  in
  Alcotest.(check int) "extracts 1" 1 (List.length result);
  Alcotest.(check string) "var name" "zIdx" (fst (List.hd result))

let test_extract_font_weight () =
  let result =
    Font_weight.extract_interpolations (`Number (`Interpolation [ "weight" ]))
  in
  Alcotest.(check int) "extracts 1" 1 (List.length result);
  Alcotest.(check string) "var name" "weight" (fst (List.hd result))

let test_extract_border_width () =
  let result =
    Border_width.extract_interpolations (`Length (`Interpolation [ "bw" ]))
  in
  Alcotest.(check int) "extracts 1" 1 (List.length result);
  Alcotest.(check string)
    "type path contains Length" "Css_types.Length"
    (snd (List.hd result))

let test_background_position_single () =
  match Background_position.parse "center" with
  | Ok (`Center, None) -> ()
  | Ok _ -> Alcotest.fail "Expected (center, None)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_background_position_two () =
  match Background_position.parse "left top" with
  | Ok (`Left, Some `Top) -> ()
  | Ok _ -> Alcotest.fail "Expected (left, Some top)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_background_position_length () =
  match Background_position.parse "10px 20%" with
  | Ok (`Length _, Some (`Percentage _)) -> ()
  | Ok _ -> Alcotest.fail "Expected (length, Some percentage)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_background_position_interpolation () =
  match Background_position.parse "$(x) $(y)" with
  | Ok (`Length (`Interpolation _), Some (`Length (`Interpolation _)))
  | Ok (`Percentage (`Interpolation _), Some (`Percentage (`Interpolation _)))
    ->
    ()
  | Ok _ -> Alcotest.fail "Expected interpolations"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_gap_single () =
  match Gap.parse "10px" with
  | Ok (`Length _, None) | Ok (`Percentage _, None) -> ()
  | Ok _ -> Alcotest.fail "Expected (length, None)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_gap_two () =
  match Gap.parse "10px 20px" with
  | Ok (`Length _, Some (`Length _)) -> ()
  | Ok _ -> Alcotest.fail "Expected two lengths"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_gap_mixed () =
  match Gap.parse "10px 50%" with
  | Ok (`Length _, Some (`Percentage _)) -> ()
  | Ok _ -> Alcotest.fail "Expected length and percentage"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_font_size_line_height_single () =
  match Font_size_line_height.parse "16px" with
  | Ok (`Px 16., None) -> ()
  | Ok _ -> Alcotest.fail "Expected (16px, None)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_font_size_line_height_both () =
  match Font_size_line_height.parse "16px 1.5" with
  | Ok (`Px 16., Some (`Number 1.5)) -> ()
  | Ok _ -> Alcotest.fail "Expected (16px, Some 1.5)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_flex_basis_auto () =
  match Flex_basis.parse "auto" with
  | Ok `Auto -> ()
  | Ok _ -> Alcotest.fail "Expected Auto"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_flex_basis_length () =
  match Flex_basis.parse "200px" with
  | Ok (`Length _) -> ()
  | Ok _ -> Alcotest.fail "Expected Length"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_flex_grow_shrink_single () =
  match Flex_grow_shrink.parse "1" with
  | Ok (`Number 1., None) -> ()
  | Ok _ -> Alcotest.fail "Expected (1, None)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_flex_grow_shrink_both () =
  match Flex_grow_shrink.parse "1 0" with
  | Ok (`Number 1., Some (`Number 0.)) -> ()
  | Ok _ -> Alcotest.fail "Expected (1, Some 0)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_extract_gap () =
  let result =
    Gap.extract_interpolations
      (`Interpolation [ "gapX" ], Some (`Interpolation [ "gapY" ]))
  in
  Alcotest.(check int) "extracts 2" 2 (List.length result)

let tests =
  ( "Real world CSS",
    [
      Alcotest.test_case "all border styles" `Quick test_all_border_styles;
      Alcotest.test_case "border-width length" `Quick test_border_width_length;
      Alcotest.test_case "border-width keyword" `Quick test_border_width_keyword;
      Alcotest.test_case "border-width interpolation" `Quick
        test_border_width_interpolation;
      Alcotest.test_case "z-index auto" `Quick test_z_index_auto;
      Alcotest.test_case "z-index number" `Quick test_z_index_number;
      Alcotest.test_case "z-index negative" `Quick test_z_index_negative;
      Alcotest.test_case "z-index interpolation" `Quick
        test_z_index_interpolation;
      Alcotest.test_case "flex-direction all" `Quick test_flex_direction_all;
      Alcotest.test_case "justify-content all" `Quick test_justify_content_all;
      Alcotest.test_case "font-weight number" `Quick test_font_weight_number;
      Alcotest.test_case "font-weight keyword" `Quick test_font_weight_keyword;
      Alcotest.test_case "font-weight interpolation" `Quick
        test_font_weight_interpolation;
      Alcotest.test_case "opacity number" `Quick test_opacity_number;
      Alcotest.test_case "opacity calc" `Quick test_opacity_calc;
      Alcotest.test_case "cursor various" `Quick test_cursor_various;
      Alcotest.test_case "white-space all" `Quick test_white_space_all;
      Alcotest.test_case "case insensitive variations" `Quick
        test_case_insensitive_variations;
      Alcotest.test_case "extract z-index" `Quick test_extract_z_index;
      Alcotest.test_case "extract font-weight" `Quick test_extract_font_weight;
      Alcotest.test_case "extract border-width" `Quick test_extract_border_width;
      Alcotest.test_case "background-position single" `Quick
        test_background_position_single;
      Alcotest.test_case "background-position two" `Quick
        test_background_position_two;
      Alcotest.test_case "background-position length" `Quick
        test_background_position_length;
      Alcotest.test_case "background-position interpolation" `Quick
        test_background_position_interpolation;
      Alcotest.test_case "gap single" `Quick test_gap_single;
      Alcotest.test_case "gap two" `Quick test_gap_two;
      Alcotest.test_case "gap mixed" `Quick test_gap_mixed;
      Alcotest.test_case "font-size/line-height single" `Quick
        test_font_size_line_height_single;
      Alcotest.test_case "font-size/line-height both" `Quick
        test_font_size_line_height_both;
      Alcotest.test_case "flex-basis auto" `Quick test_flex_basis_auto;
      Alcotest.test_case "flex-basis length" `Quick test_flex_basis_length;
      Alcotest.test_case "flex-grow-shrink single" `Quick
        test_flex_grow_shrink_single;
      Alcotest.test_case "flex-grow-shrink both" `Quick
        test_flex_grow_shrink_both;
      Alcotest.test_case "extract gap" `Quick test_extract_gap;
    ] )
