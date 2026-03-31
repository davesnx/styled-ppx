open Types
open Support

module Property_background =
  [%spec_module
  "[ <bg-layer> ',' ]* <final-bg-layer>", (module Css_types.Background)]

let property_background : property_background Rule.rule =
  Property_background.rule

module Property_background_attachment =
  [%spec_module
  "[ <attachment> ]#", (module Css_types.BackgroundAttachment)]

let property_background_attachment : property_background_attachment Rule.rule =
  Property_background_attachment.rule

module Property_background_blend_mode =
  [%spec_module
  "[ <blend-mode> ]#", (module Css_types.BackgroundBlendMode)]

let property_background_blend_mode : property_background_blend_mode Rule.rule =
  Property_background_blend_mode.rule

module Property_background_clip =
  [%spec_module
  "[ <box> | 'text' | 'border-area' ]#", (module Css_types.BackgroundClip)]

let property_background_clip : property_background_clip Rule.rule =
  Property_background_clip.rule

module Property_background_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_background_color : property_background_color Rule.rule =
  Property_background_color.rule

module Property_background_image =
  [%spec_module
  "[ <bg-image> ]#", (module Css_types.BackgroundImage)]

let property_background_image : property_background_image Rule.rule =
  Property_background_image.rule

module Property_background_origin =
  [%spec_module
  "[ <box> ]#", (module Css_types.BackgroundOrigin)]

let property_background_origin : property_background_origin Rule.rule =
  Property_background_origin.rule

module Property_background_position =
  [%spec_module
  "[ <bg-position> ]#", (module Css_types.BackgroundPosition)]

let property_background_position : property_background_position Rule.rule =
  Property_background_position.rule

module Property_background_position_x =
  [%spec_module
  "[ 'center' | [ 'left' | 'right' | 'x-start' | 'x-end' ]? [ \
   <extended-length> | <extended-percentage> ]? ]#",
  (module Css_types.BackgroundPositionX)]

let property_background_position_x : property_background_position_x Rule.rule =
  Property_background_position_x.rule

module Property_background_position_y =
  [%spec_module
  "[ 'center' | [ 'top' | 'bottom' | 'y-start' | 'y-end' ]? [ \
   <extended-length> | <extended-percentage> ]? ]#",
  (module Css_types.BackgroundPositionY)]

let property_background_position_y : property_background_position_y Rule.rule =
  Property_background_position_y.rule

module Property_background_repeat =
  [%spec_module
  "[ <repeat-style> ]#", (module Css_types.BackgroundRepeat)]

let property_background_repeat : property_background_repeat Rule.rule =
  Property_background_repeat.rule

module Property_background_size =
  [%spec_module
  "[ <bg-size> ]#", (module Css_types.BackgroundSize)]

let property_background_size : property_background_size Rule.rule =
  Property_background_size.rule

let entries : (kind * packed_rule) list =
  [
    Property "background-color", pack_module (module Property_background_color);
    Property "background", pack_module (module Property_background);
    Property "background-attachment", pack_module (module Property_background_attachment);
    Property "background-blend-mode", pack_module (module Property_background_blend_mode);
    Property "background-clip", pack_module (module Property_background_clip);
    Property "background-image", pack_module (module Property_background_image);
    Property "background-origin", pack_module (module Property_background_origin);
    Property "background-position", pack_module (module Property_background_position);
    Property "background-position-x", pack_module (module Property_background_position_x);
    Property "background-position-y", pack_module (module Property_background_position_y);
    Property "background-repeat", pack_module (module Property_background_repeat);
    Property "background-size", pack_module (module Property_background_size);
  ]
