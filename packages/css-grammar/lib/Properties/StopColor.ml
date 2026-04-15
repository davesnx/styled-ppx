open Types
open Support
module Property_stop_color = [%spec_module "<color>", (module Css_types.Color)]

let property_stop_color : property_stop_color Rule.rule =
  Property_stop_color.rule

let entries : (kind * packed_rule) list =
  [ Property "stop-color", pack_module (module Property_stop_color) ]
