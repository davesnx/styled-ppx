type rule =
  | Declaration of string * string
  | Selector of string * rule array

let declaration (property, value) = Declaration (property, value)
let selector selector rules = Selector (selector, rules)
let media query rules = Selector ({|@media |} ^ query, rules)

let rec ruleToDict (dict : Js.Json.t Js.Dict.t) (rule : rule) :
  Js.Json.t Js.Dict.t =
  let _ =
    match rule with
    | Declaration (name, value) -> Js.Dict.set dict name (Js.Json.string value)
    | Selector (name, ruleset) -> Js.Dict.set dict name (toJson ruleset)
  in
  dict

and toJson (rules : rule array) : Js.Json.t =
  Js.Json.object_
    (Kloth.Array.reduce ~init:(Js.Dict.empty ()) ~f:ruleToDict rules)
