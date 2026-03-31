open Types
open Support

module Property_unicode_bidi =
  [%spec_module
  "'normal' | 'embed' | 'isolate' | 'bidi-override' | 'isolate-override' | \
   'plaintext' | '-moz-isolate' | '-moz-isolate-override' | '-moz-plaintext' | \
   '-webkit-isolate'",
  (module Css_types.UnicodeBidi)]

let property_unicode_bidi : property_unicode_bidi Rule.rule =
  Property_unicode_bidi.rule

let entries : (kind * packed_rule) list =
  [
    Property "unicode-bidi", pack_module (module Property_unicode_bidi);
  ]
