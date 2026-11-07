open Types
open Support

module Property_scale =
  [%spec_module
  "'none' | [ <number-percentage> ]{1,3}", (module Css_types.Scale)]

let property_scale : property_scale Rule.rule = Property_scale.rule

let entries : (kind * packed_rule) list =
  [ Property "scale", pack_module (module Property_scale) ]
