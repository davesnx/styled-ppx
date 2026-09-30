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

(* CSS Fill and Stroke Module L3: https://drafts.csswg.org/fill-stroke/#propdef-stroke-align *)
module Property_stroke_align =
  [%spec_module
  "'center' | 'inset' | 'outset'", (module Css_types.StrokeAlign)]

let property_stroke_align : property_stroke_align Rule.rule =
  Property_stroke_align.rule

module Property_stroke_break =
  [%spec_module
  "'bounding-box' | 'slice' | 'clone'", (module Css_types.FillBreak)]

let property_stroke_break : property_stroke_break Rule.rule =
  Property_stroke_break.rule

module Property_stroke_dash_corner =
  [%spec_module
  "'none' | <extended-length>", (module Css_types.StrokeDashCorner)]

let property_stroke_dash_corner : property_stroke_dash_corner Rule.rule =
  Property_stroke_dash_corner.rule

module Property_stroke_dash_justify =
  [%spec_module
  "'none' | [ 'stretch' | 'compress' ] || [ 'dashes' || 'gaps' ]",
  (module Css_types.StrokeDashJustify)]

let property_stroke_dash_justify : property_stroke_dash_justify Rule.rule =
  Property_stroke_dash_justify.rule

module Property_stroke_image =
  [%spec_module
  "[ <paint> ]#", (module Css_types.Paint)]

let property_stroke_image : property_stroke_image Rule.rule =
  Property_stroke_image.rule

module Property_stroke_origin =
  [%spec_module
  "'match-parent' | 'fill-box' | 'stroke-box' | 'content-box' | 'padding-box' \
   | 'border-box'",
  (module Css_types.FillOrigin)]

let property_stroke_origin : property_stroke_origin Rule.rule =
  Property_stroke_origin.rule

module Property_stroke_position =
  [%spec_module
  "[ <bg-position> ]#", (module Css_types.BackgroundPosition)]

let property_stroke_position : property_stroke_position Rule.rule =
  Property_stroke_position.rule

module Property_stroke_repeat =
  [%spec_module
  "[ <repeat-style> ]#", (module Css_types.BackgroundRepeat)]

let property_stroke_repeat : property_stroke_repeat Rule.rule =
  Property_stroke_repeat.rule

module Property_stroke_size =
  [%spec_module
  "[ <bg-size> ]#", (module Css_types.BackgroundSize)]

let property_stroke_size : property_stroke_size Rule.rule =
  Property_stroke_size.rule

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
    Property "stroke-align", pack_module (module Property_stroke_align);
    Property "stroke-break", pack_module (module Property_stroke_break);
    ( Property "stroke-dash-corner",
      pack_module (module Property_stroke_dash_corner) );
    ( Property "stroke-dash-justify",
      pack_module (module Property_stroke_dash_justify) );
    Property "stroke-image", pack_module (module Property_stroke_image);
    Property "stroke-origin", pack_module (module Property_stroke_origin);
    Property "stroke-position", pack_module (module Property_stroke_position);
    Property "stroke-repeat", pack_module (module Property_stroke_repeat);
    Property "stroke-size", pack_module (module Property_stroke_size);
  ]
