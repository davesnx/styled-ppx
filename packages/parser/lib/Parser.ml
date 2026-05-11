open Ast
module Lex = Lexer

exception Parse_error of (Lexing.position * Lexing.position * string)

type raw_token_with_location = Lexer.token_with_location

type token_with_location = {
  txt : Tokens.token;
  start_pos : Lexing.position;
  end_pos : Lexing.position;
}

type stream = {
  tokens : token_with_location array;
  mutable index : int;
  mutable last_end_pos : Lexing.position;
}

type declaration_value_state = {
  has_content : bool;
  top_level_items : int;
  ident_like_prefix : bool;
}

let make_loc start_pos end_pos =
  Parser_location.to_ppxlib_location start_pos end_pos

let component_loc (token : token_with_location) =
  make_loc token.start_pos token.end_pos

let token_text = function
  | Tokens.WS -> " "
  | Tokens.IDENT name -> name
  | token -> Tokens.humanize token

let raise_parse_error (token : token_with_location) =
  let message =
    Printf.sprintf "Parse error while reading token '%s'" (token_text token.txt)
  in
  raise (Parse_error (token.start_pos, token.end_pos, message))

let current_token stream =
  let last_index = Array.length stream.tokens - 1 in
  let index = if stream.index > last_index then last_index else stream.index in
  stream.tokens.(index)

let current_tok stream = (current_token stream).txt

let advance stream =
  let token = current_token stream in
  if stream.index < Array.length stream.tokens then
    stream.index <- stream.index + 1;
  stream.last_end_pos <- token.end_pos;
  token

let current_is stream expected = current_tok stream = expected

let current_is_whitespace stream =
  match current_tok stream with Tokens.WS -> true | _ -> false

let skip_whitespace stream =
  while current_is_whitespace stream do
    let _ = advance stream in
    ()
  done

let accept_token stream expected =
  if current_is stream expected then Some (advance stream) else None

let expect_token stream expected =
  match accept_token stream expected with
  | Some token -> token
  | None -> raise_parse_error (current_token stream)

let accept_ident stream =
  match current_tok stream with
  | Tokens.IDENT name ->
    let token = advance stream in
    Some (name, token)
  | _ -> None

let expect_ident stream =
  match accept_ident stream with
  | Some value -> value
  | None -> raise_parse_error (current_token stream)

let with_loc start_pos end_pos value = value, make_loc start_pos end_pos

let loc_from_start stream start_pos =
  if stream.last_end_pos = Lexing.dummy_pos then make_loc start_pos start_pos
  else make_loc start_pos stream.last_end_pos

let eof_loc stream =
  let token = current_token stream in
  make_loc token.start_pos token.start_pos

let with_empty_or_consumed_loc stream start_pos values =
  match values with
  | [] -> values, make_loc start_pos start_pos
  | _ -> values, make_loc start_pos stream.last_end_pos

let token_at index tokens =
  if index < Array.length tokens then tokens.(index)
  else tokens.(Array.length tokens - 1)

let token_is_whitespace token =
  match token.txt with Tokens.WS -> true | _ -> false

let snapshot stream = stream.index, stream.last_end_pos

let restore stream (index, last_end_pos) =
  stream.index <- index;
  stream.last_end_pos <- last_end_pos

let attempt stream parse_one =
  let saved = snapshot stream in
  match parse_one stream with
  | value -> Some value
  | exception Parse_error _ ->
    restore stream saved;
    None

let next_significant_index tokens start =
  let rec loop index =
    if index >= Array.length tokens then index
    else if token_is_whitespace tokens.(index) then loop (index + 1)
    else index
  in
  loop start

(* -- Token set predicates (Design 3) -- *)

let is_selector_start = function
  | Tokens.DELIM ("." | "&" | "*")
  | Tokens.HASH _ | Tokens.LEFT_BRACKET | Tokens.INTERPOLATION _ ->
    true
  | _ -> false

let is_pseudo_start = function
  | Tokens.COLON | Tokens.DOUBLE_COLON -> true
  | _ -> false

let is_combinator_delim = function ">" | "+" | "~" -> true | _ -> false

let is_at_rule_start = function
  | Tokens.AT_RULE _ | Tokens.AT_KEYFRAMES _ -> true
  | _ -> false

(* Tokens that start a selector (ident or any selector-start or pseudo) *)
let token_starts_selector tok =
  match tok with
  | Tokens.IDENT _ -> true
  | tok -> is_selector_start tok || is_pseudo_start tok

(* Tokens that start a selector prelude (ident or selector-start, no pseudo) *)
let token_starts_selector_prelude tok =
  match tok with Tokens.IDENT _ -> true | tok -> is_selector_start tok

type nested_block_kind =
  | Nested_block_at_rule
  | Nested_block_selector_ident
  | Nested_block_selector_explicit

type block_scan_mode =
  | Block_scan_at_rule
  | Block_scan_selector

