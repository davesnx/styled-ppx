open Types
open Support

module Property_line_break =
  [%spec_module
  "'auto' | 'loose' | 'normal' | 'strict' | 'anywhere' | <interpolation>",
  (module Css_types.LineBreak)]

let property_line_break : property_line_break Rule.rule =
  Property_line_break.rule

module Property_line_clamp =
  [%spec_module
  "'none' | <integer>", (module Css_types.LineClamp)]

let property_line_clamp : property_line_clamp Rule.rule =
  Property_line_clamp.rule

module Property_line_height =
  [%spec_module
  "'normal' | <number> | <extended-length> | <extended-percentage>",
  (module Css_types.LineHeight)]

let property_line_height : property_line_height Rule.rule =
  Property_line_height.rule

module Property_line_height_step =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_line_height_step : property_line_height_step Rule.rule =
  Property_line_height_step.rule

(* CSS Inline Layout L3: https://drafts.csswg.org/css-inline-3/#propdef-line-fit-edge
   Reuses Css_types.TextBoxEdge - same flattened <text-edge> value set as the
   existing text-box-edge (Text.ml), which already includes 'leading'. *)
module Property_line_fit_edge =
  [%spec_module
  "'leading' | 'text' | 'cap' | 'ex' | 'alphabetic'",
  (module Css_types.TextBoxEdge)]

let property_line_fit_edge : property_line_fit_edge Rule.rule =
  Property_line_fit_edge.rule

let entries : (kind * packed_rule) list =
  [
    Property "line-clamp", pack_module (module Property_line_clamp);
    Property "line-height-step", pack_module (module Property_line_height_step);
    Property "line-height", pack_module (module Property_line_height);
    Property "line-break", pack_module (module Property_line_break);
    Property "line-fit-edge", pack_module (module Property_line_fit_edge);
  ]
