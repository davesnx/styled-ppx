/* We have records with identical field names. Type inference can sometimes struggle to determine which field you're referring to. This ambiguity can lead to compiler warnings or errors, we disable it with -30 because we always construct this with annotations. */
[@warning "-30"];

[@deriving show({ with_path: false })]
type position =
  Lexing.position = {
    pos_fname: string,
    pos_lnum: int,
    pos_bol: int,
    pos_cnum: int,
  };

[@deriving show({ with_path: false })]
type loc =
  Ppxlib.Location.t = {
    loc_start: position,
    loc_end: position,
    loc_ghost: bool,
  };

let location = (fmt, loc: Ppxlib.location) =>
  Format.pp_print_string(
    fmt,
    Format.sprintf(
      "start %d %d %d (L:%d c:%d) end %d %d %d (L:%d c:%d)",
      loc.loc_start.pos_lnum,
      loc.loc_start.pos_bol,
      loc.loc_start.pos_cnum,
      loc.loc_start.pos_lnum,
      loc.loc_start.pos_cnum - loc.loc_start.pos_bol,
      loc.loc_end.pos_lnum,
      loc.loc_end.pos_bol,
      loc.loc_end.pos_cnum,
      loc.loc_end.pos_lnum,
      loc.loc_end.pos_cnum - loc.loc_end.pos_bol,
    ),
  );

[@deriving show({ with_path: false })]
type with_loc('a) = ('a, [@printer location] loc);

[@deriving show({ with_path: false })]
type declaration = {
  name: with_loc(string),
  value: with_loc(component_value_list),
  important: with_loc(bool),
  [@printer location]
  loc,
}
[@deriving show({ with_path: false })]
and component_value_list = list(with_loc(component_value))
[@deriving show({ with_path: false })]
and component_value =
  | Whitespace
  | Paren_block(component_value_list)
  | Bracket_block(component_value_list)
  | Percentage(float)
  | Ident(string)
  | String(string)
  | Selector(selector_list)
  | Uri(string)
  | Delim(string)
  | Function(with_loc(string), with_loc(component_value_list))
  | Hash(string)
  | Number(float)
  | Unicode_range(string)
  | Dimension((float, string))
  | Variable(list(string))
[@deriving show({ with_path: false })]
and brace_block =
  | Empty
  | Rule_list(rule_list)
  | Stylesheet(stylesheet)
[@deriving show({ with_path: false })]
and at_rule = {
  name: with_loc(string),
  prelude: with_loc(component_value_list),
  block: brace_block,
  [@printer location]
  loc,
}
[@deriving show({ with_path: false })]
and rule_list = with_loc(list(rule))
[@deriving show({ with_path: false })]
and rule =
  | Declaration(declaration)
  | Style_rule(style_rule)
  | At_rule(at_rule)
[@deriving show({ with_path: false })]
and style_rule = {
  prelude: with_loc(selector_list),
  block: rule_list,
  [@printer location]
  loc,
}
[@deriving show({ with_path: false })]
and stylesheet = with_loc(list(rule))
[@deriving show({ with_path: false })]
and selector =
  | SimpleSelector(simple_selector)
  | ComplexSelector(complex_selector)
  | CompoundSelector(compound_selector)
  | RelativeSelector(relative_selector)
[@deriving show({ with_path: false })]
and selector_list = list(with_loc(selector))
[@deriving show({ with_path: false })]
and complex_selector =
  | Selector(selector)
  | Combinator({
      left: selector,
      right: list((option(string), selector)),
    })
[@deriving show({ with_path: false })]
and compound_selector = {
  type_selector: option(simple_selector),
  subclass_selectors: list(subclass_selector),
  pseudo_selectors: list(pseudo_selector) /* TODO: (string, pseudoclass_kind) */
}
[@deriving show({ with_path: false })]
and relative_selector = {
  combinator: option(string),
  complex_selector,
}
[@deriving show({ with_path: false })]
and simple_selector =
  | Universal
  | Ampersand
  | Type(string)
  | Subclass(subclass_selector)
  | Variable(list(string))
  | Percentage(float)
[@deriving show({ with_path: false })]
and subclass_selector =
  | Id(string)
  | Class(string)
  | ClassVariable(list(string))
  | Attribute(attribute_selector)
  | Pseudo_class(pseudo_selector)
[@deriving show({ with_path: false })]
and attr_matcher =
  | Attr_exact
  | Attr_member
  | Attr_prefix_dash
  | Attr_prefix
  | Attr_suffix
  | Attr_substring
[@deriving show({ with_path: false })]
and attribute_selector =
  | Attr_value(string)
  | To_equal({
      name: string,
      kind: attr_matcher,
      value: attr_value,
    })
[@deriving show({ with_path: false })]
and attr_value =
  | Attr_ident(string)
  | Attr_string(string)
[@deriving show({ with_path: false })]
and pseudo_selector =
  | Pseudoelement(string)
  | Pseudoclass(pseudoclass_kind)
[@deriving show({ with_path: false })]
and pseudoclass_kind =
  | PseudoIdent(string)
  | Function({
      name: string,
      payload: with_loc(selector_list),
    })
  | NthFunction({
      name: string,
      payload: with_loc(nth_payload),
    })
[@deriving show({ with_path: false })]
and nth_payload =
  | Nth(nth)
  | NthSelector(list(complex_selector))
[@deriving show({ with_path: false })]
and nth =
  | Even
  | Odd
  | A(int)
  | AN(int)
  | ANB(int, string, int);
