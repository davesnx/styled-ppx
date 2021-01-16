open Rule.Let;
open Modifier;

type combinator('a, 'b) = list(Rule.rule('a)) => Rule.rule('b);

let rec match_longest = ((left_key, left_rule), rules) =>
  switch (rules) {
  | [] =>
    let.bind_match value = left_rule;
    return_match((left_key, value));
  | [new_left, ...rules] =>
    let.bind_longest_match value = (
      left_rule,
      match_longest(new_left, rules),
    );
    switch (value) {
    | `Left(value) => return_match((left_key, value))
    | `Right(value) => return_match(value)
    };
  };

let combine_static = rules => {
  let rec match_everything = (values, rules) =>
    switch (rules) {
    | [] => return_match(values |> List.rev)
    | [left, ...rules] =>
      let.bind_match value = left;
      match_everything([value, ...values], rules);
    };
  match_everything([], rules);
};

// TODO: test [A | [A B] ] with A B
let combine_xor =
  fun
  | [] => failwith("xor doesn't makes sense without a single value")
  | [left, ...rules] => {
      let rules: list((unit, Rule.rule('a))) =
        List.map(rule => ((), rule), rules);
      let.map_match ((), value) = match_longest(((), left), rules);
      value;
    };

// TODO: [ A && [A B] ] with A B A
let combine_and = rules => {
  // TODO: an array is a better choice
  let rec match_everything = (values, rules) =>
    switch (rules) {
    | [] => return_match(values |> List.rev)
    | [left, ...new_rules] =>
      let.bind_match (key, value) = match_longest(left, new_rules);
      let rules = List.remove_assoc(key, rules);
      match_everything([(key, value), ...values], rules);
    };

  let rules = rules |> List.mapi((i, rule) => (i, rule));
  let.map_match values = match_everything([], rules);
  values
  |> List.sort(((a, _), (b, _)) => Int.compare(a, b))
  |> List.map(((_, v)) => v);
};

// [ A || B ] = [ A? && B? ]!
let combine_or = rules => rules |> List.map(optional) |> combine_and;
