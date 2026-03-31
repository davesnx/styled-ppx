open Types
open Support

module Property_fill = [%spec_module "<paint>", (module Css_types.Paint)]

let property_fill : property_fill Rule.rule = Property_fill.rule

module Property_fill_opacity =
  [%spec_module
  "<alpha-value>", (module Css_types.FillOpacity)]

let property_fill_opacity : property_fill_opacity Rule.rule =
  Property_fill_opacity.rule

module Property_fill_rule =
  [%spec_module
  "'nonzero' | 'evenodd'", (module Css_types.FillRule)]

let property_fill_rule : property_fill_rule Rule.rule = Property_fill_rule.rule

let entries : (kind * packed_rule) list =
  [
    Property "fill", pack_module (module Property_fill);
    Property "fill-opacity", pack_module (module Property_fill_opacity);
    Property "fill-rule", pack_module (module Property_fill_rule);
  ]
