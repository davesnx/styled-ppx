open Types
open Support

module Property_overflow =
  [%spec_module
  "[ 'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' ]{1,2} | \
   <-non-standard-overflow> | <interpolation>",
  (module Css_types.Overflow)]

let property_overflow : property_overflow Rule.rule = Property_overflow.rule

module Property__ms_overflow_style =
  [%spec_module
  "'auto' | 'none' | 'scrollbar' | '-ms-autohiding-scrollbar'",
  (module Css_types.Cascading)]

let property__ms_overflow_style = Property__ms_overflow_style.rule

module Property_overflow_clip_box =
  [%spec_module
  "[ 'padding-box' | 'content-box' ]{1,2}", (module Css_types.Cascading)]

let property_overflow_clip_box = Property_overflow_clip_box.rule

module Property_overflow_anchor =
  [%spec_module
  "'auto' | 'none'", (module Css_types.OverflowAnchor)]

let property_overflow_anchor : property_overflow_anchor Rule.rule =
  Property_overflow_anchor.rule

module Property_overflow_block =
  [%spec_module
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>",
  (module Css_types.OverflowBlock)]

let property_overflow_block : property_overflow_block Rule.rule =
  Property_overflow_block.rule

module Property_overflow_clip_margin =
  [%spec_module
  "<visual-box> || <extended-length>", (module Css_types.OverflowClipMargin)]

let property_overflow_clip_margin : property_overflow_clip_margin Rule.rule =
  Property_overflow_clip_margin.rule

module Property_overflow_inline =
  [%spec_module
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>",
  (module Css_types.OverflowInline)]

let property_overflow_inline : property_overflow_inline Rule.rule =
  Property_overflow_inline.rule

module Property_overflow_wrap =
  [%spec_module
  "'normal' | 'break-word' | 'anywhere'", (module Css_types.OverflowWrap)]

let property_overflow_wrap : property_overflow_wrap Rule.rule =
  Property_overflow_wrap.rule

module Property_overflow_x =
  [%spec_module
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>",
  (module Css_types.OverflowX)]

let property_overflow_x : property_overflow_x Rule.rule =
  Property_overflow_x.rule

module Property_overflow_y =
  [%spec_module
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>",
  (module Css_types.OverflowY)]

let property_overflow_y : property_overflow_y Rule.rule =
  Property_overflow_y.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "-ms-overflow-style",
      pack_module (module Property__ms_overflow_style) );
    Property "overflow", pack_module (module Property_overflow);
    ( Property "overflow-clip-box",
      pack_module (module Property_overflow_clip_box) );
    Property "overflow-wrap", pack_module (module Property_overflow_wrap);
    Property "overflow-anchor", pack_module (module Property_overflow_anchor);
    Property "overflow-block", pack_module (module Property_overflow_block);
    ( Property "overflow-clip-margin",
      pack_module (module Property_overflow_clip_margin) );
    Property "overflow-inline", pack_module (module Property_overflow_inline);
    Property "overflow-x", pack_module (module Property_overflow_x);
    Property "overflow-y", pack_module (module Property_overflow_y);
  ]
