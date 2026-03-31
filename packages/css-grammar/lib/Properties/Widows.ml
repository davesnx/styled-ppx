open Types
open Support

module Property_widows = [%spec_module "<integer>", (module Css_types.Widows)]

let property_widows : property_widows Rule.rule = Property_widows.rule

let entries : (kind * packed_rule) list =
  [
    Property "widows", pack_module (module Property_widows);
  ]
