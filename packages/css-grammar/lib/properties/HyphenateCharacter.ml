open Types
open Support

module Property_hyphenate_character =
  [%spec_module
  "'auto' | <string-token>", (module Css_types.HyphenateCharacter)]

let property_hyphenate_character : property_hyphenate_character Rule.rule =
  Property_hyphenate_character.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "hyphenate-character",
      pack_module (module Property_hyphenate_character) );
  ]
