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
    | Selector(with_loc(Selector.t))
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
    | Variable(list(string));
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
    prelude: with_loc(Selector.t),
    block: Declaration_list.t,
    loc: Location.t,
  };
} = Style_rule
and Rule: {
  type t =
    | Style_rule(Style_rule.t)
    | At_rule(At_rule.t);
} = Rule
and Stylesheet: {
  type t = with_loc(list(Rule.t));
} = Stylesheet
and Selector: {
  type t =
    | SimpleSelector(list(simple_selector))
    | ComplexSelector(list(complex_selector))
    | CompoundSelector(list(compound_selector))
  and complex_selector =
    | Selector(compound_selector)
    | Combinator({
        left: compound_selector,
        right: list((option(string), compound_selector)),
      })
  and compound_selector = {
    type_selector: option(simple_selector),
    subclass_selectors: list(subclass_selector),
    pseudo_selectors:
      list(
        (pseudo_selector, list(pseudo_selector)),
      ),
  }
  and simple_selector =
    | Universal
    | Ampersand
    | Type(string)
    | Subclass(subclass_selector)
    | Variable(list(string))
  and subclass_selector =
    | Id(string)
    | Class(string)
    | Attribute(attribute_selector)
    | Pseudo_class(pseudo_selector)
  and attribute_selector =
    | Attr_value(string)
    | To_equal({
        name: string,
        kind: string,
        value: attr_value,
      })
  and attr_value =
    | Attr_ident(string)
    | Attr_string(string)
  and pseudo_selector =
    | Pseudoelement(string)
    | Pseudoclass(pseudoclass_kind)
  and pseudoclass_kind =
    | Ident(string)
    | Function({
        name: string,
        payload: with_loc(t),
      });
} = Selector;
