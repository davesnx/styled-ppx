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

(* CSS Overflow L4 § 4 (draft, standards-track but unimplemented in any
   browser): https://drafts.csswg.org/css-overflow-4/#propdef-overflow-clip-margin-top
   overflow-clip-margin (unqualified) is now a Shorthand: this and the other
   7 per-side/-corner leaves below share the "Logical property group:
   overflow-clip-margin" the spec cites, and its own propdef row is
   explicitly "These properties and their shorthands" - the unqualified
   form resets the 4 physical sides, mirroring how `margin` (not
   margin-block/-inline) resets margin-top/-right/-bottom/-left elsewhere
   in this codebase; logical and physical sides stay independent
   registrations, same convention as margin-top vs margin-block-start. *)
module Property_overflow_clip_margin =
  [%spec_module
  "<visual-box> || <extended-length>", (module Css_types.OverflowClipMargin)]

let property_overflow_clip_margin : property_overflow_clip_margin Rule.rule =
  Property_overflow_clip_margin.rule

module Property_overflow_clip_margin_top =
  [%spec_module
  "<visual-box> || <extended-length>", (module Css_types.OverflowClipMargin)]

let property_overflow_clip_margin_top :
  property_overflow_clip_margin_top Rule.rule =
  Property_overflow_clip_margin_top.rule

module Property_overflow_clip_margin_right =
  [%spec_module
  "<visual-box> || <extended-length>", (module Css_types.OverflowClipMargin)]

let property_overflow_clip_margin_right :
  property_overflow_clip_margin_right Rule.rule =
  Property_overflow_clip_margin_right.rule

module Property_overflow_clip_margin_bottom =
  [%spec_module
  "<visual-box> || <extended-length>", (module Css_types.OverflowClipMargin)]

let property_overflow_clip_margin_bottom :
  property_overflow_clip_margin_bottom Rule.rule =
  Property_overflow_clip_margin_bottom.rule

module Property_overflow_clip_margin_left =
  [%spec_module
  "<visual-box> || <extended-length>", (module Css_types.OverflowClipMargin)]

let property_overflow_clip_margin_left :
  property_overflow_clip_margin_left Rule.rule =
  Property_overflow_clip_margin_left.rule

module Property_overflow_clip_margin_block_start =
  [%spec_module
  "<visual-box> || <extended-length>", (module Css_types.OverflowClipMargin)]

let property_overflow_clip_margin_block_start :
  property_overflow_clip_margin_block_start Rule.rule =
  Property_overflow_clip_margin_block_start.rule

module Property_overflow_clip_margin_block_end =
  [%spec_module
  "<visual-box> || <extended-length>", (module Css_types.OverflowClipMargin)]

let property_overflow_clip_margin_block_end :
  property_overflow_clip_margin_block_end Rule.rule =
  Property_overflow_clip_margin_block_end.rule

module Property_overflow_clip_margin_inline_start =
  [%spec_module
  "<visual-box> || <extended-length>", (module Css_types.OverflowClipMargin)]

let property_overflow_clip_margin_inline_start :
  property_overflow_clip_margin_inline_start Rule.rule =
  Property_overflow_clip_margin_inline_start.rule

module Property_overflow_clip_margin_inline_end =
  [%spec_module
  "<visual-box> || <extended-length>", (module Css_types.OverflowClipMargin)]

let property_overflow_clip_margin_inline_end :
  property_overflow_clip_margin_inline_end Rule.rule =
  Property_overflow_clip_margin_inline_end.rule

module Property_overflow_clip_margin_block =
  [%spec_module
  "<visual-box> || <extended-length>", (module Css_types.OverflowClipMargin)]

let property_overflow_clip_margin_block :
  property_overflow_clip_margin_block Rule.rule =
  Property_overflow_clip_margin_block.rule

module Property_overflow_clip_margin_inline =
  [%spec_module
  "<visual-box> || <extended-length>", (module Css_types.OverflowClipMargin)]

let property_overflow_clip_margin_inline :
  property_overflow_clip_margin_inline Rule.rule =
  Property_overflow_clip_margin_inline.rule

(* CSS Overflow L4 § 3 (draft; preview-only, Safari Technology Preview):
   https://drafts.csswg.org/css-overflow-4/#propdef-block-ellipsis *)
module Property_block_ellipsis =
  [%spec_module
  "'no-ellipsis' | 'auto' | <string>", (module Css_types.Cascading)]

let property_block_ellipsis : property_block_ellipsis Rule.rule =
  Property_block_ellipsis.rule

(* CSS Overflow L4 § 3 (draft; preview-only, Safari Technology Preview):
   https://drafts.csswg.org/css-overflow-4/#propdef-continue *)
module Property_continue =
  [%spec_module
  "'auto' | 'discard' | 'collapse'", (module Css_types.Cascading)]

let property_continue : property_continue Rule.rule = Property_continue.rule

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
    (* Overflow L3: https://www.w3.org/TR/css-overflow-3/#propdef-overflow *)
    ( Shorthand ("overflow", [ "overflow-x"; "overflow-y" ]),
      pack_module (module Property_overflow) );
    ( Property "overflow-clip-box",
      pack_module (module Property_overflow_clip_box) );
    Property "overflow-wrap", pack_module (module Property_overflow_wrap);
    Property "overflow-anchor", pack_module (module Property_overflow_anchor);
    Property "overflow-block", pack_module (module Property_overflow_block);
    ( Shorthand
        ( "overflow-clip-margin",
          [
            "overflow-clip-margin-top";
            "overflow-clip-margin-right";
            "overflow-clip-margin-bottom";
            "overflow-clip-margin-left";
          ] ),
      pack_module (module Property_overflow_clip_margin) );
    ( Property "overflow-clip-margin-top",
      pack_module (module Property_overflow_clip_margin_top) );
    ( Property "overflow-clip-margin-right",
      pack_module (module Property_overflow_clip_margin_right) );
    ( Property "overflow-clip-margin-bottom",
      pack_module (module Property_overflow_clip_margin_bottom) );
    ( Property "overflow-clip-margin-left",
      pack_module (module Property_overflow_clip_margin_left) );
    ( Property "overflow-clip-margin-block-start",
      pack_module (module Property_overflow_clip_margin_block_start) );
    ( Property "overflow-clip-margin-block-end",
      pack_module (module Property_overflow_clip_margin_block_end) );
    ( Property "overflow-clip-margin-inline-start",
      pack_module (module Property_overflow_clip_margin_inline_start) );
    ( Property "overflow-clip-margin-inline-end",
      pack_module (module Property_overflow_clip_margin_inline_end) );
    ( Shorthand
        ( "overflow-clip-margin-block",
          [
            "overflow-clip-margin-block-start"; "overflow-clip-margin-block-end";
          ] ),
      pack_module (module Property_overflow_clip_margin_block) );
    ( Shorthand
        ( "overflow-clip-margin-inline",
          [
            "overflow-clip-margin-inline-start";
            "overflow-clip-margin-inline-end";
          ] ),
      pack_module (module Property_overflow_clip_margin_inline) );
    Property "overflow-inline", pack_module (module Property_overflow_inline);
    Property "overflow-x", pack_module (module Property_overflow_x);
    Property "overflow-y", pack_module (module Property_overflow_y);
    Property "block-ellipsis", pack_module (module Property_block_ellipsis);
    Property "continue", pack_module (module Property_continue);
  ]
