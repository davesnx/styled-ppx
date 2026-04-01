open Types
open Support

module Property_backdrop_filter =
  [%spec_module
  "'none' | <interpolation> | <filter-function-list>", (module Css_types.Filter)]

let property_backdrop_filter : property_backdrop_filter Rule.rule =
  Property_backdrop_filter.rule

let entries : (kind * packed_rule) list =
  [ Property "backdrop-filter", pack_module (module Property_backdrop_filter) ]
