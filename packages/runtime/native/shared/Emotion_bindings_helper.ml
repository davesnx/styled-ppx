let addAmpersand selector =
  if Kloth.String.contains selector '&' then selector
  else if Kloth.String.starts_with ~prefix:"@" selector then selector
  else "& " ^ selector

let rec replaceSelector rules =
  Kloth.Array.map
    ~f:(function
      | Rule.Selector (selector, rules) ->
        Rule.Selector
          (Kloth.Array.map ~f:addAmpersand selector, replaceSelector rules)
      | Declaration (_, _) as x -> x)
    rules

let replaceSelectorGlobal rules =
  Kloth.Array.map
    ~f:(function
      | Rule.Selector (selector, rules) ->
        Rule.Selector (selector, replaceSelector rules)
      | Declaration (_, _) as x -> x)
    rules
