(* Unit tests for `Selector_nesting.subject_escapes_ampersand_subtree`: a
   selector escapes when its subject (rightmost compound) sits outside `&`'s
   subtree, reached through a sibling combinator (`+`/`~`). Cases are drawn
   from the bug report and the repo-wide audit, including the "safe
   look-alikes" that a naive `& +` grep over-reports. *)

let parse input =
  match
    Styled_ppx_css_parser.Driver.parse_declaration_list
      ~loc:Ppxlib.Location.none input
  with
  | Ok (rule_list, _) -> rule_list
  | Error (_loc, error) -> Alcotest.fail error

(* Extract the first style-rule prelude selector from a parsed block. This
   is exactly the selector shape the extractor inspects per atom. *)
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

(* --- Escaping (broken): subject outside `&`'s subtree via `+`/`~` --- *)

let minimal_adjacent_sibling () =
  check ~pos:__POS__ ~expected:true "& + .sibling { color: red; }"

let minimal_general_sibling () =
  check ~pos:__POS__ ~expected:true "& ~ .sibling { color: red; }"

(* Ahrefs Table.re:239 — the originally reported, browser-verified bug. *)
let table_next_row_cell () =
  check ~pos:__POS__ ~expected:true
    "& + .$(row) .$(cellBorderTop) { border-color: red; }"

(* Ahrefs Table.re:109 — `&:not(...)` compound is the left sibling operand. *)
let table_not_then_sibling () =
  check ~pos:__POS__ ~expected:true
    "&:not(.rowHoverGroup) + .rowHoverGroup { border-top: 1px solid red; }"

(* SelectButton.re:76 — sibling then descendant still escapes. *)
let select_button_sibling_descendant () =
  check ~pos:__POS__ ~expected:true "& + * .contentContainer { color: red; }"

let sibling_type_selector () =
  check ~pos:__POS__ ~expected:true "& + span { transition: 1ms; }"

(* `&` carrying a class still escapes when it is the left sibling operand. *)
let compound_ampersand_left_of_sibling () =
  check ~pos:__POS__ ~expected:true "&.foo + .bar { color: red; }"

(* `&` carrying a pseudo-element, likewise. *)
let pseudo_element_ampersand_left_of_sibling () =
  check ~pos:__POS__ ~expected:true "&::before + .bar { color: red; }"

(* Two `&`s but the subject `.x` is reached only via sibling steps. *)
let double_ampersand_then_sibling_subject () =
  check ~pos:__POS__ ~expected:true "& + & + .x { color: red; }"

(* --- Safe look-alikes: must NOT be flagged --- *)

(* `X + &` — the subject is `&`, which carries its own inline var. *)
let sibling_before_ampersand () =
  check ~pos:__POS__ ~expected:false ".x + & { color: red; }"

(* `& + &` — the next instance carries the same binding's inline var. *)
let self_sibling () =
  check ~pos:__POS__ ~expected:false "& + & { color: red; }"

(* Subject is the trailing `&`, regardless of intermediate siblings. *)
let sibling_chain_ending_in_ampersand () =
  check ~pos:__POS__ ~expected:false "& + .x + & { color: red; }"

(* A descendant step before the sibling keeps the subject inside `&`. *)
let descendant_then_sibling () =
  check ~pos:__POS__ ~expected:false "& input + div { color: red; }"

(* Child step before the sibling, likewise. *)
let child_then_sibling () =
  check ~pos:__POS__ ~expected:false "& > * + * { color: red; }"

(* The reaching `&` is the *second* one (`& + & .x`): `.x` is a descendant
   of the second `&`, which carries its own inline var. *)
let second_ampersand_reaches_subject () =
  check ~pos:__POS__ ~expected:false "& + & .x { color: red; }"

let descendant () =
  check ~pos:__POS__ ~expected:false "& .child { color: red; }"

let child () = check ~pos:__POS__ ~expected:false "& > .child { color: red; }"

let self_compound () =
  check ~pos:__POS__ ~expected:false "&:hover { color: red; }"

(* No `&` at all: the className is prepended via a descendant combinator
   (`.css-x .a + .b`), keeping the whole chain inside the styled element. *)
let sibling_without_ampersand () =
  check ~pos:__POS__ ~expected:false ".a + .b { color: red; }"

let type_sibling_without_ampersand () =
  check ~pos:__POS__ ~expected:false "input + div { color: red; }"

let test name fn = (name, fn)

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
