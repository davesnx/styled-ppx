open Types
open Support

module Property_clear =
  [%spec_module
  "'none' | 'left' | 'right' | 'both' | 'inline-start' | 'inline-end'",
  (module Css_types.Clear)]

let property_clear : property_clear Rule.rule = Property_clear.rule

let entries : (kind * packed_rule) list =
  [
    Property "clear", pack_module (module Property_clear);
  ]
