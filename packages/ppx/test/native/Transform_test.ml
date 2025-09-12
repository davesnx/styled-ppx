open Styled_ppx_css_parser.Ast
open Styled_ppx_css_parser

let loc = Ppxlib.Location.none
let with_loc x = x, loc

let declaration property value =
  Declaration
    {
      name = with_loc property;
      value = with_loc [ with_loc (Ident value) ];
      important = with_loc false;
      loc;
    }

let simple_selector selector = SimpleSelector selector

let make_selector str =
  match str with
  | "&" -> SimpleSelector Ampersand
  | s when String.starts_with ~prefix:"." s ->
    CompoundSelector
      {
        type_selector = None;
        subclass_selectors = [ Class (String.sub s 1 (String.length s - 1)) ];
        pseudo_selectors = [];
      }
  | s when String.starts_with ~prefix:":" s ->
    CompoundSelector
      {
        type_selector = None;
        subclass_selectors = [];
        pseudo_selectors =
          [ Pseudoclass (PseudoIdent (String.sub s 1 (String.length s - 1))) ];
      }
  | s when String.starts_with ~prefix:"::" s ->
    CompoundSelector
      {
        type_selector = None;
        subclass_selectors = [];
        pseudo_selectors =
          [ Pseudoelement (String.sub s 2 (String.length s - 2)) ];
      }
  | s -> SimpleSelector (Type s)

let parse input =
  match Styled_ppx_css_parser.Driver.parse_declaration_list input with
  | Ok rule_list -> rule_list
  | Error (_loc_start, _loc_end, error) -> Alcotest.fail error

let render input =
  let loc = Ppxlib.Location.none in
  Styled_ppx_css_parser.Render.rule_list (input, loc)

let check ~pos expected actual =
  Alcotest.check ~pos Alcotest.string "" actual expected

let split_by_kind () =
  let rules = parse "color: red; .test {} margin: 0; @media {}" in
  let declarations, selectors = Transform.split_by_kind (fst rules) in
  Alcotest.check ~pos:__POS__ Alcotest.int "Should have 2 declarations" 2
    (List.length declarations);
  Alcotest.check ~pos:__POS__ Alcotest.int "Should have 2 non-declarations" 2
    (List.length selectors)

let unnest_selector () =
  let input = "margin: 10px; a { display: block; div { display: none; } }" in
  let rule_list = parse input in
  let list_of_rules = Transform.run rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "margin: 10px; a { display: block; } a div { display: none; }"

let unnest_selector_with_ampersand () =
  let input =
    {|
    margin: 10px;
    & > a {
      margin: 11px;
      & > div {
        margin: 12px;
      }
    }
  |}
  in
  let rule_list = parse input in
  let list_of_rules = Transform.run rule_list in
  check ~pos:__POS__ (render list_of_rules)
    "margin: 10px; & > a { margin: 11px; } & > a > div { margin: 12px; }"

let tests : tests =
  [
    test "split_by_kind" split_by_kind;
    test "unnest_selector" unnest_selector;
    test "unnest_selector_with_ampersand" unnest_selector_with_ampersand;
  ]
