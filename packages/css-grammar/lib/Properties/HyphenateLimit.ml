open Types
open Support

module Property_hyphenate_limit_last =
  [%spec_module
  "'none' | 'always' | 'column' | 'page' | 'spread'",
  (module Css_types.HyphenateLimitLast)]

let property_hyphenate_limit_last : property_hyphenate_limit_last Rule.rule =
  Property_hyphenate_limit_last.rule

module Property_hyphenate_limit_lines =
  [%spec_module
  "'no-limit' | <integer>", (module Css_types.HyphenateLimitLines)]

let property_hyphenate_limit_lines : property_hyphenate_limit_lines Rule.rule =
  Property_hyphenate_limit_lines.rule

module Property__ms_hyphenate_limit_lines =
  [%spec_module
  "'no-limit' | <integer>", (module Css_types.HyphenateLimitLines)]

let property__ms_hyphenate_limit_lines = Property__ms_hyphenate_limit_lines.rule

module Property_hyphenate_limit_zone =
  [%spec_module
  "<extended-length> | <extended-percentage>",
  (module Css_types.HyphenateLimitZone)]

let property_hyphenate_limit_zone : property_hyphenate_limit_zone Rule.rule =
  Property_hyphenate_limit_zone.rule

module Property__ms_hyphenate_limit_zone =
  [%spec_module
  "<extended-length> | <extended-percentage>",
  (module Css_types.HyphenateLimitZone)]

let property__ms_hyphenate_limit_zone = Property__ms_hyphenate_limit_zone.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "-ms-hyphenate-limit-lines",
      pack_module (module Property__ms_hyphenate_limit_lines) );
    ( Property "-ms-hyphenate-limit-zone",
      pack_module (module Property__ms_hyphenate_limit_zone) );
    ( Property "hyphenate-limit-last",
      pack_module (module Property_hyphenate_limit_last) );
    ( Property "hyphenate-limit-lines",
      pack_module (module Property_hyphenate_limit_lines) );
    ( Property "hyphenate-limit-zone",
      pack_module (module Property_hyphenate_limit_zone) );
  ]
