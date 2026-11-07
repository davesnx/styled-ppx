open Types
open Support

module Property_masonry_auto_flow =
  [%spec_module
  "[ 'pack' | 'next' ] || [ 'definite-first' | 'ordered' ]",
  (module Css_types.MasonryAutoFlow)]

let property_masonry_auto_flow : property_masonry_auto_flow Rule.rule =
  Property_masonry_auto_flow.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "masonry-auto-flow",
      pack_module (module Property_masonry_auto_flow) );
  ]
