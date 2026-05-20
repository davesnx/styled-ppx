open Types
open Support

module Property_hyphenate_limit_chars =
  [%spec_module
  "'auto' | <integer>", (module Css_types.HyphenateLimitChars)]

let property_hyphenate_limit_chars : property_hyphenate_limit_chars Rule.rule =
  Property_hyphenate_limit_chars.rule

module Property__ms_hyphenate_limit_chars =
  [%spec_module
  "'auto' | <integer>{1,3}", (module Css_types.HyphenateLimitChars)]

let property__ms_hyphenate_limit_chars = Property__ms_hyphenate_limit_chars.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "-ms-hyphenate-limit-chars",
      pack_module (module Property__ms_hyphenate_limit_chars) );
    ( Property "hyphenate-limit-chars",
      pack_module (module Property_hyphenate_limit_chars) );
  ]