let block_follows ?(initial_saw_selector_token = false) tokens start_index mode
    =
  let index = ref start_index in
  let read () =
    let token : token_with_location = token_at !index tokens in
    incr index;
    token.txt
  in
  let rec scan_at_rule ~paren_depth ~bracket_depth =
    match read () with
    | Tokens.WS | Tokens.IDENT _ -> scan_at_rule ~paren_depth ~bracket_depth
    | Tokens.FUNCTION _ | Tokens.NTH_FUNCTION _ | Tokens.LEFT_PAREN ->
      scan_at_rule ~paren_depth:(paren_depth + 1) ~bracket_depth
    | Tokens.RIGHT_PAREN ->
      let next_paren_depth = if paren_depth > 0 then paren_depth - 1 else 0 in
      scan_at_rule ~paren_depth:next_paren_depth ~bracket_depth
    | Tokens.LEFT_BRACKET ->
      scan_at_rule ~paren_depth ~bracket_depth:(bracket_depth + 1)
    | Tokens.RIGHT_BRACKET ->
      let next_bracket_depth =
        if bracket_depth > 0 then bracket_depth - 1 else 0
      in
      scan_at_rule ~paren_depth ~bracket_depth:next_bracket_depth
    | Tokens.LEFT_BRACE -> paren_depth = 0 && bracket_depth = 0
    | Tokens.SEMI_COLON | Tokens.RIGHT_BRACE | Tokens.EOF -> false
    | _ -> scan_at_rule ~paren_depth ~bracket_depth
  in
  let rec scan_selector ~paren_depth ~bracket_depth ~saw_selector_token =
    match read () with
    | Tokens.WS -> scan_selector ~paren_depth ~bracket_depth ~saw_selector_token
    | Tokens.IDENT _ ->
      scan_selector ~paren_depth ~bracket_depth ~saw_selector_token:true
    | token ->
      if paren_depth > 0 || bracket_depth > 0 then (
        match token with
        | Tokens.FUNCTION _ | Tokens.NTH_FUNCTION _ | Tokens.LEFT_PAREN ->
          scan_selector ~paren_depth:(paren_depth + 1) ~bracket_depth
            ~saw_selector_token
        | Tokens.RIGHT_PAREN ->
          let next_paren_depth =
            if paren_depth > 0 then paren_depth - 1 else 0
          in
          scan_selector ~paren_depth:next_paren_depth ~bracket_depth
            ~saw_selector_token
        | Tokens.LEFT_BRACKET ->
          scan_selector ~paren_depth ~bracket_depth:(bracket_depth + 1)
            ~saw_selector_token
        | Tokens.RIGHT_BRACKET ->
          let next_bracket_depth =
            if bracket_depth > 0 then bracket_depth - 1 else 0
          in
          scan_selector ~paren_depth ~bracket_depth:next_bracket_depth
            ~saw_selector_token
        | Tokens.LEFT_BRACE | Tokens.RIGHT_BRACE | Tokens.SEMI_COLON
        | Tokens.EOF ->
          false
        | _ -> scan_selector ~paren_depth ~bracket_depth ~saw_selector_token)
      else (
        match token with
        | Tokens.LEFT_BRACE -> saw_selector_token
        | (Tokens.FUNCTION _ | Tokens.NTH_FUNCTION _) when saw_selector_token ->
          scan_selector ~paren_depth:(paren_depth + 1) ~bracket_depth
            ~saw_selector_token:true
        | Tokens.LEFT_BRACKET ->
          scan_selector ~paren_depth ~bracket_depth:(bracket_depth + 1)
            ~saw_selector_token:true
        | tok when is_selector_start tok || is_pseudo_start tok ->
          scan_selector ~paren_depth ~bracket_depth ~saw_selector_token:true
        | Tokens.DELIM s when is_combinator_delim s ->
          scan_selector ~paren_depth ~bracket_depth ~saw_selector_token:true
        | Tokens.COMMA ->
          scan_selector ~paren_depth ~bracket_depth ~saw_selector_token:true
        | Tokens.SEMI_COLON | Tokens.RIGHT_BRACE | Tokens.EOF -> false
        | _ -> false)
  in
  match mode with
  | Block_scan_at_rule -> scan_at_rule ~paren_depth:0 ~bracket_depth:0
  | Block_scan_selector ->
    scan_selector ~paren_depth:0 ~bracket_depth:0
      ~saw_selector_token:initial_saw_selector_token

let known_selector_pseudo_ident = function
  | "active" | "any-link" | "autofill" | "checked" | "defined" | "disabled"
  | "empty" | "enabled" | "first-child" | "first-of-type" | "focus"
  | "focus-visible" | "focus-within" | "fullscreen" | "future" | "hover"
  | "in-range" | "indeterminate" | "invalid" | "last-child" | "last-of-type"
  | "link" | "modal" | "only-child" | "only-of-type" | "optional"
  | "out-of-range" | "past" | "paused" | "picture-in-picture"
  | "placeholder-shown" | "playing" | "popover-open" | "read-only"
  | "read-write" | "required" | "root" | "scope" | "target" | "user-invalid"
  | "valid" | "visited" ->
    true
  | _ -> false

