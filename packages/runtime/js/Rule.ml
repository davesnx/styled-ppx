type t =
  | Declaration of string * string
  | Selector of string * t array

let declaration (property, value) = Declaration (property, value)
let selector selector rules = Selector (selector, rules)
let media query rules = Selector ({|@media |} ^ query, rules)

let rec ruleToDict dict rule =
  let _ =
    match rule with
    | Declaration (name, value) -> Js.Dict.set dict name (Js.Json.string value)
    | Selector (name, ruleset) -> Js.Dict.set dict name (toJson ruleset)
  in
  dict

and toJson rules =
  Kloth.Array.reduce rules (Js.Dict.empty ()) ruleToDict |. Js.Json.object_
