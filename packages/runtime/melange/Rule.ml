type rule =
  | Declaration of string * string
  | Selector of string array * rule array

let get_value_from_rule rule =
  match rule with
  | Declaration (_, value) -> value
  | Selector (_, _) -> assert false

let declaration (property, value) = Declaration (property, value)
let selector selector rules = Selector ([| selector |], rules)
let selectorMany selector_list rules = Selector (selector_list, rules)
let media query rules = Selector ([| {|@media |} ^ query |], rules)

let important v =
  match v with
  | Declaration (name, value) -> Declaration (name, value ^ {js| !important|js})
  | Selector (_, _) -> v

let rec ruleToDict dict rule =
  let () =
    match rule with
    | Declaration (name, value) -> Js.Dict.set dict name (Js.Json.string value)
    | Selector (name, ruleset) ->
      Js.Dict.set dict
        (Kloth.Array.map_and_join ~sep:", " ~f:(fun v -> v) name)
        (toJson ruleset)
  in
  dict

and toJson (rules : rule array) : Js.Json.t =
  Js.Json.object_
    (Kloth.Array.reduce ~init:(Js.Dict.empty ()) ~f:ruleToDict rules)
