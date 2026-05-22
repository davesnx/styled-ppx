type rule =
  | Declaration of string * string
  | Selector of string array * rule array

let camel_case_to_kebab_case str =
  let len = String.length str in
  let extra_space_for_dashes = 10 in
  let buffer = Buffer.create (len + extra_space_for_dashes) in
  for i = 0 to len - 1 do
    let c = str.[i] in
    match c with
    | 'A' .. 'Z' ->
      Buffer.add_char buffer '-';
      Buffer.add_char buffer (Char.lowercase_ascii c)
    | _ -> Buffer.add_char buffer c
  done;
  Buffer.contents buffer

let declaration (property, value) =
  Declaration (camel_case_to_kebab_case property, value)

let selector selector rules = Selector ([| selector |], rules)
let selectorMany selector_list rules = Selector (selector_list, rules)
let media query rules = Selector ([| {|@media |} ^ query |], rules)

let important v =
  match v with
  | Declaration (name, value) -> Declaration (name, value ^ {js| !important|js})
  | Selector (_, _) -> v
