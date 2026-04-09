open Types
open Support

module Property_max_block_size =
  [%spec_module
  "<'max-width'>", (module Css_types.Length)]

let property_max_block_size : property_max_block_size Rule.rule =
  Property_max_block_size.rule

module Property_max_height =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> )",
  (module Css_types.MaxHeight)]

let property_max_height : property_max_height Rule.rule =
  Property_max_height.rule

module Property_max_inline_size =
  [%spec_module
  "<'max-width'>", (module Css_types.Length)]

let property_max_inline_size : property_max_inline_size Rule.rule =
  Property_max_inline_size.rule

module Property_max_lines =
  [%spec_module
  "'none' | <integer>", (module Css_types.MaxLines)]

let property_max_lines : property_max_lines Rule.rule = Property_max_lines.rule

module Property_max_width =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'none' | 'max-content' | \
   'min-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> ) | 'fill-available' | <-non-standard-width>",
  (module Css_types.MaxWidth)]

let property_max_width : property_max_width Rule.rule = Property_max_width.rule

let entries : (kind * packed_rule) list =
  [
    Property "max-block-size", pack_module (module Property_max_block_size);
    Property "max-height", pack_module (module Property_max_height);
    Property "max-inline-size", pack_module (module Property_max_inline_size);
    Property "max-lines", pack_module (module Property_max_lines);
    Property "max-width", pack_module (module Property_max_width);
  ]
