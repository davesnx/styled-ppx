open Types
open Support

module Property__webkit_appearance =
  [%spec_module
  "'none' | 'button' | 'button-bevel' | 'caps-lock-indicator' | 'caret' | \
   'checkbox' | 'default-button' | 'listbox' | 'listitem' | \
   'media-fullscreen-button' | 'media-mute-button' | 'media-play-button' | \
   'media-seek-back-button' | 'media-seek-forward-button' | 'media-slider' | \
   'media-sliderthumb' | 'menulist' | 'menulist-button' | 'menulist-text' | \
   'menulist-textfield' | 'push-button' | 'radio' | 'scrollbarbutton-down' | \
   'scrollbarbutton-left' | 'scrollbarbutton-right' | 'scrollbarbutton-up' | \
   'scrollbargripper-horizontal' | 'scrollbargripper-vertical' | \
   'scrollbarthumb-horizontal' | 'scrollbarthumb-vertical' | \
   'scrollbartrack-horizontal' | 'scrollbartrack-vertical' | 'searchfield' | \
   'searchfield-cancel-button' | 'searchfield-decoration' | \
   'searchfield-results-button' | 'searchfield-results-decoration' | \
   'slider-horizontal' | 'slider-vertical' | 'sliderthumb-horizontal' | \
   'sliderthumb-vertical' | 'square-button' | 'textarea' | 'textfield'",
  (module Css_types.WebkitAppearance)]

let property__webkit_appearance : property__webkit_appearance Rule.rule =
  Property__webkit_appearance.rule

module Property__webkit_background_clip =
  [%spec_module
  "[ <box> | 'border' | 'padding' | 'content' | 'text' ]#",
  (module Css_types.WebkitBackgroundClip)]

let property__webkit_background_clip :
  property__webkit_background_clip Rule.rule =
  Property__webkit_background_clip.rule

module Property__webkit_border_before =
  [%spec_module
  "<'border-width'> || <'border-style'> || <'color'>",
  (module Css_types.WebkitBorderBefore)]

let property__webkit_border_before : property__webkit_border_before Rule.rule =
  Property__webkit_border_before.rule

module Property__webkit_border_before_color =
  [%spec_module
  "<'color'>", (module Css_types.WebkitBorderBeforeColor)]

let property__webkit_border_before_color :
  property__webkit_border_before_color Rule.rule =
  Property__webkit_border_before_color.rule

module Property__webkit_border_before_style =
  [%spec_module
  "<'border-style'>", (module Css_types.WebkitBorderBeforeStyle)]

let property__webkit_border_before_style :
  property__webkit_border_before_style Rule.rule =
  Property__webkit_border_before_style.rule

module Property__webkit_border_before_width =
  [%spec_module
  "<'border-width'>", (module Css_types.WebkitBorderBeforeWidth)]

let property__webkit_border_before_width :
  property__webkit_border_before_width Rule.rule =
  Property__webkit_border_before_width.rule

module Property__webkit_box_reflect =
  [%spec_module
  "[ 'above' | 'below' | 'right' | 'left' ]? [ <extended-length> ]? [ <image> \
   ]?",
  (module Css_types.WebkitBoxReflect)]

let property__webkit_box_reflect : property__webkit_box_reflect Rule.rule =
  Property__webkit_box_reflect.rule

module Property__webkit_column_break_after =
  [%spec_module
  "'always' | 'auto' | 'avoid'", (module Css_types.WebkitColumnBreakAfter)]

let property__webkit_column_break_after :
  property__webkit_column_break_after Rule.rule =
  Property__webkit_column_break_after.rule

module Property__webkit_column_break_before =
  [%spec_module
  "'always' | 'auto' | 'avoid'", (module Css_types.WebkitColumnBreakBefore)]

let property__webkit_column_break_before :
  property__webkit_column_break_before Rule.rule =
  Property__webkit_column_break_before.rule

module Property__webkit_column_break_inside =
  [%spec_module
  "'always' | 'auto' | 'avoid'", (module Css_types.WebkitColumnBreakInside)]

let property__webkit_column_break_inside :
  property__webkit_column_break_inside Rule.rule =
  Property__webkit_column_break_inside.rule

module Property__webkit_font_smoothing =
  [%spec_module
  "'auto' | 'none' | 'antialiased' | 'subpixel-antialiased'",
  (module Css_types.WebkitFontSmoothing)]

