open Rule.Let

let rec match_longest (left_key, left_rule) rules =
  match rules with
  | [] ->
      Rule.Match.bind left_rule (fun value -> return_match (left_key, value))
  | new_left :: rest ->
      Rule.Match.bind_longest (left_rule, match_longest new_left rest)
        (function
        | `Left value -> return_match (left_key, value)
        | `Right value -> return_match value)

let static rules =
  let rec match_everything values = function
    | [] -> return_match (List.rev values)
    | left :: rest ->
        Rule.Match.bind left (fun value ->
            match_everything (value :: values) rest)
  in
  match_everything [] rules

let extract_expected_value error_msg =
  if not (String.contains error_msg 'E') then None
  else
    try
      let start = String.index error_msg '\'' + 1 in
      let end_idx = String.index_from error_msg start '\'' in
      Some (String.sub error_msg start (end_idx - start))
    with _ -> None

let extract_got_value error_msg =
  if not (String.contains error_msg 'i') then "the provided value"
  else
    try
      let start = String.rindex error_msg '\'' in
      let before_quote = String.sub error_msg 0 start in
      let second_last = String.rindex before_quote '\'' + 1 in
      String.sub error_msg second_last (start - second_last)
    with _ -> "the provided value"

let format_expected_values = function
  | [] -> ""
  | [ single ] -> "'" ^ single ^ "'"
  | values ->
      let rec format_list = function
        | [] -> ""
        | [ x ] -> "or '" ^ x ^ "'"
        | x :: xs -> "'" ^ x ^ "', " ^ format_list xs
      in
      format_list values

let create_error_message got expected_values =
  match expected_values with
  | [] -> [ "Got '" ^ got ^ "'" ]
  | values -> (
      match Levenshtein.find_closest_match got values with
      | Some suggestion ->
          [ "Got '" ^ got ^ "', did you mean '" ^ suggestion ^ "'?" ]
      | None ->
          let expected_str = format_expected_values values in
          [ "Got '" ^ got ^ "', expected " ^ expected_str ^ "." ])

let process_error_messages = function
  | [] -> [ "No alternatives matched" ]
  | errors ->
      let expected_values =
        errors
        |> List.filter_map (function
             | msg :: _ -> extract_expected_value msg
             | _ -> None)
        |> List.filter (fun value -> value <> "$")
        |> List.sort_uniq String.compare
      in
      (match expected_values with
      | [] -> List.hd errors
      | values ->
          let got =
            match List.hd errors with
            | msg :: _ -> extract_got_value msg
            | _ -> "the provided value"
          in
          create_error_message got values)

let xor rules =
  match rules with
  | [] -> failwith "xor doesn't make sense without a single value"
  | all_rules ->
      let try_rules_with_best_match = function
        | [] -> failwith "xor doesn't make sense without a single value"
        | left :: rest ->
            let rules_with_unit = List.map (fun rule -> ((), rule)) rest in
            Rule.Match.map
              (match_longest ((), left) rules_with_unit)
              (fun ((), value) -> value)
      in
      let try_all_and_collect_errors rules tokens =
        let rec collect_errors remaining_rules acc_errors =
          match remaining_rules with
          | [] ->
              let combined_error = process_error_messages acc_errors in
              Rule.Data.return (Error combined_error) tokens
          | rule :: rest -> (
              let data, remaining = rule tokens in
              match data with
              | Ok value -> Rule.Data.return (Ok value) remaining
              | Error err -> collect_errors rest (acc_errors @ [ err ]))
        in
        collect_errors rules []
      in
      fun tokens ->
        let successful_rules =
          all_rules
          |> List.filter_map (fun rule ->
                 let data, remaining = rule tokens in
                 match data with
                 | Ok _ -> Some (rule, remaining)
                 | Error _ -> None)
        in
        match successful_rules with
        | [] -> try_all_and_collect_errors all_rules tokens
        | _ -> try_rules_with_best_match all_rules tokens

let and_ rules =
  let rec match_everything values indexed_rules =
    match indexed_rules with
    | [] -> return_match (List.rev values)
    | left :: new_rules ->
        Rule.Match.bind (match_longest left new_rules) (fun (key, value) ->
            let remaining = List.remove_assoc key indexed_rules in
            match_everything ((key, value) :: values) remaining)
  in
  let indexed_rules = List.mapi (fun i rule -> (i, rule)) rules in
  Rule.Match.map (match_everything [] indexed_rules) (fun values ->
      values
      |> List.sort (fun (a, _) (b, _) -> Int.compare a b)
      |> List.map (fun (_, v) -> v))

let or_ rules =
  rules |> List.map Modifier.optional |> and_ |> Modifier.at_least_one
