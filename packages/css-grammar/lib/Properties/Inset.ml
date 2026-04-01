open Types
open Support

module Property_inset =
  [%spec_module
  "[ <'top'> ]{1,4}", (module Css_types.Inset)]

let property_inset : property_inset Rule.rule = Property_inset.rule

module Property_inset_block =
  [%spec_module
  "[ <'top'> ]{1,2}", (module Css_types.InsetBlock)]

let property_inset_block : property_inset_block Rule.rule =
  Property_inset_block.rule

module Property_inset_block_end =
  [%spec_module
  "<'top'>", (module Css_types.Length)]

let property_inset_block_end : property_inset_block_end Rule.rule =
  Property_inset_block_end.rule

module Property_inset_block_start =
  [%spec_module
  "<'top'>", (module Css_types.Length)]

let property_inset_block_start : property_inset_block_start Rule.rule =
  Property_inset_block_start.rule

module Property_inset_inline =
  [%spec_module
  "[ <'top'> ]{1,2}", (module Css_types.InsetInline)]

let property_inset_inline : property_inset_inline Rule.rule =
  Property_inset_inline.rule

module Property_inset_inline_end =
  [%spec_module
  "<'top'>", (module Css_types.Length)]

let property_inset_inline_end : property_inset_inline_end Rule.rule =
  Property_inset_inline_end.rule

module Property_inset_inline_start =
  [%spec_module
  "<'top'>", (module Css_types.Length)]

let property_inset_inline_start : property_inset_inline_start Rule.rule =
  Property_inset_inline_start.rule

module Property_inset_area =
  [%spec_module
  "'none' | [ 'top' | 'bottom' | 'left' | 'right' | 'center' | 'self-start' | \
   'self-end' | 'start' | 'end' ]{1,2}",
  (module Css_types.InsetArea)]

let property_inset_area : property_inset_area Rule.rule =
  Property_inset_area.rule

let entries : (kind * packed_rule) list =
  [
    Property "inset", pack_module (module Property_inset);
    Property "inset-area", pack_module (module Property_inset_area);
    Property "inset-block", pack_module (module Property_inset_block);
    Property "inset-block-end", pack_module (module Property_inset_block_end);
    ( Property "inset-block-start",
      pack_module (module Property_inset_block_start) );
    Property "inset-inline", pack_module (module Property_inset_inline);
    Property "inset-inline-end", pack_module (module Property_inset_inline_end);
    ( Property "inset-inline-start",
      pack_module (module Property_inset_inline_start) );
  ]