let known_selector_pseudo_function = function
  | "current" | "dir" | "has" | "host" | "host-context" | "is" | "lang" | "not"
  | "nth-col" | "nth-last-col" | "part" | "slotted" | "state" | "where" ->
    true
  | _ -> false

let token_biases_selector_pseudo = function
  | Tokens.IDENT name -> known_selector_pseudo_ident name
  | Tokens.FUNCTION name -> known_selector_pseudo_function name
  | Tokens.NTH_FUNCTION _ | Tokens.COLON | Tokens.DOUBLE_COLON -> true
  | _ -> false

let nested_block_kind tokens start_index =
  let next_index = next_significant_index tokens start_index in
  let next_token = token_at next_index tokens in
  match next_token.txt with
  | Tokens.INTERPOLATION _ -> None
  | tok when is_at_rule_start tok ->
    if block_follows tokens next_index Block_scan_at_rule then
      Some Nested_block_at_rule
    else None
  | Tokens.IDENT _ ->
    if block_follows tokens next_index Block_scan_selector then
      Some Nested_block_selector_ident
    else None
  | tok when is_selector_start tok ->
    if block_follows tokens next_index Block_scan_selector then
      Some Nested_block_selector_explicit
    else None
  | _ -> None

let declaration_value_starts_nested_block tokens start_index state =
  state.has_content
  &&
  match nested_block_kind tokens start_index with
  | Some Nested_block_at_rule -> true
  | Some Nested_block_selector_ident ->
    state.top_level_items = 1 && state.ident_like_prefix
  | Some Nested_block_selector_explicit -> true
  | None -> false

let identifier_starts_property tokens start_index =
  let colon_index = next_significant_index tokens start_index in
  let colon_token = token_at colon_index tokens in
  match colon_token.txt with
  | Tokens.COLON ->
    let value_index = next_significant_index tokens (colon_index + 1) in
    let value_token = token_at value_index tokens in
    not
      (token_biases_selector_pseudo value_token.txt
      && block_follows ~initial_saw_selector_token:true tokens value_index
           Block_scan_selector)
  | _ -> false

let string_of_nth_operator op = op

let selector_combinator_of_delim = function
  | "+" -> Ast.Selector_adjacent_sibling
  | "~" -> Ast.Selector_general_sibling
  | ">" -> Ast.Selector_child
  | _ -> assert false

let parse_attr_matcher stream =
  match current_tok stream with
  | Tokens.DELIM "~" ->
    let _ = advance stream in
    let _ = expect_token stream (Tokens.DELIM "=") in
    Attr_member
  | Tokens.DELIM "|" ->
    let _ = advance stream in
    let _ = expect_token stream (Tokens.DELIM "=") in
    Attr_prefix_dash
  | Tokens.DELIM "^" ->
    let _ = advance stream in
    let _ = expect_token stream (Tokens.DELIM "=") in
    Attr_prefix
  | Tokens.DELIM "$" ->
    let _ = advance stream in
    let _ = expect_token stream (Tokens.DELIM "=") in
    Attr_suffix
  | Tokens.DELIM "*" ->
    let _ = advance stream in
    let _ = expect_token stream (Tokens.DELIM "=") in
    Attr_substring
  | Tokens.DELIM "=" ->
    let _ = advance stream in
    Attr_exact
  | _ -> raise_parse_error (current_token stream)

let parse_wq_name stream =
  let name, _ = expect_ident stream in
  name

