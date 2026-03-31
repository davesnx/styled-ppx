open Types
open Support

module Property_margin =
  [%spec_module
  "[ <extended-length> | <extended-percentage> | 'auto' | <interpolation> \
   ]{1,4}",
  (module Css_types.Margin)]

let property_margin : property_margin Rule.rule = Property_margin.rule

module Property_margin_block =
  [%spec_module
  "[ <'margin-left'> ]{1,2}", (module Css_types.MarginBlock)]

let property_margin_block : property_margin_block Rule.rule =
  Property_margin_block.rule

module Property_margin_block_end =
  [%spec_module
  "<'margin-left'>", (module Css_types.Margin)]

let property_margin_block_end : property_margin_block_end Rule.rule =
  Property_margin_block_end.rule

module Property_margin_block_start =
  [%spec_module
  "<'margin-left'>", (module Css_types.Margin)]

let property_margin_block_start : property_margin_block_start Rule.rule =
  Property_margin_block_start.rule

module Property_margin_bottom =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'auto'",
  (module Css_types.Margin)]

let property_margin_bottom : property_margin_bottom Rule.rule =
  Property_margin_bottom.rule

module Property_margin_inline =
  [%spec_module
  "[ <'margin-left'> ]{1,2}", (module Css_types.MarginInline)]

let property_margin_inline : property_margin_inline Rule.rule =
  Property_margin_inline.rule

module Property_margin_inline_end =
  [%spec_module
  "<'margin-left'>", (module Css_types.Margin)]

let property_margin_inline_end : property_margin_inline_end Rule.rule =
  Property_margin_inline_end.rule

module Property_margin_inline_start =
  [%spec_module
  "<'margin-left'>", (module Css_types.Margin)]

let property_margin_inline_start : property_margin_inline_start Rule.rule =
  Property_margin_inline_start.rule

module Property_margin_left =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'auto'",
  (module Css_types.Margin)]

let property_margin_left : property_margin_left Rule.rule =
  Property_margin_left.rule

module Property_margin_right =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'auto'",
  (module Css_types.Margin)]

let property_margin_right : property_margin_right Rule.rule =
  Property_margin_right.rule

module Property_margin_top =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'auto'",
  (module Css_types.Margin)]

let property_margin_top : property_margin_top Rule.rule =
  Property_margin_top.rule

module Property_margin_trim =
  [%spec_module
  "'none' | 'in-flow' | 'all'", (module Css_types.MarginTrim)]

let property_margin_trim : property_margin_trim Rule.rule =
  Property_margin_trim.rule

let entries : (kind * packed_rule) list =
  [
    Property "margin", pack_module (module Property_margin);
    Property "margin-block", pack_module (module Property_margin_block);
    Property "margin-block-end", pack_module (module Property_margin_block_end);
    Property "margin-block-start", pack_module (module Property_margin_block_start);
    Property "margin-bottom", pack_module (module Property_margin_bottom);
    Property "margin-inline", pack_module (module Property_margin_inline);
    Property "margin-inline-end", pack_module (module Property_margin_inline_end);
    Property "margin-inline-start", pack_module (module Property_margin_inline_start);
    Property "margin-left", pack_module (module Property_margin_left);
    Property "margin-right", pack_module (module Property_margin_right);
    Property "margin-top", pack_module (module Property_margin_top);
    Property "margin-trim", pack_module (module Property_margin_trim);
  ]
