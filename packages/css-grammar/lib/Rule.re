module Ast = Styled_ppx_css_parser.Ast;
module Render = Styled_ppx_css_parser.Render;

type error = list(string);
type data('a) = result('a, error);
type input = Ast.component_value_list;
type located_component_value = Ast.with_loc(Ast.component_value);
type rule('a) = input => (data('a), input);

type return('a, 'b) = 'b => rule('a);
type bind('a, 'b, 'c) = (rule('a), 'b => rule('c)) => rule('c);
type map('a, 'b, 'c, 'd) = (rule('a), 'b => 'c) => rule('d);
type best('left_in, 'left_v, 'right_in, 'right_v, 'c) =
  ((rule('left_in), rule('right_in)), [ | `Left('left_v) | `Right('right_v) ] => rule('c)) =>
  rule('c);

let rec drop_leading_whitespace = values =>
  switch (values) {
  | [(Ast.Whitespace, _), ...rest] => drop_leading_whitespace(rest)
  | _ => values
  };

let remaining_length = values => List.length(drop_leading_whitespace(values));

let render_component_value = ((value, _): located_component_value) =>
  Render.component_value(value);

module Data = {
  let return = (data, values) => (data, drop_leading_whitespace(values));

  let bind = (rule, f, values) => {
    let values = drop_leading_whitespace(values);
    let (data, remaining_values) = rule(values);
    switch (data) {
    | Ok(value) => f(Ok(value), remaining_values)
    | Error(message) => f(Error(message), values)
    };
  };

  let map = (rule, f) => bind(rule, value => return(f(value)));

  let bind_shortest_or_longest = (shortest, (left, right), f, values) => {
    let values = drop_leading_whitespace(values);
    let (left_data, left_values) = left(values);
    let (right_data, right_values) = right(values);
    let op = shortest ? (>) : (<);
    let use_left = op(remaining_length(left_values), remaining_length(right_values));
    use_left
      ? f(`Left(left_data), left_values)
      : f(`Right(right_data), right_values);
  };

  let bind_shortest: best('a, data('a), 'b, data('b), 'c) =
      ((left, right), f) => bind_shortest_or_longest(true, (left, right), f);

  let bind_longest: best('a, data('a), 'b, data('b), 'c) =
      ((left, right), f) => bind_shortest_or_longest(false, (left, right), f);
};

module Match = {
  let return = (value, values) => Data.return(Ok(value), values);

  let bind = (rule, f) =>
    Data.bind(
      rule,
      fun
      | Ok(value) => f(value)
      | Error(error) => Data.return(Error(error)),
    );

  let map = (rule, f) => bind(rule, value => return(f(value)));

  let bind_shortest_or_longest = (shortest, (left, right), f, values) => {
    let values = drop_leading_whitespace(values);
    let (left_data, left_values) = left(values);
    let (right_data, right_values) = right(values);
    let op = shortest ? (>) : (<);
    let use_left = op(remaining_length(left_values), remaining_length(right_values));
    switch (left_data, right_data) {
    | (Ok(left_value), Error(_)) => f(`Left(left_value), left_values)
    | (Error(_), Ok(right_value)) => f(`Right(right_value), right_values)
    | (Ok(left_value), Ok(right_value)) =>
      use_left
        ? f(`Left(left_value), left_values)
        : f(`Right(right_value), right_values)
    | (Error(left_error), Error(right_error)) =>
      use_left
        ? Data.return(Error(left_error), left_values)
        : Data.return(Error(right_error), right_values)
    };
  };

  let bind_shortest = ((left, right), f) =>
    bind_shortest_or_longest(true, (left, right), f);

  let bind_longest = ((left, right), f) =>
    bind_shortest_or_longest(false, (left, right), f);

  let rec all = rules =>
    switch (rules) {
    | [] => return([])
    | [hd_rule, ...tl_rules] =>
      bind(hd_rule, hd => {bind(all(tl_rules), tl => {return([hd, ...tl])})})
    };
};

module Let = {
  let return_data = Data.return;
  let (let.bind_data) = Data.bind;
  let (let.map_data) = Data.map;
  let (let.bind_shortest_data) = Data.bind_shortest;
  let (let.bind_longest_data) = Data.bind_longest;

  let return_match = Match.return;
  let (let.bind_match) = Match.bind;
  let (let.map_match) = Match.map;
  let (let.bind_shortest_match) = Match.bind_shortest;
  let (let.bind_longest_match) = Match.bind_longest;
};

module Pattern = {
  let identity = Match.return();

  let next =
    fun
    | [value, ...values] => Match.return(value, drop_leading_whitespace(values))
    | [] => (Error(["Unexpected end of input."]), []);

  let component = (expected, values) =>
    switch (drop_leading_whitespace(values)) {
    | [value, ...remaining_values] =>
      let data = expected(value);
      let remaining_values =
        Result.is_ok(data)
          ? drop_leading_whitespace(remaining_values)
          : drop_leading_whitespace(values);
      (data, remaining_values);
    | [] => (Error(["Unexpected end of input."]), [])
    };

  let expect_delim = expected =>
    component(
      fun
      | (Ast.Delim(actual), _) when actual == expected => Ok()
      | value =>
        Error([
          "Expected '"
          ++ Render.delimiter(expected)
          ++ "' but instead got '"
          ++ render_component_value(value)
          ++ "'.",
        ]),
    );

  let value = (value, rule) => Match.bind(rule, () => Match.return(value));
};

let run = (rule_parser, input: input) => {
  let input = drop_leading_whitespace(input);
  let (output, remaining_values) = rule_parser(input);
  switch (output) {
  | Ok(data) =>
    let remaining_values = drop_leading_whitespace(remaining_values);
    switch (remaining_values) {
    | [] => Ok(data)
    | [value, ..._] =>
      Error(
        "Unexpected trailing input starting at '"
        ++ render_component_value(value)
        ++ "'.",
      )
    };
  | Error([message, ..._]) => Error(message)
  | Error([]) => Error("Expected a valid value.")
  };
};

let interpolatable = (~type_path as _, inner_rule, values) => {
  let interp_rule =
    Pattern.component(
      fun
      | (Ast.Variable(name, _loc), _) => Ok(`Interpolation(name))
      | _ => Error(["Expected value."]),
    );
  switch (interp_rule(values)) {
  | (Ok(_) as result, rest) => (result, rest)
  | (Error(_), _) =>
    let (result, rest) = inner_rule(values);
    switch (result) {
    | Ok(value) => (Ok(`Value(value)), rest)
    | Error(msgs) => (Error(msgs), values)
    }
  };
};
