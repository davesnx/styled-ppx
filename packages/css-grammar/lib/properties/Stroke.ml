open Types
open Support
module Property_stroke = [%spec_module "<paint>", (module Css_types.Paint)]

let property_stroke : property_stroke Rule.rule = Property_stroke.rule

module Property_stroke_dasharray =
  [%spec_module
  "'none' | [ [ <svg-length> ]+ ]#", (module Css_types.StrokeDashArray)]

let property_stroke_dasharray : property_stroke_dasharray Rule.rule =
  Property_stroke_dasharray.rule

module Property_stroke_dashoffset =
  [%spec_module
  "<svg-length>", (module Css_types.StrokeDashoffset)]

let property_stroke_dashoffset : property_stroke_dashoffset Rule.rule =
  Property_stroke_dashoffset.rule

module Property_stroke_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_stroke_color = Property_stroke_color.rule

module Property_stroke_linecap =
  [%spec_module
  "'butt' | 'round' | 'square'", (module Css_types.StrokeLinecap)]

let property_stroke_linecap : property_stroke_linecap Rule.rule =
  Property_stroke_linecap.rule

module Property_stroke_linejoin =
  [%spec_module
  "'miter' | 'round' | 'bevel'", (module Css_types.StrokeLinejoin)]

let property_stroke_linejoin : property_stroke_linejoin Rule.rule =
  Property_stroke_linejoin.rule

module Property_stroke_miterlimit =
  [%spec_module
  "<number-one-or-greater>", (module Css_types.StrokeMiterlimit)]

let property_stroke_miterlimit : property_stroke_miterlimit Rule.rule =
  Property_stroke_miterlimit.rule

module Property_stroke_opacity =
  [%spec_module
  "<alpha-value>", (module Css_types.StrokeOpacity)]

let property_stroke_opacity : property_stroke_opacity Rule.rule =
  Property_stroke_opacity.rule

module Property_stroke_width =
  [%spec_module
  "<svg-length>", (module Css_types.StrokeWidth)]

let property_stroke_width : property_stroke_width Rule.rule =
  Property_stroke_width.rule

let entries : (kind * packed_rule) list =
  [
    Property "stroke-linecap", pack_module (module Property_stroke_linecap);
    Property "stroke-linejoin", pack_module (module Property_stroke_linejoin);
    Property "stroke", pack_module (module Property_stroke);
    Property "stroke-color", pack_module (module Property_stroke_color);
    Property "stroke-dasharray", pack_module (module Property_stroke_dasharray);
    ( Property "stroke-dashoffset",
      pack_module (module Property_stroke_dashoffset) );
    ( Property "stroke-miterlimit",
      pack_module (module Property_stroke_miterlimit) );
    Property "stroke-opacity", pack_module (module Property_stroke_opacity);
    Property "stroke-width", pack_module (module Property_stroke_width);
  ]
