module Ast = Styled_ppx_css_parser.Ast;
module Render = Styled_ppx_css_parser.Render;

type expected =
  | Keyword(string)
  | TokenKind(string)
  | Function(string)
  | Description(string);

type error_info = {
  expected: list(expected),
  got: option(Ast.component_value),
};

type error = list(error_info);
type data('a) = result('a, error);
type input = Ast.component_value_list;
type located_component_value = Ast.with_loc(Ast.component_value);
type rule('a) = input => (data('a), input);

type return('a, 'b) = 'b => rule('a);
type bind('a, 'b, 'c) = (rule('a), 'b => rule('c)) => rule('c);
type map('a, 'b, 'c, 'd) = (rule('a), 'b => 'c) => rule('d);
type best('left_in, 'left_v, 'right_in, 'right_v, 'c) =
  (
    (rule('left_in), rule('right_in)),
    [
      | `Left('left_v)
      | `Right('right_v)
    ] =>
    rule('c)
  ) =>
  rule('c);

let rec drop_leading_whitespace = values =>
  switch (values) {
  | [(Ast.Whitespace, _), ...rest] => drop_leading_whitespace(rest)
  | _ => values
  };

let remaining_length = values =>
  List.length(drop_leading_whitespace(values));

/* Error construction helpers */
let err = (~got=?, expected) =>
  Error([
    {
      expected,
      got,
    },
  ]);

let err_keyword = (kw, (actual, _): located_component_value) =>
  Error([
    {
      expected: [Keyword(kw)],
      got: Some(actual),
    },
  ]);

let err_kind = kind =>
  Error([
    {
      expected: [TokenKind(kind)],
      got: None,
    },
  ]);

let err_kind_got = (kind, (actual, _): located_component_value) =>
  Error([
    {
      expected: [TokenKind(kind)],
      got: Some(actual),
    },
  ]);

let err_fn = (name, (actual, _): located_component_value) =>
  Error([
    {
      expected: [Function(name)],
      got: Some(actual),
    },
  ]);

let err_desc = desc =>
  Error([
    {
      expected: [Description(desc)],
      got: None,
    },
  ]);

let err_desc_got = (desc, (actual, _): located_component_value) =>
  Error([
    {
      expected: [Description(desc)],
      got: Some(actual),
    },
  ]);

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
    let use_left =
      op(remaining_length(left_values), remaining_length(right_values));
    use_left
      ? f(`Left(left_data), left_values)
      : f(`Right(right_data), right_values);
  };

  let bind_shortest: best('a, data('a), 'b, data('b), 'c) =
      ((left, right), f) =>
    bind_shortest_or_longest(true, (left, right), f);

  let bind_longest: best('a, data('a), 'b, data('b), 'c) =
      ((left, right), f) =>
    bind_shortest_or_longest(false, (left, right), f);
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
    let use_left =
      op(remaining_length(left_values), remaining_length(right_values));
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
    | [value, ...values] =>
      Match.return(value, drop_leading_whitespace(values))
    | [] => (err_desc("more input"), []);

  let component = (expected, values) =>
    switch (drop_leading_whitespace(values)) {
    | [value, ...remaining_values] =>
      let data = expected(value);
      let remaining_values =
        Result.is_ok(data)
          ? drop_leading_whitespace(remaining_values)
          : drop_leading_whitespace(values);
      (data, remaining_values);
    | [] => (err_desc("more input"), [])
    };

  let expect_delim = expected =>
    component(
      fun
      | (Ast.Delim(actual), _) when actual == expected => Ok()
      | value => err_keyword(Render.delimiter(expected), value),
    );

  let value = (value, rule) => Match.bind(rule, () => Match.return(value));
};

let merge_error_infos = (infos: list(error_info)): error_info => {
  let all_expected = infos |> List.concat_map(e => e.expected);
  let got = infos |> List.find_map(e => e.got);
  {
    expected: all_expected,
    got,
  };
};

let run = (parser, input: input) => {
  let input = drop_leading_whitespace(input);
  let (output, remaining_values) = parser(input);
  switch (output) {
  | Ok(data) =>
    let remaining_values = drop_leading_whitespace(remaining_values);
    switch (remaining_values) {
    | [] => Ok(data)
    | [(value, _), ..._] =>
      Error({
        expected: [Description("no trailing input")],
        got: Some(value),
      })
    };
  | Error([info, ...rest]) => Error(merge_error_infos([info, ...rest]))
  | Error([]) =>
    Error({
      expected: [],
      got: None,
    })
  };
};

let interpolatable = (~type_path as _, inner_rule, values) => {
  let interp_rule =
    Pattern.component(
      fun
      | (Ast.Variable(name, _loc), _) => Ok(`Interpolation(name))
      | _ => err_kind("value"),
    );
  switch (interp_rule(values)) {
  | (Ok(_) as result, rest) => (result, rest)
  | (Error(_), _) =>
    let (result, rest) = inner_rule(values);
    switch (result) {
    | Ok(value) => (Ok(`Value(value)), rest)
    | Error(msgs) => (Error(msgs), values)
    };
  };
};

