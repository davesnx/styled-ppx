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

let entries : (kind * packed_rule) list =
  [
    Property "min-block-size", pack_module (module Property_min_block_size);
    Property "min-height", pack_module (module Property_min_height);
    Property "min-inline-size", pack_module (module Property_min_inline_size);
    Property "min-width", pack_module (module Property_min_width);
  ]