let property__webkit_font_smoothing : property__webkit_font_smoothing Rule.rule
    =
  Property__webkit_font_smoothing.rule

module Property__webkit_line_clamp =
  [%spec_module
  "'none' | <integer>", (module Css_types.WebkitLineClamp)]

let property__webkit_line_clamp : property__webkit_line_clamp Rule.rule =
  Property__webkit_line_clamp.rule

module Property__webkit_mask =
  [%spec_module
  "[ <mask-reference> || <position> [ '/' <bg-size> ]? || <repeat-style> || [ \
   <box> | 'border' | 'padding' | 'content' | 'text' ] || [ <box> | 'border' | \
   'padding' | 'content' ] ]#",
  (module Css_types.WebkitMask)]

let property__webkit_mask : property__webkit_mask Rule.rule =
  Property__webkit_mask.rule

module Property__webkit_mask_attachment =
  [%spec_module
  "[ <attachment> ]#", (module Css_types.WebkitMaskAttachment)]

let property__webkit_mask_attachment :
  property__webkit_mask_attachment Rule.rule =
  Property__webkit_mask_attachment.rule

module Property__webkit_mask_box_image =
  [%spec_module
  "[ <url> | <gradient> | 'none' ] [ [ <extended-length> | \
   <extended-percentage> ]{4} [ <webkit-mask-box-repeat> ]{2} ]?",
  (module Css_types.WebkitMaskBoxImage)]

let property__webkit_mask_box_image : property__webkit_mask_box_image Rule.rule
    =
  Property__webkit_mask_box_image.rule

module Property__webkit_mask_clip =
  [%spec_module
  "[ <box> | 'border' | 'padding' | 'content' | 'text' ]#",
  (module Css_types.WebkitMaskClip)]

let property__webkit_mask_clip : property__webkit_mask_clip Rule.rule =
  Property__webkit_mask_clip.rule

module Property__webkit_mask_composite =
  [%spec_module
  "[ <composite-style> ]#", (module Css_types.WebkitMaskComposite)]

let property__webkit_mask_composite : property__webkit_mask_composite Rule.rule
    =
  Property__webkit_mask_composite.rule

module Property__webkit_mask_image =
  [%spec_module
  "[ <mask-reference> ]#", (module Css_types.WebkitMaskImage)]

let property__webkit_mask_image : property__webkit_mask_image Rule.rule =
  Property__webkit_mask_image.rule

module Property__webkit_mask_origin =
  [%spec_module
  "[ <box> | 'border' | 'padding' | 'content' ]#",
  (module Css_types.WebkitMaskOrigin)]

let property__webkit_mask_origin : property__webkit_mask_origin Rule.rule =
  Property__webkit_mask_origin.rule

module Property__webkit_mask_position =
  [%spec_module
  "[ <position> ]#", (module Css_types.WebkitMaskPosition)]

let property__webkit_mask_position : property__webkit_mask_position Rule.rule =
  Property__webkit_mask_position.rule

module Property__webkit_mask_position_x =
  [%spec_module
  "[ <extended-length> | <extended-percentage> | 'left' | 'center' | 'right' ]#",
  (module Css_types.WebkitMaskPositionX)]

let property__webkit_mask_position_x :
  property__webkit_mask_position_x Rule.rule =
  Property__webkit_mask_position_x.rule

module Property__webkit_mask_position_y =
  [%spec_module
  "[ <extended-length> | <extended-percentage> | 'top' | 'center' | 'bottom' ]#",
  (module Css_types.WebkitMaskPositionY)]

let property__webkit_mask_position_y :
  property__webkit_mask_position_y Rule.rule =
  Property__webkit_mask_position_y.rule

module Property__webkit_mask_repeat =
  [%spec_module
  "[ <repeat-style> ]#", (module Css_types.WebkitMaskRepeat)]

let property__webkit_mask_repeat : property__webkit_mask_repeat Rule.rule =
  Property__webkit_mask_repeat.rule

module Property__webkit_mask_repeat_x =
  [%spec_module
  "'repeat' | 'no-repeat' | 'space' | 'round'",
  (module Css_types.WebkitMaskRepeatX)]

