module Tokens = Styled_ppx_css_parser.Tokens;

type error = list(string);
type data('a) = result('a, error);
type rule('a) = list(Tokens.t) => (data('a), list(Tokens.t));

/* Interpolation tracking - used during parsing to record found interpolations with their types */
module Interpolations = {
  let found: ref(list((string, string))) = ref([]);

  let reset = () => found := [];

  let record = (var_name: string, type_path: string) =>
    found := [(var_name, type_path), ...found^];

  let get = () => List.rev(found^);
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
    ((left, right), f) => bind_shortest_or_longest(true, (left, right), f);
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

/*
   `interpolatable` wraps a rule to make it accept interpolations.
   When an interpolation $(var) is encountered, it records (var, type_path)
   and returns `Interpolation. Otherwise delegates to the inner rule and
   wraps the result in `Value.

   This allows the parser to track what types interpolations should have
   based on their position in the grammar.
 */
let interpolatable =
    (~type_path: string, rule: rule('a))
    : rule(
        [>
          | `Interpolation(list(string))
          | `Value('a)
        ],
      ) =>
  tokens => {
    switch (tokens) {
    | [INTERPOLATION(parts), ...remaining] =>
      let var_name = String.concat(".", parts);
      Interpolations.record(var_name, type_path);
      (Ok(`Interpolation(parts)), remaining);
    | _ =>
      let (result, remaining) = rule(tokens);
      let wrapped =
        switch (result) {
        | Ok(value) => Ok(`Value(value))
        | Error(e) => Error(e)
        };
      (wrapped, remaining);
    };
  };

/* TODO: Duplicated with Parser.parse */
/* Parse a string input using a rule, returning Ok(value) or Error(message) */
let parse_string = (rule: rule('a), input: string): result('a, string) => {
  open Styled_ppx_css_parser.Lexer;
  let tokens_with_loc = from_string(input);
  let tokens =
    tokens_with_loc
    |> List.map(({txt, _}) =>
         switch (txt) {
         | Ok(token) => token
         | Error((token, _)) => token
         }
       );
  let tokens_without_ws =
    tokens |> List.filter(token => token != Styled_ppx_css_parser.Parser.WS);
  switch (rule(tokens_without_ws)) {
  | (Ok(value), []) => Ok(value)
  | (Ok(value), [Styled_ppx_css_parser.Parser.EOF]) => Ok(value)
  | (Ok(_), _rest) => Error("Failed to parse CSS: tokens remaining")
  | (Error(err), _) => Error(String.concat(", ", err))
  };
};
