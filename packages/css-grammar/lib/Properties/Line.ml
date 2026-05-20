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

let entries : (kind * packed_rule) list =
  [
    Property "line-clamp", pack_module (module Property_line_clamp);
    Property "line-height-step", pack_module (module Property_line_height_step);
    Property "line-height", pack_module (module Property_line_height);
    Property "line-break", pack_module (module Property_line_break);
  ]
