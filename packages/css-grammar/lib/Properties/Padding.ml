open Types
open Support

module Property_padding =
  [%spec_module
  "[ <extended-length> | <extended-percentage> | <interpolation> ]{1,4}",
  (module Css_types.Padding)]

let property_padding : property_padding Rule.rule = Property_padding.rule

module Property_padding_block =
  [%spec_module
  "[ <'padding-left'> ]{1,2}", (module Css_types.PaddingBlock)]

let property_padding_block : property_padding_block Rule.rule =
  Property_padding_block.rule

module Property_padding_block_end =
  [%spec_module
  "<'padding-left'>", (module Css_types.Length)]

let property_padding_block_end : property_padding_block_end Rule.rule =
  Property_padding_block_end.rule

module Property_padding_block_start =
  [%spec_module
  "<'padding-left'>", (module Css_types.Length)]

let property_padding_block_start : property_padding_block_start Rule.rule =
  Property_padding_block_start.rule

module Property_padding_bottom =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.Length)]

let property_padding_bottom : property_padding_bottom Rule.rule =
  Property_padding_bottom.rule

module Property_padding_inline =
  [%spec_module
  "[ <'padding-left'> ]{1,2}", (module Css_types.PaddingInline)]

let property_padding_inline : property_padding_inline Rule.rule =
  Property_padding_inline.rule

module Property_padding_inline_end =
  [%spec_module
  "<'padding-left'>", (module Css_types.Length)]

let property_padding_inline_end : property_padding_inline_end Rule.rule =
  Property_padding_inline_end.rule

module Property_padding_inline_start =
  [%spec_module
  "<'padding-left'>", (module Css_types.Length)]

let property_padding_inline_start : property_padding_inline_start Rule.rule =
  Property_padding_inline_start.rule

module Property_padding_left =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.Length)]

let property_padding_left : property_padding_left Rule.rule =
  Property_padding_left.rule

module Property_padding_right =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.Length)]

let property_padding_right : property_padding_right Rule.rule =
  Property_padding_right.rule

module Property_padding_top =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.Length)]

let property_padding_top : property_padding_top Rule.rule =
  Property_padding_top.rule

let entries : (kind * packed_rule) list =
  [
    Property "padding", pack_module (module Property_padding);
    Property "padding-block", pack_module (module Property_padding_block);
    ( Property "padding-block-end",
      pack_module (module Property_padding_block_end) );
    ( Property "padding-block-start",
      pack_module (module Property_padding_block_start) );
    Property "padding-bottom", pack_module (module Property_padding_bottom);
    Property "padding-inline", pack_module (module Property_padding_inline);
    ( Property "padding-inline-end",
      pack_module (module Property_padding_inline_end) );
    ( Property "padding-inline-start",
      pack_module (module Property_padding_inline_start) );
    Property "padding-left", pack_module (module Property_padding_left);
    Property "padding-right", pack_module (module Property_padding_right);
    Property "padding-top", pack_module (module Property_padding_top);
  ]
