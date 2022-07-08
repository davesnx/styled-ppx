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
    | Selector(list(with_loc(t)))
    | Uri(string)
    | Operator(string)
    | Combinator(string)
    | Delim(string)
    | Function(with_loc(string), with_loc(list(with_loc(t))))
    | Pseudoclass(with_loc(string))
    | PseudoclassFunction(with_loc(string), with_loc(list(with_loc(t))))
    | Pseudoelement(with_loc(string))
    | Hash(string)
    | Number(string)
    | Unicode_range(string)
    | Float_dimension((string, string, dimension))
    | Dimension((string, string))
    | Variable(list(string))
    | Ampersand;
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
    | Unsafe(Declaration.t)
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
and Stylesheet: {type t = with_loc(list(Rule.t));} = Stylesheet

and Selector: {
  type complex_selector =
    | Selector(compound_selector)
    | Combinator({
      left: complex_selector,
      combinator,
      right: compound_selector
    })
    and compound_selector = {
      type_selector: option(string),
      subclass_selectors: list(subclass_selector),
      pseudo_selectors: list(pseudo_selector),
    }
    and combinator = string
    and subclass_selector =
    | Id(string)
    | Class(string)
    | Attribute(attribute_selector)
    and attribute_selector =
      | Attr_value(string)
      | To_equal({
        name: string,
        kind: string,
        value: string,
      })
    and pseudo_selector =
      | Pseudoelement(string)
      | Pseudoclass(pseudoclass_kind)
    and pseudoclass_kind =
      | Ident(string)
      | Function({
        name: string,
        payload: list(with_loc(Component_value.t))
      })
} = Selector

/*
[@deriving show]
type complex_selector =
  | Selector(compound_selector)
  | Combinator({
      left: complex_selector,
      combinator,
      right: compound_selector,
    })
and compound_selector = {
  type_selector: option(string),
  subclass_selectors: list(subclass_selector),
  pseudo_selectors: list(pseudo_selector),
}
and subclass_selector =
  | Id(string)
  | Class(string)
  | Attribute(attribute_selector)
and attribute_selector =
  | Exists(string)
  | To_equal({
      name: string,
      kind: option([ | `Asterisk | `Caret | `Dollar | `Pipe | `Tilde]),
      value: string,
      modifier: option([ | `i | `s]),
    })
and pseudo_selector =
  | Pseudo_class(pseudo_selector_kind)
  | Pseudo_element(pseudo_selector_kind)
and pseudo_selector_kind =
  | Ident(string)
  | Function({
      name: string,
      payload: list(token),
    })
and combinator =
  | Juxtaposition
  | Greater
  | Plus
  | Tilde; */
