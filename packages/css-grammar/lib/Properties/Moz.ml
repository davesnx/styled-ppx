open Types
open Support

module Property__moz_appearance =
  [%spec_module
  "'none' | 'button' | 'button-arrow-down' | 'button-arrow-next' | \
   'button-arrow-previous' | 'button-arrow-up' | 'button-bevel' | \
   'button-focus' | 'caret' | 'checkbox' | 'checkbox-container' | \
   'checkbox-label' | 'checkmenuitem' | 'dualbutton' | 'groupbox' | 'listbox' \
   | 'listitem' | 'menuarrow' | 'menubar' | 'menucheckbox' | 'menuimage' | \
   'menuitem' | 'menuitemtext' | 'menulist' | 'menulist-button' | \
   'menulist-text' | 'menulist-textfield' | 'menupopup' | 'menuradio' | \
   'menuseparator' | 'meterbar' | 'meterchunk' | 'progressbar' | \
   'progressbar-vertical' | 'progresschunk' | 'progresschunk-vertical' | \
   'radio' | 'radio-container' | 'radio-label' | 'radiomenuitem' | 'range' | \
   'range-thumb' | 'resizer' | 'resizerpanel' | 'scale-horizontal' | \
   'scalethumbend' | 'scalethumb-horizontal' | 'scalethumbstart' | \
   'scalethumbtick' | 'scalethumb-vertical' | 'scale-vertical' | \
   'scrollbarbutton-down' | 'scrollbarbutton-left' | 'scrollbarbutton-right' | \
   'scrollbarbutton-up' | 'scrollbarthumb-horizontal' | \
   'scrollbarthumb-vertical' | 'scrollbartrack-horizontal' | \
   'scrollbartrack-vertical' | 'searchfield' | 'separator' | 'sheet' | \
   'spinner' | 'spinner-downbutton' | 'spinner-textfield' | 'spinner-upbutton' \
   | 'splitter' | 'statusbar' | 'statusbarpanel' | 'tab' | 'tabpanel' | \
   'tabpanels' | 'tab-scroll-arrow-back' | 'tab-scroll-arrow-forward' | \
   'textfield' | 'textfield-multiline' | 'toolbar' | 'toolbarbutton' | \
   'toolbarbutton-dropdown' | 'toolbargripper' | 'toolbox' | 'tooltip' | \
   'treeheader' | 'treeheadercell' | 'treeheadersortarrow' | 'treeitem' | \
   'treeline' | 'treetwisty' | 'treetwistyopen' | 'treeview' | \
   '-moz-mac-unified-toolbar' | '-moz-win-borderless-glass' | \
   '-moz-win-browsertabbar-toolbox' | '-moz-win-communicationstext' | \
   '-moz-win-communications-toolbox' | '-moz-win-exclude-glass' | \
   '-moz-win-glass' | '-moz-win-mediatext' | '-moz-win-media-toolbox' | \
   '-moz-window-button-box' | '-moz-window-button-box-maximized' | \
   '-moz-window-button-close' | '-moz-window-button-maximize' | \
   '-moz-window-button-minimize' | '-moz-window-button-restore' | \
   '-moz-window-frame-bottom' | '-moz-window-frame-left' | \
   '-moz-window-frame-right' | '-moz-window-titlebar' | \
   '-moz-window-titlebar-maximized'",
  (module Css_types.MozAppearance)]

let property__moz_appearance : property__moz_appearance Rule.rule =
  Property__moz_appearance.rule

module Property__moz_background_clip =
  [%spec_module
  "'padding' | 'border'", (module Css_types.MozBackgroundClip)]

let property__moz_background_clip : property__moz_background_clip Rule.rule =
  Property__moz_background_clip.rule

module Property__moz_binding =
  [%spec_module
  "<url> | 'none'", (module Css_types.MozBinding)]

let property__moz_binding : property__moz_binding Rule.rule =
  Property__moz_binding.rule

module Property__moz_border_bottom_colors =
  [%spec_module
  "[ <color> ]+ | 'none'", (module Css_types.MozBorderBottomColors)]

let property__moz_border_bottom_colors :
  property__moz_border_bottom_colors Rule.rule =
  Property__moz_border_bottom_colors.rule

module Property__moz_border_left_colors =
  [%spec_module
  "[ <color> ]+ | 'none'", (module Css_types.MozBorderLeftColors)]

let property__moz_border_left_colors :
  property__moz_border_left_colors Rule.rule =
  Property__moz_border_left_colors.rule

module Property__moz_border_radius_bottomleft =
  [%spec_module
  "<'border-bottom-left-radius'>", (module Css_types.MozBorderRadiusBottomleft)]

let property__moz_border_radius_bottomleft :
  property__moz_border_radius_bottomleft Rule.rule =
  Property__moz_border_radius_bottomleft.rule

module Property__moz_border_radius_bottomright =
  [%spec_module
  "<'border-bottom-right-radius'>",
  (module Css_types.MozBorderRadiusBottomright)]

