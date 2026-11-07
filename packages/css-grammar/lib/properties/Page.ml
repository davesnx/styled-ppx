open Types
open Support

module Property_page_break_after =
  [%spec_module
  "'auto' | 'always' | 'avoid' | 'left' | 'right' | 'recto' | 'verso'",
  (module Css_types.PageBreakAfter)]

let property_page_break_after : property_page_break_after Rule.rule =
  Property_page_break_after.rule

module Property_page_break_before =
  [%spec_module
  "'auto' | 'always' | 'avoid' | 'left' | 'right' | 'recto' | 'verso'",
  (module Css_types.PageBreakBefore)]

let property_page_break_before : property_page_break_before Rule.rule =
  Property_page_break_before.rule

module Property_page_break_inside =
  [%spec_module
  "'auto' | 'avoid'", (module Css_types.PageBreakInside)]

let property_page_break_inside : property_page_break_inside Rule.rule =
  Property_page_break_inside.rule

let entries : (kind * packed_rule) list =
  [
    Property "page-break-after", pack_module (module Property_page_break_after);
    ( Property "page-break-before",
      pack_module (module Property_page_break_before) );
    ( Property "page-break-inside",
      pack_module (module Property_page_break_inside) );
  ]
