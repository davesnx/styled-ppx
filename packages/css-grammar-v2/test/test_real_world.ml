open Css_grammar_v2

type border_style =
  [ `None
  | `Hidden
  | `Dotted
  | `Dashed
  | `Solid
  | `Double
  | `Groove
  | `Ridge
  | `Inset
  | `Outset
  ]

let border_style : border_style Spec.t =
  [%spec
    "'none' | 'hidden' | 'dotted' | 'dashed' | 'solid' | 'double' | 'groove' | \
     'ridge' | 'inset' | 'outset'"]

type border_width_keyword =
  [ `Thin
  | `Medium
  | `Thick
  ]

let border_width_keyword : border_width_keyword Spec.t =
  [%spec "'thin' | 'medium' | 'thick'"]

type border_width =
  [ `Length of Standard.length
  | `Thin
  | `Medium
  | `Thick
  ]

let border_width : border_width Spec.t =
  [%spec "<length> | 'thin' | 'medium' | 'thick'"]

type overflow_keyword =
  [ `Visible
  | `Hidden
  | `Clip
  | `Scroll
  | `Auto
  ]

let overflow : overflow_keyword Spec.t =
  [%spec "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto'"]

type display_outside =
  [ `Block
  | `Inline
  | `Run_in
  ]

let display_outside : display_outside Spec.t =
  [%spec "'block' | 'inline' | 'run-in'"]

type display_inside =
  [ `Flow
  | `Flow_root
  | `Table
  | `Flex
  | `Grid
  | `Ruby
  ]

let display_inside : display_inside Spec.t =
  [%spec "'flow' | 'flow-root' | 'table' | 'flex' | 'grid' | 'ruby'"]

type box_sizing =
  [ `Content_box
  | `Border_box
  ]

let box_sizing : box_sizing Spec.t = [%spec "'content-box' | 'border-box'"]

type z_index =
  [ `Auto
  | `Integer of Standard.integer
  ]

let z_index : z_index Spec.t = [%spec "'auto' | <integer>"]

type flex_wrap =
  [ `Nowrap
  | `Wrap
  | `Wrap_reverse
  ]

let flex_wrap : flex_wrap Spec.t = [%spec "'nowrap' | 'wrap' | 'wrap-reverse'"]

type flex_direction =
  [ `Row
  | `Row_reverse
  | `Column
  | `Column_reverse
  ]

let flex_direction : flex_direction Spec.t =
  [%spec "'row' | 'row-reverse' | 'column' | 'column-reverse'"]

type justify_content =
  [ `Flex_start
  | `Flex_end
  | `Center
  | `Space_between
  | `Space_around
  | `Space_evenly
  ]

let justify_content : justify_content Spec.t =
  [%spec
    "'flex-start' | 'flex-end' | 'center' | 'space-between' | 'space-around' | \
     'space-evenly'"]

type align_items =
  [ `Flex_start
  | `Flex_end
  | `Center
  | `Baseline
  | `Stretch
  ]

let align_items : align_items Spec.t =
  [%spec "'flex-start' | 'flex-end' | 'center' | 'baseline' | 'stretch'"]

type text_align =
  [ `Left
  | `Right
  | `Center
  | `Justify
  | `Start
  | `End
  ]

let text_align : text_align Spec.t =
  [%spec "'left' | 'right' | 'center' | 'justify' | 'start' | 'end'"]

type font_style =
  [ `Normal
  | `Italic
  | `Oblique
  ]

let font_style : font_style Spec.t = [%spec "'normal' | 'italic' | 'oblique'"]

type font_weight_keyword =
  [ `Normal
  | `Bold
  | `Bolder
  | `Lighter
  ]

let font_weight_keyword : font_weight_keyword Spec.t =
  [%spec "'normal' | 'bold' | 'bolder' | 'lighter'"]

type font_weight =
  [ `Normal
  | `Bold
  | `Bolder
  | `Lighter
  | `Number of Standard.number
  ]

let font_weight : font_weight Spec.t =
  [%spec "'normal' | 'bold' | 'bolder' | 'lighter' | <number>"]

type opacity = Standard.number

let opacity : opacity Spec.t = [%spec "<number>"]

type cursor_keyword =
  [ `Auto
  | `Default
  | `None
  | `Context_menu
  | `Help
  | `Pointer
  | `Progress
  | `Wait
  | `Cell
  | `Crosshair
  | `Text
  | `Vertical_text
  | `Alias
  | `Copy
  | `Move
  | `No_drop
  | `Not_allowed
  | `Grab
  | `Grabbing
  ]

let cursor_keyword : cursor_keyword Spec.t =
  [%spec
    "'auto' | 'default' | 'none' | 'context-menu' | 'help' | 'pointer' | \
     'progress' | 'wait' | 'cell' | 'crosshair' | 'text' | 'vertical-text' | \
     'alias' | 'copy' | 'move' | 'no-drop' | 'not-allowed' | 'grab' | \
     'grabbing'"]

type white_space =
  [ `Normal
  | `Pre
  | `Nowrap
  | `Pre_wrap
  | `Pre_line
  | `Break_spaces
  ]