let property__webkit_mask_repeat_x : property__webkit_mask_repeat_x Rule.rule =
  Property__webkit_mask_repeat_x.rule

module Property__webkit_mask_repeat_y =
  [%spec_module
  "'repeat' | 'no-repeat' | 'space' | 'round'",
  (module Css_types.WebkitMaskRepeatY)]

let property__webkit_mask_repeat_y : property__webkit_mask_repeat_y Rule.rule =
  Property__webkit_mask_repeat_y.rule

module Property__webkit_mask_size =
  [%spec_module
  "[ <bg-size> ]#", (module Css_types.WebkitMaskSize)]

let property__webkit_mask_size : property__webkit_mask_size Rule.rule =
  Property__webkit_mask_size.rule

module Property__webkit_overflow_scrolling =
  [%spec_module
  "'auto' | 'touch'", (module Css_types.WebkitOverflowScrolling)]

let property__webkit_overflow_scrolling :
  property__webkit_overflow_scrolling Rule.rule =
  Property__webkit_overflow_scrolling.rule

module Property__webkit_print_color_adjust =
  [%spec_module
  "'economy' | 'exact'", (module Css_types.WebkitPrintColorAdjust)]

let property__webkit_print_color_adjust :
  property__webkit_print_color_adjust Rule.rule =
  Property__webkit_print_color_adjust.rule

module Property__webkit_tap_highlight_color =
  [%spec_module
  "<color>", (module Css_types.WebkitTapHighlightColor)]

let property__webkit_tap_highlight_color :
  property__webkit_tap_highlight_color Rule.rule =
  Property__webkit_tap_highlight_color.rule

module Property__webkit_text_fill_color =
  [%spec_module
  "<color>", (module Css_types.WebkitTextFillColor)]

let property__webkit_text_fill_color :
  property__webkit_text_fill_color Rule.rule =
  Property__webkit_text_fill_color.rule

module Property__webkit_text_security =
  [%spec_module
  "'none' | 'circle' | 'disc' | 'square'", (module Css_types.WebkitTextSecurity)]

let property__webkit_text_security : property__webkit_text_security Rule.rule =
  Property__webkit_text_security.rule

module Property__webkit_text_stroke =
  [%spec_module
  "<extended-length> || <color>", (module Css_types.WebkitTextStroke)]

let property__webkit_text_stroke : property__webkit_text_stroke Rule.rule =
  Property__webkit_text_stroke.rule

module Property__webkit_text_stroke_color =
  [%spec_module
  "<color>", (module Css_types.WebkitTextStrokeColor)]

let property__webkit_text_stroke_color :
  property__webkit_text_stroke_color Rule.rule =
  Property__webkit_text_stroke_color.rule

module Property__webkit_text_stroke_width =
  [%spec_module
  "<extended-length>", (module Css_types.WebkitTextStrokeWidth)]

let property__webkit_text_stroke_width :
  property__webkit_text_stroke_width Rule.rule =
  Property__webkit_text_stroke_width.rule

module Property__webkit_touch_callout =
  [%spec_module
  "'default' | 'none'", (module Css_types.WebkitTouchCallout)]

let property__webkit_touch_callout : property__webkit_touch_callout Rule.rule =
  Property__webkit_touch_callout.rule

module Property__webkit_user_drag =
  [%spec_module
  "'none' | 'element' | 'auto'", (module Css_types.WebkitUserDrag)]

let property__webkit_user_drag : property__webkit_user_drag Rule.rule =
  Property__webkit_user_drag.rule

module Property__webkit_user_modify =
  [%spec_module
  "'read-only' | 'read-write' | 'read-write-plaintext-only'",
  (module Css_types.WebkitUserModify)]

let property__webkit_user_modify : property__webkit_user_modify Rule.rule =
  Property__webkit_user_modify.rule

module Property__webkit_user_select =
  [%spec_module
  "'auto' | 'none' | 'text' | 'all'", (module Css_types.WebkitUserSelect)]

let property__webkit_user_select : property__webkit_user_select Rule.rule =
  Property__webkit_user_select.rule

module Property__webkit_box_orient =
  [%spec_module
  "'horizontal' | 'vertical' | 'inline-axis' | 'block-axis' | 'inherit'",
  (module Css_types.BoxOrient)]

let property__webkit_box_orient = Property__webkit_box_orient.rule

