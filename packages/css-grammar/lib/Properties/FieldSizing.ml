open Types
open Support

module Property_field_sizing =
  [%spec_module
  "'content' | 'fixed'", (module Css_types.FieldSizing)]

let property_field_sizing : property_field_sizing Rule.rule =
  Property_field_sizing.rule

let entries : (kind * packed_rule) list =
  [
    Property "field-sizing", pack_module (module Property_field_sizing);
  ]
