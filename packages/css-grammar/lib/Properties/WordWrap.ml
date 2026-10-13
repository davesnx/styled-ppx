open Types
open Support

module Property_word_wrap =
  [%spec_module
  "'normal' | 'break-word' | 'anywhere'", (module Css_types.WordWrap)]

let property_word_wrap : property_word_wrap Rule.rule = Property_word_wrap.rule

let entries : (kind * packed_rule) list =
  [
    (* CSS Text L3 - https://www.w3.org/TR/css-text-3/#overflow-wrap-property :
       "word-wrap" is a legacy alias for "overflow-wrap", mapped
       value-for-value. *)
    ( Alias ("word-wrap", "overflow-wrap"),
      pack_module (module Property_word_wrap) );
  ]
