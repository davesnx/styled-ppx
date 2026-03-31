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
type delimiter =
  | Delimiter_colon
  | Delimiter_double_colon
  | Delimiter_comma
  | Delimiter_dot
  | Delimiter_asterisk
  | Delimiter_ampersand
  | Delimiter_plus
  | Delimiter_minus
  | Delimiter_tilde
  | Delimiter_greater_than
  | Delimiter_less_than
  | Delimiter_equals
  | Delimiter_slash
  | Delimiter_exclamation
  | Delimiter_pipe
  | Delimiter_caret
  | Delimiter_dollar_sign
  | Delimiter_question_mark
  | Delimiter_hash
  | Delimiter_at
  | Delimiter_percent
  | Delimiter_underscore
  | Delimiter_gte
  | Delimiter_lte
  | Delimiter_other(string);

[@deriving show({ with_path: false })]
type length_unit =
  | Length_unit_cap
  | Length_unit_ch
  | Length_unit_em
  | Length_unit_ex
  | Length_unit_ic
  | Length_unit_lh
  | Length_unit_rcap
  | Length_unit_rch
  | Length_unit_rem
  | Length_unit_rex
  | Length_unit_ric
  | Length_unit_rlh
  | Length_unit_vh
  | Length_unit_vw
  | Length_unit_vmax
  | Length_unit_vmin
  | Length_unit_vb
  | Length_unit_vi
  | Length_unit_cqw
  | Length_unit_cqh
  | Length_unit_cqi
  | Length_unit_cqb
  | Length_unit_cqmin
  | Length_unit_cqmax
  | Length_unit_px
  | Length_unit_cm
  | Length_unit_mm
  | Length_unit_q
  | Length_unit_in
  | Length_unit_pc
  | Length_unit_pt
and angle_unit =
  | Angle_unit_deg
  | Angle_unit_grad
  | Angle_unit_rad
  | Angle_unit_turn
and time_unit =
  | Time_unit_s
  | Time_unit_ms
and frequency_unit =
  | Frequency_unit_hz
  | Frequency_unit_khz
and resolution_unit =
  | Resolution_unit_dpi
  | Resolution_unit_dpcm
  | Resolution_unit_dppx
and flex_unit =
  | Flex_unit_fr
and dimension_kind =
  | Dimension_length(length_unit)
  | Dimension_angle(angle_unit)
  | Dimension_time(time_unit)
  | Dimension_frequency(frequency_unit)
  | Dimension_resolution(resolution_unit)
  | Dimension_flex(flex_unit)
  | Dimension_unknown
and dimension = {
  value: float,
  unit: string,
  kind: dimension_kind,
};

[@deriving show({ with_path: false })]
type hash_kind =
  | Hash_kind_id
  | Hash_kind_unrestricted;

[@deriving show({ with_path: false })]
type function_kind =
  | Function_kind_regular
  | Function_kind_nth;

[@deriving show({ with_path: false })]
type selector_combinator =
  | Selector_descendant
  | Selector_child
  | Selector_adjacent_sibling
  | Selector_general_sibling;

[@deriving show({ with_path: false })]
type declaration = {
  name: with_loc(string),
  value: with_loc(component_value_list),
  important: with_loc(bool),
  [@printer location]
  loc,
}
[@deriving show({ with_path: false })]
and component_function = {
  name: with_loc(string),
  kind: function_kind,
  body: with_loc(component_value_list),
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
  | Delim(delimiter)
  | Function(component_function)
  | Hash((string, hash_kind))
  | Number(float)
  | Unicode_range(string)
  | Dimension(dimension)
  | Variable(string, loc)
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
      right: list((selector_combinator, selector)),
    })
[@deriving show({ with_path: false })]
and compound_selector = {
  type_selector: option(simple_selector),
  subclass_selectors: list(subclass_selector),
  pseudo_selectors: list(pseudo_selector) /* TODO: (string, pseudoclass_kind) */
}
[@deriving show({ with_path: false })]
and relative_selector = {
  combinator: option(selector_combinator),
  complex_selector,
}
[@deriving show({ with_path: false })]
and simple_selector =
  | Universal
  | Ampersand
  | Type(string)
  | Subclass(subclass_selector)
  | Variable(string, loc)
  | Percentage(float)
[@deriving show({ with_path: false })]
and subclass_selector =
  | Id(string)
  | Class(string)
  | ClassVariable(string, loc)
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
