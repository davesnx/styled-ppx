let parse input =
  match
    Styled_ppx_css_parser.Driver.parse_declaration_list
      ~source_position_start:
        (Styled_ppx_css_parser.Parser_location.file_start ())
      input
  with
  | Ok (rule_list, _) -> rule_list
  | Error (_loc, error) -> Alcotest.fail error

let selector_of input =
  let rec find = function
    | [] -> Alcotest.failf "No style rule found in %S" input
    | Styled_ppx_css_parser.Ast.Style_rule { prelude = (sel, _) :: _, _; _ }
      :: _ ->
      sel
    | _ :: tl -> find tl
  in
  find (parse input)

let check ~pos ~expected input =
  let actual =
    Styled_ppx_css_parser.Selector_nesting.subject_escapes_ampersand_subtree
      (selector_of input)
  in
  if actual <> expected then (
    let file, line, _, _ = pos in
    Alcotest.failf "Expected escapes=%b for %S, received %b at %s:%d" expected
      input actual file line)

let minimal_adjacent_sibling () =
  check ~pos:__POS__ ~expected:true "& + .sibling { color: red; }"

let minimal_general_sibling () =
  check ~pos:__POS__ ~expected:true "& ~ .sibling { color: red; }"

let table_next_row_cell () =
  check ~pos:__POS__ ~expected:true
    "& + .$(row) .$(cellBorderTop) { border-color: red; }"

let table_not_then_sibling () =
  check ~pos:__POS__ ~expected:true
    "&:not(.rowHoverGroup) + .rowHoverGroup { border-top: 1px solid red; }"

let select_button_sibling_descendant () =
  check ~pos:__POS__ ~expected:true "& + * .contentContainer { color: red; }"

let sibling_type_selector () =
  check ~pos:__POS__ ~expected:true "& + span { transition: 1ms; }"

let compound_ampersand_left_of_sibling () =
  check ~pos:__POS__ ~expected:true "&.foo + .bar { color: red; }"

let pseudo_element_ampersand_left_of_sibling () =
  check ~pos:__POS__ ~expected:true "&::before + .bar { color: red; }"

let double_ampersand_then_sibling_subject () =
  check ~pos:__POS__ ~expected:true "& + & + .x { color: red; }"

let has_with_sibling_ampersand () =
  check ~pos:__POS__ ~expected:true ":has(& + div) { color: red; }"

let has_ampersand () =
  check ~pos:__POS__ ~expected:true ":has(&) { color: red; }"

let not_ampersand () =
  check ~pos:__POS__ ~expected:true "div:not(&) { color: red; }"

let is_with_sibling_branch () =
  check ~pos:__POS__ ~expected:true ":is(& + div) { color: red; }"

let is_with_unrelated_branch () =
  check ~pos:__POS__ ~expected:true ":is(& div, .foo) { color: red; }"

let is_with_descendant_branch () =
  check ~pos:__POS__ ~expected:false ":is(& div) { color: red; }"

let is_exactly_ampersand () =
  check ~pos:__POS__ ~expected:false "div:is(&) { color: red; }"

let is_with_all_branches_inside () =
  check ~pos:__POS__ ~expected:false ":is(& .x, & .y) { color: red; }"

let descendant_of_is_segment () =
  check ~pos:__POS__ ~expected:false ":is(& div) span { color: red; }"

let where_with_descendant_branch () =
  check ~pos:__POS__ ~expected:false ":where(& div) { color: red; }"

let sibling_of_is_descendant_conservative () =
  check ~pos:__POS__ ~expected:true ":is(& div) + .x { color: red; }"

let sibling_of_is_ampersand () =
  check ~pos:__POS__ ~expected:true ":is(&) + .x { color: red; }"

let sibling_before_ampersand () =
  check ~pos:__POS__ ~expected:false ".x + & { color: red; }"

let self_sibling () = check ~pos:__POS__ ~expected:false "& + & { color: red; }"

let sibling_chain_ending_in_ampersand () =
  check ~pos:__POS__ ~expected:false "& + .x + & { color: red; }"

let descendant_then_sibling () =
  check ~pos:__POS__ ~expected:false "& input + div { color: red; }"

let child_then_sibling () =
  check ~pos:__POS__ ~expected:false "& > * + * { color: red; }"

let second_ampersand_reaches_subject () =
  check ~pos:__POS__ ~expected:false "& + & .x { color: red; }"

let descendant () =
  check ~pos:__POS__ ~expected:false "& .child { color: red; }"

let child () = check ~pos:__POS__ ~expected:false "& > .child { color: red; }"

let self_compound () =
  check ~pos:__POS__ ~expected:false "&:hover { color: red; }"

let sibling_without_ampersand () =
  check ~pos:__POS__ ~expected:false ".a + .b { color: red; }"

let type_sibling_without_ampersand () =
  check ~pos:__POS__ ~expected:false "input + div { color: red; }"

let test name fn = name, fn

let cases =
  [
    test "minimal_adjacent_sibling" minimal_adjacent_sibling;
    test "minimal_general_sibling" minimal_general_sibling;
    test "table_next_row_cell" table_next_row_cell;
    test "table_not_then_sibling" table_not_then_sibling;
    test "select_button_sibling_descendant" select_button_sibling_descendant;
    test "sibling_type_selector" sibling_type_selector;
    test "compound_ampersand_left_of_sibling" compound_ampersand_left_of_sibling;
    test "pseudo_element_ampersand_left_of_sibling"
      pseudo_element_ampersand_left_of_sibling;
    test "double_ampersand_then_sibling_subject"
      double_ampersand_then_sibling_subject;
    test "has_with_sibling_ampersand" has_with_sibling_ampersand;
    test "has_ampersand" has_ampersand;
    test "not_ampersand" not_ampersand;
    test "is_with_sibling_branch" is_with_sibling_branch;
    test "is_with_unrelated_branch" is_with_unrelated_branch;
    test "is_with_descendant_branch" is_with_descendant_branch;
    test "is_exactly_ampersand" is_exactly_ampersand;
    test "is_with_all_branches_inside" is_with_all_branches_inside;
    test "descendant_of_is_segment" descendant_of_is_segment;
    test "where_with_descendant_branch" where_with_descendant_branch;
    test "sibling_of_is_descendant_conservative"
      sibling_of_is_descendant_conservative;
    test "sibling_of_is_ampersand" sibling_of_is_ampersand;
    test "sibling_before_ampersand" sibling_before_ampersand;
    test "self_sibling" self_sibling;
    test "sibling_chain_ending_in_ampersand" sibling_chain_ending_in_ampersand;
    test "descendant_then_sibling" descendant_then_sibling;
    test "child_then_sibling" child_then_sibling;
    test "second_ampersand_reaches_subject" second_ampersand_reaches_subject;
    test "descendant" descendant;
    test "child" child;
    test "self_compound" self_compound;
    test "sibling_without_ampersand" sibling_without_ampersand;
    test "type_sibling_without_ampersand" type_sibling_without_ampersand;
  ]

let run_all () = List.iter (fun (_name, fn) -> fn ()) cases
