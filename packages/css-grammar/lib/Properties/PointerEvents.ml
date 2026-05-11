open Types
open Support

module Property_pointer_events =
  [%spec_module
  "'auto' | 'none' | 'visiblePainted' | 'visibleFill' | 'visibleStroke' | \
   'visible' | 'painted' | 'fill' | 'stroke' | 'all' | 'inherit'",
  (module Css_types.PointerEvents)]

let property_pointer_events : property_pointer_events Rule.rule =
  Property_pointer_events.rule

let entries : (kind * packed_rule) list =
  [ Property "pointer-events", pack_module (module Property_pointer_events) ]
