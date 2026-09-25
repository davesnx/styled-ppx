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

(* CSS Fill and Stroke Module L3: https://drafts.csswg.org/fill-stroke/#propdef-fill-break *)
module Property_fill_break =
  [%spec_module
  "'bounding-box' | 'slice' | 'clone'", (module Css_types.FillBreak)]

let property_fill_break : property_fill_break Rule.rule =
  Property_fill_break.rule

module Property_fill_color = [%spec_module "<color>", (module Css_types.Color)]

let property_fill_color : property_fill_color Rule.rule =
  Property_fill_color.rule

module Property_fill_image =
  [%spec_module
  "[ <paint> ]#", (module Css_types.Paint)]

let property_fill_image : property_fill_image Rule.rule =
  Property_fill_image.rule

module Property_fill_origin =
  [%spec_module
  "'match-parent' | 'fill-box' | 'stroke-box' | 'content-box' | 'padding-box' \
   | 'border-box'",
  (module Css_types.FillOrigin)]

let property_fill_origin : property_fill_origin Rule.rule =
  Property_fill_origin.rule

module Property_fill_position =
  [%spec_module
  "[ <bg-position> ]#", (module Css_types.BackgroundPosition)]

let property_fill_position : property_fill_position Rule.rule =
  Property_fill_position.rule

module Property_fill_repeat =
  [%spec_module
  "[ <repeat-style> ]#", (module Css_types.BackgroundRepeat)]

let property_fill_repeat : property_fill_repeat Rule.rule =
  Property_fill_repeat.rule

module Property_fill_size =
  [%spec_module
  "[ <bg-size> ]#", (module Css_types.BackgroundSize)]

let property_fill_size : property_fill_size Rule.rule = Property_fill_size.rule

let entries : (kind * packed_rule) list =
  [
    Property "fill", pack_module (module Property_fill);
    Property "fill-opacity", pack_module (module Property_fill_opacity);
    Property "fill-rule", pack_module (module Property_fill_rule);
    Property "fill-break", pack_module (module Property_fill_break);
    Property "fill-color", pack_module (module Property_fill_color);
    Property "fill-image", pack_module (module Property_fill_image);
    Property "fill-origin", pack_module (module Property_fill_origin);
    Property "fill-position", pack_module (module Property_fill_position);
    Property "fill-repeat", pack_module (module Property_fill_repeat);
    Property "fill-size", pack_module (module Property_fill_size);
  ]