let parse_nth_payload stream =
  skip_whitespace stream;
  let payload =
    match current_tok stream with
    | Tokens.NUMBER a ->
      let _ = advance stream in
      Ast.Nth (A (int_of_float a))
    | Tokens.DIMENSION (num, unit) ->
      let _ = advance stream in
      skip_whitespace stream;
      begin match current_tok stream with
      | Tokens.DELIM (("+" | "-") as op) ->
        let _ = advance stream in
        skip_whitespace stream;
        let b =
          match current_tok stream with
          | Tokens.NUMBER value ->
            let _ = advance stream in
            int_of_float value
          | _ -> raise_parse_error (current_token stream)
        in
        Ast.Nth (ANB (int_of_float num, op, b))
      | Tokens.NUMBER value ->
        let _ = advance stream in
        let b = int_of_float value in
        let op, abs_b = if b < 0 then "-", abs b else "+", b in
        Ast.Nth (ANB (int_of_float num, op, abs_b))
      | _ ->
        if String.length unit > 2 && unit.[0] = 'n' && unit.[1] = '-' then (
          let b = int_of_string (String.sub unit 2 (String.length unit - 2)) in
          Ast.Nth (ANB (int_of_float num, "-", b)))
        else Ast.Nth (AN (int_of_float num))
      end
    | Tokens.IDENT name ->
      let _ = advance stream in
      skip_whitespace stream;
      begin match current_tok stream with
      | Tokens.DELIM (("+" | "-") as op) ->
        let _ = advance stream in
        skip_whitespace stream;
        let b =
          match current_tok stream with
          | Tokens.NUMBER value ->
            let _ = advance stream in
            int_of_float value
          | _ -> raise_parse_error (current_token stream)
        in
        let first_char = name.[0] in
        let a = if first_char = '-' then -1 else 1 in
        Ast.Nth (ANB (a, op, b))
      | Tokens.NUMBER value ->
        let _ = advance stream in
        let b = int_of_float value in
        let op, abs_b = if b < 0 then "-", abs b else "+", b in
        let first_char = name.[0] in
        let a = if first_char = '-' then -1 else 1 in
        Ast.Nth (ANB (a, op, abs_b))
      | _ -> begin
        match name with
        | "even" -> Ast.Nth Even
        | "odd" -> Ast.Nth Odd
        | "n" -> Ast.Nth (AN 1)
        | _ ->
          let first_char = name.[0] in
          let a = if first_char = '-' then -1 else 1 in
          Ast.Nth (AN a)
      end
      end
    | _ -> raise_parse_error (current_token stream)
  in
  payload

let rec parse_component_value stream =
  let start_pos = (current_token stream).start_pos in
  match current_tok stream with
  | Tokens.WS ->
    let token = advance stream in
    Ast.Whitespace, component_loc token
  | Tokens.IDENT name ->
    let _ = advance stream in
    with_loc start_pos stream.last_end_pos (Ast.Ident name)
  | Tokens.LEFT_PAREN ->
    let _ = advance stream in
    let values, _ =
      parse_component_value_list_until stream (fun stream ->
        current_is stream Tokens.RIGHT_PAREN)
    in
    let _ = expect_token stream Tokens.RIGHT_PAREN in
    with_loc start_pos stream.last_end_pos (Ast.Paren_block values)
  | Tokens.LEFT_BRACKET ->
    let _ = advance stream in
    let values, _ =
      parse_component_value_list_until stream (fun stream ->
        current_is stream Tokens.RIGHT_BRACKET)
    in
    let _ = expect_token stream Tokens.RIGHT_BRACKET in
    with_loc start_pos stream.last_end_pos (Ast.Bracket_block values)
  | Tokens.PERCENTAGE value ->
    let _ = advance stream in
    with_loc start_pos stream.last_end_pos
      (Ast.Percentage value : Ast.component_value)
  | Tokens.STRING value ->
    let _ = advance stream in
    with_loc start_pos stream.last_end_pos (Ast.String value)
  | Tokens.URL value ->
    let _ = advance stream in
    with_loc start_pos stream.last_end_pos (Ast.Uri value)
  | Tokens.HASH (value, kind) ->
    let _ = advance stream in
    let kind =
      match kind with
      | `ID -> Ast.Hash_kind_id
      | `UNRESTRICTED -> Ast.Hash_kind_unrestricted
    in
    with_loc start_pos stream.last_end_pos (Ast.Hash (value, kind))
  | Tokens.NUMBER value ->
    let _ = advance stream in
    with_loc start_pos stream.last_end_pos (Ast.Number value)
  | Tokens.UNICODE_RANGE value ->
    let _ = advance stream in
    with_loc start_pos stream.last_end_pos (Ast.Unicode_range value)
  | Tokens.DIMENSION (value, unit) ->
    let _ = advance stream in
    with_loc start_pos stream.last_end_pos
      (Ast.Dimension (Ast.dimension_make (value, unit)))
  | Tokens.INTERPOLATION (content, loc) ->
    let _ = advance stream in
    with_loc start_pos stream.last_end_pos
      (Ast.Variable (content, loc) : Ast.component_value)
  | Tokens.FUNCTION name ->
    let token = advance stream in
    let body, body_loc =
      parse_component_value_list_until stream (fun stream ->
        current_is stream Tokens.RIGHT_PAREN)
    in
    let _ = expect_token stream Tokens.RIGHT_PAREN in
    let name_loc = component_loc token in
    with_loc start_pos stream.last_end_pos
      (Ast.Function
         ({
            name = name, name_loc;
            kind = Ast.Function_kind_regular;
            body = body, body_loc;
          }
           : Ast.component_function)
        : Ast.component_value)
  | Tokens.NTH_FUNCTION name ->
    let token = advance stream in
    let body, body_loc =
      parse_component_value_list_until stream (fun stream ->
        current_is stream Tokens.RIGHT_PAREN)
    in
    let _ = expect_token stream Tokens.RIGHT_PAREN in
    let name_loc = component_loc token in
    with_loc start_pos stream.last_end_pos
      (Ast.Function
         ({
            name = name, name_loc;
            kind = Ast.Function_kind_nth;
            body = body, body_loc;
          }
           : Ast.component_function)
        : Ast.component_value)
  | Tokens.COLON ->
    let _ = advance stream in
    with_loc start_pos stream.last_end_pos (Ast.Delim Ast.Delimiter_colon)
  | Tokens.DOUBLE_COLON ->
    let _ = advance stream in
    with_loc start_pos stream.last_end_pos
      (Ast.Delim Ast.Delimiter_double_colon)
  | Tokens.COMMA ->
    let _ = advance stream in
    with_loc start_pos stream.last_end_pos (Ast.Delim Ast.Delimiter_comma)
  | Tokens.DELIM s -> begin
    match Ast.delimiter_of_string s with
    | Some delim ->
      let _ = advance stream in
      with_loc start_pos stream.last_end_pos (Ast.Delim delim)
    | None -> raise_parse_error (current_token stream)
  end
  | _ -> raise_parse_error (current_token stream)

