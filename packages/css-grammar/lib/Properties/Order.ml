open Types
open Support
module Property_order = [%spec_module "<integer>", (module Css_types.Order)]

let property_order : property_order Rule.rule = Property_order.rule

let entries : (kind * packed_rule) list =
  [ Property "order", pack_module (module Property_order) ]
