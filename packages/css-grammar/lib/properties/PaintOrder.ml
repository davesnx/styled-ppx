open Types
open Support

module Property_paint_order =
  [%spec_module
  "'normal' | 'fill' || 'stroke' || 'markers'", (module Css_types.PaintOrder)]

let property_paint_order : property_paint_order Rule.rule =
  Property_paint_order.rule

let entries : (kind * packed_rule) list =
  [ Property "paint-order", pack_module (module Property_paint_order) ]
