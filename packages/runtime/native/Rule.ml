open Kloth

type rule =
  | Declaration of string * string
  | Selector of string array * rule array

let get_value_from_rule rule =
  match rule with
  | Declaration (_, value) -> value
  | Selector (_, _) -> assert false

let camel_case_to_kebab_case str =
  let len = Kloth.String.length str in
  let extra_space_for_dashes = 10 in
  let buffer = Kloth.Buffer.create (len + extra_space_for_dashes) in
  for i = 0 to len - 1 do
    let c = str.[i] in
    match c with
    | 'A' .. 'Z' ->
      Kloth.Buffer.add_char buffer '-';
      Kloth.Buffer.add_char buffer (Kloth.Char.lowercase_ascii c)
    | _ -> Kloth.Buffer.add_char buffer c
  done;
  Kloth.Buffer.contents buffer

let declaration (property, value) =
  Declaration (camel_case_to_kebab_case property, value)

let selector selector rules = Selector ([| selector |], rules)
let selectorMany selector_list rules = Selector (selector_list, rules)
let media query rules = Selector ([| {|@media |} ^ query |], rules)

let important v =
  match v with
  | Declaration (name, value) -> Declaration (name, value ^ {js| !important|js})
  | Selector (_, _) -> v
