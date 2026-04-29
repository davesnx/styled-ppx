open Types
open Support

module Property_word_wrap =
  [%spec_module
  "'normal' | 'break-word' | 'anywhere'", (module Css_types.WordWrap)]

let property_word_wrap : property_word_wrap Rule.rule = Property_word_wrap.rule

let entries : (kind * packed_rule) list =
  [ Property "word-wrap", pack_module (module Property_word_wrap) ]