and parse_component_value_list_until stream stop =
  let start_pos = (current_token stream).start_pos in
  let rec loop acc =
    if stop stream then
      with_empty_or_consumed_loc stream start_pos (List.rev acc)
    else (
      let value = parse_component_value stream in
      loop (value :: acc))
  in
  loop []

let selector_starts_non_complex stream =
  token_starts_selector (current_tok stream)

let parse_selector_ident stream =
  let name, _ = expect_ident stream in
  name

let parse_type_selector stream =
  match current_tok stream with
  | Tokens.DELIM "&" ->
    let _ = advance stream in
    Ampersand
  | Tokens.DELIM "*" ->
    let _ = advance stream in
    Universal
  | Tokens.INTERPOLATION (content, loc) ->
    let _ = advance stream in
    Variable (content, loc)
  | Tokens.IDENT name ->
    let _ = advance stream in
    Type name
  | _ -> raise_parse_error (current_token stream)

let rec parse_attribute_selector stream =
  let _ = expect_token stream Tokens.LEFT_BRACKET in
  skip_whitespace stream;
  let name = parse_wq_name stream in
  skip_whitespace stream;
  if current_is stream Tokens.RIGHT_BRACKET then (
    let _ = advance stream in
    Attr_value name)
  else (
    let kind = parse_attr_matcher stream in
    skip_whitespace stream;
    let value =
      match current_tok stream with
      | Tokens.STRING value ->
        let _ = advance stream in
        Attr_string value
      | Tokens.IDENT value ->
        let _ = advance stream in
        Attr_ident value
      | _ -> raise_parse_error (current_token stream)
    in
    skip_whitespace stream;
    let _ = expect_token stream Tokens.RIGHT_BRACKET in
    To_equal { name; kind; value })

and parse_pseudo_class_selector stream =
  let _ = expect_token stream Tokens.COLON in
  match current_tok stream with
  | Tokens.IDENT name ->
    let _ = advance stream in
    Pseudoclass (PseudoIdent name)
  | Tokens.FUNCTION name ->
    let start_pos = (current_token stream).start_pos in
    let _ = advance stream in
    let selectors, payload_loc = parse_relative_selector_list stream in
    let _ = expect_token stream Tokens.RIGHT_PAREN in
    let payload_loc =
      match selectors with
      | [] -> make_loc start_pos start_pos
      | _ -> payload_loc
    in
    Pseudoclass
      (Ast.Function { name; payload = selectors, payload_loc }
        : Ast.pseudoclass_kind)
  | Tokens.NTH_FUNCTION name ->
    let start_pos = (current_token stream).start_pos in
    let _ = advance stream in
    let payload = parse_nth_payload stream in
    let payload_loc = make_loc start_pos stream.last_end_pos in
    let _ = expect_token stream Tokens.RIGHT_PAREN in
    Pseudoclass
      (Ast.NthFunction { name; payload = payload, payload_loc }
        : Ast.pseudoclass_kind)
  | _ -> raise_parse_error (current_token stream)

and parse_pseudo_element_selector stream =
  let _ = expect_token stream Tokens.DOUBLE_COLON in
  let name = parse_selector_ident stream in
  Pseudoelement name

and parse_pseudo_list stream =
  let first = parse_pseudo_element_selector stream in
  let rec loop acc =
    skip_whitespace stream;
    match current_tok stream with
    | Tokens.COLON ->
      let pseudo = parse_pseudo_class_selector stream in
      loop (pseudo :: acc)
    | _ -> List.rev acc
  in
  loop [ first ]

and parse_subclass_selector stream =
  match current_tok stream with
  | Tokens.HASH (value, _) ->
    let _ = advance stream in
    Id value
  | Tokens.DELIM "." ->
    let _ = advance stream in
    begin match current_tok stream with
    | Tokens.IDENT value ->
      let _ = advance stream in
      Class value
    | Tokens.INTERPOLATION (content, loc) ->
      let _ = advance stream in
      ClassVariable (content, loc)
    | _ -> raise_parse_error (current_token stream)
    end
  | Tokens.LEFT_BRACKET -> Attribute (parse_attribute_selector stream)
  | Tokens.COLON -> Pseudo_class (parse_pseudo_class_selector stream)
  | _ -> raise_parse_error (current_token stream)

