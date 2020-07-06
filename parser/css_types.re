type with_loc('a) = ('a, Location.t);

type dimension =
  | Length
  | Angle
  | Time
  | Frequency;

module rec Component_value: {
  type t =
    | Paren_block(list(with_loc(t)))
    | Bracket_block(list(with_loc(t)))
    | Percentage(string)
    | Ident(string)
    | String(string)
    | Selector(string)
    | Uri(string)
    | Operator(string)
    | Delim(string)
    | Function(with_loc(string), with_loc(list(with_loc(t))))
    | Hash(string)
    | Number(string)
    | Unicode_range(string)
    | Float_dimension((string, string, dimension))
    | Dimension((string, string))
    | Variable(string)
    | TypedVariable((string, string));
} = Component_value
and Brace_block: {
  type t =
    | Empty
    | Declaration_list(Declaration_list.t)
    | Stylesheet(Stylesheet.t);
} = Brace_block
and At_rule: {
  type t = {
    name: with_loc(string),
    prelude: with_loc(list(with_loc(Component_value.t))),
    block: Brace_block.t,
    loc: Location.t,
  };
} = At_rule
and Declaration: {
  type t = {
    name: with_loc(string),
    value: with_loc(list(with_loc(Component_value.t))),
    important: with_loc(bool),
    loc: Location.t,
  };
} = Declaration
and Declaration_list: {
  type kind =
    | Declaration(Declaration.t)
    | At_rule(At_rule.t)
    | Style_rule(Style_rule.t);
  type t = with_loc(list(kind));
} = Declaration_list
and Style_rule: {
  type t = {
    prelude: with_loc(list(with_loc(Component_value.t))),
    block: Declaration_list.t,
    loc: Location.t,
  };
} = Style_rule
and Rule: {
  type t =
    | Style_rule(Style_rule.t)
    | At_rule(At_rule.t);
} = Rule
and Stylesheet: {type t = with_loc(list(Rule.t));} = Stylesheet;
