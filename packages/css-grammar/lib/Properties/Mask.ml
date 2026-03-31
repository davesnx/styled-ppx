open Types
open Support

module Property_mask =
  [%spec_module
  "[ <mask-layer> ]#", (module Css_types.Mask)]

let property_mask : property_mask Rule.rule = Property_mask.rule

module Property_mask_border =
  [%spec_module
  "<'mask-border-source'> || <'mask-border-slice'> [ '/' [ \
   <'mask-border-width'> ]? [ '/' <'mask-border-outset'> ]? ]? || \
   <'mask-border-repeat'> || <'mask-border-mode'>",
  (module Css_types.MaskBorder)]

let property_mask_border : property_mask_border Rule.rule =
  Property_mask_border.rule

module Property_mask_border_mode =
  [%spec_module
  "'luminance' | 'alpha'", (module Css_types.MaskBorderMode)]

let property_mask_border_mode : property_mask_border_mode Rule.rule =
  Property_mask_border_mode.rule

module Property_mask_border_outset =
  [%spec_module
  "[ <extended-length> | <number> ]{1,4}", (module Css_types.MaskBorderOutset)]

let property_mask_border_outset : property_mask_border_outset Rule.rule =
  Property_mask_border_outset.rule

module Property_mask_border_repeat =
  [%spec_module
  "[ 'stretch' | 'repeat' | 'round' | 'space' ]{1,2}",
  (module Css_types.MaskBorderRepeat)]

let property_mask_border_repeat : property_mask_border_repeat Rule.rule =
  Property_mask_border_repeat.rule

module Property_mask_border_slice =
  [%spec_module
  "[ <number-percentage> ]{1,4} [ 'fill' ]?", (module Css_types.MaskBorderSlice)]

let property_mask_border_slice : property_mask_border_slice Rule.rule =
  Property_mask_border_slice.rule

module Property_mask_border_source =
  [%spec_module
  "'none' | <image>", (module Css_types.MaskBorderSource)]

let property_mask_border_source : property_mask_border_source Rule.rule =
  Property_mask_border_source.rule

module Property_mask_border_width =
  [%spec_module
  "[ <extended-length> | <extended-percentage> | <number> | 'auto' ]{1,4}",
  (module Css_types.MaskBorderWidth)]

let property_mask_border_width : property_mask_border_width Rule.rule =
  Property_mask_border_width.rule

module Property_mask_clip =
  [%spec_module
  "[ <geometry-box> | 'no-clip' ]#", (module Css_types.MaskClip)]

let property_mask_clip : property_mask_clip Rule.rule = Property_mask_clip.rule

module Property_mask_composite =
  [%spec_module
  "[ <compositing-operator> ]#", (module Css_types.MaskComposite)]

let property_mask_composite : property_mask_composite Rule.rule =
  Property_mask_composite.rule

module Property_mask_image =
  [%spec_module
  "[ <mask-reference> ]#", (module Css_types.MaskImage)]

let property_mask_image : property_mask_image Rule.rule =
  Property_mask_image.rule

module Property_mask_mode =
  [%spec_module
  "[ <masking-mode> ]#", (module Css_types.MaskMode)]

let property_mask_mode : property_mask_mode Rule.rule = Property_mask_mode.rule

module Property_mask_origin =
  [%spec_module
  "[ <geometry-box> ]#", (module Css_types.MaskOrigin)]

let property_mask_origin : property_mask_origin Rule.rule =
  Property_mask_origin.rule

module Property_mask_position =
  [%spec_module
  "[ <position> ]#", (module Css_types.MaskPosition)]

let property_mask_position : property_mask_position Rule.rule =
  Property_mask_position.rule

module Property_mask_repeat =
  [%spec_module
  "[ <repeat-style> ]#", (module Css_types.MaskRepeat)]

let property_mask_repeat : property_mask_repeat Rule.rule =
  Property_mask_repeat.rule

module Property_mask_size =
  [%spec_module
  "[ <bg-size> ]#", (module Css_types.MaskSize)]

let property_mask_size : property_mask_size Rule.rule = Property_mask_size.rule

module Property_mask_type =
  [%spec_module
  "'luminance' | 'alpha'", (module Css_types.MaskType)]

let property_mask_type : property_mask_type Rule.rule = Property_mask_type.rule

let entries : (kind * packed_rule) list =
  [
    Property "mask-border-mode", pack_module (module Property_mask_border_mode);
    Property "mask-type", pack_module (module Property_mask_type);
    Property "mask", pack_module (module Property_mask);
    Property "mask-border", pack_module (module Property_mask_border);
    Property "mask-border-outset", pack_module (module Property_mask_border_outset);
    Property "mask-border-repeat", pack_module (module Property_mask_border_repeat);
    Property "mask-border-slice", pack_module (module Property_mask_border_slice);
    Property "mask-border-source", pack_module (module Property_mask_border_source);
    Property "mask-border-width", pack_module (module Property_mask_border_width);
    Property "mask-clip", pack_module (module Property_mask_clip);
    Property "mask-composite", pack_module (module Property_mask_composite);
    Property "mask-image", pack_module (module Property_mask_image);
    Property "mask-mode", pack_module (module Property_mask_mode);
    Property "mask-origin", pack_module (module Property_mask_origin);
    Property "mask-position", pack_module (module Property_mask_position);
    Property "mask-repeat", pack_module (module Property_mask_repeat);
    Property "mask-size", pack_module (module Property_mask_size);
  ]
