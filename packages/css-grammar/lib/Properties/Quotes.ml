open Types
open Support

module Property_quotes =
  [%spec_module
  "'none' | 'auto' | [ <string> <string> ]+", (module Css_types.Quotes)]

let property_quotes : property_quotes Rule.rule = Property_quotes.rule

let entries : (kind * packed_rule) list =
  [
    Property "quotes", pack_module (module Property_quotes);
  ]
