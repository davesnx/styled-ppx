open Types
open Support

module Property_min_block_size =
  [%spec_module
  "<'min-width'>", (module Css_types.Length)]

let property_min_block_size : property_min_block_size Rule.rule =
  Property_min_block_size.rule

module Property_min_height =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> )",
  (module Css_types.MinHeight)]

let property_min_height : property_min_height Rule.rule =
  Property_min_height.rule

module Property_min_inline_size =
  [%spec_module
  "<'min-width'>", (module Css_types.Length)]

let property_min_inline_size : property_min_inline_size Rule.rule =
  Property_min_inline_size.rule

module Property_min_width =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'auto' | 'max-content' | \
   'min-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> ) | 'fill-available' | <-non-standard-width>",
  (module Css_types.MinWidth)]

let property_min_width : property_min_width Rule.rule = Property_min_width.rule

(* CSS Box Sizing L4: https://drafts.csswg.org/css-sizing-4/#propdef-min-size *)
module Property_min_size =
  [%spec_module
  "<'min-width'> [ <'min-height'> ]?", (module Css_types.MinWidth)]

let property_min_size : property_min_size Rule.rule = Property_min_size.rule

(* CSS Box Sizing L4: https://drafts.csswg.org/css-sizing-4/#propdef-min-intrinsic-sizing *)
module Property_min_intrinsic_sizing =
  [%spec_module
  "'legacy' | 'zero-if-scroll' || 'zero-if-extrinsic'",
  (module Css_types.MinIntrinsicSizing)]

let property_min_intrinsic_sizing : property_min_intrinsic_sizing Rule.rule =
  Property_min_intrinsic_sizing.rule

let entries : (kind * packed_rule) list =
  [
    Property "min-block-size", pack_module (module Property_min_block_size);
    Property "min-height", pack_module (module Property_min_height);
    Property "min-inline-size", pack_module (module Property_min_inline_size);
    Property "min-width", pack_module (module Property_min_width);
    ( Shorthand ("min-size", [ "min-width"; "min-height" ]),
      pack_module (module Property_min_size) );
    ( Property "min-intrinsic-sizing",
      pack_module (module Property_min_intrinsic_sizing) );
  ]
