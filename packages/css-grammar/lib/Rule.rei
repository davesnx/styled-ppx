module Tokens = Styled_ppx_css_parser.Tokens;

/*
   A rule is a function that maps a list of tokens into a tuple where
   the left side will be a output made from some tokens consumed and
   the right side will be the tokens that were not consumed
 */

type error = list(string);
type data('a) = result('a, error);
type rule('a) = list(Tokens.t) => (data('a), list(Tokens.t));

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

/*
   `Data` is the representation of the a rule output, where if the transformation was succeed, it will
   return `Ok(value)` with value being defined by the function (The [%value.rec] ppx generates polymorphic variants based on the CSS Spec)
   and if it fails it will return `Error(reasons)` where reasons is a list of string. The module also exposes functions to create and use `Data`
 */
module Data: {
  let return: return('a, data('a));
  let bind: bind('a, data('a), 'b);
  let map: map('a, data('a), data('b), 'b);
  let bind_shortest: best('a, data('a), 'b, data('b), 'c);
  let bind_longest: best('a, data('a), 'b, data('b), 'c);
};

/*
   Match operates on `Data`, it deals with cases where Data transformation in a rule went successful
   matching over the results and offering functions to manipulate the result
 */
module Match: {
  let return: return('a, 'a);
  let bind: bind('a, 'a, 'b);
  let map: map('a, 'a, 'b, 'b);
  let bind_shortest: best('a, 'a, 'b, 'b, 'c);
  let bind_longest: best('a, 'a, 'b, 'b, 'c);
  let all: list(rule('a)) => rule(list('a));
};

// Module to expose monadic let operators
module Let: {
  let return_data: return('a, data('a));
  let (let.bind_data): bind('a, data('a), 'b);
  let (let.map_data): map('a, data('a), data('b), 'b);
  let (let.bind_shortest_data): best('a, data('a), 'b, data('b), 'c);
  let (let.bind_longest_data): best('a, data('a), 'b, data('b), 'c);

  let return_match: return('a, 'a);
  let (let.bind_match): bind('a, 'a, 'b);
  let (let.map_match): map('a, 'a, 'b, 'b);
  let (let.bind_shortest_match): best('a, 'a, 'b, 'b, 'c);
  let (let.bind_longest_match): best('a, 'a, 'b, 'b, 'c);
};

/*
   Pattern is a helper module with functions to make tokens consumption easier
 */
module Pattern: {
  let identity: rule(unit);
  let next: rule(Tokens.t);
  let token: (Tokens.t => data('a)) => rule('a);
  let expect: Tokens.t => rule(unit);
  let value: ('a, rule(unit)) => rule('a);
};

/* Parse a string input using a rule, returning Ok(value) or Error(message) */
let parse_string: (rule('a), string) => result('a, string);
