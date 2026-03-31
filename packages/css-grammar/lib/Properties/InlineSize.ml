open Types
open Support

module Property_inline_size =
  [%spec_module
  "<'width'>", (module Css_types.Length)]

let property_inline_size : property_inline_size Rule.rule =
  Property_inline_size.rule

let entries : (kind * packed_rule) list =
  [
    Property "inline-size", pack_module (module Property_inline_size);
  ]
