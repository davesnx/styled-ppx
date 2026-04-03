module Ast = Styled_ppx_css_parser.Ast;

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

let remaining_length: input => int;

/* Error construction helpers */
let err: (~got: Ast.component_value=?, list(expected)) => data('a);
let err_keyword: (string, located_component_value) => data('a);
let err_kind: string => data('a);
let err_kind_got: (string, located_component_value) => data('a);
let err_fn: (string, located_component_value) => data('a);
let err_desc: string => data('a);
let err_desc_got: (string, located_component_value) => data('a);

/* Error merging */
let merge_error_infos: list(error_info) => error_info;

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
  let all: list(rule('a)) => rule(list('a));
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
  let next: rule(located_component_value);
  let component: (located_component_value => data('a)) => rule('a);
  let expect_delim: Ast.delimiter => rule(unit);
  let value: ('a, rule(unit)) => rule('a);
};

let run: (rule('a), input) => result('a, error_info);

let interpolatable:
  (~type_path: string, rule('a)) =>
  rule(
    [>
      | `Interpolation(string)
      | `Value('a)
    ],
  );

/* Serialization (only called at edges) */
let expected_to_string: expected => string;
let format_expected: list(expected) => string;
let find_suggestion: (string, list(expected)) => option(string);
let format_error_info: error_info => string;
