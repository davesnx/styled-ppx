open Types
open Support

module Property_float =
  [%spec_module
  "'left' | 'right' | 'none' | 'inline-start' | 'inline-end'",
  (module Css_types.Float)]

let property_float : property_float Rule.rule = Property_float.rule

let entries : (kind * packed_rule) list =
  [
    Property "float", pack_module (module Property_float);
  ]
