module Tokens = Styled_ppx_css_parser.Tokens;

type error = list(string);
type data('a) = result('a, error);
type rule('a) = list(Tokens.token) => (data('a), list(Tokens.token));

/* Interpolation tracking - used during parsing to record found interpolations with their types */
module Interpolations = {
  let store: ref(list((string, string))) = ref([]);
  let reset = () => store := [];
  let record = (name, type_path) => store := [(name, type_path), ...store^];
  let get = () => List.rev(store^);
};

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

// monad to deal with tokens
module Data = {
  let return = (data, tokens) => (data, tokens);
  let bind = (rule, f, tokens) => {
    let (data, remaining_tokens) = rule(tokens);
    // TODO: maybe combinators should guarantee that
    switch (data) {
    | Ok(d) => f(Ok(d), remaining_tokens)
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
      ((left, right), f) =>
    bind_shortest_or_longest(true, (left, right), f);
  let bind_longest: best('a, data('a), 'b, data('b), 'c) =
      ((left, right), f) =>
    bind_shortest_or_longest(false, (left, right), f);
};

// monad when match is successful
module Match = {
  let return = (value, tokens) => Data.return(Ok(value), tokens);
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

  let rec all = rules => {
    switch (rules) {
    | [] => return([])
    | [hd_rule, ...tl_rules] =>
      bind(hd_rule, hd => {bind(all(tl_rules), tl => {return([hd, ...tl])})})
    };
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
  // TODO: errors
  let identity = Match.return();

  let next =
    fun
    | [token, ...tokens] => Match.return(token, tokens)
    | _ => (Error(["missing the token expected"]), []);

  let token = (expected, tokens) =>
    switch (tokens) {
    | [token, ...tokens] =>
      let data = expected(token);
      // if failed then keep the tokens intact
      let tokens = Result.is_ok(data) ? tokens : [token, ...tokens];
      (data, tokens);
    | [] => (Error(["missing the token expected"]), [])
    };

  let expect = expected =>
    token(
      fun
      | token when token == expected => Ok()
      | token =>
        Error([
          "Expected '"
          ++ Tokens.humanize(expected)
          ++ "' but instead got "
          ++ "'"
          ++ Tokens.humanize(token)
          ++ "'.",
        ]),
    );

  let value = (value, rule) => Match.bind(rule, () => Match.return(value));
};

module Css_lexer = Styled_ppx_css_parser.Lexer;

let parse_string = (rule_parser, input) => {
  let tokens_with_loc =
    Css_lexer.from_string(
      ~initial_mode=Styled_ppx_css_parser.Lexer_context.Declaration_value,
      input,
    );
  let tokens =
    tokens_with_loc
    |> List.filter_map(({ txt, _ }: Css_lexer.token_with_location) =>
         switch (txt) {
         | Ok(token) => Some(token)
         | Error(_) => None
         }
       )
    |> List.rev;
  let tokens_without_ws = tokens |> List.filter(t => t != Tokens.WS);
  let (output, remaining_tokens) = rule_parser(tokens_without_ws);
  switch (output) {
  | Ok(data) =>
    let remaining = remaining_tokens |> List.filter(t => t != Tokens.WS);
    switch (remaining) {
    | []
    | [Tokens.EOF] => Ok(data)
    | tokens =>
      let token_strs =
        tokens |> List.map(Tokens.show_token) |> String.concat(", ");
      Error("tokens remaining: " ++ token_strs);
    };
  | Error([message, ..._]) => Error(message)
  | Error([]) => Error("unexpected parse error")
  };
};

/*
   `interpolatable` wraps a rule to make it accept interpolations.
   When an interpolation $(var) is encountered, it records (var, type_path)
   and returns `Interpolation. Otherwise delegates to the inner rule and
   wraps the result in `Value.
 */
let interpolatable = (~type_path, inner_rule, tokens) => {
  let interp_rule =
    Pattern.token(
      fun
      | Tokens.INTERPOLATION((name, _loc)) => {
          Interpolations.record(name, type_path);
          Ok(`Interpolation(name));
        }
      | _ => Error(["Expected value."]),
    );
  switch (interp_rule(tokens)) {
  | (Ok(_) as result, rest) => (result, rest)
  | (Error(_), _) =>
    let (result, rest) = inner_rule(tokens);
    switch (result) {
    | Ok(value) => (Ok(`Value(value)), rest)
    | Error(msgs) => (Error(msgs), tokens)
    };
  };
};
