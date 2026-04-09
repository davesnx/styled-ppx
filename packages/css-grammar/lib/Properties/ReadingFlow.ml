open Types
open Support

module Property_reading_flow =
  [%spec_module
  "'normal' | 'flex-visual' | 'flex-flow' | 'grid-rows' | 'grid-columns' | \
   'grid-order'",
  (module Css_types.ReadingFlow)]

let property_reading_flow : property_reading_flow Rule.rule =
  Property_reading_flow.rule

let entries : (kind * packed_rule) list =
  [ Property "reading-flow", pack_module (module Property_reading_flow) ]
