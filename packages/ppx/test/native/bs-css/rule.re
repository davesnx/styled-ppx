type t =
  | Declaration(string, string)
  | Selector(string, list(t))
  | Pseudoclass(string, list(t))
  | PseudoclassParam(string, string, list(t));

let rec rule_to_string = (accumulator: string, rule) => {
  let next_rule =
    switch (rule) {
    | Declaration(name, value) => Printf.sprintf("%s: %s", name, value)
    | Selector(name, rules) =>
      Printf.sprintf(".%s { %s }", name, to_string(rules))
    | Pseudoclass(name, rules) =>
      Printf.sprintf(":%s { %s }", name, to_string(rules))
    | PseudoclassParam(name, param, rules) =>
      Printf.sprintf(":%s ( %s ) %s", name, param, to_string(rules))
    };
  accumulator ++ next_rule ++ "; ";
}

and to_string = (rules: list(t)) =>
  rules |> List.fold_left(rule_to_string, "");
