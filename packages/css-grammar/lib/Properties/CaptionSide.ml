open Types
open Support

module Property_caption_side =
  [%spec_module
  "'top' | 'bottom' | 'block-start' | 'block-end' | 'inline-start' | \
   'inline-end'",
  (module Css_types.CaptionSide)]

let property_caption_side : property_caption_side Rule.rule =
  Property_caption_side.rule

let entries : (kind * packed_rule) list =
  [ Property "caption-side", pack_module (module Property_caption_side) ]
