open Types
open Support

module Property_src =
  [%spec_module
  "[ <url> [ format( [ <string> ]# ) ]? | local( <family-name> ) ]#",
  (module Css_types.Src)]

let property_src : property_src Rule.rule = Property_src.rule

module Property_unicode_range =
  [%spec_module
  "[ <urange> ]#", (module Css_types.UnicodeRange)]

let property_unicode_range : property_unicode_range Rule.rule =
  Property_unicode_range.rule

module Property_marks =
  [%spec_module
  "'none' | 'crop' || 'cross'", (module Css_types.Marks)]

let property_marks : property_marks Rule.rule = Property_marks.rule

module Property_bleed =
  [%spec_module
  "'auto' | <extended-length>", (module Css_types.Bleed)]

let property_bleed : property_bleed Rule.rule = Property_bleed.rule

module Property_inherits =
  [%spec_module
  "'true' | 'false'", (module Css_types.Inherits)]

let property_inherits : property_inherits Rule.rule = Property_inherits.rule

module Property_initial_value =
  [%spec_module
  "<string>", (module Css_types.InitialValue)]

let property_initial_value : property_initial_value Rule.rule =
  Property_initial_value.rule

module Property_page =
  [%spec_module
  "'auto' | <custom-ident>", (module Css_types.Page)]

let property_page : property_page Rule.rule = Property_page.rule

(* Additional modern properties *)

let entries : (kind * packed_rule) list =
  [
    Property "inherits", pack_module (module Property_inherits);
    Property "initial-value", pack_module (module Property_initial_value);
    Property "page", pack_module (module Property_page);
    Property "src", pack_module (module Property_src);
    Property "unicode-range", pack_module (module Property_unicode_range);
    Property "bleed", pack_module (module Property_bleed);
    Property "marks", pack_module (module Property_marks);
  ]