module Property__webkit_box_shadow =
  [%spec_module
  "'none' | <interpolation> | [ <shadow> ]#", (module Css_types.BoxShadows)]

let property__webkit_box_shadow = Property__webkit_box_shadow.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "-webkit-appearance",
      pack_module (module Property__webkit_appearance) );
    ( Property "-webkit-background-clip",
      pack_module (module Property__webkit_background_clip) );
    ( Property "-webkit-border-before",
      pack_module (module Property__webkit_border_before) );
    ( Property "-webkit-border-before-style",
      pack_module (module Property__webkit_border_before_style) );
    ( Property "-webkit-border-before-width",
      pack_module (module Property__webkit_border_before_width) );
    ( Property "-webkit-box-reflect",
      pack_module (module Property__webkit_box_reflect) );
    ( Property "-webkit-column-break-after",
      pack_module (module Property__webkit_column_break_after) );
    ( Property "-webkit-column-break-before",
      pack_module (module Property__webkit_column_break_before) );
    ( Property "-webkit-column-break-inside",
      pack_module (module Property__webkit_column_break_inside) );
    ( Property "-webkit-line-clamp",
      pack_module (module Property__webkit_line_clamp) );
    Property "-webkit-mask", pack_module (module Property__webkit_mask);
    ( Property "-webkit-mask-attachment",
      pack_module (module Property__webkit_mask_attachment) );
    ( Property "-webkit-mask-box-image",
      pack_module (module Property__webkit_mask_box_image) );
    ( Property "-webkit-mask-clip",
      pack_module (module Property__webkit_mask_clip) );
    ( Property "-webkit-mask-composite",
      pack_module (module Property__webkit_mask_composite) );
    ( Property "-webkit-mask-image",
      pack_module (module Property__webkit_mask_image) );
    ( Property "-webkit-mask-origin",
      pack_module (module Property__webkit_mask_origin) );
    ( Property "-webkit-mask-position",
      pack_module (module Property__webkit_mask_position) );
    ( Property "-webkit-mask-position-x",
      pack_module (module Property__webkit_mask_position_x) );
    ( Property "-webkit-mask-position-y",
      pack_module (module Property__webkit_mask_position_y) );
    ( Property "-webkit-mask-repeat",
      pack_module (module Property__webkit_mask_repeat) );
    ( Property "-webkit-mask-repeat-x",
      pack_module (module Property__webkit_mask_repeat_x) );
    ( Property "-webkit-mask-repeat-y",
      pack_module (module Property__webkit_mask_repeat_y) );
    ( Property "-webkit-mask-size",
      pack_module (module Property__webkit_mask_size) );
    ( Property "-webkit-overflow-scrolling",
      pack_module (module Property__webkit_overflow_scrolling) );
    ( Property "-webkit-text-security",
      pack_module (module Property__webkit_text_security) );
    ( Property "-webkit-text-stroke",
      pack_module (module Property__webkit_text_stroke) );
    ( Property "-webkit-text-stroke-width",
      pack_module (module Property__webkit_text_stroke_width) );
    ( Property "-webkit-touch-callout",
      pack_module (module Property__webkit_touch_callout) );
    ( Property "-webkit-user-drag",
      pack_module (module Property__webkit_user_drag) );
    ( Property "-webkit-user-modify",
      pack_module (module Property__webkit_user_modify) );
    ( Property "-webkit-user-select",
      pack_module (module Property__webkit_user_select) );
    ( Property "-webkit-box-orient",
      pack_module (module Property__webkit_box_orient) );
    ( Property "-webkit-box-shadow",
      pack_module (module Property__webkit_box_shadow) );
    ( Property "-webkit-font-smoothing",
      pack_module (module Property__webkit_font_smoothing) );
    ( Property "-webkit-border-before-color",
      pack_module (module Property__webkit_border_before_color) );
    ( Property "-webkit-print-color-adjust",
      pack_module (module Property__webkit_print_color_adjust) );
    ( Property "-webkit-tap-highlight-color",
      pack_module (module Property__webkit_tap_highlight_color) );
    ( Property "-webkit-text-fill-color",
      pack_module (module Property__webkit_text_fill_color) );
    ( Property "-webkit-text-stroke-color",
      pack_module (module Property__webkit_text_stroke_color) );
  ]
