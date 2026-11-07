open Types
open Support

module Property_word_spacing =
  [%spec_module
  "'normal' | <extended-length> | <extended-percentage>",
  (module Css_types.WordSpacing)]

let property_word_spacing : property_word_spacing Rule.rule =
  Property_word_spacing.rule

let entries : (kind * packed_rule) list =
  [ Property "word-spacing", pack_module (module Property_word_spacing) ]
