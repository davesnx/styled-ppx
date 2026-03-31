open Types
open Support

module Property_anchor_scope =
  [%spec_module
  "'none' | 'all' | [ <dashed-ident> ]#", (module Css_types.AnchorScope)]

let property_anchor_scope : property_anchor_scope Rule.rule =
  Property_anchor_scope.rule

let entries : (kind * packed_rule) list =
  [
    Property "anchor-scope", pack_module (module Property_anchor_scope);
  ]
