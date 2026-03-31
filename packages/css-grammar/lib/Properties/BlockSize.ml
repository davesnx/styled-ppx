open Types
open Support

module Property_block_size =
  [%spec_module
  "<'width'>", (module Css_types.Length)]

let property_block_size : property_block_size Rule.rule =
  Property_block_size.rule

let entries : (kind * packed_rule) list =
  [
    Property "block-size", pack_module (module Property_block_size);
  ]