let white_space : white_space Spec.t =
  [%spec
    "'normal' | 'pre' | 'nowrap' | 'pre-wrap' | 'pre-line' | 'break-spaces'"]

type text_decoration_line =
  [ `None
  | `Underline
  | `Overline
  | `Line_through
  | `Blink
  ]

let text_decoration_line : text_decoration_line Spec.t =
  [%spec "'none' | 'underline' | 'overline' | 'line-through' | 'blink'"]

type visibility =
  [ `Visible
  | `Hidden
  | `Collapse
  ]

let visibility : visibility Spec.t = [%spec "'visible' | 'hidden' | 'collapse'"]

type background_position_value =
  [ `Left
  | `Center
  | `Right
  | `Top
  | `Bottom
  | `Length of Standard.length
  | `Percentage of Standard.percentage
  ]

let background_position_value : background_position_value Spec.t =
  [%spec
    "'left' | 'center' | 'right' | 'top' | 'bottom' | <length> | <percentage>"]

type background_position =
  background_position_value * background_position_value option

let background_position : background_position Spec.t =
  [%spec
    "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length> | \
     <percentage> ] [ 'left' | 'center' | 'right' | 'top' | 'bottom' | \
     <length> | <percentage> ]?"]

type border_radius_value = Standard.length_percentage

let border_radius_single : border_radius_value Spec.t =
  [%spec "<length-percentage>"]

type gap = Standard.length_percentage * Standard.length_percentage option

let gap : gap Spec.t = [%spec "<length-percentage> <length-percentage>?"]

type font_size_line_height = Standard.length * Standard.number option

let font_size_line_height : font_size_line_height Spec.t =
  [%spec "<length> <number>?"]

type flex_basis =
  [ `Auto
  | `Content
  | `Length of Standard.length
  | `Percentage of Standard.percentage
  ]

let flex_basis : flex_basis Spec.t =
  [%spec "'auto' | 'content' | <length> | <percentage>"]

type flex_grow_shrink = Standard.number * Standard.number option

let flex_grow_shrink : flex_grow_shrink Spec.t = [%spec "<number> <number>?"]

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
      match Spec.parse border_style style with
      | Ok _ -> ()
      | Error e -> Alcotest.fail ("Parse error for " ^ style ^ ": " ^ e))
    styles

let test_border_width_length () =
  match Spec.parse border_width "2px" with
  | Ok (`Length _) -> ()
  | Ok _ -> Alcotest.fail "Expected Length"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_border_width_keyword () =
  match Spec.parse border_width "medium" with
  | Ok `Medium -> ()
  | Ok _ -> Alcotest.fail "Expected Medium"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_border_width_interpolation () =
  match Spec.parse border_width "$(bw)" with
  | Ok (`Length (`Interpolation _)) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation in Length"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_z_index_auto () =
  match Spec.parse z_index "auto" with
  | Ok `Auto -> ()
  | Ok _ -> Alcotest.fail "Expected Auto"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_z_index_number () =
  match Spec.parse z_index "100" with
  | Ok (`Integer (`Integer 100)) -> ()
  | Ok _ -> Alcotest.fail "Expected Integer 100"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_z_index_negative () =
  match Spec.parse z_index "-1" with
  | Ok (`Integer (`Integer n)) when n = -1 -> ()
  | Ok _ -> Alcotest.fail "Expected Integer -1"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_z_index_interpolation () =
  match Spec.parse z_index "$(zIndex)" with
  | Ok (`Integer (`Interpolation _)) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_flex_direction_all () =
  let directions = [ "row"; "row-reverse"; "column"; "column-reverse" ] in
  List.iter
    (fun dir ->
      match Spec.parse flex_direction dir with
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
      match Spec.parse justify_content v with
      | Ok _ -> ()
      | Error e -> Alcotest.fail ("Parse error for " ^ v ^ ": " ^ e))
    values

