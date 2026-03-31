open Types
open Support

module Property_dominant_baseline =
  [%spec_module
  "'auto' | 'use-script' | 'no-change' | 'reset-size' | 'ideographic' | \
   'alphabetic' | 'hanging' | 'mathematical' | 'central' | 'middle' | \
   'text-after-edge' | 'text-before-edge'",
  (module Css_types.DominantBaseline)]

let property_dominant_baseline : property_dominant_baseline Rule.rule =
  Property_dominant_baseline.rule

let entries : (kind * packed_rule) list =
  [
    Property "dominant-baseline", pack_module (module Property_dominant_baseline);
  ]
