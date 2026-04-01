open Ast
module Lex = Lexer

exception Parse_error of (Lexing.position * Lexing.position * string)

type token_with_location = Lexer.token_with_location

type stream = {
  tokens : Lexer.token_with_location array;
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
    Printf.sprintf "Parse error while reading token '%s'"
      (match token.txt with
      | Ok tok -> token_text tok
      | Error err -> Tokens.show_error err)
  in
  raise (Parse_error (token.start_pos, token.end_pos, message))

let current_token stream =
  let last_index = Array.length stream.tokens - 1 in
  let index = if stream.index > last_index then last_index else stream.index in
  stream.tokens.(index)

let current_tok stream =
  match (current_token stream).txt with
  | Ok tok -> tok
  | Error _ -> assert false

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
    ignore (advance stream)
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

let token_value (token : token_with_location) =
  match token.txt with Ok tok -> tok | Error _ -> assert false

let token_is_whitespace token =
  match token_value token with Tokens.WS -> true | _ -> false

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

let known_pseudo_ident = function
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

let known_pseudo_function = function
  | "current" | "dir" | "has" | "host" | "host-context" | "is" | "lang" | "not"
  | "nth-col" | "nth-last-col" | "part" | "slotted" | "state" | "where" ->
    true
  | _ -> false

let token_starts_selector_pseudo = function
  | Tokens.IDENT name -> known_pseudo_ident name
  | Tokens.FUNCTION name -> known_pseudo_function name
  | Tokens.NTH_FUNCTION _ | Tokens.COLON | Tokens.DOUBLE_COLON -> true
  | _ -> false

let nested_block_follows tokens start_index ~initial_paren_depth
  ~initial_bracket_depth =
  let index = ref start_index in
  let read () =
    let token : token_with_location = token_at !index tokens in
    incr index;
    token
  in
  let rec scan ~paren_depth ~bracket_depth =
    match (read ()).txt with
    | Ok Tokens.WS | Ok (Tokens.IDENT _) -> scan ~paren_depth ~bracket_depth
    | Ok token ->
      (match token with
      | Tokens.FUNCTION _ | Tokens.NTH_FUNCTION _ | Tokens.LEFT_PAREN ->
        scan ~paren_depth:(paren_depth + 1) ~bracket_depth
      | Tokens.RIGHT_PAREN ->
        let next_paren_depth = if paren_depth > 0 then paren_depth - 1 else 0 in
        scan ~paren_depth:next_paren_depth ~bracket_depth
      | Tokens.LEFT_BRACKET ->
        scan ~paren_depth ~bracket_depth:(bracket_depth + 1)
      | Tokens.RIGHT_BRACKET ->
        let next_bracket_depth =
          if bracket_depth > 0 then bracket_depth - 1 else 0
        in
        scan ~paren_depth ~bracket_depth:next_bracket_depth
      | Tokens.LEFT_BRACE -> paren_depth = 0 && bracket_depth = 0
      | Tokens.SEMI_COLON | Tokens.RIGHT_BRACE | Tokens.EOF -> false
      | _ -> scan ~paren_depth ~bracket_depth)
    | Error _ -> false
  in
  scan ~paren_depth:initial_paren_depth ~bracket_depth:initial_bracket_depth

let selector_prelude_follows tokens start_index =
  let index = ref start_index in
  let read () =
    let token : token_with_location = token_at !index tokens in
    incr index;
    token
  in
  let rec scan ~paren_depth ~bracket_depth ~saw_selector_token =
    match (read ()).txt with
    | Ok Tokens.WS -> scan ~paren_depth ~bracket_depth ~saw_selector_token
    | Ok (Tokens.IDENT _) ->
      scan ~paren_depth ~bracket_depth ~saw_selector_token:true
    | Ok token ->
      if paren_depth > 0 || bracket_depth > 0 then (
        match token with
        | Tokens.FUNCTION _ | Tokens.NTH_FUNCTION _ | Tokens.LEFT_PAREN ->
          scan ~paren_depth:(paren_depth + 1) ~bracket_depth ~saw_selector_token
        | Tokens.RIGHT_PAREN ->
          let next_paren_depth =
            if paren_depth > 0 then paren_depth - 1 else 0
          in
          scan ~paren_depth:next_paren_depth ~bracket_depth ~saw_selector_token
        | Tokens.LEFT_BRACKET ->
          scan ~paren_depth ~bracket_depth:(bracket_depth + 1)
            ~saw_selector_token
        | Tokens.RIGHT_BRACKET ->
          let next_bracket_depth =
            if bracket_depth > 0 then bracket_depth - 1 else 0
          in
          scan ~paren_depth ~bracket_depth:next_bracket_depth
            ~saw_selector_token
        | Tokens.LEFT_BRACE | Tokens.RIGHT_BRACE | Tokens.SEMI_COLON
        | Tokens.EOF ->
          false
        | _ -> scan ~paren_depth ~bracket_depth ~saw_selector_token)
      else (
        match token with
        | Tokens.LEFT_BRACE -> saw_selector_token
        | (Tokens.FUNCTION _ | Tokens.NTH_FUNCTION _) when saw_selector_token ->
          scan ~paren_depth:(paren_depth + 1) ~bracket_depth
            ~saw_selector_token:true
        | Tokens.LEFT_BRACKET ->
          scan ~paren_depth ~bracket_depth:(bracket_depth + 1)
            ~saw_selector_token:true
        | tok when is_selector_start tok || is_pseudo_start tok ->
          scan ~paren_depth ~bracket_depth ~saw_selector_token:true
        | Tokens.DELIM s when is_combinator_delim s ->
          scan ~paren_depth ~bracket_depth ~saw_selector_token:true
        | Tokens.COMMA ->
          scan ~paren_depth ~bracket_depth ~saw_selector_token:true
        | Tokens.SEMI_COLON | Tokens.RIGHT_BRACE | Tokens.EOF -> false
        | _ -> false)
    | Error _ -> false
  in
  scan ~paren_depth:0 ~bracket_depth:0 ~saw_selector_token:false

let declaration_value_starts_nested_block tokens start_index state =
  if not state.has_content then false
  else (
    let next_index = next_significant_index tokens start_index in
    let next_token = token_at next_index tokens in
    match next_token.txt with
    | Ok (Tokens.INTERPOLATION _) -> false
    | Ok tok when is_at_rule_start tok ->
      nested_block_follows tokens next_index ~initial_paren_depth:0
        ~initial_bracket_depth:0
    | Ok tok
      when token_starts_selector_prelude tok
           &&
           match tok with
           | Tokens.IDENT _ ->
             state.top_level_items = 1 && state.ident_like_prefix
           | _ -> true ->
      selector_prelude_follows tokens next_index
    | _ -> false)

let identifier_starts_property tokens start_index =
  let index = ref start_index in
  let read () =
    let token : token_with_location = token_at !index tokens in
    incr index;
    token
  in
  let rec read_next_significant () =
    match (read ()).txt with
    | Ok Tokens.WS -> read_next_significant ()
    | _ as value -> value
  in
  let rec scan_possible_nested_block ~paren_depth ~bracket_depth
    ~fallback_top_level_items ~fallback_ident_like_prefix
    ~fallback_selector_pseudo_prefix =
    match (read ()).txt with
    | Ok Tokens.WS ->
      scan_possible_nested_block ~paren_depth ~bracket_depth
        ~fallback_top_level_items ~fallback_ident_like_prefix
        ~fallback_selector_pseudo_prefix
    | Ok (Tokens.IDENT _) ->
      scan_possible_nested_block ~paren_depth ~bracket_depth
        ~fallback_top_level_items ~fallback_ident_like_prefix
        ~fallback_selector_pseudo_prefix
    | Ok token ->
      if paren_depth > 0 || bracket_depth > 0 then (
        match token with
        | Tokens.FUNCTION _ | Tokens.NTH_FUNCTION _ | Tokens.LEFT_PAREN ->
          scan_possible_nested_block ~paren_depth:(paren_depth + 1)
            ~bracket_depth ~fallback_top_level_items ~fallback_ident_like_prefix
            ~fallback_selector_pseudo_prefix
        | Tokens.RIGHT_PAREN ->
          let next_paren_depth =
            if paren_depth > 0 then paren_depth - 1 else 0
          in
          scan_possible_nested_block ~paren_depth:next_paren_depth
            ~bracket_depth ~fallback_top_level_items ~fallback_ident_like_prefix
            ~fallback_selector_pseudo_prefix
        | Tokens.LEFT_BRACKET ->
          scan_possible_nested_block ~paren_depth
            ~bracket_depth:(bracket_depth + 1) ~fallback_top_level_items
            ~fallback_ident_like_prefix ~fallback_selector_pseudo_prefix
        | Tokens.RIGHT_BRACKET ->
          let next_bracket_depth =
            if bracket_depth > 0 then bracket_depth - 1 else 0
          in
          scan_possible_nested_block ~paren_depth
            ~bracket_depth:next_bracket_depth ~fallback_top_level_items
            ~fallback_ident_like_prefix ~fallback_selector_pseudo_prefix
        | Tokens.LEFT_BRACE | Tokens.RIGHT_BRACE | Tokens.SEMI_COLON
        | Tokens.EOF ->
          true
        | _ ->
          scan_possible_nested_block ~paren_depth ~bracket_depth
            ~fallback_top_level_items ~fallback_ident_like_prefix
            ~fallback_selector_pseudo_prefix)
      else (
        match token with
        | Tokens.LEFT_BRACE -> true
        | Tokens.FUNCTION _ | Tokens.NTH_FUNCTION _ ->
          scan_possible_nested_block ~paren_depth:(paren_depth + 1)
            ~bracket_depth ~fallback_top_level_items ~fallback_ident_like_prefix
            ~fallback_selector_pseudo_prefix
        | Tokens.LEFT_BRACKET ->
          scan_possible_nested_block ~paren_depth
            ~bracket_depth:(bracket_depth + 1) ~fallback_top_level_items
            ~fallback_ident_like_prefix ~fallback_selector_pseudo_prefix
        | tok when is_selector_start tok || is_pseudo_start tok ->
          scan_possible_nested_block ~paren_depth ~bracket_depth
            ~fallback_top_level_items ~fallback_ident_like_prefix
            ~fallback_selector_pseudo_prefix
        | Tokens.DELIM s when is_combinator_delim s ->
          scan_possible_nested_block ~paren_depth ~bracket_depth
            ~fallback_top_level_items ~fallback_ident_like_prefix
            ~fallback_selector_pseudo_prefix
        | Tokens.COMMA ->
          scan_possible_nested_block ~paren_depth ~bracket_depth
            ~fallback_top_level_items ~fallback_ident_like_prefix
            ~fallback_selector_pseudo_prefix
        | Tokens.SEMI_COLON | Tokens.RIGHT_BRACE | Tokens.EOF -> true
        | _ ->
          scan_property_value ~paren_depth ~bracket_depth ~has_value:true
            ~top_level_items:fallback_top_level_items
            ~ident_like_prefix:fallback_ident_like_prefix
            ~selector_pseudo_prefix:fallback_selector_pseudo_prefix)
    | Error _ -> true
  and scan_property_value ~paren_depth ~bracket_depth ~has_value
    ~top_level_items ~ident_like_prefix ~selector_pseudo_prefix =
    let at_top_level = paren_depth = 0 && bracket_depth = 0 in
    let remember_top_level_item ~is_ident_like =
      if at_top_level then (
        let next_top_level_items = top_level_items + 1 in
        let next_ident_like_prefix =
          if next_top_level_items = 1 then is_ident_like else ident_like_prefix
        in
        next_top_level_items, next_ident_like_prefix)
      else top_level_items, ident_like_prefix
    in
    match (read ()).txt with
    | Ok Tokens.WS ->
      scan_property_value ~paren_depth ~bracket_depth ~has_value
        ~top_level_items ~ident_like_prefix ~selector_pseudo_prefix
    | Ok (Tokens.IDENT name) ->
      let next_selector_pseudo_prefix =
        ((not has_value) && at_top_level && known_pseudo_ident name)
        || selector_pseudo_prefix
      in
      if
        has_value
        && at_top_level
        && (not next_selector_pseudo_prefix)
        && top_level_items = 1
        && ident_like_prefix
      then
        scan_possible_nested_block ~paren_depth:0 ~bracket_depth:0
          ~fallback_top_level_items:(top_level_items + 1)
          ~fallback_ident_like_prefix:ident_like_prefix
          ~fallback_selector_pseudo_prefix:next_selector_pseudo_prefix
      else (
        let next_top_level_items, next_ident_like_prefix =
          remember_top_level_item ~is_ident_like:true
        in
        scan_property_value ~paren_depth ~bracket_depth ~has_value:true
          ~top_level_items:next_top_level_items
          ~ident_like_prefix:next_ident_like_prefix
          ~selector_pseudo_prefix:next_selector_pseudo_prefix)
    | Ok token ->
      let next_selector_pseudo_prefix =
        ((not has_value) && at_top_level && token_starts_selector_pseudo token)
        || selector_pseudo_prefix
      in
      begin match token with
      | Tokens.FUNCTION _ | Tokens.NTH_FUNCTION _ ->
        let next_top_level_items, next_ident_like_prefix =
          remember_top_level_item ~is_ident_like:false
        in
        scan_property_value ~paren_depth:(paren_depth + 1) ~bracket_depth
          ~has_value:true ~top_level_items:next_top_level_items
          ~ident_like_prefix:next_ident_like_prefix
          ~selector_pseudo_prefix:next_selector_pseudo_prefix
      | token
        when has_value
             && at_top_level
             && (not selector_pseudo_prefix)
             && token_starts_selector_prelude token ->
        scan_possible_nested_block ~paren_depth:0 ~bracket_depth:0
          ~fallback_top_level_items:top_level_items
          ~fallback_ident_like_prefix:ident_like_prefix
          ~fallback_selector_pseudo_prefix:selector_pseudo_prefix
      | Tokens.NUMBER _ | Tokens.PERCENTAGE _ | Tokens.DIMENSION _
      | Tokens.HASH _ | Tokens.STRING _ | Tokens.URL _ | Tokens.INTERPOLATION _
        ->
        let next_top_level_items, next_ident_like_prefix =
          remember_top_level_item ~is_ident_like:false
        in
        scan_property_value ~paren_depth ~bracket_depth ~has_value:true
          ~top_level_items:next_top_level_items
          ~ident_like_prefix:next_ident_like_prefix
          ~selector_pseudo_prefix:next_selector_pseudo_prefix
      | Tokens.LEFT_PAREN ->
        scan_property_value ~paren_depth:(paren_depth + 1) ~bracket_depth
          ~has_value:true ~top_level_items ~ident_like_prefix
          ~selector_pseudo_prefix:next_selector_pseudo_prefix
      | Tokens.RIGHT_PAREN ->
        let next_paren_depth = if paren_depth > 0 then paren_depth - 1 else 0 in
        scan_property_value ~paren_depth:next_paren_depth ~bracket_depth
          ~has_value:true ~top_level_items ~ident_like_prefix
          ~selector_pseudo_prefix:next_selector_pseudo_prefix
      | Tokens.LEFT_BRACKET ->
        scan_property_value ~paren_depth ~bracket_depth:(bracket_depth + 1)
          ~has_value:true ~top_level_items ~ident_like_prefix
          ~selector_pseudo_prefix:next_selector_pseudo_prefix
      | Tokens.RIGHT_BRACKET ->
        let next_bracket_depth =
          if bracket_depth > 0 then bracket_depth - 1 else 0
        in
        scan_property_value ~paren_depth ~bracket_depth:next_bracket_depth
          ~has_value:true ~top_level_items ~ident_like_prefix
          ~selector_pseudo_prefix:next_selector_pseudo_prefix
      | (Tokens.COLON | Tokens.DOUBLE_COLON) when has_value && at_top_level ->
        false
      | token when has_value && at_top_level && is_at_rule_start token ->
        if
          nested_block_follows tokens (!index - 1) ~initial_paren_depth:0
            ~initial_bracket_depth:0
        then true
        else
          scan_property_value ~paren_depth ~bracket_depth ~has_value:true
            ~top_level_items ~ident_like_prefix ~selector_pseudo_prefix
      | Tokens.LEFT_BRACE ->
        if at_top_level then false
        else
          scan_property_value ~paren_depth ~bracket_depth ~has_value:true
            ~top_level_items ~ident_like_prefix
            ~selector_pseudo_prefix:next_selector_pseudo_prefix
      | Tokens.SEMI_COLON | Tokens.RIGHT_BRACE | Tokens.EOF ->
        if at_top_level then true
        else
          scan_property_value ~paren_depth ~bracket_depth ~has_value:true
            ~top_level_items ~ident_like_prefix
            ~selector_pseudo_prefix:next_selector_pseudo_prefix
      | _ ->
        scan_property_value ~paren_depth ~bracket_depth ~has_value:true
          ~top_level_items ~ident_like_prefix
          ~selector_pseudo_prefix:next_selector_pseudo_prefix
      end
    | Error _ -> true
  in
  match read_next_significant () with
  | Ok Tokens.COLON ->
    scan_property_value ~paren_depth:0 ~bracket_depth:0 ~has_value:false
      ~top_level_items:0 ~ident_like_prefix:false ~selector_pseudo_prefix:false
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
    ignore (advance stream);
    ignore (expect_token stream (Tokens.DELIM "="));
    Attr_member
  | Tokens.DELIM "|" ->
    ignore (advance stream);
    ignore (expect_token stream (Tokens.DELIM "="));
    Attr_prefix_dash
  | Tokens.DELIM "^" ->
    ignore (advance stream);
    ignore (expect_token stream (Tokens.DELIM "="));
    Attr_prefix
  | Tokens.DELIM "$" ->
    ignore (advance stream);
    ignore (expect_token stream (Tokens.DELIM "="));
    Attr_suffix
  | Tokens.DELIM "*" ->
    ignore (advance stream);
    ignore (expect_token stream (Tokens.DELIM "="));
    Attr_substring
  | Tokens.DELIM "=" ->
    ignore (advance stream);
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
      ignore (advance stream);
      Ast.Nth (A (int_of_float a))
    | Tokens.DIMENSION (num, unit) ->
      ignore (advance stream);
      skip_whitespace stream;
      begin match current_tok stream with
      | Tokens.DELIM (("+" | "-") as op) ->
        ignore (advance stream);
        skip_whitespace stream;
        let b =
          match current_tok stream with
          | Tokens.NUMBER value ->
            ignore (advance stream);
            int_of_float value
          | _ -> raise_parse_error (current_token stream)
        in
        Ast.Nth (ANB (int_of_float num, string_of_nth_operator op, b))
      | Tokens.NUMBER value ->
        ignore (advance stream);
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
      ignore (advance stream);
      skip_whitespace stream;
      begin match current_tok stream with
      | Tokens.DELIM (("+" | "-") as op) ->
        ignore (advance stream);
        skip_whitespace stream;
        let b =
          match current_tok stream with
          | Tokens.NUMBER value ->
            ignore (advance stream);
            int_of_float value
          | _ -> raise_parse_error (current_token stream)
        in
        let first_char = name.[0] in
        let a = if first_char = '-' then -1 else 1 in
        Ast.Nth (ANB (a, string_of_nth_operator op, b))
      | Tokens.NUMBER value ->
        ignore (advance stream);
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
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos (Ast.Ident name)
  | Tokens.LEFT_PAREN ->
    ignore (advance stream);
    let values, _ =
      parse_component_value_list_until stream (fun stream ->
        current_is stream Tokens.RIGHT_PAREN)
    in
    ignore (expect_token stream Tokens.RIGHT_PAREN);
    with_loc start_pos stream.last_end_pos (Ast.Paren_block values)
  | Tokens.LEFT_BRACKET ->
    ignore (advance stream);
    let values, _ =
      parse_component_value_list_until stream (fun stream ->
        current_is stream Tokens.RIGHT_BRACKET)
    in
    ignore (expect_token stream Tokens.RIGHT_BRACKET);
    with_loc start_pos stream.last_end_pos (Ast.Bracket_block values)
  | Tokens.PERCENTAGE value ->
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos
      (Ast.Percentage value : Ast.component_value)
  | Tokens.STRING value ->
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos (Ast.String value)
  | Tokens.URL value ->
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos (Ast.Uri value)
  | Tokens.HASH (value, kind) ->
    ignore (advance stream);
    let kind =
      match kind with
      | `ID -> Ast.Hash_kind_id
      | `UNRESTRICTED -> Ast.Hash_kind_unrestricted
    in
    with_loc start_pos stream.last_end_pos (Ast.Hash (value, kind))
  | Tokens.NUMBER value ->
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos (Ast.Number value)
  | Tokens.UNICODE_RANGE value ->
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos (Ast.Unicode_range value)
  | Tokens.DIMENSION (value, unit) ->
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos
      (Ast.Dimension (Ast.dimension_make (value, unit)))
  | Tokens.INTERPOLATION (content, loc) ->
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos
      (Ast.Variable (content, loc) : Ast.component_value)
  | Tokens.FUNCTION name ->
    let token = advance stream in
    let body, body_loc =
      parse_component_value_list_until stream (fun stream ->
        current_is stream Tokens.RIGHT_PAREN)
    in
    ignore (expect_token stream Tokens.RIGHT_PAREN);
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
    ignore (expect_token stream Tokens.RIGHT_PAREN);
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
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos (Ast.Delim Ast.Delimiter_colon)
  | Tokens.DOUBLE_COLON ->
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos
      (Ast.Delim Ast.Delimiter_double_colon)
  | Tokens.COMMA ->
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos (Ast.Delim Ast.Delimiter_comma)
  | Tokens.DELIM s -> begin
    match Ast.delimiter_of_string s with
    | Some delim ->
      ignore (advance stream);
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
    ignore (advance stream);
    Ampersand
  | Tokens.DELIM "*" ->
    ignore (advance stream);
    Universal
  | Tokens.INTERPOLATION (content, loc) ->
    ignore (advance stream);
    Variable (content, loc)
  | Tokens.IDENT name ->
    ignore (advance stream);
    Type name
  | _ -> raise_parse_error (current_token stream)

let rec parse_attribute_selector stream =
  ignore (expect_token stream Tokens.LEFT_BRACKET);
  skip_whitespace stream;
  let name = parse_wq_name stream in
  skip_whitespace stream;
  if current_is stream Tokens.RIGHT_BRACKET then (
    ignore (advance stream);
    Attr_value name)
  else (
    let kind = parse_attr_matcher stream in
    skip_whitespace stream;
    let value =
      match current_tok stream with
      | Tokens.STRING value ->
        ignore (advance stream);
        Attr_string value
      | Tokens.IDENT value ->
        ignore (advance stream);
        Attr_ident value
      | _ -> raise_parse_error (current_token stream)
    in
    skip_whitespace stream;
    ignore (expect_token stream Tokens.RIGHT_BRACKET);
    To_equal { name; kind; value })

and parse_pseudo_class_selector stream =
  ignore (expect_token stream Tokens.COLON);
  match current_tok stream with
  | Tokens.IDENT name ->
    ignore (advance stream);
    Pseudoclass (PseudoIdent name)
  | Tokens.FUNCTION name ->
    let start_pos = (current_token stream).start_pos in
    ignore (advance stream);
    let selectors, payload_loc = parse_relative_selector_list stream in
    ignore (expect_token stream Tokens.RIGHT_PAREN);
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
    ignore (advance stream);
    let payload = parse_nth_payload stream in
    let payload_loc = make_loc start_pos stream.last_end_pos in
    ignore (expect_token stream Tokens.RIGHT_PAREN);
    Pseudoclass
      (Ast.NthFunction { name; payload = payload, payload_loc }
        : Ast.pseudoclass_kind)
  | _ -> raise_parse_error (current_token stream)

and parse_pseudo_element_selector stream =
  ignore (expect_token stream Tokens.DOUBLE_COLON);
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
    ignore (advance stream);
    Id value
  | Tokens.DELIM "." ->
    ignore (advance stream);
    begin match current_tok stream with
    | Tokens.IDENT value ->
      ignore (advance stream);
      Class value
    | Tokens.INTERPOLATION (content, loc) ->
      ignore (advance stream);
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
      ignore (advance stream)
    done;
    match current_tok stream with
    | Tokens.DELIM (("+" | "~" | ">") as s) ->
      ignore (advance stream);
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

and parse_selector_list stream =
  skip_whitespace stream;
  let start_pos = (current_token stream).start_pos in
  let rec parse_one acc =
    let selector_start = (current_token stream).start_pos in
    let selector = parse_selector stream in
    let selector_loc = make_loc selector_start stream.last_end_pos in
    skip_whitespace stream;
    let acc = (selector, selector_loc) :: acc in
    match current_tok stream with
    | Tokens.COMMA ->
      ignore (advance stream);
      skip_whitespace stream;
      parse_one acc
    | _ ->
      let selectors = List.rev acc in
      let loc =
        if selectors = [] then make_loc start_pos start_pos
        else make_loc start_pos stream.last_end_pos
      in
      selectors, loc
  in
  parse_one []

and parse_relative_selector stream =
  skip_whitespace stream;
  let combinator =
    match current_tok stream with
    | Tokens.DELIM (("+" | "~" | ">") as s) ->
      ignore (advance stream);
      skip_whitespace stream;
      Some (selector_combinator_of_delim s)
    | _ -> None
  in
  let complex_selector = parse_complex_selector stream in
  RelativeSelector { combinator; complex_selector }

and parse_relative_selector_list stream =
  skip_whitespace stream;
  let start_pos = (current_token stream).start_pos in
  let rec parse_one acc =
    let selector_start = (current_token stream).start_pos in
    let selector = parse_relative_selector stream in
    let selector_loc = make_loc selector_start stream.last_end_pos in
    skip_whitespace stream;
    let acc = (selector, selector_loc) :: acc in
    match current_tok stream with
    | Tokens.COMMA ->
      ignore (advance stream);
      skip_whitespace stream;
      parse_one acc
    | _ ->
      let selectors = List.rev acc in
      let loc =
        if selectors = [] then make_loc start_pos start_pos
        else make_loc start_pos stream.last_end_pos
      in
      selectors, loc
  in
  parse_one []

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

let parse_prelude_value_list_until stream stop =
  let start_pos = (current_token stream).start_pos in
  let rec loop acc =
    if stop stream then
      with_empty_or_consumed_loc stream start_pos (List.rev acc)
    else (
      let value = parse_component_value stream in
      loop (value :: acc))
  in
  loop []

let parse_declaration_no_eof stream =
  skip_whitespace stream;
  let start_pos = (current_token stream).start_pos in
  let name, name_token = expect_ident stream in
  let name_loc = component_loc name_token in
  skip_whitespace stream;
  ignore (expect_token stream Tokens.COLON);
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
  ignore (accept_token stream Tokens.SEMI_COLON);
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
  ignore (accept_token stream Tokens.SEMI_COLON);
  [], make_loc left_brace.start_pos right_brace.end_pos

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
          ignore (advance stream);
          skip_whitespace stream;
          let acc =
            (SimpleSelector (Percentage percent), component_loc token) :: acc
          in
          begin match current_tok stream with
          | Tokens.COMMA ->
            ignore (advance stream);
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
    skip_whitespace stream;
    if current_is stream Tokens.RIGHT_BRACE then
      parse_empty_rule_block stream left_brace
    else (
      let rules, rules_loc =
        parse_rule_list stream
          ~stop:(fun stream -> current_is stream Tokens.RIGHT_BRACE)
          ~parse_one:parse_block_rule ~allow_empty:false
      in
      ignore (expect_token stream Tokens.RIGHT_BRACE);
      ignore (accept_token stream Tokens.SEMI_COLON);
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
    skip_whitespace stream;
    let block =
      if current_is stream Tokens.RIGHT_BRACE then (
        let empty_block = parse_empty_rule_block stream left_brace in
        Rule_list empty_block)
      else (
        let rules = parse_keyframe_rule_list stream in
        ignore (expect_token stream Tokens.RIGHT_BRACE);
        ignore (accept_token stream Tokens.SEMI_COLON);
        Rule_list rules)
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
      parse_prelude_value_list_until stream (fun stream ->
        current_is stream Tokens.SEMI_COLON)
    in
    ignore (expect_token stream Tokens.SEMI_COLON);
    {
      name = name, component_loc at_token;
      prelude = prelude, prelude_loc;
      block = Empty;
      loc = loc_from_start stream start_pos;
    }
  | Tokens.AT_RULE name ->
    let at_token = advance stream in
    let prelude, prelude_loc =
      parse_prelude_value_list_until stream (fun stream ->
        current_is stream Tokens.LEFT_BRACE)
    in
    ignore (expect_token stream Tokens.LEFT_BRACE);
    let rules =
      parse_rule_list stream
        ~stop:(fun stream -> current_is stream Tokens.RIGHT_BRACE)
        ~parse_one:parse_block_rule ~allow_empty:true
    in
    ignore (expect_token stream Tokens.RIGHT_BRACE);
    ignore (accept_token stream Tokens.SEMI_COLON);
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
    skip_whitespace stream;
    if current_is stream Tokens.RIGHT_BRACE then
      parse_empty_rule_block stream left_brace
    else (
      let rules, rules_loc =
        parse_rule_list stream
          ~stop:(fun stream -> current_is stream Tokens.RIGHT_BRACE)
          ~parse_one:parse_block_rule ~allow_empty:false
      in
      ignore (expect_token stream Tokens.RIGHT_BRACE);
      ignore (accept_token stream Tokens.SEMI_COLON);
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
    Declaration (parse_declaration_no_eof stream)
  | _ -> Style_rule (parse_style_rule stream)

and parse_stylesheet_rule stream =
  skip_whitespace stream;
  match current_tok stream with
  | Tokens.AT_KEYFRAMES _ | Tokens.AT_RULE _ | Tokens.AT_RULE_STATEMENT _ ->
    At_rule (parse_at_rule stream)
  | _ -> Style_rule (parse_style_rule stream)

let make_stream input =
  let tokens = Lex.from_string input in
  List.iter
    (fun ({ txt; start_pos; end_pos } : token_with_location) ->
      match txt with
      | Ok _ -> ()
      | Error err ->
        raise (Lexer.LexingError (start_pos, end_pos, Tokens.show_error err)))
    tokens;
  { tokens = Array.of_list tokens; index = 0; last_end_pos = Lexing.dummy_pos }

let parse_declaration_list input =
  let stream = make_stream input in
  let rules, loc =
    parse_rule_list stream
      ~stop:(fun stream -> current_is stream Tokens.EOF)
      ~parse_one:parse_block_rule ~allow_empty:true
  in
  ignore (expect_token stream Tokens.EOF);
  rules, loc

let parse_declaration input =
  let stream = make_stream input in
  let declaration = parse_declaration_no_eof stream in
  skip_whitespace stream;
  ignore (expect_token stream Tokens.EOF);
  declaration

let parse_stylesheet input =
  let stream = make_stream input in
  let rules, loc =
    parse_rule_list stream
      ~stop:(fun stream -> current_is stream Tokens.EOF)
      ~parse_one:parse_stylesheet_rule ~allow_empty:true
  in
  ignore (expect_token stream Tokens.EOF);
  rules, loc

let parse_keyframes input =
  let stream = make_stream input in
  let rules =
    if current_is stream Tokens.LEFT_BRACE then (
      ignore (advance stream);
      let rules = parse_keyframe_rule_list stream in
      ignore (expect_token stream Tokens.RIGHT_BRACE);
      ignore (accept_token stream Tokens.SEMI_COLON);
      rules)
    else parse_keyframe_rule_list stream
  in
  ignore (expect_token stream Tokens.EOF);
  rules
