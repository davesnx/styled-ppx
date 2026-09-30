open Types
open Support

module Property_float =
  [%spec_module
  "'left' | 'right' | 'none' | 'inline-start' | 'inline-end'",
  (module Css_types.Float)]

let property_float : property_float Rule.rule = Property_float.rule

(* CSS Page Floats: https://drafts.csswg.org/css-page-floats/#propdef-float-reference *)
module Property_float_reference =
  [%spec_module
  "'inline' | 'column' | 'region' | 'page'", (module Css_types.FloatReference)]

let property_float_reference : property_float_reference Rule.rule =
  Property_float_reference.rule

(* CSS Page Floats: https://drafts.csswg.org/css-page-floats/#propdef-float-defer *)
module Property_float_defer =
  [%spec_module
  "<integer> | 'last' | 'none'", (module Css_types.FloatDefer)]

let property_float_defer : property_float_defer Rule.rule =
  Property_float_defer.rule

(* CSS Page Floats: https://drafts.csswg.org/css-page-floats/#propdef-float-offset *)
module Property_float_offset =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.Gap)]

let property_float_offset : property_float_offset Rule.rule =
  Property_float_offset.rule

let entries : (kind * packed_rule) list =
  [
    Property "float", pack_module (module Property_float);
    Property "float-reference", pack_module (module Property_float_reference);
    Property "float-defer", pack_module (module Property_float_defer);
    Property "float-offset", pack_module (module Property_float_offset);
  ]
