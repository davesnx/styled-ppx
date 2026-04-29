open Types
open Support

module Property_direction =
  [%spec_module
  "'ltr' | 'rtl'", (module Css_types.Direction)]

let property_direction : property_direction Rule.rule = Property_direction.rule

let entries : (kind * packed_rule) list =
  [ Property "direction", pack_module (module Property_direction) ]
