open Rule.Let;
open Rule.Pattern;

type modifier('a, 'b) = Rule.rule('a) => Rule.rule('b);

type range = (int, option(int));

let one = Fun.id;
let optional = rule => {
  let.bind_data value = rule;
  let value =
    switch (value) {
    | Ok(value) => Some(value)
    | Error(_) => None
    };
  return_match(value);
};
let match_n_values = ((min, max), sep, rule) => {
  // TODO: this definitly needs to be cleaned up

  let rule_with_comma = {
    let.bind_match () = sep;
    rule;
  };
  let rec match_until_fails = values => {
    let.bind_data value = rule_with_comma;

    let length = List.length(values) + (Result.is_ok(value) ? 1 : 0);
    let hit_min = length >= min;
    let hit_max =
      switch (max) {
      | Some(max) => length >= max
      | None => false
      };

    switch (value) {
    | Ok(value) =>
      hit_max
        ? return_match([value, ...values] |> List.rev)
        : match_until_fails([value, ...values])
    | Error(last_error) =>
      hit_min
        ? return_match(values |> List.rev) : return_data(Error(last_error))
    };
  };

  let.bind_data value = rule;
  switch (value) {
  | Ok(value) => match_until_fails([value])
  | Error(last_error) =>
    min == 0 ? return_data(Ok([])) : return_data(Error(last_error))
  };
};
let zero_or_more = rule => match_n_values((0, None), identity, rule);
let one_or_more = rule => match_n_values((1, None), identity, rule);
let repeat_by_sep = (sep, (min, max), rule) =>
  match_n_values((min, max), sep, rule);
let repeat = ((min, max), rule) =>
  repeat_by_sep(identity, (min, max), rule);
let repeat_by_comma = ((min, max), rule) =>
  repeat_by_sep(expect(COMMA), (min, max), rule);

let at_least_one = rule => {
  let.bind_match values = rule;
  let have_one = List.exists(Option.is_some, values);
  return_data(have_one ? Ok(values) : Error(["should match at least one"]));
};
// TODO: make that more dynamic
let at_least_one_2 = rule => {
  let.bind_match (a, b) = rule;
  let.bind_match _ = {
    let a = Option.map(a => `A(a), a);
    let b = Option.map(b => `B(b), b);
    at_least_one(return_match([a, b]));
  };
  return_match((a, b));
};
