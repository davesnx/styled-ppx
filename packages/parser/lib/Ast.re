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
  | Delimiter_lte;

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

/* --- Dimension unit classifiers --- */

let length_unit_of_string =
  fun
  | "cap" => Some(Length_unit_cap)
  | "ch" => Some(Length_unit_ch)
  | "em" => Some(Length_unit_em)
  | "ex" => Some(Length_unit_ex)
  | "ic" => Some(Length_unit_ic)
  | "lh" => Some(Length_unit_lh)
  | "rcap" => Some(Length_unit_rcap)
  | "rch" => Some(Length_unit_rch)
  | "rem" => Some(Length_unit_rem)
  | "rex" => Some(Length_unit_rex)
  | "ric" => Some(Length_unit_ric)
  | "rlh" => Some(Length_unit_rlh)
  | "vh" => Some(Length_unit_vh)
  | "vw" => Some(Length_unit_vw)
  | "vmax" => Some(Length_unit_vmax)
  | "vmin" => Some(Length_unit_vmin)
  | "vb" => Some(Length_unit_vb)
  | "vi" => Some(Length_unit_vi)
  | "cqw" => Some(Length_unit_cqw)
  | "cqh" => Some(Length_unit_cqh)
  | "cqi" => Some(Length_unit_cqi)
  | "cqb" => Some(Length_unit_cqb)
  | "cqmin" => Some(Length_unit_cqmin)
  | "cqmax" => Some(Length_unit_cqmax)
  | "px" => Some(Length_unit_px)
  | "cm" => Some(Length_unit_cm)
  | "mm" => Some(Length_unit_mm)
  | "Q" => Some(Length_unit_q)
  | "in" => Some(Length_unit_in)
  | "pc" => Some(Length_unit_pc)
  | "pt" => Some(Length_unit_pt)
  | _ => None;

let angle_unit_of_string =
  fun
  | "deg" => Some(Angle_unit_deg)
  | "grad" => Some(Angle_unit_grad)
  | "rad" => Some(Angle_unit_rad)
  | "turn" => Some(Angle_unit_turn)
  | _ => None;

let time_unit_of_string =
  fun
  | "s" => Some(Time_unit_s)
  | "ms" => Some(Time_unit_ms)
  | _ => None;

let frequency_unit_of_string = unit =>
  switch (String.lowercase_ascii(unit)) {
  | "hz" => Some(Frequency_unit_hz)
  | "khz" => Some(Frequency_unit_khz)
  | _ => None
  };

let resolution_unit_of_string = unit =>
  switch (String.lowercase_ascii(unit)) {
  | "dpi" => Some(Resolution_unit_dpi)
  | "dpcm" => Some(Resolution_unit_dpcm)
  | "x"
  | "dppx" => Some(Resolution_unit_dppx)
  | _ => None
  };

let flex_unit_of_string =
  fun
  | "fr" => Some(Flex_unit_fr)
  | _ => None;

let dimension_kind_of_unit = unit =>
  switch (length_unit_of_string(unit)) {
  | Some(length_unit) => Dimension_length(length_unit)
  | None =>
    switch (angle_unit_of_string(unit)) {
    | Some(angle_unit) => Dimension_angle(angle_unit)
    | None =>
      switch (time_unit_of_string(unit)) {
      | Some(time_unit) => Dimension_time(time_unit)
      | None =>
        switch (frequency_unit_of_string(unit)) {
        | Some(frequency_unit) => Dimension_frequency(frequency_unit)
        | None =>
          switch (resolution_unit_of_string(unit)) {
          | Some(resolution_unit) => Dimension_resolution(resolution_unit)
          | None =>
            switch (flex_unit_of_string(unit)) {
            | Some(flex_unit) => Dimension_flex(flex_unit)
            | None => Dimension_unknown
            }
          }
        }
      }
    }
  };

let dimension_make = ((value, unit)): dimension => {
  value,
  unit,
  kind: dimension_kind_of_unit(unit),
};

/* --- Delimiter conversion functions --- */

let delimiter_of_string =
  fun
  | ":" => Some(Delimiter_colon)
  | "::" => Some(Delimiter_double_colon)
  | "," => Some(Delimiter_comma)
  | "." => Some(Delimiter_dot)
  | "*" => Some(Delimiter_asterisk)
  | "&" => Some(Delimiter_ampersand)
  | "+" => Some(Delimiter_plus)
  | "-" => Some(Delimiter_minus)
  | "~" => Some(Delimiter_tilde)
  | ">" => Some(Delimiter_greater_than)
  | "<" => Some(Delimiter_less_than)
  | "=" => Some(Delimiter_equals)
  | "/" => Some(Delimiter_slash)
  | "!" => Some(Delimiter_exclamation)
  | "|" => Some(Delimiter_pipe)
  | "^" => Some(Delimiter_caret)
  | "$" => Some(Delimiter_dollar_sign)
  | "?" => Some(Delimiter_question_mark)
  | "#" => Some(Delimiter_hash)
  | "@" => Some(Delimiter_at)
  | "%" => Some(Delimiter_percent)
  | "_" => Some(Delimiter_underscore)
  | ">=" => Some(Delimiter_gte)
  | "<=" => Some(Delimiter_lte)
  | _ => None;

let string_of_delimiter =
  fun
  | Delimiter_colon => ":"
  | Delimiter_double_colon => "::"
  | Delimiter_comma => ","
  | Delimiter_dot => "."
  | Delimiter_asterisk => "*"
  | Delimiter_ampersand => "&"
  | Delimiter_plus => "+"
  | Delimiter_minus => "-"
  | Delimiter_tilde => "~"
  | Delimiter_greater_than => ">"
  | Delimiter_less_than => "<"
  | Delimiter_equals => "="
  | Delimiter_slash => "/"
  | Delimiter_exclamation => "!"
  | Delimiter_pipe => "|"
  | Delimiter_caret => "^"
  | Delimiter_dollar_sign => "$"
  | Delimiter_question_mark => "?"
  | Delimiter_hash => "#"
  | Delimiter_at => "@"
  | Delimiter_percent => "%"
  | Delimiter_underscore => "_"
  | Delimiter_gte => ">="
  | Delimiter_lte => "<=";
