open Types
open Support

module Property_block_overflow =
  [%spec_module
  "'clip' | 'ellipsis' | <string>", (module Css_types.BlockOverflow)]

let property_block_overflow : property_block_overflow Rule.rule =
  Property_block_overflow.rule

let entries : (kind * packed_rule) list =
  [ Property "block-overflow", pack_module (module Property_block_overflow) ]