and parse_non_complex_selector stream =
  let type_selector =
    match current_tok stream with
    | Tokens.IDENT _ | Tokens.DELIM ("&" | "*") | Tokens.INTERPOLATION _ ->
      Some (parse_type_selector stream)
    | _ -> None
  in
  let rec collect_subclasses acc =
    match current_tok stream with
    | Tokens.HASH _ | Tokens.DELIM "." | Tokens.LEFT_BRACKET | Tokens.COLON ->
      let subclass = parse_subclass_selector stream in
      collect_subclasses (subclass :: acc)
    | _ -> List.rev acc
  in
  let subclass_selectors = collect_subclasses [] in
  let pseudo_selectors =
    match current_tok stream with
    | Tokens.DOUBLE_COLON -> parse_pseudo_list stream
    | _ -> []
  in
  match type_selector, subclass_selectors, pseudo_selectors with
  | Some simple, [], [] -> SimpleSelector simple
  | None, [], [] -> raise_parse_error (current_token stream)
  | _ ->
    CompoundSelector { type_selector; subclass_selectors; pseudo_selectors }

and parse_complex_selector stream =
  let left = parse_non_complex_selector stream in
  let rec loop right =
    let saw_whitespace = ref false in
    while current_is_whitespace stream do
      saw_whitespace := true;
      let _ = advance stream in
      ()
    done;
    match current_tok stream with
    | Tokens.DELIM (("+" | "~" | ">") as s) ->
      let _ = advance stream in
      skip_whitespace stream;
      let selector = parse_non_complex_selector stream in
      loop ((selector_combinator_of_delim s, selector) :: right)
    | _ when !saw_whitespace && selector_starts_non_complex stream ->
      let selector = parse_non_complex_selector stream in
      loop ((Ast.Selector_descendant, selector) :: right)
    | _ ->
      (match List.rev right with
      | [] -> Selector left
      | right -> Combinator { left; right })
  in
  loop []

and parse_selector stream = ComplexSelector (parse_complex_selector stream)

and parse_selector_list_with stream parse_one =
  skip_whitespace stream;
  let start_pos = (current_token stream).start_pos in
  let rec loop acc =
    let item_start = (current_token stream).start_pos in
    let item = parse_one stream in
    let item_loc = make_loc item_start stream.last_end_pos in
    skip_whitespace stream;
    let acc = (item, item_loc) :: acc in
    match current_tok stream with
    | Tokens.COMMA ->
      let _ = advance stream in
      skip_whitespace stream;
      loop acc
    | _ ->
      let items = List.rev acc in
      let loc =
        if items = [] then make_loc start_pos start_pos
        else make_loc start_pos stream.last_end_pos
      in
      items, loc
  in
  loop []

and parse_selector_list stream = parse_selector_list_with stream parse_selector

and parse_relative_selector stream =
  skip_whitespace stream;
  let combinator =
    match current_tok stream with
    | Tokens.DELIM (("+" | "~" | ">") as s) ->
      let _ = advance stream in
      skip_whitespace stream;
      Some (selector_combinator_of_delim s)
    | _ -> None
  in
  let complex_selector = parse_complex_selector stream in
  RelativeSelector { combinator; complex_selector }

and parse_relative_selector_list stream =
  parse_selector_list_with stream parse_relative_selector

let update_declaration_value_state state (value, _) =
  match value with
  | Whitespace -> state
  | Ident _ ->
    let top_level_items = state.top_level_items + 1 in
    let ident_like_prefix =
      if top_level_items = 1 then true else state.ident_like_prefix
    in
    { has_content = true; top_level_items; ident_like_prefix }
  | Number _ | Percentage _ | Dimension _ | Hash _ | String _ | Uri _
  | Variable _ | Function _ ->
    let top_level_items = state.top_level_items + 1 in
    let ident_like_prefix =
      if top_level_items = 1 then false else state.ident_like_prefix
    in
    { has_content = true; top_level_items; ident_like_prefix }
  | Paren_block _ | Bracket_block _ | Delim _ | Selector _ | Unicode_range _ ->
    { state with has_content = true }

let parse_declaration_value_list stream =
  let start_pos = (current_token stream).start_pos in
  let initial_state =
    { has_content = false; top_level_items = 0; ident_like_prefix = false }
  in
  let rec loop acc state =
    match current_tok stream with
    | Tokens.EOF | Tokens.RIGHT_BRACE | Tokens.SEMI_COLON | Tokens.IMPORTANT ->
      with_empty_or_consumed_loc stream start_pos (List.rev acc)
    | _
      when declaration_value_starts_nested_block stream.tokens stream.index
             state ->
      with_empty_or_consumed_loc stream start_pos (List.rev acc)
    | _ ->
      let value = parse_component_value stream in
      let state = update_declaration_value_state state value in
      loop (value :: acc) state
  in
  loop [] initial_state

