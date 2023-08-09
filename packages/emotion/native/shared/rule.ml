type t =
  | Declaration of string * string
  | Selector of string * t list
  | Pseudoclass of string * t list
  | PseudoclassParam of string * string * t list

let rec rule_to_string (accumulator : string) rule =
  let next_rule =
    match rule with
    | Declaration (name, value) -> Printf.sprintf "%s: %s" name value
    | Selector (name, rules) ->
      Printf.sprintf ".%s { %s }" name (to_string rules)
    | Pseudoclass (name, rules) ->
      Printf.sprintf ":%s { %s }" name (to_string rules)
    | PseudoclassParam (name, param, rules) ->
      Printf.sprintf ":%s ( %s ) %s" name param (to_string rules)
  in
  accumulator ^ next_rule ^ "; "

and to_string (rules : t list) = rules |> List.fold_left rule_to_string ""
