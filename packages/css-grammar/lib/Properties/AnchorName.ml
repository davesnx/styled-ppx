open Types
open Support

module Property_anchor_name =
  [%spec_module
  "'none' | [ <dashed-ident> ]#", (module Css_types.AnchorName)]

let property_anchor_name : property_anchor_name Rule.rule =
  Property_anchor_name.rule

let entries : (kind * packed_rule) list =
  [ Property "anchor-name", pack_module (module Property_anchor_name) ]
