let grammar_error: (Location.t, string) => 'a;
let split: (char, string) => list(string);
let is_variant: string => bool;
let to_caml_case: string => string;
let number_to_const: string => Parsetree.constant;
let float_to_const: string => Parsetree.constant;
let string_to_const: (~loc: Location.t, string) => Parsetree.expression;
let list_to_expr:
  (Location.t, list(Parsetree.expression)) => Parsetree.expression;
let group_params:
  list((Css_types.Component_value.t, Location.t)) =>
  list((list((Css_types.Component_value.t, Location.t)), Location.t));
let is_time: Css_types.Component_value.t => bool;
let is_timing_function: Css_types.Component_value.t => bool;
let is_animation_iteration_count: Css_types.Component_value.t => bool;
let is_animation_direction: Css_types.Component_value.t => bool;
let is_animation_fill_mode: Css_types.Component_value.t => bool;
let is_animation_play_state: Css_types.Component_value.t => bool;
let is_keyframes_name: Css_types.Component_value.t => bool;
let is_ident: (string, Css_types.Component_value.t) => bool;
let is_length: Css_types.Component_value.t => bool;
let is_color: Css_types.Component_value.t => bool;
let is_line_width: Css_types.Component_value.t => bool;
let is_line_style: Css_types.Component_value.t => bool;
let render_component_value:
  Css_types.with_loc(Css_types.Component_value.t) => Parsetree.expression;
let render_at_rule: Css_types.At_rule.t => Parsetree.expression;
let render_declaration:
  (Css_types.Declaration.t, Location.t) => Parsetree.expression;
let render_declarations:
  list(Css_types.Declaration_list.kind) => list(Parsetree.expression);
let render_declaration_list:
  Css_types.Declaration_list.t => Parsetree.expression;
let render_style_rule: Css_types.Style_rule.t => Parsetree.expression;
let render_rule: Css_types.Rule.t => Parsetree.expression;
