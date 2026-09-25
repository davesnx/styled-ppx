open Types
open Support

module Property_inline_size =
  [%spec_module
  "<'width'>", (module Css_types.Length)]

let property_inline_size : property_inline_size Rule.rule =
  Property_inline_size.rule

(* CSS Inline Layout L3 (unrelated to CSS Sizing's inline-size above, despite
   the name): https://drafts.csswg.org/css-inline-3/#propdef-inline-sizing *)
module Property_inline_sizing =
  [%spec_module
  "'normal' | 'stretch'", (module Css_types.InlineSizing)]

let property_inline_sizing : property_inline_sizing Rule.rule =
  Property_inline_sizing.rule

let entries : (kind * packed_rule) list =
  [
    Property "inline-size", pack_module (module Property_inline_size);
    Property "inline-sizing", pack_module (module Property_inline_sizing);
  ]
