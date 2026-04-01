open Ast
module Lex = Lexer
module Raw = Lexer
module Tok = Tokens

exception Parse_error of (Lexing.position * Lexing.position * string)

type raw_token = Raw.raw_token
type raw_token_with_location = Raw.raw_token_with_location

type stream = {
  tokens : raw_token_with_location array;
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

let component_loc (token : raw_token_with_location) =
  make_loc token.start_pos token.end_pos

let raw_text = function
  | Raw.Raw_whitespace -> " "
  | Raw.Raw_ident name -> name
  | Raw.Raw_token token -> Tok.humanize token

let raise_parse_error (token : raw_token_with_location) =
  let message =
    Printf.sprintf "Parse error while reading token '%s'"
      (match token.txt with
      | Ok raw -> raw_text raw
      | Error err -> Tok.show_error err)
  in
  raise (Parse_error (token.start_pos, token.end_pos, message))

let current_token stream =
  let last_index = Array.length stream.tokens - 1 in
  let index = if stream.index > last_index then last_index else stream.index in
  stream.tokens.(index)

let current_raw stream =
  match (current_token stream).txt with
  | Ok raw -> raw
  | Error _ -> assert false

let advance stream =
  let token = current_token stream in
  if stream.index < Array.length stream.tokens then
    stream.index <- stream.index + 1;
  stream.last_end_pos <- token.end_pos;
  token

let token_is token expected =
  match token with
  | Raw.Raw_token actual when actual = expected -> true
  | _ -> false

let current_is stream expected = token_is (current_raw stream) expected

let current_is_whitespace stream =
  match current_raw stream with Raw.Raw_whitespace -> true | _ -> false

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
  match current_raw stream with
  | Raw.Raw_ident name ->
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

let raw_at index tokens =
  if index < Array.length tokens then tokens.(index)
  else tokens.(Array.length tokens - 1)

let raw_value (token : raw_token_with_location) =
  match token.txt with Ok raw -> raw | Error _ -> assert false

let raw_is_whitespace token =
  match raw_value token with Raw.Raw_whitespace -> true | _ -> false

let next_significant_index tokens start =
  let rec loop index =
    if index >= Array.length tokens then index
    else if raw_is_whitespace tokens.(index) then loop (index + 1)
    else index
  in
  loop start

let token_starts_selector = function
  | Raw.Raw_ident _ -> true
  | Raw.Raw_token
      ( Tok.DOT | Tok.HASH _ | Tok.AMPERSAND | Tok.ASTERISK | Tok.COLON
      | Tok.DOUBLE_COLON | Tok.LEFT_BRACKET | Tok.INTERPOLATION _ ) ->
    true
  | Raw.Raw_token _ | Raw.Raw_whitespace -> false

let token_starts_nested_block = function
  | Raw.Raw_token (Tok.AT_RULE _ | Tok.AT_KEYFRAMES _) -> true
  | Raw.Raw_ident _ | Raw.Raw_token _ | Raw.Raw_whitespace -> false

let token_starts_selector_prelude = function
  | Raw.Raw_ident _ -> true
  | Raw.Raw_token
      ( Tok.AMPERSAND | Tok.DOT | Tok.HASH _ | Tok.ASTERISK | Tok.LEFT_BRACKET
      | Tok.INTERPOLATION _ ) ->
    true
  | Raw.Raw_token _ | Raw.Raw_whitespace -> false

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
  | Raw.Raw_ident name -> known_pseudo_ident name
  | Raw.Raw_token (Tok.FUNCTION name) -> known_pseudo_function name
  | Raw.Raw_token (Tok.NTH_FUNCTION _ | Tok.COLON | Tok.DOUBLE_COLON) -> true
  | Raw.Raw_token _ | Raw.Raw_whitespace -> false

let nested_block_follows tokens start_index ~initial_paren_depth
  ~initial_bracket_depth =
  let index = ref start_index in
  let read () =
    let token : raw_token_with_location = raw_at !index tokens in
    incr index;
    token
  in
  let rec scan ~paren_depth ~bracket_depth =
    match (read ()).txt with
    | Ok Raw.Raw_whitespace | Ok (Raw.Raw_ident _) ->
      scan ~paren_depth ~bracket_depth
    | Ok (Raw.Raw_token token) ->
      (match token with
      | Tok.FUNCTION _ | Tok.NTH_FUNCTION _ | Tok.LEFT_PAREN ->
        scan ~paren_depth:(paren_depth + 1) ~bracket_depth
      | Tok.RIGHT_PAREN ->
        let next_paren_depth = if paren_depth > 0 then paren_depth - 1 else 0 in
        scan ~paren_depth:next_paren_depth ~bracket_depth
      | Tok.LEFT_BRACKET -> scan ~paren_depth ~bracket_depth:(bracket_depth + 1)
      | Tok.RIGHT_BRACKET ->
        let next_bracket_depth =
          if bracket_depth > 0 then bracket_depth - 1 else 0
        in
        scan ~paren_depth ~bracket_depth:next_bracket_depth
      | Tok.LEFT_BRACE -> paren_depth = 0 && bracket_depth = 0
      | Tok.SEMI_COLON | Tok.RIGHT_BRACE | Tok.EOF -> false
      | _ -> scan ~paren_depth ~bracket_depth)
    | Error _ -> false
  in
  scan ~paren_depth:initial_paren_depth ~bracket_depth:initial_bracket_depth

let selector_prelude_follows tokens start_index =
  let index = ref start_index in
  let read () =
    let token : raw_token_with_location = raw_at !index tokens in
    incr index;
    token
  in
  let rec scan ~paren_depth ~bracket_depth ~saw_selector_token =
    match (read ()).txt with
    | Ok Raw.Raw_whitespace ->
      scan ~paren_depth ~bracket_depth ~saw_selector_token
    | Ok (Raw.Raw_ident _) ->
      scan ~paren_depth ~bracket_depth ~saw_selector_token:true
    | Ok (Raw.Raw_token token) ->
      if paren_depth > 0 || bracket_depth > 0 then (
        match token with
        | Tok.FUNCTION _ | Tok.NTH_FUNCTION _ | Tok.LEFT_PAREN ->
          scan ~paren_depth:(paren_depth + 1) ~bracket_depth ~saw_selector_token
        | Tok.RIGHT_PAREN ->
          let next_paren_depth =
            if paren_depth > 0 then paren_depth - 1 else 0
          in
          scan ~paren_depth:next_paren_depth ~bracket_depth ~saw_selector_token
        | Tok.LEFT_BRACKET ->
          scan ~paren_depth ~bracket_depth:(bracket_depth + 1)
            ~saw_selector_token
        | Tok.RIGHT_BRACKET ->
          let next_bracket_depth =
            if bracket_depth > 0 then bracket_depth - 1 else 0
          in
          scan ~paren_depth ~bracket_depth:next_bracket_depth
            ~saw_selector_token
        | Tok.LEFT_BRACE | Tok.RIGHT_BRACE | Tok.SEMI_COLON | Tok.EOF -> false
        | _ -> scan ~paren_depth ~bracket_depth ~saw_selector_token)
      else (
        match token with
        | Tok.LEFT_BRACE -> saw_selector_token
        | (Tok.FUNCTION _ | Tok.NTH_FUNCTION _) when saw_selector_token ->
          scan ~paren_depth:(paren_depth + 1) ~bracket_depth
            ~saw_selector_token:true
        | Tok.LEFT_BRACKET ->
          scan ~paren_depth ~bracket_depth:(bracket_depth + 1)
            ~saw_selector_token:true
        | Tok.DOT | Tok.HASH _ | Tok.AMPERSAND | Tok.ASTERISK | Tok.COLON
        | Tok.DOUBLE_COLON | Tok.INTERPOLATION _ | Tok.GREATER_THAN | Tok.PLUS
        | Tok.TILDE | Tok.COMMA ->
          scan ~paren_depth ~bracket_depth ~saw_selector_token:true
        | Tok.SEMI_COLON | Tok.RIGHT_BRACE | Tok.EOF -> false
        | _ -> false)
    | Error _ -> false
  in
  scan ~paren_depth:0 ~bracket_depth:0 ~saw_selector_token:false

let declaration_value_starts_nested_block tokens start_index state =
  if not state.has_content then false
  else (
    let next_index = next_significant_index tokens start_index in
    let next_token = raw_at next_index tokens in
    match next_token.txt with
    | Ok (Raw.Raw_token (Tok.INTERPOLATION _)) -> false
    | Ok raw when token_starts_nested_block raw ->
      nested_block_follows tokens next_index ~initial_paren_depth:0
        ~initial_bracket_depth:0
    | Ok raw
      when token_starts_selector_prelude raw
           &&
           match raw with
           | Raw.Raw_ident _ ->
             state.top_level_items = 1 && state.ident_like_prefix
           | _ -> true ->
      selector_prelude_follows tokens next_index
    | _ -> false)

let identifier_starts_property tokens start_index =
  let index = ref start_index in
  let read () =
    let token : raw_token_with_location = raw_at !index tokens in
    incr index;
    token
  in
  let rec read_next_significant () =
    match (read ()).txt with
    | Ok Raw.Raw_whitespace -> read_next_significant ()
    | _ as value -> value
  in
  let rec scan_possible_nested_block ~paren_depth ~bracket_depth
    ~fallback_top_level_items ~fallback_ident_like_prefix
    ~fallback_selector_pseudo_prefix =
    match (read ()).txt with
    | Ok Raw.Raw_whitespace ->
      scan_possible_nested_block ~paren_depth ~bracket_depth
        ~fallback_top_level_items ~fallback_ident_like_prefix
        ~fallback_selector_pseudo_prefix
    | Ok (Raw.Raw_ident _) ->
      scan_possible_nested_block ~paren_depth ~bracket_depth
        ~fallback_top_level_items ~fallback_ident_like_prefix
        ~fallback_selector_pseudo_prefix
    | Ok (Raw.Raw_token token) ->
      if paren_depth > 0 || bracket_depth > 0 then (
        match token with
        | Tok.FUNCTION _ | Tok.NTH_FUNCTION _ | Tok.LEFT_PAREN ->
          scan_possible_nested_block ~paren_depth:(paren_depth + 1)
            ~bracket_depth ~fallback_top_level_items ~fallback_ident_like_prefix
            ~fallback_selector_pseudo_prefix
        | Tok.RIGHT_PAREN ->
          let next_paren_depth =
            if paren_depth > 0 then paren_depth - 1 else 0
          in
          scan_possible_nested_block ~paren_depth:next_paren_depth
            ~bracket_depth ~fallback_top_level_items ~fallback_ident_like_prefix
            ~fallback_selector_pseudo_prefix
        | Tok.LEFT_BRACKET ->
          scan_possible_nested_block ~paren_depth
            ~bracket_depth:(bracket_depth + 1) ~fallback_top_level_items
            ~fallback_ident_like_prefix ~fallback_selector_pseudo_prefix
        | Tok.RIGHT_BRACKET ->
          let next_bracket_depth =
            if bracket_depth > 0 then bracket_depth - 1 else 0
          in
          scan_possible_nested_block ~paren_depth
            ~bracket_depth:next_bracket_depth ~fallback_top_level_items
            ~fallback_ident_like_prefix ~fallback_selector_pseudo_prefix
        | Tok.LEFT_BRACE | Tok.RIGHT_BRACE | Tok.SEMI_COLON | Tok.EOF -> true
        | _ ->
          scan_possible_nested_block ~paren_depth ~bracket_depth
            ~fallback_top_level_items ~fallback_ident_like_prefix
            ~fallback_selector_pseudo_prefix)
      else (
        match token with
        | Tok.LEFT_BRACE -> true
        | Tok.FUNCTION _ | Tok.NTH_FUNCTION _ ->
          scan_possible_nested_block ~paren_depth:(paren_depth + 1)
            ~bracket_depth ~fallback_top_level_items ~fallback_ident_like_prefix
            ~fallback_selector_pseudo_prefix
        | Tok.LEFT_BRACKET ->
          scan_possible_nested_block ~paren_depth
            ~bracket_depth:(bracket_depth + 1) ~fallback_top_level_items
            ~fallback_ident_like_prefix ~fallback_selector_pseudo_prefix
        | Tok.DOT | Tok.HASH _ | Tok.AMPERSAND | Tok.ASTERISK | Tok.COLON
        | Tok.DOUBLE_COLON | Tok.INTERPOLATION _ | Tok.GREATER_THAN | Tok.PLUS
        | Tok.TILDE | Tok.COMMA ->
          scan_possible_nested_block ~paren_depth ~bracket_depth
            ~fallback_top_level_items ~fallback_ident_like_prefix
            ~fallback_selector_pseudo_prefix
        | Tok.SEMI_COLON | Tok.RIGHT_BRACE | Tok.EOF -> true
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
    | Ok Raw.Raw_whitespace ->
      scan_property_value ~paren_depth ~bracket_depth ~has_value
        ~top_level_items ~ident_like_prefix ~selector_pseudo_prefix
    | Ok (Raw.Raw_ident name) ->
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
    | Ok (Raw.Raw_token token) ->
      let next_selector_pseudo_prefix =
        (not has_value)
        && at_top_level
        && token_starts_selector_pseudo (Raw.Raw_token token)
        || selector_pseudo_prefix
      in
      begin match token with
      | Tok.FUNCTION _ | Tok.NTH_FUNCTION _ ->
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
             && token_starts_selector_prelude (Raw.Raw_token token) ->
        scan_possible_nested_block ~paren_depth:0 ~bracket_depth:0
          ~fallback_top_level_items:top_level_items
          ~fallback_ident_like_prefix:ident_like_prefix
          ~fallback_selector_pseudo_prefix:selector_pseudo_prefix
      | Tok.NUMBER _ | Tok.PERCENTAGE _ | Tok.DIMENSION _ | Tok.HASH _
      | Tok.STRING _ | Tok.URL _ | Tok.INTERPOLATION _ ->
        let next_top_level_items, next_ident_like_prefix =
          remember_top_level_item ~is_ident_like:false
        in
        scan_property_value ~paren_depth ~bracket_depth ~has_value:true
          ~top_level_items:next_top_level_items
          ~ident_like_prefix:next_ident_like_prefix
          ~selector_pseudo_prefix:next_selector_pseudo_prefix
      | Tok.LEFT_PAREN ->
        scan_property_value ~paren_depth:(paren_depth + 1) ~bracket_depth
          ~has_value:true ~top_level_items ~ident_like_prefix
          ~selector_pseudo_prefix:next_selector_pseudo_prefix
      | Tok.RIGHT_PAREN ->
        let next_paren_depth = if paren_depth > 0 then paren_depth - 1 else 0 in
        scan_property_value ~paren_depth:next_paren_depth ~bracket_depth
          ~has_value:true ~top_level_items ~ident_like_prefix
          ~selector_pseudo_prefix:next_selector_pseudo_prefix
      | Tok.LEFT_BRACKET ->
        scan_property_value ~paren_depth ~bracket_depth:(bracket_depth + 1)
          ~has_value:true ~top_level_items ~ident_like_prefix
          ~selector_pseudo_prefix:next_selector_pseudo_prefix
      | Tok.RIGHT_BRACKET ->
        let next_bracket_depth =
          if bracket_depth > 0 then bracket_depth - 1 else 0
        in
        scan_property_value ~paren_depth ~bracket_depth:next_bracket_depth
          ~has_value:true ~top_level_items ~ident_like_prefix
          ~selector_pseudo_prefix:next_selector_pseudo_prefix
      | (Tok.COLON | Tok.DOUBLE_COLON) when has_value && at_top_level -> false
      | token
        when has_value
             && at_top_level
             && token_starts_nested_block (Raw.Raw_token token) ->
        if
          nested_block_follows tokens (!index - 1) ~initial_paren_depth:0
            ~initial_bracket_depth:0
        then true
        else
          scan_property_value ~paren_depth ~bracket_depth ~has_value:true
            ~top_level_items ~ident_like_prefix ~selector_pseudo_prefix
      | Tok.LEFT_BRACE ->
        if at_top_level then false
        else
          scan_property_value ~paren_depth ~bracket_depth ~has_value:true
            ~top_level_items ~ident_like_prefix
            ~selector_pseudo_prefix:next_selector_pseudo_prefix
      | Tok.SEMI_COLON | Tok.RIGHT_BRACE | Tok.EOF ->
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
  | Ok (Raw.Raw_token Tok.COLON) ->
    scan_property_value ~paren_depth:0 ~bracket_depth:0 ~has_value:false
      ~top_level_items:0 ~ident_like_prefix:false ~selector_pseudo_prefix:false
  | _ -> false

let string_of_nth_operator_token = function
  | Tok.PLUS -> "+"
  | Tok.MINUS -> "-"
  | _ -> assert false

let selector_combinator_of_token = function
  | Tok.PLUS -> Ast.Selector_adjacent_sibling
  | Tok.TILDE -> Ast.Selector_general_sibling
  | Tok.GREATER_THAN -> Ast.Selector_child
  | _ -> assert false

let parse_attr_matcher stream =
  match current_raw stream with
  | Raw.Raw_token Tok.TILDE ->
    ignore (advance stream);
    ignore (expect_token stream Tok.EQUALS);
    Attr_member
  | Raw.Raw_token Tok.PIPE ->
    ignore (advance stream);
    ignore (expect_token stream Tok.EQUALS);
    Attr_prefix_dash
  | Raw.Raw_token Tok.CARET ->
    ignore (advance stream);
    ignore (expect_token stream Tok.EQUALS);
    Attr_prefix
  | Raw.Raw_token Tok.DOLLAR_SIGN ->
    ignore (advance stream);
    ignore (expect_token stream Tok.EQUALS);
    Attr_suffix
  | Raw.Raw_token Tok.ASTERISK ->
    ignore (advance stream);
    ignore (expect_token stream Tok.EQUALS);
    Attr_substring
  | Raw.Raw_token Tok.EQUALS ->
    ignore (advance stream);
    Attr_exact
  | _ -> raise_parse_error (current_token stream)

let parse_wq_name stream =
  let name, _ = expect_ident stream in
  name

let parse_nth_payload stream =
  skip_whitespace stream;
  let payload =
    match current_raw stream with
    | Raw.Raw_token (Tok.NUMBER a) ->
      ignore (advance stream);
      Ast.Nth (A (int_of_float a))
    | Raw.Raw_token (Tok.DIMENSION (num, unit)) ->
      ignore (advance stream);
      skip_whitespace stream;
      begin match current_raw stream with
      | Raw.Raw_token ((Tok.PLUS | Tok.MINUS) as op_token) ->
        ignore (advance stream);
        skip_whitespace stream;
        let b =
          match current_raw stream with
          | Raw.Raw_token (Tok.NUMBER value) ->
            ignore (advance stream);
            int_of_float value
          | _ -> raise_parse_error (current_token stream)
        in
        Ast.Nth
          (ANB (int_of_float num, string_of_nth_operator_token op_token, b))
      | Raw.Raw_token (Tok.NUMBER value) ->
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
    | Raw.Raw_ident name ->
      ignore (advance stream);
      skip_whitespace stream;
      begin match current_raw stream with
      | Raw.Raw_token ((Tok.PLUS | Tok.MINUS) as op_token) ->
        ignore (advance stream);
        skip_whitespace stream;
        let b =
          match current_raw stream with
          | Raw.Raw_token (Tok.NUMBER value) ->
            ignore (advance stream);
            int_of_float value
          | _ -> raise_parse_error (current_token stream)
        in
        let first_char = name.[0] in
        let a = if first_char = '-' then -1 else 1 in
        Ast.Nth (ANB (a, string_of_nth_operator_token op_token, b))
      | Raw.Raw_token (Tok.NUMBER value) ->
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
  match current_raw stream with
  | Raw.Raw_whitespace ->
    let token = advance stream in
    Ast.Whitespace, component_loc token
  | Raw.Raw_ident name ->
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos (Ast.Ident name)
  | Raw.Raw_token Tok.LEFT_PAREN ->
    ignore (advance stream);
    let values, _ =
      parse_component_value_list_until stream (fun stream ->
        current_is stream Tok.RIGHT_PAREN)
    in
    ignore (expect_token stream Tok.RIGHT_PAREN);
    with_loc start_pos stream.last_end_pos (Ast.Paren_block values)
  | Raw.Raw_token Tok.LEFT_BRACKET ->
    ignore (advance stream);
    let values, _ =
      parse_component_value_list_until stream (fun stream ->
        current_is stream Tok.RIGHT_BRACKET)
    in
    ignore (expect_token stream Tok.RIGHT_BRACKET);
    with_loc start_pos stream.last_end_pos (Ast.Bracket_block values)
  | Raw.Raw_token (Tok.PERCENTAGE value) ->
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos
      (Ast.Percentage value : Ast.component_value)
  | Raw.Raw_token (Tok.STRING value) ->
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos (Ast.String value)
  | Raw.Raw_token (Tok.URL value) ->
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos (Ast.Uri value)
  | Raw.Raw_token (Tok.HASH (value, kind)) ->
    ignore (advance stream);
    let kind =
      match kind with
      | `ID -> Ast.Hash_kind_id
      | `UNRESTRICTED -> Ast.Hash_kind_unrestricted
    in
    with_loc start_pos stream.last_end_pos (Ast.Hash (value, kind))
  | Raw.Raw_token (Tok.NUMBER value) ->
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos (Ast.Number value)
  | Raw.Raw_token (Tok.UNICODE_RANGE value) ->
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos (Ast.Unicode_range value)
  | Raw.Raw_token (Tok.DIMENSION (value, unit)) ->
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos
      (Ast.Dimension (Component_value_classifier.Dimension.make (value, unit)))
  | Raw.Raw_token (Tok.INTERPOLATION (content, loc)) ->
    ignore (advance stream);
    with_loc start_pos stream.last_end_pos
      (Ast.Variable (content, loc) : Ast.component_value)
  | Raw.Raw_token (Tok.FUNCTION name) ->
    let token = advance stream in
    let body, body_loc =
      parse_component_value_list_until stream (fun stream ->
        current_is stream Tok.RIGHT_PAREN)
    in
    ignore (expect_token stream Tok.RIGHT_PAREN);
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
  | Raw.Raw_token (Tok.NTH_FUNCTION name) ->
    let token = advance stream in
    let body, body_loc =
      parse_component_value_list_until stream (fun stream ->
        current_is stream Tok.RIGHT_PAREN)
    in
    ignore (expect_token stream Tok.RIGHT_PAREN);
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
  | Raw.Raw_token token ->
    let value =
      match token with
      | Tok.COLON -> Some (Ast.Delim Ast.Delimiter_colon)
      | Tok.DOUBLE_COLON -> Some (Ast.Delim Ast.Delimiter_double_colon)
      | Tok.COMMA -> Some (Ast.Delim Ast.Delimiter_comma)
      | Tok.DOT -> Some (Ast.Delim Ast.Delimiter_dot)
      | Tok.ASTERISK -> Some (Ast.Delim Ast.Delimiter_asterisk)
      | Tok.AMPERSAND -> Some (Ast.Delim Ast.Delimiter_ampersand)
      | Tok.PLUS -> Some (Ast.Delim Ast.Delimiter_plus)
      | Tok.MINUS -> Some (Ast.Delim Ast.Delimiter_minus)
      | Tok.TILDE -> Some (Ast.Delim Ast.Delimiter_tilde)
      | Tok.GREATER_THAN -> Some (Ast.Delim Ast.Delimiter_greater_than)
      | Tok.LESS_THAN -> Some (Ast.Delim Ast.Delimiter_less_than)
      | Tok.EQUALS -> Some (Ast.Delim Ast.Delimiter_equals)
      | Tok.SLASH -> Some (Ast.Delim Ast.Delimiter_slash)
      | Tok.EXCLAMATION -> Some (Ast.Delim Ast.Delimiter_exclamation)
      | Tok.PIPE -> Some (Ast.Delim Ast.Delimiter_pipe)
      | Tok.CARET -> Some (Ast.Delim Ast.Delimiter_caret)
      | Tok.DOLLAR_SIGN -> Some (Ast.Delim Ast.Delimiter_dollar_sign)
      | Tok.QUESTION_MARK -> Some (Ast.Delim Ast.Delimiter_question_mark)
      | Tok.GTE -> Some (Ast.Delim Ast.Delimiter_gte)
      | Tok.LTE -> Some (Ast.Delim Ast.Delimiter_lte)
      | Tok.DELIM '#' -> Some (Ast.Delim Ast.Delimiter_hash)
      | Tok.DELIM '@' -> Some (Ast.Delim Ast.Delimiter_at)
      | Tok.DELIM '%' -> Some (Ast.Delim Ast.Delimiter_percent)
      | Tok.DELIM '_' -> Some (Ast.Delim Ast.Delimiter_underscore)
      | Tok.DELIM ch ->
        Some (Ast.Delim (Ast.Delimiter_other (String.make 1 ch)))
      | _ -> None
    in
    begin match value with
    | Some value ->
      ignore (advance stream);
      with_loc start_pos stream.last_end_pos value
    | None -> raise_parse_error (current_token stream)
    end

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
  match current_raw stream with
  | Raw.Raw_ident _ -> true
  | Raw.Raw_token (Tok.AMPERSAND | Tok.ASTERISK | Tok.INTERPOLATION _) -> true
  | Raw.Raw_token
      (Tok.DOT | Tok.HASH _ | Tok.LEFT_BRACKET | Tok.COLON | Tok.DOUBLE_COLON)
    ->
    true
  | _ -> false

let parse_selector_ident stream =
  let name, _ = expect_ident stream in
  name

let parse_type_selector stream =
  match current_raw stream with
  | Raw.Raw_token Tok.AMPERSAND ->
    ignore (advance stream);
    Ampersand
  | Raw.Raw_token Tok.ASTERISK ->
    ignore (advance stream);
    Universal
  | Raw.Raw_token (Tok.INTERPOLATION (content, loc)) ->
    ignore (advance stream);
    Variable (content, loc)
  | Raw.Raw_ident name ->
    ignore (advance stream);
    Type name
  | _ -> raise_parse_error (current_token stream)

let rec parse_attribute_selector stream =
  ignore (expect_token stream Tok.LEFT_BRACKET);
  skip_whitespace stream;
  let name = parse_wq_name stream in
  skip_whitespace stream;
  if current_is stream Tok.RIGHT_BRACKET then (
    ignore (advance stream);
    Attr_value name)
  else (
    let kind = parse_attr_matcher stream in
    skip_whitespace stream;
    let value =
      match current_raw stream with
      | Raw.Raw_token (Tok.STRING value) ->
        ignore (advance stream);
        Attr_string value
      | Raw.Raw_ident value ->
        ignore (advance stream);
        Attr_ident value
      | _ -> raise_parse_error (current_token stream)
    in
    skip_whitespace stream;
    ignore (expect_token stream Tok.RIGHT_BRACKET);
    To_equal { name; kind; value })

and parse_pseudo_class_selector stream =
  ignore (expect_token stream Tok.COLON);
  match current_raw stream with
  | Raw.Raw_ident name ->
    ignore (advance stream);
    Pseudoclass (PseudoIdent name)
  | Raw.Raw_token (Tok.FUNCTION name) ->
    let start_pos = (current_token stream).start_pos in
    ignore (advance stream);
    let selectors, payload_loc = parse_relative_selector_list stream in
    ignore (expect_token stream Tok.RIGHT_PAREN);
    let payload_loc =
      match selectors with
      | [] -> make_loc start_pos start_pos
      | _ -> payload_loc
    in
    Pseudoclass
      (Ast.Function { name; payload = selectors, payload_loc }
        : Ast.pseudoclass_kind)
  | Raw.Raw_token (Tok.NTH_FUNCTION name) ->
    let start_pos = (current_token stream).start_pos in
    ignore (advance stream);
    let payload = parse_nth_payload stream in
    let payload_loc = make_loc start_pos stream.last_end_pos in
    ignore (expect_token stream Tok.RIGHT_PAREN);
    Pseudoclass
      (Ast.NthFunction { name; payload = payload, payload_loc }
        : Ast.pseudoclass_kind)
  | _ -> raise_parse_error (current_token stream)

and parse_pseudo_element_selector stream =
  ignore (expect_token stream Tok.DOUBLE_COLON);
  let name = parse_selector_ident stream in
  Pseudoelement name

and parse_pseudo_list stream =
  let first = parse_pseudo_element_selector stream in
  let rec loop acc =
    skip_whitespace stream;
    match current_raw stream with
    | Raw.Raw_token Tok.COLON ->
      let pseudo = parse_pseudo_class_selector stream in
      loop (pseudo :: acc)
    | _ -> List.rev acc
  in
  loop [ first ]

and parse_subclass_selector stream =
  match current_raw stream with
  | Raw.Raw_token (Tok.HASH (value, _)) ->
    ignore (advance stream);
    Id value
  | Raw.Raw_token Tok.DOT ->
    ignore (advance stream);
    begin match current_raw stream with
    | Raw.Raw_ident value ->
      ignore (advance stream);
      Class value
    | Raw.Raw_token (Tok.INTERPOLATION (content, loc)) ->
      ignore (advance stream);
      ClassVariable (content, loc)
    | _ -> raise_parse_error (current_token stream)
    end
  | Raw.Raw_token Tok.LEFT_BRACKET ->
    Attribute (parse_attribute_selector stream)
  | Raw.Raw_token Tok.COLON -> Pseudo_class (parse_pseudo_class_selector stream)
  | _ -> raise_parse_error (current_token stream)

and parse_non_complex_selector stream =
  let type_selector =
    match current_raw stream with
    | Raw.Raw_ident _
    | Raw.Raw_token (Tok.AMPERSAND | Tok.ASTERISK | Tok.INTERPOLATION _) ->
      Some (parse_type_selector stream)
    | _ -> None
  in
  let rec collect_subclasses acc =
    match current_raw stream with
    | Raw.Raw_token (Tok.HASH _ | Tok.DOT | Tok.LEFT_BRACKET | Tok.COLON) ->
      let subclass = parse_subclass_selector stream in
      collect_subclasses (subclass :: acc)
    | _ -> List.rev acc
  in
  let subclass_selectors = collect_subclasses [] in
  let pseudo_selectors =
    match current_raw stream with
    | Raw.Raw_token Tok.DOUBLE_COLON -> parse_pseudo_list stream
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
    match current_raw stream with
    | Raw.Raw_token ((Tok.PLUS | Tok.TILDE | Tok.GREATER_THAN) as token) ->
      ignore (advance stream);
      skip_whitespace stream;
      let selector = parse_non_complex_selector stream in
      loop ((selector_combinator_of_token token, selector) :: right)
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
    match current_raw stream with
    | Raw.Raw_token Tok.COMMA ->
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
    match current_raw stream with
    | Raw.Raw_token ((Tok.PLUS | Tok.TILDE | Tok.GREATER_THAN) as token) ->
      ignore (advance stream);
      skip_whitespace stream;
      Some (selector_combinator_of_token token)
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
    match current_raw stream with
    | Raw.Raw_token Tok.COMMA ->
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
    match current_raw stream with
    | Raw.Raw_token (Tok.EOF | Tok.RIGHT_BRACE | Tok.SEMI_COLON | Tok.IMPORTANT)
      ->
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
  ignore (expect_token stream Tok.COLON);
  let value, value_loc = parse_declaration_value_list stream in
  let important =
    match current_raw stream with
    | Raw.Raw_token Tok.IMPORTANT ->
      let token = advance stream in
      true, component_loc token
    | _ ->
      let token = current_token stream in
      false, make_loc token.start_pos token.start_pos
  in
  ignore (accept_token stream Tok.SEMI_COLON);
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

let parse_empty_rule_block stream (left_brace : raw_token_with_location) =
  let right_brace : raw_token_with_location =
    expect_token stream Tok.RIGHT_BRACE
  in
  ignore (accept_token stream Tok.SEMI_COLON);
  [], make_loc left_brace.start_pos right_brace.end_pos

let rec parse_keyframe_style_rule stream =
  skip_whitespace stream;
  let start_pos = (current_token stream).start_pos in
  let prelude =
    match current_raw stream with
    | Raw.Raw_ident name ->
      let _, token = expect_ident stream in
      let selector = SimpleSelector (Type name), component_loc token in
      [ selector ], component_loc token
    | Raw.Raw_token (Tok.PERCENTAGE _) ->
      let rec loop acc =
        let token = current_token stream in
        match current_raw stream with
        | Raw.Raw_token (Tok.PERCENTAGE percent) ->
          ignore (advance stream);
          skip_whitespace stream;
          let acc =
            (SimpleSelector (Percentage percent), component_loc token) :: acc
          in
          begin match current_raw stream with
          | Raw.Raw_token Tok.COMMA ->
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
    let left_brace = expect_token stream Tok.LEFT_BRACE in
    skip_whitespace stream;
    if current_is stream Tok.RIGHT_BRACE then
      parse_empty_rule_block stream left_brace
    else (
      let rules, rules_loc =
        parse_rule_list stream
          ~stop:(fun stream -> current_is stream Tok.RIGHT_BRACE)
          ~parse_one:parse_block_rule ~allow_empty:false
      in
      ignore (expect_token stream Tok.RIGHT_BRACE);
      ignore (accept_token stream Tok.SEMI_COLON);
      rules, rules_loc)
  in
  Style_rule { prelude; block; loc = loc_from_start stream start_pos }

and parse_keyframe_rule_list stream =
  parse_rule_list stream
    ~stop:(fun stream ->
      current_is stream Tok.RIGHT_BRACE || current_is stream Tok.EOF)
    ~parse_one:parse_keyframe_style_rule ~allow_empty:false

and parse_at_rule stream =
  skip_whitespace stream;
  let start_pos = (current_token stream).start_pos in
  match current_raw stream with
  | Raw.Raw_token (Tok.AT_KEYFRAMES name) ->
    let at_token = advance stream in
    skip_whitespace stream;
    let keyframe_name, keyframe_token = expect_ident stream in
    let keyframe_loc = component_loc keyframe_token in
    let prelude = [ Ident keyframe_name, keyframe_loc ], keyframe_loc in
    skip_whitespace stream;
    let left_brace = expect_token stream Tok.LEFT_BRACE in
    skip_whitespace stream;
    let block =
      if current_is stream Tok.RIGHT_BRACE then (
        let empty_block = parse_empty_rule_block stream left_brace in
        Rule_list empty_block)
      else (
        let rules = parse_keyframe_rule_list stream in
        ignore (expect_token stream Tok.RIGHT_BRACE);
        ignore (accept_token stream Tok.SEMI_COLON);
        Rule_list rules)
    in
    {
      name = name, component_loc at_token;
      prelude;
      block;
      loc = loc_from_start stream start_pos;
    }
  | Raw.Raw_token (Tok.AT_RULE_STATEMENT name) ->
    let at_token = advance stream in
    let prelude, prelude_loc =
      parse_prelude_value_list_until stream (fun stream ->
        current_is stream Tok.SEMI_COLON)
    in
    ignore (expect_token stream Tok.SEMI_COLON);
    {
      name = name, component_loc at_token;
      prelude = prelude, prelude_loc;
      block = Empty;
      loc = loc_from_start stream start_pos;
    }
  | Raw.Raw_token (Tok.AT_RULE name) ->
    let at_token = advance stream in
    let prelude, prelude_loc =
      parse_prelude_value_list_until stream (fun stream ->
        current_is stream Tok.LEFT_BRACE)
    in
    ignore (expect_token stream Tok.LEFT_BRACE);
    let rules =
      parse_rule_list stream
        ~stop:(fun stream -> current_is stream Tok.RIGHT_BRACE)
        ~parse_one:parse_block_rule ~allow_empty:true
    in
    ignore (expect_token stream Tok.RIGHT_BRACE);
    ignore (accept_token stream Tok.SEMI_COLON);
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
  let left_brace = expect_token stream Tok.LEFT_BRACE in
  let block =
    skip_whitespace stream;
    if current_is stream Tok.RIGHT_BRACE then
      parse_empty_rule_block stream left_brace
    else (
      let rules, rules_loc =
        parse_rule_list stream
          ~stop:(fun stream -> current_is stream Tok.RIGHT_BRACE)
          ~parse_one:parse_block_rule ~allow_empty:false
      in
      ignore (expect_token stream Tok.RIGHT_BRACE);
      ignore (accept_token stream Tok.SEMI_COLON);
      rules, rules_loc)
  in
  { prelude; block; loc = loc_from_start stream start_pos }

and parse_block_rule stream =
  skip_whitespace stream;
  match current_raw stream with
  | Raw.Raw_token (Tok.AT_KEYFRAMES _ | Tok.AT_RULE _ | Tok.AT_RULE_STATEMENT _)
    ->
    At_rule (parse_at_rule stream)
  | Raw.Raw_ident _
    when identifier_starts_property stream.tokens (stream.index + 1) ->
    Declaration (parse_declaration_no_eof stream)
  | _ -> Style_rule (parse_style_rule stream)

and parse_stylesheet_rule stream =
  skip_whitespace stream;
  match current_raw stream with
  | Raw.Raw_token (Tok.AT_KEYFRAMES _ | Tok.AT_RULE _ | Tok.AT_RULE_STATEMENT _)
    ->
    At_rule (parse_at_rule stream)
  | _ -> Style_rule (parse_style_rule stream)

let make_stream input =
  let tokens = Lex.from_string input in
  List.iter
    (fun ({ txt; start_pos; end_pos } : raw_token_with_location) ->
      match txt with
      | Ok _ -> ()
      | Error err ->
        raise (Lexer.LexingError (start_pos, end_pos, Tok.show_error err)))
    tokens;
  { tokens = Array.of_list tokens; index = 0; last_end_pos = Lexing.dummy_pos }

let parse_declaration_list input =
  let stream = make_stream input in
  let rules, loc =
    parse_rule_list stream
      ~stop:(fun stream -> current_is stream Tok.EOF)
      ~parse_one:parse_block_rule ~allow_empty:true
  in
  ignore (expect_token stream Tok.EOF);
  rules, loc

let parse_declaration input =
  let stream = make_stream input in
  let declaration = parse_declaration_no_eof stream in
  skip_whitespace stream;
  ignore (expect_token stream Tok.EOF);
  declaration

let parse_stylesheet input =
  let stream = make_stream input in
  let rules, loc =
    parse_rule_list stream
      ~stop:(fun stream -> current_is stream Tok.EOF)
      ~parse_one:parse_stylesheet_rule ~allow_empty:true
  in
  ignore (expect_token stream Tok.EOF);
  rules, loc

let parse_keyframes input =
  let stream = make_stream input in
  let rules =
    if current_is stream Tok.LEFT_BRACE then (
      ignore (advance stream);
      let rules = parse_keyframe_rule_list stream in
      ignore (expect_token stream Tok.RIGHT_BRACE);
      ignore (accept_token stream Tok.SEMI_COLON);
      rules)
    else parse_keyframe_rule_list stream
  in
  ignore (expect_token stream Tok.EOF);
  rules
