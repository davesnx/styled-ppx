module Ast = Styled_ppx_css_parser.Ast;

type expected =
  | Keyword(string)
  | Token_kind(string)
  | Function(string)
  | Description(string);

type error_info = {
  expected: list(expected),
  got: option(Ast.component_value),
};

type error = list(error_info);
type data('value) = result('value, error);
type input = Ast.component_value_list;
type located_component_value = Ast.with_loc(Ast.component_value);
type rule('value) = input => (data('value), input);

type return('output, 'from) = 'from => rule('output);
type bind('first, 'cont, 'next) =
  (rule('first), 'cont => rule('next)) => rule('next);
type map('first, 'map_in, 'map_out, 'rule_out) =
  (rule('first), 'map_in => 'map_out) => rule('rule_out);
type best('left_in, 'left_ok, 'right_in, 'right_ok, 'out) =
  (
    (rule('left_in), rule('right_in)),
    [
      | `Left('left_ok)
      | `Right('right_ok)
    ] =>
    rule('out)
  ) =>
  rule('out);

let remaining_length: input => int;

/* Error construction helpers */
let err: (~got: Ast.component_value=?, list(expected)) => data('ignored);
let err_keyword: (string, located_component_value) => data('ignored);
let err_kind: string => data('ignored);
let err_kind_got: (string, located_component_value) => data('ignored);
let err_fn: (string, located_component_value) => data('ignored);
let err_desc: string => data('ignored);
let err_desc_got: (string, located_component_value) => data('ignored);

/* Error merging */
let merge_error_infos: list(error_info) => error_info;

module Data: {
  let return: return('value, data('value));
  let bind: bind('first, data('first), 'next);
  let map: map('first, data('first), data('next), 'next);
  let bind_shortest: best('left, data('left), 'right, data('right), 'out);
  let bind_longest: best('left, data('left), 'right, data('right), 'out);
};

module Match: {
  let return: return('value, 'value);
  let bind: bind('first, 'first, 'next);
  let map: map('first, 'first, 'next, 'next);
  let bind_shortest: best('left, 'left, 'right, 'right, 'out);
  let bind_longest: best('left, 'left, 'right, 'right, 'out);
  let all: list(rule('element)) => rule(list('element));
};

module Let: {
  let return_data: return('value, data('value));
  let (let.bind_data): bind('first, data('first), 'next);
  let (let.map_data): map('first, data('first), data('next), 'next);
  let (let.bind_shortest_data):
    best('left, data('left), 'right, data('right), 'out);
  let (let.bind_longest_data):
    best('left, data('left), 'right, data('right), 'out);

  let return_match: return('value, 'value);
  let (let.bind_match): bind('first, 'first, 'next);
  let (let.map_match): map('first, 'first, 'next, 'next);
  let (let.bind_shortest_match): best('left, 'left, 'right, 'right, 'out);
  let (let.bind_longest_match): best('left, 'left, 'right, 'right, 'out);
};

module Pattern: {
  let identity: rule(unit);
  let next: rule(located_component_value);
  let component: (located_component_value => data('value)) => rule('value);
  let expect_delim: Ast.delimiter => rule(unit);
  let value: ('literal, rule(unit)) => rule('literal);
};

let run: (rule('value), input) => result('value, error_info);

let interpolatable:
  (~type_path: string, rule('inner)) =>
  rule(
    [>
      | `Interpolation(string)
      | `Value('inner)
    ],
  );

/* Serialization (only called at edges) */
let expected_to_string: expected => string;
let format_expected: list(expected) => string;
let find_suggestion: (string, list(expected)) => option(string);
let format_error_info: error_info => string;
