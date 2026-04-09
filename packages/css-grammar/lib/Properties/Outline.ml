open Types
open Support

module Property_outline =
  [%spec_module
  "'none' | <'outline-width'> | [ <'outline-width'> <'outline-style'> ] | [ \
   <'outline-width'> <'outline-style'> [ <color> | <interpolation> ]]",
  (module Css_types.Outline)]

let property_outline : property_outline Rule.rule = Property_outline.rule

module Property_outline_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_outline_color : property_outline_color Rule.rule =
  Property_outline_color.rule

module Property_outline_offset =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_outline_offset : property_outline_offset Rule.rule =
  Property_outline_offset.rule

module Property_outline_style =
  [%spec_module
  "'auto' | <line-style> | <interpolation>", (module Css_types.OutlineStyle)]

let property_outline_style : property_outline_style Rule.rule =
  Property_outline_style.rule

module Property_outline_width =
  [%spec_module
  "<line-width> | <interpolation>", (module Css_types.LineWidth)]

let property_outline_width : property_outline_width Rule.rule =
  Property_outline_width.rule

let entries : (kind * packed_rule) list =
  [
    Property "outline-width", pack_module (module Property_outline_width);
    Property "outline-style", pack_module (module Property_outline_style);
    Property "outline", pack_module (module Property_outline);
    Property "outline-offset", pack_module (module Property_outline_offset);
    Property "outline-color", pack_module (module Property_outline_color);
  ]
