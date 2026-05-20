open Types
open Support

module Property_lighting_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_lighting_color : property_lighting_color Rule.rule =
  Property_lighting_color.rule

let entries : (kind * packed_rule) list =
  [ Property "lighting-color", pack_module (module Property_lighting_color) ]
