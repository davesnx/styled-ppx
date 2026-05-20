open Types
open Support

module Property_will_change =
  [%spec_module
  "'auto' | [ <animateable-feature> ]#", (module Css_types.WillChange)]

let property_will_change : property_will_change Rule.rule =
  Property_will_change.rule

let entries : (kind * packed_rule) list =
  [ Property "will-change", pack_module (module Property_will_change) ]
