open Types
open Support

module Property_border =
  [%spec_module
  "'none' | [ <line-width> | <interpolation> ] | [ <line-width> | \
   <interpolation> ] [ <line-style> | <interpolation> ] | [ <line-width> | \
   <interpolation> ] [ <line-style> | <interpolation> ] [ <color> | \
   <interpolation> ]",
  (module Css_types.Border)]

let property_border : property_border Rule.rule = Property_border.rule

module Property_border_block =
  [%spec_module
  "<'border'>", (module Css_types.BorderBlock)]

let property_border_block : property_border_block Rule.rule =
  Property_border_block.rule

module Property_border_block_color =
  [%spec_module
  "[ <'border-top-color'> ]{1,2}", (module Css_types.BorderBlockColor)]

let property_border_block_color : property_border_block_color Rule.rule =
  Property_border_block_color.rule

module Property_border_block_end =
  [%spec_module
  "<'border'>", (module Css_types.BorderBlockEnd)]

let property_border_block_end : property_border_block_end Rule.rule =
  Property_border_block_end.rule

module Property_border_block_end_color =
  [%spec_module
  "<'border-top-color'>", (module Css_types.Color)]

let property_border_block_end_color : property_border_block_end_color Rule.rule
    =
  Property_border_block_end_color.rule

module Property_border_block_end_style =
  [%spec_module
  "<'border-top-style'>", (module Css_types.BorderBlockEndStyle)]

let property_border_block_end_style : property_border_block_end_style Rule.rule
    =
  Property_border_block_end_style.rule

module Property_border_block_end_width =
  [%spec_module
  "<'border-top-width'>", (module Css_types.LineWidth)]

let property_border_block_end_width : property_border_block_end_width Rule.rule
    =
  Property_border_block_end_width.rule

module Property_border_block_start =
  [%spec_module
  "<'border'>", (module Css_types.BorderBlockStart)]

let property_border_block_start : property_border_block_start Rule.rule =
  Property_border_block_start.rule

module Property_border_block_start_color =
  [%spec_module
  "<'border-top-color'>", (module Css_types.Color)]

let property_border_block_start_color :
  property_border_block_start_color Rule.rule =
  Property_border_block_start_color.rule

module Property_border_block_start_style =
  [%spec_module
  "<'border-top-style'>", (module Css_types.BorderBlockStartStyle)]

let property_border_block_start_style :
  property_border_block_start_style Rule.rule =
  Property_border_block_start_style.rule

module Property_border_block_start_width =
  [%spec_module
  "<'border-top-width'>", (module Css_types.LineWidth)]

let property_border_block_start_width :
  property_border_block_start_width Rule.rule =
  Property_border_block_start_width.rule

module Property_border_block_style =
  [%spec_module
  "<'border-top-style'>", (module Css_types.BorderBlockStyle)]

let property_border_block_style : property_border_block_style Rule.rule =
  Property_border_block_style.rule

module Property_border_block_width =
  [%spec_module
  "<'border-top-width'>", (module Css_types.LineWidth)]

let property_border_block_width : property_border_block_width Rule.rule =
  Property_border_block_width.rule

module Property_border_bottom =
  [%spec_module
  "<'border'>", (module Css_types.Border)]

let property_border_bottom : property_border_bottom Rule.rule =
  Property_border_bottom.rule

module Property_border_bottom_color =
  [%spec_module
  "<'border-top-color'>", (module Css_types.Color)]

let property_border_bottom_color : property_border_bottom_color Rule.rule =
  Property_border_bottom_color.rule