let property__moz_border_radius_bottomright :
  property__moz_border_radius_bottomright Rule.rule =
  Property__moz_border_radius_bottomright.rule

module Property__moz_border_radius_topleft =
  [%spec_module
  "<'border-top-left-radius'>", (module Css_types.MozBorderRadiusTopleft)]

let property__moz_border_radius_topleft :
  property__moz_border_radius_topleft Rule.rule =
  Property__moz_border_radius_topleft.rule

module Property__moz_border_radius_topright =
  [%spec_module
  "<'border-bottom-right-radius'>", (module Css_types.MozBorderRadiusTopright)]

let property__moz_border_radius_topright :
  property__moz_border_radius_topright Rule.rule =
  Property__moz_border_radius_topright.rule

module Property__moz_border_right_colors =
  [%spec_module
  "[ <color> ]+ | 'none'", (module Css_types.MozBorderRightColors)]

let property__moz_border_right_colors :
  property__moz_border_right_colors Rule.rule =
  Property__moz_border_right_colors.rule

module Property__moz_border_top_colors =
  [%spec_module
  "[ <color> ]+ | 'none'", (module Css_types.MozBorderTopColors)]

let property__moz_border_top_colors : property__moz_border_top_colors Rule.rule
    =
  Property__moz_border_top_colors.rule

module Property__moz_context_properties =
  [%spec_module
  "'none' | [ 'fill' | 'fill-opacity' | 'stroke' | 'stroke-opacity' ]#",
  (module Css_types.MozContextProperties)]

let property__moz_context_properties :
  property__moz_context_properties Rule.rule =
  Property__moz_context_properties.rule

module Property__moz_control_character_visibility =
  [%spec_module
  "'visible' | 'hidden'", (module Css_types.Cascading)]

let property__moz_control_character_visibility :
  property__moz_control_character_visibility Rule.rule =
  Property__moz_control_character_visibility.rule

module Property__moz_float_edge =
  [%spec_module
  "'border-box' | 'content-box' | 'margin-box' | 'padding-box'",
  (module Css_types.MozFloatEdge)]

let property__moz_float_edge : property__moz_float_edge Rule.rule =
  Property__moz_float_edge.rule

module Property__moz_force_broken_image_icon =
  [%spec_module
  "<integer>", (module Css_types.MozForceBrokenImageIcon)]

let property__moz_force_broken_image_icon :
  property__moz_force_broken_image_icon Rule.rule =
  Property__moz_force_broken_image_icon.rule

module Property__moz_image_region =
  [%spec_module
  "<shape> | 'auto'", (module Css_types.MozImageRegion)]

let property__moz_image_region : property__moz_image_region Rule.rule =
  Property__moz_image_region.rule

module Property__moz_orient =
  [%spec_module
  "'inline' | 'block' | 'horizontal' | 'vertical'", (module Css_types.MozOrient)]

let property__moz_orient : property__moz_orient Rule.rule =
  Property__moz_orient.rule

module Property__moz_osx_font_smoothing =
  [%spec_module
  "'auto' | 'grayscale'", (module Css_types.MozOsxFontSmoothing)]

let property__moz_osx_font_smoothing :
  property__moz_osx_font_smoothing Rule.rule =
  Property__moz_osx_font_smoothing.rule

module Property__moz_outline_radius =
  [%spec_module
  "[ <outline-radius> ]{1,4} [ '/' [ <outline-radius> ]{1,4} ]?",
  (module Css_types.MozOutlineRadius)]

let property__moz_outline_radius : property__moz_outline_radius Rule.rule =
  Property__moz_outline_radius.rule

module Property__moz_outline_radius_bottomleft =
  [%spec_module
  "<outline-radius>", (module Css_types.MozOutlineRadiusBottomleft)]

let property__moz_outline_radius_bottomleft :
  property__moz_outline_radius_bottomleft Rule.rule =
  Property__moz_outline_radius_bottomleft.rule

module Property__moz_outline_radius_bottomright =
  [%spec_module
  "<outline-radius>", (module Css_types.LengthPercentage)]

let property__moz_outline_radius_bottomright :
  property__moz_outline_radius_bottomright Rule.rule =
  Property__moz_outline_radius_bottomright.rule

module Property__moz_outline_radius_topleft =
  [%spec_module
  "<outline-radius>", (module Css_types.MozOutlineRadiusTopleft)]

let property__moz_outline_radius_topleft :
  property__moz_outline_radius_topleft Rule.rule =
  Property__moz_outline_radius_topleft.rule

module Property__moz_outline_radius_topright =
  [%spec_module
  "<outline-radius>", (module Css_types.MozOutlineRadiusTopright)]

let property__moz_outline_radius_topright :
  property__moz_outline_radius_topright Rule.rule =
  Property__moz_outline_radius_topright.rule

module Property__moz_stack_sizing =
  [%spec_module
  "'ignore' | 'stretch-to-fit'", (module Css_types.MozStackSizing)]

