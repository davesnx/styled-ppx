open Types
open Support

module Property_d =
  [%spec_module
  "'none' | <string>", (module Css_types.Cascading)]

let property_d : property_d Rule.rule = Property_d.rule

let entries : (kind * packed_rule) list =
  [ Property "d", pack_module (module Property_d) ]
