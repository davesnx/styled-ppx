open Types
open Support

module Property_touch_action =
  [%spec_module
  "'auto' | 'none' | [ 'pan-x' | 'pan-left' | 'pan-right' ] || [ 'pan-y' | \
   'pan-up' | 'pan-down' ] || 'pinch-zoom' | 'manipulation'",
  (module Css_types.TouchAction)]

let property_touch_action : property_touch_action Rule.rule =
  Property_touch_action.rule

let entries : (kind * packed_rule) list =
  [ Property "touch-action", pack_module (module Property_touch_action) ]
