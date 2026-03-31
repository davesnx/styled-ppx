open Types
open Support

module Property_content_visibility =
  [%spec_module
  "'visible' | 'hidden' | 'auto'", (module Css_types.ContentVisibility)]

let property_content_visibility : property_content_visibility Rule.rule =
  Property_content_visibility.rule

let entries : (kind * packed_rule) list =
  [
    Property "content-visibility", pack_module (module Property_content_visibility);
  ]
