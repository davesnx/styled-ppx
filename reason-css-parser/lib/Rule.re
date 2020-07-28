open Reason_css_lexer;

type error = string;
type data('a) = result('a, error);
type rule('a) = list(token) => (data('a), list(token));

type return('a, 'b) = 'b => rule('a);
type bind('a, 'b, 'c) = (rule('a), 'b => rule('c)) => rule('c);
type map('a, 'b, 'c, 'd) = (rule('a), 'b => 'c) => rule('d);
type best('left_in, 'left_v, 'right_in, 'right_v, 'c) =
  (
    (rule('left_in), rule('right_in)),
    [ | `Left('left_v) | `Right('right_v)] => rule('c)
  ) =>
  rule('c);

// monad to deal with tokens
module Data = {
  let return = (data, tokens) => (data, tokens);
  let bind = (rule, f, tokens) => {
    let (data, remaining_tokens) = rule(tokens);
    // TODO: maybe combinators should guarantee that
    switch (data) {
    | Ok(data) => f(Ok(data), remaining_tokens)
    | Error(message) => f(Error(message), tokens)
    };
  };
  let map = (rule, f) => bind(rule, value => return(f(value)));
  let bind_shortest_or_longest = (shortest, (left, right), f, tokens) => {
    let (left_data, left_tokens) = left(tokens);
    let (right_data, right_tokens) = right(tokens);
    let op = shortest ? (>) : (<);
    let use_left = op(List.length(left_tokens), List.length(right_tokens));
    use_left
      ? f(`Left(left_data), left_tokens)
      : f(`Right(right_data), right_tokens);
  };
  let bind_shortest: best('a, data('a), 'b, data('b), 'c) =
    ((left, right), f) => bind_shortest_or_longest(true, (left, right), f);
  let bind_longest: best('a, data('a), 'b, data('b), 'c) =
    ((left, right), f) =>
      bind_shortest_or_longest(false, (left, right), f);
};

// monad when match is successful
module Match = {
  let return = value => Data.return(Ok(value));
  let bind = (rule, f) =>
    Data.bind(
      rule,
      fun
      | Ok(value) => f(value)
      | Error(error) => Data.return(Error(error)),
    );
  let map = (rule, f) => bind(rule, value => return(f(value)));
  let bind_shortest_or_longest = (shortest, (left, right), f, tokens) => {
    let (left_data, left_tokens) = left(tokens);
    let (right_data, right_tokens) = right(tokens);
    let op = shortest ? (>) : (<);
    let use_left = op(List.length(left_tokens), List.length(right_tokens));
    switch (left_data, right_data) {
    | (Ok(left_value), Error(_)) => f(`Left(left_value), left_tokens)
    | (Error(_), Ok(right_value)) => f(`Right(right_value), right_tokens)
    | (Ok(left_value), Ok(right_value)) =>
      use_left
        ? f(`Left(left_value), left_tokens)
        : f(`Right(right_value), right_tokens)
    | (Error(left_data), Error(right_data)) =>
      use_left
        ? Data.return(Error(left_data), left_tokens)
        : Data.return(Error(right_data), right_tokens)
    };
  };
  let bind_shortest = ((left, right), f) =>
    bind_shortest_or_longest(true, (left, right), f);
  let bind_longest = ((left, right), f) =>
    bind_shortest_or_longest(false, (left, right), f);
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
  // TODO: errors
  let identity = Match.return();
  let next =
    fun
    | [token, ...tokens] => Match.return(token, tokens)
    | _ => (Error("missing the token expected"), []);
  let token = (expected, tokens) =>
    switch (tokens) {
    | [token, ...tokens] =>
      let data = expected(token);
      // if failed then keep the tokens intact
      let tokens = Result.is_ok(data) ? tokens : [token, ...tokens];
      (data, tokens);
    | [] => (Error("missing the token expected"), [])
    };
  let expect = expected =>
    token(
      fun
      | token when token == expected => Ok()
      | _ => Error("expected " ++ show_token(expected)),
    );
  let value = (value, rule) => Match.bind(rule, () => Match.return(value));
};
