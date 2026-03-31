open Types
open Support

module Property_letter_spacing =
  [%spec_module
  "'normal' | <extended-length> | <extended-percentage>",
  (module Css_types.LetterSpacing)]

let property_letter_spacing : property_letter_spacing Rule.rule =
  Property_letter_spacing.rule

let entries : (kind * packed_rule) list =
  [
    Property "letter-spacing", pack_module (module Property_letter_spacing);
  ]
