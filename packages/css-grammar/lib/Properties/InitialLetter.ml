open Types
open Support

module Property_initial_letter =
  [%spec_module
  "'normal' | <number> [ <integer> ]?", (module Css_types.InitialLetter)]

let property_initial_letter : property_initial_letter Rule.rule =
  Property_initial_letter.rule

let entries : (kind * packed_rule) list =
  [
    Property "initial-letter", pack_module (module Property_initial_letter);
  ]
