open Types
open Support

module Property_right =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'auto'", (module Css_types.Right)]

let property_right : property_right Rule.rule = Property_right.rule

let entries : (kind * packed_rule) list =
  [ Property "right", pack_module (module Property_right) ]