let test_font_weight_number () =
  match Spec.parse font_weight "700" with
  | Ok (`Number (`Number 700.)) -> ()
  | Ok _ -> Alcotest.fail "Expected Number 700"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_font_weight_keyword () =
  match Spec.parse font_weight "bold" with
  | Ok `Bold -> ()
  | Ok _ -> Alcotest.fail "Expected Bold"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_font_weight_interpolation () =
  match Spec.parse font_weight "$(fw)" with
  | Ok (`Number (`Interpolation _)) -> ()
  | Ok _ -> Alcotest.fail "Expected interpolation"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_opacity_number () =
  match Spec.parse opacity "0.5" with
  | Ok (`Number n) when n = 0.5 -> ()
  | Ok _ -> Alcotest.fail "Expected Number 0.5"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_opacity_calc () =
  match Spec.parse opacity "calc(1 - 0.3)" with
  | Ok (`Calc _) -> ()
  | Ok _ -> Alcotest.fail "Expected Calc"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_cursor_various () =
  let cursors = [ "pointer"; "default"; "not-allowed"; "grab"; "grabbing" ] in
  List.iter
    (fun c ->
      match Spec.parse cursor_keyword c with
      | Ok _ -> ()
      | Error e -> Alcotest.fail ("Parse error for " ^ c ^ ": " ^ e))
    cursors

let test_white_space_all () =
  let values =
    [ "normal"; "pre"; "nowrap"; "pre-wrap"; "pre-line"; "break-spaces" ]
  in
  List.iter
    (fun v ->
      match Spec.parse white_space v with
      | Ok _ -> ()
      | Error e -> Alcotest.fail ("Parse error for " ^ v ^ ": " ^ e))
    values

let test_case_insensitive_variations () =
  let test input spec_parse =
    match spec_parse input with
    | Ok _ -> ()
    | Error e -> Alcotest.fail ("Parse error for " ^ input ^ ": " ^ e)
  in
  test "SOLID" (Spec.parse border_style);
  test "Solid" (Spec.parse border_style);
  test "sOLiD" (Spec.parse border_style);
  test "ROW-REVERSE" (Spec.parse flex_direction);
  test "SPACE-BETWEEN" (Spec.parse justify_content);
  test "NOT-ALLOWED" (Spec.parse cursor_keyword);
  test "PRE-WRAP" (Spec.parse white_space)

let test_extract_z_index () =
  let result =
    z_index.extract_interpolations (`Integer (`Interpolation [ "zIdx" ]))
  in
  Alcotest.(check int) "extracts 1" 1 (List.length result);
  Alcotest.(check string) "var name" "zIdx" (fst (List.hd result))

let test_extract_font_weight () =
  let result =
    font_weight.extract_interpolations (`Number (`Interpolation [ "weight" ]))
  in
  Alcotest.(check int) "extracts 1" 1 (List.length result);
  Alcotest.(check string) "var name" "weight" (fst (List.hd result))

let test_extract_border_width () =
  let result =
    border_width.extract_interpolations (`Length (`Interpolation [ "bw" ]))
  in
  Alcotest.(check int) "extracts 1" 1 (List.length result);
  Alcotest.(check string)
    "type path contains Length" "Css_types.Length"
    (snd (List.hd result))

let test_background_position_single () =
  match Spec.parse background_position "center" with
  | Ok (`Center, None) -> ()
  | Ok _ -> Alcotest.fail "Expected (center, None)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_background_position_two () =
  match Spec.parse background_position "left top" with
  | Ok (`Left, Some `Top) -> ()
  | Ok _ -> Alcotest.fail "Expected (left, Some top)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_background_position_length () =
  match Spec.parse background_position "10px 20%" with
  | Ok (`Length _, Some (`Percentage _)) -> ()
  | Ok _ -> Alcotest.fail "Expected (length, Some percentage)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_background_position_interpolation () =
  match Spec.parse background_position "$(x) $(y)" with
  | Ok (`Length (`Interpolation _), Some (`Length (`Interpolation _)))
  | Ok (`Percentage (`Interpolation _), Some (`Percentage (`Interpolation _)))
    ->
    ()
  | Ok _ -> Alcotest.fail "Expected interpolations"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_gap_single () =
  match Spec.parse gap "10px" with
  | Ok (`Length _, None) | Ok (`Percentage _, None) -> ()
  | Ok _ -> Alcotest.fail "Expected (length, None)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_gap_two () =
  match Spec.parse gap "10px 20px" with
  | Ok (`Length _, Some (`Length _)) -> ()
  | Ok _ -> Alcotest.fail "Expected two lengths"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_gap_mixed () =
  match Spec.parse gap "10px 50%" with
  | Ok (`Length _, Some (`Percentage _)) -> ()
  | Ok _ -> Alcotest.fail "Expected length and percentage"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_font_size_line_height_single () =
  match Spec.parse font_size_line_height "16px" with
  | Ok (`Px 16., None) -> ()
  | Ok _ -> Alcotest.fail "Expected (16px, None)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_font_size_line_height_both () =
  match Spec.parse font_size_line_height "16px 1.5" with
  | Ok (`Px 16., Some (`Number 1.5)) -> ()
  | Ok _ -> Alcotest.fail "Expected (16px, Some 1.5)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_flex_basis_auto () =
  match Spec.parse flex_basis "auto" with
  | Ok `Auto -> ()
  | Ok _ -> Alcotest.fail "Expected Auto"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_flex_basis_length () =
  match Spec.parse flex_basis "200px" with
  | Ok (`Length _) -> ()
  | Ok _ -> Alcotest.fail "Expected Length"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_flex_grow_shrink_single () =
  match Spec.parse flex_grow_shrink "1" with
  | Ok (`Number 1., None) -> ()
  | Ok _ -> Alcotest.fail "Expected (1, None)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_flex_grow_shrink_both () =
  match Spec.parse flex_grow_shrink "1 0" with
  | Ok (`Number 1., Some (`Number 0.)) -> ()
  | Ok _ -> Alcotest.fail "Expected (1, Some 0)"
  | Error e -> Alcotest.fail ("Parse error: " ^ e)

let test_extract_gap () =
  let result =
    gap.extract_interpolations
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
