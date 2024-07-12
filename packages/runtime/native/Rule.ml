type rule =
  | Declaration of string * string
  | Selector of string * rule array

let explode s =
  let rec exp i l = if i < 0 then l else exp (i - 1) (s.[i] :: l) in
  exp (String.length s - 1) []

let camelCaseToKebabCase str =
  let insert_dash acc letter =
    match letter with
    | 'A' .. 'Z' as letter ->
      ("-" ^ String.make 1 (Char.lowercase_ascii letter)) :: acc
    | _ -> String.make 1 letter :: acc
  in
  String.concat "" (List.rev (List.fold_left insert_dash [] (explode str)))

let declaration (property, value) =
  Declaration (camelCaseToKebabCase property, value)

let selector selector rules = Selector (selector, rules)
let media query rules = Selector ({|@media |} ^ query, rules)
