open Types
open Support

module Property_aspect_ratio =
  [%spec_module
  "'auto' | <ratio>", (module Css_types.AspectRatio)]

let property_aspect_ratio : property_aspect_ratio Rule.rule =
  Property_aspect_ratio.rule

let entries : (kind * packed_rule) list =
  [ Property "aspect-ratio", pack_module (module Property_aspect_ratio) ]
