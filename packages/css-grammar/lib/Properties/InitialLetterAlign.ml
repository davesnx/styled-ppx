open Types
open Support

module Property_initial_letter_align =
  [%spec_module
  "'auto' | 'alphabetic' | 'hanging' | 'ideographic'",
  (module Css_types.InitialLetterAlign)]

let property_initial_letter_align : property_initial_letter_align Rule.rule =
  Property_initial_letter_align.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "initial-letter-align",
      pack_module (module Property_initial_letter_align) );
  ]
