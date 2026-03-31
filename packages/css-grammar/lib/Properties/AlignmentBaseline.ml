open Types
open Support

module Property_alignment_baseline =
  [%spec_module
  "'auto' | 'baseline' | 'before-edge' | 'text-before-edge' | 'middle' | \
   'central' | 'after-edge' | 'text-after-edge' | 'ideographic' | 'alphabetic' \
   | 'hanging' | 'mathematical'",
  (module Css_types.AlignmentBaseline)]

let property_alignment_baseline : property_alignment_baseline Rule.rule =
  Property_alignment_baseline.rule

let entries : (kind * packed_rule) list =
  [
    Property "alignment-baseline", pack_module (module Property_alignment_baseline);
  ]
