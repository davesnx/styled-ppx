open Types
open Support

module Property_vertical_align =
  [%spec_module
  "'baseline' | 'sub' | 'super' | 'text-top' | 'text-bottom' | 'middle' | \
   'top' | 'bottom' | <extended-percentage> | <extended-length>",
  (module Css_types.VerticalAlign)]

let property_vertical_align : property_vertical_align Rule.rule =
  Property_vertical_align.rule

let entries : (kind * packed_rule) list =
  [ Property "vertical-align", pack_module (module Property_vertical_align) ]
