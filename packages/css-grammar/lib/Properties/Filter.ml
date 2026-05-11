open Types
open Support

module Property_filter =
  [%spec_module
  "'none' | <interpolation> | <filter-function-list>", (module Css_types.Filter)]

let property_filter : property_filter Rule.rule = Property_filter.rule

module Property__ms_filter =
  [%spec_module
  "<string> | <interpolation>", (module Css_types.Filter)]

let property__ms_filter = Property__ms_filter.rule

let entries : (kind * packed_rule) list =
  [
    Property "-ms-filter", pack_module (module Property__ms_filter);
    Property "filter", pack_module (module Property_filter);
  ]
