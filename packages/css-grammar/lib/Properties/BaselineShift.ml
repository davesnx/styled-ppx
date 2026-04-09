open Types
open Support

module Property_baseline_shift =
  [%spec_module
  "'baseline' | 'sub' | 'super' | <svg-length>",
  (module Css_types.BaselineShift)]

let property_baseline_shift : property_baseline_shift Rule.rule =
  Property_baseline_shift.rule

let entries : (kind * packed_rule) list =
  [ Property "baseline-shift", pack_module (module Property_baseline_shift) ]
