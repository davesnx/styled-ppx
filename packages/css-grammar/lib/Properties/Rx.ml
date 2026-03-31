open Types
open Support

module Property_rx =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.LengthPercentage)]

let property_rx : property_rx Rule.rule = Property_rx.rule

let entries : (kind * packed_rule) list =
  [
    Property "rx", pack_module (module Property_rx);
  ]
