open Types
open Support

module Property_white_space =
  [%spec_module
  "'normal' | 'pre' | 'nowrap' | 'pre-wrap' | 'pre-line' | 'break-spaces'",
  (module Css_types.WhiteSpace)]

let property_white_space : property_white_space Rule.rule =
  Property_white_space.rule

let entries : (kind * packed_rule) list =
  [
    Property "white-space", pack_module (module Property_white_space);
  ]