let property__moz_stack_sizing : property__moz_stack_sizing Rule.rule =
  Property__moz_stack_sizing.rule

module Property__moz_text_blink =
  [%spec_module
  "'none' | 'blink'", (module Css_types.MozTextBlink)]

let property__moz_text_blink : property__moz_text_blink Rule.rule =
  Property__moz_text_blink.rule

module Property__moz_user_focus =
  [%spec_module
  "'ignore' | 'normal' | 'select-after' | 'select-before' | 'select-menu' | \
   'select-same' | 'select-all' | 'none'",
  (module Css_types.MozUserFocus)]

let property__moz_user_focus : property__moz_user_focus Rule.rule =
  Property__moz_user_focus.rule

module Property__moz_user_input =
  [%spec_module
  "'auto' | 'none' | 'enabled' | 'disabled'", (module Css_types.MozUserInput)]

let property__moz_user_input : property__moz_user_input Rule.rule =
  Property__moz_user_input.rule

module Property__moz_user_modify =
  [%spec_module
  "'read-only' | 'read-write' | 'write-only'", (module Css_types.MozUserModify)]

let property__moz_user_modify : property__moz_user_modify Rule.rule =
  Property__moz_user_modify.rule

module Property__moz_user_select =
  [%spec_module
  "'none' | 'text' | 'all' | '-moz-none'", (module Css_types.MozUserSelect)]

let property__moz_user_select : property__moz_user_select Rule.rule =
  Property__moz_user_select.rule

module Property__moz_window_dragging =
  [%spec_module
  "'drag' | 'no-drag'", (module Css_types.MozWindowDragging)]

let property__moz_window_dragging : property__moz_window_dragging Rule.rule =
  Property__moz_window_dragging.rule

module Property__moz_window_shadow =
  [%spec_module
  "'default' | 'menu' | 'tooltip' | 'sheet' | 'none'",
  (module Css_types.MozWindowShadow)]

let property__moz_window_shadow : property__moz_window_shadow Rule.rule =
  Property__moz_window_shadow.rule

let entries : (kind * packed_rule) list =
  [
    Property "-moz-appearance", pack_module (module Property__moz_appearance);
    Property "-moz-background-clip", pack_module (module Property__moz_background_clip);
    Property "-moz-binding", pack_module (module Property__moz_binding);
    ( Property "-moz-border-bottom-colors",
      pack_module (module Property__moz_border_bottom_colors) );
    ( Property "-moz-border-left-colors",
      pack_module (module Property__moz_border_left_colors) );
    ( Property "-moz-border-radius-bottomleft",
      pack_module (module Property__moz_border_radius_bottomleft) );
    ( Property "-moz-border-radius-bottomright",
      pack_module (module Property__moz_border_radius_bottomright) );
    ( Property "-moz-border-radius-topleft",
      pack_module (module Property__moz_border_radius_topleft) );
    ( Property "-moz-border-radius-topright",
      pack_module (module Property__moz_border_radius_topright) );
    ( Property "-moz-border-right-colors",
      pack_module (module Property__moz_border_right_colors) );
    Property "-moz-border-top-colors", pack_module (module Property__moz_border_top_colors);
    ( Property "-moz-context-properties",
      pack_module (module Property__moz_context_properties) );
    ( Property "-moz-control-character-visibility",
      pack_module (module Property__moz_control_character_visibility) );
    Property "-moz-float-edge", pack_module (module Property__moz_float_edge);
    ( Property "-moz-force-broken-image-icon",
      pack_module (module Property__moz_force_broken_image_icon) );
    Property "-moz-image-region", pack_module (module Property__moz_image_region);
    Property "-moz-orient", pack_module (module Property__moz_orient);
    Property "-moz-outline-radius", pack_module (module Property__moz_outline_radius);
    ( Property "-moz-outline-radius-bottomleft",
      pack_module (module Property__moz_outline_radius_bottomleft) );
    ( Property "-moz-outline-radius-bottomright",
      pack_module (module Property__moz_outline_radius_bottomright) );
    ( Property "-moz-outline-radius-topleft",
      pack_module (module Property__moz_outline_radius_topleft) );
    ( Property "-moz-outline-radius-topright",
      pack_module (module Property__moz_outline_radius_topright) );
    Property "-moz-stack-sizing", pack_module (module Property__moz_stack_sizing);
    Property "-moz-text-blink", pack_module (module Property__moz_text_blink);
    Property "-moz-user-focus", pack_module (module Property__moz_user_focus);
    Property "-moz-user-input", pack_module (module Property__moz_user_input);
    Property "-moz-user-modify", pack_module (module Property__moz_user_modify);
    Property "-moz-user-select", pack_module (module Property__moz_user_select);
    Property "-moz-window-dragging", pack_module (module Property__moz_window_dragging);
    Property "-moz-window-shadow", pack_module (module Property__moz_window_shadow);
    ( Property "-moz-osx-font-smoothing",
      pack_module (module Property__moz_osx_font_smoothing) );
  ]
