open Types
open Support

module Property_isolation =
  [%spec_module
  "'auto' | 'isolate'", (module Css_types.Isolation)]

let property_isolation : property_isolation Rule.rule = Property_isolation.rule

let entries : (kind * packed_rule) list =
  [
    Property "isolation", pack_module (module Property_isolation);
  ]
