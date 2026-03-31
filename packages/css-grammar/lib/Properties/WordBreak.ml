open Types
open Support

module Property_word_break =
  [%spec_module
  "'normal' | 'break-all' | 'keep-all' | 'break-word'",
  (module Css_types.WordBreak)]

let property_word_break : property_word_break Rule.rule =
  Property_word_break.rule

let entries : (kind * packed_rule) list =
  [
    Property "word-break", pack_module (module Property_word_break);
  ]
