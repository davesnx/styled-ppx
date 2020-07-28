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

module Data: {
  let return: return('a, data('a));
  let bind: bind('a, data('a), 'b);
  let map: map('a, data('a), data('b), 'b);
  let bind_shortest: best('a, data('a), 'b, data('b), 'c);
  let bind_longest: best('a, data('a), 'b, data('b), 'c);
};

module Match: {
  let return: return('a, 'a);
  let bind: bind('a, 'a, 'b);
  let map: map('a, 'a, 'b, 'b);
  let bind_shortest: best('a, 'a, 'b, 'b, 'c);
  let bind_longest: best('a, 'a, 'b, 'b, 'c);
};

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

module Pattern: {
  let identity: rule(unit);
  let next: rule(token);
  let token: (token => data('a)) => rule('a);
  let expect: token => rule(unit);
  let value: ('a, rule(unit)) => rule('a);
};