let parse_declaration_no_eof stream =
  skip_whitespace stream;
  let start_pos = (current_token stream).start_pos in
  let name, name_token = expect_ident stream in
  let name_loc = component_loc name_token in
  skip_whitespace stream;
  let _ = expect_token stream Tokens.COLON in
  let value, value_loc = parse_declaration_value_list stream in
  let important =
    match current_tok stream with
    | Tokens.IMPORTANT ->
      let token = advance stream in
      true, component_loc token
    | _ ->
      let token = current_token stream in
      false, make_loc token.start_pos token.start_pos
  in
  let _ = accept_token stream Tokens.SEMI_COLON in
  {
    name = name, name_loc;
    value = value, value_loc;
    important;
    loc = loc_from_start stream start_pos;
  }

let parse_rule_list stream ~stop ~parse_one ~allow_empty =
  skip_whitespace stream;
  let start_pos = (current_token stream).start_pos in
  if stop stream then
    if allow_empty then [], eof_loc stream
    else raise_parse_error (current_token stream)
  else (
    let rec loop acc =
      skip_whitespace stream;
      if stop stream then List.rev acc
      else (
        let rule = parse_one stream in
        loop (rule :: acc))
    in
    let rules = loop [] in
    rules, make_loc start_pos stream.last_end_pos)

let parse_empty_rule_block stream (left_brace : token_with_location) =
  let right_brace : token_with_location =
    expect_token stream Tokens.RIGHT_BRACE
  in
  let _ = accept_token stream Tokens.SEMI_COLON in
  [], make_loc left_brace.start_pos right_brace.end_pos

let parse_braced_rules stream left_brace parse_rules =
  skip_whitespace stream;
  if current_is stream Tokens.RIGHT_BRACE then
    parse_empty_rule_block stream left_brace
  else (
    let rules = parse_rules stream in
    let _ = expect_token stream Tokens.RIGHT_BRACE in
    let _ = accept_token stream Tokens.SEMI_COLON in
    rules)

let rec parse_keyframe_style_rule stream =
  skip_whitespace stream;
  let start_pos = (current_token stream).start_pos in
  let prelude =
    match current_tok stream with
    | Tokens.IDENT name ->
      let _, token = expect_ident stream in
      let selector = SimpleSelector (Type name), component_loc token in
      [ selector ], component_loc token
    | Tokens.PERCENTAGE _ ->
      let rec loop acc =
        let token = current_token stream in
        match current_tok stream with
        | Tokens.PERCENTAGE percent ->
          let _ = advance stream in
          skip_whitespace stream;
          let acc =
            (SimpleSelector (Percentage percent), component_loc token) :: acc
          in
          begin match current_tok stream with
          | Tokens.COMMA ->
            let _ = advance stream in
            skip_whitespace stream;
            loop acc
          | _ -> List.rev acc
          end
        | _ -> raise_parse_error (current_token stream)
      in
      let selectors = loop [] in
      let prelude_loc =
        match selectors with
        | [] -> eof_loc stream
        | _ -> make_loc start_pos stream.last_end_pos
      in
      selectors, prelude_loc
    | _ -> raise_parse_error (current_token stream)
  in
  skip_whitespace stream;
  let block =
    let left_brace = expect_token stream Tokens.LEFT_BRACE in
    parse_braced_rules stream left_brace (fun stream ->
      let rules, rules_loc =
        parse_rule_list stream
          ~stop:(fun stream -> current_is stream Tokens.RIGHT_BRACE)
          ~parse_one:parse_block_rule ~allow_empty:false
      in
      rules, rules_loc)
  in
  Style_rule { prelude; block; loc = loc_from_start stream start_pos }

and parse_keyframe_rule_list stream =
  parse_rule_list stream
    ~stop:(fun stream ->
      current_is stream Tokens.RIGHT_BRACE || current_is stream Tokens.EOF)
    ~parse_one:parse_keyframe_style_rule ~allow_empty:false

