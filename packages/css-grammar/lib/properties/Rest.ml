open Types
open Support

module Property_rest =
  [%spec_module
  "<'rest-before'> [ <'rest-after'> ]?", (module Css_types.Rest)]

let property_rest : property_rest Rule.rule = Property_rest.rule

module Property_rest_after =
  [%spec_module
  "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
   'x-strong'",
  (module Css_types.RestAfter)]

let property_rest_after : property_rest_after Rule.rule =
  Property_rest_after.rule

module Property_rest_before =
  [%spec_module
  "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
   'x-strong'",
  (module Css_types.RestBefore)]

let property_rest_before : property_rest_before Rule.rule =
  Property_rest_before.rule

let entries : (kind * packed_rule) list =
  [
    Property "rest", pack_module (module Property_rest);
    Property "rest-after", pack_module (module Property_rest_after);
    Property "rest-before", pack_module (module Property_rest_before);
  ]
