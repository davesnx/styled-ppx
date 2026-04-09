open Types
open Support

module Property_top =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'auto'", (module Css_types.Top)]

let property_top : property_top Rule.rule = Property_top.rule

let entries : (kind * packed_rule) list =
  [ Property "top", pack_module (module Property_top) ]