and parse_at_rule stream =
  skip_whitespace stream;
  let start_pos = (current_token stream).start_pos in
  match current_tok stream with
  | Tokens.AT_KEYFRAMES name ->
    let at_token = advance stream in
    skip_whitespace stream;
    let keyframe_name, keyframe_token = expect_ident stream in
    let keyframe_loc = component_loc keyframe_token in
    let prelude = [ Ident keyframe_name, keyframe_loc ], keyframe_loc in
    skip_whitespace stream;
    let left_brace = expect_token stream Tokens.LEFT_BRACE in
    let block =
      Rule_list (parse_braced_rules stream left_brace parse_keyframe_rule_list)
    in
    {
      name = name, component_loc at_token;
      prelude;
      block;
      loc = loc_from_start stream start_pos;
    }
  | Tokens.AT_RULE_STATEMENT name ->
    let at_token = advance stream in
    let prelude, prelude_loc =
      parse_component_value_list_until stream (fun stream ->
        current_is stream Tokens.SEMI_COLON)
    in
    let _ = expect_token stream Tokens.SEMI_COLON in
    {
      name = name, component_loc at_token;
      prelude = prelude, prelude_loc;
      block = Empty;
      loc = loc_from_start stream start_pos;
    }
  | Tokens.AT_RULE name ->
    let at_token = advance stream in
    let prelude, prelude_loc =
      parse_component_value_list_until stream (fun stream ->
        current_is stream Tokens.LEFT_BRACE)
    in
    let left_brace = expect_token stream Tokens.LEFT_BRACE in
    let rules =
      parse_braced_rules stream left_brace (fun stream ->
        parse_rule_list stream
          ~stop:(fun stream -> current_is stream Tokens.RIGHT_BRACE)
          ~parse_one:parse_block_rule ~allow_empty:true)
    in
    {
      name = name, component_loc at_token;
      prelude = prelude, prelude_loc;
      block = Stylesheet rules;
      loc = loc_from_start stream start_pos;
    }
  | _ -> raise_parse_error (current_token stream)

and parse_style_rule stream =
  skip_whitespace stream;
  let start_pos = (current_token stream).start_pos in
  let prelude = parse_selector_list stream in
  skip_whitespace stream;
  let left_brace = expect_token stream Tokens.LEFT_BRACE in
  let block =
    parse_braced_rules stream left_brace (fun stream ->
      let rules, rules_loc =
        parse_rule_list stream
          ~stop:(fun stream -> current_is stream Tokens.RIGHT_BRACE)
          ~parse_one:parse_block_rule ~allow_empty:false
      in
      rules, rules_loc)
  in
  { prelude; block; loc = loc_from_start stream start_pos }

and parse_block_rule stream =
  skip_whitespace stream;
  match current_tok stream with
  | Tokens.AT_KEYFRAMES _ | Tokens.AT_RULE _ | Tokens.AT_RULE_STATEMENT _ ->
    At_rule (parse_at_rule stream)
  | Tokens.IDENT _
    when identifier_starts_property stream.tokens (stream.index + 1) ->
    let saved = snapshot stream in
    begin match parse_declaration_no_eof stream with
    | declaration -> Declaration declaration
    | exception (Parse_error _ as declaration_error) ->
      restore stream saved;
      (match attempt stream parse_style_rule with
      | Some style_rule -> Style_rule style_rule
      | None ->
        restore stream saved;
        raise declaration_error)
    end
  | _ -> Style_rule (parse_style_rule stream)

and parse_stylesheet_rule stream =
  skip_whitespace stream;
  match current_tok stream with
  | Tokens.AT_KEYFRAMES _ | Tokens.AT_RULE _ | Tokens.AT_RULE_STATEMENT _ ->
    At_rule (parse_at_rule stream)
  | _ -> Style_rule (parse_style_rule stream)

let make_stream input =
  let tokens =
    Lex.from_string input
    |> List.map (fun ({ txt; start_pos; end_pos } : raw_token_with_location) ->
      match txt with
      | Ok token -> { txt = token; start_pos; end_pos }
      | Error err ->
        raise (Lexer.LexingError (start_pos, end_pos, Tokens.show_error err)))
  in
  { tokens = Array.of_list tokens; index = 0; last_end_pos = Lexing.dummy_pos }

let parse_declaration_list input =
  let stream = make_stream input in
  let rules, loc =
    parse_rule_list stream
      ~stop:(fun stream -> current_is stream Tokens.EOF)
      ~parse_one:parse_block_rule ~allow_empty:true
  in
  let _ = expect_token stream Tokens.EOF in
  rules, loc

let parse_declaration input =
  let stream = make_stream input in
  let declaration = parse_declaration_no_eof stream in
  skip_whitespace stream;
  let _ = expect_token stream Tokens.EOF in
  declaration

let parse_stylesheet input =
  let stream = make_stream input in
  let rules, loc =
    parse_rule_list stream
      ~stop:(fun stream -> current_is stream Tokens.EOF)
      ~parse_one:parse_stylesheet_rule ~allow_empty:true
  in
  let _ = expect_token stream Tokens.EOF in
  rules, loc

let parse_keyframes input =
  let stream = make_stream input in
  let rules =
    if current_is stream Tokens.LEFT_BRACE then (
      let _ = advance stream in
      let rules = parse_keyframe_rule_list stream in
      let _ = expect_token stream Tokens.RIGHT_BRACE in
      let _ = accept_token stream Tokens.SEMI_COLON in
      rules)
    else parse_keyframe_rule_list stream
  in
  let _ = expect_token stream Tokens.EOF in
  rules
