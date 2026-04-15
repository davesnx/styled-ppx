open Types
open Support

module Property_bottom =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'auto'",
  (module Css_types.Bottom)]

let property_bottom : property_bottom Rule.rule = Property_bottom.rule

let entries : (kind * packed_rule) list =
  [ Property "bottom", pack_module (module Property_bottom) ]
