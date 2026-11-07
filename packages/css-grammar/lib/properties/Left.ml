open Types
open Support

module Property_left =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'auto'", (module Css_types.Left)]

let property_left : property_left Rule.rule = Property_left.rule

let entries : (kind * packed_rule) list =
  [ Property "left", pack_module (module Property_left) ]