/* === Serialization (only called at edges) === */

let expected_to_string =
  fun
  | Keyword(s) => s
  | TokenKind(s) => s
  | Function(s) => s ++ "()"
  | Description(s) => s;

let max_expected_values = 8;

let is_vendor_prefixed = s => String.length(s) > 0 && s.[0] == '-';

let expected_priority =
  fun
  | TokenKind(_) => 0
  | Function(_) => 1
  | Keyword(s) when !is_vendor_prefixed(s) => 2
  | Keyword(_) => 3
  | Description(_) => 4;

let compare_expected = (a, b) => {
  let pa = expected_priority(a);
  let pb = expected_priority(b);
  if (pa != pb) {
    Int.compare(pa, pb);
  } else {
    String.compare(expected_to_string(a), expected_to_string(b));
  };
};

let format_expected = (expected: list(expected)) => {
  let values =
    expected
    |> List.filter(
         fun
         | Description(_) => false
         | _ => true,
       )
    |> List.sort_uniq(compare_expected)
    |> List.map(expected_to_string);

  switch (values) {
  | [] => ""
  | values =>
    let count = List.length(values);
    let (shown, has_more) =
      if (count > max_expected_values) {
        (List.filteri((i, _) => i < max_expected_values, values), true);
      } else {
        (values, false);
      };
    let shown = shown |> List.map(v => "'" ++ v ++ "'");
    let joined =
      switch (shown) {
      | [] => ""
      | [single] => single
      | _ when has_more => String.concat(", ", shown) ++ ", etc."
      | [first, second] => first ++ " or " ++ second
      | _ =>
        let rec format_list = lst =>
          switch (lst) {
          | [] => ""
          | [last] => "or " ++ last
          | [item, ...items] => item ++ ", " ++ format_list(items)
          };
        format_list(shown);
      };
    "Expected " ++ joined;
  };
};

let find_suggestion = (got_str: string, expected: list(expected)) => {
  let candidates =
    expected
    |> List.filter_map(
         fun
         | Keyword(s) => Some(s)
         | TokenKind(s) => Some(s)
         | Function(s) => Some("function " ++ s)
         | Description(_) => None,
       );
  Levenshtein.find_closest_match(got_str, candidates);
};

let format_error_info = (info: error_info): string => {
  let expected_str = format_expected(info.expected);
  let got_str =
    switch (info.got) {
    | Some(v) => Render.component_value(v)
    | None => "the provided value"
    };
  let base =
    switch (expected_str) {
    | "" => "Expected a valid value."
    | s when String.ends_with(~suffix=".", s) => s
    | s => s ++ "."
    };
  switch (find_suggestion(got_str, info.expected)) {
  | Some(suggestion) => base ++ " Did you mean '" ++ suggestion ++ "'?"
  | None => base
  };
};
