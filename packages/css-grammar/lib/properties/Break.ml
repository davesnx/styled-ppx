open Types
open Support

module Property_break_after =
  [%spec_module
  "'auto' | 'avoid' | 'always' | 'all' | 'avoid-page' | 'page' | 'left' | \
   'right' | 'recto' | 'verso' | 'avoid-column' | 'column' | 'avoid-region' | \
   'region'",
  (module Css_types.BreakAfter)]

let property_break_after : property_break_after Rule.rule =
  Property_break_after.rule

module Property_break_before =
  [%spec_module
  "'auto' | 'avoid' | 'always' | 'all' | 'avoid-page' | 'page' | 'left' | \
   'right' | 'recto' | 'verso' | 'avoid-column' | 'column' | 'avoid-region' | \
   'region'",
  (module Css_types.BreakBefore)]

let property_break_before : property_break_before Rule.rule =
  Property_break_before.rule

module Property_break_inside =
  [%spec_module
  "'auto' | 'avoid' | 'avoid-page' | 'avoid-column' | 'avoid-region'",
  (module Css_types.BreakInside)]

let property_break_inside : property_break_inside Rule.rule =
  Property_break_inside.rule

let entries : (kind * packed_rule) list =
  [
    Property "break-inside", pack_module (module Property_break_inside);
    Property "break-before", pack_module (module Property_break_before);
    Property "break-after", pack_module (module Property_break_after);
  ]
