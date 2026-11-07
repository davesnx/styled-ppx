open Types
open Support
module Property_flood_color = [%spec_module "<color>", (module Css_types.Color)]

let property_flood_color : property_flood_color Rule.rule =
  Property_flood_color.rule

let entries : (kind * packed_rule) list =
  [ Property "flood-color", pack_module (module Property_flood_color) ]