module Property_border_bottom_left_radius =
  [%spec_module
  "[ <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.LengthPercentage)]

let property_border_bottom_left_radius :
  property_border_bottom_left_radius Rule.rule =
  Property_border_bottom_left_radius.rule

module Property_border_bottom_right_radius =
  [%spec_module
  "[ <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.LengthPercentage)]

let property_border_bottom_right_radius :
  property_border_bottom_right_radius Rule.rule =
  Property_border_bottom_right_radius.rule

module Property_border_bottom_style =
  [%spec_module
  "<line-style>", (module Css_types.BorderStyle)]

let property_border_bottom_style : property_border_bottom_style Rule.rule =
  Property_border_bottom_style.rule

module Property_border_bottom_width =
  [%spec_module
  "<line-width>", (module Css_types.LineWidth)]

let property_border_bottom_width : property_border_bottom_width Rule.rule =
  Property_border_bottom_width.rule

module Property_border_collapse =
  [%spec_module
  "'collapse' | 'separate'", (module Css_types.BorderCollapse)]

let property_border_collapse : property_border_collapse Rule.rule =
  Property_border_collapse.rule

module Property_border_color =
  [%spec_module
  "[ <color> ]{1,4}", (module Css_types.Color)]

let property_border_color : property_border_color Rule.rule =
  Property_border_color.rule

module Property_border_end_end_radius =
  [%spec_module
  "[ <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.LengthPercentage)]

let property_border_end_end_radius : property_border_end_end_radius Rule.rule =
  Property_border_end_end_radius.rule

module Property_border_end_start_radius =
  [%spec_module
  "[ <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.LengthPercentage)]

let property_border_end_start_radius :
  property_border_end_start_radius Rule.rule =
  Property_border_end_start_radius.rule

module Property_border_image =
  [%spec_module
  "<'border-image-source'> || <'border-image-slice'> [ '/' \
   <'border-image-width'> | '/' [ <'border-image-width'> ]? '/' \
   <'border-image-outset'> ]? || <'border-image-repeat'>",
  (module Css_types.BorderImage)]

let property_border_image : property_border_image Rule.rule =
  Property_border_image.rule

module Property_border_image_outset =
  [%spec_module
  "[ <extended-length> | <number> ]{1,4}", (module Css_types.BorderImageOutset)]

let property_border_image_outset : property_border_image_outset Rule.rule =
  Property_border_image_outset.rule

module Property_border_image_repeat =
  [%spec_module
  "[ 'stretch' | 'repeat' | 'round' | 'space' ]{1,2}",
  (module Css_types.BorderImageRepeat)]

let property_border_image_repeat : property_border_image_repeat Rule.rule =
  Property_border_image_repeat.rule

module Property_border_image_slice =
  [%spec_module
  "[ <number-percentage> ]{1,4} && [ 'fill' ]?",
  (module Css_types.BorderImageSlice)]

let property_border_image_slice : property_border_image_slice Rule.rule =
  Property_border_image_slice.rule

module Property_border_image_source =
  [%spec_module
  "'none' | <image>", (module Css_types.BorderImageSource)]

let property_border_image_source : property_border_image_source Rule.rule =
  Property_border_image_source.rule

module Property_border_image_width =
  [%spec_module
  "[ <extended-length> | <extended-percentage> | <number> | 'auto' ]{1,4}",
  (module Css_types.BorderImageWidth)]

let property_border_image_width : property_border_image_width Rule.rule =
  Property_border_image_width.rule

module Property_border_inline =
  [%spec_module
  "<'border'>", (module Css_types.BorderInline)]

let property_border_inline : property_border_inline Rule.rule =
  Property_border_inline.rule

module Property_border_inline_color =
  [%spec_module
  "[ <'border-top-color'> ]{1,2}", (module Css_types.BorderInlineColor)]

let property_border_inline_color : property_border_inline_color Rule.rule =
  Property_border_inline_color.rule

module Property_border_inline_end =
  [%spec_module
  "<'border'>", (module Css_types.BorderInlineEnd)]

let property_border_inline_end : property_border_inline_end Rule.rule =
  Property_border_inline_end.rule

module Property_border_inline_end_color =
  [%spec_module
  "<'border-top-color'>", (module Css_types.Color)]

let property_border_inline_end_color :
  property_border_inline_end_color Rule.rule =
  Property_border_inline_end_color.rule

module Property_border_inline_end_style =
  [%spec_module
  "<'border-top-style'>", (module Css_types.BorderInlineEndStyle)]

let property_border_inline_end_style :
  property_border_inline_end_style Rule.rule =
  Property_border_inline_end_style.rule

module Property_border_inline_end_width =
  [%spec_module
  "<'border-top-width'>", (module Css_types.LineWidth)]

let property_border_inline_end_width :
  property_border_inline_end_width Rule.rule =
  Property_border_inline_end_width.rule

module Property_border_inline_start =
  [%spec_module
  "<'border'>", (module Css_types.BorderInlineStart)]

let property_border_inline_start : property_border_inline_start Rule.rule =
  Property_border_inline_start.rule

module Property_border_inline_start_color =
  [%spec_module
  "<'border-top-color'>", (module Css_types.Color)]

let property_border_inline_start_color :
  property_border_inline_start_color Rule.rule =
  Property_border_inline_start_color.rule

module Property_border_inline_start_style =
  [%spec_module
  "<'border-top-style'>", (module Css_types.BorderInlineStartStyle)]

let property_border_inline_start_style :
  property_border_inline_start_style Rule.rule =
  Property_border_inline_start_style.rule

module Property_border_inline_start_width =
  [%spec_module
  "<'border-top-width'>", (module Css_types.LineWidth)]

let property_border_inline_start_width :
  property_border_inline_start_width Rule.rule =
  Property_border_inline_start_width.rule

module Property_border_inline_style =
  [%spec_module
  "<'border-top-style'>", (module Css_types.BorderInlineStyle)]

let property_border_inline_style : property_border_inline_style Rule.rule =
  Property_border_inline_style.rule

module Property_border_inline_width =
  [%spec_module
  "<'border-top-width'>", (module Css_types.LineWidth)]

let property_border_inline_width : property_border_inline_width Rule.rule =
  Property_border_inline_width.rule

module Property_border_left =
  [%spec_module
  "<'border'>", (module Css_types.Border)]

let property_border_left : property_border_left Rule.rule =
  Property_border_left.rule

module Property_border_left_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_border_left_color : property_border_left_color Rule.rule =
  Property_border_left_color.rule

module Property_border_left_style =
  [%spec_module
  "<line-style>", (module Css_types.BorderStyle)]

let property_border_left_style : property_border_left_style Rule.rule =
  Property_border_left_style.rule

module Property_border_left_width =
  [%spec_module
  "<line-width>", (module Css_types.LineWidth)]

let property_border_left_width : property_border_left_width Rule.rule =
  Property_border_left_width.rule

(* border-radius supports 1-4 values with optional "/" for horizontal/vertical radii *)

module Property_border_radius =
  [%spec_module
  "[ <extended-length> | <extended-percentage> ]{1,4} [ '/' [ \
   <extended-length> | <extended-percentage> ]{1,4} ]?",
  (module Css_types.BorderRadius)]

let property_border_radius : property_border_radius Rule.rule =
  Property_border_radius.rule

module Property_border_right =
  [%spec_module
  "<'border'>", (module Css_types.Border)]

let property_border_right : property_border_right Rule.rule =
  Property_border_right.rule

module Property_border_right_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_border_right_color : property_border_right_color Rule.rule =
  Property_border_right_color.rule

module Property_border_right_style =
  [%spec_module
  "<line-style>", (module Css_types.BorderStyle)]

let property_border_right_style : property_border_right_style Rule.rule =
  Property_border_right_style.rule

module Property_border_right_width =
  [%spec_module
  "<line-width>", (module Css_types.LineWidth)]

let property_border_right_width : property_border_right_width Rule.rule =
  Property_border_right_width.rule

module Property_border_spacing =
  [%spec_module
  "<extended-length> [ <extended-length> ]?", (module Css_types.BorderSpacing)]

let property_border_spacing : property_border_spacing Rule.rule =
  Property_border_spacing.rule

module Property_border_start_end_radius =
  [%spec_module
  "[ <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.LengthPercentage)]

let property_border_start_end_radius :
  property_border_start_end_radius Rule.rule =
  Property_border_start_end_radius.rule

module Property_border_start_start_radius =
  [%spec_module
  "[ <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.LengthPercentage)]

let property_border_start_start_radius :
  property_border_start_start_radius Rule.rule =
  Property_border_start_start_radius.rule

(* bs-css doesn't support list of styles, the original spec is: `[ <line-style> ]{1,4}` *)

module Property_border_style =
  [%spec_module
  "<line-style>", (module Css_types.BorderStyle)]

let property_border_style : property_border_style Rule.rule =
  Property_border_style.rule

module Property_border_top =
  [%spec_module
  "<'border'>", (module Css_types.Border)]

let property_border_top : property_border_top Rule.rule =
  Property_border_top.rule

module Property_border_top_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_border_top_color : property_border_top_color Rule.rule =
  Property_border_top_color.rule

module Property_border_top_left_radius =
  [%spec_module
  "[ <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.LengthPercentage)]

let property_border_top_left_radius : property_border_top_left_radius Rule.rule
    =
  Property_border_top_left_radius.rule

module Property_border_top_right_radius =
  [%spec_module
  "[ <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.LengthPercentage)]

let property_border_top_right_radius :
  property_border_top_right_radius Rule.rule =
  Property_border_top_right_radius.rule

module Property_border_top_style =
  [%spec_module
  "<line-style>", (module Css_types.BorderStyle)]

let property_border_top_style : property_border_top_style Rule.rule =
  Property_border_top_style.rule

module Property_border_top_width =
  [%spec_module
  "<line-width>", (module Css_types.LineWidth)]

let property_border_top_width : property_border_top_width Rule.rule =
  Property_border_top_width.rule

module Property_border_width =
  [%spec_module
  "[ <line-width> ]{1,4}", (module Css_types.LineWidth)]

let property_border_width : property_border_width Rule.rule =
  Property_border_width.rule

let entries : (kind * packed_rule) list =
  [
    Property "border", pack_module (module Property_border);
    Property "border-block", pack_module (module Property_border_block);
    Property "border-block-end", pack_module (module Property_border_block_end);
    ( Property "border-block-end-style",
      pack_module (module Property_border_block_end_style) );
    ( Property "border-block-end-width",
      pack_module (module Property_border_block_end_width) );
    ( Property "border-block-start",
      pack_module (module Property_border_block_start) );
    ( Property "border-block-start-style",
      pack_module (module Property_border_block_start_style) );
    ( Property "border-block-start-width",
      pack_module (module Property_border_block_start_width) );
    ( Property "border-block-style",
      pack_module (module Property_border_block_style) );
    ( Property "border-block-width",
      pack_module (module Property_border_block_width) );
    Property "border-bottom", pack_module (module Property_border_bottom);
    ( Property "border-bottom-left-radius",
      pack_module (module Property_border_bottom_left_radius) );
    ( Property "border-bottom-right-radius",
      pack_module (module Property_border_bottom_right_radius) );
    ( Property "border-bottom-style",
      pack_module (module Property_border_bottom_style) );
    ( Property "border-bottom-width",
      pack_module (module Property_border_bottom_width) );
    ( Property "border-end-end-radius",
      pack_module (module Property_border_end_end_radius) );
    ( Property "border-end-start-radius",
      pack_module (module Property_border_end_start_radius) );
    Property "border-inline", pack_module (module Property_border_inline);
    ( Property "border-inline-end",
      pack_module (module Property_border_inline_end) );
    ( Property "border-inline-end-style",
      pack_module (module Property_border_inline_end_style) );
    ( Property "border-inline-end-width",
      pack_module (module Property_border_inline_end_width) );
    ( Property "border-inline-start",
      pack_module (module Property_border_inline_start) );
    ( Property "border-inline-start-style",
      pack_module (module Property_border_inline_start_style) );
    ( Property "border-inline-start-width",
      pack_module (module Property_border_inline_start_width) );
    ( Property "border-inline-style",
      pack_module (module Property_border_inline_style) );
    ( Property "border-inline-width",
      pack_module (module Property_border_inline_width) );
    Property "border-left", pack_module (module Property_border_left);
    ( Property "border-left-style",
      pack_module (module Property_border_left_style) );
    ( Property "border-left-width",
      pack_module (module Property_border_left_width) );
    Property "border-radius", pack_module (module Property_border_radius);
    Property "border-right", pack_module (module Property_border_right);
    ( Property "border-right-style",
      pack_module (module Property_border_right_style) );
    ( Property "border-right-width",
      pack_module (module Property_border_right_width) );
    Property "border-spacing", pack_module (module Property_border_spacing);
    ( Property "border-start-end-radius",
      pack_module (module Property_border_start_end_radius) );
    ( Property "border-start-start-radius",
      pack_module (module Property_border_start_start_radius) );
    Property "border-style", pack_module (module Property_border_style);
    Property "border-top", pack_module (module Property_border_top);
    ( Property "border-top-left-radius",
      pack_module (module Property_border_top_left_radius) );
    ( Property "border-top-right-radius",
      pack_module (module Property_border_top_right_radius) );
    Property "border-top-style", pack_module (module Property_border_top_style);
    Property "border-top-width", pack_module (module Property_border_top_width);
    Property "border-width", pack_module (module Property_border_width);
    Property "border-collapse", pack_module (module Property_border_collapse);
    ( Property "border-block-color",
      pack_module (module Property_border_block_color) );
    ( Property "border-block-end-color",
      pack_module (module Property_border_block_end_color) );
    ( Property "border-block-start-color",
      pack_module (module Property_border_block_start_color) );
    ( Property "border-bottom-color",
      pack_module (module Property_border_bottom_color) );
    Property "border-color", pack_module (module Property_border_color);
    ( Property "border-inline-color",
      pack_module (module Property_border_inline_color) );
    ( Property "border-inline-end-color",
      pack_module (module Property_border_inline_end_color) );
    ( Property "border-inline-start-color",
      pack_module (module Property_border_inline_start_color) );
    ( Property "border-left-color",
      pack_module (module Property_border_left_color) );
    ( Property "border-right-color",
      pack_module (module Property_border_right_color) );
    Property "border-top-color", pack_module (module Property_border_top_color);
    ( Property "border-image-repeat",
      pack_module (module Property_border_image_repeat) );
    Property "border-image", pack_module (module Property_border_image);
    ( Property "border-image-outset",
      pack_module (module Property_border_image_outset) );
    ( Property "border-image-slice",
      pack_module (module Property_border_image_slice) );
    ( Property "border-image-source",
      pack_module (module Property_border_image_source) );
    ( Property "border-image-width",
      pack_module (module Property_border_image_width) );
  ]
