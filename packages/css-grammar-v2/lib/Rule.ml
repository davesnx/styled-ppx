module Tokens = Styled_ppx_css_parser.Tokens

type 'a rule = Tokens.t list -> ('a, string list) result * Tokens.t list

module Data = struct
  let return data tokens = data, tokens

  let bind rule f tokens =
    let data, remaining_tokens = rule tokens in
    match data with
    | Ok d -> f (Ok d) remaining_tokens
    | Error message -> f (Error message) tokens

  let map rule f = bind rule (fun value -> return (f value))

  let bind_shortest_or_longest shortest (left, right) f tokens =
    let left_data, left_tokens = left tokens in
    let right_data, right_tokens = right tokens in
    let op = if shortest then ( > ) else ( < ) in
    let use_left = op (List.length left_tokens) (List.length right_tokens) in
    if use_left then f (`Left left_data) left_tokens
    else f (`Right right_data) right_tokens

  let bind_shortest (left, right) f =
    bind_shortest_or_longest true (left, right) f

  let bind_longest (left, right) f =
    bind_shortest_or_longest false (left, right) f
end

module Match = struct
  let return value tokens = Data.return (Ok value) tokens

  let bind rule f =
    Data.bind rule (function
      | Ok value -> f value
      | Error error -> Data.return (Error error))

  let map rule f = bind rule (fun value -> return (f value))

  let bind_shortest_or_longest shortest (left, right) f tokens =
    let left_data, left_tokens = left tokens in
    let right_data, right_tokens = right tokens in
    let left_len = List.length left_tokens in
    let right_len = List.length right_tokens in
    (* For longest: fewer remaining = consumed more = longer match.
       On ties, prefer left (first rule). *)
    let use_left =
      if shortest then left_len > right_len else left_len <= right_len
    in
    match left_data, right_data with
    | Ok left_value, Error _ -> f (`Left left_value) left_tokens
    | Error _, Ok right_value -> f (`Right right_value) right_tokens
    | Ok left_value, Ok right_value ->
      if use_left then f (`Left left_value) left_tokens
      else f (`Right right_value) right_tokens
    | Error left_data, Error right_data ->
      if use_left then Data.return (Error left_data) left_tokens
      else Data.return (Error right_data) right_tokens

  let bind_shortest (left, right) f =
    bind_shortest_or_longest true (left, right) f

  let bind_longest (left, right) f =
    bind_shortest_or_longest false (left, right) f

  let rec all = function
    | [] -> return []
    | hd_rule :: tl_rules ->
      bind hd_rule (fun hd -> bind (all tl_rules) (fun tl -> return (hd :: tl)))
end

module Let = struct
  let return_data = Data.return
  let ( let* ) = Data.bind
  let ( let+ ) = Data.map
  let bind_shortest_data = Data.bind_shortest
  let bind_longest_data = Data.bind_longest
  let return_match = Match.return
  let ( let*! ) = Match.bind
  let ( let+! ) = Match.map
  let bind_shortest_match = Match.bind_shortest
  let bind_longest_match = Match.bind_longest
end

module Pattern = struct
  let identity tokens = Match.return () tokens

  let next = function
    | token :: tokens -> Match.return token tokens
    | _ -> Error [ "missing the token expected" ], []

  let token expected tokens =
    match tokens with
    | token :: rest ->
      let data = expected token in
      let tokens = if Result.is_ok data then rest else token :: rest in
      data, tokens
    | [] -> Error [ "missing the token expected" ], []

  let expect expected =
    token (fun token ->
      if token = expected then Ok ()
      else
        Error
          [
            "Expected '"
            ^ Tokens.humanize expected
            ^ "' but instead got '"
            ^ Tokens.humanize token
            ^ "'.";
          ])

  let value v rule = Match.bind rule (fun () -> Match.return v)
end
