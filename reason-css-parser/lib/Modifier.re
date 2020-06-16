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
let match_n_values = (sep, rule) => {
  let rule_with_comma = {
    let.bind_match () = sep;
    rule;
  };
  let rec match_until_fails = values => {
    let.bind_data value = rule_with_comma;
    switch (value) {
    | Ok(value) => match_until_fails([value, ...values])
    | Error(last_error) => return_match((values |> List.rev, last_error))
    };
  };
  let.bind_data value = rule;
  switch (value) {
  | Ok(value) => match_until_fails([value])
  | Error(last_error) => return_match(([], last_error))
  };
};
let zero_or_more = rule => {
  let.bind_match (values, _) = match_n_values(identity, rule);
  return_match(values);
};
let one_or_more = rule => {
  let.bind_match (values, last_error) = match_n_values(identity, rule);
  let data =
    switch (values) {
    | [] => Error(last_error)
    | values => Ok(values)
    };
  return_data(data);
};
let repeat_by_sep = (sep, (min, max), rule) => {
  let.bind_match (values, last_error) = match_n_values(sep, rule);
  let values_length = List.length(values);
  // TODO: technically it could be more than max, but we shouldn't match
  let hit_max =
    switch (max) {
    | Some(max) =>
      values_length <= max
        ? Ok()
        : Error("expected up to " ++ string_of_int(max) ++ " elements")
    | None => Ok()
    };
  let data =
    switch (values_length >= min, hit_max) {
    | (false, _) => Error(last_error)
    | (_, Error(error)) => Error(error)
    | (true, Ok ()) => Ok(values)
    };
  return_data(data);
};
let repeat = ((min, max), rule) =>
  repeat_by_sep(identity, (min, max), rule);
let repeat_by_comma = ((min, max), rule) =>
  repeat_by_sep(expect(COMMA), (min, max), rule);

let at_least_one = rule => {
  let.bind_match values = rule;
  let have_one = List.exists(Option.is_some, values);
  return_data(have_one ? Ok(values) : Error("should match at least one"));
};
