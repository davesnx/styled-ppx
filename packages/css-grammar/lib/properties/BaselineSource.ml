open Types
open Support

module Property_baseline_source =
  [%spec_module
  "'auto' | 'first' | 'last'", (module Css_types.Cascading)]

let property_baseline_source = Property_baseline_source.rule

let entries : (kind * packed_rule) list =
  [ Property "baseline-source", pack_module (module Property_baseline_source) ]
